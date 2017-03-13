Return-Path: <SRS0=5Ir3=2W=metafoo.de=lars@kernel.org>
Subject: Re: [PATCH v3 1/2] staging: iio: ad9834: Use private driver lock
 instead of mlock
To: sayli karnik <karniksayli1995@gmail.com>,
 outreachy-kernel@googlegroups.com
References: <cover.1489389769.git.karniksayli1995@gmail.com>
 <24fc8a025e0c56abfa57e38acef17a32a1e54934.1489389769.git.karniksayli1995@gmail.com>
Cc: linux-iio@vger.kernel.org,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <742f81fc-c8e3-d76e-5624-14cfe5803534@metafoo.de>
Date: Mon, 13 Mar 2017 12:54:56 +0100
MIME-Version: 1.0
In-Reply-To: <24fc8a025e0c56abfa57e38acef17a32a1e54934.1489389769.git.karniksayli1995@gmail.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 03/13/2017 08:35 AM, sayli karnik wrote:
> iio_dev->mlock should be used by the IIO core only for protecting
> device operating mode changes. ie. Changes between INDIO_DIRECT_MODE,
> INDIO_BUFFER_* modes.
> Replace mlock with a lock in the device's global data to protect
> hardware state changes.
> 
> Signed-off-by: sayli karnik <karniksayli1995@gmail.com>

This looks OK, but there is one issue with this patch(and all the other lock
changes). The lock needs to be initialized before it can be used. You need
to call mutex_init() inside the probe function before the lock is used the
first time.

> ---
> v2:
> Fixed mistake by changing mutex_lock() to mutex_unlock()
> 
>  drivers/staging/iio/frequency/ad9834.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
> index f92ff7f..60461a6 100644
> --- a/drivers/staging/iio/frequency/ad9834.c
> +++ b/drivers/staging/iio/frequency/ad9834.c
> @@ -63,6 +63,7 @@
>   * @msg:		default spi message
>   * @freq_xfer:		tuning word spi transfer
>   * @freq_msg:		tuning word spi message
> + * @lock:		protect sensor state
>   * @data:		spi transmit buffer
>   * @freq_data:		tuning word spi transmit buffer
>   */
> @@ -77,6 +78,7 @@ struct ad9834_state {
>  	struct spi_message		msg;
>  	struct spi_transfer		freq_xfer[2];
>  	struct spi_message		freq_msg;
> +	struct mutex                    lock;   /* protect sensor state */
>  
>  	/*
>  	 * DMA (thus cache coherency maintenance) requires the
> @@ -149,7 +151,7 @@ static ssize_t ad9834_write(struct device *dev,
>  	if (ret)
>  		goto error_ret;
>  
> -	mutex_lock(&indio_dev->mlock);
> +	mutex_lock(&st->lock);
>  	switch ((u32)this_attr->address) {
>  	case AD9834_REG_FREQ0:
>  	case AD9834_REG_FREQ1:
> @@ -207,7 +209,7 @@ static ssize_t ad9834_write(struct device *dev,
>  	default:
>  		ret = -ENODEV;
>  	}
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&st->lock);
>  
>  error_ret:
>  	return ret ? ret : len;
> @@ -224,7 +226,7 @@ static ssize_t ad9834_store_wavetype(struct device *dev,
>  	int ret = 0;
>  	bool is_ad9833_7 = (st->devid == ID_AD9833) || (st->devid == ID_AD9837);
>  
> -	mutex_lock(&indio_dev->mlock);
> +	mutex_lock(&st->lock);
>  
>  	switch ((u32)this_attr->address) {
>  	case 0:
> @@ -267,7 +269,7 @@ static ssize_t ad9834_store_wavetype(struct device *dev,
>  		st->data = cpu_to_be16(AD9834_REG_CMD | st->control);
>  		ret = spi_sync(st->spi, &st->msg);
>  	}
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&st->lock);
>  
>  	return ret ? ret : len;
>  }
> 
