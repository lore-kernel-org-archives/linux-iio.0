Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f45.google.com ([209.85.215.45]:36649 "EHLO
	mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752348AbcCZDnk (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 25 Mar 2016 23:43:40 -0400
Received: by mail-lf0-f45.google.com with SMTP id e133so6887863lfe.3
        for <linux-iio@vger.kernel.org>; Fri, 25 Mar 2016 20:43:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1458272888-26146-2-git-send-email-mranostay@gmail.com>
References: <1458272888-26146-1-git-send-email-mranostay@gmail.com> <1458272888-26146-2-git-send-email-mranostay@gmail.com>
From: Matt Ranostay <mranostay@gmail.com>
Date: Fri, 25 Mar 2016 20:42:58 -0700
Message-ID: <CAKzfze9pQwB0F2P+76gtn26ULMo4UDSyA9e-g+YTP7J5eF9LeQ@mail.gmail.com>
Subject: Re: [PATCH] iio: health: max30100: correct FIFO check condition
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	David Binderman <dcb314@hotmail.com>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Matt Ranostay <mranostay@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This get lost in the inbox? :)
Same fix as for APDS9660 issue in the FIFO

On Thu, Mar 17, 2016 at 8:48 PM, Matt Ranostay <mranostay@gmail.com> wrote:
> Correct issue that the last entry in FIFO was being read twice due
> to an incorrect decrement of entry count variable before condition
> check.
>
> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
> ---
>  drivers/iio/health/max30100.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/health/max30100.c b/drivers/iio/health/max30100.c
> index 09db893..90ab8a2d 100644
> --- a/drivers/iio/health/max30100.c
> +++ b/drivers/iio/health/max30100.c
> @@ -238,12 +238,13 @@ static irqreturn_t max30100_interrupt_handler(int irq, void *private)
>
>         mutex_lock(&data->lock);
>
> -       while (cnt-- || (cnt = max30100_fifo_count(data) > 0)) {
> +       while (cnt || (cnt = max30100_fifo_count(data) > 0)) {
>                 ret = max30100_read_measurement(data);
>                 if (ret)
>                         break;
>
>                 iio_push_to_buffers(data->indio_dev, data->buffer);
> +               cnt--;
>         }
>
>         mutex_unlock(&data->lock);
> --
> 2.7.0
>
