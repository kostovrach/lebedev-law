import nodemailer from 'nodemailer';
import Mail from 'nodemailer/lib/mailer';
import { rateLimit } from '~~/server/utils/rateLimit';

export default defineEventHandler(async (event) => {
    const config = useRuntimeConfig().smtp;
    const ip = getRequestHeader(event, 'x-forwarded-for') || event.node.req.socket.remoteAddress;

    if (!rateLimit(ip as string, 5, 60_000)) {
        throw createError({
            statusCode: 429,
            statusMessage: 'Слишком много запросов. Попробуйте позже.',
        });
    }
    try {
        const data = await readBody<{
            name?: string;
            telephone: string;
            message?: string;
        }>(event);

        if (!data?.telephone) {
            throw createError({
                statusCode: 400,
                statusMessage: 'Не указан номер телефона',
            });
        }

        const transporter = nodemailer.createTransport({
            host: config.host,
            port: Number(config.port || 587),
            secure: true,
            auth: {
                user: config.user,
                pass: config.pass,
            },
        });

        const mailOptions: Mail.Options = {
            from: `${data.name?.length ? data.name : 'Анонимная заявка'}`,
            to: config.target,
            subject: 'Заявка на обратную связь с сайта',
            html: `
                <h1>Заявка на обратную связь</h1>
                <div>
                    <p><strong>Имя:</strong> ${data.name?.length ? data.name : 'Анонимная заявка'}</p>
                    <p><strong>Номер телефона:</strong> ${data.telephone}</p>
                    <p><strong>Описание заявки:</strong> ${data.message?.length ? data.message : 'Без дополнительной информации'}</p>
                </div>
            `,
        };

        const info = await transporter.sendMail(mailOptions).catch((err) => {
            console.error('MAIL ERROR:', err);
            throw createError({
                statusCode: 500,
                statusMessage: 'Не удалось отправить письмо',
            });
        });

        return {
            ok: true,
            status: 200,
            messageId: info.messageId,
            previewUrl: nodemailer.getTestMessageUrl(info),
        };
    } catch (err) {
        console.error('MAIL HANDLER ERROR:', err);

        throw err;
    }
});
