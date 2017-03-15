Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58246 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753868AbdCOWM7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Mar 2017 18:12:59 -0400
Subject: Re: [PATCH v3] staging: iio: ad9834: Use private driver lock instead
 of mlock
To: sayli karnik <karniksayli1995@gmail.com>,
        outreachy-kernel@googlegroups.com
References: <20170313163527.GA15056@sayli-HP-15-Notebook-PC>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <8f78e5c0-52c7-30b6-7b55-9ffbf12ee2fc@kernel.org>
Date: Wed, 15 Mar 2017 22:12:58 +0000
MIME-Version: 1.0
In-Reply-To: <20170313163527.GA15056@sayli-HP-15-Notebook-PC>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 13/03/17 16:35, sayli karnik wrote:
> iio_dev->mlock should be used by the IIO core only for protecting
> device operating mode changes. ie. Changes between INDIO_DIRECT_MODE,
> INDIO_BUFFER_* modes.
> Replace mlock with a lock in the device's global data to protect
> hardware state changes.
> 
> Signed-off-by: sayli karnik <karniksayli1995@gmail.com>
Applied and pushed out as testing for the autobuilders to play with it.

Thanks,

Jonathan
> ---
> v3:
> Initialised the lock with mutex_init()
> v2:
> Fixed mistake by changing mutex_lock() to mutex_unlock()
> 
>  drivers/staging/iio/frequency/ad9834.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
> index f92ff7f..2dffe48 100644
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
> @@ -418,6 +420,7 @@ static int ad9834_probe(struct spi_device *spi)
>  	}
>  	spi_set_drvdata(spi, indio_dev);
>  	st = iio_priv(indio_dev);
> +	mutex_init(&st->lock);
>  	st->mclk = pdata->mclk;
>  	st->spi = spi;
>  	st->devid = spi_get_device_id(spi)->driver_data;
> 

