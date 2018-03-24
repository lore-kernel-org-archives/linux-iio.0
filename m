Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751894AbeCXN3b (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 24 Mar 2018 09:29:31 -0400
Date: Sat, 24 Mar 2018 13:29:25 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc: John Syne <john3909@gmail.com>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Barry Song <21cnbao@gmail.com>,
        daniel.baluta@nxp.com
Subject: Re: [PATCH v3 8/8] staging:iio:ade7854: Remove read_reg_*
 duplications
Message-ID: <20180324132925.0363b10e@archlinux>
In-Reply-To: <0af75d8bc519e2d8a38d62742fbf7de3c5899503.1521813782.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1521813782.git.rodrigosiqueiramelo@gmail.com>
        <0af75d8bc519e2d8a38d62742fbf7de3c5899503.1521813782.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 23 Mar 2018 11:27:27 -0300
Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com> wrote:

> The original code had a read function per data size; after updates, all
> read functions tasks were centralized in a single function, but the old
> signature was kept to maintain the module working without problems. This
> patch removes a set of duplications associated with read_reg_*, and
> update the areas that calling the old interface by the new one.
> 
> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Applied.  Note these probably won't go upstream until after the merge
window closes.  It's just possible Linus will decide to do an rc8, in which
case I might do another pull request to Greg, but probably not.

Jonathan

> ---
> Changes in v3:
>  - Update commit message
> 
>  drivers/staging/iio/meter/ade7854-i2c.c | 33 +------------------------------
>  drivers/staging/iio/meter/ade7854-spi.c | 35 ++-------------------------------
>  drivers/staging/iio/meter/ade7854.c     | 18 ++++++++---------
>  drivers/staging/iio/meter/ade7854.h     |  7 +++----
>  4 files changed, 15 insertions(+), 78 deletions(-)
> 
> diff --git a/drivers/staging/iio/meter/ade7854-i2c.c b/drivers/staging/iio/meter/ade7854-i2c.c
> index 63793f9664c7..c3aa6ea9d036 100644
> --- a/drivers/staging/iio/meter/ade7854-i2c.c
> +++ b/drivers/staging/iio/meter/ade7854-i2c.c
> @@ -110,34 +110,6 @@ static int ade7854_i2c_read_reg(struct device *dev,
>  	return ret;
>  }
>  
> -static int ade7854_i2c_read_reg_8(struct device *dev,
> -				  u16 reg_address,
> -				  u8 *val)
> -{
> -	return ade7854_i2c_read_reg(dev, reg_address, (u32 *)val, 8);
> -}
> -
> -static int ade7854_i2c_read_reg_16(struct device *dev,
> -				   u16 reg_address,
> -				   u16 *val)
> -{
> -	return ade7854_i2c_read_reg(dev, reg_address, (u32 *)val, 16);
> -}
> -
> -static int ade7854_i2c_read_reg_24(struct device *dev,
> -				   u16 reg_address,
> -				   u32 *val)
> -{
> -	return ade7854_i2c_read_reg(dev, reg_address, (u32 *)val, 24);
> -}
> -
> -static int ade7854_i2c_read_reg_32(struct device *dev,
> -				   u16 reg_address,
> -				   u32 *val)
> -{
> -	return ade7854_i2c_read_reg(dev, reg_address, (u32 *)val, 32);
> -}
> -
>  static int ade7854_i2c_probe(struct i2c_client *client,
>  			     const struct i2c_device_id *id)
>  {
> @@ -149,10 +121,7 @@ static int ade7854_i2c_probe(struct i2c_client *client,
>  		return -ENOMEM;
>  	st = iio_priv(indio_dev);
>  	i2c_set_clientdata(client, indio_dev);
> -	st->read_reg_8 = ade7854_i2c_read_reg_8;
> -	st->read_reg_16 = ade7854_i2c_read_reg_16;
> -	st->read_reg_24 = ade7854_i2c_read_reg_24;
> -	st->read_reg_32 = ade7854_i2c_read_reg_32;
> +	st->read_reg = ade7854_i2c_read_reg;
>  	st->write_reg = ade7854_i2c_write_reg;
>  	st->i2c = client;
>  	st->irq = client->irq;
> diff --git a/drivers/staging/iio/meter/ade7854-spi.c b/drivers/staging/iio/meter/ade7854-spi.c
> index ee6e4d166ece..fc9146757283 100644
> --- a/drivers/staging/iio/meter/ade7854-spi.c
> +++ b/drivers/staging/iio/meter/ade7854-spi.c
> @@ -94,7 +94,7 @@ static int ade7854_spi_read_reg(struct device *dev,
>  	st->tx[2] = reg_address & 0xFF;
>  
>  	ret = spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
> -	if (ret) {
> +	if (ret < 0) {
>  		dev_err(&st->spi->dev, "problem when reading register 0x%02X",
>  			reg_address);
>  		goto unlock;
> @@ -120,34 +120,6 @@ static int ade7854_spi_read_reg(struct device *dev,
>  	return ret;
>  }
>  
> -static int ade7854_spi_read_reg_8(struct device *dev,
> -				  u16 reg_address,
> -				  u8 *val)
> -{
> -	return ade7854_spi_read_reg(dev, reg_address, (u32 *)val, 8);
> -}
> -
> -static int ade7854_spi_read_reg_16(struct device *dev,
> -				   u16 reg_address,
> -				   u16 *val)
> -{
> -	return ade7854_spi_read_reg(dev, reg_address, (u32 *)val, 16);
> -}
> -
> -static int ade7854_spi_read_reg_24(struct device *dev,
> -				   u16 reg_address,
> -				   u32 *val)
> -{
> -	return ade7854_spi_read_reg(dev, reg_address, (u32 *)val, 24);
> -}
> -
> -static int ade7854_spi_read_reg_32(struct device *dev,
> -				   u16 reg_address,
> -				   u32 *val)
> -{
> -	return ade7854_spi_read_reg(dev, reg_address, (u32 *)val, 32);
> -}
> -
>  static int ade7854_spi_probe(struct spi_device *spi)
>  {
>  	struct ade7854_state *st;
> @@ -158,10 +130,7 @@ static int ade7854_spi_probe(struct spi_device *spi)
>  		return -ENOMEM;
>  	st = iio_priv(indio_dev);
>  	spi_set_drvdata(spi, indio_dev);
> -	st->read_reg_8 = ade7854_spi_read_reg_8;
> -	st->read_reg_16 = ade7854_spi_read_reg_16;
> -	st->read_reg_24 = ade7854_spi_read_reg_24;
> -	st->read_reg_32 = ade7854_spi_read_reg_32;
> +	st->read_reg = ade7854_spi_read_reg;
>  	st->write_reg = ade7854_spi_write_reg;
>  	st->irq = spi->irq;
>  	st->spi = spi;
> diff --git a/drivers/staging/iio/meter/ade7854.c b/drivers/staging/iio/meter/ade7854.c
> index 45984b9a2bee..029c3bf42d4d 100644
> --- a/drivers/staging/iio/meter/ade7854.c
> +++ b/drivers/staging/iio/meter/ade7854.c
> @@ -27,12 +27,12 @@ static ssize_t ade7854_read_8bit(struct device *dev,
>  				 char *buf)
>  {
>  	int ret;
> -	u8 val = 0;
> +	u32 val = 0;
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct ade7854_state *st = iio_priv(indio_dev);
>  	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>  
> -	ret = st->read_reg_8(dev, this_attr->address, &val);
> +	ret = st->read_reg(dev, this_attr->address, &val, 8);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -44,12 +44,12 @@ static ssize_t ade7854_read_16bit(struct device *dev,
>  				  char *buf)
>  {
>  	int ret;
> -	u16 val = 0;
> +	u32 val = 0;
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct ade7854_state *st = iio_priv(indio_dev);
>  	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>  
> -	ret = st->read_reg_16(dev, this_attr->address, &val);
> +	ret = st->read_reg(dev, this_attr->address, &val, 16);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -66,7 +66,7 @@ static ssize_t ade7854_read_24bit(struct device *dev,
>  	struct ade7854_state *st = iio_priv(indio_dev);
>  	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>  
> -	ret = st->read_reg_24(dev, this_attr->address, &val);
> +	ret = st->read_reg(dev, this_attr->address, &val, 24);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -83,7 +83,7 @@ static ssize_t ade7854_read_32bit(struct device *dev,
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct ade7854_state *st = iio_priv(indio_dev);
>  
> -	ret = st->read_reg_32(dev, this_attr->address, &val);
> +	ret = st->read_reg(dev, this_attr->address, &val, 32);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -178,9 +178,9 @@ static int ade7854_reset(struct device *dev)
>  {
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct ade7854_state *st = iio_priv(indio_dev);
> -	u16 val;
> +	u32 val;
>  
> -	st->read_reg_16(dev, ADE7854_CONFIG, &val);
> +	st->read_reg(dev, ADE7854_CONFIG, &val, 16);
>  	val |= BIT(7); /* Software Chip Reset */
>  
>  	return st->write_reg(dev, ADE7854_CONFIG, val, 16);
> @@ -415,7 +415,7 @@ static int ade7854_set_irq(struct device *dev, bool enable)
>  	int ret;
>  	u32 irqen;
>  
> -	ret = st->read_reg_32(dev, ADE7854_MASK0, &irqen);
> +	ret = st->read_reg(dev, ADE7854_MASK0, &irqen, 32);
>  	if (ret < 0)
>  		return ret;
>  
> diff --git a/drivers/staging/iio/meter/ade7854.h b/drivers/staging/iio/meter/ade7854.h
> index 290adbf56951..a51e6e3183d3 100644
> --- a/drivers/staging/iio/meter/ade7854.h
> +++ b/drivers/staging/iio/meter/ade7854.h
> @@ -146,6 +146,7 @@
>  /**
>   * struct ade7854_state - device instance specific data
>   * @spi:		actual spi_device
> + * @read_reg		Wrapper function for I2C and SPI read
>   * @write_reg		Wrapper function for I2C and SPI write
>   * @indio_dev:		industrial I/O device structure
>   * @buf_lock:		mutex to protect tx and rx
> @@ -155,10 +156,8 @@
>  struct ade7854_state {
>  	struct spi_device *spi;
>  	struct i2c_client *i2c;
> -	int (*read_reg_8)(struct device *dev, u16 reg_address, u8 *val);
> -	int (*read_reg_16)(struct device *dev, u16 reg_address, u16 *val);
> -	int (*read_reg_24)(struct device *dev, u16 reg_address, u32 *val);
> -	int (*read_reg_32)(struct device *dev, u16 reg_address, u32 *val);
> +	int (*read_reg)(struct device *dev, u16 reg_address, u32 *val,
> +			int bits);
>  	int (*write_reg)(struct device *dev, u16 reg_address, u32 val,
>  			 int bits);
>  	int irq;

