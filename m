Return-Path: <pmeerw@pmeerw.net>
Date: Wed, 19 Mar 2014 19:07:25 +0100 (CET)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Kevin Tsai <ktsai@capellamicro.com>
cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH V1 1/1] iio: add Capella cm3218x ambient light sensor
 driver.
In-Reply-To: <1395179466-15821-1-git-send-email-ktsai@capellamicro.com>
Message-ID: <alpine.DEB.2.01.1403191839450.3673@pmeerw.net>
References: <1395179466-15821-1-git-send-email-ktsai@capellamicro.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>


> Add Capella Microsystem CM3218x family Ambient Light Sensor IIO driver.
> This driver will convert raw data to lux value.  Default parameters are
> for reference only.  It will detect ACPI table to load per-system manufacturing
> parameters.

nitpicking below

> ---
>  .../devicetree/bindings/i2c/trivial-devices.txt    |   1 +
>  drivers/iio/light/Kconfig                          |  11 +
>  drivers/iio/light/Makefile                         |   1 +
>  drivers/iio/light/cm3218x.c                        | 769 +++++++++++++++++++++
>  4 files changed, 782 insertions(+)
>  create mode 100644 drivers/iio/light/cm3218x.c
> 
> diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> index 1a1ac2e..29e7eae 100644
> --- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> +++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> @@ -17,6 +17,7 @@ at,24c08		i2c serial eeprom  (24cxx)
>  atmel,24c02		i2c serial eeprom  (24cxx)
>  atmel,at97sc3204t	i2c trusted platform module (TPM)
>  capella,cm32181		CM32181: Ambient Light Sensor
> +capella,cm3218x		CM3218x: Ambient Light Sensor
>  catalyst,24c32		i2c serial eeprom
>  dallas,ds1307		64 x 8, Serial, I2C Real-Time Clock
>  dallas,ds1338		I2C RTC with 56-Byte NV RAM
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index d12b2a0..45a22a6 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -38,6 +38,17 @@ config CM32181
>  	 To compile this driver as a module, choose M here:
>  	 the module will be called cm32181.
>  
> +config CM3218X
> +	depends on I2C

is there an ACPI dependency?

> +	tristate "CM3218x driver"
> +	help
> +	 Say Y here if you use cm3218x.
> +	 This option enables ambient light sensor using
> +	 Capella cm3218x device driver.
> +
> +	 To compile this driver as a module, choose M here:
> +	 the module will be called cm3218x.
> +
>  config CM36651
>  	depends on I2C
>  	tristate "CM36651 driver"
> diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
> index 60e35ac..a506c23 100644
> --- a/drivers/iio/light/Makefile
> +++ b/drivers/iio/light/Makefile
> @@ -6,6 +6,7 @@
>  obj-$(CONFIG_ADJD_S311)		+= adjd_s311.o
>  obj-$(CONFIG_APDS9300)		+= apds9300.o
>  obj-$(CONFIG_CM32181)		+= cm32181.o
> +obj-$(CONFIG_CM3218X)		+= cm3218x.o
>  obj-$(CONFIG_CM36651)		+= cm36651.o
>  obj-$(CONFIG_GP2AP020A00F)	+= gp2ap020a00f.o
>  obj-$(CONFIG_HID_SENSOR_ALS)	+= hid-sensor-als.o
> diff --git a/drivers/iio/light/cm3218x.c b/drivers/iio/light/cm3218x.c
> new file mode 100644
> index 0000000..e422f68
> --- /dev/null
> +++ b/drivers/iio/light/cm3218x.c
> @@ -0,0 +1,769 @@
> +/*
> + * Copyright (C) 2014 Capella Microsystems Inc.
> + * Author: Kevin Tsai <ktsai@capellamicro.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2, as published
> + * by the Free Software Foundation.
> + *
> + * Special thanks Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> + * help to add ACPI support.
> + *
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/mutex.h>
> +#include <linux/module.h>
> +#include <linux/interrupt.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/events.h>
> +#include <linux/init.h>
> +#include <linux/acpi.h>
> +
> +/* Registers Address */
> +#define CM3218x_REG_ADDR_CMD		0x00
> +#define	CM3218x_REG_ADDR_WH		0x01
> +#define	CM3218x_REG_ADDR_WL		0x02
> +#define	CM3218x_REG_ADDR_TEST		0x03

