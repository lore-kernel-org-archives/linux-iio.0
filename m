Return-Path: <jic23@kernel.org>
Message-ID: <4F96DAFC.1060905@kernel.org>
Date: Tue, 24 Apr 2012 17:55:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org,
 device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Subject: Re: [PATCH v2 03/11] staging:iio:dac:ad5446: Fix 24bit transfers
References: <1335286181-20474-1-git-send-email-lars@metafoo.de> <1335286181-20474-3-git-send-email-lars@metafoo.de>
In-Reply-To: <1335286181-20474-3-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 04/24/2012 05:49 PM, Lars-Peter Clausen wrote:
> We currently only write 16 bit in case where we should write 24 bit. The spi message
> length is calculated from the channel storage_size, but since the storage size
> is only 16 bit we end up with the wrong value for devices which have power down
> bits and thus a register with 24 bit. Since each store function knows how many
> bytes it has to write just use the spi_write function from there instead of
> going through the hassle of manually preparing a spi_message and keeping buffers
> in the state struct.
> 
> Another advantage of this patch is that it will implementing support for similar
> I2C based DACs much easier.
Nice cleanup.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  drivers/staging/iio/dac/ad5446.c |   52 ++++++++++++++++++--------------------
>  drivers/staging/iio/dac/ad5446.h |   13 ++--------
>  2 files changed, 27 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/staging/iio/dac/ad5446.c b/drivers/staging/iio/dac/ad5446.c
> index 0da5c6c..2ce6b5b 100644
> --- a/drivers/staging/iio/dac/ad5446.c
> +++ b/drivers/staging/iio/dac/ad5446.c
> @@ -24,31 +24,40 @@
>  
>  #include "ad5446.h"
>  
> -static void ad5446_store_sample(struct ad5446_state *st, unsigned val)
> +static int ad5446_store_sample(struct ad5446_state *st, unsigned val)
>  {
> -	st->data.d16 = cpu_to_be16(val);
> +	__be16 data = cpu_to_be16(val);
> +	return spi_write(st->spi, &data, sizeof(data));
>  }
>  
> -static void ad5660_store_sample(struct ad5446_state *st, unsigned val)
> +static int ad5660_store_sample(struct ad5446_state *st, unsigned val)
>  {
> +	uint8_t data[3];
> +
>  	val |= AD5660_LOAD;
> -	st->data.d24[0] = (val >> 16) & 0xFF;
> -	st->data.d24[1] = (val >> 8) & 0xFF;
> -	st->data.d24[2] = val & 0xFF;
> +	data[0] = (val >> 16) & 0xFF;
> +	data[1] = (val >> 8) & 0xFF;
> +	data[2] = val & 0xFF;
> +
> +	return spi_write(st->spi, data, sizeof(data));
>  }
>  
> -static void ad5620_store_pwr_down(struct ad5446_state *st, unsigned mode)
> +static int ad5620_store_pwr_down(struct ad5446_state *st, unsigned mode)
>  {
> -	st->data.d16 = cpu_to_be16(mode << 14);
> +	__be16 data = cpu_to_be16(mode << 14);
> +	return spi_write(st->spi, &data, sizeof(data));
>  }
>  
> -static void ad5660_store_pwr_down(struct ad5446_state *st, unsigned mode)
> +static int ad5660_store_pwr_down(struct ad5446_state *st, unsigned mode)
>  {
>  	unsigned val = mode << 16;
> +	uint8_t data[3];
> +
> +	data[0] = (val >> 16) & 0xFF;
> +	data[1] = (val >> 8) & 0xFF;
> +	data[2] = val & 0xFF;
>  
> -	st->data.d24[0] = (val >> 16) & 0xFF;
> -	st->data.d24[1] = (val >> 8) & 0xFF;
> -	st->data.d24[2] = val & 0xFF;
> +	return spi_write(st->spi, data, sizeof(data));
>  }
>  
>  static ssize_t ad5446_write_powerdown_mode(struct device *dev,
> @@ -111,11 +120,10 @@ static ssize_t ad5446_write_dac_powerdown(struct device *dev,
>  	st->pwr_down = readin;
>  
>  	if (st->pwr_down)
> -		st->chip_info->store_pwr_down(st, st->pwr_down_mode);
> +		ret = st->chip_info->store_pwr_down(st, st->pwr_down_mode);
>  	else
> -		st->chip_info->store_sample(st, st->cached_val);
> +		ret = st->chip_info->store_sample(st, st->cached_val);
>  
> -	ret = spi_sync(st->spi, &st->msg);
>  	mutex_unlock(&indio_dev->mlock);
>  
>  	return ret ? ret : len;
> @@ -272,10 +280,8 @@ static int ad5446_write_raw(struct iio_dev *indio_dev,
>  		val <<= chan->scan_type.shift;
>  		mutex_lock(&indio_dev->mlock);
>  		st->cached_val = val;
> -		if (!st->pwr_down) {
> -			st->chip_info->store_sample(st, val);
> -			ret = spi_sync(st->spi, &st->msg);
> -		}
> +		if (!st->pwr_down)
> +			ret = st->chip_info->store_sample(st, val);
>  		mutex_unlock(&indio_dev->mlock);
>  		break;
>  	default:
> @@ -338,14 +344,6 @@ static int __devinit ad5446_probe(struct spi_device *spi)
>  	indio_dev->channels = &st->chip_info->channel;
>  	indio_dev->num_channels = 1;
>  
> -	/* Setup default message */
> -
> -	st->xfer.tx_buf = &st->data;
> -	st->xfer.len = st->chip_info->channel.scan_type.storagebits / 8;
> -
> -	spi_message_init(&st->msg);
> -	spi_message_add_tail(&st->xfer, &st->msg);
> -
>  	switch (spi_get_device_id(spi)->driver_data) {
>  	case ID_AD5620_2500:
>  	case ID_AD5620_1250:
> diff --git a/drivers/staging/iio/dac/ad5446.h b/drivers/staging/iio/dac/ad5446.h
> index 4ea3476..f9fff71 100644
> --- a/drivers/staging/iio/dac/ad5446.h
> +++ b/drivers/staging/iio/dac/ad5446.h
> @@ -36,9 +36,6 @@
>   * @reg:		supply regulator
>   * @poll_work:		bottom half of polling interrupt handler
>   * @vref_mv:		actual reference voltage used
> - * @xfer:		default spi transfer
> - * @msg:		default spi message
> - * @data:		spi transmit buffer
>   */
>  
>  struct ad5446_state {
> @@ -50,12 +47,6 @@ struct ad5446_state {
>  	unsigned			cached_val;
>  	unsigned			pwr_down_mode;
>  	unsigned			pwr_down;
> -	struct spi_transfer		xfer;
> -	struct spi_message		msg;
> -	union {
> -		unsigned short		d16;
> -		unsigned char		d24[3];
> -	} data;
>  };
>  
>  /**
> @@ -69,8 +60,8 @@ struct ad5446_state {
>  struct ad5446_chip_info {
>  	struct iio_chan_spec	channel;
>  	u16			int_vref_mv;
> -	void (*store_sample)	(struct ad5446_state *st, unsigned val);
> -	void (*store_pwr_down)	(struct ad5446_state *st, unsigned mode);
> +	int (*store_sample)	(struct ad5446_state *st, unsigned val);
> +	int (*store_pwr_down)	(struct ad5446_state *st, unsigned mode);
>  };
>  
>  /**
