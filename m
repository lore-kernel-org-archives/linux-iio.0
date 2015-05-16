Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53044 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754006AbbEPKBv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 16 May 2015 06:01:51 -0400
Message-ID: <5557158D.7060406@kernel.org>
Date: Sat, 16 May 2015 11:01:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 5/5] iio: adis16400: Fix burst transfer for adis16448
References: <1431703118-32676-1-git-send-email-lars@metafoo.de> <1431703118-32676-6-git-send-email-lars@metafoo.de>
In-Reply-To: <1431703118-32676-6-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 15/05/15 16:18, Lars-Peter Clausen wrote:
> The adis16448, unlike the other chips in this family, in addition to the
> hardware channels also sends out the DIAG_STAT register in burst mode
> before them. Handle that case by skipping over the first 2 bytes before we
> pass the received data to the buffer.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Fixes: 76ada52f7f5d ("iio:adis16400: Add support for the adis16448")
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan
> ---
>  drivers/iio/imu/adis16400.h        |  1 +
>  drivers/iio/imu/adis16400_buffer.c | 10 +++++++++-
>  drivers/iio/imu/adis16400_core.c   |  3 ++-
>  3 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/imu/adis16400.h b/drivers/iio/imu/adis16400.h
> index 1e8fd2e..73b189c 100644
> --- a/drivers/iio/imu/adis16400.h
> +++ b/drivers/iio/imu/adis16400.h
> @@ -139,6 +139,7 @@
>  #define ADIS16400_NO_BURST		BIT(1)
>  #define ADIS16400_HAS_SLOW_MODE		BIT(2)
>  #define ADIS16400_HAS_SERIAL_NUMBER	BIT(3)
> +#define ADIS16400_BURST_DIAG_STAT	BIT(4)
>  
>  struct adis16400_state;
>  
> diff --git a/drivers/iio/imu/adis16400_buffer.c b/drivers/iio/imu/adis16400_buffer.c
> index 629ae84..90c24a2 100644
> --- a/drivers/iio/imu/adis16400_buffer.c
> +++ b/drivers/iio/imu/adis16400_buffer.c
> @@ -29,6 +29,8 @@ int adis16400_update_scan_mode(struct iio_dev *indio_dev,
>  
>  	/* All but the timestamp channel */
>  	burst_length = (indio_dev->num_channels - 1) * sizeof(u16);
> +	if (st->variant->flags & ADIS16400_BURST_DIAG_STAT)
> +		burst_length += sizeof(u16);
>  
>  	adis->xfer = kcalloc(2, sizeof(*adis->xfer), GFP_KERNEL);
>  	if (!adis->xfer)
> @@ -63,6 +65,7 @@ irqreturn_t adis16400_trigger_handler(int irq, void *p)
>  	struct adis16400_state *st = iio_priv(indio_dev);
>  	struct adis *adis = &st->adis;
>  	u32 old_speed_hz = st->adis.spi->max_speed_hz;
> +	void *buffer;
>  	int ret;
>  
>  	if (!adis->buffer)
> @@ -83,7 +86,12 @@ irqreturn_t adis16400_trigger_handler(int irq, void *p)
>  		spi_setup(st->adis.spi);
>  	}
>  
> -	iio_push_to_buffers_with_timestamp(indio_dev, adis->buffer,
> +	if (st->variant->flags & ADIS16400_BURST_DIAG_STAT)
> +		buffer = adis->buffer + sizeof(u16);
> +	else
> +		buffer = adis->buffer;
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, buffer,
>  		pf->timestamp);
>  
>  	iio_trigger_notify_done(indio_dev->trig);
> diff --git a/drivers/iio/imu/adis16400_core.c b/drivers/iio/imu/adis16400_core.c
> index 7b06e058..2fd68f22 100644
> --- a/drivers/iio/imu/adis16400_core.c
> +++ b/drivers/iio/imu/adis16400_core.c
> @@ -778,7 +778,8 @@ static struct adis16400_chip_info adis16400_chips[] = {
>  		.channels = adis16448_channels,
>  		.num_channels = ARRAY_SIZE(adis16448_channels),
>  		.flags = ADIS16400_HAS_PROD_ID |
> -				ADIS16400_HAS_SERIAL_NUMBER,
> +				ADIS16400_HAS_SERIAL_NUMBER |
> +				ADIS16400_BURST_DIAG_STAT,
>  		.gyro_scale_micro = IIO_DEGREE_TO_RAD(10000), /* 0.01 deg/s */
>  		.accel_scale_micro = IIO_G_TO_M_S_2(833), /* 1/1200 g */
>  		.temp_scale_nano = 73860000, /* 0.07386 C */
> 

