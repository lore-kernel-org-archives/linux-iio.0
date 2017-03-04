Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56169 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751945AbdCDSm0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Mar 2017 13:42:26 -0500
Subject: Re: [PATCH] staging: iio: accel: Rename source files and update
 Makefile
To: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
References: <1488651406-6175-1-git-send-email-narcisaanamaria12@gmail.com>
Cc: linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <3c029cbb-8b86-67cc-4584-717d3dcbe527@kernel.org>
Date: Sat, 4 Mar 2017 18:42:23 +0000
MIME-Version: 1.0
In-Reply-To: <1488651406-6175-1-git-send-email-narcisaanamaria12@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/03/17 18:16, Narcisa Ana Maria Vasile wrote:
> Rename adis162xx_core.c files to adis162xx.c because
> these are the only source files for these drivers.
> 
> Update Makefile to correspond to the new file names.
> 
> Signed-off-by: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
There are always reasons to deliberate leave move detection turned off
(i.e. to promote a review of a driver moving out of staging which is much
easier if the code is in front of people).

In a simple move like this though, git move detection is definitely a good
thing as then this turns into an obvious 10 line patch!

Could you look up how to enable it and send the resulting shorter patch as
a V2.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/accel/Makefile         |   7 -
>  drivers/staging/iio/accel/adis16201.c      | 248 ++++++++++++++++++++++++
>  drivers/staging/iio/accel/adis16201_core.c | 248 ------------------------
>  drivers/staging/iio/accel/adis16203.c      | 216 +++++++++++++++++++++
>  drivers/staging/iio/accel/adis16203_core.c | 216 ---------------------
>  drivers/staging/iio/accel/adis16209.c      | 248 ++++++++++++++++++++++++
>  drivers/staging/iio/accel/adis16209_core.c | 248 ------------------------
>  drivers/staging/iio/accel/adis16240.c      | 301 +++++++++++++++++++++++++++++
>  drivers/staging/iio/accel/adis16240_core.c | 301 -----------------------------
>  9 files changed, 1013 insertions(+), 1020 deletions(-)
>  create mode 100644 drivers/staging/iio/accel/adis16201.c
>  delete mode 100644 drivers/staging/iio/accel/adis16201_core.c
>  create mode 100644 drivers/staging/iio/accel/adis16203.c
>  delete mode 100644 drivers/staging/iio/accel/adis16203_core.c
>  create mode 100644 drivers/staging/iio/accel/adis16209.c
>  delete mode 100644 drivers/staging/iio/accel/adis16209_core.c
>  create mode 100644 drivers/staging/iio/accel/adis16240.c
>  delete mode 100644 drivers/staging/iio/accel/adis16240_core.c
> 
> diff --git a/drivers/staging/iio/accel/Makefile b/drivers/staging/iio/accel/Makefile
> index febb137..5d8ad21 100644
> --- a/drivers/staging/iio/accel/Makefile
> +++ b/drivers/staging/iio/accel/Makefile
> @@ -2,14 +2,7 @@
>  # Makefile for industrial I/O accelerometer drivers
>  #
>  
> -adis16201-y             := adis16201_core.o
>  obj-$(CONFIG_ADIS16201) += adis16201.o
> -
> -adis16203-y             := adis16203_core.o
>  obj-$(CONFIG_ADIS16203) += adis16203.o
> -
> -adis16209-y             := adis16209_core.o
>  obj-$(CONFIG_ADIS16209) += adis16209.o
> -
> -adis16240-y             := adis16240_core.o
>  obj-$(CONFIG_ADIS16240) += adis16240.o
> diff --git a/drivers/staging/iio/accel/adis16201.c b/drivers/staging/iio/accel/adis16201.c
> new file mode 100644
> index 0000000..7963d4a
> --- /dev/null
> +++ b/drivers/staging/iio/accel/adis16201.c
> @@ -0,0 +1,248 @@
> +/*
> + * ADIS16201 Dual-Axis Digital Inclinometer and Accelerometer
> + *
> + * Copyright 2010 Analog Devices Inc.
> + *
> + * Licensed under the GPL-2 or later.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/mutex.h>
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/spi/spi.h>
> +#include <linux/slab.h>
> +#include <linux/sysfs.h>
> +#include <linux/module.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/imu/adis.h>
> +
> +#include "adis16201.h"
> +
> +static const u8 adis16201_addresses[] = {
> +	[ADIS16201_SCAN_ACC_X] = ADIS16201_XACCL_OFFS,
> +	[ADIS16201_SCAN_ACC_Y] = ADIS16201_YACCL_OFFS,
> +	[ADIS16201_SCAN_INCLI_X] = ADIS16201_XINCL_OFFS,
> +	[ADIS16201_SCAN_INCLI_Y] = ADIS16201_YINCL_OFFS,
> +};
> +
> +static int adis16201_read_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      int *val, int *val2,
> +			      long mask)
> +{
> +	struct adis *st = iio_priv(indio_dev);
> +	int ret;
> +	int bits;
> +	u8 addr;
> +	s16 val16;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		return adis_single_conversion(indio_dev, chan,
> +				ADIS16201_ERROR_ACTIVE, val);
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_VOLTAGE:
> +			if (chan->channel == 0) {
> +				*val = 1;
> +				*val2 = 220000; /* 1.22 mV */
> +			} else {
> +				*val = 0;
> +				*val2 = 610000; /* 0.610 mV */
> +			}
> +			return IIO_VAL_INT_PLUS_MICRO;
> +		case IIO_TEMP:
> +			*val = -470; /* 0.47 C */
> +			*val2 = 0;
> +			return IIO_VAL_INT_PLUS_MICRO;
> +		case IIO_ACCEL:
> +			*val = 0;
> +			*val2 = IIO_G_TO_M_S_2(462400); /* 0.4624 mg */
> +			return IIO_VAL_INT_PLUS_NANO;
> +		case IIO_INCLI:
> +			*val = 0;
> +			*val2 = 100000; /* 0.1 degree */
> +			return IIO_VAL_INT_PLUS_MICRO;
> +		default:
> +			return -EINVAL;
> +		}
> +		break;
> +	case IIO_CHAN_INFO_OFFSET:
> +		*val = 25000 / -470 - 1278; /* 25 C = 1278 */
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		switch (chan->type) {
> +		case IIO_ACCEL:
> +			bits = 12;
> +			break;
> +		case IIO_INCLI:
> +			bits = 9;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		mutex_lock(&indio_dev->mlock);
> +		addr = adis16201_addresses[chan->scan_index];
> +		ret = adis_read_reg_16(st, addr, &val16);
> +		if (ret) {
> +			mutex_unlock(&indio_dev->mlock);
> +			return ret;
> +		}
> +		val16 &= (1 << bits) - 1;
> +		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
> +		*val = val16;
> +		mutex_unlock(&indio_dev->mlock);
> +		return IIO_VAL_INT;
> +	}
> +	return -EINVAL;
> +}
> +
> +static int adis16201_write_raw(struct iio_dev *indio_dev,
> +			       struct iio_chan_spec const *chan,
> +			       int val,
> +			       int val2,
> +			       long mask)
> +{
> +	struct adis *st = iio_priv(indio_dev);
> +	int bits;
> +	s16 val16;
> +	u8 addr;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		switch (chan->type) {
> +		case IIO_ACCEL:
> +			bits = 12;
> +			break;
> +		case IIO_INCLI:
> +			bits = 9;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		val16 = val & ((1 << bits) - 1);
> +		addr = adis16201_addresses[chan->scan_index];
> +		return adis_write_reg_16(st, addr, val16);
> +	}
> +	return -EINVAL;
> +}
> +
> +static const struct iio_chan_spec adis16201_channels[] = {
> +	ADIS_SUPPLY_CHAN(ADIS16201_SUPPLY_OUT, ADIS16201_SCAN_SUPPLY, 0, 12),
> +	ADIS_TEMP_CHAN(ADIS16201_TEMP_OUT, ADIS16201_SCAN_TEMP, 0, 12),
> +	ADIS_ACCEL_CHAN(X, ADIS16201_XACCL_OUT, ADIS16201_SCAN_ACC_X,
> +			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
> +	ADIS_ACCEL_CHAN(Y, ADIS16201_YACCL_OUT, ADIS16201_SCAN_ACC_Y,
> +			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
> +	ADIS_AUX_ADC_CHAN(ADIS16201_AUX_ADC, ADIS16201_SCAN_AUX_ADC, 0, 12),
> +	ADIS_INCLI_CHAN(X, ADIS16201_XINCL_OUT, ADIS16201_SCAN_INCLI_X,
> +			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
> +	ADIS_INCLI_CHAN(X, ADIS16201_YINCL_OUT, ADIS16201_SCAN_INCLI_Y,
> +			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
> +	IIO_CHAN_SOFT_TIMESTAMP(7)
> +};
> +
> +static const struct iio_info adis16201_info = {
> +	.read_raw = &adis16201_read_raw,
> +	.write_raw = &adis16201_write_raw,
> +	.update_scan_mode = adis_update_scan_mode,
> +	.driver_module = THIS_MODULE,
> +};
> +
> +static const char * const adis16201_status_error_msgs[] = {
> +	[ADIS16201_DIAG_STAT_SPI_FAIL_BIT] = "SPI failure",
> +	[ADIS16201_DIAG_STAT_FLASH_UPT_BIT] = "Flash update failed",
> +	[ADIS16201_DIAG_STAT_POWER_HIGH_BIT] = "Power supply above 3.625V",
> +	[ADIS16201_DIAG_STAT_POWER_LOW_BIT] = "Power supply below 3.15V",
> +};
> +
> +static const struct adis_data adis16201_data = {
> +	.read_delay = 20,
> +	.msc_ctrl_reg = ADIS16201_MSC_CTRL,
> +	.glob_cmd_reg = ADIS16201_GLOB_CMD,
> +	.diag_stat_reg = ADIS16201_DIAG_STAT,
> +
> +	.self_test_mask = ADIS16201_MSC_CTRL_SELF_TEST_EN,
> +	.self_test_no_autoclear = true,
> +	.startup_delay = ADIS16201_STARTUP_DELAY,
> +
> +	.status_error_msgs = adis16201_status_error_msgs,
> +	.status_error_mask = BIT(ADIS16201_DIAG_STAT_SPI_FAIL_BIT) |
> +		BIT(ADIS16201_DIAG_STAT_FLASH_UPT_BIT) |
> +		BIT(ADIS16201_DIAG_STAT_POWER_HIGH_BIT) |
> +		BIT(ADIS16201_DIAG_STAT_POWER_LOW_BIT),
> +};
> +
> +static int adis16201_probe(struct spi_device *spi)
> +{
> +	int ret;
> +	struct adis *st;
> +	struct iio_dev *indio_dev;
> +
> +	/* setup the industrialio driver allocated elements */
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +	/* this is only used for removal purposes */
> +	spi_set_drvdata(spi, indio_dev);
> +
> +	indio_dev->name = spi->dev.driver->name;
> +	indio_dev->dev.parent = &spi->dev;
> +	indio_dev->info = &adis16201_info;
> +
> +	indio_dev->channels = adis16201_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(adis16201_channels);
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	ret = adis_init(st, indio_dev, spi, &adis16201_data);
> +	if (ret)
> +		return ret;
> +	ret = adis_setup_buffer_and_trigger(st, indio_dev, NULL);
> +	if (ret)
> +		return ret;
> +
> +	/* Get the device into a sane initial state */
> +	ret = adis_initial_startup(st);
> +	if (ret)
> +		goto error_cleanup_buffer_trigger;
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret < 0)
> +		goto error_cleanup_buffer_trigger;
> +	return 0;
> +
> +error_cleanup_buffer_trigger:
> +	adis_cleanup_buffer_and_trigger(st, indio_dev);
> +	return ret;
> +}
> +
> +static int adis16201_remove(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> +	struct adis *st = iio_priv(indio_dev);
> +
> +	iio_device_unregister(indio_dev);
> +	adis_cleanup_buffer_and_trigger(st, indio_dev);
> +
> +	return 0;
> +}
> +
> +static struct spi_driver adis16201_driver = {
> +	.driver = {
> +		.name = "adis16201",
> +	},
> +	.probe = adis16201_probe,
> +	.remove = adis16201_remove,
> +};
> +module_spi_driver(adis16201_driver);
> +
> +MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
> +MODULE_DESCRIPTION("Analog Devices ADIS16201 Dual-Axis Digital Inclinometer and Accelerometer");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("spi:adis16201");
> diff --git a/drivers/staging/iio/accel/adis16201_core.c b/drivers/staging/iio/accel/adis16201_core.c
> deleted file mode 100644
> index 7963d4a..0000000
> --- a/drivers/staging/iio/accel/adis16201_core.c
> +++ /dev/null
> @@ -1,248 +0,0 @@
> -/*
> - * ADIS16201 Dual-Axis Digital Inclinometer and Accelerometer
> - *
> - * Copyright 2010 Analog Devices Inc.
> - *
> - * Licensed under the GPL-2 or later.
> - */
> -
> -#include <linux/delay.h>
> -#include <linux/mutex.h>
> -#include <linux/device.h>
> -#include <linux/kernel.h>
> -#include <linux/spi/spi.h>
> -#include <linux/slab.h>
> -#include <linux/sysfs.h>
> -#include <linux/module.h>
> -
> -#include <linux/iio/iio.h>
> -#include <linux/iio/sysfs.h>
> -#include <linux/iio/buffer.h>
> -#include <linux/iio/imu/adis.h>
> -
> -#include "adis16201.h"
> -
> -static const u8 adis16201_addresses[] = {
> -	[ADIS16201_SCAN_ACC_X] = ADIS16201_XACCL_OFFS,
> -	[ADIS16201_SCAN_ACC_Y] = ADIS16201_YACCL_OFFS,
> -	[ADIS16201_SCAN_INCLI_X] = ADIS16201_XINCL_OFFS,
> -	[ADIS16201_SCAN_INCLI_Y] = ADIS16201_YINCL_OFFS,
> -};
> -
> -static int adis16201_read_raw(struct iio_dev *indio_dev,
> -			      struct iio_chan_spec const *chan,
> -			      int *val, int *val2,
> -			      long mask)
> -{
> -	struct adis *st = iio_priv(indio_dev);
> -	int ret;
> -	int bits;
> -	u8 addr;
> -	s16 val16;
> -
> -	switch (mask) {
> -	case IIO_CHAN_INFO_RAW:
> -		return adis_single_conversion(indio_dev, chan,
> -				ADIS16201_ERROR_ACTIVE, val);
> -	case IIO_CHAN_INFO_SCALE:
> -		switch (chan->type) {
> -		case IIO_VOLTAGE:
> -			if (chan->channel == 0) {
> -				*val = 1;
> -				*val2 = 220000; /* 1.22 mV */
> -			} else {
> -				*val = 0;
> -				*val2 = 610000; /* 0.610 mV */
> -			}
> -			return IIO_VAL_INT_PLUS_MICRO;
> -		case IIO_TEMP:
> -			*val = -470; /* 0.47 C */
> -			*val2 = 0;
> -			return IIO_VAL_INT_PLUS_MICRO;
> -		case IIO_ACCEL:
> -			*val = 0;
> -			*val2 = IIO_G_TO_M_S_2(462400); /* 0.4624 mg */
> -			return IIO_VAL_INT_PLUS_NANO;
> -		case IIO_INCLI:
> -			*val = 0;
> -			*val2 = 100000; /* 0.1 degree */
> -			return IIO_VAL_INT_PLUS_MICRO;
> -		default:
> -			return -EINVAL;
> -		}
> -		break;
> -	case IIO_CHAN_INFO_OFFSET:
> -		*val = 25000 / -470 - 1278; /* 25 C = 1278 */
> -		return IIO_VAL_INT;
> -	case IIO_CHAN_INFO_CALIBBIAS:
> -		switch (chan->type) {
> -		case IIO_ACCEL:
> -			bits = 12;
> -			break;
> -		case IIO_INCLI:
> -			bits = 9;
> -			break;
> -		default:
> -			return -EINVAL;
> -		}
> -		mutex_lock(&indio_dev->mlock);
> -		addr = adis16201_addresses[chan->scan_index];
> -		ret = adis_read_reg_16(st, addr, &val16);
> -		if (ret) {
> -			mutex_unlock(&indio_dev->mlock);
> -			return ret;
> -		}
> -		val16 &= (1 << bits) - 1;
> -		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
> -		*val = val16;
> -		mutex_unlock(&indio_dev->mlock);
> -		return IIO_VAL_INT;
> -	}
> -	return -EINVAL;
> -}
> -
> -static int adis16201_write_raw(struct iio_dev *indio_dev,
> -			       struct iio_chan_spec const *chan,
> -			       int val,
> -			       int val2,
> -			       long mask)
> -{
> -	struct adis *st = iio_priv(indio_dev);
> -	int bits;
> -	s16 val16;
> -	u8 addr;
> -
> -	switch (mask) {
> -	case IIO_CHAN_INFO_CALIBBIAS:
> -		switch (chan->type) {
> -		case IIO_ACCEL:
> -			bits = 12;
> -			break;
> -		case IIO_INCLI:
> -			bits = 9;
> -			break;
> -		default:
> -			return -EINVAL;
> -		}
> -		val16 = val & ((1 << bits) - 1);
> -		addr = adis16201_addresses[chan->scan_index];
> -		return adis_write_reg_16(st, addr, val16);
> -	}
> -	return -EINVAL;
> -}
> -
> -static const struct iio_chan_spec adis16201_channels[] = {
> -	ADIS_SUPPLY_CHAN(ADIS16201_SUPPLY_OUT, ADIS16201_SCAN_SUPPLY, 0, 12),
> -	ADIS_TEMP_CHAN(ADIS16201_TEMP_OUT, ADIS16201_SCAN_TEMP, 0, 12),
> -	ADIS_ACCEL_CHAN(X, ADIS16201_XACCL_OUT, ADIS16201_SCAN_ACC_X,
> -			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
> -	ADIS_ACCEL_CHAN(Y, ADIS16201_YACCL_OUT, ADIS16201_SCAN_ACC_Y,
> -			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
> -	ADIS_AUX_ADC_CHAN(ADIS16201_AUX_ADC, ADIS16201_SCAN_AUX_ADC, 0, 12),
> -	ADIS_INCLI_CHAN(X, ADIS16201_XINCL_OUT, ADIS16201_SCAN_INCLI_X,
> -			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
> -	ADIS_INCLI_CHAN(X, ADIS16201_YINCL_OUT, ADIS16201_SCAN_INCLI_Y,
> -			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
> -	IIO_CHAN_SOFT_TIMESTAMP(7)
> -};
> -
> -static const struct iio_info adis16201_info = {
> -	.read_raw = &adis16201_read_raw,
> -	.write_raw = &adis16201_write_raw,
> -	.update_scan_mode = adis_update_scan_mode,
> -	.driver_module = THIS_MODULE,
> -};
> -
> -static const char * const adis16201_status_error_msgs[] = {
> -	[ADIS16201_DIAG_STAT_SPI_FAIL_BIT] = "SPI failure",
> -	[ADIS16201_DIAG_STAT_FLASH_UPT_BIT] = "Flash update failed",
> -	[ADIS16201_DIAG_STAT_POWER_HIGH_BIT] = "Power supply above 3.625V",
> -	[ADIS16201_DIAG_STAT_POWER_LOW_BIT] = "Power supply below 3.15V",
> -};
> -
> -static const struct adis_data adis16201_data = {
> -	.read_delay = 20,
> -	.msc_ctrl_reg = ADIS16201_MSC_CTRL,
> -	.glob_cmd_reg = ADIS16201_GLOB_CMD,
> -	.diag_stat_reg = ADIS16201_DIAG_STAT,
> -
> -	.self_test_mask = ADIS16201_MSC_CTRL_SELF_TEST_EN,
> -	.self_test_no_autoclear = true,
> -	.startup_delay = ADIS16201_STARTUP_DELAY,
> -
> -	.status_error_msgs = adis16201_status_error_msgs,
> -	.status_error_mask = BIT(ADIS16201_DIAG_STAT_SPI_FAIL_BIT) |
> -		BIT(ADIS16201_DIAG_STAT_FLASH_UPT_BIT) |
> -		BIT(ADIS16201_DIAG_STAT_POWER_HIGH_BIT) |
> -		BIT(ADIS16201_DIAG_STAT_POWER_LOW_BIT),
> -};
> -
> -static int adis16201_probe(struct spi_device *spi)
> -{
> -	int ret;
> -	struct adis *st;
> -	struct iio_dev *indio_dev;
> -
> -	/* setup the industrialio driver allocated elements */
> -	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> -	if (!indio_dev)
> -		return -ENOMEM;
> -
> -	st = iio_priv(indio_dev);
> -	/* this is only used for removal purposes */
> -	spi_set_drvdata(spi, indio_dev);
> -
> -	indio_dev->name = spi->dev.driver->name;
> -	indio_dev->dev.parent = &spi->dev;
> -	indio_dev->info = &adis16201_info;
> -
> -	indio_dev->channels = adis16201_channels;
> -	indio_dev->num_channels = ARRAY_SIZE(adis16201_channels);
> -	indio_dev->modes = INDIO_DIRECT_MODE;
> -
> -	ret = adis_init(st, indio_dev, spi, &adis16201_data);
> -	if (ret)
> -		return ret;
> -	ret = adis_setup_buffer_and_trigger(st, indio_dev, NULL);
> -	if (ret)
> -		return ret;
> -
> -	/* Get the device into a sane initial state */
> -	ret = adis_initial_startup(st);
> -	if (ret)
> -		goto error_cleanup_buffer_trigger;
> -
> -	ret = iio_device_register(indio_dev);
> -	if (ret < 0)
> -		goto error_cleanup_buffer_trigger;
> -	return 0;
> -
> -error_cleanup_buffer_trigger:
> -	adis_cleanup_buffer_and_trigger(st, indio_dev);
> -	return ret;
> -}
> -
> -static int adis16201_remove(struct spi_device *spi)
> -{
> -	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> -	struct adis *st = iio_priv(indio_dev);
> -
> -	iio_device_unregister(indio_dev);
> -	adis_cleanup_buffer_and_trigger(st, indio_dev);
> -
> -	return 0;
> -}
> -
> -static struct spi_driver adis16201_driver = {
> -	.driver = {
> -		.name = "adis16201",
> -	},
> -	.probe = adis16201_probe,
> -	.remove = adis16201_remove,
> -};
> -module_spi_driver(adis16201_driver);
> -
> -MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
> -MODULE_DESCRIPTION("Analog Devices ADIS16201 Dual-Axis Digital Inclinometer and Accelerometer");
> -MODULE_LICENSE("GPL v2");
> -MODULE_ALIAS("spi:adis16201");
> diff --git a/drivers/staging/iio/accel/adis16203.c b/drivers/staging/iio/accel/adis16203.c
> new file mode 100644
> index 0000000..bd8119a
> --- /dev/null
> +++ b/drivers/staging/iio/accel/adis16203.c
> @@ -0,0 +1,216 @@
> +/*
> + * ADIS16203 Programmable 360 Degrees Inclinometer
> + *
> + * Copyright 2010 Analog Devices Inc.
> + *
> + * Licensed under the GPL-2 or later.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/mutex.h>
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/spi/spi.h>
> +#include <linux/slab.h>
> +#include <linux/sysfs.h>
> +#include <linux/module.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/imu/adis.h>
> +
> +#include "adis16203.h"
> +
> +#define DRIVER_NAME		"adis16203"
> +
> +static const u8 adis16203_addresses[] = {
> +	[ADIS16203_SCAN_INCLI_X] = ADIS16203_INCL_NULL,
> +};
> +
> +static int adis16203_write_raw(struct iio_dev *indio_dev,
> +			       struct iio_chan_spec const *chan,
> +			       int val,
> +			       int val2,
> +			       long mask)
> +{
> +	struct adis *st = iio_priv(indio_dev);
> +	/* currently only one writable parameter which keeps this simple */
> +	u8 addr = adis16203_addresses[chan->scan_index];
> +
> +	return adis_write_reg_16(st, addr, val & 0x3FFF);
> +}
> +
> +static int adis16203_read_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      int *val, int *val2,
> +			      long mask)
> +{
> +	struct adis *st = iio_priv(indio_dev);
> +	int ret;
> +	int bits;
> +	u8 addr;
> +	s16 val16;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		return adis_single_conversion(indio_dev, chan,
> +				ADIS16203_ERROR_ACTIVE, val);
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_VOLTAGE:
> +			if (chan->channel == 0) {
> +				*val = 1;
> +				*val2 = 220000; /* 1.22 mV */
> +			} else {
> +				*val = 0;
> +				*val2 = 610000; /* 0.61 mV */
> +			}
> +			return IIO_VAL_INT_PLUS_MICRO;
> +		case IIO_TEMP:
> +			*val = -470; /* -0.47 C */
> +			*val2 = 0;
> +			return IIO_VAL_INT_PLUS_MICRO;
> +		case IIO_INCLI:
> +			*val = 0;
> +			*val2 = 25000; /* 0.025 degree */
> +			return IIO_VAL_INT_PLUS_MICRO;
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_OFFSET:
> +		*val = 25000 / -470 - 1278; /* 25 C = 1278 */
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		bits = 14;
> +		mutex_lock(&indio_dev->mlock);
> +		addr = adis16203_addresses[chan->scan_index];
> +		ret = adis_read_reg_16(st, addr, &val16);
> +		if (ret) {
> +			mutex_unlock(&indio_dev->mlock);
> +			return ret;
> +		}
> +		val16 &= (1 << bits) - 1;
> +		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
> +		*val = val16;
> +		mutex_unlock(&indio_dev->mlock);
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_chan_spec adis16203_channels[] = {
> +	ADIS_SUPPLY_CHAN(ADIS16203_SUPPLY_OUT, ADIS16203_SCAN_SUPPLY, 0, 12),
> +	ADIS_AUX_ADC_CHAN(ADIS16203_AUX_ADC, ADIS16203_SCAN_AUX_ADC, 0, 12),
> +	ADIS_INCLI_CHAN(X, ADIS16203_XINCL_OUT, ADIS16203_SCAN_INCLI_X,
> +			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
> +	/* Fixme: Not what it appears to be - see data sheet */
> +	ADIS_INCLI_CHAN(Y, ADIS16203_YINCL_OUT, ADIS16203_SCAN_INCLI_Y,
> +			0, 0, 14),
> +	ADIS_TEMP_CHAN(ADIS16203_TEMP_OUT, ADIS16203_SCAN_TEMP, 0, 12),
> +	IIO_CHAN_SOFT_TIMESTAMP(5),
> +};
> +
> +static const struct iio_info adis16203_info = {
> +	.read_raw = &adis16203_read_raw,
> +	.write_raw = &adis16203_write_raw,
> +	.update_scan_mode = adis_update_scan_mode,
> +	.driver_module = THIS_MODULE,
> +};
> +
> +static const char * const adis16203_status_error_msgs[] = {
> +	[ADIS16203_DIAG_STAT_SELFTEST_FAIL_BIT] = "Self test failure",
> +	[ADIS16203_DIAG_STAT_SPI_FAIL_BIT] = "SPI failure",
> +	[ADIS16203_DIAG_STAT_FLASH_UPT_BIT] = "Flash update failed",
> +	[ADIS16203_DIAG_STAT_POWER_HIGH_BIT] = "Power supply above 3.625V",
> +	[ADIS16203_DIAG_STAT_POWER_LOW_BIT] = "Power supply below 3.15V",
> +};
> +
> +static const struct adis_data adis16203_data = {
> +	.read_delay = 20,
> +	.msc_ctrl_reg = ADIS16203_MSC_CTRL,
> +	.glob_cmd_reg = ADIS16203_GLOB_CMD,
> +	.diag_stat_reg = ADIS16203_DIAG_STAT,
> +
> +	.self_test_mask = ADIS16203_MSC_CTRL_SELF_TEST_EN,
> +	.self_test_no_autoclear = true,
> +	.startup_delay = ADIS16203_STARTUP_DELAY,
> +
> +	.status_error_msgs = adis16203_status_error_msgs,
> +	.status_error_mask = BIT(ADIS16203_DIAG_STAT_SELFTEST_FAIL_BIT) |
> +		BIT(ADIS16203_DIAG_STAT_SPI_FAIL_BIT) |
> +		BIT(ADIS16203_DIAG_STAT_FLASH_UPT_BIT) |
> +		BIT(ADIS16203_DIAG_STAT_POWER_HIGH_BIT) |
> +		BIT(ADIS16203_DIAG_STAT_POWER_LOW_BIT),
> +};
> +
> +static int adis16203_probe(struct spi_device *spi)
> +{
> +	int ret;
> +	struct iio_dev *indio_dev;
> +	struct adis *st;
> +
> +	/* setup the industrialio driver allocated elements */
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +	st = iio_priv(indio_dev);
> +	/* this is only used for removal purposes */
> +	spi_set_drvdata(spi, indio_dev);
> +
> +	indio_dev->name = spi->dev.driver->name;
> +	indio_dev->dev.parent = &spi->dev;
> +	indio_dev->channels = adis16203_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(adis16203_channels);
> +	indio_dev->info = &adis16203_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	ret = adis_init(st, indio_dev, spi, &adis16203_data);
> +	if (ret)
> +		return ret;
> +
> +	ret = adis_setup_buffer_and_trigger(st, indio_dev, NULL);
> +	if (ret)
> +		return ret;
> +
> +	/* Get the device into a sane initial state */
> +	ret = adis_initial_startup(st);
> +	if (ret)
> +		goto error_cleanup_buffer_trigger;
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret)
> +		goto error_cleanup_buffer_trigger;
> +
> +	return 0;
> +
> +error_cleanup_buffer_trigger:
> +	adis_cleanup_buffer_and_trigger(st, indio_dev);
> +	return ret;
> +}
> +
> +static int adis16203_remove(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> +	struct adis *st = iio_priv(indio_dev);
> +
> +	iio_device_unregister(indio_dev);
> +	adis_cleanup_buffer_and_trigger(st, indio_dev);
> +
> +	return 0;
> +}
> +
> +static struct spi_driver adis16203_driver = {
> +	.driver = {
> +		.name = "adis16203",
> +	},
> +	.probe = adis16203_probe,
> +	.remove = adis16203_remove,
> +};
> +module_spi_driver(adis16203_driver);
> +
> +MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
> +MODULE_DESCRIPTION("Analog Devices ADIS16203 Programmable 360 Degrees Inclinometer");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("spi:adis16203");
> diff --git a/drivers/staging/iio/accel/adis16203_core.c b/drivers/staging/iio/accel/adis16203_core.c
> deleted file mode 100644
> index bd8119a..0000000
> --- a/drivers/staging/iio/accel/adis16203_core.c
> +++ /dev/null
> @@ -1,216 +0,0 @@
> -/*
> - * ADIS16203 Programmable 360 Degrees Inclinometer
> - *
> - * Copyright 2010 Analog Devices Inc.
> - *
> - * Licensed under the GPL-2 or later.
> - */
> -
> -#include <linux/delay.h>
> -#include <linux/mutex.h>
> -#include <linux/device.h>
> -#include <linux/kernel.h>
> -#include <linux/spi/spi.h>
> -#include <linux/slab.h>
> -#include <linux/sysfs.h>
> -#include <linux/module.h>
> -
> -#include <linux/iio/iio.h>
> -#include <linux/iio/sysfs.h>
> -#include <linux/iio/buffer.h>
> -#include <linux/iio/imu/adis.h>
> -
> -#include "adis16203.h"
> -
> -#define DRIVER_NAME		"adis16203"
> -
> -static const u8 adis16203_addresses[] = {
> -	[ADIS16203_SCAN_INCLI_X] = ADIS16203_INCL_NULL,
> -};
> -
> -static int adis16203_write_raw(struct iio_dev *indio_dev,
> -			       struct iio_chan_spec const *chan,
> -			       int val,
> -			       int val2,
> -			       long mask)
> -{
> -	struct adis *st = iio_priv(indio_dev);
> -	/* currently only one writable parameter which keeps this simple */
> -	u8 addr = adis16203_addresses[chan->scan_index];
> -
> -	return adis_write_reg_16(st, addr, val & 0x3FFF);
> -}
> -
> -static int adis16203_read_raw(struct iio_dev *indio_dev,
> -			      struct iio_chan_spec const *chan,
> -			      int *val, int *val2,
> -			      long mask)
> -{
> -	struct adis *st = iio_priv(indio_dev);
> -	int ret;
> -	int bits;
> -	u8 addr;
> -	s16 val16;
> -
> -	switch (mask) {
> -	case IIO_CHAN_INFO_RAW:
> -		return adis_single_conversion(indio_dev, chan,
> -				ADIS16203_ERROR_ACTIVE, val);
> -	case IIO_CHAN_INFO_SCALE:
> -		switch (chan->type) {
> -		case IIO_VOLTAGE:
> -			if (chan->channel == 0) {
> -				*val = 1;
> -				*val2 = 220000; /* 1.22 mV */
> -			} else {
> -				*val = 0;
> -				*val2 = 610000; /* 0.61 mV */
> -			}
> -			return IIO_VAL_INT_PLUS_MICRO;
> -		case IIO_TEMP:
> -			*val = -470; /* -0.47 C */
> -			*val2 = 0;
> -			return IIO_VAL_INT_PLUS_MICRO;
> -		case IIO_INCLI:
> -			*val = 0;
> -			*val2 = 25000; /* 0.025 degree */
> -			return IIO_VAL_INT_PLUS_MICRO;
> -		default:
> -			return -EINVAL;
> -		}
> -	case IIO_CHAN_INFO_OFFSET:
> -		*val = 25000 / -470 - 1278; /* 25 C = 1278 */
> -		return IIO_VAL_INT;
> -	case IIO_CHAN_INFO_CALIBBIAS:
> -		bits = 14;
> -		mutex_lock(&indio_dev->mlock);
> -		addr = adis16203_addresses[chan->scan_index];
> -		ret = adis_read_reg_16(st, addr, &val16);
> -		if (ret) {
> -			mutex_unlock(&indio_dev->mlock);
> -			return ret;
> -		}
> -		val16 &= (1 << bits) - 1;
> -		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
> -		*val = val16;
> -		mutex_unlock(&indio_dev->mlock);
> -		return IIO_VAL_INT;
> -	default:
> -		return -EINVAL;
> -	}
> -}
> -
> -static const struct iio_chan_spec adis16203_channels[] = {
> -	ADIS_SUPPLY_CHAN(ADIS16203_SUPPLY_OUT, ADIS16203_SCAN_SUPPLY, 0, 12),
> -	ADIS_AUX_ADC_CHAN(ADIS16203_AUX_ADC, ADIS16203_SCAN_AUX_ADC, 0, 12),
> -	ADIS_INCLI_CHAN(X, ADIS16203_XINCL_OUT, ADIS16203_SCAN_INCLI_X,
> -			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
> -	/* Fixme: Not what it appears to be - see data sheet */
> -	ADIS_INCLI_CHAN(Y, ADIS16203_YINCL_OUT, ADIS16203_SCAN_INCLI_Y,
> -			0, 0, 14),
> -	ADIS_TEMP_CHAN(ADIS16203_TEMP_OUT, ADIS16203_SCAN_TEMP, 0, 12),
> -	IIO_CHAN_SOFT_TIMESTAMP(5),
> -};
> -
> -static const struct iio_info adis16203_info = {
> -	.read_raw = &adis16203_read_raw,
> -	.write_raw = &adis16203_write_raw,
> -	.update_scan_mode = adis_update_scan_mode,
> -	.driver_module = THIS_MODULE,
> -};
> -
> -static const char * const adis16203_status_error_msgs[] = {
> -	[ADIS16203_DIAG_STAT_SELFTEST_FAIL_BIT] = "Self test failure",
> -	[ADIS16203_DIAG_STAT_SPI_FAIL_BIT] = "SPI failure",
> -	[ADIS16203_DIAG_STAT_FLASH_UPT_BIT] = "Flash update failed",
> -	[ADIS16203_DIAG_STAT_POWER_HIGH_BIT] = "Power supply above 3.625V",
> -	[ADIS16203_DIAG_STAT_POWER_LOW_BIT] = "Power supply below 3.15V",
> -};
> -
> -static const struct adis_data adis16203_data = {
> -	.read_delay = 20,
> -	.msc_ctrl_reg = ADIS16203_MSC_CTRL,
> -	.glob_cmd_reg = ADIS16203_GLOB_CMD,
> -	.diag_stat_reg = ADIS16203_DIAG_STAT,
> -
> -	.self_test_mask = ADIS16203_MSC_CTRL_SELF_TEST_EN,
> -	.self_test_no_autoclear = true,
> -	.startup_delay = ADIS16203_STARTUP_DELAY,
> -
> -	.status_error_msgs = adis16203_status_error_msgs,
> -	.status_error_mask = BIT(ADIS16203_DIAG_STAT_SELFTEST_FAIL_BIT) |
> -		BIT(ADIS16203_DIAG_STAT_SPI_FAIL_BIT) |
> -		BIT(ADIS16203_DIAG_STAT_FLASH_UPT_BIT) |
> -		BIT(ADIS16203_DIAG_STAT_POWER_HIGH_BIT) |
> -		BIT(ADIS16203_DIAG_STAT_POWER_LOW_BIT),
> -};
> -
> -static int adis16203_probe(struct spi_device *spi)
> -{
> -	int ret;
> -	struct iio_dev *indio_dev;
> -	struct adis *st;
> -
> -	/* setup the industrialio driver allocated elements */
> -	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> -	if (!indio_dev)
> -		return -ENOMEM;
> -	st = iio_priv(indio_dev);
> -	/* this is only used for removal purposes */
> -	spi_set_drvdata(spi, indio_dev);
> -
> -	indio_dev->name = spi->dev.driver->name;
> -	indio_dev->dev.parent = &spi->dev;
> -	indio_dev->channels = adis16203_channels;
> -	indio_dev->num_channels = ARRAY_SIZE(adis16203_channels);
> -	indio_dev->info = &adis16203_info;
> -	indio_dev->modes = INDIO_DIRECT_MODE;
> -
> -	ret = adis_init(st, indio_dev, spi, &adis16203_data);
> -	if (ret)
> -		return ret;
> -
> -	ret = adis_setup_buffer_and_trigger(st, indio_dev, NULL);
> -	if (ret)
> -		return ret;
> -
> -	/* Get the device into a sane initial state */
> -	ret = adis_initial_startup(st);
> -	if (ret)
> -		goto error_cleanup_buffer_trigger;
> -
> -	ret = iio_device_register(indio_dev);
> -	if (ret)
> -		goto error_cleanup_buffer_trigger;
> -
> -	return 0;
> -
> -error_cleanup_buffer_trigger:
> -	adis_cleanup_buffer_and_trigger(st, indio_dev);
> -	return ret;
> -}
> -
> -static int adis16203_remove(struct spi_device *spi)
> -{
> -	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> -	struct adis *st = iio_priv(indio_dev);
> -
> -	iio_device_unregister(indio_dev);
> -	adis_cleanup_buffer_and_trigger(st, indio_dev);
> -
> -	return 0;
> -}
> -
> -static struct spi_driver adis16203_driver = {
> -	.driver = {
> -		.name = "adis16203",
> -	},
> -	.probe = adis16203_probe,
> -	.remove = adis16203_remove,
> -};
> -module_spi_driver(adis16203_driver);
> -
> -MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
> -MODULE_DESCRIPTION("Analog Devices ADIS16203 Programmable 360 Degrees Inclinometer");
> -MODULE_LICENSE("GPL v2");
> -MODULE_ALIAS("spi:adis16203");
> diff --git a/drivers/staging/iio/accel/adis16209.c b/drivers/staging/iio/accel/adis16209.c
> new file mode 100644
> index 0000000..a599e19
> --- /dev/null
> +++ b/drivers/staging/iio/accel/adis16209.c
> @@ -0,0 +1,248 @@
> +/*
> + * ADIS16209 Dual-Axis Digital Inclinometer and Accelerometer
> + *
> + * Copyright 2010 Analog Devices Inc.
> + *
> + * Licensed under the GPL-2 or later.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/mutex.h>
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/spi/spi.h>
> +#include <linux/slab.h>
> +#include <linux/sysfs.h>
> +#include <linux/list.h>
> +#include <linux/module.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/imu/adis.h>
> +
> +#include "adis16209.h"
> +
> +static const u8 adis16209_addresses[8][1] = {
> +	[ADIS16209_SCAN_SUPPLY] = { },
> +	[ADIS16209_SCAN_AUX_ADC] = { },
> +	[ADIS16209_SCAN_ACC_X] = { ADIS16209_XACCL_NULL },
> +	[ADIS16209_SCAN_ACC_Y] = { ADIS16209_YACCL_NULL },
> +	[ADIS16209_SCAN_INCLI_X] = { ADIS16209_XINCL_NULL },
> +	[ADIS16209_SCAN_INCLI_Y] = { ADIS16209_YINCL_NULL },
> +	[ADIS16209_SCAN_ROT] = { },
> +	[ADIS16209_SCAN_TEMP] = { },
> +};
> +
> +static int adis16209_write_raw(struct iio_dev *indio_dev,
> +			       struct iio_chan_spec const *chan,
> +			       int val,
> +			       int val2,
> +			       long mask)
> +{
> +	struct adis *st = iio_priv(indio_dev);
> +	int bits;
> +	s16 val16;
> +	u8 addr;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		switch (chan->type) {
> +		case IIO_ACCEL:
> +		case IIO_INCLI:
> +			bits = 14;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		val16 = val & ((1 << bits) - 1);
> +		addr = adis16209_addresses[chan->scan_index][0];
> +		return adis_write_reg_16(st, addr, val16);
> +	}
> +	return -EINVAL;
> +}
> +
> +static int adis16209_read_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      int *val, int *val2,
> +			      long mask)
> +{
> +	struct adis *st = iio_priv(indio_dev);
> +	int ret;
> +	int bits;
> +	u8 addr;
> +	s16 val16;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		return adis_single_conversion(indio_dev, chan,
> +			ADIS16209_ERROR_ACTIVE, val);
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_VOLTAGE:
> +			*val = 0;
> +			if (chan->channel == 0)
> +				*val2 = 305180; /* 0.30518 mV */
> +			else
> +				*val2 = 610500; /* 0.6105 mV */
> +			return IIO_VAL_INT_PLUS_MICRO;
> +		case IIO_TEMP:
> +			*val = -470; /* -0.47 C */
> +			*val2 = 0;
> +			return IIO_VAL_INT_PLUS_MICRO;
> +		case IIO_ACCEL:
> +			*val = 0;
> +			*val2 = IIO_G_TO_M_S_2(244140); /* 0.244140 mg */
> +			return IIO_VAL_INT_PLUS_NANO;
> +		case IIO_INCLI:
> +		case IIO_ROT:
> +			*val = 0;
> +			*val2 = 25000; /* 0.025 degree */
> +			return IIO_VAL_INT_PLUS_MICRO;
> +		default:
> +			return -EINVAL;
> +		}
> +		break;
> +	case IIO_CHAN_INFO_OFFSET:
> +		*val = 25000 / -470 - 0x4FE; /* 25 C = 0x4FE */
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		switch (chan->type) {
> +		case IIO_ACCEL:
> +			bits = 14;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		mutex_lock(&indio_dev->mlock);
> +		addr = adis16209_addresses[chan->scan_index][0];
> +		ret = adis_read_reg_16(st, addr, &val16);
> +		if (ret) {
> +			mutex_unlock(&indio_dev->mlock);
> +			return ret;
> +		}
> +		val16 &= (1 << bits) - 1;
> +		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
> +		*val = val16;
> +		mutex_unlock(&indio_dev->mlock);
> +		return IIO_VAL_INT;
> +	}
> +	return -EINVAL;
> +}
> +
> +static const struct iio_chan_spec adis16209_channels[] = {
> +	ADIS_SUPPLY_CHAN(ADIS16209_SUPPLY_OUT, ADIS16209_SCAN_SUPPLY, 0, 14),
> +	ADIS_TEMP_CHAN(ADIS16209_TEMP_OUT, ADIS16209_SCAN_TEMP, 0, 12),
> +	ADIS_ACCEL_CHAN(X, ADIS16209_XACCL_OUT, ADIS16209_SCAN_ACC_X,
> +			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
> +	ADIS_ACCEL_CHAN(Y, ADIS16209_YACCL_OUT, ADIS16209_SCAN_ACC_Y,
> +			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
> +	ADIS_AUX_ADC_CHAN(ADIS16209_AUX_ADC, ADIS16209_SCAN_AUX_ADC, 0, 12),
> +	ADIS_INCLI_CHAN(X, ADIS16209_XINCL_OUT, ADIS16209_SCAN_INCLI_X,
> +			0, 0, 14),
> +	ADIS_INCLI_CHAN(Y, ADIS16209_YINCL_OUT, ADIS16209_SCAN_INCLI_Y,
> +			0, 0, 14),
> +	ADIS_ROT_CHAN(X, ADIS16209_ROT_OUT, ADIS16209_SCAN_ROT, 0, 0, 14),
> +	IIO_CHAN_SOFT_TIMESTAMP(8)
> +};
> +
> +static const struct iio_info adis16209_info = {
> +	.read_raw = &adis16209_read_raw,
> +	.write_raw = &adis16209_write_raw,
> +	.update_scan_mode = adis_update_scan_mode,
> +	.driver_module = THIS_MODULE,
> +};
> +
> +static const char * const adis16209_status_error_msgs[] = {
> +	[ADIS16209_DIAG_STAT_SELFTEST_FAIL_BIT] = "Self test failure",
> +	[ADIS16209_DIAG_STAT_SPI_FAIL_BIT] = "SPI failure",
> +	[ADIS16209_DIAG_STAT_FLASH_UPT_BIT] = "Flash update failed",
> +	[ADIS16209_DIAG_STAT_POWER_HIGH_BIT] = "Power supply above 3.625V",
> +	[ADIS16209_DIAG_STAT_POWER_LOW_BIT] = "Power supply below 3.15V",
> +};
> +
> +static const struct adis_data adis16209_data = {
> +	.read_delay = 30,
> +	.msc_ctrl_reg = ADIS16209_MSC_CTRL,
> +	.glob_cmd_reg = ADIS16209_GLOB_CMD,
> +	.diag_stat_reg = ADIS16209_DIAG_STAT,
> +
> +	.self_test_mask = ADIS16209_MSC_CTRL_SELF_TEST_EN,
> +	.self_test_no_autoclear = true,
> +	.startup_delay = ADIS16209_STARTUP_DELAY,
> +
> +	.status_error_msgs = adis16209_status_error_msgs,
> +	.status_error_mask = BIT(ADIS16209_DIAG_STAT_SELFTEST_FAIL_BIT) |
> +		BIT(ADIS16209_DIAG_STAT_SPI_FAIL_BIT) |
> +		BIT(ADIS16209_DIAG_STAT_FLASH_UPT_BIT) |
> +		BIT(ADIS16209_DIAG_STAT_POWER_HIGH_BIT) |
> +		BIT(ADIS16209_DIAG_STAT_POWER_LOW_BIT),
> +};
> +
> +static int adis16209_probe(struct spi_device *spi)
> +{
> +	int ret;
> +	struct adis *st;
> +	struct iio_dev *indio_dev;
> +
> +	/* setup the industrialio driver allocated elements */
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +	st = iio_priv(indio_dev);
> +	/* this is only used for removal purposes */
> +	spi_set_drvdata(spi, indio_dev);
> +
> +	indio_dev->name = spi->dev.driver->name;
> +	indio_dev->dev.parent = &spi->dev;
> +	indio_dev->info = &adis16209_info;
> +	indio_dev->channels = adis16209_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(adis16209_channels);
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	ret = adis_init(st, indio_dev, spi, &adis16209_data);
> +	if (ret)
> +		return ret;
> +	ret = adis_setup_buffer_and_trigger(st, indio_dev, NULL);
> +	if (ret)
> +		return ret;
> +
> +	/* Get the device into a sane initial state */
> +	ret = adis_initial_startup(st);
> +	if (ret)
> +		goto error_cleanup_buffer_trigger;
> +	ret = iio_device_register(indio_dev);
> +	if (ret)
> +		goto error_cleanup_buffer_trigger;
> +
> +	return 0;
> +
> +error_cleanup_buffer_trigger:
> +	adis_cleanup_buffer_and_trigger(st, indio_dev);
> +	return ret;
> +}
> +
> +static int adis16209_remove(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> +	struct adis *st = iio_priv(indio_dev);
> +
> +	iio_device_unregister(indio_dev);
> +	adis_cleanup_buffer_and_trigger(st, indio_dev);
> +
> +	return 0;
> +}
> +
> +static struct spi_driver adis16209_driver = {
> +	.driver = {
> +		.name = "adis16209",
> +	},
> +	.probe = adis16209_probe,
> +	.remove = adis16209_remove,
> +};
> +module_spi_driver(adis16209_driver);
> +
> +MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
> +MODULE_DESCRIPTION("Analog Devices ADIS16209 Dual-Axis Digital Inclinometer and Accelerometer");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("spi:adis16209");
> diff --git a/drivers/staging/iio/accel/adis16209_core.c b/drivers/staging/iio/accel/adis16209_core.c
> deleted file mode 100644
> index a599e19..0000000
> --- a/drivers/staging/iio/accel/adis16209_core.c
> +++ /dev/null
> @@ -1,248 +0,0 @@
> -/*
> - * ADIS16209 Dual-Axis Digital Inclinometer and Accelerometer
> - *
> - * Copyright 2010 Analog Devices Inc.
> - *
> - * Licensed under the GPL-2 or later.
> - */
> -
> -#include <linux/delay.h>
> -#include <linux/mutex.h>
> -#include <linux/device.h>
> -#include <linux/kernel.h>
> -#include <linux/spi/spi.h>
> -#include <linux/slab.h>
> -#include <linux/sysfs.h>
> -#include <linux/list.h>
> -#include <linux/module.h>
> -
> -#include <linux/iio/iio.h>
> -#include <linux/iio/sysfs.h>
> -#include <linux/iio/buffer.h>
> -#include <linux/iio/imu/adis.h>
> -
> -#include "adis16209.h"
> -
> -static const u8 adis16209_addresses[8][1] = {
> -	[ADIS16209_SCAN_SUPPLY] = { },
> -	[ADIS16209_SCAN_AUX_ADC] = { },
> -	[ADIS16209_SCAN_ACC_X] = { ADIS16209_XACCL_NULL },
> -	[ADIS16209_SCAN_ACC_Y] = { ADIS16209_YACCL_NULL },
> -	[ADIS16209_SCAN_INCLI_X] = { ADIS16209_XINCL_NULL },
> -	[ADIS16209_SCAN_INCLI_Y] = { ADIS16209_YINCL_NULL },
> -	[ADIS16209_SCAN_ROT] = { },
> -	[ADIS16209_SCAN_TEMP] = { },
> -};
> -
> -static int adis16209_write_raw(struct iio_dev *indio_dev,
> -			       struct iio_chan_spec const *chan,
> -			       int val,
> -			       int val2,
> -			       long mask)
> -{
> -	struct adis *st = iio_priv(indio_dev);
> -	int bits;
> -	s16 val16;
> -	u8 addr;
> -
> -	switch (mask) {
> -	case IIO_CHAN_INFO_CALIBBIAS:
> -		switch (chan->type) {
> -		case IIO_ACCEL:
> -		case IIO_INCLI:
> -			bits = 14;
> -			break;
> -		default:
> -			return -EINVAL;
> -		}
> -		val16 = val & ((1 << bits) - 1);
> -		addr = adis16209_addresses[chan->scan_index][0];
> -		return adis_write_reg_16(st, addr, val16);
> -	}
> -	return -EINVAL;
> -}
> -
> -static int adis16209_read_raw(struct iio_dev *indio_dev,
> -			      struct iio_chan_spec const *chan,
> -			      int *val, int *val2,
> -			      long mask)
> -{
> -	struct adis *st = iio_priv(indio_dev);
> -	int ret;
> -	int bits;
> -	u8 addr;
> -	s16 val16;
> -
> -	switch (mask) {
> -	case IIO_CHAN_INFO_RAW:
> -		return adis_single_conversion(indio_dev, chan,
> -			ADIS16209_ERROR_ACTIVE, val);
> -	case IIO_CHAN_INFO_SCALE:
> -		switch (chan->type) {
> -		case IIO_VOLTAGE:
> -			*val = 0;
> -			if (chan->channel == 0)
> -				*val2 = 305180; /* 0.30518 mV */
> -			else
> -				*val2 = 610500; /* 0.6105 mV */
> -			return IIO_VAL_INT_PLUS_MICRO;
> -		case IIO_TEMP:
> -			*val = -470; /* -0.47 C */
> -			*val2 = 0;
> -			return IIO_VAL_INT_PLUS_MICRO;
> -		case IIO_ACCEL:
> -			*val = 0;
> -			*val2 = IIO_G_TO_M_S_2(244140); /* 0.244140 mg */
> -			return IIO_VAL_INT_PLUS_NANO;
> -		case IIO_INCLI:
> -		case IIO_ROT:
> -			*val = 0;
> -			*val2 = 25000; /* 0.025 degree */
> -			return IIO_VAL_INT_PLUS_MICRO;
> -		default:
> -			return -EINVAL;
> -		}
> -		break;
> -	case IIO_CHAN_INFO_OFFSET:
> -		*val = 25000 / -470 - 0x4FE; /* 25 C = 0x4FE */
> -		return IIO_VAL_INT;
> -	case IIO_CHAN_INFO_CALIBBIAS:
> -		switch (chan->type) {
> -		case IIO_ACCEL:
> -			bits = 14;
> -			break;
> -		default:
> -			return -EINVAL;
> -		}
> -		mutex_lock(&indio_dev->mlock);
> -		addr = adis16209_addresses[chan->scan_index][0];
> -		ret = adis_read_reg_16(st, addr, &val16);
> -		if (ret) {
> -			mutex_unlock(&indio_dev->mlock);
> -			return ret;
> -		}
> -		val16 &= (1 << bits) - 1;
> -		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
> -		*val = val16;
> -		mutex_unlock(&indio_dev->mlock);
> -		return IIO_VAL_INT;
> -	}
> -	return -EINVAL;
> -}
> -
> -static const struct iio_chan_spec adis16209_channels[] = {
> -	ADIS_SUPPLY_CHAN(ADIS16209_SUPPLY_OUT, ADIS16209_SCAN_SUPPLY, 0, 14),
> -	ADIS_TEMP_CHAN(ADIS16209_TEMP_OUT, ADIS16209_SCAN_TEMP, 0, 12),
> -	ADIS_ACCEL_CHAN(X, ADIS16209_XACCL_OUT, ADIS16209_SCAN_ACC_X,
> -			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
> -	ADIS_ACCEL_CHAN(Y, ADIS16209_YACCL_OUT, ADIS16209_SCAN_ACC_Y,
> -			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
> -	ADIS_AUX_ADC_CHAN(ADIS16209_AUX_ADC, ADIS16209_SCAN_AUX_ADC, 0, 12),
> -	ADIS_INCLI_CHAN(X, ADIS16209_XINCL_OUT, ADIS16209_SCAN_INCLI_X,
> -			0, 0, 14),
> -	ADIS_INCLI_CHAN(Y, ADIS16209_YINCL_OUT, ADIS16209_SCAN_INCLI_Y,
> -			0, 0, 14),
> -	ADIS_ROT_CHAN(X, ADIS16209_ROT_OUT, ADIS16209_SCAN_ROT, 0, 0, 14),
> -	IIO_CHAN_SOFT_TIMESTAMP(8)
> -};
> -
> -static const struct iio_info adis16209_info = {
> -	.read_raw = &adis16209_read_raw,
> -	.write_raw = &adis16209_write_raw,
> -	.update_scan_mode = adis_update_scan_mode,
> -	.driver_module = THIS_MODULE,
> -};
> -
> -static const char * const adis16209_status_error_msgs[] = {
> -	[ADIS16209_DIAG_STAT_SELFTEST_FAIL_BIT] = "Self test failure",
> -	[ADIS16209_DIAG_STAT_SPI_FAIL_BIT] = "SPI failure",
> -	[ADIS16209_DIAG_STAT_FLASH_UPT_BIT] = "Flash update failed",
> -	[ADIS16209_DIAG_STAT_POWER_HIGH_BIT] = "Power supply above 3.625V",
> -	[ADIS16209_DIAG_STAT_POWER_LOW_BIT] = "Power supply below 3.15V",
> -};
> -
> -static const struct adis_data adis16209_data = {
> -	.read_delay = 30,
> -	.msc_ctrl_reg = ADIS16209_MSC_CTRL,
> -	.glob_cmd_reg = ADIS16209_GLOB_CMD,
> -	.diag_stat_reg = ADIS16209_DIAG_STAT,
> -
> -	.self_test_mask = ADIS16209_MSC_CTRL_SELF_TEST_EN,
> -	.self_test_no_autoclear = true,
> -	.startup_delay = ADIS16209_STARTUP_DELAY,
> -
> -	.status_error_msgs = adis16209_status_error_msgs,
> -	.status_error_mask = BIT(ADIS16209_DIAG_STAT_SELFTEST_FAIL_BIT) |
> -		BIT(ADIS16209_DIAG_STAT_SPI_FAIL_BIT) |
> -		BIT(ADIS16209_DIAG_STAT_FLASH_UPT_BIT) |
> -		BIT(ADIS16209_DIAG_STAT_POWER_HIGH_BIT) |
> -		BIT(ADIS16209_DIAG_STAT_POWER_LOW_BIT),
> -};
> -
> -static int adis16209_probe(struct spi_device *spi)
> -{
> -	int ret;
> -	struct adis *st;
> -	struct iio_dev *indio_dev;
> -
> -	/* setup the industrialio driver allocated elements */
> -	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> -	if (!indio_dev)
> -		return -ENOMEM;
> -	st = iio_priv(indio_dev);
> -	/* this is only used for removal purposes */
> -	spi_set_drvdata(spi, indio_dev);
> -
> -	indio_dev->name = spi->dev.driver->name;
> -	indio_dev->dev.parent = &spi->dev;
> -	indio_dev->info = &adis16209_info;
> -	indio_dev->channels = adis16209_channels;
> -	indio_dev->num_channels = ARRAY_SIZE(adis16209_channels);
> -	indio_dev->modes = INDIO_DIRECT_MODE;
> -
> -	ret = adis_init(st, indio_dev, spi, &adis16209_data);
> -	if (ret)
> -		return ret;
> -	ret = adis_setup_buffer_and_trigger(st, indio_dev, NULL);
> -	if (ret)
> -		return ret;
> -
> -	/* Get the device into a sane initial state */
> -	ret = adis_initial_startup(st);
> -	if (ret)
> -		goto error_cleanup_buffer_trigger;
> -	ret = iio_device_register(indio_dev);
> -	if (ret)
> -		goto error_cleanup_buffer_trigger;
> -
> -	return 0;
> -
> -error_cleanup_buffer_trigger:
> -	adis_cleanup_buffer_and_trigger(st, indio_dev);
> -	return ret;
> -}
> -
> -static int adis16209_remove(struct spi_device *spi)
> -{
> -	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> -	struct adis *st = iio_priv(indio_dev);
> -
> -	iio_device_unregister(indio_dev);
> -	adis_cleanup_buffer_and_trigger(st, indio_dev);
> -
> -	return 0;
> -}
> -
> -static struct spi_driver adis16209_driver = {
> -	.driver = {
> -		.name = "adis16209",
> -	},
> -	.probe = adis16209_probe,
> -	.remove = adis16209_remove,
> -};
> -module_spi_driver(adis16209_driver);
> -
> -MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
> -MODULE_DESCRIPTION("Analog Devices ADIS16209 Dual-Axis Digital Inclinometer and Accelerometer");
> -MODULE_LICENSE("GPL v2");
> -MODULE_ALIAS("spi:adis16209");
> diff --git a/drivers/staging/iio/accel/adis16240.c b/drivers/staging/iio/accel/adis16240.c
> new file mode 100644
> index 0000000..d5b99e6
> --- /dev/null
> +++ b/drivers/staging/iio/accel/adis16240.c
> @@ -0,0 +1,301 @@
> +/*
> + * ADIS16240 Programmable Impact Sensor and Recorder driver
> + *
> + * Copyright 2010 Analog Devices Inc.
> + *
> + * Licensed under the GPL-2 or later.
> + */
> +
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/gpio.h>
> +#include <linux/delay.h>
> +#include <linux/mutex.h>
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/spi/spi.h>
> +#include <linux/slab.h>
> +#include <linux/sysfs.h>
> +#include <linux/list.h>
> +#include <linux/module.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/imu/adis.h>
> +
> +#include "adis16240.h"
> +
> +static ssize_t adis16240_spi_read_signed(struct device *dev,
> +					 struct device_attribute *attr,
> +					 char *buf,
> +					 unsigned int bits)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct adis *st = iio_priv(indio_dev);
> +	int ret;
> +	s16 val = 0;
> +	unsigned int shift = 16 - bits;
> +	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> +
> +	ret = adis_read_reg_16(st,
> +			       this_attr->address, (u16 *)&val);
> +	if (ret)
> +		return ret;
> +
> +	if (val & ADIS16240_ERROR_ACTIVE)
> +		adis_check_status(st);
> +
> +	val = (s16)(val << shift) >> shift;
> +	return sprintf(buf, "%d\n", val);
> +}
> +
> +static ssize_t adis16240_read_12bit_signed(struct device *dev,
> +					   struct device_attribute *attr,
> +					   char *buf)
> +{
> +	ssize_t ret;
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +
> +	/* Take the iio_dev status lock */
> +	mutex_lock(&indio_dev->mlock);
> +	ret =  adis16240_spi_read_signed(dev, attr, buf, 12);
> +	mutex_unlock(&indio_dev->mlock);
> +
> +	return ret;
> +}
> +
> +static IIO_DEVICE_ATTR(in_accel_xyz_squared_peak_raw, S_IRUGO,
> +		       adis16240_read_12bit_signed, NULL,
> +		       ADIS16240_XYZPEAK_OUT);
> +
> +static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("4096");
> +
> +static const u8 adis16240_addresses[][2] = {
> +	[ADIS16240_SCAN_ACC_X] = { ADIS16240_XACCL_OFF, ADIS16240_XPEAK_OUT },
> +	[ADIS16240_SCAN_ACC_Y] = { ADIS16240_YACCL_OFF, ADIS16240_YPEAK_OUT },
> +	[ADIS16240_SCAN_ACC_Z] = { ADIS16240_ZACCL_OFF, ADIS16240_ZPEAK_OUT },
> +};
> +
> +static int adis16240_read_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      int *val, int *val2,
> +			      long mask)
> +{
> +	struct adis *st = iio_priv(indio_dev);
> +	int ret;
> +	int bits;
> +	u8 addr;
> +	s16 val16;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		return adis_single_conversion(indio_dev, chan,
> +				ADIS16240_ERROR_ACTIVE, val);
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_VOLTAGE:
> +			if (chan->channel == 0) {
> +				*val = 4;
> +				*val2 = 880000; /* 4.88 mV */
> +				return IIO_VAL_INT_PLUS_MICRO;
> +			}
> +			return -EINVAL;
> +		case IIO_TEMP:
> +			*val = 244; /* 0.244 C */
> +			*val2 = 0;
> +			return IIO_VAL_INT_PLUS_MICRO;
> +		case IIO_ACCEL:
> +			*val = 0;
> +			*val2 = IIO_G_TO_M_S_2(51400); /* 51.4 mg */
> +			return IIO_VAL_INT_PLUS_MICRO;
> +		default:
> +			return -EINVAL;
> +		}
> +		break;
> +	case IIO_CHAN_INFO_PEAK_SCALE:
> +		*val = 0;
> +		*val2 = IIO_G_TO_M_S_2(51400); /* 51.4 mg */
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	case IIO_CHAN_INFO_OFFSET:
> +		*val = 25000 / 244 - 0x133; /* 25 C = 0x133 */
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		bits = 10;
> +		mutex_lock(&indio_dev->mlock);
> +		addr = adis16240_addresses[chan->scan_index][0];
> +		ret = adis_read_reg_16(st, addr, &val16);
> +		if (ret) {
> +			mutex_unlock(&indio_dev->mlock);
> +			return ret;
> +		}
> +		val16 &= (1 << bits) - 1;
> +		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
> +		*val = val16;
> +		mutex_unlock(&indio_dev->mlock);
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_PEAK:
> +		bits = 10;
> +		mutex_lock(&indio_dev->mlock);
> +		addr = adis16240_addresses[chan->scan_index][1];
> +		ret = adis_read_reg_16(st, addr, &val16);
> +		if (ret) {
> +			mutex_unlock(&indio_dev->mlock);
> +			return ret;
> +		}
> +		val16 &= (1 << bits) - 1;
> +		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
> +		*val = val16;
> +		mutex_unlock(&indio_dev->mlock);
> +		return IIO_VAL_INT;
> +	}
> +	return -EINVAL;
> +}
> +
> +static int adis16240_write_raw(struct iio_dev *indio_dev,
> +			       struct iio_chan_spec const *chan,
> +			       int val,
> +			       int val2,
> +			       long mask)
> +{
> +	struct adis *st = iio_priv(indio_dev);
> +	int bits = 10;
> +	s16 val16;
> +	u8 addr;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		val16 = val & ((1 << bits) - 1);
> +		addr = adis16240_addresses[chan->scan_index][0];
> +		return adis_write_reg_16(st, addr, val16);
> +	}
> +	return -EINVAL;
> +}
> +
> +static const struct iio_chan_spec adis16240_channels[] = {
> +	ADIS_SUPPLY_CHAN(ADIS16240_SUPPLY_OUT, ADIS16240_SCAN_SUPPLY, 0, 10),
> +	ADIS_AUX_ADC_CHAN(ADIS16240_AUX_ADC, ADIS16240_SCAN_AUX_ADC, 0, 10),
> +	ADIS_ACCEL_CHAN(X, ADIS16240_XACCL_OUT, ADIS16240_SCAN_ACC_X,
> +			BIT(IIO_CHAN_INFO_CALIBBIAS) | BIT(IIO_CHAN_INFO_PEAK),
> +			0, 10),
> +	ADIS_ACCEL_CHAN(Y, ADIS16240_YACCL_OUT, ADIS16240_SCAN_ACC_Y,
> +			BIT(IIO_CHAN_INFO_CALIBBIAS) | BIT(IIO_CHAN_INFO_PEAK),
> +			0, 10),
> +	ADIS_ACCEL_CHAN(Z, ADIS16240_ZACCL_OUT, ADIS16240_SCAN_ACC_Z,
> +			BIT(IIO_CHAN_INFO_CALIBBIAS) | BIT(IIO_CHAN_INFO_PEAK),
> +			0, 10),
> +	ADIS_TEMP_CHAN(ADIS16240_TEMP_OUT, ADIS16240_SCAN_TEMP, 0, 10),
> +	IIO_CHAN_SOFT_TIMESTAMP(6)
> +};
> +
> +static struct attribute *adis16240_attributes[] = {
> +	&iio_dev_attr_in_accel_xyz_squared_peak_raw.dev_attr.attr,
> +	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group adis16240_attribute_group = {
> +	.attrs = adis16240_attributes,
> +};
> +
> +static const struct iio_info adis16240_info = {
> +	.attrs = &adis16240_attribute_group,
> +	.read_raw = &adis16240_read_raw,
> +	.write_raw = &adis16240_write_raw,
> +	.update_scan_mode = adis_update_scan_mode,
> +	.driver_module = THIS_MODULE,
> +};
> +
> +static const char * const adis16240_status_error_msgs[] = {
> +	[ADIS16240_DIAG_STAT_PWRON_FAIL_BIT] = "Power on, self-test failed",
> +	[ADIS16240_DIAG_STAT_SPI_FAIL_BIT] = "SPI failure",
> +	[ADIS16240_DIAG_STAT_FLASH_UPT_BIT] = "Flash update failed",
> +	[ADIS16240_DIAG_STAT_POWER_HIGH_BIT] = "Power supply above 3.625V",
> +	[ADIS16240_DIAG_STAT_POWER_LOW_BIT] = "Power supply below 2.225V",
> +};
> +
> +static const struct adis_data adis16240_data = {
> +	.write_delay = 35,
> +	.read_delay = 35,
> +	.msc_ctrl_reg = ADIS16240_MSC_CTRL,
> +	.glob_cmd_reg = ADIS16240_GLOB_CMD,
> +	.diag_stat_reg = ADIS16240_DIAG_STAT,
> +
> +	.self_test_mask = ADIS16240_MSC_CTRL_SELF_TEST_EN,
> +	.self_test_no_autoclear = true,
> +	.startup_delay = ADIS16240_STARTUP_DELAY,
> +
> +	.status_error_msgs = adis16240_status_error_msgs,
> +	.status_error_mask = BIT(ADIS16240_DIAG_STAT_PWRON_FAIL_BIT) |
> +		BIT(ADIS16240_DIAG_STAT_SPI_FAIL_BIT) |
> +		BIT(ADIS16240_DIAG_STAT_FLASH_UPT_BIT) |
> +		BIT(ADIS16240_DIAG_STAT_POWER_HIGH_BIT) |
> +		BIT(ADIS16240_DIAG_STAT_POWER_LOW_BIT),
> +};
> +
> +static int adis16240_probe(struct spi_device *spi)
> +{
> +	int ret;
> +	struct adis *st;
> +	struct iio_dev *indio_dev;
> +
> +	/* setup the industrialio driver allocated elements */
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +	st = iio_priv(indio_dev);
> +	/* this is only used for removal purposes */
> +	spi_set_drvdata(spi, indio_dev);
> +
> +	indio_dev->name = spi->dev.driver->name;
> +	indio_dev->dev.parent = &spi->dev;
> +	indio_dev->info = &adis16240_info;
> +	indio_dev->channels = adis16240_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(adis16240_channels);
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	ret = adis_init(st, indio_dev, spi, &adis16240_data);
> +	if (ret)
> +		return ret;
> +	ret = adis_setup_buffer_and_trigger(st, indio_dev, NULL);
> +	if (ret)
> +		return ret;
> +
> +	/* Get the device into a sane initial state */
> +	ret = adis_initial_startup(st);
> +	if (ret)
> +		goto error_cleanup_buffer_trigger;
> +	ret = iio_device_register(indio_dev);
> +	if (ret)
> +		goto error_cleanup_buffer_trigger;
> +	return 0;
> +
> +error_cleanup_buffer_trigger:
> +	adis_cleanup_buffer_and_trigger(st, indio_dev);
> +	return ret;
> +}
> +
> +static int adis16240_remove(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> +	struct adis *st = iio_priv(indio_dev);
> +
> +	iio_device_unregister(indio_dev);
> +	adis_cleanup_buffer_and_trigger(st, indio_dev);
> +
> +	return 0;
> +}
> +
> +static struct spi_driver adis16240_driver = {
> +	.driver = {
> +		.name = "adis16240",
> +	},
> +	.probe = adis16240_probe,
> +	.remove = adis16240_remove,
> +};
> +module_spi_driver(adis16240_driver);
> +
> +MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
> +MODULE_DESCRIPTION("Analog Devices Programmable Impact Sensor and Recorder");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("spi:adis16240");
> diff --git a/drivers/staging/iio/accel/adis16240_core.c b/drivers/staging/iio/accel/adis16240_core.c
> deleted file mode 100644
> index d5b99e6..0000000
> --- a/drivers/staging/iio/accel/adis16240_core.c
> +++ /dev/null
> @@ -1,301 +0,0 @@
> -/*
> - * ADIS16240 Programmable Impact Sensor and Recorder driver
> - *
> - * Copyright 2010 Analog Devices Inc.
> - *
> - * Licensed under the GPL-2 or later.
> - */
> -
> -#include <linux/interrupt.h>
> -#include <linux/irq.h>
> -#include <linux/gpio.h>
> -#include <linux/delay.h>
> -#include <linux/mutex.h>
> -#include <linux/device.h>
> -#include <linux/kernel.h>
> -#include <linux/spi/spi.h>
> -#include <linux/slab.h>
> -#include <linux/sysfs.h>
> -#include <linux/list.h>
> -#include <linux/module.h>
> -
> -#include <linux/iio/iio.h>
> -#include <linux/iio/sysfs.h>
> -#include <linux/iio/buffer.h>
> -#include <linux/iio/imu/adis.h>
> -
> -#include "adis16240.h"
> -
> -static ssize_t adis16240_spi_read_signed(struct device *dev,
> -					 struct device_attribute *attr,
> -					 char *buf,
> -					 unsigned int bits)
> -{
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct adis *st = iio_priv(indio_dev);
> -	int ret;
> -	s16 val = 0;
> -	unsigned int shift = 16 - bits;
> -	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> -
> -	ret = adis_read_reg_16(st,
> -			       this_attr->address, (u16 *)&val);
> -	if (ret)
> -		return ret;
> -
> -	if (val & ADIS16240_ERROR_ACTIVE)
> -		adis_check_status(st);
> -
> -	val = (s16)(val << shift) >> shift;
> -	return sprintf(buf, "%d\n", val);
> -}
> -
> -static ssize_t adis16240_read_12bit_signed(struct device *dev,
> -					   struct device_attribute *attr,
> -					   char *buf)
> -{
> -	ssize_t ret;
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -
> -	/* Take the iio_dev status lock */
> -	mutex_lock(&indio_dev->mlock);
> -	ret =  adis16240_spi_read_signed(dev, attr, buf, 12);
> -	mutex_unlock(&indio_dev->mlock);
> -
> -	return ret;
> -}
> -
> -static IIO_DEVICE_ATTR(in_accel_xyz_squared_peak_raw, S_IRUGO,
> -		       adis16240_read_12bit_signed, NULL,
> -		       ADIS16240_XYZPEAK_OUT);
> -
> -static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("4096");
> -
> -static const u8 adis16240_addresses[][2] = {
> -	[ADIS16240_SCAN_ACC_X] = { ADIS16240_XACCL_OFF, ADIS16240_XPEAK_OUT },
> -	[ADIS16240_SCAN_ACC_Y] = { ADIS16240_YACCL_OFF, ADIS16240_YPEAK_OUT },
> -	[ADIS16240_SCAN_ACC_Z] = { ADIS16240_ZACCL_OFF, ADIS16240_ZPEAK_OUT },
> -};
> -
> -static int adis16240_read_raw(struct iio_dev *indio_dev,
> -			      struct iio_chan_spec const *chan,
> -			      int *val, int *val2,
> -			      long mask)
> -{
> -	struct adis *st = iio_priv(indio_dev);
> -	int ret;
> -	int bits;
> -	u8 addr;
> -	s16 val16;
> -
> -	switch (mask) {
> -	case IIO_CHAN_INFO_RAW:
> -		return adis_single_conversion(indio_dev, chan,
> -				ADIS16240_ERROR_ACTIVE, val);
> -	case IIO_CHAN_INFO_SCALE:
> -		switch (chan->type) {
> -		case IIO_VOLTAGE:
> -			if (chan->channel == 0) {
> -				*val = 4;
> -				*val2 = 880000; /* 4.88 mV */
> -				return IIO_VAL_INT_PLUS_MICRO;
> -			}
> -			return -EINVAL;
> -		case IIO_TEMP:
> -			*val = 244; /* 0.244 C */
> -			*val2 = 0;
> -			return IIO_VAL_INT_PLUS_MICRO;
> -		case IIO_ACCEL:
> -			*val = 0;
> -			*val2 = IIO_G_TO_M_S_2(51400); /* 51.4 mg */
> -			return IIO_VAL_INT_PLUS_MICRO;
> -		default:
> -			return -EINVAL;
> -		}
> -		break;
> -	case IIO_CHAN_INFO_PEAK_SCALE:
> -		*val = 0;
> -		*val2 = IIO_G_TO_M_S_2(51400); /* 51.4 mg */
> -		return IIO_VAL_INT_PLUS_MICRO;
> -	case IIO_CHAN_INFO_OFFSET:
> -		*val = 25000 / 244 - 0x133; /* 25 C = 0x133 */
> -		return IIO_VAL_INT;
> -	case IIO_CHAN_INFO_CALIBBIAS:
> -		bits = 10;
> -		mutex_lock(&indio_dev->mlock);
> -		addr = adis16240_addresses[chan->scan_index][0];
> -		ret = adis_read_reg_16(st, addr, &val16);
> -		if (ret) {
> -			mutex_unlock(&indio_dev->mlock);
> -			return ret;
> -		}
> -		val16 &= (1 << bits) - 1;
> -		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
> -		*val = val16;
> -		mutex_unlock(&indio_dev->mlock);
> -		return IIO_VAL_INT;
> -	case IIO_CHAN_INFO_PEAK:
> -		bits = 10;
> -		mutex_lock(&indio_dev->mlock);
> -		addr = adis16240_addresses[chan->scan_index][1];
> -		ret = adis_read_reg_16(st, addr, &val16);
> -		if (ret) {
> -			mutex_unlock(&indio_dev->mlock);
> -			return ret;
> -		}
> -		val16 &= (1 << bits) - 1;
> -		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
> -		*val = val16;
> -		mutex_unlock(&indio_dev->mlock);
> -		return IIO_VAL_INT;
> -	}
> -	return -EINVAL;
> -}
> -
> -static int adis16240_write_raw(struct iio_dev *indio_dev,
> -			       struct iio_chan_spec const *chan,
> -			       int val,
> -			       int val2,
> -			       long mask)
> -{
> -	struct adis *st = iio_priv(indio_dev);
> -	int bits = 10;
> -	s16 val16;
> -	u8 addr;
> -
> -	switch (mask) {
> -	case IIO_CHAN_INFO_CALIBBIAS:
> -		val16 = val & ((1 << bits) - 1);
> -		addr = adis16240_addresses[chan->scan_index][0];
> -		return adis_write_reg_16(st, addr, val16);
> -	}
> -	return -EINVAL;
> -}
> -
> -static const struct iio_chan_spec adis16240_channels[] = {
> -	ADIS_SUPPLY_CHAN(ADIS16240_SUPPLY_OUT, ADIS16240_SCAN_SUPPLY, 0, 10),
> -	ADIS_AUX_ADC_CHAN(ADIS16240_AUX_ADC, ADIS16240_SCAN_AUX_ADC, 0, 10),
> -	ADIS_ACCEL_CHAN(X, ADIS16240_XACCL_OUT, ADIS16240_SCAN_ACC_X,
> -			BIT(IIO_CHAN_INFO_CALIBBIAS) | BIT(IIO_CHAN_INFO_PEAK),
> -			0, 10),
> -	ADIS_ACCEL_CHAN(Y, ADIS16240_YACCL_OUT, ADIS16240_SCAN_ACC_Y,
> -			BIT(IIO_CHAN_INFO_CALIBBIAS) | BIT(IIO_CHAN_INFO_PEAK),
> -			0, 10),
> -	ADIS_ACCEL_CHAN(Z, ADIS16240_ZACCL_OUT, ADIS16240_SCAN_ACC_Z,
> -			BIT(IIO_CHAN_INFO_CALIBBIAS) | BIT(IIO_CHAN_INFO_PEAK),
> -			0, 10),
> -	ADIS_TEMP_CHAN(ADIS16240_TEMP_OUT, ADIS16240_SCAN_TEMP, 0, 10),
> -	IIO_CHAN_SOFT_TIMESTAMP(6)
> -};
> -
> -static struct attribute *adis16240_attributes[] = {
> -	&iio_dev_attr_in_accel_xyz_squared_peak_raw.dev_attr.attr,
> -	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
> -	NULL
> -};
> -
> -static const struct attribute_group adis16240_attribute_group = {
> -	.attrs = adis16240_attributes,
> -};
> -
> -static const struct iio_info adis16240_info = {
> -	.attrs = &adis16240_attribute_group,
> -	.read_raw = &adis16240_read_raw,
> -	.write_raw = &adis16240_write_raw,
> -	.update_scan_mode = adis_update_scan_mode,
> -	.driver_module = THIS_MODULE,
> -};
> -
> -static const char * const adis16240_status_error_msgs[] = {
> -	[ADIS16240_DIAG_STAT_PWRON_FAIL_BIT] = "Power on, self-test failed",
> -	[ADIS16240_DIAG_STAT_SPI_FAIL_BIT] = "SPI failure",
> -	[ADIS16240_DIAG_STAT_FLASH_UPT_BIT] = "Flash update failed",
> -	[ADIS16240_DIAG_STAT_POWER_HIGH_BIT] = "Power supply above 3.625V",
> -	[ADIS16240_DIAG_STAT_POWER_LOW_BIT] = "Power supply below 2.225V",
> -};
> -
> -static const struct adis_data adis16240_data = {
> -	.write_delay = 35,
> -	.read_delay = 35,
> -	.msc_ctrl_reg = ADIS16240_MSC_CTRL,
> -	.glob_cmd_reg = ADIS16240_GLOB_CMD,
> -	.diag_stat_reg = ADIS16240_DIAG_STAT,
> -
> -	.self_test_mask = ADIS16240_MSC_CTRL_SELF_TEST_EN,
> -	.self_test_no_autoclear = true,
> -	.startup_delay = ADIS16240_STARTUP_DELAY,
> -
> -	.status_error_msgs = adis16240_status_error_msgs,
> -	.status_error_mask = BIT(ADIS16240_DIAG_STAT_PWRON_FAIL_BIT) |
> -		BIT(ADIS16240_DIAG_STAT_SPI_FAIL_BIT) |
> -		BIT(ADIS16240_DIAG_STAT_FLASH_UPT_BIT) |
> -		BIT(ADIS16240_DIAG_STAT_POWER_HIGH_BIT) |
> -		BIT(ADIS16240_DIAG_STAT_POWER_LOW_BIT),
> -};
> -
> -static int adis16240_probe(struct spi_device *spi)
> -{
> -	int ret;
> -	struct adis *st;
> -	struct iio_dev *indio_dev;
> -
> -	/* setup the industrialio driver allocated elements */
> -	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> -	if (!indio_dev)
> -		return -ENOMEM;
> -	st = iio_priv(indio_dev);
> -	/* this is only used for removal purposes */
> -	spi_set_drvdata(spi, indio_dev);
> -
> -	indio_dev->name = spi->dev.driver->name;
> -	indio_dev->dev.parent = &spi->dev;
> -	indio_dev->info = &adis16240_info;
> -	indio_dev->channels = adis16240_channels;
> -	indio_dev->num_channels = ARRAY_SIZE(adis16240_channels);
> -	indio_dev->modes = INDIO_DIRECT_MODE;
> -
> -	ret = adis_init(st, indio_dev, spi, &adis16240_data);
> -	if (ret)
> -		return ret;
> -	ret = adis_setup_buffer_and_trigger(st, indio_dev, NULL);
> -	if (ret)
> -		return ret;
> -
> -	/* Get the device into a sane initial state */
> -	ret = adis_initial_startup(st);
> -	if (ret)
> -		goto error_cleanup_buffer_trigger;
> -	ret = iio_device_register(indio_dev);
> -	if (ret)
> -		goto error_cleanup_buffer_trigger;
> -	return 0;
> -
> -error_cleanup_buffer_trigger:
> -	adis_cleanup_buffer_and_trigger(st, indio_dev);
> -	return ret;
> -}
> -
> -static int adis16240_remove(struct spi_device *spi)
> -{
> -	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> -	struct adis *st = iio_priv(indio_dev);
> -
> -	iio_device_unregister(indio_dev);
> -	adis_cleanup_buffer_and_trigger(st, indio_dev);
> -
> -	return 0;
> -}
> -
> -static struct spi_driver adis16240_driver = {
> -	.driver = {
> -		.name = "adis16240",
> -	},
> -	.probe = adis16240_probe,
> -	.remove = adis16240_remove,
> -};
> -module_spi_driver(adis16240_driver);
> -
> -MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
> -MODULE_DESCRIPTION("Analog Devices Programmable Impact Sensor and Recorder");
> -MODULE_LICENSE("GPL v2");
> -MODULE_ALIAS("spi:adis16240");
> 