inconsistent whitespace allover

> +#define CM3218x_REG_ADDR_ALS		0x04
> +#define CM3218x_REG_ADDR_STATUS		0x06
> +#define CM3218x_REG_ADDR_ID		0x07
> +
> +/* Number of Configurable Registers */
> +#define CM3218x_CONF_REG_NUM		16
> +
> +/* CMD register */
> +#define CM3218x_CMD_ALS_DISABLE		0x01
> +#define CM3218x_CMD_ALS_INT_EN		0x02
> +#define	CM3218x_CMD_ALS_THRES_WINDOW	0x04
> +
> +#define	CM3218x_CMD_ALS_PERS_SHIFT	4
> +#define	CM3218x_CMD_ALS_PERS_MASK	(0x03 << CM3218x_CMD_ALS_PERS_SHIFT)
> +#define	CM3218x_CMD_ALS_PERS_DEFAULT	(0x01 << CM3218x_CMD_ALS_PERS_SHIFT)
> +
> +#define CM3218x_CMD_ALS_IT_SHIFT	6
> +#define CM3218x_CMD_ALS_IT_MASK		(0x0F << CM3218x_CMD_ALS_IT_SHIFT)
> +#define CM3218x_CMD_ALS_IT_DEFAULT	(0x01 << CM3218x_CMD_ALS_IT_SHIFT)
> +
> +#define CM3218x_CMD_ALS_HS_SHIFT	11
> +#define CM3218x_CMD_ALS_HS_MASK		(0x01 << CM3218x_CMD_ALS_HS_SHIFT)
> +#define CM3218x_CMD_ALS_HS_DEFAULT	(0x00 << CM3218x_CMD_ALS_HS_SHIFT)
> +
> +#define	CM3218x_CMD_DEFAULT		(CM3218x_CMD_ALS_THRES_WINDOW |\
> +					CM3218x_CMD_ALS_PERS_DEFAULT |\
> +					CM3218x_CMD_ALS_IT_DEFAULT |\
> +					CM3218x_CMD_ALS_HS_DEFAULT)
> +
> +#define	CM3218x_WH_DEFAULT		0xFFFF
> +#define	CM3218x_WL_DEFAULT		0x0000
> +
> +#define CM3218x_CALIBSCALE_DEFAULT	100000
> +#define CM3218x_CALIBSCALE_RESOLUTION	100000
> +#define MLUX_PER_LUX			1000

CM3218x prefix missing

the lowercase x in macros is a bit weird for my taste

> +#define CM3218x_THRESHOLD_PERCENT	10	/* 10 percent */
> +
> +/* CM3218 Family */
> +#define CM3218_MLUX_PER_BIT_DEFAULT	5	/* Depend on system */
> +#define CM3218_MLUX_PER_BIT_BASE_IT	800000
> +static int CM3218_als_it_bits[] = {0, 1, 2, 3};
> +static int CM3218_als_it_values[] = {100000, 200000, 400000, 800000};

const missing

> +
> +/* CM32181 Family */
> +#define CM32181_MLUX_PER_BIT_DEFAULT	5
> +#define CM32181_MLUX_PER_BIT_BASE_IT	800000
> +static int CM32181_als_it_bits[] = {12, 8, 0, 1, 2, 3};
> +static int CM32181_als_it_values[] = {
> +			25000, 50000, 100000, 200000, 400000, 800000};

const missing

> +
> +/* CM32182 Family */
> +#define CM32182_MLUX_PER_BIT_DEFAULT	5
> +#define CM32182_MLUX_PER_BIT_BASE_IT	800000
> +static int CM32182_als_it_bits[] = {12, 8, 0, 1, 2, 3};
> +static int CM32182_als_it_values[] = {
> +			25000, 50000, 100000, 200000, 400000, 800000};

const missing

these definitions are largely identical and could be dropped; they are 
only used to fill device-specific tables below; why have a separate 
define here?

