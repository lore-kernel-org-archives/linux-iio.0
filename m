Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49788 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751606AbcDPTwl (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 16 Apr 2016 15:52:41 -0400
Subject: Re: [PATCH v5] iio: light: new driver for the ROHM BH1780
To: Linus Walleij <linus.walleij@linaro.org>, linux-iio@vger.kernel.org
References: <1460376724-7805-1-git-send-email-linus.walleij@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Daniel Mack <daniel@caiaq.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <57129805.6040707@kernel.org>
Date: Sat, 16 Apr 2016 20:52:37 +0100
MIME-Version: 1.0
In-Reply-To: <1460376724-7805-1-git-send-email-linus.walleij@linaro.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/04/16 13:12, Linus Walleij wrote:
> This is a reimplementation of the old misc device driver for the
> ROHM BH1780 ambient light sensor (drivers/misc/bh1780gli.c).
> 
> Differences from the old driver:
> - Uses the IIO framework
> - Uses runtime PM to idle the hardware after 5 seconds
> - No weird custom power management from userspace
> - No homebrewn values in sysfs
> 
> This uses the same (undocumented) device tree compatible-string
> as the old driver ("rohm,bh1780gli").
Fancy documenting it?
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Daniel Mack <daniel@caiaq.de>
> Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Two comments inline. As trivial to sort out I'll do it during applying
to save us going through another spin!

Applied to the togreg branch of iio.git - initially pushed out as testing
for the autobuilders to try and break it.

Thanks,

Jonathan
> ---
> ChangeLog v4->v5:
> - Make sure to power down the device also in the module .remove()
> - Augment state container to contain a proper pointer to the
>   indio device so it can be removed in .remove()
> - Use i2c_smbus_read_word_data() to read both LSB+MSB in
>   one swift transaction and return it back to IIO.
> ChangeLog v3->v4:
> - Set the system suspend PM ops to pm_force_[suspend|resume]
>   so we are in low power also in system suspend.
> - Error prints for failed I2C transactions in runtime
>   suspend/resume
> ChangeLog v2->v3:
> - Dropped the _scale information just returning "1" from
>   sysfs, userspace should assume scale by 1 if not present.
> - Dropped CC to maintainers who seemingly fell off the planet.
> ChangeLog v1->v2:
> - Use <linux/bitops.h>, BIT(), GENMASK()
> - Do not read state first when suspending.
> - Do not cast debug reg access return value.
> - Whitespace, comments.
> 
> I want to phase out the old misc driver, but don't know how that
> should properly be handled. The driver has an old (totally
> undocumented) sysfs ABI for raw measurements, should I add
> this as backward-compatibility and symlink the device to the old
> location?
> ---
>  drivers/iio/light/Kconfig  |  11 ++
>  drivers/iio/light/Makefile |   1 +
>  drivers/iio/light/bh1780.c | 298 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 310 insertions(+)
>  create mode 100644 drivers/iio/light/bh1780.c
> 
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index cfd3df8416bb..5ee1d453b3d8 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -73,6 +73,17 @@ config BH1750
>  	 To compile this driver as a module, choose M here: the module will
>  	 be called bh1750.
>  
> +config BH1780
> +	tristate "ROHM BH1780 ambient light sensor"
> +	depends on I2C
> +	depends on !SENSORS_BH1780
> +	help
> +	 Say Y here to build support for the ROHM BH1780GLI ambient
> +	 light sensor.
> +
> +	 To compile this driver as a module, choose M here: the module will
> +	 be called bh1780.
> +
>  config CM32181
>  	depends on I2C
>  	tristate "CM32181 driver"
> diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
> index b2c31053db0c..4aeee2bd8f49 100644
> --- a/drivers/iio/light/Makefile
> +++ b/drivers/iio/light/Makefile
> @@ -9,6 +9,7 @@ obj-$(CONFIG_AL3320A)		+= al3320a.o
>  obj-$(CONFIG_APDS9300)		+= apds9300.o
>  obj-$(CONFIG_APDS9960)		+= apds9960.o
>  obj-$(CONFIG_BH1750)		+= bh1750.o
> +obj-$(CONFIG_BH1780)		+= bh1780.o
>  obj-$(CONFIG_CM32181)		+= cm32181.o
>  obj-$(CONFIG_CM3232)		+= cm3232.o
>  obj-$(CONFIG_CM3323)		+= cm3323.o
> diff --git a/drivers/iio/light/bh1780.c b/drivers/iio/light/bh1780.c
> new file mode 100644
> index 000000000000..d78a3cf81551
> --- /dev/null
> +++ b/drivers/iio/light/bh1780.c
> @@ -0,0 +1,298 @@
> +/*
> + * ROHM 1780GLI Ambient Light Sensor Driver
> + *
> + * Copyright (C) 2016 Linaro Ltd.
> + * Author: Linus Walleij <linus.walleij@linaro.org>
> + * Loosely based on the previous BH1780 ALS misc driver
> + * Copyright (C) 2010 Texas Instruments
> + * Author: Hemanth V <hemanthv@ti.com>
> + */
> +#include <linux/i2c.h>
> +#include <linux/slab.h>
> +#include <linux/platform_device.h>
> +#include <linux/delay.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/bitops.h>
> +
> +#define BH1780_CMD_BIT		BIT(7)
> +#define BH1780_REG_CONTROL	0x00
> +#define BH1780_REG_PARTID	0x0A
> +#define BH1780_REG_MANFID	0x0B
> +#define BH1780_REG_DLOW		0x0C
> +#define BH1780_REG_DHIGH	0x0D
> +
> +#define BH1780_REVMASK		GENMASK(3,0)
> +#define BH1780_POWMASK		GENMASK(1,0)
> +#define BH1780_POFF		(0x0)
> +#define BH1780_PON		(0x3)
> +
> +/* power on settling time in ms */
> +#define BH1780_PON_DELAY	2
> +/* max time before value available in ms */
> +#define BH1780_INTERVAL		250
> +
> +struct bh1780_data {
> +	struct i2c_client *client;
> +	struct iio_dev *indio_dev;
> +};
> +
> +static int bh1780_write(struct bh1780_data *bh1780, u8 reg, u8 val)
> +{
> +	int ret = i2c_smbus_write_byte_data(bh1780->client,
> +					    BH1780_CMD_BIT | reg,
> +					    val);
> +	if (ret < 0)
> +		dev_err(&bh1780->client->dev,
> +			"i2c_smbus_write_byte_data failed error "
> +			"%d, register %01x\n",
> +			ret, reg);
> +	return ret;
> +}
> +
> +static int bh1780_read(struct bh1780_data *bh1780, u8 reg)
> +{
> +	int ret = i2c_smbus_read_byte_data(bh1780->client,
> +					   BH1780_CMD_BIT | reg);
> +	if (ret < 0)
> +		dev_err(&bh1780->client->dev,
> +			"i2c_smbus_read_byte_data failed error "
> +			"%d, register %01x\n",
> +			ret, reg);
> +	return ret;
> +}
> +
> +static int bh1780_read_word(struct bh1780_data *bh1780, u8 reg)
> +{
> +	int ret = i2c_smbus_read_word_data(bh1780->client,
> +					   BH1780_CMD_BIT | reg);
> +	if (ret < 0)
> +		dev_err(&bh1780->client->dev,
> +			"i2c_smbus_read_word_data failed error "
> +			"%d, register %01x\n",
> +			ret, reg);
> +	return ret;
> +}
> +
static
> +int bh1780_debugfs_reg_access(struct iio_dev *indio_dev,
> +			      unsigned int reg, unsigned int writeval,
> +			      unsigned int *readval)
> +{
> +	struct bh1780_data *bh1780 = iio_priv(indio_dev);
> +	int ret;
> +
> +	if (!readval)
> +		bh1780_write(bh1780, (u8)reg, (u8)writeval);
> +
> +	ret = bh1780_read(bh1780, (u8)reg);
> +	if (ret < 0)
> +		return ret;
> +
> +	*readval = ret;
> +
> +	return 0;
> +}
> +
> +static int bh1780_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan,
> +			   int *val, int *val2, long mask)
> +{
> +	struct bh1780_data *bh1780 = iio_priv(indio_dev);
> +	int value;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		switch (chan->type) {
> +		case IIO_LIGHT:
> +			pm_runtime_get_sync(&bh1780->client->dev);
> +			value = bh1780_read_word(bh1780, BH1780_REG_DLOW);
> +			if (value < 0)
> +				return value;
> +			pm_runtime_mark_last_busy(&bh1780->client->dev);
> +			pm_runtime_put_autosuspend(&bh1780->client->dev);
> +			*val = value;
> +
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_INT_TIME:
> +		*val = 0;
> +		*val2 = BH1780_INTERVAL * 1000;
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info bh1780_info = {
> +	.driver_module = THIS_MODULE,
> +	.read_raw = bh1780_read_raw,
> +	.debugfs_reg_access = bh1780_debugfs_reg_access,
> +};
> +
> +static const struct iio_chan_spec bh1780_channels[] = {
> +	{
> +		.type = IIO_LIGHT,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_INT_TIME)
> +	}
> +};
> +
> +static int bh1780_probe(struct i2c_client *client,
> +			const struct i2c_device_id *id)
> +{
> +	int ret;
> +	struct bh1780_data *bh1780;
> +	struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
> +	struct iio_dev *indio_dev;
> +
> +	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE))
> +		return -EIO;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*bh1780));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	bh1780 = iio_priv(indio_dev);
> +	bh1780->client = client;
> +	bh1780->indio_dev = indio_dev;
> +	i2c_set_clientdata(client, bh1780);

