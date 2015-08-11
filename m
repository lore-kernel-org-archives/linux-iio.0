Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:34776 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755243AbbHKKwW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 11 Aug 2015 06:52:22 -0400
Received: by lbbtg9 with SMTP id tg9so3783463lbb.1
        for <linux-iio@vger.kernel.org>; Tue, 11 Aug 2015 03:52:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1439287000-31506-1-git-send-email-linus.walleij@linaro.org>
References: <1439287000-31506-1-git-send-email-linus.walleij@linaro.org>
Date: Tue, 11 Aug 2015 13:52:20 +0300
Message-ID: <CAEnQRZCen5ewAnnuiTSwQ5Yynpx0=_xnb0EUFohqb+v9LhZjzA@mail.gmail.com>
Subject: Re: [PATCH] iio: percolate error if event fd fails
From: Daniel Baluta <daniel.baluta@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Aug 11, 2015 at 12:56 PM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> This makes the error from iio_event_getfd() percolate up
> to userspace properly so we can know for sure there is no
> events on this device (-ENODEV returned). Before this patch
> we would bail out looking for the unsupported evens on the
> erroneous (negative) file descriptor.

Good catch. s/evens/events

>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Acked-by: Daniel Baluta <daniel.baluta@intel.com>

> ---
>  drivers/iio/industrialio-core.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 3524b0de8721..9492aa443a26 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1130,6 +1130,8 @@ static long iio_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>
>         if (cmd == IIO_GET_EVENT_FD_IOCTL) {
>                 fd = iio_event_getfd(indio_dev);
> +               if (fd < 0)
> +                       return fd;
>                 if (copy_to_user(ip, &fd, sizeof(fd)))
>                         return -EFAULT;
>                 return 0;
> --
> 2.4.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
