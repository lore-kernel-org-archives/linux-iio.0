Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53283 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752804AbcHUTtp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 21 Aug 2016 15:49:45 -0400
Subject: Re: [PATCH 07/17] iio: accel: kxsd9: Convert to use regmap for
 transport
To: Linus Walleij <linus.walleij@linaro.org>, linux-iio@vger.kernel.org
References: <1471354423-19186-1-git-send-email-linus.walleij@linaro.org>
 <1471354423-19186-8-git-send-email-linus.walleij@linaro.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <002c5853-d258-86c6-c1c5-2d02f8c23d8e@kernel.org>
Date: Sun, 21 Aug 2016 20:49:41 +0100
MIME-Version: 1.0
In-Reply-To: <1471354423-19186-8-git-send-email-linus.walleij@linaro.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 16/08/16 14:33, Linus Walleij wrote:
> This converts the KXSD9 driver to drop the custom transport
> mechanism and just use regmap like everything else.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Mostly fine, but we are dropping an explicit delay in the
read function. Which bothers me.  Even if I test this on
my board and it's fine (as the natural delay may well be
big enough) that's not say the device isn't on a quicker
spi bus somewhere else....

Jonathan
> ---
>  drivers/iio/accel/Kconfig     |  1 +
>  drivers/iio/accel/kxsd9-spi.c | 79 ++++++++++---------------------------------
>  drivers/iio/accel/kxsd9.c     | 40 +++++++++++++---------
>  drivers/iio/accel/kxsd9.h     | 22 +-----------
>  4 files changed, 43 insertions(+), 99 deletions(-)
> 
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index 95e3fc09f640..0ac316fbba38 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -108,6 +108,7 @@ config KXSD9_SPI
>  	depends on KXSD9
>  	depends on SPI
>  	default KXSD9
> +	select REGMAP_SPI
>  	help
>  	  Say yes here to enable the Kionix KXSD9 accelerometer
>  	  SPI transport channel.
> diff --git a/drivers/iio/accel/kxsd9-spi.c b/drivers/iio/accel/kxsd9-spi.c
> index 332b7664233e..04dbc6f94e7d 100644
> --- a/drivers/iio/accel/kxsd9-spi.c
> +++ b/drivers/iio/accel/kxsd9-spi.c
> @@ -3,75 +3,30 @@
>  #include <linux/spi/spi.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
> +#include <linux/regmap.h>
>  
>  #include "kxsd9.h"
>  
> -#define KXSD9_READ(a) (0x80 | (a))
> -#define KXSD9_WRITE(a) (a)
> -
> -static int kxsd9_spi_readreg(struct kxsd9_transport *tr, u8 address)
> -{
> -	struct spi_device *spi = tr->trdev;
> -
> -	return spi_w8r8(spi, KXSD9_READ(address));
> -}
> -
> -static int kxsd9_spi_writereg(struct kxsd9_transport *tr, u8 address, u8 val)
> -{
> -	struct spi_device *spi = tr->trdev;
> -
> -	tr->tx[0] = KXSD9_WRITE(address),
> -	tr->tx[1] = val;
> -	return spi_write(spi, tr->tx, 2);
> -}
> -
> -static int kxsd9_spi_readval(struct kxsd9_transport *tr, u8 address)
> -{
> -	struct spi_device *spi = tr->trdev;
> -	struct spi_transfer xfers[] = {
> -		{
> -			.bits_per_word = 8,
> -			.len = 1,
> -			.delay_usecs = 200,
Dropping this explicit delay? 
> -			.tx_buf = tr->tx,
> -		}, {
> -			.bits_per_word = 8,
> -			.len = 2,
> -			.rx_buf = tr->rx,
> -		},
> -	};
> -	int ret;
> -
> -	tr->tx[0] = KXSD9_READ(address);
> -	ret = spi_sync_transfer(spi, xfers, ARRAY_SIZE(xfers));
> -	if (!ret)
> -		ret = (((u16)(tr->rx[0])) << 8) | (tr->rx[1]);
> -	return ret;
> -}
> -
>  static int kxsd9_spi_probe(struct spi_device *spi)
>  {
> -	struct kxsd9_transport *transport;
> -	int ret;
> -
> -	transport = devm_kzalloc(&spi->dev, sizeof(*transport), GFP_KERNEL);
> -	if (!transport)
> -		return -ENOMEM;
> +	static const struct regmap_config config = {
> +		.reg_bits = 8,
> +		.val_bits = 8,
> +		.max_register = 0x0e,
> +	};
> +	struct regmap *regmap;
>  
> -	transport->trdev = spi;
> -	transport->readreg = kxsd9_spi_readreg;
> -	transport->writereg = kxsd9_spi_writereg;
> -	transport->readval = kxsd9_spi_readval;
>  	spi->mode = SPI_MODE_0;
> -	spi_setup(spi);
> -
> -	ret = kxsd9_common_probe(&spi->dev,
> -				 transport,
> -				 spi_get_device_id(spi)->name);
> -	if (ret)
> -		return ret;
> -
> -	return 0;
> +	regmap = devm_regmap_init_spi(spi, &config);
> +	if (IS_ERR(regmap)) {
> +		dev_err(&spi->dev, "%s: regmap allocation failed: %ld\n",
> +			__func__, PTR_ERR(regmap));
> +		return PTR_ERR(regmap);
> +	}
> +
> +	return kxsd9_common_probe(&spi->dev,
> +				  regmap,
> +				  spi_get_device_id(spi)->name);
>  }
>  
>  static const struct spi_device_id kxsd9_spi_id[] = {
> diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
> index 7c94a0d3464a..fe85f61cfa9d 100644
> --- a/drivers/iio/accel/kxsd9.c
> +++ b/drivers/iio/accel/kxsd9.c
> @@ -21,7 +21,7 @@
>  #include <linux/sysfs.h>
>  #include <linux/slab.h>
>  #include <linux/module.h>
> -
> +#include <linux/regmap.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  
> @@ -47,7 +47,7 @@
>   * @tx:		single tx buffer storage
>   **/
>  struct kxsd9_state {
> -	struct kxsd9_transport *transport;
> +	struct regmap *map;
>  	struct mutex buf_lock;
>  };
>  
> @@ -64,6 +64,7 @@ static int kxsd9_write_scale(struct iio_dev *indio_dev, int micro)
>  	int ret, i;
>  	struct kxsd9_state *st = iio_priv(indio_dev);
>  	bool foundit = false;
> +	unsigned int val;
>  
>  	for (i = 0; i < 4; i++)
>  		if (micro == kxsd9_micro_scales[i]) {
> @@ -74,13 +75,14 @@ static int kxsd9_write_scale(struct iio_dev *indio_dev, int micro)
>  		return -EINVAL;
>  
>  	mutex_lock(&st->buf_lock);
> -	ret = st->transport->readreg(st->transport,
> -				     KXSD9_REG_CTRL_C);
> +	ret = regmap_read(st->map,
> +			  KXSD9_REG_CTRL_C,
> +			  &val);
>  	if (ret < 0)
>  		goto error_ret;
> -	ret = st->transport->writereg(st->transport,
> -				      KXSD9_REG_CTRL_C,
> -				      (ret & ~KXSD9_FS_MASK) | i);
> +	ret = regmap_write(st->map,
> +			   KXSD9_REG_CTRL_C,
> +			   (val & ~KXSD9_FS_MASK) | i);
>  error_ret:
>  	mutex_unlock(&st->buf_lock);
>  	return ret;
> @@ -90,11 +92,15 @@ static int kxsd9_read(struct iio_dev *indio_dev, u8 address)
>  {
>  	int ret;
>  	struct kxsd9_state *st = iio_priv(indio_dev);
> +	__be16 raw_val;
>  
>  	mutex_lock(&st->buf_lock);
> -	ret = st->transport->readval(st->transport, address);
> +	ret = regmap_bulk_read(st->map, address, &raw_val, sizeof(raw_val));
> +	if (ret)
> +		goto out_fail_read;
>  	/* Only 12 bits are valid */
> -	ret &= 0xfff0;
> +	ret = be16_to_cpu(raw_val) & 0xfff0;
> +out_fail_read:
>  	mutex_unlock(&st->buf_lock);
>  	return ret;
>  }
> @@ -134,6 +140,7 @@ static int kxsd9_read_raw(struct iio_dev *indio_dev,
>  {
>  	int ret = -EINVAL;
>  	struct kxsd9_state *st = iio_priv(indio_dev);
> +	unsigned int regval;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> @@ -144,11 +151,12 @@ static int kxsd9_read_raw(struct iio_dev *indio_dev,
>  		ret = IIO_VAL_INT;
>  		break;
>  	case IIO_CHAN_INFO_SCALE:
> -		ret = st->transport->readreg(st->transport,
> -					     KXSD9_REG_CTRL_C);
> +		ret = regmap_read(st->map,
> +				  KXSD9_REG_CTRL_C,
> +				  &regval);
>  		if (ret < 0)
>  			goto error_ret;
> -		*val2 = kxsd9_micro_scales[ret & KXSD9_FS_MASK];
> +		*val2 = kxsd9_micro_scales[regval & KXSD9_FS_MASK];
>  		ret = IIO_VAL_INT_PLUS_MICRO;
>  		break;
>  	}
> @@ -184,10 +192,10 @@ static int kxsd9_power_up(struct kxsd9_state *st)
>  {
>  	int ret;
>  
> -	ret = st->transport->writereg(st->transport, KXSD9_REG_CTRL_B, 0x40);
> +	ret = regmap_write(st->map, KXSD9_REG_CTRL_B, 0x40);
>  	if (ret)
>  		return ret;
> -	return st->transport->writereg(st->transport, KXSD9_REG_CTRL_C, 0x9b);
> +	return regmap_write(st->map, KXSD9_REG_CTRL_C, 0x9b);
>  };
>  
>  static const struct iio_info kxsd9_info = {
> @@ -198,7 +206,7 @@ static const struct iio_info kxsd9_info = {
>  };
>  
>  int kxsd9_common_probe(struct device *parent,
> -		       struct kxsd9_transport *transport,
> +		       struct regmap *map,
>  		       const char *name)
>  {
>  	struct iio_dev *indio_dev;
> @@ -210,7 +218,7 @@ int kxsd9_common_probe(struct device *parent,
>  		return -ENOMEM;
>  
>  	st = iio_priv(indio_dev);
> -	st->transport = transport;
> +	st->map = map;
>  
>  	mutex_init(&st->buf_lock);
>  	indio_dev->channels = kxsd9_channels;
> diff --git a/drivers/iio/accel/kxsd9.h b/drivers/iio/accel/kxsd9.h
> index 32f86c9b33c7..ef3dbbf70b98 100644
> --- a/drivers/iio/accel/kxsd9.h
> +++ b/drivers/iio/accel/kxsd9.h
> @@ -4,26 +4,6 @@
>  #define KXSD9_STATE_RX_SIZE 2
>  #define KXSD9_STATE_TX_SIZE 2
>  
> -struct kxsd9_transport;
> -
> -/**
> - * struct kxsd9_transport - transport adapter for SPI or I2C
> - * @trdev: transport device such as SPI or I2C
> - * @readreg(): function to read a byte from an address in the device
> - * @writereg(): function to write a byte to an address in the device
> - * @readval(): function to read a 16bit value from the device
> - * @rx: cache aligned read buffer
> - * @tx: cache aligned write buffer
> - */
> -struct kxsd9_transport {
> -	void *trdev;
> -	int (*readreg) (struct kxsd9_transport *tr, u8 address);
> -	int (*writereg) (struct kxsd9_transport *tr, u8 address, u8 val);
> -	int (*readval) (struct kxsd9_transport *tr, u8 address);
> -	u8 rx[KXSD9_STATE_RX_SIZE] ____cacheline_aligned;
> -	u8 tx[KXSD9_STATE_TX_SIZE];
> -};
> -
>  int kxsd9_common_probe(struct device *parent,
> -		       struct kxsd9_transport *transport,
> +		       struct regmap *map,
>  		       const char *name);
> 