Given the bh1780 structure is already easily obtained from the struct iio_dev
flip this around and do what most drivers in IIO do and
i2c_set_clientdata(client, bh1780) thus removing the need to have a pointer
to the iio_dev in struct bh1780_data.

> +
> +	/* Power up the device */
> +	ret = bh1780_write(bh1780, BH1780_REG_CONTROL, BH1780_PON);
> +	if (ret < 0)
> +		return ret;
> +	msleep(BH1780_PON_DELAY);
> +	pm_runtime_get_noresume(&client->dev);
> +	pm_runtime_set_active(&client->dev);
> +	pm_runtime_enable(&client->dev);
> +
> +	ret = bh1780_read(bh1780, BH1780_REG_PARTID);
> +	if (ret < 0)
> +		goto out_disable_pm;
> +	dev_info(&client->dev,
> +		 "Ambient Light Sensor, Rev : %lu\n",
> +		 (ret & BH1780_REVMASK));
> +
> +	/*
> +	 * As the device takes 250 ms to even come up with a fresh
> +	 * measurement after power-on, do not shut it down unnecessarily.
> +	 * Set autosuspend to a five seconds.
> +	 */
> +	pm_runtime_set_autosuspend_delay(&client->dev, 5000);
> +	pm_runtime_use_autosuspend(&client->dev);
> +	pm_runtime_put(&client->dev);
> +
> +	indio_dev->dev.parent = &client->dev;
> +	indio_dev->info = &bh1780_info;
> +	indio_dev->name = id->name;
> +	indio_dev->channels = bh1780_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(bh1780_channels);
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret)
> +		goto out_disable_pm;
> +	return 0;
> +
> +out_disable_pm:
> +	pm_runtime_put_noidle(&client->dev);
> +	pm_runtime_disable(&client->dev);
> +	return ret;
> +}
> +
> +static int bh1780_remove(struct i2c_client *client)
> +{
> +	struct bh1780_data *bh1780 = i2c_get_clientdata(client);
> +	int ret;
> +
> +	iio_device_unregister(bh1780->indio_dev);
> +	pm_runtime_get_sync(&client->dev);
> +	pm_runtime_put_noidle(&client->dev);
> +	pm_runtime_disable(&client->dev);
> +	ret = bh1780_write(bh1780, BH1780_REG_CONTROL, BH1780_POFF);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "failed to power off\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM
> +static int bh1780_runtime_suspend(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct bh1780_data *bh1780 = i2c_get_clientdata(client);
> +	int ret;
> +
> +	ret = bh1780_write(bh1780, BH1780_REG_CONTROL, BH1780_POFF);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to runtime suspend\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int bh1780_runtime_resume(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct bh1780_data *bh1780 = i2c_get_clientdata(client);
> +	int ret;
> +
> +	ret = bh1780_write(bh1780, BH1780_REG_CONTROL, BH1780_PON);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to runtime resume\n");
> +		return ret;
> +	}
> +
> +	/* Wait for power on, then for a value to be available */
> +	msleep(BH1780_PON_DELAY + BH1780_INTERVAL);
> +
> +	return 0;
> +}
> +#endif /* CONFIG_PM */
> +
> +static const struct dev_pm_ops bh1780_dev_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> +				pm_runtime_force_resume)
> +	SET_RUNTIME_PM_OPS(bh1780_runtime_suspend,
> +			   bh1780_runtime_resume, NULL)
> +};
> +
> +static const struct i2c_device_id bh1780_id[] = {
> +	{ "bh1780", 0 },
> +	{ },
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, bh1780_id);
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id of_bh1780_match[] = {
> +	{ .compatible = "rohm,bh1780gli", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, of_bh1780_match);
> +#endif
> +
> +static struct i2c_driver bh1780_driver = {
> +	.probe		= bh1780_probe,
> +	.remove		= bh1780_remove,
> +	.id_table	= bh1780_id,
> +	.driver = {
> +		.name = "bh1780",
> +		.pm = &bh1780_dev_pm_ops,
> +		.of_match_table = of_match_ptr(of_bh1780_match),
> +	},
> +};
> +
> +module_i2c_driver(bh1780_driver);
> +
> +MODULE_DESCRIPTION("ROHM BH1780GLI Ambient Light Sensor Driver");
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Linus Walleij <linus.walleij@linaro.org>");
> 

