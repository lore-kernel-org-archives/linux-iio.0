Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753537AbeCRJ5K (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 18 Mar 2018 05:57:10 -0400
Date: Sun, 18 Mar 2018 09:57:04 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc: John Syne <john3909@gmail.com>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Barry Song <21cnbao@gmail.com>,
        daniel.baluta@nxp.com
Subject: Re: [PATCH v2 4/8] staging:iio:ade7854: Rework SPI write function
Message-ID: <20180318095704.60e93288@archlinux>
In-Reply-To: <66ce9378178c994eb64d19ba3cccc5dbfc64e0ef.1521239766.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1521239766.git.rodrigosiqueiramelo@gmail.com>
        <66ce9378178c994eb64d19ba3cccc5dbfc64e0ef.1521239766.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 16 Mar 2018 19:49:24 -0300
Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com> wrote:

> The write operation using SPI has a many code duplications (similar to
> I2C) and four different interfaces per data size. This patch introduces
> a single function that centralizes the main task related to SPI.
> 
> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
A good change, but same comment on the defines as for the i2c case.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/meter/ade7854-spi.c | 108 ++++++++++++--------------------
>  1 file changed, 41 insertions(+), 67 deletions(-)
> 
> diff --git a/drivers/staging/iio/meter/ade7854-spi.c b/drivers/staging/iio/meter/ade7854-spi.c
> index 4419b8f06197..f21dc24194fb 100644
> --- a/drivers/staging/iio/meter/ade7854-spi.c
> +++ b/drivers/staging/iio/meter/ade7854-spi.c
> @@ -15,9 +15,10 @@
>  #include <linux/iio/iio.h>
>  #include "ade7854.h"
>  
> -static int ade7854_spi_write_reg_8(struct device *dev,
> -				   u16 reg_address,
> -				   u8 val)
> +static int ade7854_spi_write_reg(struct device *dev,
> +				 u16 reg_address,
> +				 u32 val,
> +				 int bytes)
>  {
>  	int ret;
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> @@ -32,93 +33,66 @@ static int ade7854_spi_write_reg_8(struct device *dev,
>  	st->tx[0] = ADE7854_WRITE_REG;
>  	st->tx[1] = (reg_address >> 8) & 0xFF;
>  	st->tx[2] = reg_address & 0xFF;
> -	st->tx[3] = val & 0xFF;
> +	switch (bytes) {
> +	case DATA_SIZE_8_BITS:
> +		st->tx[3] = val & 0xFF;
> +		break;
> +	case DATA_SIZE_16_BITS:
> +		xfer.len = 5;
> +		st->tx[3] = (val >> 8) & 0xFF;
> +		st->tx[4] = val & 0xFF;
> +		break;
> +	case DATA_SIZE_24_BITS:
> +		xfer.len = 6;
> +		st->tx[3] = (val >> 16) & 0xFF;
> +		st->tx[4] = (val >> 8) & 0xFF;
> +		st->tx[5] = val & 0xFF;
> +		break;
> +	case DATA_SIZE_32_BITS:
> +		xfer.len = 7;
> +		st->tx[3] = (val >> 24) & 0xFF;
> +		st->tx[4] = (val >> 16) & 0xFF;
> +		st->tx[5] = (val >> 8) & 0xFF;
> +		st->tx[6] = val & 0xFF;
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		goto unlock;
> +	}
>  
>  	ret = spi_sync_transfer(st->spi, &xfer, 1);
> +unlock:
>  	mutex_unlock(&st->buf_lock);
>  
>  	return ret;
>  }
>  
> +static int ade7854_spi_write_reg_8(struct device *dev,
> +				   u16 reg_address,
> +				   u8 val)
> +{
> +	return ade7854_spi_write_reg(dev, reg_address, val, DATA_SIZE_8_BITS);
> +}
> +
>  static int ade7854_spi_write_reg_16(struct device *dev,
>  				    u16 reg_address,
>  				    u16 val)
>  {
> -	int ret;
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct ade7854_state *st = iio_priv(indio_dev);
> -	struct spi_transfer xfer = {
> -		.tx_buf = st->tx,
> -		.bits_per_word = 8,
> -		.len = 5,
> -	};
> -
> -	mutex_lock(&st->buf_lock);
> -	st->tx[0] = ADE7854_WRITE_REG;
> -	st->tx[1] = (reg_address >> 8) & 0xFF;
> -	st->tx[2] = reg_address & 0xFF;
> -	st->tx[3] = (val >> 8) & 0xFF;
> -	st->tx[4] = val & 0xFF;
> -
> -	ret = spi_sync_transfer(st->spi, &xfer, 1);
> -	mutex_unlock(&st->buf_lock);
> -
> -	return ret;
> +	return ade7854_spi_write_reg(dev, reg_address, val, DATA_SIZE_16_BITS);
>  }
>  
>  static int ade7854_spi_write_reg_24(struct device *dev,
>  				    u16 reg_address,
>  				    u32 val)
>  {
> -	int ret;
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct ade7854_state *st = iio_priv(indio_dev);
> -	struct spi_transfer xfer = {
> -		.tx_buf = st->tx,
> -		.bits_per_word = 8,
> -		.len = 6,
> -	};
> -
> -	mutex_lock(&st->buf_lock);
> -	st->tx[0] = ADE7854_WRITE_REG;
> -	st->tx[1] = (reg_address >> 8) & 0xFF;
> -	st->tx[2] = reg_address & 0xFF;
> -	st->tx[3] = (val >> 16) & 0xFF;
> -	st->tx[4] = (val >> 8) & 0xFF;
> -	st->tx[5] = val & 0xFF;
> -
> -	ret = spi_sync_transfer(st->spi, &xfer, 1);
> -	mutex_unlock(&st->buf_lock);
> -
> -	return ret;
> +	return ade7854_spi_write_reg(dev, reg_address, val, DATA_SIZE_24_BITS);
>  }
>  
>  static int ade7854_spi_write_reg_32(struct device *dev,
>  				    u16 reg_address,
>  				    u32 val)
>  {
> -	int ret;
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct ade7854_state *st = iio_priv(indio_dev);
> -	struct spi_transfer xfer = {
> -		.tx_buf = st->tx,
> -		.bits_per_word = 8,
> -		.len = 7,
> -	};
> -
> -	mutex_lock(&st->buf_lock);
> -	st->tx[0] = ADE7854_WRITE_REG;
> -	st->tx[1] = (reg_address >> 8) & 0xFF;
> -	st->tx[2] = reg_address & 0xFF;
> -	st->tx[3] = (val >> 24) & 0xFF;
> -	st->tx[4] = (val >> 16) & 0xFF;
> -	st->tx[5] = (val >> 8) & 0xFF;
> -	st->tx[6] = val & 0xFF;
> -
> -	ret = spi_sync_transfer(st->spi, &xfer, 1);
> -	mutex_unlock(&st->buf_lock);
> -
> -	return ret;
> +	return ade7854_spi_write_reg(dev, reg_address, val, DATA_SIZE_32_BITS);
>  }
>  
>  static int ade7854_spi_read_reg_8(struct device *dev,

