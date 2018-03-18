Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752499AbeCRJpr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 18 Mar 2018 05:45:47 -0400
Date: Sun, 18 Mar 2018 09:45:41 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc: John Syne <john3909@gmail.com>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Barry Song <21cnbao@gmail.com>,
        daniel.baluta@nxp.com
Subject: Re: [PATCH v2 1/8] staging:iio:ade7854: Fix error handling on
 read/write
Message-ID: <20180318094541.24331a00@archlinux>
In-Reply-To: <c6329504bb92726dd1ca45cd5b44e180e86a407e.1521239766.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1521239766.git.rodrigosiqueiramelo@gmail.com>
        <c6329504bb92726dd1ca45cd5b44e180e86a407e.1521239766.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 16 Mar 2018 19:48:33 -0300
Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com> wrote:

> The original code does not correctly handle the error related to I2C
> read and write. This patch fixes the error handling related to all
> read/write functions for I2C. This patch is an adaptation of the John
> Syne patches.
> 
> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> Signed-off-by: John Syne <john3909@gmail.com>
Hi Rodrigo,

I'm not sure what the chain of authorship was here.  If this is fundamentally
John's original patch he should still be the author and his sign off should be
first.  You then sign off afterwards to indicate that you 'handled' the patch
and believe the work to be John's (you are trusting his sign off).  This
is 'fun' legal stuff - read the docs on developers certificate of origin.

If the patch has changed 'enough' (where that is a fuzzy definition)
then you should as you have here take the authorship, but John's sign off is
no longer true (it's a different patch).  If John has reviewed the code
it is fine to have a reviewed-by or acked-by from John there to reflect
that.

Anyhow, please clarify the situation as I shouldn't take a patch where
I'm applying my sign-off without knowing the origins etc.

> ---
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
So for write cases you are flattening to 0 for good and < 0 for bad.
good.
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
But in read cases you are returning the number of bytes read...
Given these functions can know the 'right' answer to that why not check
it here and do the same as for writes in return 0 for good and < 0 for
bad?
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
If you did as discussed above with the reads then this change would not
be needed and all the changes would be confined to the i2c code.

Thanks,

Jonathan


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

