Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754755AbeCGU6n (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 7 Mar 2018 15:58:43 -0500
Date: Wed, 7 Mar 2018 20:58:38 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Himanshu Jha <himanshujha199640@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, daniel.baluta@gmail.com
Subject: Re: [PATCH 11/11] Staging: iio: accel: Move adis16201 driver out of
 staging subsystem
Message-ID: <20180307205838.18603e5e@archlinux>
In-Reply-To: <1520236170-14668-12-git-send-email-himanshujha199640@gmail.com>
References: <1520236170-14668-1-git-send-email-himanshujha199640@gmail.com>
        <1520236170-14668-12-git-send-email-himanshujha199640@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon,  5 Mar 2018 13:19:30 +0530
Himanshu Jha <himanshujha199640@gmail.com> wrote:

> Move the adis16201 driver out of staging directory and merge to the
> mainline IIO subsystem.
> 
> Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
One comment inline (that I should have noticed in one of your earlier patches but
missed).

Michael, do you have the time to look through these at the moment?

The changes are not likely to break anything so if you are too busy I'm happy to
move them out of staging if you are fine with that.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/Kconfig             |  12 ++
>  drivers/iio/accel/Makefile            |   1 +
>  drivers/iio/accel/adis16201.c         | 323 ++++++++++++++++++++++++++++++++++
>  drivers/staging/iio/accel/Kconfig     |  12 --
>  drivers/staging/iio/accel/Makefile    |   1 -
>  drivers/staging/iio/accel/adis16201.c | 323 ----------------------------------
>  6 files changed, 336 insertions(+), 336 deletions(-)
>  create mode 100644 drivers/iio/accel/adis16201.c
>  delete mode 100644 drivers/staging/iio/accel/adis16201.c
> 
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index c6d9517..9416c6f 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -5,6 +5,18 @@
>  
>  menu "Accelerometers"
>  
> +config ADIS16201
> +        tristate "Analog Devices ADIS16201 Dual-Axis Digital Inclinometer and Accelerometer"
> +        depends on SPI
> +        select IIO_ADIS_LIB
> +        select IIO_ADIS_LIB_BUFFER if IIO_BUFFER
> +        help
> +          Say Y here to build support for Analog Devices adis16201 dual-axis
> +          digital inclinometer and accelerometer.
> +
> +          To compile this driver as a module, say M here: the module will
> +          be called adis16201.
> +
>  config ADXL345
>  	tristate
>  
> diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
> index 368aedb..7832ec9 100644
> --- a/drivers/iio/accel/Makefile
> +++ b/drivers/iio/accel/Makefile
> @@ -4,6 +4,7 @@
>  #
>  
>  # When adding new entries keep the list in alphabetical order
> +obj-$(CONFIG_ADIS16201) += adis16201.o
>  obj-$(CONFIG_ADXL345) += adxl345_core.o
>  obj-$(CONFIG_ADXL345_I2C) += adxl345_i2c.o
>  obj-$(CONFIG_ADXL345_SPI) += adxl345_spi.o
> diff --git a/drivers/iio/accel/adis16201.c b/drivers/iio/accel/adis16201.c
> new file mode 100644
> index 0000000..946c7b1
> --- /dev/null
> +++ b/drivers/iio/accel/adis16201.c
> @@ -0,0 +1,323 @@
> +/*
> + * ADIS16201 Dual-Axis Digital Inclinometer and Accelerometer
> + *
> + * Copyright 2010 Analog Devices Inc.
> + *
> + * Licensed under the GPL-2 or later.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/slab.h>
> +#include <linux/spi/spi.h>
> +#include <linux/sysfs.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/imu/adis.h>
> +
> +#define ADIS16201_STARTUP_DELAY_MS				220
> +#define ADIS16201_FLASH_CNT					0x00
> +
> +/* Data Output Register Information */
> +#define ADIS16201_SUPPLY_OUT_REG				0x02
> +#define ADIS16201_XACCL_OUT_REG					0x04
> +#define ADIS16201_YACCL_OUT_REG					0x06
> +#define ADIS16201_AUX_ADC_REG					0x08
> +#define ADIS16201_TEMP_OUT_REG					0x0A
> +#define ADIS16201_XINCL_OUT_REG					0x0C
> +#define ADIS16201_YINCL_OUT_REG					0x0E
> +
> +/* Calibration Register Definition */
> +#define ADIS16201_XACCL_OFFS_REG				0x10
> +#define ADIS16201_YACCL_OFFS_REG				0x12
> +#define ADIS16201_XACCL_SCALE_REG				0x14
> +#define ADIS16201_YACCL_SCALE_REG				0x16
> +#define ADIS16201_XINCL_OFFS_REG				0x18
> +#define ADIS16201_YINCL_OFFS_REG				0x1A
> +#define ADIS16201_XINCL_SCALE_REG				0x1C
> +#define ADIS16201_YINCL_SCALE_REG				0x1E
> +
> +/* Alarm Register Definition */
> +#define ADIS16201_ALM_MAG1_REG					0x20
> +#define ADIS16201_ALM_MAG2_REG					0x22
> +#define ADIS16201_ALM_SMPL1_REG					0x24
> +#define ADIS16201_ALM_SMPL2_REG					0x26
> +#define ADIS16201_ALM_CTRL_REG					0x28
> +
> +#define ADIS16201_AUX_DAC_REG					0x30
> +#define ADIS16201_GPIO_CTRL_REG					0x32
> +#define ADIS16201_MSC_CTRL_REG					0x34
> +#define ADIS16201_SMPL_PRD_REG					0x36
> +#define ADIS16201_AVG_CNT_REG					0x38
> +#define ADIS16201_SLP_CNT_REG					0x3A
> +
> +/* Miscellaneous Control Register Definition */
> +#define ADIS16201_MSC_CTRL_REG					0x34
> +#define  ADIS16201_MSC_CTRL_SELF_TEST_EN			BIT(8)
> +#define  ADIS16201_MSC_CTRL_DATA_RDY_EN				BIT(2)
> +#define  ADIS16201_MSC_CTRL_ACTIVE_DATA_RDY_HIGH		BIT(1)
> +#define  ADIS16201_MSC_CTRL_DATA_RDY_DIO1			BIT(0)
> +
> +/* Diagnostics, system status register */
> +#define ADIS16201_DIAG_STAT_REG					0x3C
> +#define  ADIS16201_DIAG_STAT_ALARM2				BIT(9)
> +#define  ADIS16201_DIAG_STAT_ALARM1				BIT(8)
> +#define  ADIS16201_DIAG_STAT_SPI_FAIL_BIT			3
> +#define  ADIS16201_DIAG_STAT_FLASH_UPT_FAIL_BIT			2
> +#define  ADIS16201_DIAG_STAT_POWER_HIGH_BIT			1
> +#define  ADIS16201_DIAG_STAT_POWER_LOW_BIT			0
> +
> +/* Operation, system command register */
> +#define ADIS16201_GLOB_CMD_REG					0x3E
> +#define  ADIS16201_GLOB_CMD_SW_RESET				BIT(7)
> +#define  ADIS16201_GLOB_CMD_FACTORY				BIT(1)
> +
> +#define ADIS16201_ERROR_ACTIVE					BIT(14)
> +
> +enum adis16201_scan {
> +	ADIS16201_SCAN_ACC_X,
> +	ADIS16201_SCAN_ACC_Y,
> +	ADIS16201_SCAN_INCLI_X,
> +	ADIS16201_SCAN_INCLI_Y,
> +	ADIS16201_SCAN_SUPPLY,
> +	ADIS16201_SCAN_AUX_ADC,
> +	ADIS16201_SCAN_TEMP,
> +};
> +
> +static const u8 adis16201_addresses[] = {
> +	[ADIS16201_SCAN_ACC_X] = ADIS16201_XACCL_OFFS_REG,
> +	[ADIS16201_SCAN_ACC_Y] = ADIS16201_YACCL_OFFS_REG,
> +	[ADIS16201_SCAN_INCLI_X] = ADIS16201_XINCL_OFFS_REG,
> +	[ADIS16201_SCAN_INCLI_Y] = ADIS16201_YINCL_OFFS_REG,
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
> +						ADIS16201_ERROR_ACTIVE, val);
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_VOLTAGE:
> +			switch (chan->channel) {
> +			case 0:
> +				*val = 1;
> +				*val2 = 220000;
> +				break;
> +			case 1:
> +				*val = 0;
> +				*val2 = 610000;
> +				break;
> +			}
> +			return IIO_VAL_INT_PLUS_MICRO;
> +		case IIO_TEMP:
> +			*val = -470;
> +			*val2 = 0;
> +			return IIO_VAL_INT_PLUS_MICRO;
> +		case IIO_ACCEL:
> +		       /*
> +			* IIO base unit for sensitivity of accelerometer
> +			* is milli g.
> +			* 1 LSB represents 0.244 mg.
> +			*/
> +			*val = 0;
> +			*val2 = IIO_G_TO_M_S_2(462400);
> +			return IIO_VAL_INT_PLUS_NANO;
> +		case IIO_INCLI:
> +			*val = 0;
> +			*val2 = 100000;
> +			return IIO_VAL_INT_PLUS_MICRO;
> +		default:
> +			return -EINVAL;
> +		}
> +		break;
> +	case IIO_CHAN_INFO_OFFSET:
> +	       /*
> +		* The raw ADC value is 0x4FE when the temperature
Ah, I missed this earlier.  Why have it in hex here in the comment
and decimal in the maths.  Make them the same (either way round
is fine)

> +		* is 25 degrees and the scale factor per milli
> +		* degree celcius is -470.
> +		*/
> +		*val = 25000 / -470 - 1278;
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
> +		addr = adis16201_addresses[chan->scan_index];
> +		ret = adis_read_reg_16(st, addr, &val16);
> +		if (ret)
> +			return ret;
> +
> +		*val = sign_extend32(val16, bits - 1);
> +		return IIO_VAL_INT;
> +	}
> +
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
> +
> +	return -EINVAL;
> +}
> +
> +static const struct iio_chan_spec adis16201_channels[] = {
> +	ADIS_SUPPLY_CHAN(ADIS16201_SUPPLY_OUT_REG, ADIS16201_SCAN_SUPPLY, 0, 12),
> +	ADIS_TEMP_CHAN(ADIS16201_TEMP_OUT_REG, ADIS16201_SCAN_TEMP, 0, 12),
> +	ADIS_ACCEL_CHAN(X, ADIS16201_XACCL_OUT_REG, ADIS16201_SCAN_ACC_X,
> +			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
> +	ADIS_ACCEL_CHAN(Y, ADIS16201_YACCL_OUT_REG, ADIS16201_SCAN_ACC_Y,
> +			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
> +	ADIS_AUX_ADC_CHAN(ADIS16201_AUX_ADC_REG, ADIS16201_SCAN_AUX_ADC, 0, 12),
> +	ADIS_INCLI_CHAN(X, ADIS16201_XINCL_OUT_REG, ADIS16201_SCAN_INCLI_X,
> +			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
> +	ADIS_INCLI_CHAN(X, ADIS16201_YINCL_OUT_REG, ADIS16201_SCAN_INCLI_Y,
> +			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
> +	IIO_CHAN_SOFT_TIMESTAMP(7)
> +};
> +
> +static const struct iio_info adis16201_info = {
> +	.read_raw = adis16201_read_raw,
> +	.write_raw = adis16201_write_raw,
> +	.update_scan_mode = adis_update_scan_mode,
> +};
> +
> +static const char * const adis16201_status_error_msgs[] = {
> +	[ADIS16201_DIAG_STAT_SPI_FAIL_BIT] = "SPI failure",
> +	[ADIS16201_DIAG_STAT_FLASH_UPT_FAIL_BIT] = "Flash update failed",
> +	[ADIS16201_DIAG_STAT_POWER_HIGH_BIT] = "Power supply above 3.625V",
> +	[ADIS16201_DIAG_STAT_POWER_LOW_BIT] = "Power supply below 3.15V",
> +};
> +
> +static const struct adis_data adis16201_data = {
> +	.read_delay = 20,
> +	.msc_ctrl_reg = ADIS16201_MSC_CTRL_REG,
> +	.glob_cmd_reg = ADIS16201_GLOB_CMD_REG,
> +	.diag_stat_reg = ADIS16201_DIAG_STAT_REG,
> +
> +	.self_test_mask = ADIS16201_MSC_CTRL_SELF_TEST_EN,
> +	.self_test_no_autoclear = true,
> +	.startup_delay = ADIS16201_STARTUP_DELAY_MS,
> +
> +	.status_error_msgs = adis16201_status_error_msgs,
> +	.status_error_mask = BIT(ADIS16201_DIAG_STAT_SPI_FAIL_BIT) |
> +		BIT(ADIS16201_DIAG_STAT_FLASH_UPT_FAIL_BIT) |
> +		BIT(ADIS16201_DIAG_STAT_POWER_HIGH_BIT) |
> +		BIT(ADIS16201_DIAG_STAT_POWER_LOW_BIT),
> +};
> +
> +static int adis16201_probe(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev;
> +	struct adis *st;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
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
> +
> +	ret = adis_setup_buffer_and_trigger(st, indio_dev, NULL);
> +	if (ret)
> +		return ret;
> +
> +	ret = adis_initial_startup(st);
> +	if (ret)
> +		goto error_cleanup_buffer_trigger;
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret < 0)
> +		goto error_cleanup_buffer_trigger;
> +
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
<snip>
