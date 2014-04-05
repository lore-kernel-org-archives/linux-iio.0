Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39976 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751896AbaDEKof (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 5 Apr 2014 06:44:35 -0400
Message-ID: <533FDEDC.8030301@kernel.org>
Date: Sat, 05 Apr 2014 11:45:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Kevin Tsai <ktsai@capellamicro.com>,
	Beomho Seo <beomho.seo@samsung.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH V1 1/1] iio: update Capella cm32181 ambient light sensor
 driver.
References: <1396305786-15206-1-git-send-email-ktsai@capellamicro.com>
In-Reply-To: <1396305786-15206-1-git-send-email-ktsai@capellamicro.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 31/03/14 23:43, Kevin Tsai wrote:
> If CONFIG_ACPI supported, driver will detect ACPI table and load per-system
> manufacturing parameters.  For Interrupt feature, it will register its
> interrupt service routine to system if device IRQ number is not zero.
>
> Signed-off-by: Kevin Tsai <ktsai@capellamicro.com>
Hi Kevin,

Previously I'd failed to note the 3218x driver you have posted includes this
device.  Why were you proposing a new driver?  I guess this patch is bolting
the equivalent support into this existing driver.

As I mentioned in my brief email the other day this needs splitting up into
a series of smaller changes.

1) Any cleanup / renaming etc.
2) interrupt support
3) acpi support

Various comments inline, but a hydra patch like this is hard to review
so there will probably be more once it is broken up into is various
parts.

I'm particularly unclear how the interrupts are used in the driver as
it stands.  They move thresholds around, but unless I am missing something
the result is exposed to userspace...

(could just be a lack of caffine this morning ;)

