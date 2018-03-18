Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752092AbeCRKA6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 18 Mar 2018 06:00:58 -0400
Date: Sun, 18 Mar 2018 10:00:52 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc: John Syne <john3909@gmail.com>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Barry Song <21cnbao@gmail.com>,
        daniel.baluta@nxp.com
Subject: Re: [PATCH v2 6/8] staging:iio:ade7854: Rework I2C read function
Message-ID: <20180318100052.36b6311b@archlinux>
In-Reply-To: <1d0edf1a515e71b0198cb76ed6ec679f85ba2127.1521239766.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1521239766.git.rodrigosiqueiramelo@gmail.com>
        <1d0edf1a515e71b0198cb76ed6ec679f85ba2127.1521239766.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 16 Mar 2018 19:49:59 -0300
Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com> wrote:

> The read operation for the I2C function has many duplications that can
> be generalized into a single function. This patch reworks the read
> operation for I2C to centralizes all similar code in a single function.
> Part of the rework includes a proper error handling and a fix on the
> i2c_master_recv for 32 bits as pointed by John Syne patches.
This seems likely to have been covered by the earlier patch. Please update
the description.

Otherwise same define comment but beyond that looks good.

Jonathan

> 
> It is possible to remove all the old interface to use the new one,
> however, for keeping the things simple and working this patch maintain
> legacy interface.
> 
> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> Signed-off-by: John Syne <john3909@gmail.com>
> ---
>  drivers/staging/iio/meter/ade7854-i2c.c | 110 ++++++++++++--------------------
>  1 file changed, 41 insertions(+), 69 deletions(-)
> 
> diff --git a/drivers/staging/iio/meter/ade7854-i2c.c b/drivers/staging/iio/meter/ade7854-i2c.c
> index e95147a1bac1..20db8eedb84a 100644
> --- a/drivers/staging/iio/meter/ade7854-i2c.c
> +++ b/drivers/staging/iio/meter/ade7854-i2c.c
> @@ -65,9 +65,10 @@ static int ade7854_i2c_write_reg(struct device *dev,
>  	return ret < 0 ? ret : 0;
>  }
>  
> -static int ade7854_i2c_read_reg_8(struct device *dev,
> -				  u16 reg_address,
> -				  u8 *val)
> +static int ade7854_i2c_read_reg(struct device *dev,
> +				u16 reg_address,
> +				u32 *val,
> +				int bytes)
>  {
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct ade7854_state *st = iio_priv(indio_dev);
> @@ -79,95 +80,66 @@ static int ade7854_i2c_read_reg_8(struct device *dev,
>  
>  	ret = i2c_master_send(st->i2c, st->tx, 2);
>  	if (ret < 0)
> -		goto out;
> +		goto unlock;
>  
> -	ret = i2c_master_recv(st->i2c, st->rx, 1);
> +	ret = i2c_master_recv(st->i2c, st->rx, bytes);
>  	if (ret < 0)
> -		goto out;
> +		goto unlock;
> +
> +	switch (bytes) {
> +	case DATA_SIZE_8_BITS:
> +		*val = st->rx[0];
> +		break;
> +	case DATA_SIZE_16_BITS:
> +		*val = (st->rx[0] << 8) | st->rx[1];
> +		break;
> +	case DATA_SIZE_24_BITS:
> +		*val = (st->rx[0] << 16) | (st->rx[1] << 8) | st->rx[2];
> +		break;
> +	case DATA_SIZE_32_BITS:
> +		*val = (st->rx[0] << 24) | (st->rx[1] << 16) |
> +			(st->rx[2] << 8) | st->rx[3];
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		goto unlock;
> +	}
>  
> -	*val = st->rx[0];
> -out:
> +unlock:
>  	mutex_unlock(&st->buf_lock);
>  	return ret;
>  }
>  
> +static int ade7854_i2c_read_reg_8(struct device *dev,
> +				  u16 reg_address,
> +				  u8 *val)
> +{
> +	return ade7854_i2c_read_reg(dev, reg_address, (u32 *)val,
> +				    DATA_SIZE_8_BITS);
> +}
> +
>  static int ade7854_i2c_read_reg_16(struct device *dev,
>  				   u16 reg_address,
>  				   u16 *val)
>  {
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct ade7854_state *st = iio_priv(indio_dev);
> -	int ret;
> -
> -	mutex_lock(&st->buf_lock);
> -	st->tx[0] = (reg_address >> 8) & 0xFF;
> -	st->tx[1] = reg_address & 0xFF;
> -
> -	ret = i2c_master_send(st->i2c, st->tx, 2);
> -	if (ret < 0)
> -		goto out;
> -
> -	ret = i2c_master_recv(st->i2c, st->rx, 2);
> -	if (ret < 0)
> -		goto out;
> -
> -	*val = (st->rx[0] << 8) | st->rx[1];
> -out:
> -	mutex_unlock(&st->buf_lock);
> -	return ret;
> +	return ade7854_i2c_read_reg(dev, reg_address, (u32 *)val,
> +				    DATA_SIZE_16_BITS);
>  }
>  
>  static int ade7854_i2c_read_reg_24(struct device *dev,
>  				   u16 reg_address,
>  				   u32 *val)
>  {
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct ade7854_state *st = iio_priv(indio_dev);
> -	int ret;
> -
> -	mutex_lock(&st->buf_lock);
> -	st->tx[0] = (reg_address >> 8) & 0xFF;
> -	st->tx[1] = reg_address & 0xFF;
> -
> -	ret = i2c_master_send(st->i2c, st->tx, 2);
> -	if (ret < 0)
> -		goto out;
> -
> -	ret = i2c_master_recv(st->i2c, st->rx, 3);
> -	if (ret < 0)
> -		goto out;
> -
> -	*val = (st->rx[0] << 16) | (st->rx[1] << 8) | st->rx[2];
> -out:
> -	mutex_unlock(&st->buf_lock);
> -	return ret;
> +	return ade7854_i2c_read_reg(dev, reg_address, (u32 *)val,
> +				    DATA_SIZE_24_BITS);
>  }
>  
>  static int ade7854_i2c_read_reg_32(struct device *dev,
>  				   u16 reg_address,
>  				   u32 *val)
>  {
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct ade7854_state *st = iio_priv(indio_dev);
> -	int ret;
> -
> -	mutex_lock(&st->buf_lock);
> -	st->tx[0] = (reg_address >> 8) & 0xFF;
> -	st->tx[1] = reg_address & 0xFF;
> -
> -	ret = i2c_master_send(st->i2c, st->tx, 2);
> -	if (ret < 0)
> -		goto out;
> -
> -	ret = i2c_master_recv(st->i2c, st->rx, 4);
> -	if (ret < 0)
> -		goto out;
> -
> -	*val = (st->rx[0] << 24) | (st->rx[1] << 16) |
> -		(st->rx[2] << 8) | st->rx[3];
> -out:
> -	mutex_unlock(&st->buf_lock);
> -	return ret;
> +	return ade7854_i2c_read_reg(dev, reg_address, (u32 *)val,
> +				    DATA_SIZE_32_BITS);
>  }
>  
>  static int ade7854_i2c_probe(struct i2c_client *client,

