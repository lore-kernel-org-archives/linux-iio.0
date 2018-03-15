Return-Path: <SRS0=dLTr=GF=oracle.com=dan.carpenter@kernel.org>
Date: Thu, 15 Mar 2018 15:06:07 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Barry Song <21cnbao@gmail.com>, John Syne <john3909@gmail.com>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        daniel.baluta@nxp.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] staging:iio:ade7854: Rework I2C write function
Message-ID: <20180315120607.cjp42wpii3soni6d@mwanda>
References: <cover.1521037060.git.rodrigosiqueiramelo@gmail.com>
 <98c74382f0ea9c5d33f7ea9c9697d87889c1baa2.1521037060.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <98c74382f0ea9c5d33f7ea9c9697d87889c1baa2.1521037060.git.rodrigosiqueiramelo@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

On Wed, Mar 14, 2018 at 03:10:18PM -0300, Rodrigo Siqueira wrote:
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
>  drivers/staging/iio/meter/ade7854-i2c.c | 89 +++++++++++++++++++--------------
>  drivers/staging/iio/meter/ade7854.h     |  7 +++
>  2 files changed, 58 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/staging/iio/meter/ade7854-i2c.c b/drivers/staging/iio/meter/ade7854-i2c.c
> index 317e4f0d8176..03133a05eae4 100644
> --- a/drivers/staging/iio/meter/ade7854-i2c.c
> +++ b/drivers/staging/iio/meter/ade7854-i2c.c
> @@ -15,41 +15,74 @@
>  #include <linux/iio/iio.h>
>  #include "ade7854.h"
>  
> -static int ade7854_i2c_write_reg_8(struct device *dev,
> -				   u16 reg_address,
> -				   u8 val)
> +static int ade7854_i2c_write_reg(struct device *dev,
> +				 u16 reg_address,
> +				 u32 val,
> +				 enum data_size type)


The data size should just be the number of bytes and not an enum.
1 means 1 byte / 8 bits.
2 means 2 bytes / 16 bits.
3 means 3 bytes / 24 bits.
etc.

>  {
>  	int ret;
> +	int count;
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct ade7854_state *st = iio_priv(indio_dev);
>  
>  	mutex_lock(&st->buf_lock);
>  	st->tx[0] = (reg_address >> 8) & 0xFF;
>  	st->tx[1] = reg_address & 0xFF;
> -	st->tx[2] = val;
>  
> -	ret = i2c_master_send(st->i2c, st->tx, 3);
> +	switch (type) {
> +	case DATA_SIZE_8_BITS:
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
> +		goto error_i2c_write_unlock;
> +	}
> +
> +	ret = i2c_master_send(st->i2c, st->tx, count);
> +
> +error_i2c_write_unlock:

These labels are sort of long.  And what does the "i2c_write" really
mean?  It should be obvious that we're not jumping to a different
function.

Just "unlock:" is OK as a label name.

>  	mutex_unlock(&st->buf_lock);
>  
>  	return ret;
>  }
>  
> +static int ade7854_i2c_write_reg_8(struct device *dev,
> +				   u16 reg_address,
> +				   u8 val)
> +{
> +	int ret;
> +
> +	ret = ade7854_i2c_write_reg(dev, reg_address, val, DATA_SIZE_8_BITS);
> +
> +	return ret;
> +}

Just do it like this:

static int ade7854_i2c_write_reg_8(struct device *dev, u16 reg_address, u8 val)
{
	return ade7854_i2c_write_reg(dev, reg_address, val, DATA_SIZE_8_BITS);
}



> +
>  static int ade7854_i2c_write_reg_16(struct device *dev,
>  				    u16 reg_address,
>  				    u16 val)
>  {
>  	int ret;
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct ade7854_state *st = iio_priv(indio_dev);
>  
> -	mutex_lock(&st->buf_lock);
> -	st->tx[0] = (reg_address >> 8) & 0xFF;
> -	st->tx[1] = reg_address & 0xFF;
> -	st->tx[2] = (val >> 8) & 0xFF;
> -	st->tx[3] = val & 0xFF;
> -
> -	ret = i2c_master_send(st->i2c, st->tx, 4);
> -	mutex_unlock(&st->buf_lock);
> +	ret = ade7854_i2c_write_reg(dev, reg_address, val, DATA_SIZE_16_BITS);
>  
>  	return ret;

Again:

	return ade7854_i2c_write_reg(dev, reg_address, val, DATA_SIZE_16_BITS);



>  }
> @@ -59,18 +92,8 @@ static int ade7854_i2c_write_reg_24(struct device *dev,
>  				    u32 val)
>  {
>  	int ret;
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct ade7854_state *st = iio_priv(indio_dev);
>  
> -	mutex_lock(&st->buf_lock);
> -	st->tx[0] = (reg_address >> 8) & 0xFF;
> -	st->tx[1] = reg_address & 0xFF;
> -	st->tx[2] = (val >> 16) & 0xFF;
> -	st->tx[3] = (val >> 8) & 0xFF;
> -	st->tx[4] = val & 0xFF;
> -
> -	ret = i2c_master_send(st->i2c, st->tx, 5);
> -	mutex_unlock(&st->buf_lock);
> +	ret = ade7854_i2c_write_reg(dev, reg_address, val, DATA_SIZE_24_BITS);
>  
>  	return ret;

Same.

>  }
> @@ -80,23 +103,13 @@ static int ade7854_i2c_write_reg_32(struct device *dev,
>  				    u32 val)
>  {
>  	int ret;
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
>  
> -	ret = i2c_master_send(st->i2c, st->tx, 6);
> -	mutex_unlock(&st->buf_lock);
> +	ret = ade7854_i2c_write_reg(dev, reg_address, val, DATA_SIZE_32_BITS);
>  
>  	return ret;

Same.

>  }
>  
> +

Checkpatch.pl will complain about this second blank line.

regards,
dan carpenter
