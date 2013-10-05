Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:32914 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751408Ab3JEKAO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 5 Oct 2013 06:00:14 -0400
Message-ID: <524FF15E.9020302@kernel.org>
Date: Sat, 05 Oct 2013 12:00:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 4/8] iio:adis16130: Use spi_sync_transfer()
References: <1380959108-21775-1-git-send-email-lars@metafoo.de> <1380959108-21775-4-git-send-email-lars@metafoo.de>
In-Reply-To: <1380959108-21775-4-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/05/13 08:45, Lars-Peter Clausen wrote:
> Use the spi_sync_transfer() helper function instead of open-coding it. Makes
> the code a bit shorter.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git

Thanks,
> ---
>  drivers/iio/gyro/adis16130.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/gyro/adis16130.c b/drivers/iio/gyro/adis16130.c
> index 9155cf6..445c2ae 100644
> --- a/drivers/iio/gyro/adis16130.c
> +++ b/drivers/iio/gyro/adis16130.c
> @@ -47,7 +47,6 @@ static int adis16130_spi_read(struct iio_dev *indio_dev, u8 reg_addr, u32 *val)
>  {
>  	int ret;
>  	struct adis16130_state *st = iio_priv(indio_dev);
> -	struct spi_message msg;
>  	struct spi_transfer xfer = {
>  		.tx_buf = st->buf,
>  		.rx_buf = st->buf,
> @@ -59,10 +58,7 @@ static int adis16130_spi_read(struct iio_dev *indio_dev, u8 reg_addr, u32 *val)
>  	st->buf[0] = ADIS16130_CON_RD | reg_addr;
>  	st->buf[1] = st->buf[2] = st->buf[3] = 0;
>  
> -	spi_message_init(&msg);
> -	spi_message_add_tail(&xfer, &msg);
> -	ret = spi_sync(st->us, &msg);
> -
> +	ret = spi_sync_transfer(st->us, &xfer, 1);
>  	if (ret == 0)
>  		*val = (st->buf[1] << 16) | (st->buf[2] << 8) | st->buf[3];
>  	mutex_unlock(&st->buf_lock);
> 
