Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751423AbeCRJ4K (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 18 Mar 2018 05:56:10 -0400
Date: Sun, 18 Mar 2018 09:56:04 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc: John Syne <john3909@gmail.com>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Barry Song <21cnbao@gmail.com>,
        daniel.baluta@nxp.com
Subject: Re: [PATCH v2 3/8] staging:iio:ade7854: Rework I2C write function
Message-ID: <20180318095604.72efed73@archlinux>
In-Reply-To: <d739c0eb2843e7b7d6251d6d805d3874e598cbcc.1521239766.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1521239766.git.rodrigosiqueiramelo@gmail.com>
        <d739c0eb2843e7b7d6251d6d805d3874e598cbcc.1521239766.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 16 Mar 2018 19:49:08 -0300
Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com> wrote:

> The write operation using I2C has many code duplications and four
> different interfaces per data size. This patch introduces a single
> function that centralizes the main tasks.
> 
> The central function inserted by this patch can easily replace all the
> four functions related to the data size. However, this patch does not
> remove any code signature for keeping the meter module work and make
> easier to review this patch.
> 
> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> ---
>  drivers/staging/iio/meter/ade7854-i2c.c | 96 ++++++++++++++++-----------------
>  drivers/staging/iio/meter/ade7854.h     |  7 +++
>  2 files changed, 53 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/staging/iio/meter/ade7854-i2c.c b/drivers/staging/iio/meter/ade7854-i2c.c
> index 37c957482493..1daad42b1e92 100644
> --- a/drivers/staging/iio/meter/ade7854-i2c.c
> +++ b/drivers/staging/iio/meter/ade7854-i2c.c
> @@ -15,86 +15,82 @@
>  #include <linux/iio/iio.h>
>  #include "ade7854.h"
>  
> -static int ade7854_i2c_write_reg_8(struct device *dev,
> -				   u16 reg_address,
> -				   u8 val)
> +static int ade7854_i2c_write_reg(struct device *dev,
> +				 u16 reg_address,
> +				 u32 val,
> +				 int bytes)
>  {
>  	int ret;
> +	int count;
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct ade7854_state *st = iio_priv(indio_dev);
>  
>  	mutex_lock(&st->buf_lock);
>  	st->tx[0] = (reg_address >> 8) & 0xFF;
>  	st->tx[1] = reg_address & 0xFF;
There are a lot of endian conversions in here, but as some aren't
standard sizes (24 bits) and others are unaligned which makes things
messy, perhaps we are better doing it 'long hand' like this.

> -	st->tx[2] = val;
>  
> -	ret = i2c_master_send(st->i2c, st->tx, 3);
> +	switch (bytes) {
> +	case DATA_SIZE_8_BITS:

The defines really don't help here.  These are real numbers
so have them as such.

> +		st->tx[2] = val & 0xFF;
> +		count = 3;
> +		break;
> +	case DATA_SIZE_16_BITS:
> +		st->tx[2] = (val >> 8) & 0xFF;
> +		st->tx[3] = val & 0xFF;
> +		count = 4;
> +		break;
> +	case DATA_SIZE_24_BITS:
> +		st->tx[2] = (val >> 16) & 0xFF;
> +		st->tx[3] = (val >> 8) & 0xFF;
> +		st->tx[4] = val & 0xFF;
> +		count = 5;
> +		break;
> +	case DATA_SIZE_32_BITS:
> +		st->tx[2] = (val >> 24) & 0xFF;
> +		st->tx[3] = (val >> 16) & 0xFF;
> +		st->tx[4] = (val >> 8) & 0xFF;
> +		st->tx[5] = val & 0xFF;
> +		count = 6;
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		goto unlock;
> +	}
> +
> +	ret = i2c_master_send(st->i2c, st->tx, count);
> +
> +unlock:
>  	mutex_unlock(&st->buf_lock);
>  
>  	return ret < 0 ? ret : 0;
>  }
>  
> +static int ade7854_i2c_write_reg_8(struct device *dev,
> +				   u16 reg_address,
> +				   u8 val)
> +{
> +	return ade7854_i2c_write_reg(dev, reg_address, val, DATA_SIZE_8_BITS);
> +}
> +
>  static int ade7854_i2c_write_reg_16(struct device *dev,
>  				    u16 reg_address,
>  				    u16 val)
>  {
> -	int ret;
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct ade7854_state *st = iio_priv(indio_dev);
> -
> -	mutex_lock(&st->buf_lock);
> -	st->tx[0] = (reg_address >> 8) & 0xFF;
> -	st->tx[1] = reg_address & 0xFF;
> -	st->tx[2] = (val >> 8) & 0xFF;
> -	st->tx[3] = val & 0xFF;
> -
> -	ret = i2c_master_send(st->i2c, st->tx, 4);
> -	mutex_unlock(&st->buf_lock);
> -
> -	return ret < 0 ? ret : 0;
> +	return ade7854_i2c_write_reg(dev, reg_address, val, DATA_SIZE_16_BITS);
>  }
>  
>  static int ade7854_i2c_write_reg_24(struct device *dev,
>  				    u16 reg_address,
>  				    u32 val)
>  {
> -	int ret;
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct ade7854_state *st = iio_priv(indio_dev);
> -
> -	mutex_lock(&st->buf_lock);
> -	st->tx[0] = (reg_address >> 8) & 0xFF;
> -	st->tx[1] = reg_address & 0xFF;
> -	st->tx[2] = (val >> 16) & 0xFF;
> -	st->tx[3] = (val >> 8) & 0xFF;
> -	st->tx[4] = val & 0xFF;
> -
> -	ret = i2c_master_send(st->i2c, st->tx, 5);
> -	mutex_unlock(&st->buf_lock);
> -
> -	return ret < 0 ? ret : 0;
> +	return ade7854_i2c_write_reg(dev, reg_address, val, DATA_SIZE_24_BITS);
>  }
>  
>  static int ade7854_i2c_write_reg_32(struct device *dev,
>  				    u16 reg_address,
>  				    u32 val)
>  {
> -	int ret;
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct ade7854_state *st = iio_priv(indio_dev);
> -
> -	mutex_lock(&st->buf_lock);
> -	st->tx[0] = (reg_address >> 8) & 0xFF;
> -	st->tx[1] = reg_address & 0xFF;
> -	st->tx[2] = (val >> 24) & 0xFF;
> -	st->tx[3] = (val >> 16) & 0xFF;
> -	st->tx[4] = (val >> 8) & 0xFF;
> -	st->tx[5] = val & 0xFF;
> -
> -	ret = i2c_master_send(st->i2c, st->tx, 6);
> -	mutex_unlock(&st->buf_lock);
> -
> -	return ret < 0 ? ret : 0;
> +	return ade7854_i2c_write_reg(dev, reg_address, val, DATA_SIZE_32_BITS);
>  }
>  
>  static int ade7854_i2c_read_reg_8(struct device *dev,
> diff --git a/drivers/staging/iio/meter/ade7854.h b/drivers/staging/iio/meter/ade7854.h
> index a82d38224cbd..71bdd638f348 100644
> --- a/drivers/staging/iio/meter/ade7854.h
> +++ b/drivers/staging/iio/meter/ade7854.h
> @@ -143,6 +143,13 @@
>  #define ADE7854_SPI_BURST	(u32)(1000 * 1000)
>  #define ADE7854_SPI_FAST	(u32)(2000 * 1000)
>  
> +enum data_size {
> +	DATA_SIZE_8_BITS = 1,
> +	DATA_SIZE_16_BITS,
> +	DATA_SIZE_24_BITS,
> +	DATA_SIZE_32_BITS,
> +};
Don't introduce this - these aren't magic numbers so they don't need
'names' to say what they are!

Jonathan
> +
>  /**
>   * struct ade7854_state - device instance specific data
>   * @spi:			actual spi_device

