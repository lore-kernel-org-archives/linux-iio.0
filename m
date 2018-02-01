Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:5162 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751520AbeBAJx2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 1 Feb 2018 04:53:28 -0500
Date: Thu, 1 Feb 2018 09:53:03 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Shreeya Patel <shreeya.patel23498@gmail.com>
CC: <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] Staging: iio: ade7758: Expand buf_lock to cover both
 buffer and state protection
Message-ID: <20180201095303.000066b2@huawei.com>
In-Reply-To: <1517335217-6163-1-git-send-email-shreeya.patel23498@gmail.com>
References: <1517335217-6163-1-git-send-email-shreeya.patel23498@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 30 Jan 2018 23:30:17 +0530
Shreeya Patel <shreeya.patel23498@gmail.com> wrote:

> iio_dev->mlock is to be used only by the IIO core for protecting
> device mode changes between INDIO_DIRECT and INDIO_BUFFER.
> 
> This patch replaces the use of mlock with the already established
> buf_lock mutex.
> 
> Introducing 'unlocked' forms of read and write registers. The
> read/write frequency functions now require buf_lock to be held.
> That's not obvious so avoid this but moving the locking inside
> the functions where it is then clear that they are taking the
> unlocked forms of the register read/write.
> 
> Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>

Good, this should now work nicely.  I have suggested a further
improvement inline which I think will improve code clarity by
moving the lock to where it is obvious what it is protecting.

Thanks,

Jonathan
> ---
> 
> Changes in v2
>   -Add static keyword to newly introduced functions and remove some
> added comments which are not required.
> 
> Changes in v3
>   -Remove some useless mlocks and send it as another patch.
> Also make the necessary change in the current patch associated with 
> the new patch with commit id 88eba33. Make commit message more 
> appropriate.
> 
> 
>  drivers/staging/iio/meter/ade7758.h      |  2 +-
>  drivers/staging/iio/meter/ade7758_core.c | 40 ++++++++++++++++++++++++--------
>  2 files changed, 31 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/staging/iio/meter/ade7758.h b/drivers/staging/iio/meter/ade7758.h
> index 6ae78d8..2de81b5 100644
> --- a/drivers/staging/iio/meter/ade7758.h
> +++ b/drivers/staging/iio/meter/ade7758.h
> @@ -111,7 +111,7 @@
>   * @trig:		data ready trigger registered with iio
>   * @tx:			transmit buffer
>   * @rx:			receive buffer
> - * @buf_lock:		mutex to protect tx and rx
> + * @buf_lock:		mutex to protect tx, rx, read and write frequency
>   **/
>  struct ade7758_state {
>  	struct spi_device	*us;
> diff --git a/drivers/staging/iio/meter/ade7758_core.c b/drivers/staging/iio/meter/ade7758_core.c
> index 227dbfc..38e5d67 100644
> --- a/drivers/staging/iio/meter/ade7758_core.c
> +++ b/drivers/staging/iio/meter/ade7758_core.c
> @@ -24,17 +24,25 @@
>  #include "meter.h"
>  #include "ade7758.h"
>  
> -int ade7758_spi_write_reg_8(struct device *dev, u8 reg_address, u8 val)
> +static int __ade7758_spi_write_reg_8(struct device *dev, u8 reg_address, u8 val)
>  {
> -	int ret;
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct ade7758_state *st = iio_priv(indio_dev);
>  
> -	mutex_lock(&st->buf_lock);
>  	st->tx[0] = ADE7758_WRITE_REG(reg_address);
>  	st->tx[1] = val;
>  
> -	ret = spi_write(st->us, st->tx, 2);
> +	return spi_write(st->us, st->tx, 2);
> +}
> +
> +int ade7758_spi_write_reg_8(struct device *dev, u8 reg_address, u8 val)
> +{
> +	int ret;
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct ade7758_state *st = iio_priv(indio_dev);
> +
> +	mutex_lock(&st->buf_lock);
> +	ret = __ade7758_spi_write_reg_8(dev, reg_address, val);
>  	mutex_unlock(&st->buf_lock);
>  
>  	return ret;
> @@ -91,7 +99,7 @@ static int ade7758_spi_write_reg_24(struct device *dev, u8 reg_address,
>  	return ret;
>  }
>  
> -int ade7758_spi_read_reg_8(struct device *dev, u8 reg_address, u8 *val)
> +static int __ade7758_spi_read_reg_8(struct device *dev, u8 reg_address, u8 *val)
>  {
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct ade7758_state *st = iio_priv(indio_dev);
> @@ -111,7 +119,6 @@ int ade7758_spi_read_reg_8(struct device *dev, u8 reg_address, u8 *val)
>  		},
>  	};
>  
> -	mutex_lock(&st->buf_lock);
>  	st->tx[0] = ADE7758_READ_REG(reg_address);
>  	st->tx[1] = 0;
>  
> @@ -124,7 +131,19 @@ int ade7758_spi_read_reg_8(struct device *dev, u8 reg_address, u8 *val)
>  	*val = st->rx[0];
>  
>  error_ret:
> +	return ret;
> +}
> +
> +int ade7758_spi_read_reg_8(struct device *dev, u8 reg_address, u8 *val)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct ade7758_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	mutex_lock(&st->buf_lock);
> +	ret = __ade7758_spi_read_reg_8(dev, reg_address, val);
>  	mutex_unlock(&st->buf_lock);
> +
>  	return ret;
>  }
>  
> @@ -503,14 +522,14 @@ static int ade7758_write_samp_freq(struct device *dev, int val)
>  		goto out;
>  	}
>  
> -	ret = ade7758_spi_read_reg_8(dev, ADE7758_WAVMODE, &reg);
> +	ret = __ade7758_spi_read_reg_8(dev, ADE7758_WAVMODE, &reg);
>  	if (ret)
>  		goto out;
>  
>  	reg &= ~(5 << 3);
>  	reg |= t << 5;
>  
> -	ret = ade7758_spi_write_reg_8(dev, ADE7758_WAVMODE, reg);
> +	ret = __ade7758_spi_write_reg_8(dev, ADE7758_WAVMODE, reg);
>  
>  out:
>  	return ret;
> @@ -540,14 +559,15 @@ static int ade7758_write_raw(struct iio_dev *indio_dev,
>  			     int val, int val2, long mask)
>  {
>  	int ret;
> +	struct ade7758_state *st = iio_priv(indio_dev);
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		if (val2)
>  			return -EINVAL;
> -		mutex_lock(&indio_dev->mlock);
> +		mutex_lock(&st->buf_lock);
>  		ret = ade7758_write_samp_freq(&indio_dev->dev, val);
> -		mutex_unlock(&indio_dev->mlock);

Hmm. There is a trade off here between complexity of patch
(this is the minimal version on that side) and neatness of
the result.

It isn't readily apparent that ade7758_write_samp_freq requires the locks
to be taken so I think we should really move them inside the function.
(it's the only function that does other than the obvious unlocked
variants you introduce).

That would mean changing the function definition to take indio_dev
instead of the device pointer.

I think that would be a nice further improvement to the patch.

Thanks,

Jonathan
> +		mutex_unlock(&st->buf_lock);
>  		return ret;
>  	default:
>  		return -EINVAL;

