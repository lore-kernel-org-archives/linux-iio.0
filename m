Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43373 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752707AbcDJLca (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 10 Apr 2016 07:32:30 -0400
Subject: Re: [PATCH] iio: pressure: bmp280: add support for BMP180
To: Akinobu Mita <akinobu.mita@gmail.com>, linux-iio@vger.kernel.org
References: <1460044621-17274-1-git-send-email-akinobu.mita@gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Cc: Vlad Dogaru <vlad.dogaru@intel.com>,
	Christoph Mair <christoph.mair@gmail.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Message-ID: <570A39CB.9060901@kernel.org>
Date: Sun, 10 Apr 2016 12:32:27 +0100
MIME-Version: 1.0
In-Reply-To: <1460044621-17274-1-git-send-email-akinobu.mita@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/04/16 16:57, Akinobu Mita wrote:
> This adds support for the BMP180 to the bmp280 iio driver.
> The BMP180 has already been supported by misc/bmp085 driver but it
> doesn't use iio framework.
> 
> This also adds ability to control the oversampling ratio of the
> temperature and pressure measurement for both bmp180 and bmp280.
> (bmp280 is untested)
> 
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> Cc: Vlad Dogaru <vlad.dogaru@intel.com>
> Cc: Christoph Mair <christoph.mair@gmail.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald <pmeerw@pmeerw.net>
I absolutely agree that this should be two patches, one for the device
support and one for the oversampling support.

A few suggestions on how to simplify the code inline.

Also, we need to be careful in Kconfig whilst we have two drivers supporting
the chip.  They probably need to depend on the other one not being selected
to avoid any issues.

J
> ---
>  drivers/iio/pressure/Kconfig  |   4 +-
>  drivers/iio/pressure/bmp280.c | 574 +++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 548 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
> index e8f60db..c9131f8 100644
> --- a/drivers/iio/pressure/Kconfig
> +++ b/drivers/iio/pressure/Kconfig
> @@ -6,11 +6,11 @@
>  menu "Pressure sensors"
>  
>  config BMP280
> -	tristate "Bosch Sensortec BMP280 pressure sensor driver"
> +	tristate "Bosch Sensortec BMP180 and BMP280 pressure sensor driver"
>  	depends on I2C
>  	select REGMAP_I2C
>  	help
> -	 Say yes here to build support for Bosch Sensortec BMP280
> +	 Say yes here to build support for Bosch Sensortec BMP180 and BMP280
>  	 pressure and temperature sensor.
>  
>  	 To compile this driver as a module, choose M here: the module
> diff --git a/drivers/iio/pressure/bmp280.c b/drivers/iio/pressure/bmp280.c
> index a2602d8..8f64012 100644
> --- a/drivers/iio/pressure/bmp280.c
> +++ b/drivers/iio/pressure/bmp280.c
> @@ -1,12 +1,15 @@
>  /*
>   * Copyright (c) 2014 Intel Corporation
>   *
> - * Driver for Bosch Sensortec BMP280 digital pressure sensor.
> + * Driver for Bosch Sensortec BMP180 and BMP280 digital pressure sensor.
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License version 2 as
>   * published by the Free Software Foundation.
>   *
> + * Datasheet:
> + * https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BMP180-DS000-121.pdf
> + * https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BMP280-DS001-12.pdf
>   */
>  
>  #define pr_fmt(fmt) "bmp280: " fmt
> @@ -15,9 +18,13 @@
>  #include <linux/i2c.h>
>  #include <linux/acpi.h>
>  #include <linux/regmap.h>
> +#include <linux/delay.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  
> +/*
> + * BMP280 specific registers
> + */
>  #define BMP280_REG_TEMP_XLSB		0xFC
>  #define BMP280_REG_TEMP_LSB		0xFB
>  #define BMP280_REG_TEMP_MSB		0xFA
> @@ -26,10 +33,7 @@
>  #define BMP280_REG_PRESS_MSB		0xF7
>  
>  #define BMP280_REG_CONFIG		0xF5
> -#define BMP280_REG_CTRL_MEAS		0xF4
>  #define BMP280_REG_STATUS		0xF3
> -#define BMP280_REG_RESET		0xE0
> -#define BMP280_REG_ID			0xD0
>  
>  #define BMP280_REG_COMP_TEMP_START	0x88
>  #define BMP280_COMP_TEMP_REG_COUNT	6
> @@ -46,25 +50,53 @@
>  
>  #define BMP280_OSRS_TEMP_MASK		(BIT(7) | BIT(6) | BIT(5))
>  #define BMP280_OSRS_TEMP_SKIP		0
> -#define BMP280_OSRS_TEMP_1X		BIT(5)
> -#define BMP280_OSRS_TEMP_2X		BIT(6)
> -#define BMP280_OSRS_TEMP_4X		(BIT(6) | BIT(5))
> -#define BMP280_OSRS_TEMP_8X		BIT(7)
> -#define BMP280_OSRS_TEMP_16X		(BIT(7) | BIT(5))
> +#define BMP280_OSRS_TEMP_X(osrs_t)	((osrs_t) << 5)
> +#define BMP280_OSRS_TEMP_1X		BMP280_OSRS_TEMP_X(1)
> +#define BMP280_OSRS_TEMP_2X		BMP280_OSRS_TEMP_X(2)
> +#define BMP280_OSRS_TEMP_4X		BMP280_OSRS_TEMP_X(3)
> +#define BMP280_OSRS_TEMP_8X		BMP280_OSRS_TEMP_X(4)
> +#define BMP280_OSRS_TEMP_16X		BMP280_OSRS_TEMP_X(5)
>  
>  #define BMP280_OSRS_PRESS_MASK		(BIT(4) | BIT(3) | BIT(2))
>  #define BMP280_OSRS_PRESS_SKIP		0
> -#define BMP280_OSRS_PRESS_1X		BIT(2)
> -#define BMP280_OSRS_PRESS_2X		BIT(3)
> -#define BMP280_OSRS_PRESS_4X		(BIT(3) | BIT(2))
> -#define BMP280_OSRS_PRESS_8X		BIT(4)
> -#define BMP280_OSRS_PRESS_16X		(BIT(4) | BIT(2))
> +#define BMP280_OSRS_PRESS_X(osrs_p)	((osrs_p) << 2)
> +#define BMP280_OSRS_PRESS_1X		BMP280_OSRS_PRESS_X(1)
> +#define BMP280_OSRS_PRESS_2X		BMP280_OSRS_PRESS_X(2)
> +#define BMP280_OSRS_PRESS_4X		BMP280_OSRS_PRESS_X(3)
> +#define BMP280_OSRS_PRESS_8X		BMP280_OSRS_PRESS_X(4)
> +#define BMP280_OSRS_PRESS_16X		BMP280_OSRS_PRESS_X(5)
>  
>  #define BMP280_MODE_MASK		(BIT(1) | BIT(0))
>  #define BMP280_MODE_SLEEP		0
>  #define BMP280_MODE_FORCED		BIT(0)
>  #define BMP280_MODE_NORMAL		(BIT(1) | BIT(0))
>  
> +/*
> + * BMP180 specific registers
> + */
> +#define BMP180_REG_OUT_XLSB		0xF8
> +#define BMP180_REG_OUT_LSB		0xF7
> +#define BMP180_REG_OUT_MSB		0xF6
> +
> +#define BMP180_REG_CALIB_START		0xAA
> +#define BMP180_REG_CALIB_COUNT		22
> +
> +#define BMP180_MEAS_SCO			BIT(5)
> +#define BMP180_MEAS_TEMP		(0x0E | BMP180_MEAS_SCO)
> +#define BMP180_MEAS_PRESS_X(oss)	((oss) << 6 | 0x14 | BMP180_MEAS_SCO)
> +#define BMP180_MEAS_PRESS_1X		BMP180_MEAS_PRESS_X(0)
> +#define BMP180_MEAS_PRESS_2X		BMP180_MEAS_PRESS_X(1)
> +#define BMP180_MEAS_PRESS_4X		BMP180_MEAS_PRESS_X(2)
> +#define BMP180_MEAS_PRESS_8X		BMP180_MEAS_PRESS_X(3)
> +
> +/*
> + * BMP180 and BMP280 common registers
> + */
> +#define BMP280_REG_CTRL_MEAS		0xF4
> +#define BMP280_REG_RESET		0xE0
> +#define BMP280_REG_ID			0xD0
> +
> +#define BMP180_CHIP_ID			0x55
>  #define BMP280_CHIP_ID			0x58
>  #define BMP280_SOFT_RESET_VAL		0xB6
>  
> @@ -72,6 +104,15 @@ struct bmp280_data {
>  	struct i2c_client *client;
>  	struct mutex lock;
>  	struct regmap *regmap;
> +	const struct bmp280_ops *ops;
I'd define this slightly differently as say
const struct bmp280_chip_info  and include all the ops as well as the
various other elements in here that you set depending on which chip it is.

The big assignment in probe should be done in one line rather than 10ish.

> +
> +	const int *oversampling_temp_avail;
> +	int num_oversampling_temp_avail;
> +	const int *oversampling_press_avail;
> +	int num_oversampling_press_avail;
> +
> +	u8 oversampling_press;
> +	u8 oversampling_temp;
>  
>  	/*
>  	 * Carryover value from temperature conversion, used in pressure
> @@ -80,9 +121,15 @@ struct bmp280_data {
>  	s32 t_fine;
>  };
>  
> +struct bmp280_ops {
> +	int (*init)(struct bmp280_data *);
> +	int (*read_temp)(struct bmp280_data *, int *);
> +	int (*read_press)(struct bmp280_data *, int *, int *);
> +};
> +
>  /*
>   * These enums are used for indexing into the array of compensation
> - * parameters.
> + * parameters for BMP280.
>   */
>  enum { T1, T2, T3 };
>  enum { P1, P2, P3, P4, P5, P6, P7, P8, P9 };
> @@ -90,11 +137,13 @@ enum { P1, P2, P3, P4, P5, P6, P7, P8, P9 };
>  static const struct iio_chan_spec bmp280_channels[] = {
>  	{
>  		.type = IIO_PRESSURE,
> -		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> +				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
>  	},
>  	{
>  		.type = IIO_TEMP,
> -		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> +				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
>  	},
>  };
>  
> @@ -290,10 +339,25 @@ static int bmp280_read_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_PROCESSED:
>  		switch (chan->type) {
>  		case IIO_PRESSURE:
> -			ret = bmp280_read_press(data, val, val2);
> +			ret = data->ops->read_press(data, val, val2);
> +			break;
> +		case IIO_TEMP:
> +			ret = data->ops->read_temp(data, val);
> +			break;
> +		default:
> +			ret = -EINVAL;
> +			break;
> +		}
> +		break;
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		switch (chan->type) {
> +		case IIO_PRESSURE:
> +			*val = 1 << data->oversampling_press;
> +			ret = IIO_VAL_INT;
>  			break;
>  		case IIO_TEMP:
> -			ret = bmp280_read_temp(data, val);
> +			*val = 1 << data->oversampling_temp;
> +			ret = IIO_VAL_INT;
>  			break;
>  		default:
>  			ret = -EINVAL;
> @@ -310,22 +374,135 @@ static int bmp280_read_raw(struct iio_dev *indio_dev,
>  	return ret;
>  }
>  
> +static int bmp280_write_oversampling_ratio_temp(struct bmp280_data *data,
> +					       int val)
> +{
> +	int i;
> +	const int *avail = data->oversampling_temp_avail;
> +	const int n = data->num_oversampling_temp_avail;
> +
> +	for (i = 0; i < n; i++) {
> +		if (avail[i] == val) {
> +			data->oversampling_temp = ilog2(val);
> +
> +			return data->ops->init(data);
> +		}
> +	}
> +	return -EINVAL;
> +}
> +
> +static int bmp280_write_oversampling_ratio_press(struct bmp280_data *data,
> +					       int val)
> +{
> +	int i;
> +	const int *avail = data->oversampling_press_avail;
> +	const int n = data->num_oversampling_press_avail;
> +
> +	for (i = 0; i < n; i++) {
> +		if (avail[i] == val) {
> +			data->oversampling_press = ilog2(val);
> +
> +			return data->ops->init(data);
> +		}
> +	}
> +	return -EINVAL;
> +}
> +
> +static int bmp280_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int val, int val2, long mask)
> +{
> +	int ret = 0;
> +	struct bmp280_data *data = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		mutex_lock(&data->lock);
> +		switch (chan->type) {
> +		case IIO_PRESSURE:
> +			ret = bmp280_write_oversampling_ratio_press(data, val);
> +			break;
> +		case IIO_TEMP:
> +			ret = bmp280_write_oversampling_ratio_temp(data, val);
> +			break;
> +		default:
> +			ret = -EINVAL;
> +			break;
> +		}
> +		mutex_unlock(&data->lock);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static ssize_t bmp280_show_avail(char *buf, const int *vals, const int n)
> +{
> +	size_t len = 0;
> +	int i;
> +
> +	for (i = 0; i < n; i++)
> +		len += scnprintf(buf + len, PAGE_SIZE - len, "%d ", vals[i]);
> +
> +	buf[len - 1] = '\n';
> +
> +	return len;
> +}
> +
> +static ssize_t bmp280_show_temp_oversampling_avail(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	struct bmp280_data *data = iio_priv(dev_to_iio_dev(dev));
> +
> +	return bmp280_show_avail(buf, data->oversampling_temp_avail,
> +				 data->num_oversampling_temp_avail);
> +}
> +
> +static ssize_t bmp280_show_press_oversampling_avail(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	struct bmp280_data *data = iio_priv(dev_to_iio_dev(dev));
> +
> +	return bmp280_show_avail(buf, data->oversampling_press_avail,
> +				 data->num_oversampling_press_avail);
> +}
> +
> +static IIO_DEVICE_ATTR(in_temp_oversampling_ratio_available,
> +	S_IRUGO, bmp280_show_temp_oversampling_avail, NULL, 0);
> +
> +static IIO_DEVICE_ATTR(in_pressure_oversampling_ratio_available,
> +	S_IRUGO, bmp280_show_press_oversampling_avail, NULL, 0);
> +
> +static struct attribute *bmp280_attributes[] = {
> +	&iio_dev_attr_in_temp_oversampling_ratio_available.dev_attr.attr,
> +	&iio_dev_attr_in_pressure_oversampling_ratio_available.dev_attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group bmp280_attrs_group = {
> +	.attrs = bmp280_attributes,
> +};
> +
>  static const struct iio_info bmp280_info = {
>  	.driver_module = THIS_MODULE,
>  	.read_raw = &bmp280_read_raw,
> +	.write_raw = &bmp280_write_raw,
> +	.attrs = &bmp280_attrs_group,
>  };
>  
>  static int bmp280_chip_init(struct bmp280_data *data)
>  {
>  	int ret;
> +	u8 osrs = BMP280_OSRS_TEMP_X(data->oversampling_temp) |
> +		  BMP280_OSRS_PRESS_X(data->oversampling_press);
>  
>  	ret = regmap_update_bits(data->regmap, BMP280_REG_CTRL_MEAS,
>  				 BMP280_OSRS_TEMP_MASK |
>  				 BMP280_OSRS_PRESS_MASK |
>  				 BMP280_MODE_MASK,
> -				 BMP280_OSRS_TEMP_2X |
> -				 BMP280_OSRS_PRESS_16X |
> -				 BMP280_MODE_NORMAL);
> +				 osrs | BMP280_MODE_NORMAL);
>  	if (ret < 0) {
>  		dev_err(&data->client->dev,
>  			"failed to write ctrl_meas register\n");
> @@ -344,12 +521,315 @@ static int bmp280_chip_init(struct bmp280_data *data)
>  	return ret;
>  }
>  
> +static const int bmp280_oversampling_avail[] = { 1, 2, 4, 8, 16 };
> +
> +static const struct bmp280_ops bmp280_ops = {
> +	.init = bmp280_chip_init,
> +	.read_temp = bmp280_read_temp,
> +	.read_press = bmp280_read_press,
> +};
> +
> +static bool bmp180_is_writeable_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case BMP280_REG_CTRL_MEAS:
> +	case BMP280_REG_RESET:
> +		return true;
> +	default:
> +		return false;
> +	};
> +}
> +
> +static bool bmp180_is_volatile_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case BMP180_REG_OUT_XLSB:
> +	case BMP180_REG_OUT_LSB:
> +	case BMP180_REG_OUT_MSB:
> +	case BMP280_REG_CTRL_MEAS:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static const struct regmap_config bmp180_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +
> +	.max_register = BMP180_REG_OUT_XLSB,
> +	.cache_type = REGCACHE_RBTREE,
> +
> +	.writeable_reg = bmp180_is_writeable_reg,
> +	.volatile_reg = bmp180_is_volatile_reg,
> +};
> +
> +static int bmp180_measure(struct bmp280_data *data, u8 ctrl_meas)
> +{
> +	int ret;
> +	const int conversion_time_max[] = { 4500, 7500, 13500, 25500 };
> +	unsigned int delay_us;
> +	unsigned int ctrl;
> +
> +	ret = regmap_write(data->regmap, BMP280_REG_CTRL_MEAS, ctrl_meas);
> +	if (ret)
> +		return ret;
> +
> +	if (ctrl_meas == BMP180_MEAS_TEMP)
> +		delay_us = 4500;
> +	else
> +		delay_us = conversion_time_max[data->oversampling_press];
> +
> +	usleep_range(delay_us, delay_us + 1000);
> +
> +	ret = regmap_read(data->regmap, BMP280_REG_CTRL_MEAS, &ctrl);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * The value of this bit reset to "0" after conversion is complete
> +	 */
> +	if (ctrl & BMP180_MEAS_SCO)
> +		return -EIO;
> +
> +	return 0;
> +}
> +
> +static int bmp180_read_adc_temp(struct bmp280_data *data, int *val)
> +{
> +	int ret;
> +	__be16 tmp = 0;
> +
> +	ret = bmp180_measure(data, BMP180_MEAS_TEMP);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_bulk_read(data->regmap, BMP180_REG_OUT_MSB, (u8 *)&tmp, 2);
> +	if (ret)
> +		return ret;
> +
> +	*val = be16_to_cpu(tmp);
> +
> +	return 0;
> +}
> +
> +/*
> + * These enums are used for indexing into the array of calibration
> + * coefficients for BMP180.
> + */
> +enum { AC1, AC2, AC3, AC4, AC5, AC6, B1, B2, MB, MC, MD };
> +
> +struct bmp180_calib {
> +	s32 AC1;
> +	s32 AC2;
> +	s32 AC3;
> +	u32 AC4;
> +	u32 AC5;
> +	u32 AC6;
> +	s32 B1;
> +	s32 B2;
> +	s32 MB;
> +	s32 MC;
> +	s32 MD;
> +};
> +
> +static int bmp180_read_calib(struct bmp280_data *data,
> +			     struct bmp180_calib *calib)
> +{
> +	int ret;
> +	int i;
> +	__be16 buf[BMP180_REG_CALIB_COUNT / 2];
> +
> +	ret = regmap_bulk_read(data->regmap, BMP180_REG_CALIB_START, buf,
> +			       sizeof(buf));
> +
> +	/*
> +	 * None of the words has the value 0 or 0xFFFF
> +	 */
> +	for (i = 0; i < ARRAY_SIZE(buf); i++) {
> +		if (buf[i] == be16_to_cpu(0) || buf[i] == be16_to_cpu(0xffff))
> +			return -EIO;
> +	}
> +
> +	/*
> +	 * The double casts are necessary because be16_to_cpu returns an
> +	 * unsigned 16-bit value.  Casting that value directly to a
> +	 * signed 32-bit will not do proper sign extension.
> +	 *
> +	 * Conversely, AC4, AC5 and AC6 are unsigned values, so they can be
> +	 * cast straight to the larger type.
> +	 */
> +	calib->AC1 = (s32)(s16)be16_to_cpu(buf[AC1]);
> +	calib->AC2 = (s32)(s16)be16_to_cpu(buf[AC2]);
> +	calib->AC3 = (s32)(s16)be16_to_cpu(buf[AC3]);
> +	calib->AC4 = be16_to_cpu(buf[AC4]);
> +	calib->AC5 = be16_to_cpu(buf[AC5]);
> +	calib->AC6 = be16_to_cpu(buf[AC6]);
> +	calib->B1 = (s32)(s16)be16_to_cpu(buf[B1]);
> +	calib->B2 = (s32)(s16)be16_to_cpu(buf[B2]);
> +	calib->MB = (s32)(s16)be16_to_cpu(buf[MB]);
> +	calib->MC = (s32)(s16)be16_to_cpu(buf[MC]);
> +	calib->MD = (s32)(s16)be16_to_cpu(buf[MD]);
> +
> +	return 0;
> +}
> +
> +/*
> + * Returns temperature in DegC, resolution is 0.1 DegC.
> + * t_fine carries fine temperature as global value.
> + *
> + * Taken from datasheet, Section 3.5, "Calculating pressure and temperature".
> + */
> +static s32 bmp180_compensate_temp(struct bmp280_data *data, s32 adc_temp)
> +{
> +	int ret;
> +	s32 x1, x2;
> +	struct bmp180_calib calib;
> +
> +	ret = bmp180_read_calib(data, &calib);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev,
> +			"failed to read calibration coefficients\n");
> +		return ret;
> +	}
> +
> +	x1 = ((adc_temp - calib.AC6) * calib.AC5) >> 15;
> +	x2 = (calib.MC << 11) / (x1 + calib.MD);
> +	data->t_fine = x1 + x2;
> +
> +	return (data->t_fine + 8) >> 4;
> +}
> +
> +static int bmp180_read_temp(struct bmp280_data *data, int *val)
> +{
> +	int ret;
> +	s32 adc_temp, comp_temp;
> +
> +	ret = bmp180_read_adc_temp(data, &adc_temp);
> +	if (ret)
> +		return ret;
> +
> +	comp_temp = bmp180_compensate_temp(data, adc_temp);
> +
> +	/*
> +	 * val might be NULL if we're called by the read_press routine,
> +	 * who only cares about the carry over t_fine value.
> +	 */
> +	if (val) {
> +		*val = comp_temp * 100;
> +		return IIO_VAL_INT;
> +	}
> +
> +	return 0;
> +}
> +
> +static int bmp180_read_adc_press(struct bmp280_data *data, int *val)
> +{
> +	int ret;
> +	__be32 tmp = 0;
> +	u8 oss = data->oversampling_press;
> +
> +	ret = bmp180_measure(data, BMP180_MEAS_PRESS_X(oss));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_bulk_read(data->regmap, BMP180_REG_OUT_MSB, (u8 *)&tmp, 3);
> +	if (ret)
> +		return ret;
> +
> +	*val = (be32_to_cpu(tmp) >> 8) >> (8 - oss);
> +
> +	return 0;
> +}
> +
> +/*
> + * Returns pressure in Pa, resolution is 1 Pa.
> + *
> + * Taken from datasheet, Section 3.5, "Calculating pressure and temperature".
> + */
> +static u32 bmp180_compensate_press(struct bmp280_data *data, s32 adc_press)
> +{
> +	int ret;
> +	s32 x1, x2, x3, p;
> +	s32 b3, b6;
> +	u32 b4, b7;
> +	s32 oss = data->oversampling_press;
> +	struct bmp180_calib calib;
> +
> +	ret = bmp180_read_calib(data, &calib);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev,
> +			"failed to read calibration coefficients\n");
> +		return ret;
> +	}
> +
> +	b6 = data->t_fine - 4000;
> +	x1 = (calib.B2 * (b6 * b6 >> 12)) >> 11;
> +	x2 = calib.AC2 * b6 >> 11;
> +	x3 = x1 + x2;
> +	b3 = (((calib.AC1 * 4 + x3) << oss) + 2) / 4;
> +	x1 = calib.AC3 * b6 >> 13;
> +	x2 = (calib.B1 * ((b6 * b6) >> 12)) >> 16;
> +	x3 = (x1 + x2 + 2) >> 2;
> +	b4 = calib.AC4 * (u32)(x3 + 32768) >> 15;
> +	b7 = ((u32)adc_press - b3) * (50000 >> oss);
> +	if (b7 < 0x80000000)
> +		p = (b7 * 2) / b4;
> +	else
> +		p = (b7 / b4) * 2;
> +
> +	x1 = (p >> 8) * (p >> 8);
> +	x1 = (x1 * 3038) >> 16;
> +	x2 = (-7357 * p) >> 16;
> +
> +	return p + ((x1 + x2 + 3791) >> 4);
> +}
> +
> +static int bmp180_read_press(struct bmp280_data *data,
> +			     int *val, int *val2)
> +{
> +	int ret;
> +	s32 adc_press;
> +	u32 comp_press;
> +
> +	/* Read and compensate temperature so we get a reading of t_fine. */
> +	ret = bmp180_read_temp(data, NULL);
> +	if (ret)
> +		return ret;
> +
> +	ret = bmp180_read_adc_press(data, &adc_press);
> +	if (ret)
> +		return ret;
> +
> +	comp_press = bmp180_compensate_press(data, adc_press);
> +
> +	*val = comp_press;
> +	*val2 = 1000;
> +
> +	return IIO_VAL_FRACTIONAL;
> +}
> +
> +static int bmp180_chip_init(struct bmp280_data *data)
> +{
> +	return 0;
> +}
> +
> +static const int bmp180_oversampling_temp_avail[] = { 1 };
> +static const int bmp180_oversampling_press_avail[] = { 1, 2, 4, 8 };
> +
> +static const struct bmp280_ops bmp180_ops = {
> +	.read_temp = bmp180_read_temp,
> +	.read_press = bmp180_read_press,
> +	.init = bmp180_chip_init,
> +};
> +
>  static int bmp280_probe(struct i2c_client *client,
>  			const struct i2c_device_id *id)
>  {
>  	int ret;
>  	struct iio_dev *indio_dev;
>  	struct bmp280_data *data;
> +	const struct regmap_config *config;
>  	unsigned int chip_id;
>  
>  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> @@ -367,7 +847,43 @@ static int bmp280_probe(struct i2c_client *client,
>  	indio_dev->info = &bmp280_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
> -	data->regmap = devm_regmap_init_i2c(client, &bmp280_regmap_config);
> +	switch (id->driver_data) {
> +	case BMP180_CHIP_ID:
> +		data->ops = &bmp180_ops;
> +
> +		data->oversampling_press_avail =
> +			bmp180_oversampling_press_avail;
> +		data->num_oversampling_press_avail =
> +			ARRAY_SIZE(bmp180_oversampling_press_avail);
> +		data->oversampling_press = ilog2(1);
> +
> +		data->oversampling_temp_avail = bmp180_oversampling_temp_avail;
> +		data->num_oversampling_temp_avail =
> +			ARRAY_SIZE(bmp180_oversampling_temp_avail);
> +		data->oversampling_temp = ilog2(1);
> +
> +		config = &bmp180_regmap_config;
> +		break;
> +	case BMP280_CHIP_ID:
> +		data->ops = &bmp280_ops;
As stated above, I can't immediately see why all the below can't
be bundled up in to a single chip_info structure and assigned with
a single line.
> +
> +		data->oversampling_press_avail = bmp280_oversampling_avail;
> +		data->num_oversampling_press_avail =
> +			ARRAY_SIZE(bmp280_oversampling_avail);
> +		data->oversampling_press = ilog2(16);
> +
> +		data->oversampling_temp_avail = bmp280_oversampling_avail;
> +		data->num_oversampling_temp_avail =
> +			ARRAY_SIZE(bmp280_oversampling_avail);
> +		data->oversampling_temp = ilog2(2);
> +
> +		config = &bmp280_regmap_config;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	data->regmap = devm_regmap_init_i2c(client, config);
>  	if (IS_ERR(data->regmap)) {
>  		dev_err(&client->dev, "failed to allocate register map\n");
>  		return PTR_ERR(data->regmap);
> @@ -376,13 +892,13 @@ static int bmp280_probe(struct i2c_client *client,
>  	ret = regmap_read(data->regmap, BMP280_REG_ID, &chip_id);
>  	if (ret < 0)
>  		return ret;
> -	if (chip_id != BMP280_CHIP_ID) {
> +	if (chip_id != id->driver_data) {
>  		dev_err(&client->dev, "bad chip id.  expected %x got %x\n",
>  			BMP280_CHIP_ID, chip_id);
>  		return -EINVAL;
>  	}
>  
> -	ret = bmp280_chip_init(data);
> +	ret = data->ops->init(data);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -390,13 +906,15 @@ static int bmp280_probe(struct i2c_client *client,
>  }
>  
>  static const struct acpi_device_id bmp280_acpi_match[] = {
> -	{"BMP0280", 0},
> +	{"BMP0280", BMP280_CHIP_ID },
Why not provide ACPI id's for the other devices?
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(acpi, bmp280_acpi_match);
>  
>  static const struct i2c_device_id bmp280_id[] = {
> -	{"bmp280", 0},
> +	{"bmp280", BMP280_CHIP_ID },
> +	{"bmp180", BMP180_CHIP_ID },
> +	{"bmp085", BMP180_CHIP_ID },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(i2c, bmp280_id);
> @@ -412,5 +930,5 @@ static struct i2c_driver bmp280_driver = {
>  module_i2c_driver(bmp280_driver);
>  
>  MODULE_AUTHOR("Vlad Dogaru <vlad.dogaru@intel.com>");
> -MODULE_DESCRIPTION("Driver for Bosch Sensortec BMP280 pressure and temperature sensor");
> +MODULE_DESCRIPTION("Driver for Bosch Sensortec BMP180/BMP280 pressure and temperature sensor");
>  MODULE_LICENSE("GPL v2");
> 

