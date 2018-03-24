Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751894AbeCXN2i (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 24 Mar 2018 09:28:38 -0400
Date: Sat, 24 Mar 2018 13:28:32 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc: John Syne <john3909@gmail.com>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Barry Song <21cnbao@gmail.com>,
        daniel.baluta@nxp.com
Subject: Re: [PATCH v3 7/8] staging:iio:ade7854: Rework SPI read function
Message-ID: <20180324132832.4de33872@archlinux>
In-Reply-To: <960df20b2a51e6517e9ccef2b5486ee116f35ba4.1521813782.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1521813782.git.rodrigosiqueiramelo@gmail.com>
        <960df20b2a51e6517e9ccef2b5486ee116f35ba4.1521813782.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 23 Mar 2018 11:27:12 -0300
Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com> wrote:

> Rework read SPI function to reduce the code duplication and centralizes
> all the task in a single function.
> 
> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
> Changes in v3:
>  - Remove the use of defines that not improve the readability
>  - Replace variable name "bytes" for "bits"
>  - Update commit message
> 
>  drivers/staging/iio/meter/ade7854-spi.c | 136 ++++++++------------------------
>  1 file changed, 33 insertions(+), 103 deletions(-)
> 
> diff --git a/drivers/staging/iio/meter/ade7854-spi.c b/drivers/staging/iio/meter/ade7854-spi.c
> index be7397042850..ee6e4d166ece 100644
> --- a/drivers/staging/iio/meter/ade7854-spi.c
> +++ b/drivers/staging/iio/meter/ade7854-spi.c
> @@ -67,9 +67,10 @@ static int ade7854_spi_write_reg(struct device *dev,
>  	return ret;
>  }
>  
> -static int ade7854_spi_read_reg_8(struct device *dev,
> -				  u16 reg_address,
> -				  u8 *val)
> +static int ade7854_spi_read_reg(struct device *dev,
> +				u16 reg_address,
> +				u32 *val,
> +				int bits)
>  {
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct ade7854_state *st = iio_priv(indio_dev);
> @@ -82,7 +83,7 @@ static int ade7854_spi_read_reg_8(struct device *dev,
>  		}, {
>  			.rx_buf = st->rx,
>  			.bits_per_word = 8,
> -			.len = 1,
> +			.len = bits,
>  		}
>  	};
>  
> @@ -94,128 +95,57 @@ static int ade7854_spi_read_reg_8(struct device *dev,
>  
>  	ret = spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
>  	if (ret) {
> -		dev_err(&st->spi->dev, "problem when reading 8 bit register 0x%02X",
> +		dev_err(&st->spi->dev, "problem when reading register 0x%02X",
>  			reg_address);
> -		goto error_ret;
> +		goto unlock;
> +	}
> +
> +	switch (bits) {
> +	case 8:
> +		*val = st->rx[0];
> +		break;
> +	case 16:
> +		*val = be16_to_cpup((const __be16 *)st->rx);
> +		break;
> +	case 24:
> +		*val = (st->rx[0] << 16) | (st->rx[1] << 8) | st->rx[2];
> +		break;
> +	case 32:
> +		*val = be32_to_cpup((const __be32 *)st->rx);
> +		break;
>  	}
> -	*val = st->rx[0];
>  
> -error_ret:
> +unlock:
>  	mutex_unlock(&st->buf_lock);
>  	return ret;
>  }
>  
> +static int ade7854_spi_read_reg_8(struct device *dev,
> +				  u16 reg_address,
> +				  u8 *val)
> +{
> +	return ade7854_spi_read_reg(dev, reg_address, (u32 *)val, 8);
> +}
> +
>  static int ade7854_spi_read_reg_16(struct device *dev,
>  				   u16 reg_address,
>  				   u16 *val)
>  {
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct ade7854_state *st = iio_priv(indio_dev);
> -	int ret;
> -	struct spi_transfer xfers[] = {
> -		{
> -			.tx_buf = st->tx,
> -			.bits_per_word = 8,
> -			.len = 3,
> -		}, {
> -			.rx_buf = st->rx,
> -			.bits_per_word = 8,
> -			.len = 2,
> -		}
> -	};
> -
> -	mutex_lock(&st->buf_lock);
> -	st->tx[0] = ADE7854_READ_REG;
> -	st->tx[1] = (reg_address >> 8) & 0xFF;
> -	st->tx[2] = reg_address & 0xFF;
> -
> -	ret = spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
> -	if (ret) {
> -		dev_err(&st->spi->dev, "problem when reading 16 bit register 0x%02X",
> -			reg_address);
> -		goto error_ret;
> -	}
> -	*val = be16_to_cpup((const __be16 *)st->rx);
> -
> -error_ret:
> -	mutex_unlock(&st->buf_lock);
> -	return ret;
> +	return ade7854_spi_read_reg(dev, reg_address, (u32 *)val, 16);
>  }
>  
>  static int ade7854_spi_read_reg_24(struct device *dev,
>  				   u16 reg_address,
>  				   u32 *val)
>  {
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct ade7854_state *st = iio_priv(indio_dev);
> -	int ret;
> -	struct spi_transfer xfers[] = {
> -		{
> -			.tx_buf = st->tx,
> -			.bits_per_word = 8,
> -			.len = 3,
> -		}, {
> -			.rx_buf = st->rx,
> -			.bits_per_word = 8,
> -			.len = 3,
> -		}
> -	};
> -
> -	mutex_lock(&st->buf_lock);
> -
> -	st->tx[0] = ADE7854_READ_REG;
> -	st->tx[1] = (reg_address >> 8) & 0xFF;
> -	st->tx[2] = reg_address & 0xFF;
> -
> -	ret = spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
> -	if (ret) {
> -		dev_err(&st->spi->dev, "problem when reading 24 bit register 0x%02X",
> -			reg_address);
> -		goto error_ret;
> -	}
> -	*val = (st->rx[0] << 16) | (st->rx[1] << 8) | st->rx[2];
> -
> -error_ret:
> -	mutex_unlock(&st->buf_lock);
> -	return ret;
> +	return ade7854_spi_read_reg(dev, reg_address, (u32 *)val, 24);
>  }
>  
>  static int ade7854_spi_read_reg_32(struct device *dev,
>  				   u16 reg_address,
>  				   u32 *val)
>  {
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct ade7854_state *st = iio_priv(indio_dev);
> -	int ret;
> -	struct spi_transfer xfers[] = {
> -		{
> -			.tx_buf = st->tx,
> -			.bits_per_word = 8,
> -			.len = 3,
> -		}, {
> -			.rx_buf = st->rx,
> -			.bits_per_word = 8,
> -			.len = 4,
> -		}
> -	};
> -
> -	mutex_lock(&st->buf_lock);
> -
> -	st->tx[0] = ADE7854_READ_REG;
> -	st->tx[1] = (reg_address >> 8) & 0xFF;
> -	st->tx[2] = reg_address & 0xFF;
> -
> -	ret = spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
> -	if (ret) {
> -		dev_err(&st->spi->dev, "problem when reading 32 bit register 0x%02X",
> -			reg_address);
> -		goto error_ret;
> -	}
> -	*val = be32_to_cpup((const __be32 *)st->rx);
> -
> -error_ret:
> -	mutex_unlock(&st->buf_lock);
> -	return ret;
> +	return ade7854_spi_read_reg(dev, reg_address, (u32 *)val, 32);
>  }
>  
>  static int ade7854_spi_probe(struct spi_device *spi)

