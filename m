Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48675 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751286AbdCSLWQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Mar 2017 07:22:16 -0400
Subject: Re: [PATCH v3] staging: iio: ad7280: Replace mlock with driver
 private lock
To: Gargi Sharma <gs051095@gmail.com>,
        outreachy-kernel@googlegroups.com
References: <1489737570-2491-1-git-send-email-gs051095@gmail.com>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de,
        Michael.Hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <3c4496fb-9ac8-db04-6292-2326f64a4523@kernel.org>
Date: Sun, 19 Mar 2017 11:12:06 +0000
MIME-Version: 1.0
In-Reply-To: <1489737570-2491-1-git-send-email-gs051095@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 17/03/17 07:59, Gargi Sharma wrote:
> The IIO subsystem is redefining iio_dev->mlock to be used by
> the IIO core only for protecting device operating mode changes.
> ie. Changes between INDIO_DIRECT_MODE, INDIO_BUFFER_* modes.
> 
> In this driver, mlock was being used to protect hardware state
> changes.  Replace it with a lock in the devices global data.
> 
> Signed-off-by: Gargi Sharma <gs051095@gmail.com>
Applied to the togreg branch of iio.git. Will push out as testing
later today.

Thanks,

Jonathan
> ---
> Changes in v3:
> 	- Added mutex_init(&st->lock) inside probe function.
> 	- Added driver name in subject line.
> Changes in v2:
>         - Made the commit log clearer.
> ---
>  drivers/staging/iio/adc/ad7280a.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
> index ee679ac..6a85e28 100644
> --- a/drivers/staging/iio/adc/ad7280a.c
> +++ b/drivers/staging/iio/adc/ad7280a.c
> @@ -134,6 +134,7 @@ struct ad7280_state {
>  	unsigned char			aux_threshhigh;
>  	unsigned char			aux_threshlow;
>  	unsigned char			cb_mask[AD7280A_MAX_CHAIN];
> +	struct mutex			lock; /* protect sensor state */
>  
>  	__be32				buf[2] ____cacheline_aligned;
>  };
> @@ -410,7 +411,7 @@ static ssize_t ad7280_store_balance_sw(struct device *dev,
>  	devaddr = this_attr->address >> 8;
>  	ch = this_attr->address & 0xFF;
>  
> -	mutex_lock(&indio_dev->mlock);
> +	mutex_lock(&st->lock);
>  	if (readin)
>  		st->cb_mask[devaddr] |= 1 << (ch + 2);
>  	else
> @@ -418,7 +419,7 @@ static ssize_t ad7280_store_balance_sw(struct device *dev,
>  
>  	ret = ad7280_write(st, devaddr, AD7280A_CELL_BALANCE,
>  			   0, st->cb_mask[devaddr]);
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&st->lock);
>  
>  	return ret ? ret : len;
>  }
> @@ -433,10 +434,10 @@ static ssize_t ad7280_show_balance_timer(struct device *dev,
>  	int ret;
>  	unsigned int msecs;
>  
> -	mutex_lock(&indio_dev->mlock);
> +	mutex_lock(&st->lock);
>  	ret = ad7280_read(st, this_attr->address >> 8,
>  			  this_attr->address & 0xFF);
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&st->lock);
>  
>  	if (ret < 0)
>  		return ret;
> @@ -466,11 +467,11 @@ static ssize_t ad7280_store_balance_timer(struct device *dev,
>  	if (val > 31)
>  		return -EINVAL;
>  
> -	mutex_lock(&indio_dev->mlock);
> +	mutex_lock(&st->lock);
>  	ret = ad7280_write(st, this_attr->address >> 8,
>  			   this_attr->address & 0xFF,
>  			   0, (val & 0x1F) << 3);
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&st->lock);
>  
>  	return ret ? ret : len;
>  }
> @@ -655,7 +656,7 @@ static ssize_t ad7280_write_channel_config(struct device *dev,
>  
>  	val = clamp(val, 0L, 0xFFL);
>  
> -	mutex_lock(&indio_dev->mlock);
> +	mutex_lock(&st->lock);
>  	switch ((u32)this_attr->address) {
>  	case AD7280A_CELL_OVERVOLTAGE:
>  		st->cell_threshhigh = val;
> @@ -674,7 +675,7 @@ static ssize_t ad7280_write_channel_config(struct device *dev,
>  	ret = ad7280_write(st, AD7280A_DEVADDR_MASTER,
>  			   this_attr->address, 1, val);
>  
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&st->lock);
>  
>  	return ret ? ret : len;
>  }
> @@ -792,13 +793,13 @@ static int ad7280_read_raw(struct iio_dev *indio_dev,
>  
>  	switch (m) {
>  	case IIO_CHAN_INFO_RAW:
> -		mutex_lock(&indio_dev->mlock);
> +		mutex_lock(&st->lock);
>  		if (chan->address == AD7280A_ALL_CELLS)
>  			ret = ad7280_read_all_channels(st, st->scan_cnt, NULL);
>  		else
>  			ret = ad7280_read_channel(st, chan->address >> 8,
>  						  chan->address & 0xFF);
> -		mutex_unlock(&indio_dev->mlock);
> +		mutex_unlock(&st->lock);
>  
>  		if (ret < 0)
>  			return ret;
> @@ -847,6 +848,7 @@ static int ad7280_probe(struct spi_device *spi)
>  	st = iio_priv(indio_dev);
>  	spi_set_drvdata(spi, indio_dev);
>  	st->spi = spi;
> +	mutex_init(&st->lock);
>  
>  	if (!pdata)
>  		pdata = &ad7793_default_pdata;
> 

