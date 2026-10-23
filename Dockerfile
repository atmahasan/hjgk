# ۱. انتخاب ایمیج پایه رسمی زبان گو
FROM golang:1.26 AS builder

# ۲. تعیین پوشه کاری داخل کانتینر
WORKDIR /app

# ۳. کپی کردن فایل‌های پروژه به داخل کانتینر
COPY . .

# ۴. کامپایل کردن پروژه به صورت باینری
RUN go build -trimpath -o cottendns_server ./cmd/server

# ۵. ساخت ایمیج نهایی و سبک‌تر برای اجرا
FROM ubuntu:24.04
WORKDIR /app
COPY --from=builder /app/cottendns_server .

# ۶. باز کردن پورت 53 برای DNS Tunnel
EXPOSE 53/udp
EXPOSE 53/tcp

# ۷. دستور اجرای سرور در زمان روشن شدن کانتینر
ENTRYPOINT ["./cottendns_server"]