> +
> +struct cmdev {

prefix?

> +	u32 family_id;
> +	int int_type;
> +#define	INT_TYPE_SMBUS			0
> +#define	INT_TYPE_I2C			1

prefix?

> +	int regs_bmp;
> +	int calibscale;
> +	int mlux_per_bit;
> +	int mlux_per_bit_base_it;
> +	int *als_it_bits;
> +	int *als_it_values;
> +	int num_als_it;
> +};
> +
> +static struct cmdev cm3218 = {
> +	3218, INT_TYPE_SMBUS, 0x0F, CM3218x_CALIBSCALE_DEFAULT,
> +	CM3218_MLUX_PER_BIT_DEFAULT, CM3218_MLUX_PER_BIT_BASE_IT,
> +	CM3218_als_it_bits, CM3218_als_it_values,
> +	ARRAY_SIZE(CM3218_als_it_bits)};
> +
> +static struct cmdev cm32181 = {
> +	32181, INT_TYPE_I2C, 0x0F, CM3218x_CALIBSCALE_DEFAULT,
> +	CM32181_MLUX_PER_BIT_DEFAULT, CM32181_MLUX_PER_BIT_BASE_IT,
> +	CM32181_als_it_bits, CM32181_als_it_values,
> +	ARRAY_SIZE(CM32181_als_it_bits)};
> +
> +static struct cmdev cm32182 = {
> +	32182, INT_TYPE_I2C, 0x0F, CM3218x_CALIBSCALE_DEFAULT,
> +	CM32182_MLUX_PER_BIT_DEFAULT, CM32182_MLUX_PER_BIT_BASE_IT,
> +	CM32182_als_it_bits, CM32182_als_it_values,
> +	ARRAY_SIZE(CM32182_als_it_bits)};
> +
> +struct cm3218x_chip {
> +	struct i2c_client *client;
> +	struct cmdev *cmdev;
> +	struct mutex lock;
> +	u16 conf_regs[CM3218x_CONF_REG_NUM];
> +	int als_raw;
> +};
> +
> +static int cm3218x_get_lux(struct cm3218x_chip *chip);
> +static int cm3218x_threshold_update(struct cm3218x_chip *chip, int percent);
> +static int cm3218x_read_als_it(struct cm3218x_chip *chip, int *val2);
> +
> +/**
> + * cm3218x_read_ara() - Read ARA register
> + * @cm3218x:	pointer of struct cm3218x.

@chip

> + *
> + * Following SMBus protocol, ARA register is available only when interrupt
> + * event happened.  Read it to clean interrupt event.  Otherwise, other
> + * device address/registers will be blocked during interrupt event.
> + *
> + * Return: 0 for success; otherwise for error code.
> + */
> +static int cm3218x_read_ara(struct cm3218x_chip *chip)
> +{
> +	struct i2c_client *client = chip->client;
> +	int status;
> +	unsigned short addr;
> +

this looks dangerous: temporarily changing the I2C chip address!

> +	addr = client->addr;
> +	client->addr = 0x0C;
> +	status = i2c_smbus_read_byte(client);
> +	client->addr = addr;
> +
> +	if (status < 0)
> +		return -ENODEV;
> +
> +	return status;
> +}
> +
> +/**
> + * cm3218x_interrupt_config() - Enable/Disable CM3218x interrupt
> + * @cm3218x:	pointer of struct cm3218x.

@chip: pointer to struct cm3218x_chip

> + * @enable:	0 to disable; otherwise to enable
> + *
> + * Config CM3218x interrupt control bit.
> + *
> + * Return: 0 for success; otherwise for error code.
> + */
> +static int cm3218x_interrupt_config(struct cm3218x_chip *chip, int enable)
> +{
> +	struct i2c_client *client = chip->client;
> +	struct cmdev *cmdev = chip->cmdev;
> +	int status;
> +
> +	if (!cmdev)
> +		return -ENODEV;
> +
> +	/* Force to clean interrupt */
> +	if (cmdev->int_type == INT_TYPE_I2C) {
> +		status = i2c_smbus_read_word_data(client,
> +				CM3218x_REG_ADDR_STATUS);
> +		if (status < 0)
> +			cmdev->int_type = INT_TYPE_SMBUS;
> +	}
> +	if (cmdev->int_type == INT_TYPE_SMBUS)
> +		cm3218x_read_ara(chip);
> +
> +	if (enable)
> +		chip->conf_regs[CM3218x_REG_ADDR_CMD] |=
> +			CM3218x_CMD_ALS_INT_EN;
> +	else
> +		chip->conf_regs[CM3218x_REG_ADDR_CMD] &=
> +			~CM3218x_CMD_ALS_INT_EN;
> +
> +	status = i2c_smbus_write_word_data(client, CM3218x_REG_ADDR_CMD,
> +		chip->conf_regs[CM3218x_REG_ADDR_CMD]);
> +
> +	if (status < 0)
> +		return -ENODEV;
> +
> +	return status;
> +}
> +
> +/**
> + * cm3218x_acpi_get_cpm_info() - Get CPM object from ACPI
> + * @client	pointer of struct i2c_client.
> + * @obj_name	pointer of ACPI object name.
> + * @count	maximum size of return array.
> + * @vals	pointer of array for return elements.
> + *
> + * Convert ACPI CPM table to array. Special thanks Srinivas Pandruvada's
> + * help to implement this routine.
> + *
> + * Return: -ENODEV for fail.  Otherwise is number of elements.
> + */
> +static int cm3218x_acpi_get_cpm_info(struct i2c_client *client, char *obj_name,
> +							int count, u64 *vals)
> +{
> +	acpi_handle handle;
> +	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
> +	int i;
> +	acpi_status status;
> +	union acpi_object *cpm = NULL;

no need to initialize cpm

> +
> +	handle = ACPI_HANDLE(&client->dev);
> +	if (!handle)
> +		return -ENODEV;
> +
> +	status = acpi_evaluate_object(handle, obj_name, NULL, &buffer);
> +	if (ACPI_FAILURE(status)) {
> +		dev_err(&client->dev, "object %s not found\n", obj_name);
> +		return -ENODEV;
> +	}
> +
> +	cpm = buffer.pointer;
> +	for (i = 0; i < cpm->package.count && i < count; ++i) {
> +		union acpi_object *elem;
> +		elem = &(cpm->package.elements[i]);
> +		vals[i] = elem->integer.value;
> +	}
> +
> +	kfree(buffer.pointer);
> +
> +	return cpm->package.count;
> +}
> +
> +/**
> + * cm3218x_reg_init() - Initialize CM3218x registers
> + * @cm3218x:	pointer of struct cm3218x.
> + *
> + * Initialize CM3218x ambient light sensor register to default values.
> + *
> +  Return: 0 for success; otherwise for error code.
> + */
> +static int cm3218x_reg_init(struct cm3218x_chip *chip)
> +{
> +	struct i2c_client *client = chip->client;
> +	int i;
> +	s32 ret;
> +	int cpm_elem_count;
> +	u64 cpm_elems[20];
> +	struct cmdev *cmdev;
> +
> +	/* Default device */
> +	chip->cmdev = &cm3218;
> +	chip->conf_regs[CM3218x_REG_ADDR_CMD] = CM3218x_CMD_DEFAULT;
> +	chip->conf_regs[CM3218x_REG_ADDR_WH] = CM3218x_WH_DEFAULT;
> +	chip->conf_regs[CM3218x_REG_ADDR_WL] = CM3218x_WL_DEFAULT;
> +
> +	/* Disable interrupt */
> +	cm3218x_interrupt_config(chip, 0);
> +
> +	/* Disable Test Mode */
> +	i2c_smbus_write_word_data(client, CM3218x_REG_ADDR_TEST, 0x0000);
> +
> +	/* Disable device */
> +	i2c_smbus_write_word_data(client, CM3218x_REG_ADDR_CMD,
> +		CM3218x_CMD_ALS_DISABLE);
> +
> +	/* Identify device */
> +	ret = i2c_smbus_read_word_data(client, CM3218x_REG_ADDR_ID);
> +	if (ret < 0)
> +		return ret;
> +	switch (ret & 0xFF) {
> +	case 0x18:
> +		cmdev = chip->cmdev = &cm3218;
> +		if (ret & 0x0800)
> +			cmdev->int_type = INT_TYPE_I2C;
> +		else
> +			cmdev->int_type = INT_TYPE_SMBUS;
> +		break;
> +	case 0x81:
> +		cmdev = chip->cmdev = &cm32181;
> +		break;
> +	case 0x82:
> +		cmdev = chip->cmdev = &cm32182;
> +		break;
> +	default:
> +		return -ENODEV;
> +	}
> +
> +	if (ACPI_HANDLE(&client->dev)) {
> +		/* Load from ACPI */
> +		cpm_elem_count = cm3218x_acpi_get_cpm_info(client, "CPM0",
> +							ARRAY_SIZE(cpm_elems),
> +							cpm_elems);
> +		if (cpm_elem_count > 0) {
> +			int header_num = 3;
> +			int reg_num = cpm_elem_count - header_num;
> +
> +			cmdev->regs_bmp = cpm_elems[2];
> +			for (i = 0; i < reg_num; i++)
> +				if (cmdev->regs_bmp & (1<<i))
> +					chip->conf_regs[i] =
> +						cpm_elems[header_num+i];
> +		}
> +
> +		cpm_elem_count = cm3218x_acpi_get_cpm_info(client, "CPM1",
> +							ARRAY_SIZE(cpm_elems),
> +							cpm_elems);
> +		if (cpm_elem_count > 0) {
> +			cmdev->mlux_per_bit = (int)cpm_elems[0] / 100;
> +			cmdev->calibscale = (int)cpm_elems[1];
> +		}
> +	}
> +
> +	/* Force to disable interrupt */
> +	chip->conf_regs[CM3218x_REG_ADDR_CMD] &= ~CM3218x_CMD_ALS_INT_EN;
> +
> +	/* Initialize registers*/

whitespace

> +	for (i = 0; i < CM3218x_CONF_REG_NUM; i++) {
> +		if (cmdev->regs_bmp & (1<<i)) {
> +			ret = i2c_smbus_write_word_data(client, i,
> +						chip->conf_regs[i]);
> +			if (ret < 0)
> +				return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + *  cm3218x_read_als_it() - Get sensor integration time (ms)
> + *  @cm3218x:	pointer of struct cm3218x
> + *  @val2:	pointer of int to load the als_it value.
> + *
> + *  Report the current integartion time by millisecond.

integration time in milliseconds

> + *
> + *  Return: IIO_VAL_INT_PLUS_MICRO for success, otherwise -EINVAL.
> + */
> +static int cm3218x_read_als_it(struct cm3218x_chip *chip, int *val2)
> +{
> +	struct cmdev *cmdev = chip->cmdev;
> +	u16 als_it;
> +	int i;
> +
> +	als_it = chip->conf_regs[CM3218x_REG_ADDR_CMD];
> +	als_it &= CM3218x_CMD_ALS_IT_MASK;
> +	als_it >>= CM3218x_CMD_ALS_IT_SHIFT;
> +	for (i = 0; i < cmdev->num_als_it; i++) {
> +		if (als_it == cmdev->als_it_bits[i]) {
> +			*val2 = cmdev->als_it_values[i];
> +			return IIO_VAL_INT_PLUS_MICRO;
> +		}
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +/**
> + * cm3218x_write_als_it() - Write sensor integration time
> + * @cm3218x:	pointer of struct cm3218x.
> + * @val:	integration time by millisecond.
> + *
> + * Convert integration time (ms) to sensor value.
> + *
> + * Return: i2c_smbus_write_word_data command return value.
> + */
> +static int cm3218x_write_als_it(struct cm3218x_chip *chip, int val)
> +{
> +	struct i2c_client *client = chip->client;
> +	struct cmdev *cmdev = chip->cmdev;
> +	u16 als_it;
> +	int ret, i;
> +
> +	for (i = 0; i < cmdev->num_als_it; i++)
> +		if (val <= cmdev->als_it_values[i])
> +			break;
> +	if (i >= cmdev->num_als_it)
> +		i = cmdev->num_als_it - 1;
> +
> +	als_it = cmdev->als_it_bits[i];
> +	als_it <<= CM3218x_CMD_ALS_IT_SHIFT;
> +
> +	mutex_lock(&chip->lock);
> +	chip->conf_regs[CM3218x_REG_ADDR_CMD] &=
> +			~CM3218x_CMD_ALS_IT_MASK;
> +	chip->conf_regs[CM3218x_REG_ADDR_CMD] |=
> +			als_it;
> +	ret = i2c_smbus_write_word_data(client, CM3218x_REG_ADDR_CMD,
> +			chip->conf_regs[CM3218x_REG_ADDR_CMD]);
> +	mutex_unlock(&chip->lock);
> +
> +	return ret;
> +}
> +
> +/**
> + * cm3218x_get_lux() - report current lux value
> + * @cm3218x:	pointer of struct cm3218x.
> + *
> + * Convert sensor raw data to lux.  It depends on integration
> + * time and claibscale variable.

calibscale

> + *
> + * Return: Positive value is lux, otherwise is error code.
> + */
> +static int cm3218x_get_lux(struct cm3218x_chip *chip)
> +{
> +	struct i2c_client *client = chip->client;
> +	struct cmdev *cmdev = chip->cmdev;
> +	int ret;
> +	int als_it;
> +	int lux;

lux variable is not needed

> +	u64 tmp;
> +
> +	/* Calculate mlux per bit based on als_it */
> +	ret = cm3218x_read_als_it(chip, &als_it);
> +	if (ret < 0)
> +		return -EINVAL;
> +	tmp = (__force u64)cmdev->mlux_per_bit;
> +	tmp *= cmdev->mlux_per_bit_base_it;
> +	tmp = div_u64(tmp, als_it);
> +
> +	/* Get als_raw */
> +	if (!(chip->conf_regs[CM3218x_REG_ADDR_CMD] & CM3218x_CMD_ALS_INT_EN))
> +		chip->als_raw = i2c_smbus_read_word_data(
> +					client,
> +					CM3218x_REG_ADDR_ALS);
> +	if (chip->als_raw < 0)
> +		return chip->als_raw;
> +
> +	tmp *= chip->als_raw;
> +	tmp *= cmdev->calibscale;
> +	tmp = div_u64(tmp, CM3218x_CALIBSCALE_RESOLUTION);
> +	tmp = div_u64(tmp, MLUX_PER_LUX);
> +
> +	if (tmp > 0xFFFF)
> +		tmp = 0xFFFF;
> +
> +	lux = (int)tmp;
> +	return lux;
> +}
> +
> +static int cm3218x_read_raw(struct iio_dev *indio_dev,
> +			struct iio_chan_spec const *chan,
> +			int *val, int *val2, long mask)
> +{
> +	struct cm3218x_chip *chip = iio_priv(indio_dev);
> +	struct cmdev *cmdev = chip->cmdev;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_PROCESSED:
> +		ret = cm3218x_get_lux(chip);
> +		if (ret < 0)
> +			return ret;
> +		*val = ret;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		*val = cmdev->calibscale;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_INT_TIME:
> +		*val = 0;
> +		ret = cm3218x_read_als_it(chip, val2);
> +		return ret;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int cm3218x_write_raw(struct iio_dev *indio_dev,
> +			struct iio_chan_spec const *chan,
> +			int val, int val2, long mask)
> +{
> +	struct cm3218x_chip *chip = iio_priv(indio_dev);
> +	struct cmdev *cmdev = chip->cmdev;
> +	int ret;

ret not needed

> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		cmdev->calibscale = val;
> +		return val;
> +	case IIO_CHAN_INFO_INT_TIME:

val==0 could be checked here

> +		ret = cm3218x_write_als_it(chip, val2);
> +		return ret;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +/**
> + * cm3218x_get_it_available() - Get available ALS IT value
> + * @dev:	pointer of struct device.
> + * @attr:	pointer of struct device_attribute.
> + * @buf:	pointer of return string buffer.
> + *
> + * Display the available integration time values by millisecond.
> + *
> + * Return: string length.
> + */
> +static ssize_t cm3218x_get_it_available(struct device *dev,
> +			struct device_attribute *attr, char *buf)
> +{
> +	struct cm3218x_chip *chip = iio_priv(dev_to_iio_dev(dev));
> +	struct cmdev *cmdev = chip->cmdev;
> +	int i, len;
> +
> +	for (i = 0, len = 0; i < cmdev->num_als_it; i++)
> +		len += sprintf(buf + len, "0.%06u ", cmdev->als_it_values[i]);

scnprintf(buf+len, PAGESIZE-len, ...) could be used

> +	return len + sprintf(buf + len, "\n");
> +}
> +
> +/**
> + * cm3218x_threshold_update() - Update the threshold registers.
> + * @dev:	pointer of struct cm3218x_chip.

@chip

> + * @percent:	+/- percent.
> + *
> + * Based on the current ALS value, tupdate the hi and low threshold registers.
> + *
> + * Return: string length.

definitely not the string length

> + */
> +static int cm3218x_threshold_update(struct cm3218x_chip *chip, int percent)
> +{
> +	struct i2c_client *client = chip->client;
> +	int ret;
> +	int wh, wl;
> +
> +	ret = chip->als_raw = i2c_smbus_read_word_data(client,
> +					CM3218x_REG_ADDR_ALS);
> +	if (ret < 0)
> +		return ret;
> +
> +	wh = wl = ret;
> +	ret *= percent;
> +	ret /= 100;
> +	if (ret < 1)
> +		ret = 1;
> +	wh += ret;
> +	wl -= ret;
> +	if (wh > 65535)
> +		wh = 65535;
> +	if (wl < 0)
> +		wl = 0;
> +
> +	chip->conf_regs[CM3218x_REG_ADDR_WH] = wh;
> +	ret = i2c_smbus_write_word_data(
> +		client,
> +		CM3218x_REG_ADDR_WH,
> +		chip->conf_regs[CM3218x_REG_ADDR_WH]);
> +	if (ret < 0)
> +		return ret;
> +
> +	chip->conf_regs[CM3218x_REG_ADDR_WL] = wl;
> +	ret = i2c_smbus_write_word_data(
> +		client,
> +		CM3218x_REG_ADDR_WL,
> +		chip->conf_regs[CM3218x_REG_ADDR_WL]);

just 
return ret;

> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +/**
> + * cm3218x_event_handler() - Interrupt handling routine.
> + * @irq:	irq number.
> + * @private:	pointer of void.
> + *
> + * Clean interrupt and reset threshold registers.
> + *
> + * Return: string length.



> + */
> +static irqreturn_t cm3218x_event_handler(int irq, void *private)
> +{
> +	struct iio_dev *dev_info = private;
> +	struct cm3218x_chip *chip = iio_priv(dev_info);
> +	int ret;
> +
> +	mutex_lock(&chip->lock);
> +
> +	/* Disable interrupt */
> +	ret = cm3218x_interrupt_config(chip, 0);
> +	if (ret < 0)
> +		goto error_handler_unlock;
> +
> +	/* Update Hi/Lo windows */
> +	ret = cm3218x_threshold_update(chip, CM3218x_THRESHOLD_PERCENT);
> +	if (ret < 0)
> +		goto error_handler_unlock;
> +
> +	/* Enable interrupt */
> +	ret = cm3218x_interrupt_config(chip, 1);
> +	if (ret < 0)
> +		goto error_handler_unlock;
> +
> +	mutex_unlock(&chip->lock);
> +
> +	return IRQ_HANDLED;
> +
> +error_handler_unlock:
> +	mutex_unlock(&chip->lock);
> +	return IRQ_NONE;

I think it should be IRQ_HANDLED always
there is no check if the interrupt indeed stems from this device

> +}
> +
> +static const struct iio_chan_spec cm3218x_channels[] = {
> +	{
> +		.type = IIO_LIGHT,
> +		.info_mask_separate =
> +			BIT(IIO_CHAN_INFO_PROCESSED) |
> +			BIT(IIO_CHAN_INFO_CALIBSCALE) |
> +			BIT(IIO_CHAN_INFO_INT_TIME),
> +	}
> +};
> +
> +static IIO_DEVICE_ATTR(in_illuminance_integration_time_available,
> +			S_IRUGO, cm3218x_get_it_available, NULL, 0);
> +
> +static struct attribute *cm3218x_attributes[] = {
> +	&iio_dev_attr_in_illuminance_integration_time_available.dev_attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group cm3218x_attribute_group = {
> +	.attrs = cm3218x_attributes
> +};
> +
> +static const struct iio_info cm3218x_info = {
> +	.driver_module		= THIS_MODULE,
> +	.read_raw		= &cm3218x_read_raw,
> +	.write_raw		= &cm3218x_write_raw,
> +	.attrs			= &cm3218x_attribute_group,
> +};
> +
> +static int cm3218x_probe(struct i2c_client *client,
> +			const struct i2c_device_id *id)
> +{
> +	struct cm3218x_chip *chip;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*chip));
> +	if (!indio_dev) {
> +		dev_err(&client->dev, "devm_iio_device_alloc failed\n");
> +		return -ENOMEM;
> +	}
> +
> +	chip = iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);
> +	chip->client = client;
> +
> +	mutex_init(&chip->lock);
> +	indio_dev->dev.parent = &client->dev;
> +	indio_dev->channels = cm3218x_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(cm3218x_channels);
> +	indio_dev->info = &cm3218x_info;
> +	if (id && id->name)
> +		indio_dev->name = id->name;
> +	else
> +		indio_dev->name = (char *)dev_name(&client->dev);
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	ret = cm3218x_reg_init(chip);
> +	if (ret) {
> +		dev_err(&client->dev,
> +			"%s: register init failed\n",
> +			__func__);
> +		return ret;
> +	}
> +
> +	if (client->irq) {
> +		ret = request_threaded_irq(client->irq,
> +					NULL,
> +					cm3218x_event_handler,
> +					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +					"cm3218x_event",
> +					indio_dev);
> +
> +		if (ret < 0) {
> +			dev_err(&client->dev, "irq request error %d\n",
> +				-ret);
> +			goto error_disable_int;
> +		}
> +	}
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret < 0) {
> +		dev_err(&client->dev,
> +			"%s: regist device failed\n",
> +			__func__);
> +		goto error_free_irq;
> +	}
> +
> +	if (client->irq) {
> +		ret = cm3218x_threshold_update(chip, CM3218x_THRESHOLD_PERCENT);
> +		if (ret < 0)
> +			goto error_free_irq;
> +
> +		ret = cm3218x_interrupt_config(chip, 1);
> +		if (ret < 0)
> +			goto error_free_irq;
> +	}
> +
> +	return 0;
> +
> +error_free_irq:
> +	free_irq(client->irq, indio_dev);
> +error_disable_int:
> +	cm3218x_interrupt_config(chip, 0);
> +	return ret;
> +}
> +
> +static int cm3218x_remove(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +	struct cm3218x_chip *chip = iio_priv(indio_dev);
> +
> +	cm3218x_interrupt_config(chip, 0);
> +	if (client->irq)
> +		free_irq(client->irq, indio_dev);
> +	iio_device_unregister(indio_dev);
> +	return 0;
> +}
> +
> +static const struct i2c_device_id cm3218x_id[] = {
> +	{ "cm3218x", 0},
> +	{ }
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, cm3218x_id);
> +
> +static const struct of_device_id cm3218x_of_match[] = {
> +	{ .compatible = "capella,cm3218x" },
> +	{ }
> +};
> +
> +static const struct acpi_device_id cm3218x_acpi_match[] = {
> +	{ "CPLM3218", 0},
> +	{},
> +};
> +
> +MODULE_DEVICE_TABLE(acpi, cm3218x_acpi_match);
> +
> +static struct i2c_driver cm3218x_driver = {
> +	.driver = {
> +		.name	= "cm3218x",
> +		.acpi_match_table = ACPI_PTR(cm3218x_acpi_match),
> +		.of_match_table = of_match_ptr(cm3218x_of_match),
> +		.owner	= THIS_MODULE,
> +	},
> +	.id_table	= cm3218x_id,
> +	.probe		= cm3218x_probe,
> +	.remove		= cm3218x_remove,
> +};
> +
> +module_i2c_driver(cm3218x_driver);
> +
> +MODULE_AUTHOR("Kevin Tsai <ktsai@capellamicro.com>");
> +MODULE_DESCRIPTION("CM3218x ambient light sensor driver");
> +MODULE_LICENSE("GPL");
> 

-- 

Peter Meerwald
+43-664-2444418 (mobile)
