Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750925AbdJNR2m (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 14 Oct 2017 13:28:42 -0400
Date: Sat, 14 Oct 2017 18:28:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: proximity: Add rfd77402 driver
Message-ID: <20171014182838.54b6ae41@archlinux>
In-Reply-To: <20171010134847.2175-2-pmeerw@pmeerw.net>
References: <20171010134847.2175-1-pmeerw@pmeerw.net>
        <20171010134847.2175-2-pmeerw@pmeerw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 10 Oct 2017 15:48:47 +0200
Peter Meerwald-Stadler <pmeerw@pmeerw.net> wrote:

> Driver for RF Digital RFD77402 VCSEL (vertical-cavity surface-emitting
> laser) Time-of-Flight (ToF) sensor to measure distance up to 2 m with
> millimeter precision
> 
> Signed-off-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>

Nice little driver - given all the comments I had were trivial, I
have fixed them up whilst applying.

Applied with minor changes to the togreg branch of iio.git and pushed
out as testing for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/proximity/Kconfig    |  10 ++
>  drivers/iio/proximity/Makefile   |   1 +
>  drivers/iio/proximity/rfd77402.c | 350 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 361 insertions(+)
>  create mode 100644 drivers/iio/proximity/rfd77402.c
> 
> diff --git a/drivers/iio/proximity/Kconfig b/drivers/iio/proximity/Kconfig
> index ae070950f920..fcb1c4ba5e41 100644
> --- a/drivers/iio/proximity/Kconfig
> +++ b/drivers/iio/proximity/Kconfig
> @@ -32,6 +32,16 @@ config LIDAR_LITE_V2
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called pulsedlight-lite-v2
>  
> +config RFD77402
> +	tristate "RFD77402 ToF sensor"
> +	depends on I2C
> +	help
> +	  Say Y to build a driver for the RFD77420 Time-of-Flight (distance)
> +	  sensor module with I2C interface.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called rfd77402.
> +
>  config SRF04
>  	tristate "Devantech SRF04 ultrasonic ranger sensor"
>  	depends on GPIOLIB
> diff --git a/drivers/iio/proximity/Makefile b/drivers/iio/proximity/Makefile
> index ed1b6f4cc209..1b195d84c611 100644
> --- a/drivers/iio/proximity/Makefile
> +++ b/drivers/iio/proximity/Makefile
> @@ -5,6 +5,7 @@
>  # When adding new entries keep the list in alphabetical order
>  obj-$(CONFIG_AS3935)		+= as3935.o
>  obj-$(CONFIG_LIDAR_LITE_V2)	+= pulsedlight-lidar-lite-v2.o
> +obj-$(CONFIG_RFD77402)		+= rfd77402.o
>  obj-$(CONFIG_SRF04)		+= srf04.o
>  obj-$(CONFIG_SRF08)		+= srf08.o
>  obj-$(CONFIG_SX9500)		+= sx9500.o
> diff --git a/drivers/iio/proximity/rfd77402.c b/drivers/iio/proximity/rfd77402.c
> new file mode 100644
> index 000000000000..8fa82eafc877
> --- /dev/null
> +++ b/drivers/iio/proximity/rfd77402.c
> @@ -0,0 +1,350 @@
> +
> +/*
> + * rfd77402.c - Support for RF Digital RFD77402 Time-of-Flight (distance) sensor
> + *
> + * Copyright 2017 Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> + *
> + * This file is subject to the terms and conditions of version 2 of
> + * the GNU General Public License.  See the file COPYING in the main
> + * directory of this archive for more details.
> + *
> + * 7-bit I2C slave address 0x4c
> + *
> + * TODO: interrupt
> + * https://media.digikey.com/pdf/Data%20Sheets/RF%20Digital%20PDFs/RFD77402.pdf
> + */
> +
> +#include <linux/module.h>
> +#include <linux/i2c.h>
> +#include <linux/delay.h>
> +
> +#include <linux/iio/iio.h>
> +
> +#define RFD77402_DRV_NAME "rfd77402"
> +
> +#define RFD77402_ICSR		0x00 /* Interrupt Control Status Register */
> +#define RFD77402_ICSR_INT_MODE	BIT(2)
> +#define RFD77402_ICSR_INT_POL	BIT(3)
> +#define RFD77402_ICSR_RESULT	BIT(4)
> +#define RFD77402_ICSR_M2H_MSG	BIT(5)
> +#define RFD77402_ICSR_H2M_MSG	BIT(6)
> +#define RFD77402_ICSR_RESET	BIT(7)
> +
> +#define RFD77402_CMD_R		0x04
> +#define RFD77402_CMD_SINGLE	0x01
> +#define RFD77402_CMD_STANDBY	0x10
> +#define RFD77402_CMD_MCPU_OFF	0x11
> +#define RFD77402_CMD_MCPU_ON	0x12
> +#define RFD77402_CMD_RESET	BIT(6)
> +#define RFD77402_CMD_VALID	BIT(7)
> +
> +#define RFD77402_STATUS_R	0x06
> +#define RFD77402_STATUS_PM_MASK	GENMASK(4, 0)
> +#define RFD77402_STATUS_STANDBY	0x00
> +#define RFD77402_STATUS_MCPU_OFF	0x10
> +#define RFD77402_STATUS_MCPU_ON	0x18
> +
> +#define RFD77402_RESULT_R	0x08
> +#define RFD77402_RESULT_DIST_MASK	GENMASK(12, 2)
> +#define RFD77402_RESULT_ERR_MASK	GENMASK(14, 13)
> +#define RFD77402_RESULT_VALID	BIT(15)
> +
> +#define RFD77402_PMU_CFG	0x14
> +#define RFD77402_PMU_MCPU_INIT	BIT(9)
> +
> +#define RFD77402_I2C_INIT_CFG	0x1c
> +#define RFD77402_I2C_ADDR_INCR	BIT(0)
> +#define RFD77402_I2C_DATA_INCR	BIT(2)
> +#define RFD77402_I2C_HOST_DEBUG	BIT(5)
> +#define RFD77402_I2C_MCPU_DEBUG	BIT(6)
> +
> +#define RFD77402_CMD_CFGR_A	0x0c
> +#define RFD77402_CMD_CFGR_B	0x0e
> +#define RFD77402_HFCFG_0	0x20
> +#define RFD77402_HFCFG_1	0x22
> +#define RFD77402_HFCFG_2	0x24
> +#define RFD77402_HFCFG_3	0x26
> +
> +#define RFD77402_MOD_CHIP_ID	0x28
> +
> +/* magic configuration values from datasheet */
> +static const struct {
> +	u8 reg;
> +	u16 val;
> +} rf77402_tof_config[] = {
> +	{RFD77402_CMD_CFGR_A,	0xe100},
> +	{RFD77402_CMD_CFGR_B,	0x10ff},
> +	{RFD77402_HFCFG_0,	0x07d0},
> +	{RFD77402_HFCFG_1,	0x5008},
> +	{RFD77402_HFCFG_2,	0xa041},
> +	{RFD77402_HFCFG_3,	0x45d4},
> +};
> +
> +struct rfd77402_data {
> +	struct i2c_client *client;
> +	struct mutex lock;

Check patch moans and in this case I think it is right - needs a comment.
'Serialize reads from the sensor' will do the job.

> +};
> +
> +static const struct iio_chan_spec rfd77402_channels[] = {
> +	{
> +		.type = IIO_DISTANCE,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE),
> +	},
> +};
> +
> +static int rfd77402_set_state(struct rfd77402_data *data, u8 state, u16 check)
> +{
> +	int ret;
> +
> +	ret = i2c_smbus_write_byte_data(data->client, RFD77402_CMD_R,
> +		state | RFD77402_CMD_VALID);
> +	if (ret < 0)
> +		return ret;
> +
> +	usleep_range(10000, 20000);
> +
> +	ret = i2c_smbus_read_word_data(data->client, RFD77402_STATUS_R);
> +	if (ret < 0)
> +		return ret;
> +	if ((ret & RFD77402_STATUS_PM_MASK) != check)
> +		return -ENODEV;
> +
> +	return 0;
> +}
> +
> +static int rfd77402_measure(struct rfd77402_data *data)
> +{
> +	int ret;
> +	int tries = 10;
> +
> +	ret = rfd77402_set_state(data, RFD77402_CMD_MCPU_ON,
> +		RFD77402_STATUS_MCPU_ON);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = i2c_smbus_write_byte_data(data->client, RFD77402_CMD_R,
> +		RFD77402_CMD_SINGLE | RFD77402_CMD_VALID);
> +	if (ret < 0)
> +		goto err;
> +
> +	while (tries-- > 0) {
> +		ret = i2c_smbus_read_byte_data(data->client, RFD77402_ICSR);
> +		if (ret < 0)
> +			goto err;
> +		if (ret & RFD77402_ICSR_RESULT)
> +			break;
> +		msleep(20);
> +	}
> +
> +	if (tries < 0) {
> +		ret = -ETIMEDOUT;
> +		goto err;
> +	}
> +
> +	ret = i2c_smbus_read_word_data(data->client, RFD77402_RESULT_R);
> +	if (ret < 0)
> +		goto err;
> +
> +	if ((ret & RFD77402_RESULT_ERR_MASK) ||
> +		!(ret & RFD77402_RESULT_VALID)) {
> +		ret = -EIO;
> +		goto err;
> +	}
> +
> +	return (ret & RFD77402_RESULT_DIST_MASK) >> 2;
> +
> +err:
> +	rfd77402_set_state(data, RFD77402_CMD_MCPU_OFF,
> +			RFD77402_STATUS_MCPU_OFF);
> +	return ret;
> +}
> +
> +static int rfd77402_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int *val, int *val2, long mask)
> +{
> +	struct rfd77402_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		mutex_lock(&data->lock);
> +		ret = rfd77402_measure(data);
> +		mutex_unlock(&data->lock);
> +		if (ret < 0)
> +			return ret;
> +		*val = ret;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		/* 1 LSB is 1 mm */
> +		*val = 0;
> +		*val2 = 1000;
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info rfd77402_info = {
> +	.read_raw = rfd77402_read_raw,
> +};
> +
> +static int rfd77402_init(struct rfd77402_data *data)
> +{
> +	int ret, i;
> +
> +	ret = rfd77402_set_state(data, RFD77402_CMD_STANDBY,
> +		RFD77402_STATUS_STANDBY);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* configure INT pad as push-pull, active low */
> +	ret = i2c_smbus_write_byte_data(data->client, RFD77402_ICSR,
> +		RFD77402_ICSR_INT_MODE);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* I2C configuration */
> +	ret = i2c_smbus_write_word_data(data->client, RFD77402_I2C_INIT_CFG,
> +		RFD77402_I2C_ADDR_INCR | RFD77402_I2C_DATA_INCR |
> +		RFD77402_I2C_HOST_DEBUG	| RFD77402_I2C_MCPU_DEBUG);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* set initialization */
> +	ret = i2c_smbus_write_word_data(data->client, RFD77402_PMU_CFG, 0x0500);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = rfd77402_set_state(data, RFD77402_CMD_MCPU_OFF,
> +		RFD77402_STATUS_MCPU_OFF);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* set initialization */
> +	ret = i2c_smbus_write_word_data(data->client, RFD77402_PMU_CFG, 0x0600);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = rfd77402_set_state(data, RFD77402_CMD_MCPU_ON,
> +		RFD77402_STATUS_MCPU_ON);

Where sensible align with the opening bracket..

> +	if (ret < 0)
> +		return ret;
> +
> +	for (i = 0; i < ARRAY_SIZE(rf77402_tof_config); i++) {
> +		ret = i2c_smbus_write_word_data(data->client,
> +			rf77402_tof_config[i].reg, rf77402_tof_config[i].val);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	ret = rfd77402_set_state(data, RFD77402_CMD_STANDBY,
> +		RFD77402_STATUS_STANDBY);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;

return ret and loose the if above.

> +}
> +
> +static int rfd77402_powerdown(struct rfd77402_data *data)
> +{
> +	return rfd77402_set_state(data, RFD77402_CMD_STANDBY,
> +		RFD77402_STATUS_STANDBY);
> +}
> +
> +static int rfd77402_probe(struct i2c_client *client,
> +			  const struct i2c_device_id *id)
> +{
> +	struct rfd77402_data *data;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	ret = i2c_smbus_read_word_data(client, RFD77402_MOD_CHIP_ID);
> +	if (ret < 0)
> +		return ret;
> +	if (ret != 0xad01 && ret != 0xad02) /* known chip ids */
> +		return -ENODEV;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);
> +	data->client = client;
> +	mutex_init(&data->lock);
> +
> +	indio_dev->dev.parent = &client->dev;
> +	indio_dev->info = &rfd77402_info;
> +	indio_dev->channels = rfd77402_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(rfd77402_channels);
> +	indio_dev->name = RFD77402_DRV_NAME;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	ret = rfd77402_init(data);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret)
> +		goto err_powerdown;
> +
> +	return 0;
> +
> +err_powerdown:
> +	rfd77402_powerdown(data);
> +	return ret;
> +}
> +
> +static int rfd77402_remove(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +
> +	iio_device_unregister(indio_dev);
> +	rfd77402_powerdown(iio_priv(indio_dev));
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int rfd77402_suspend(struct device *dev)
> +{
> +	struct rfd77402_data *data = iio_priv(i2c_get_clientdata(
> +				     to_i2c_client(dev)));
ultimate nitpick - spacing inconsistent compared to resume below
that has a blank line here. 
> +	return rfd77402_powerdown(data);
> +}
> +
> +static int rfd77402_resume(struct device *dev)
> +{
> +	struct rfd77402_data *data = iio_priv(i2c_get_clientdata(
> +				     to_i2c_client(dev)));
> +
> +	return rfd77402_init(data);
> +}
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(rfd77402_pm_ops, rfd77402_suspend, rfd77402_resume);
> +
> +static const struct i2c_device_id rfd77402_id[] = {
> +	{ "rfd77402", 0},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, rfd77402_id);
> +
> +static struct i2c_driver rfd77402_driver = {
> +	.driver = {
> +		.name   = RFD77402_DRV_NAME,
> +		.pm     = &rfd77402_pm_ops,
> +	},
> +	.probe  = rfd77402_probe,
> +	.remove = rfd77402_remove,
> +	.id_table = rfd77402_id,
> +};
> +
> +module_i2c_driver(rfd77402_driver);
> +
> +MODULE_AUTHOR("Peter Meerwald-Stadler <pmeerw@pmeerw.net>");
> +MODULE_DESCRIPTION("RFD77402 Time-of-Flight sensor driver");
> +MODULE_LICENSE("GPL");
> +

