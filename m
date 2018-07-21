Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727964AbeGUReS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Jul 2018 13:34:18 -0400
Date: Sat, 21 Jul 2018 17:40:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc: <linux-iio@vger.kernel.org>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>
Subject: Re: [PATCH V4] iio: ad9523: replace core mlock with local lock
Message-ID: <20180721174055.6b32df4c@archlinux>
In-Reply-To: <20180718072953.15669-1-alexandru.ardelean@analog.com>
References: <20180718072953.15669-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 18 Jul 2018 10:29:53 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> From: Lars-Peter Clausen <lars@metafoo.de>
> 
> This is also part of a long term effort to make the use of mlock opaque and
> single purpose.
> 
> This lock is required for accessing device registers. Some operations
> require multiple consecutive R/W operations, during which the device
> shouldn't be interrupted.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Hi Alexandru.  Lars pointed out I was simply wrong in my complaints with
the previous description - it was correct in that case - we need perhaps
to expand the description to include what you have here as well.

Given I doubt you care too much on the wording I've fused the two.

	/*
	 * Lock for accessing device registers. Some operations require
	 * multiple consecutive R/W operations, during which the device
	 * shouldn't be interrupted.  The buffers are also shared across
	 * all operations so need to be protected on stand alone reads and
	 * writes.
	 */

Applied with that minor addition.  Thanks for persistence on this!

Jonathan

> ---
> 
> V3 -> V4:
> * updated comment/description of the lock
> 
>  drivers/iio/frequency/ad9523.c | 32 ++++++++++++++++++++++----------
>  1 file changed, 22 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/frequency/ad9523.c b/drivers/iio/frequency/ad9523.c
> index ddb6a334ae68..2ab175a0664d 100644
> --- a/drivers/iio/frequency/ad9523.c
> +++ b/drivers/iio/frequency/ad9523.c
> @@ -274,6 +274,13 @@ struct ad9523_state {
>  	unsigned long		vco_out_freq[AD9523_NUM_CLK_SRC];
>  	unsigned char		vco_out_map[AD9523_NUM_CHAN_ALT_CLK_SRC];
>  
> +	/*
> +	 * Lock for accessing device registers. Some operations require
> +	 * multiple consecutive R/W operations, during which the device
> +	 * shouldn't be interrupted.
> +	 */
> +	struct mutex		lock;
> +
>  	/*
>  	 * DMA (thus cache coherency maintenance) requires the
>  	 * transfer buffers to live in their own cache lines.
> @@ -500,6 +507,7 @@ static ssize_t ad9523_store(struct device *dev,
>  {
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> +	struct ad9523_state *st = iio_priv(indio_dev);
>  	bool state;
>  	int ret;
>  
> @@ -510,7 +518,7 @@ static ssize_t ad9523_store(struct device *dev,
>  	if (!state)
>  		return 0;
>  
> -	mutex_lock(&indio_dev->mlock);
> +	mutex_lock(&st->lock);
>  	switch ((u32)this_attr->address) {
>  	case AD9523_SYNC:
>  		ret = ad9523_sync(indio_dev);
> @@ -521,7 +529,7 @@ static ssize_t ad9523_store(struct device *dev,
>  	default:
>  		ret = -ENODEV;
>  	}
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&st->lock);
>  
>  	return ret ? ret : len;
>  }
> @@ -532,15 +540,16 @@ static ssize_t ad9523_show(struct device *dev,
>  {
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> +	struct ad9523_state *st = iio_priv(indio_dev);
>  	int ret;
>  
> -	mutex_lock(&indio_dev->mlock);
> +	mutex_lock(&st->lock);
>  	ret = ad9523_read(indio_dev, AD9523_READBACK_0);
>  	if (ret >= 0) {
>  		ret = sprintf(buf, "%d\n", !!(ret & (1 <<
>  			(u32)this_attr->address)));
>  	}
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&st->lock);
>  
>  	return ret;
>  }
> @@ -623,9 +632,9 @@ static int ad9523_read_raw(struct iio_dev *indio_dev,
>  	unsigned int code;
>  	int ret;
>  
> -	mutex_lock(&indio_dev->mlock);
> +	mutex_lock(&st->lock);
>  	ret = ad9523_read(indio_dev, AD9523_CHANNEL_CLOCK_DIST(chan->channel));
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&st->lock);
>  
>  	if (ret < 0)
>  		return ret;
> @@ -659,7 +668,7 @@ static int ad9523_write_raw(struct iio_dev *indio_dev,
>  	unsigned int reg;
>  	int ret, tmp, code;
>  
> -	mutex_lock(&indio_dev->mlock);
> +	mutex_lock(&st->lock);
>  	ret = ad9523_read(indio_dev, AD9523_CHANNEL_CLOCK_DIST(chan->channel));
>  	if (ret < 0)
>  		goto out;
> @@ -705,7 +714,7 @@ static int ad9523_write_raw(struct iio_dev *indio_dev,
>  
>  	ad9523_io_update(indio_dev);
>  out:
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&st->lock);
>  	return ret;
>  }
>  
> @@ -713,9 +722,10 @@ static int ad9523_reg_access(struct iio_dev *indio_dev,
>  			      unsigned int reg, unsigned int writeval,
>  			      unsigned int *readval)
>  {
> +	struct ad9523_state *st = iio_priv(indio_dev);
>  	int ret;
>  
> -	mutex_lock(&indio_dev->mlock);
> +	mutex_lock(&st->lock);
>  	if (readval == NULL) {
>  		ret = ad9523_write(indio_dev, reg | AD9523_R1B, writeval);
>  		ad9523_io_update(indio_dev);
> @@ -728,7 +738,7 @@ static int ad9523_reg_access(struct iio_dev *indio_dev,
>  	}
>  
>  out_unlock:
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&st->lock);
>  
>  	return ret;
>  }
> @@ -967,6 +977,8 @@ static int ad9523_probe(struct spi_device *spi)
>  
>  	st = iio_priv(indio_dev);
>  
> +	mutex_init(&st->lock);
> +
>  	st->reg = devm_regulator_get(&spi->dev, "vcc");
>  	if (!IS_ERR(st->reg)) {
>  		ret = regulator_enable(st->reg);

