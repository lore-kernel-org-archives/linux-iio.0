Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751986AbeBDLK1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 4 Feb 2018 06:10:27 -0500
Date: Sun, 4 Feb 2018 11:10:22 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Shreeya Patel <shreeya.patel23498@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] Staging: iio: ade7758: Expand buf_lock to cover both
 buffer and state protection
Message-ID: <20180204111022.0e6d08f6@archlinux>
In-Reply-To: <1517671892-4045-1-git-send-email-shreeya.patel23498@gmail.com>
References: <1517671892-4045-1-git-send-email-shreeya.patel23498@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat,  3 Feb 2018 21:01:32 +0530
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
> It isn't readily apparent that write frequency function requires
> the locks to be taken, so move it inside the function to where it
> is required to protect.
> 
> Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
Hi Shreeya,

Unfortunately this introduces a new bug - you end up unlocking
a mutex that you never locked in one of the error paths.
See inline.

We are also still taking the mlock around the read of the
frequency which doesn't make any sense given there is
no reason to protect that against state changes.
Arguably fixing that could be a separate patch as it never
made much sense, but it should probably be in this same series
at least.  I would have no real problem with it being in it this
same patch as long as the description above mentions it.

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
> Changes in v4
>   -Write frequency function do not require lock so move it inside
> the function to where it is required to protect.
> 
> 
>  drivers/staging/iio/meter/ade7758.h      |  2 +-
>  drivers/staging/iio/meter/ade7758_core.c | 49 ++++++++++++++++++++++++--------
>  2 files changed, 38 insertions(+), 13 deletions(-)
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
> index 227dbfc..ff19d46 100644
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
> @@ -480,10 +499,12 @@ static int ade7758_read_samp_freq(struct device *dev, int *val)
>  	return 0;
>  }
>  
> -static int ade7758_write_samp_freq(struct device *dev, int val)
> +static int ade7758_write_samp_freq(struct iio_dev *indio_dev, int val)
>  {
>  	int ret;
>  	u8 reg, t;
> +	struct ade7758_state *st = iio_priv(indio_dev);
> +	struct device *dev = &indio_dev->dev;
>  
>  	switch (val) {
>  	case 26040:
> @@ -503,16 +524,20 @@ static int ade7758_write_samp_freq(struct device *dev, int val)
>  		goto out;

This goto out results in an unlock but the lock hasn't been locked
for a few more lines...

Change this to a direct return here rather than a goto to fix this.
return -EINVAL;

>  	}
>  
> -	ret = ade7758_spi_read_reg_8(dev, ADE7758_WAVMODE, &reg);
> +	mutex_lock(&st->buf_lock);
> +
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
> +	mutex_unlock(&st->buf_lock);
> +
>  	return ret;
>  }
>  
> @@ -545,9 +570,9 @@ static int ade7758_write_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		if (val2)
>  			return -EINVAL;
> -		mutex_lock(&indio_dev->mlock);
> -		ret = ade7758_write_samp_freq(&indio_dev->dev, val);
> -		mutex_unlock(&indio_dev->mlock);
> +
> +		ret = ade7758_write_samp_freq(indio_dev, val);
> +
>  		return ret;
>  	default:
>  		return -EINVAL;

