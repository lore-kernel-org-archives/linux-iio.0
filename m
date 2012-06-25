Return-Path: <jic23@kernel.org>
Message-ID: <4FE8C790.5020305@kernel.org>
Date: Mon, 25 Jun 2012 21:18:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio:dac:ad5064: Add support for the ad5629r and ad5669r
References: <1340630285-11591-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1340630285-11591-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 06/25/2012 02:18 PM, Lars-Peter Clausen wrote:
> The ad5629r and ad5669r are the I2C variants of the ad5628 and ad5668. Since the
> ad5064 driver currently only supports SPI based devices the major part of this
> patch focuses on adding support for I2C based devices. Adding support for the
> actual parts boils down to adding entries for them to the device id table.

Nasty lack of null termination in the i2c_device_id table. Other than
that a few nitpicks.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  drivers/iio/dac/Kconfig  |    2 +-
>  drivers/iio/dac/ad5064.c |  198 +++++++++++++++++++++++++++++++++++++++-------
>  2 files changed, 169 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index 92fb3a0..da44ec9 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -5,7 +5,7 @@ menu "Digital to analog converters"
>  
>  config AD5064
>  	tristate "Analog Devices AD5064/64-1/65/44/45/24/25, AD5628/48/66/68 DAC driver"
> -	depends on SPI
> +	depends on (SPI || I2C)
A bit inconsistent at the driver depends on the more specific
SPI_MASTER. Perhaps worth updating that here as it is explicit in the
driver (admittedly the number of slave only spi running kernels is going
to be rather few!)
>  	help
>  	  Say yes here to build support for Analog Devices AD5024, AD5025, AD5044,
>  	  AD5045, AD5064, AD5064-1, AD5065, AD5628, AD5648, AD5666, AD5668 Digital
> diff --git a/drivers/iio/dac/ad5064.c b/drivers/iio/dac/ad5064.c
> index 276af02..10d38b6 100644
> --- a/drivers/iio/dac/ad5064.c
> +++ b/drivers/iio/dac/ad5064.c
> @@ -1,6 +1,6 @@
>  /*
> - * AD5024, AD5025, AD5044, AD5045, AD5064, AD5064-1, AD5065, AD5628, AD5648,
> - * AD5666, AD5668 Digital to analog converters driver
> + * AD5024, AD5025, AD5044, AD5045, AD5064, AD5064-1, AD5065, AD5628, AD5629R,
> + * AD5648, AD5666, AD5668, AD5669R Digital to analog converters driver
>   *
>   * Copyright 2011 Analog Devices Inc.
>   *
> @@ -12,9 +12,11 @@
>  #include <linux/module.h>
>  #include <linux/kernel.h>
>  #include <linux/spi/spi.h>
> +#include <linux/i2c.h>
>  #include <linux/slab.h>
>  #include <linux/sysfs.h>
>  #include <linux/regulator/consumer.h>
> +#include <asm/unaligned.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> @@ -62,9 +64,14 @@ struct ad5064_chip_info {
>  	unsigned int num_channels;
>  };
>  
> +struct ad5064_state;
> +
> +typedef int (*ad5064_write_func)(struct ad5064_state *st, unsigned int cmd,
> +		unsigned int addr, unsigned int val);
> +
>  /**
>   * struct ad5064_state - driver instance specific data
> - * @spi:		spi_device
> + * @dev:		the device for this driver instance
>   * @chip_info:		chip model specific constants, available modes etc
>   * @vref_reg:		vref supply regulators
>   * @pwr_down:		whether channel is powered down
> @@ -72,11 +79,12 @@ struct ad5064_chip_info {
>   * @dac_cache:		current DAC raw value (chip does not support readback)
>   * @use_internal_vref:	set to true if the internal reference voltage should be
>   *			used.
> - * @data:		spi transfer buffers
> + * @write:		register write callback
> + * @data:		i2c/spi transfer buffers
>   */
>  
>  struct ad5064_state {
> -	struct spi_device		*spi;
> +	struct device *dev;
>  	const struct ad5064_chip_info	*chip_info;
>  	struct regulator_bulk_data	vref_reg[AD5064_MAX_VREFS];
>  	bool				pwr_down[AD5064_MAX_DAC_CHANNELS];
> @@ -84,11 +92,16 @@ struct ad5064_state {
>  	unsigned int			dac_cache[AD5064_MAX_DAC_CHANNELS];
>  	bool				use_internal_vref;
>  
> +	ad5064_write_func		write;
> +
>  	/*
>  	 * DMA (thus cache coherency maintenance) requires the
>  	 * transfer buffers to live in their own cache lines.
>  	 */
> -	__be32 data ____cacheline_aligned;
> +	union {
> +		u8 i2c[3];
> +		__be32 spi;
> +	} data ____cacheline_aligned;
>  };
>  
>  enum ad5064_type {
> @@ -109,14 +122,31 @@ enum ad5064_type {
>  	ID_AD5668_2,
>  };
>  
> +static int ad5064_i2c_write(struct ad5064_state *st, unsigned int cmd,
> +	unsigned int addr, unsigned int val)
> +{
> +	struct i2c_client *i2c = to_i2c_client(st->dev);
> +
> +	st->data.i2c[0] = (cmd << 4) | addr;
> +	put_unaligned_be16(val, &st->data.i2c[1]);
> +	return i2c_master_send(i2c, st->data.i2c, 3);
> +}
> +
>  static int ad5064_spi_write(struct ad5064_state *st, unsigned int cmd,
> +	unsigned int addr, unsigned int val)
> +{
> +	struct spi_device *spi = to_spi_device(st->dev);
> +
> +	st->data.spi = cpu_to_be32(AD5064_CMD(cmd) | AD5064_ADDR(addr) | val);
> +	return spi_write(spi, &st->data.spi, sizeof(st->data.spi));
> +}
> +
> +static int ad5064_write(struct ad5064_state *st, unsigned int cmd,
>  	unsigned int addr, unsigned int val, unsigned int shift)
>  {
>  	val <<= shift;
>  
> -	st->data = cpu_to_be32(AD5064_CMD(cmd) | AD5064_ADDR(addr) | val);
> -
> -	return spi_write(st->spi, &st->data, sizeof(st->data));
> +	return st->write(st, cmd, addr, val);
>  }
>  
>  static int ad5064_sync_powerdown_mode(struct ad5064_state *st,
> @@ -130,7 +160,7 @@ static int ad5064_sync_powerdown_mode(struct ad5064_state *st,
>  	if (st->pwr_down[channel])
>  		val |= st->pwr_down_mode[channel] << 8;
>  
> -	ret = ad5064_spi_write(st, AD5064_CMD_POWERDOWN_DAC, 0, val, 0);
> +	ret = ad5064_write(st, AD5064_CMD_POWERDOWN_DAC, 0, val, 0);
>  
>  	return ret;
>  }
> @@ -251,7 +281,7 @@ static int ad5064_write_raw(struct iio_dev *indio_dev,
>  			return -EINVAL;
>  
>  		mutex_lock(&indio_dev->mlock);
> -		ret = ad5064_spi_write(st, AD5064_CMD_WRITE_INPUT_N_UPDATE_N,
> +		ret = ad5064_write(st, AD5064_CMD_WRITE_INPUT_N_UPDATE_N,
>  				chan->address, val, chan->scan_type.shift);
>  		if (ret == 0)
>  			st->dac_cache[chan->channel] = val;
> @@ -413,9 +443,9 @@ static const char * const ad5064_vref_name(struct ad5064_state *st,
>  	return st->chip_info->shared_vref ? "vref" : ad5064_vref_names[vref];
>  }
>  
> -static int __devinit ad5064_probe(struct spi_device *spi)
> +static int __devinit ad5064_probe(struct device *dev, enum ad5064_type type,
> +	const char *name, ad5064_write_func write)
>  {
> -	enum ad5064_type type = spi_get_device_id(spi)->driver_data;
>  	struct iio_dev *indio_dev;
>  	struct ad5064_state *st;
>  	unsigned int i;
> @@ -426,24 +456,25 @@ static int __devinit ad5064_probe(struct spi_device *spi)
>  		return  -ENOMEM;
>  
>  	st = iio_priv(indio_dev);
> -	spi_set_drvdata(spi, indio_dev);
> +	dev_set_drvdata(dev, indio_dev);
>  
>  	st->chip_info = &ad5064_chip_info_tbl[type];
> -	st->spi = spi;
> +	st->dev = dev;
> +	st->write = write;
>  
>  	for (i = 0; i < ad5064_num_vref(st); ++i)
>  		st->vref_reg[i].supply = ad5064_vref_name(st, i);
>  
> -	ret = regulator_bulk_get(&st->spi->dev, ad5064_num_vref(st),
> +	ret = regulator_bulk_get(dev, ad5064_num_vref(st),
>  		st->vref_reg);
>  	if (ret) {
>  		if (!st->chip_info->internal_vref)
>  			goto error_free;
>  		st->use_internal_vref = true;
> -		ret = ad5064_spi_write(st, AD5064_CMD_CONFIG, 0,
> +		ret = ad5064_write(st, AD5064_CMD_CONFIG, 0,
>  			AD5064_CONFIG_INT_VREF_ENABLE, 0);
>  		if (ret) {
> -			dev_err(&spi->dev, "Failed to enable internal vref: %d\n",
> +			dev_err(dev, "Failed to enable internal vref: %d\n",
>  				ret);
>  			goto error_free;
>  		}
> @@ -458,8 +489,8 @@ static int __devinit ad5064_probe(struct spi_device *spi)
>  		st->dac_cache[i] = 0x8000;
>  	}
>  
> -	indio_dev->dev.parent = &spi->dev;
> -	indio_dev->name = spi_get_device_id(spi)->name;
> +	indio_dev->dev.parent = dev;
> +	indio_dev->name = name;
>  	indio_dev->info = &ad5064_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->channels = st->chip_info->channels;
> @@ -483,10 +514,9 @@ error_free:
>  	return ret;
>  }
>  
> -
> -static int __devexit ad5064_remove(struct spi_device *spi)
> +static int __devexit ad5064_remove(struct device *dev)
>  {
> -	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct ad5064_state *st = iio_priv(indio_dev);
>  
>  	iio_device_unregister(indio_dev);
> @@ -501,7 +531,22 @@ static int __devexit ad5064_remove(struct spi_device *spi)
>  	return 0;
>  }
>  
> -static const struct spi_device_id ad5064_id[] = {
> +#if IS_ENABLED(CONFIG_SPI_MASTER)
> +
> +static int __devinit ad5064_spi_probe(struct spi_device *spi)
> +{
> +	const struct spi_device_id *id = spi_get_device_id(spi);
> +
> +	return ad5064_probe(&spi->dev, id->driver_data, id->name,
> +				ad5064_spi_write);
> +}
> +
> +static int __devexit ad5064_spi_remove(struct spi_device *spi)
> +{
> +	return ad5064_remove(&spi->dev);
> +}
> +
> +static const struct spi_device_id ad5064_spi_ids[] = {
>  	{"ad5024", ID_AD5024},
>  	{"ad5025", ID_AD5025},
>  	{"ad5044", ID_AD5044},
> @@ -520,18 +565,111 @@ static const struct spi_device_id ad5064_id[] = {
>  	{"ad5668-3", ID_AD5668_2}, /* similar enough to ad5668-2 */
>  	{}
>  };
> -MODULE_DEVICE_TABLE(spi, ad5064_id);
> +MODULE_DEVICE_TABLE(spi, ad5064_spi_ids);
>  
> -static struct spi_driver ad5064_driver = {
> +static struct spi_driver ad5064_spi_driver = {
>  	.driver = {
>  		   .name = "ad5064",
>  		   .owner = THIS_MODULE,
>  	},
> -	.probe = ad5064_probe,
> -	.remove = __devexit_p(ad5064_remove),
> -	.id_table = ad5064_id,
> +	.probe = ad5064_spi_probe,
> +	.remove = __devexit_p(ad5064_spi_remove),
> +	.id_table = ad5064_spi_ids,
>  };
> -module_spi_driver(ad5064_driver);
> +
> +static inline int ad5064_spi_register_driver(void)
> +{
> +	return spi_register_driver(&ad5064_spi_driver);
> +}
> +
> +static inline void ad5064_spi_unregister_driver(void)
> +{
> +	spi_unregister_driver(&ad5064_spi_driver);
> +}
> +
> +#else
> +
> +static inline int ad5064_spi_register_driver(void) { return 0; }
> +static inline void ad5064_spi_unregister_driver(void) { }
> +
> +#endif
> +
> +#if IS_ENABLED(CONFIG_I2C)
> +
> +static int __devinit ad5064_i2c_probe(struct i2c_client *i2c,
> +	const struct i2c_device_id *id)
> +{
> +	return ad5064_probe(&i2c->dev, id->driver_data, id->name,
> +						ad5064_i2c_write);
> +}
> +
> +static int __devexit ad5064_i2c_remove(struct i2c_client *i2c)
> +{
> +	return ad5064_remove(&i2c->dev);
> +}
> +
> +static const struct i2c_device_id ad5064_i2c_ids[] = {
> +	{"ad5629-1", ID_AD5628_1},
> +	{"ad5629-2", ID_AD5628_2},
> +	{"ad5629-3", ID_AD5628_2}, /* similar enough to ad5629-2 */
> +	{"ad5669-1", ID_AD5668_1},
> +	{"ad5669-2", ID_AD5668_2},
> +	{"ad5669-3", ID_AD5668_2}, /* similar enough to ad5669-2 */
Must be null terminated.

Btw I didn't get that by hand. Got a message at the end
of build test
drivers/iio/dac/ad5064: struct i2c_device_id is 24 bytes.  The last of 6 is:
0x61 0x64 0x35 0x36 0x36 0x39 0x2d 0x33 0x00 0x00 0x00 0x00 0x00 0x00
0x00 0x00 0x00 0x00 0x00 0x00 0x0e 0x00 0x00 0x00
FATAL: drivers/iio/dac/ad5064: struct i2c_device_id is not terminated
with a NULL entry!


Not seen that one before!

> +};
> +MODULE_DEVICE_TABLE(i2c, ad5064_i2c_ids);
> +
> +static struct i2c_driver ad5064_i2c_driver = {
> +	.driver = {
> +		   .name = "ad5064",
> +		   .owner = THIS_MODULE,
> +	},
> +	.probe = ad5064_i2c_probe,
> +	.remove = __devexit_p(ad5064_i2c_remove),
> +	.id_table = ad5064_i2c_ids,
> +};
> +
> +static inline int ad5064_i2c_register_driver(void)
> +{
> +	return i2c_add_driver(&ad5064_i2c_driver);
> +}
> +
> +static inline void ad5064_i2c_unregister_driver(void)
> +{
> +	i2c_del_driver(&ad5064_i2c_driver);
> +}
> +
> +#else
> +
> +static inline int ad5064_i2c_register_driver(void) { return 0; }
> +static inline void ad5064_i2c_unregister_driver(void) { }
> +
> +#endif
> +
> +static int __init ad5064_spi_init(void)
> +{
> +	int ret;
> +
> +	ret = ad5064_spi_register_driver();
> +	if (ret)
> +		return ret;
> +
> +	ret = ad5064_i2c_register_driver();
> +	if (ret) {
> +		ad5064_spi_unregister_driver();
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +module_init(ad5064_spi_init);
> +
> +static void __exit ad5064_spi_exit(void)
> +{
> +	ad5064_i2c_unregister_driver();
> +	ad5064_spi_unregister_driver();
> +
> +}
> +module_exit(ad5064_spi_exit);
These are somewhat 'miss named' functions now. Just change them to
ad5064_init / exit/
>  
>  MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
>  MODULE_DESCRIPTION("Analog Devices AD5024/25/44/45/64/64-1/65, AD5628/48/66/68 DAC");
As you clearly are right not to add these new parts here (as it's
getting silly and grep will give this driver anyway) why not clean
this up to the old AD5024 and similar line that gets used all
over the place?
> 