J
> ---
>   drivers/iio/light/cm32181.c | 576 ++++++++++++++++++++++++++++++++++----------
>   1 file changed, 452 insertions(+), 124 deletions(-)
>
> diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
> index 47a6dba..97bb2a6 100644
> --- a/drivers/iio/light/cm32181.c
> +++ b/drivers/iio/light/cm32181.c
> @@ -1,10 +1,14 @@
>   /*
> - * Copyright (C) 2013 Capella Microsystems Inc.
> + * Copyright (C) 2014 Capella Microsystems Inc.
>    * Author: Kevin Tsai <ktsai@capellamicro.com>
>    *
>    * This program is free software; you can redistribute it and/or modify it
>    * under the terms of the GNU General Public License version 2, as published
>    * by the Free Software Foundation.
> + *
> + * Special thanks Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> + * help to add ACPI support.
> + *
>    */
>
>   #include <linux/delay.h>
> @@ -19,82 +23,258 @@
>   #include <linux/iio/events.h>
>   #include <linux/init.h>
>
> +#ifdef	CONFIG_ACPI
> +#include <linux/acpi.h>
> +#endif /* CONFIG_ACPI */
> +
>   /* Registers Address */
> -#define CM32181_REG_ADDR_CMD		0x00
> -#define CM32181_REG_ADDR_ALS		0x04
> -#define CM32181_REG_ADDR_STATUS		0x06
> -#define CM32181_REG_ADDR_ID		0x07
> +#define CM32181_REG_ADDR_CMD 0x00
> +#define CM32181_REG_ADDR_WH 0x01
> +#define CM32181_REG_ADDR_WL 0x02
> +#define CM32181_REG_ADDR_TEST 0x03
> +#define CM32181_REG_ADDR_ALS 0x04
> +#define CM32181_REG_ADDR_STATUS 0x06
> +#define CM32181_REG_ADDR_ID 0x07
>
>   /* Number of Configurable Registers */
> -#define CM32181_CONF_REG_NUM		0x01
> +#define CM32181_CONF_REG_NUM 16
>
>   /* CMD register */
> -#define CM32181_CMD_ALS_ENABLE		0x00
> -#define CM32181_CMD_ALS_DISABLE		0x01
> -#define CM32181_CMD_ALS_INT_EN		0x02
> -
> -#define CM32181_CMD_ALS_IT_SHIFT	6
> -#define CM32181_CMD_ALS_IT_MASK		(0x0F << CM32181_CMD_ALS_IT_SHIFT)
> -#define CM32181_CMD_ALS_IT_DEFAULT	(0x00 << CM32181_CMD_ALS_IT_SHIFT)
> -
> -#define CM32181_CMD_ALS_SM_SHIFT	11
> -#define CM32181_CMD_ALS_SM_MASK		(0x03 << CM32181_CMD_ALS_SM_SHIFT)
> -#define CM32181_CMD_ALS_SM_DEFAULT	(0x01 << CM32181_CMD_ALS_SM_SHIFT)
> -
> -#define CM32181_MLUX_PER_BIT		5	/* ALS_SM=01 IT=800ms */
> -#define CM32181_MLUX_PER_BIT_BASE_IT	800000	/* Based on IT=800ms */
> -#define	CM32181_CALIBSCALE_DEFAULT	1000
> -#define CM32181_CALIBSCALE_RESOLUTION	1000
> -#define MLUX_PER_LUX			1000
> -
> -static const u8 cm32181_reg[CM32181_CONF_REG_NUM] = {
> -	CM32181_REG_ADDR_CMD,
> +#define CM32181_CMD_ALS_DISABLE BIT(0)
> +#define CM32181_CMD_ALS_INT_EN BIT(1)
> +#define CM32181_CMD_ALS_THRES_WINDOW BIT(2)
> +
> +#define CM32181_CMD_ALS_PERS_SHIFT 4
> +#define CM32181_CMD_ALS_PERS_MASK (0x03 << CM32181_CMD_ALS_PERS_SHIFT)
> +#define CM32181_CMD_ALS_PERS_DEFAULT (0x01 << CM32181_CMD_ALS_PERS_SHIFT)
> +
> +#define CM32181_CMD_ALS_IT_SHIFT 6
> +#define CM32181_CMD_ALS_IT_MASK (0x0F << CM32181_CMD_ALS_IT_SHIFT)
> +#define CM32181_CMD_ALS_IT_DEFAULT (0x01 << CM32181_CMD_ALS_IT_SHIFT)
> +
> +#define CM32181_CMD_ALS_HS_SHIFT 11
> +#define CM32181_CMD_ALS_HS_MASK (0x01 << CM32181_CMD_ALS_HS_SHIFT)
> +#define CM32181_CMD_ALS_HS_DEFAULT (0x00 << CM32181_CMD_ALS_HS_SHIFT)
> +
> +#define CM32181_CMD_DEFAULT (CM32181_CMD_ALS_THRES_WINDOW |\
> +		CM32181_CMD_ALS_PERS_DEFAULT |\
> +		CM32181_CMD_ALS_IT_DEFAULT |\
> +		CM32181_CMD_ALS_HS_DEFAULT)
> +
> +#define CM32181_WH_DEFAULT 0xFFFF
> +#define CM32181_WL_DEFAULT 0x0000
> +
> +#define CM32181_CALIBSCALE_DEFAULT 100000
> +#define CM32181_CALIBSCALE_RESOLUTION 100000
> +#define CM32181_MLUX_PER_LUX 1000
> +#define CM32181_THRESHOLD_PERCENT 10	/* 10 percent */
> +
> +#define CM32181_MLUX_PER_BIT_DEFAULT 5
> +#define CM32181_MLUX_PER_BIT_BASE_IT 800000
> +static const int CM32181_als_it_bits[] = {12, 8, 0, 1, 2, 3};
> +static const int CM32181_als_it_values[] = {
> +			25000, 50000, 100000, 200000, 400000, 800000};
> +
> +struct cm32181_als_info {
> +	u32 id;
> +	int regs_bmp;
> +	int calibscale;
> +	int mlux_per_bit;
> +	int mlux_per_bit_base_it;
> +	const int *als_it_bits;
> +	const int *als_it_values;
> +	const int num_als_it;
> +	int als_raw;
>   };
>
> -static const int als_it_bits[] = {12, 8, 0, 1, 2, 3};
> -static const int als_it_value[] = {25000, 50000, 100000, 200000, 400000,
> -	800000};
> +static struct cm32181_als_info cm32181_als_info_default = {
> +	.id = 32181,
> +	.regs_bmp = 0x0F,
> +	.calibscale = CM32181_CALIBSCALE_DEFAULT,
> +	.mlux_per_bit = CM32181_MLUX_PER_BIT_DEFAULT,
> +	.mlux_per_bit_base_it = CM32181_MLUX_PER_BIT_BASE_IT,
> +	.als_it_bits = CM32181_als_it_bits,
> +	.als_it_values = CM32181_als_it_values,
> +	.num_als_it = ARRAY_SIZE(CM32181_als_it_bits),
> +};
>
>   struct cm32181_chip {
>   	struct i2c_client *client;
>   	struct mutex lock;
>   	u16 conf_regs[CM32181_CONF_REG_NUM];
> -	int calibscale;
> +	struct cm32181_als_info *als_info;
>   };
>
> +static int cm32181_get_lux(struct cm32181_chip *chip);
> +static int cm32181_threshold_update(struct cm32181_chip *chip, int percent);
> +static int cm32181_read_als_it(struct cm32181_chip *chip, int *val2);
> +
> +/**
> + * cm32181_interrupt_config() - Enable/Disable CM32181 interrupt
> + * @chip:	pointer of struct cm32181.
> + * @enable:	0 to disable; otherwise to enable
> + *
> + * Config CM32181 interrupt control bit.
> + *
> + * Return: 0 for success; otherwise for error code.
> + */
> +static int cm32181_interrupt_config(struct cm32181_chip *chip, int enable)
> +{
> +	struct i2c_client *client = chip->client;
> +	struct cm32181_als_info *als_info = chip->als_info;
> +	int status;
> +
> +	if (!als_info)
> +		return -ENODEV;
> +
> +	/* Force to clean interrupt */
> +	status = i2c_smbus_read_word_data(client,
> +			CM32181_REG_ADDR_STATUS);
> +	if (status < 0)
> +		return -ENODEV;
> +
> +	if (enable)
> +		chip->conf_regs[CM32181_REG_ADDR_CMD] |=
> +			CM32181_CMD_ALS_INT_EN;
> +	else
> +		chip->conf_regs[CM32181_REG_ADDR_CMD] &=
> +			~CM32181_CMD_ALS_INT_EN;
> +
> +	status = i2c_smbus_write_word_data(client, CM32181_REG_ADDR_CMD,
> +		chip->conf_regs[CM32181_REG_ADDR_CMD]);
> +
> +	if (status < 0)
> +		return -ENODEV;
> +
> +	return status;
> +}
> +
> +#ifdef CONFIG_ACPI
> +/**
> + * cm32181_acpi_get_cpm_info() - Get CPM object from ACPI
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
> +static int cm32181_acpi_get_cpm_info(struct i2c_client *client, char *obj_name,
> +							int count, u64 *vals)
> +{
> +	acpi_handle handle;
> +	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
> +	int i;
> +	acpi_status status;
> +	union acpi_object *cpm;
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
> +#endif /* CONFIG_ACPI */
> +
>   /**
>    * cm32181_reg_init() - Initialize CM32181 registers
> - * @cm32181:	pointer of struct cm32181.
> + * @chip:	pointer of struct cm32181.
>    *
>    * Initialize CM32181 ambient light sensor register to default values.
>    *
> - * Return: 0 for success; otherwise for error code.
> +  Return: 0 for success; otherwise for error code.
>    */
> -static int cm32181_reg_init(struct cm32181_chip *cm32181)
> +static int cm32181_reg_init(struct cm32181_chip *chip)
>   {
> -	struct i2c_client *client = cm32181->client;
> +	struct i2c_client *client = chip->client;
>   	int i;
>   	s32 ret;
> +	struct cm32181_als_info *als_info;
> +#ifdef CONFIG_ACPI
> +	int cpm_elem_count;
> +	u64 cpm_elems[20];
> +#endif /* CONFIG_ACPI */
>
> +	/* Default device */
> +	als_info = chip->als_info = &cm32181_als_info_default;
> +	chip->conf_regs[CM32181_REG_ADDR_CMD] = CM32181_CMD_DEFAULT;
> +	chip->conf_regs[CM32181_REG_ADDR_WH] = CM32181_WH_DEFAULT;
> +	chip->conf_regs[CM32181_REG_ADDR_WL] = CM32181_WL_DEFAULT;
> +
> +	/* Disable interrupt */
> +	cm32181_interrupt_config(chip, 0);
> +
> +	/* Disable Test Mode */
> +	i2c_smbus_write_word_data(client, CM32181_REG_ADDR_TEST, 0x0000);
> +
> +	/* Disable device */
> +	i2c_smbus_write_word_data(client, CM32181_REG_ADDR_CMD,
> +		CM32181_CMD_ALS_DISABLE);
> +
> +	/* Identify device */
>   	ret = i2c_smbus_read_word_data(client, CM32181_REG_ADDR_ID);
>   	if (ret < 0)
>   		return ret;
> -
> -	/* check device ID */
>   	if ((ret & 0xFF) != 0x81)
>   		return -ENODEV;
>
> -	/* Default Values */
> -	cm32181->conf_regs[CM32181_REG_ADDR_CMD] = CM32181_CMD_ALS_ENABLE |
> -			CM32181_CMD_ALS_IT_DEFAULT | CM32181_CMD_ALS_SM_DEFAULT;
> -	cm32181->calibscale = CM32181_CALIBSCALE_DEFAULT;
> +#ifdef CONFIG_ACPI
> +	if (ACPI_HANDLE(&client->dev)) {
> +		/* Load from ACPI */
> +		cpm_elem_count = cm32181_acpi_get_cpm_info(client, "CPM0",
> +							ARRAY_SIZE(cpm_elems),
> +							cpm_elems);
> +		if (cpm_elem_count > 0) {
> +			int header_num = 3;
> +			int reg_num = cpm_elem_count - header_num;
> +
> +			als_info->id = cpm_elems[0];
> +			als_info->regs_bmp = cpm_elems[2];
> +			for (i = 0; i < reg_num; i++)
> +				if (als_info->regs_bmp & (1<<i))
> +					chip->conf_regs[i] =
> +						cpm_elems[header_num+i];
> +		}
> +
> +		cpm_elem_count = cm32181_acpi_get_cpm_info(client, "CPM1",
> +							ARRAY_SIZE(cpm_elems),
> +							cpm_elems);
> +		if (cpm_elem_count > 0) {
> +			als_info->mlux_per_bit = (int)cpm_elems[0] / 100;
> +			als_info->calibscale = (int)cpm_elems[1];
> +		}
> +	}
> +#endif /* CONFIG_ACPI */
>
> -	/* Initialize registers*/
> +	/* Force to disable interrupt */
> +	chip->conf_regs[CM32181_REG_ADDR_CMD] &= ~CM32181_CMD_ALS_INT_EN;
> +
> +	/* Initialize registers */
>   	for (i = 0; i < CM32181_CONF_REG_NUM; i++) {
> -		ret = i2c_smbus_write_word_data(client, cm32181_reg[i],
> -			cm32181->conf_regs[i]);
> -		if (ret < 0)
> -			return ret;
> +		if (als_info->regs_bmp & (1<<i)) {
spacing around the <<
> +			ret = i2c_smbus_write_word_data(client, i,
> +						chip->conf_regs[i]);
> +			if (ret < 0)
> +				return ret;
> +		}
>   	}
>
>   	return 0;
> @@ -102,24 +282,25 @@ static int cm32181_reg_init(struct cm32181_chip *cm32181)
>
>   /**
>    *  cm32181_read_als_it() - Get sensor integration time (ms)
> - *  @cm32181:	pointer of struct cm32181
> + *  @chip:	pointer of struct cm32181
>    *  @val2:	pointer of int to load the als_it value.
>    *
> - *  Report the current integartion time by millisecond.
> + *  Report the current integration time in milliseconds.
>    *
>    *  Return: IIO_VAL_INT_PLUS_MICRO for success, otherwise -EINVAL.
>    */
> -static int cm32181_read_als_it(struct cm32181_chip *cm32181, int *val2)
> +static int cm32181_read_als_it(struct cm32181_chip *chip, int *val2)
>   {
> +	struct cm32181_als_info *als_info = chip->als_info;
>   	u16 als_it;
>   	int i;
>
> -	als_it = cm32181->conf_regs[CM32181_REG_ADDR_CMD];
> +	als_it = chip->conf_regs[CM32181_REG_ADDR_CMD];
>   	als_it &= CM32181_CMD_ALS_IT_MASK;
>   	als_it >>= CM32181_CMD_ALS_IT_SHIFT;
> -	for (i = 0; i < ARRAY_SIZE(als_it_bits); i++) {
> -		if (als_it == als_it_bits[i]) {
> -			*val2 = als_it_value[i];
> +	for (i = 0; i < als_info->num_als_it; i++) {
> +		if (als_it == als_info->als_it_bits[i]) {
> +			*val2 = als_info->als_it_values[i];
>   			return IIO_VAL_INT_PLUS_MICRO;
>   		}
>   	}
> @@ -129,99 +310,106 @@ static int cm32181_read_als_it(struct cm32181_chip *cm32181, int *val2)
>
>   /**
>    * cm32181_write_als_it() - Write sensor integration time
> - * @cm32181:	pointer of struct cm32181.
> - * @val:	integration time by millisecond.
> + * @chip:	pointer of struct cm32181.
> + * @val:	integration time in milliseconds.
>    *
>    * Convert integration time (ms) to sensor value.
>    *
>    * Return: i2c_smbus_write_word_data command return value.
>    */
> -static int cm32181_write_als_it(struct cm32181_chip *cm32181, int val)
> +static int cm32181_write_als_it(struct cm32181_chip *chip, int val)
>   {
> -	struct i2c_client *client = cm32181->client;
> +	struct i2c_client *client = chip->client;
> +	struct cm32181_als_info *als_info = chip->als_info;
>   	u16 als_it;
> -	int ret, i, n;
> +	int ret, i;
>
> -	n = ARRAY_SIZE(als_it_value);
> -	for (i = 0; i < n; i++)
> -		if (val <= als_it_value[i])
> +	for (i = 0; i < als_info->num_als_it; i++)
> +		if (val <= als_info->als_it_values[i])
>   			break;
> -	if (i >= n)
> -		i = n - 1;
> +	if (i >= als_info->num_als_it)
> +		i = als_info->num_als_it - 1;
>
> -	als_it = als_it_bits[i];
> +	als_it = als_info->als_it_bits[i];
>   	als_it <<= CM32181_CMD_ALS_IT_SHIFT;
>
> -	mutex_lock(&cm32181->lock);
> -	cm32181->conf_regs[CM32181_REG_ADDR_CMD] &=
> -		~CM32181_CMD_ALS_IT_MASK;
> -	cm32181->conf_regs[CM32181_REG_ADDR_CMD] |=
> -		als_it;
> +	mutex_lock(&chip->lock);
> +	chip->conf_regs[CM32181_REG_ADDR_CMD] &=
> +			~CM32181_CMD_ALS_IT_MASK;
> +	chip->conf_regs[CM32181_REG_ADDR_CMD] |=
> +			als_it;
>   	ret = i2c_smbus_write_word_data(client, CM32181_REG_ADDR_CMD,
> -			cm32181->conf_regs[CM32181_REG_ADDR_CMD]);
> -	mutex_unlock(&cm32181->lock);
> +			chip->conf_regs[CM32181_REG_ADDR_CMD]);
> +	mutex_unlock(&chip->lock);
>
>   	return ret;
>   }
>
>   /**
>    * cm32181_get_lux() - report current lux value
> - * @cm32181:	pointer of struct cm32181.
> + * @chip:	pointer of struct cm32181.
>    *
>    * Convert sensor raw data to lux.  It depends on integration
> - * time and claibscale variable.
> + * time and calibscale variable.
>    *
>    * Return: Positive value is lux, otherwise is error code.
>    */
> -static int cm32181_get_lux(struct cm32181_chip *cm32181)
> +static int cm32181_get_lux(struct cm32181_chip *chip)
>   {
> -	struct i2c_client *client = cm32181->client;
> +	struct i2c_client *client = chip->client;
> +	struct cm32181_als_info *als_info = chip->als_info;
>   	int ret;
>   	int als_it;
> -	unsigned long lux;
> +	u64 tmp;
>
> -	ret = cm32181_read_als_it(cm32181, &als_it);
> +	/* Calculate mlux per bit based on als_it */
> +	ret = cm32181_read_als_it(chip, &als_it);
>   	if (ret < 0)
>   		return -EINVAL;
> -
> -	lux = CM32181_MLUX_PER_BIT;
> -	lux *= CM32181_MLUX_PER_BIT_BASE_IT;
> -	lux /= als_it;
> -
> -	ret = i2c_smbus_read_word_data(client, CM32181_REG_ADDR_ALS);
> -	if (ret < 0)
> -		return ret;
> -
> -	lux *= ret;
> -	lux *= cm32181->calibscale;
> -	lux /= CM32181_CALIBSCALE_RESOLUTION;
> -	lux /= MLUX_PER_LUX;
> -
> -	if (lux > 0xFFFF)
> -		lux = 0xFFFF;
> -
> -	return lux;
> +	tmp = (__force u64)als_info->mlux_per_bit;
> +	tmp *= als_info->mlux_per_bit_base_it;
> +	tmp = div_u64(tmp, als_it);
> +
> +	/* Get als_raw */
> +	if (!(chip->conf_regs[CM32181_REG_ADDR_CMD] & CM32181_CMD_ALS_INT_EN))
> +		als_info->als_raw = i2c_smbus_read_word_data(
> +					client,
> +					CM32181_REG_ADDR_ALS);
> +	if (als_info->als_raw < 0)
> +		return als_info->als_raw;
> +
> +	tmp *= als_info->als_raw;
> +	tmp *= als_info->calibscale;
> +	tmp = div_u64(tmp, CM32181_CALIBSCALE_RESOLUTION);
> +	tmp = div_u64(tmp, CM32181_MLUX_PER_LUX);
> +
> +	if (tmp > 0xFFFF)
> +		tmp = 0xFFFF;
> +
> +	return (int)tmp;
>   }
>
>   static int cm32181_read_raw(struct iio_dev *indio_dev,
> -			    struct iio_chan_spec const *chan,
> -			    int *val, int *val2, long mask)
> +			struct iio_chan_spec const *chan,
> +			int *val, int *val2, long mask)
>   {
> -	struct cm32181_chip *cm32181 = iio_priv(indio_dev);
> +	struct cm32181_chip *chip = iio_priv(indio_dev);
> +	struct cm32181_als_info *als_info = chip->als_info;
>   	int ret;
>
>   	switch (mask) {
>   	case IIO_CHAN_INFO_PROCESSED:
> -		ret = cm32181_get_lux(cm32181);
> +		ret = cm32181_get_lux(chip);
>   		if (ret < 0)
>   			return ret;
>   		*val = ret;
>   		return IIO_VAL_INT;
>   	case IIO_CHAN_INFO_CALIBSCALE:
> -		*val = cm32181->calibscale;
> +		*val = als_info->calibscale;
>   		return IIO_VAL_INT;
>   	case IIO_CHAN_INFO_INT_TIME:
> -		ret = cm32181_read_als_it(cm32181, val2);
> +		*val = 0;
Don't bother with the intermediate ret.
       return cm32181_read_als_it(chip, val2);
> +		ret = cm32181_read_als_it(chip, val2);
>   		return ret;
>   	}
>
> @@ -229,19 +417,20 @@ static int cm32181_read_raw(struct iio_dev *indio_dev,
>   }
>
>   static int cm32181_write_raw(struct iio_dev *indio_dev,
> -			     struct iio_chan_spec const *chan,
> -			     int val, int val2, long mask)
> +			struct iio_chan_spec const *chan,
> +			int val, int val2, long mask)
>   {
> -	struct cm32181_chip *cm32181 = iio_priv(indio_dev);
> -	int ret;
> +	struct cm32181_chip *chip = iio_priv(indio_dev);
> +	struct cm32181_als_info *als_info = chip->als_info;
> +	long ms;
>
>   	switch (mask) {
>   	case IIO_CHAN_INFO_CALIBSCALE:
> -		cm32181->calibscale = val;
> +		als_info->calibscale = val;
>   		return val;
>   	case IIO_CHAN_INFO_INT_TIME:
> -		ret = cm32181_write_als_it(cm32181, val2);
> -		return ret;
> +		ms = val * 1000000 + val2;
> +		return cm32181_write_als_it(chip, (int)ms);
>   	}
>
>   	return -EINVAL;
> @@ -253,19 +442,107 @@ static int cm32181_write_raw(struct iio_dev *indio_dev,
>    * @attr:	pointer of struct device_attribute.
>    * @buf:	pointer of return string buffer.
>    *
> - * Display the available integration time values by millisecond.
> + * Display the available integration time in milliseconds.
>    *
>    * Return: string length.
>    */
>   static ssize_t cm32181_get_it_available(struct device *dev,
>   			struct device_attribute *attr, char *buf)
>   {
> -	int i, n, len;
> +	struct cm32181_chip *chip = iio_priv(dev_to_iio_dev(dev));
> +	struct cm32181_als_info *als_info = chip->als_info;
> +	int i, len;
> +
> +	for (i = 0, len = 0; i < als_info->num_als_it; i++)
> +		len += scnprintf(buf + len, PAGE_SIZE - len, "%u.%06u ",
> +			als_info->als_it_values[i]/1000000,
> +			als_info->als_it_values[i]%1000000);
> +	return len + scnprintf(buf + len, PAGE_SIZE - len, "\n");
> +}
> +
> +/**
> + * cm32181_threshold_update() - Update the threshold registers.
> + * @chip:	pointer of struct cm32181_chip.
> + * @percent:	+/- percent.
> + *
> + * Based on the current ALS value, update the hi and low threshold registers.
> + *
> + * Return: 0 for success; otherwise for error code.
> + */
> +static int cm32181_threshold_update(struct cm32181_chip *chip, int percent)
> +{
> +	struct i2c_client *client = chip->client;
> +	struct cm32181_als_info *als_info = chip->als_info;
> +	int ret;
> +	int wh, wl;
> +
> +	ret = als_info->als_raw = i2c_smbus_read_word_data(client,
> +					CM32181_REG_ADDR_ALS);
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
> +	chip->conf_regs[CM32181_REG_ADDR_WH] = wh;
> +	ret = i2c_smbus_write_word_data(
> +		client,
> +		CM32181_REG_ADDR_WH,
> +		chip->conf_regs[CM32181_REG_ADDR_WH]);
> +	if (ret < 0)
> +		return ret;
>
> -	n = ARRAY_SIZE(als_it_value);
> -	for (i = 0, len = 0; i < n; i++)
> -		len += sprintf(buf + len, "0.%06u ", als_it_value[i]);
> -	return len + sprintf(buf + len, "\n");
> +	chip->conf_regs[CM32181_REG_ADDR_WL] = wl;
> +	ret = i2c_smbus_write_word_data(
> +		client,
> +		CM32181_REG_ADDR_WL,
> +		chip->conf_regs[CM32181_REG_ADDR_WL]);
> +
> +	return ret;
> +}
> +
> +/**
> + * cm32181_event_handler() - Interrupt handling routine.
> + * @irq:	irq number.
> + * @private:	pointer of void.
> + *
> + * Clean interrupt and reset threshold registers.
> + *
> + * Return: IRQ_HANDLED.
> + */
> +static irqreturn_t cm32181_event_handler(int irq, void *private)
> +{
> +	struct iio_dev *dev_info = private;
> +	struct cm32181_chip *chip = iio_priv(dev_info);
> +	int ret;
> +
> +	mutex_lock(&chip->lock);
> +
> +	/* Disable interrupt */
> +	ret = cm32181_interrupt_config(chip, 0);
> +	if (ret < 0)
> +		goto error_handler_unlock;
> +
> +	/* Update Hi/Lo windows */
> +	ret = cm32181_threshold_update(chip, CM32181_THRESHOLD_PERCENT);
> +	if (ret < 0)
> +		goto error_handler_unlock;
> +
> +	/* Enable interrupt */
> +	cm32181_interrupt_config(chip, 1);
> +
> +error_handler_unlock:
> +	mutex_unlock(&chip->lock);
> +	return IRQ_HANDLED;
>   }
>
>   static const struct iio_chan_spec cm32181_channels[] = {
> @@ -300,29 +577,32 @@ static const struct iio_info cm32181_info = {
>   static int cm32181_probe(struct i2c_client *client,
>   			const struct i2c_device_id *id)
>   {
> -	struct cm32181_chip *cm32181;
> +	struct cm32181_chip *chip;
This is almost universally gaining the naming cm32181_state *st;
but I don't really care.
>   	struct iio_dev *indio_dev;
>   	int ret;
>
> -	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*cm32181));
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*chip));
>   	if (!indio_dev) {
>   		dev_err(&client->dev, "devm_iio_device_alloc failed\n");
>   		return -ENOMEM;
>   	}
>
> -	cm32181 = iio_priv(indio_dev);
> +	chip = iio_priv(indio_dev);
>   	i2c_set_clientdata(client, indio_dev);
> -	cm32181->client = client;
> +	chip->client = client;
>
> -	mutex_init(&cm32181->lock);
> +	mutex_init(&chip->lock);
>   	indio_dev->dev.parent = &client->dev;
>   	indio_dev->channels = cm32181_channels;
>   	indio_dev->num_channels = ARRAY_SIZE(cm32181_channels);
>   	indio_dev->info = &cm32181_info;
> -	indio_dev->name = id->name;
> +	if (id && id->name)
> +		indio_dev->name = id->name;
> +	else
> +		indio_dev->name = (char *)dev_name(&client->dev);
>   	indio_dev->modes = INDIO_DIRECT_MODE;
>
> -	ret = cm32181_reg_init(cm32181);
> +	ret = cm32181_reg_init(chip);
>   	if (ret) {
>   		dev_err(&client->dev,
>   			"%s: register init failed\n",
> @@ -330,27 +610,63 @@ static int cm32181_probe(struct i2c_client *client,
>   		return ret;
>   	}
>
> +	if (client->irq) {
> +		ret = request_threaded_irq(client->irq,
> +					NULL,
> +					cm32181_event_handler,
> +					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +					"cm32181_event",
> +					indio_dev);
> +
> +		if (ret < 0) {
> +			dev_err(&client->dev, "irq request error %d\n",
> +				-ret);
> +			goto error_disable_int;
> +		}
> +	}
> +
>   	ret = iio_device_register(indio_dev);
> -	if (ret) {
> +	if (ret < 0) {
>   		dev_err(&client->dev,
>   			"%s: regist device failed\n",
>   			__func__);
> -		return ret;
> +		goto error_free_irq;
> +	}
> +
Unless we have a bug, you should be fine doing this before the device register
and hence simplify this probe function somewhat.  Given the events are
not exposed to userspace? you should be fine doing this earlier...
I'm not sure I'm keen on the complete lack of exposure, but I guess it doesn't
break the abi, so if it is what you want to do, fair enough...
(not sure what the point is though...) If you were exposing them to userspace
you would want to bring up the device with them disabled so this reordering
would make sense anyway.

> +	if (client->irq) {
> +		ret = cm32181_threshold_update(chip, CM32181_THRESHOLD_PERCENT);
> +		if (ret < 0)
> +			goto error_free_irq;
> +
> +		ret = cm32181_interrupt_config(chip, 1);
> +		if (ret < 0)
> +			goto error_free_irq;
>   	}
>
>   	return 0;
> +
> +error_free_irq:
> +	if (client->irq)
> +		free_irq(client->irq, indio_dev);
> +error_disable_int:
> +	cm32181_interrupt_config(chip, 0);
This disables the interrupt in the hardware after removing the handler?

Seems like a recipe for disaster and a sure sign of an ordering issue above.

> +	return ret;
>   }
>
>   static int cm32181_remove(struct i2c_client *client)
>   {
>   	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +	struct cm32181_chip *chip = iio_priv(indio_dev);
>
> +	cm32181_interrupt_config(chip, 0);
> +	if (client->irq)
> +		free_irq(client->irq, indio_dev);
>   	iio_device_unregister(indio_dev);
If you are doing a cleanup patch, a blank line here would be nice.
>   	return 0;
>   }
>
>   static const struct i2c_device_id cm32181_id[] = {
> -	{ "cm32181", 0 },
> +	{ "cm32181", 0},
Exactly the sort of cleanup that should be in a preceding patch
before anything interesting.
>   	{ }
>   };
>
> @@ -361,13 +677,25 @@ static const struct of_device_id cm32181_of_match[] = {
>   	{ }
>   };
>
> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id cm32181_acpi_match[] = {
> +	{ "CPLM3218", 0},
Given you fixed the spacing above, please get it right here too ;)
> +	{},
> +};
> +
> +MODULE_DEVICE_TABLE(acpi, cm32181_acpi_match);
> +#endif /* CONFIG_ACPI */
> +
>   static struct i2c_driver cm32181_driver = {
>   	.driver = {
>   		.name	= "cm32181",
> +#ifdef CONFIG_ACPI
> +		.acpi_match_table = ACPI_PTR(cm32181_acpi_match),
> +#endif /* CONFIG_ACPI */
>   		.of_match_table = of_match_ptr(cm32181_of_match),
>   		.owner	= THIS_MODULE,
>   	},
> -	.id_table       = cm32181_id,
> +	.id_table	= cm32181_id,
>   	.probe		= cm32181_probe,
>   	.remove		= cm32181_remove,
>   };
>

