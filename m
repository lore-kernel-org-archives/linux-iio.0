Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.117]:48068 "EHLO vps.pmeerw.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754280AbdC3IUK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 30 Mar 2017 04:20:10 -0400
Date: Thu, 30 Mar 2017 10:20:08 +0200 (CEST)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Gargi Sharma <gs051095@gmail.com>
cc: outreachy-kernel@googlegroups.com, linux-iio@vger.kernel.org,
        lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org
Subject: Re: [RFC v2] staging: iio: update locking method during frequency
 writes
In-Reply-To: <1490855953-27552-1-git-send-email-gs051095@gmail.com>
Message-ID: <alpine.DEB.2.20.1703301018510.14237@vps.pmeerw.net>
References: <1490855953-27552-1-git-send-email-gs051095@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 30 Mar 2017, Gargi Sharma wrote:

> The driver needs to insure atomicity during frequency
> changes of bus and device. The iiodev->mlock as used
> was not doing that. Replace it with the drivers existing
> buffer lock and introduce an auxiliary spi_write() that does
> not hold the lock.

nitpicking below
 
> Signed-off-by: Gargi Sharma <gs051095@gmail.com>
> ---
> Changes in v2:
>         - Added auxiliary function.
>         - Updated the buf_lock comment appropriately.
> ---
>  drivers/staging/iio/meter/ade7754.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/iio/meter/ade7754.c b/drivers/staging/iio/meter/ade7754.c
> index c8d2d4c..f371030 100644
> --- a/drivers/staging/iio/meter/ade7754.c
> +++ b/drivers/staging/iio/meter/ade7754.c
> @@ -97,7 +97,7 @@
>  /**
>   * struct ade7754_state - device instance specific data
>   * @us:			actual spi_device
> - * @buf_lock:		mutex to protect tx and rx
> + * @buf_lock:		mutex to protect tx, rx and write frequency
>   * @tx:			transmit buffer
>   * @rx:			receive buffer
>   **/
> @@ -108,17 +108,29 @@ struct ade7754_state {
>  	u8			rx[ADE7754_MAX_RX];
>  };
>  
> -static int ade7754_spi_write_reg_8(struct device *dev, u8 reg_address, u8 val)
> +/* Unlocked version of ade7754_spi_write_reg_8 function */
> +static int __ade7754_spi_write_reg_8(struct device *dev, u8 reg_address, u8 val)
>  {
>  	int ret;
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct ade7754_state *st = iio_priv(indio_dev);
>  
> -	mutex_lock(&st->buf_lock);
>  	st->tx[0] = ADE7754_WRITE_REG(reg_address);
>  	st->tx[1] = val;
>  
>  	ret = spi_write(st->us, st->tx, 2);

return directly, so
return spi_write(st->us, st->tx, 2);
and no need for ret variable anymore

> +
> +	return ret;
> +}
> +
> +static int ade7754_spi_write_reg_8(struct device *dev, u8 reg_address, u8 val)
> +{
> +	int ret;
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct ade7754_state *st = iio_priv(indio_dev);
> +
> +	mutex_lock(&st->buf_lock);
> +	ret = __ade7754_spi_write_reg_8(dev, reg_address, val);
>  	mutex_unlock(&st->buf_lock);
>  
>  	return ret;
> @@ -513,7 +525,7 @@ static ssize_t ade7754_write_frequency(struct device *dev,
>  	if (!val)
>  		return -EINVAL;
>  
> -	mutex_lock(&indio_dev->mlock);
> +	mutex_lock(&st->buf_lock);
>  
>  	t = 26000 / val;
>  	if (t > 0)
> @@ -531,10 +543,10 @@ static ssize_t ade7754_write_frequency(struct device *dev,
>  	reg &= ~(3 << 3);
>  	reg |= t << 3;
>  
> -	ret = ade7754_spi_write_reg_8(dev, ADE7754_WAVMODE, reg);
> +	ret = __ade7754_spi_write_reg_8(dev, ADE7754_WAVMODE, reg);
>  
>  out:
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&st->buf_lock);
>  
>  	return ret ? ret : len;
>  }
> 

-- 

Peter Meerwald-Stadler
Mobile: +43 664 24 44 418
