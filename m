Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751903AbeCXMlM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 24 Mar 2018 08:41:12 -0400
Date: Sat, 24 Mar 2018 12:41:06 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: John Syne <rodrigosiqueiramelo@gmail.com>
Cc: John Syne <john3909@gmail.com>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Barry Song <21cnbao@gmail.com>,
        daniel.baluta@nxp.com
Subject: Re: [PATCH v3 1/8] staging:iio:ade7854: Fix error handling on
 read/write
Message-ID: <20180324124106.61e636be@archlinux>
In-Reply-To: <a3f1f7cd5da77e13ee381b5c41d9a2956335a4b2.1521813782.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1521813782.git.rodrigosiqueiramelo@gmail.com>
        <a3f1f7cd5da77e13ee381b5c41d9a2956335a4b2.1521813782.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 23 Mar 2018 11:22:10 -0300
John Syne <rodrigosiqueiramelo@gmail.com> wrote:

> Fixes: correctly handle errors on the read and write operation for I2C
Please look at the Submitting patches documentation.  This is not
what a fixes tag is about!  I'll fix it up this time but please
look at it.
> 
> The original code does not correctly handle the error related to I2C
> read and write. This patch fixes the error handling related to all
> read/write functions for I2C.
> 
> Signed-off-by: John Syne <john3909@gmail.com>
> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Given this has been broken a long time I'm not going to push
this for stable.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
> Changes in v3:
>  - Clarify authorship
>  - Add Fixes tag in the commit message
> 
>  drivers/staging/iio/meter/ade7854-i2c.c | 24 ++++++++++++------------
>  drivers/staging/iio/meter/ade7854.c     | 10 +++++-----
>  2 files changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/staging/iio/meter/ade7854-i2c.c b/drivers/staging/iio/meter/ade7854-i2c.c
> index 317e4f0d8176..4437f1e33261 100644
> --- a/drivers/staging/iio/meter/ade7854-i2c.c
> +++ b/drivers/staging/iio/meter/ade7854-i2c.c
> @@ -31,7 +31,7 @@ static int ade7854_i2c_write_reg_8(struct device *dev,
>  	ret = i2c_master_send(st->i2c, st->tx, 3);
>  	mutex_unlock(&st->buf_lock);
>  
> -	return ret;
> +	return ret < 0 ? ret : 0;
>  }
>  
>  static int ade7854_i2c_write_reg_16(struct device *dev,
> @@ -51,7 +51,7 @@ static int ade7854_i2c_write_reg_16(struct device *dev,
>  	ret = i2c_master_send(st->i2c, st->tx, 4);
>  	mutex_unlock(&st->buf_lock);
>  
> -	return ret;
> +	return ret < 0 ? ret : 0;
>  }
>  
>  static int ade7854_i2c_write_reg_24(struct device *dev,
> @@ -72,7 +72,7 @@ static int ade7854_i2c_write_reg_24(struct device *dev,
>  	ret = i2c_master_send(st->i2c, st->tx, 5);
>  	mutex_unlock(&st->buf_lock);
>  
> -	return ret;
> +	return ret < 0 ? ret : 0;
>  }
>  
>  static int ade7854_i2c_write_reg_32(struct device *dev,
> @@ -94,7 +94,7 @@ static int ade7854_i2c_write_reg_32(struct device *dev,
>  	ret = i2c_master_send(st->i2c, st->tx, 6);
>  	mutex_unlock(&st->buf_lock);
>  
> -	return ret;
> +	return ret < 0 ? ret : 0;
>  }
>  
>  static int ade7854_i2c_read_reg_8(struct device *dev,
> @@ -110,11 +110,11 @@ static int ade7854_i2c_read_reg_8(struct device *dev,
>  	st->tx[1] = reg_address & 0xFF;
>  
>  	ret = i2c_master_send(st->i2c, st->tx, 2);
> -	if (ret)
> +	if (ret < 0)
>  		goto out;
>  
>  	ret = i2c_master_recv(st->i2c, st->rx, 1);
> -	if (ret)
> +	if (ret < 0)
>  		goto out;
>  
>  	*val = st->rx[0];
> @@ -136,11 +136,11 @@ static int ade7854_i2c_read_reg_16(struct device *dev,
>  	st->tx[1] = reg_address & 0xFF;
>  
>  	ret = i2c_master_send(st->i2c, st->tx, 2);
> -	if (ret)
> +	if (ret < 0)
>  		goto out;
>  
>  	ret = i2c_master_recv(st->i2c, st->rx, 2);
> -	if (ret)
> +	if (ret < 0)
>  		goto out;
>  
>  	*val = (st->rx[0] << 8) | st->rx[1];
> @@ -162,11 +162,11 @@ static int ade7854_i2c_read_reg_24(struct device *dev,
>  	st->tx[1] = reg_address & 0xFF;
>  
>  	ret = i2c_master_send(st->i2c, st->tx, 2);
> -	if (ret)
> +	if (ret < 0)
>  		goto out;
>  
>  	ret = i2c_master_recv(st->i2c, st->rx, 3);
> -	if (ret)
> +	if (ret < 0)
>  		goto out;
>  
>  	*val = (st->rx[0] << 16) | (st->rx[1] << 8) | st->rx[2];
> @@ -188,11 +188,11 @@ static int ade7854_i2c_read_reg_32(struct device *dev,
>  	st->tx[1] = reg_address & 0xFF;
>  
>  	ret = i2c_master_send(st->i2c, st->tx, 2);
> -	if (ret)
> +	if (ret < 0)
>  		goto out;
>  
>  	ret = i2c_master_recv(st->i2c, st->rx, 3);
> -	if (ret)
> +	if (ret < 0)
>  		goto out;
>  
>  	*val = (st->rx[0] << 24) | (st->rx[1] << 16) |
> diff --git a/drivers/staging/iio/meter/ade7854.c b/drivers/staging/iio/meter/ade7854.c
> index 90d07cdca4b8..0193ae3aae29 100644
> --- a/drivers/staging/iio/meter/ade7854.c
> +++ b/drivers/staging/iio/meter/ade7854.c
> @@ -33,7 +33,7 @@ static ssize_t ade7854_read_8bit(struct device *dev,
>  	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>  
>  	ret = st->read_reg_8(dev, this_attr->address, &val);
> -	if (ret)
> +	if (ret < 0)
>  		return ret;
>  
>  	return sprintf(buf, "%u\n", val);
> @@ -50,7 +50,7 @@ static ssize_t ade7854_read_16bit(struct device *dev,
>  	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>  
>  	ret = st->read_reg_16(dev, this_attr->address, &val);
> -	if (ret)
> +	if (ret < 0)
>  		return ret;
>  
>  	return sprintf(buf, "%u\n", val);
> @@ -67,7 +67,7 @@ static ssize_t ade7854_read_24bit(struct device *dev,
>  	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>  
>  	ret = st->read_reg_24(dev, this_attr->address, &val);
> -	if (ret)
> +	if (ret < 0)
>  		return ret;
>  
>  	return sprintf(buf, "%u\n", val);
> @@ -84,7 +84,7 @@ static ssize_t ade7854_read_32bit(struct device *dev,
>  	struct ade7854_state *st = iio_priv(indio_dev);
>  
>  	ret = st->read_reg_32(dev, this_attr->address, &val);
> -	if (ret)
> +	if (ret < 0)
>  		return ret;
>  
>  	return sprintf(buf, "%u\n", val);
> @@ -416,7 +416,7 @@ static int ade7854_set_irq(struct device *dev, bool enable)
>  	u32 irqen;
>  
>  	ret = st->read_reg_32(dev, ADE7854_MASK0, &irqen);
> -	if (ret)
> +	if (ret < 0)
>  		return ret;
>  
>  	if (enable)

