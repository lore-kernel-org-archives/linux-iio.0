Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55460 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752127Ab3FKTdc (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 11 Jun 2013 15:33:32 -0400
Message-ID: <51B77B8B.9010009@kernel.org>
Date: Tue, 11 Jun 2013 20:33:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/4] staging:iio:adis16130: Fix sample reading
References: <1370872815-14386-1-git-send-email-lars@metafoo.de> <1370872815-14386-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1370872815-14386-2-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/10/2013 03:00 PM, Lars-Peter Clausen wrote:
> The driver first does a proper read of the data register, but right after that
> it does a spi_read, which will overwrite the initial result.
> 
> It looks as if the extra spi_read was accidentally introduced in commit
> a5e7363ca ("staging:iio:gyro:adis16130 drop control of adc resolution."), quite
> likely due to a bad rebase.
> 
oops.  This is a rather old bug now so I'm not rushing this one out. It can
wait for the next merge cycle, at which point you might want to request it is
applied to the stable trees.
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git

> ---
>  drivers/staging/iio/gyro/adis16130_core.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/gyro/adis16130_core.c b/drivers/staging/iio/gyro/adis16130_core.c
> index 5288635..2537f59 100644
> --- a/drivers/staging/iio/gyro/adis16130_core.c
> +++ b/drivers/staging/iio/gyro/adis16130_core.c
> @@ -62,7 +62,6 @@ static int adis16130_spi_read(struct iio_dev *indio_dev, u8 reg_addr, u32 *val)
>  	spi_message_init(&msg);
>  	spi_message_add_tail(&xfer, &msg);
>  	ret = spi_sync(st->us, &msg);
> -	ret = spi_read(st->us, st->buf, 4);
>  
>  	if (ret == 0)
>  		*val = (st->buf[1] << 16) | (st->buf[2] << 8) | st->buf[3];
> 
