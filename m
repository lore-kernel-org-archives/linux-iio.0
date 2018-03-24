Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751891AbeCXNZo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 24 Mar 2018 09:25:44 -0400
Date: Sat, 24 Mar 2018 13:25:38 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc: John Syne <john3909@gmail.com>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Barry Song <21cnbao@gmail.com>,
        daniel.baluta@nxp.com
Subject: Re: [PATCH v3 4/8] staging:iio:ade7854: Rework SPI write function
Message-ID: <20180324132538.0e5cdfeb@archlinux>
In-Reply-To: <23ef49f070426f277ea6883c68c2de94978210f1.1521813782.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1521813782.git.rodrigosiqueiramelo@gmail.com>
        <23ef49f070426f277ea6883c68c2de94978210f1.1521813782.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 23 Mar 2018 11:26:25 -0300
Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com> wrote:

> The write operation using SPI has a many code duplications (similar to
> I2C) and four different interfaces per data size. This patch introduces
> a single function that centralizes the main task related to SPI.
> 
> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Applied.

Thanks,

Jonathan

> ---
> Changes in v3:
>  - Remove the use of defines that not improve the readability
>  - Replace variable name "bytes" for "bits"
> 
>  drivers/staging/iio/meter/ade7854-spi.c | 108 ++++++++++++--------------------
>  1 file changed, 41 insertions(+), 67 deletions(-)
> 
> diff --git a/drivers/staging/iio/meter/ade7854-spi.c b/drivers/staging/iio/meter/ade7854-spi.c
> index 4419b8f06197..9c5c16c4d6e0 100644
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
> +				 int bits)
>  {
>  	int ret;
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> @@ -32,93 +33,66 @@ static int ade7854_spi_write_reg_8(struct device *dev,
>  	st->tx[0] = ADE7854_WRITE_REG;
>  	st->tx[1] = (reg_address >> 8) & 0xFF;
>  	st->tx[2] = reg_address & 0xFF;
> -	st->tx[3] = val & 0xFF;
> +	switch (bits) {
> +	case 8:
> +		st->tx[3] = val & 0xFF;
> +		break;
> +	case 16:
> +		xfer.len = 5;
> +		st->tx[3] = (val >> 8) & 0xFF;
> +		st->tx[4] = val & 0xFF;
> +		break;
> +	case 24:
> +		xfer.len = 6;
> +		st->tx[3] = (val >> 16) & 0xFF;
> +		st->tx[4] = (val >> 8) & 0xFF;
> +		st->tx[5] = val & 0xFF;
> +		break;
> +	case 32:
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
> +	return ade7854_spi_write_reg(dev, reg_address, val, 8);
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
> +	return ade7854_spi_write_reg(dev, reg_address, val, 16);
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
> +	return ade7854_spi_write_reg(dev, reg_address, val, 24);
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
> +	return ade7854_spi_write_reg(dev, reg_address, val, 32);
>  }
>  
>  static int ade7854_spi_read_reg_8(struct device *dev,

