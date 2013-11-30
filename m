Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48204 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751119Ab3K3LHO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 30 Nov 2013 06:07:14 -0500
Message-ID: <5299C6E1.8030307@kernel.org>
Date: Sat, 30 Nov 2013 11:07:13 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 02/15] iio:ad5504: Do not store transfer buffers on the
 stack
References: <1385383327-28181-1-git-send-email-lars@metafoo.de> <1385383327-28181-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1385383327-28181-2-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/25/13 12:41, Lars-Peter Clausen wrote:
> Some SPI controllers may not be able to handle transfer buffers that are placed
> on the stack.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git

Thanks
> ---
>  drivers/iio/dac/ad5504.c | 40 ++++++++++++++++++++--------------------
>  1 file changed, 20 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5504.c b/drivers/iio/dac/ad5504.c
> index 6cd0dd6..d44c8f5 100644
> --- a/drivers/iio/dac/ad5504.c
> +++ b/drivers/iio/dac/ad5504.c
> @@ -47,14 +47,16 @@
>   * @vref_mv:		actual reference voltage used
>   * @pwr_down_mask	power down mask
>   * @pwr_down_mode	current power down mode
> + * @data:		transfer buffer
>   */
> -
>  struct ad5504_state {
>  	struct spi_device		*spi;
>  	struct regulator		*reg;
>  	unsigned short			vref_mv;
>  	unsigned			pwr_down_mask;
>  	unsigned			pwr_down_mode;
> +
> +	__be16				data[2] ____cacheline_aligned;
>  };
>  
>  /**
> @@ -66,31 +68,29 @@ enum ad5504_supported_device_ids {
>  	ID_AD5501,
>  };
>  
> -static int ad5504_spi_write(struct spi_device *spi, u8 addr, u16 val)
> +static int ad5504_spi_write(struct ad5504_state *st, u8 addr, u16 val)
>  {
> -	__be16 tmp = cpu_to_be16(AD5504_CMD_WRITE |
> -			      AD5504_ADDR(addr) |
> +	st->data[0] = cpu_to_be16(AD5504_CMD_WRITE | AD5504_ADDR(addr) |
>  			      (val & AD5504_RES_MASK));
>  
> -	return spi_write(spi, (u8 *)&tmp, 2);
> +	return spi_write(st->spi, &st->data[0], 2);
>  }
>  
> -static int ad5504_spi_read(struct spi_device *spi, u8 addr)
> +static int ad5504_spi_read(struct ad5504_state *st, u8 addr)
>  {
> -	__be16 tmp = cpu_to_be16(AD5504_CMD_READ | AD5504_ADDR(addr));
> -	__be16 val;
>  	int ret;
> -	struct spi_transfer	t = {
> -			.tx_buf		= &tmp,
> -			.rx_buf		= &val,
> -			.len		= 2,
> -		};
> -	ret = spi_sync_transfer(spi, &t, 1);
> -
> +	struct spi_transfer t = {
> +	    .tx_buf = &st->data[0],
> +	    .rx_buf = &st->data[1],
> +	    .len = 2,
> +	};
> +
> +	st->data[0] = cpu_to_be16(AD5504_CMD_READ | AD5504_ADDR(addr));
> +	ret = spi_sync_transfer(st->spi, &t, 1);
>  	if (ret < 0)
>  		return ret;
>  
> -	return be16_to_cpu(val) & AD5504_RES_MASK;
> +	return be16_to_cpu(st->data[1]) & AD5504_RES_MASK;
>  }
>  
>  static int ad5504_read_raw(struct iio_dev *indio_dev,
> @@ -104,7 +104,7 @@ static int ad5504_read_raw(struct iio_dev *indio_dev,
>  
>  	switch (m) {
>  	case IIO_CHAN_INFO_RAW:
> -		ret = ad5504_spi_read(st->spi, chan->address);
> +		ret = ad5504_spi_read(st, chan->address);
>  		if (ret < 0)
>  			return ret;
>  
> @@ -133,7 +133,7 @@ static int ad5504_write_raw(struct iio_dev *indio_dev,
>  		if (val >= (1 << chan->scan_type.realbits) || val < 0)
>  			return -EINVAL;
>  
> -		return ad5504_spi_write(st->spi, chan->address, val);
> +		return ad5504_spi_write(st, chan->address, val);
>  	default:
>  		ret = -EINVAL;
>  	}
> @@ -197,12 +197,12 @@ static ssize_t ad5504_write_dac_powerdown(struct iio_dev *indio_dev,
>  	else
>  		st->pwr_down_mask &= ~(1 << chan->channel);
>  
> -	ret = ad5504_spi_write(st->spi, AD5504_ADDR_CTRL,
> +	ret = ad5504_spi_write(st, AD5504_ADDR_CTRL,
>  				AD5504_DAC_PWRDWN_MODE(st->pwr_down_mode) |
>  				AD5504_DAC_PWR(st->pwr_down_mask));
>  
>  	/* writes to the CTRL register must be followed by a NOOP */
> -	ad5504_spi_write(st->spi, AD5504_ADDR_NOOP, 0);
> +	ad5504_spi_write(st, AD5504_ADDR_NOOP, 0);
>  
>  	return ret ? ret : len;
>  }
> 
