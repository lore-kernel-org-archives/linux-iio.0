Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39719 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932948Ab3AIVqA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 9 Jan 2013 16:46:00 -0500
Message-ID: <50EDE516.5040206@kernel.org>
Date: Wed, 09 Jan 2013 21:45:58 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/7] staging:iio:adis16080: Cleanup SPI transfer
References: <1357740079-12326-1-git-send-email-lars@metafoo.de> <1357740079-12326-3-git-send-email-lars@metafoo.de>
In-Reply-To: <1357740079-12326-3-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/09/2013 02:01 PM, Lars-Peter Clausen wrote:
> During sampling the driver currently does a spi_read followed by a spi_write.
> This is not a problem per se, since CS needs to be deasserted between the two
> transfers. So even if another device claims the bus between the two transfers we
> should still get a result. But the code is actually spread out over multiple
> functions. E.g. the spi_read happens in one function the spi_write in another,
> this makes the code harder to follow. This patch re-factors the code to just use
> a single spi transaction to do both the read and the write transfer.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Definitely an improvement.

Added to togreg branch of iio.git  There was a bit of fuzz
as patch 1 has changed and for that matter is going through
a different route so wasn't there.  Nothing significant
though..

> ---
>  drivers/staging/iio/gyro/adis16080_core.c | 61 +++++++++++++------------------
>  1 file changed, 25 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/staging/iio/gyro/adis16080_core.c b/drivers/staging/iio/gyro/adis16080_core.c
> index 0268f2a..6016e4c 100644
> --- a/drivers/staging/iio/gyro/adis16080_core.c
> +++ b/drivers/staging/iio/gyro/adis16080_core.c
> @@ -42,32 +42,32 @@ struct adis16080_state {
>  	u8 buf[2] ____cacheline_aligned;
>  };
>  
> -static int adis16080_spi_write(struct iio_dev *indio_dev,
> -		u16 val)
> +static int adis16080_read_sample(struct iio_dev *indio_dev,
> +		u16 addr, int *val)
>  {
> -	int ret;
>  	struct adis16080_state *st = iio_priv(indio_dev);
> -
> -	mutex_lock(&st->buf_lock);
> -	st->buf[0] = val >> 8;
> -	st->buf[1] = val;
> -
> -	ret = spi_write(st->us, st->buf, 2);
> -	mutex_unlock(&st->buf_lock);
> -
> -	return ret;
> -}
> -
> -static int adis16080_spi_read(struct iio_dev *indio_dev,
> -			      u16 *val)
> -{
> +	struct spi_message m;
>  	int ret;
> -	struct adis16080_state *st = iio_priv(indio_dev);
> +	struct spi_transfer	t[] = {
> +		{
> +			.tx_buf		= &st->buf,
> +			.len		= 2,
> +			.cs_change	= 1,
> +		}, {
> +			.rx_buf		= &st->buf,
> +			.len		= 2,
> +		},
> +	};
>  
>  	mutex_lock(&st->buf_lock);
> +	st->buf[0] = addr >> 8;
> +	st->buf[1] = addr;
>  
> -	ret = spi_read(st->us, st->buf, 2);
> +	spi_message_init(&m);
> +	spi_message_add_tail(&t[0], &m);
> +	spi_message_add_tail(&t[1], &m);
>  
> +	ret = spi_sync(st->us, &m);
>  	if (ret == 0)
>  		*val = sign_extend32(12, ((st->buf[0] & 0xF) << 8) | st->buf[1]);
>  	mutex_unlock(&st->buf_lock);
> @@ -81,28 +81,17 @@ static int adis16080_read_raw(struct iio_dev *indio_dev,
>  			     int *val2,
>  			     long mask)
>  {
> -	int ret = -EINVAL;
> -	u16 ut = 0;
> -	/* Take the iio_dev status lock */
> +	int ret;
>  
> -	mutex_lock(&indio_dev->mlock);
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> -		ret = adis16080_spi_write(indio_dev,
> -					  chan->address |
> -					  ADIS16080_DIN_WRITE);
> -		if (ret < 0)
> -			break;
> -		ret = adis16080_spi_read(indio_dev, &ut);
> -		if (ret < 0)
> -			break;
> -		*val = ut;
> -		ret = IIO_VAL_INT;
> -		break;
> +		mutex_lock(&indio_dev->mlock);
> +		ret = adis16080_read_sample(indio_dev, chan->address, val);
> +		mutex_unlock(&indio_dev->mlock);
> +		return ret ? ret : IIO_VAL_INT;
>  	}
> -	mutex_unlock(&indio_dev->mlock);
>  
> -	return ret;
> +	return -EINVAL;
>  }
>  
>  static const struct iio_chan_spec adis16080_channels[] = {
> 
