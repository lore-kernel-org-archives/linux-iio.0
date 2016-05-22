Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:32880 "EHLO
	mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751132AbcEVG2l convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 22 May 2016 02:28:41 -0400
Received: by mail-oi0-f65.google.com with SMTP id m198so13597231oig.0
        for <linux-iio@vger.kernel.org>; Sat, 21 May 2016 23:28:41 -0700 (PDT)
Received: from [30.98.126.234] ([172.56.14.88])
        by smtp.gmail.com with ESMTPSA id a1sm8226726oee.8.2016.05.21.23.28.38
        for <linux-iio@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 21 May 2016 23:28:38 -0700 (PDT)
From: Matt Ranostay <mranostay@gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 3/3] iio: proximity: as3935: fix buffer stack trashing
Message-Id: <861A0A5C-29E2-432A-9E9C-0AD3844426AF@gmail.com>
Date: Sat, 21 May 2016 23:28:37 -0700
References: <1463886063-20004-1-git-send-email-mranostay@gmail.com> <1463886063-20004-4-git-send-email-mranostay@gmail.com>
In-Reply-To: <1463886063-20004-4-git-send-email-mranostay@gmail.com>
To: linux-iio@vger.kernel.org
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


> On May 21, 2016, at 20:01, Matt Ranostay <mranostay@gmail.com> wrote:
> 
> Buffer wasn't of a valid size to allow the timestamp, and correct padding.
> This patchset also moves the buffer off the stack, and onto the heap.
> 
> Cc: george.mccollister@gmail.com
> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
> ---
> drivers/iio/proximity/as3935.c | 6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
> index 6aed024..8730451 100644
> --- a/drivers/iio/proximity/as3935.c
> +++ b/drivers/iio/proximity/as3935.c
> @@ -64,6 +64,7 @@ struct as3935_state {
>    struct delayed_work work;
> 
>    u32 tune_cap;
> +    u8 buffer[16]; /* 8-bit data + 54-bit padding + 64-bit timestamp */

Just noticed that should be noted as 56-bit

>    u8 buf[2] ____cacheline_aligned;
> };
> 
> @@ -212,9 +213,10 @@ static irqreturn_t as3935_trigger_handler(int irq, void *private)
>    ret = as3935_read(st, AS3935_DATA, &val);
>    if (ret)
>        goto err_read;
> -    val &= AS3935_DATA_MASK;
> 
> -    iio_push_to_buffers_with_timestamp(indio_dev, &val, pf->timestamp);
> +    st->buffer[0] = val & AS3935_DATA_MASK;
> +    iio_push_to_buffers_with_timestamp(indio_dev, &st->buffer,
> +                       pf->timestamp);
> err_read:
>    iio_trigger_notify_done(indio_dev->trig);
> 
> -- 
> 2.7.4
> 
