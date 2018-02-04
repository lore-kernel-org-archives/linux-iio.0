Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751546AbeBDQb2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 4 Feb 2018 11:31:28 -0500
Date: Sun, 4 Feb 2018 16:31:24 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org, <daniel.baluta@gmail.com>,
        <amsfield22@gmail.com>, lars@metafoo.de
Subject: [TODO] potentail staging cleanup accel:adis16203 inclinonmeter.
Message-ID: <20180204163124.67234ae5@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Here's a second driver reviewed...

Vast majority of comments are the same as for the adis16201 driver.

The only real addition here is the nasty second inclinometer channel.
It's just using a different range, so if you take the first and after
it is greater than 180 degrees you instead make it negative, then
you have the second channel.

My gut instinct is to drop reporting that channel at all.
It doesn't add anything and it makes the userspace view of this
hardware more complex.

Please read the 16201 review as well and the same suggestions apply
on 'claiming' the driver if you want to clean it up.

Either way, both drivers should be straight forward to get ready
for a staging graduation.

There are lots more features we 'could' support but absense of
full support is not a reason to keep them in staging.

Thanks,

Jonathan


> /*
>  * ADIS16203 Programmable 360 Degrees Inclinometer
>  *
>  * Copyright 2010 Analog Devices Inc.
>  *
>  * Licensed under the GPL-2 or later.

Might as well convert to SPDX format whilst we are working on the driver.

>  */
> 
> #include <linux/delay.h>
> #include <linux/device.h>
> 
> #include <linux/iio/buffer.h>
> #include <linux/iio/iio.h>
> #include <linux/iio/imu/adis.h>
> #include <linux/iio/sysfs.h>
> 
> #include <linux/kernel.h>
> #include <linux/module.h>
> #include <linux/mutex.h>
> #include <linux/slab.h>
> #include <linux/spi/spi.h>
> #include <linux/sysfs.h>

Put these into conventional header ordering.
Alphabetical with iio headers grouped at the end.

> 
> #define ADIS16203_STARTUP_DELAY 220 /* ms */

Include _MS in the naming and drop the comment.

> 
> /* Flash memory write count */
There are a lot of fairly 'obvious' comments here.

Add _REG naming to keep things consistent.
(see adis16201 review)

> #define ADIS16203_FLASH_CNT      0x00
> 
> /* Output, power supply */
> #define ADIS16203_SUPPLY_OUT     0x02
> 
> /* Output, auxiliary ADC input */
> #define ADIS16203_AUX_ADC        0x08
> 
> /* Output, temperature */
> #define ADIS16203_TEMP_OUT       0x0A
> 
> /* Output, x-axis inclination */
> #define ADIS16203_XINCL_OUT      0x0C
> 
> /* Output, y-axis inclination */
> #define ADIS16203_YINCL_OUT      0x0E
> 
> /* Incline null calibration */
> #define ADIS16203_INCL_NULL      0x18
> 
> /* Alarm 1 amplitude threshold */
> #define ADIS16203_ALM_MAG1       0x20
> 
> /* Alarm 2 amplitude threshold */
> #define ADIS16203_ALM_MAG2       0x22
> 
> /* Alarm 1, sample period */
> #define ADIS16203_ALM_SMPL1      0x24
> 
> /* Alarm 2, sample period */
> #define ADIS16203_ALM_SMPL2      0x26
> 
> /* Alarm control */
> #define ADIS16203_ALM_CTRL       0x28
> 
> /* Auxiliary DAC data */
> #define ADIS16203_AUX_DAC        0x30
> 
> /* General-purpose digital input/output control */
> #define ADIS16203_GPIO_CTRL      0x32
> 
> /* Miscellaneous control */
> #define ADIS16203_MSC_CTRL       0x34
> 
> /* Internal sample period (rate) control */
> #define ADIS16203_SMPL_PRD       0x36
> 
> /* Operation, filter configuration */
> #define ADIS16203_AVG_CNT        0x38
> 
> /* Operation, sleep mode control */
> #define ADIS16203_SLP_CNT        0x3A
> 
> /* Diagnostics, system status register */
> #define ADIS16203_DIAG_STAT      0x3C
> 
> /* Operation, system command register */
> #define ADIS16203_GLOB_CMD       0x3E
> 
> /* MSC_CTRL */
> 
> /* Self-test at power-on: 1 = disabled, 0 = enabled */
> #define ADIS16203_MSC_CTRL_PWRUP_SELF_TEST      BIT(10)
> 
> /* Reverses rotation of both inclination outputs */
> #define ADIS16203_MSC_CTRL_REVERSE_ROT_EN       BIT(9)
> 
> /* Self-test enable */
> #define ADIS16203_MSC_CTRL_SELF_TEST_EN         BIT(8)
> 
> /* Data-ready enable: 1 = enabled, 0 = disabled */
> #define ADIS16203_MSC_CTRL_DATA_RDY_EN          BIT(2)
> 
> /* Data-ready polarity: 1 = active high, 0 = active low */
> #define ADIS16203_MSC_CTRL_ACTIVE_HIGH          BIT(1)
> 
> /* Data-ready line selection: 1 = DIO1, 0 = DIO0 */
> #define ADIS16203_MSC_CTRL_DATA_RDY_DIO1        BIT(0)
> 
> /* DIAG_STAT */
> 
> /* Alarm 2 status: 1 = alarm active, 0 = alarm inactive */
> #define ADIS16203_DIAG_STAT_ALARM2        BIT(9)
> 
> /* Alarm 1 status: 1 = alarm active, 0 = alarm inactive */
> #define ADIS16203_DIAG_STAT_ALARM1        BIT(8)
> 
> /* Self-test diagnostic error flag */
> #define ADIS16203_DIAG_STAT_SELFTEST_FAIL_BIT 5
> 
> /* SPI communications failure */
> #define ADIS16203_DIAG_STAT_SPI_FAIL_BIT      3
> 
> /* Flash update failure */
> #define ADIS16203_DIAG_STAT_FLASH_UPT_BIT     2
> 
> /* Power supply above 3.625 V */
> #define ADIS16203_DIAG_STAT_POWER_HIGH_BIT    1
> 
> /* Power supply below 3.15 V */
> #define ADIS16203_DIAG_STAT_POWER_LOW_BIT     0
> 
> /* GLOB_CMD */

See the adis16201 review for suggestions on how
to clean this up and drop unnecessary comemnts.

> 
> #define ADIS16203_GLOB_CMD_SW_RESET     BIT(7)
> #define ADIS16203_GLOB_CMD_CLEAR_STAT   BIT(4)
> #define ADIS16203_GLOB_CMD_FACTORY_CAL  BIT(1)
> 
> #define ADIS16203_ERROR_ACTIVE          BIT(14)
> 
> enum adis16203_scan {
> 	 ADIS16203_SCAN_INCLI_X,
> 	 ADIS16203_SCAN_INCLI_Y,
> 	 ADIS16203_SCAN_SUPPLY,
> 	 ADIS16203_SCAN_AUX_ADC,
> 	 ADIS16203_SCAN_TEMP,
> };
> 
> #define DRIVER_NAME		"adis16203"
> 
> static const u8 adis16203_addresses[] = {
> 	[ADIS16203_SCAN_INCLI_X] = ADIS16203_INCL_NULL,
> };
> 
> static int adis16203_write_raw(struct iio_dev *indio_dev,
> 			       struct iio_chan_spec const *chan,
> 			       int val,
> 			       int val2,
> 			       long mask)
> {
> 	struct adis *st = iio_priv(indio_dev);
> 	/* currently only one writable parameter which keeps this simple */
> 	u8 addr = adis16203_addresses[chan->scan_index];

However it needs error checking as nothing stops us trying to write
to other parameters from userspace.  So check it's what we
expect.

Also that mask should be generated with GENMASK to make it 
more obvious what it covers.


> 
> 	return adis_write_reg_16(st, addr, val & 0x3FFF);
> }
> 
> static int adis16203_read_raw(struct iio_dev *indio_dev,
> 			      struct iio_chan_spec const *chan,
> 			      int *val, int *val2,
> 			      long mask)
> {
> 	struct adis *st = iio_priv(indio_dev);
> 	int ret;
> 	int bits;
> 	u8 addr;
> 	s16 val16;
> 
> 	switch (mask) {
> 	case IIO_CHAN_INFO_RAW:
> 		return adis_single_conversion(indio_dev, chan,
> 				ADIS16203_ERROR_ACTIVE, val);
> 	case IIO_CHAN_INFO_SCALE:
> 		switch (chan->type) {
> 		case IIO_VOLTAGE:
> 			if (chan->channel == 0) {
> 				*val = 1;
> 				*val2 = 220000; /* 1.22 mV */
> 			} else {
> 				*val = 0;
> 				*val2 = 610000; /* 0.61 mV */
> 			}
> 			return IIO_VAL_INT_PLUS_MICRO;
> 		case IIO_TEMP:
> 			*val = -470; /* -0.47 C */
> 			*val2 = 0;
> 			return IIO_VAL_INT_PLUS_MICRO;
> 		case IIO_INCLI:
> 			*val = 0;
> 			*val2 = 25000; /* 0.025 degree */
> 			return IIO_VAL_INT_PLUS_MICRO;
> 		default:
> 			return -EINVAL;
> 		}
> 	case IIO_CHAN_INFO_OFFSET:
> 		*val = 25000 / -470 - 1278; /* 25 C = 1278 */
> 		return IIO_VAL_INT;
> 	case IIO_CHAN_INFO_CALIBBIAS:
> 		bits = 14;
> 		addr = adis16203_addresses[chan->scan_index];
> 		ret = adis_read_reg_16(st, addr, &val16);
> 		if (ret)
> 			return ret;
> 		val16 &= (1 << bits) - 1;

Given sign extension, the masking shouldn't make any difference.

> 		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);

Simple sign extension.  Just use the standard functions.
Also go directly to 32bits and put it in val.

> 		*val = val16;
> 		return IIO_VAL_INT;
> 	default:
> 		return -EINVAL;
> 	}
> }
> 
> static const struct iio_chan_spec adis16203_channels[] = {
> 	ADIS_SUPPLY_CHAN(ADIS16203_SUPPLY_OUT, ADIS16203_SCAN_SUPPLY, 0, 12),
> 	ADIS_AUX_ADC_CHAN(ADIS16203_AUX_ADC, ADIS16203_SCAN_AUX_ADC, 0, 12),
> 	ADIS_INCLI_CHAN(X, ADIS16203_XINCL_OUT, ADIS16203_SCAN_INCLI_X,
> 			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
> 	/* Fixme: Not what it appears to be - see data sheet */

This is just an offset version of the previous channel. I would drop
it as it doesn't add anything significant that userspace can't trivially
compute.

> 	ADIS_INCLI_CHAN(Y, ADIS16203_YINCL_OUT, ADIS16203_SCAN_INCLI_Y,
> 			0, 0, 14),
> 	ADIS_TEMP_CHAN(ADIS16203_TEMP_OUT, ADIS16203_SCAN_TEMP, 0, 12),
> 	IIO_CHAN_SOFT_TIMESTAMP(5),
> };
> 
> static const struct iio_info adis16203_info = {
> 	.read_raw = adis16203_read_raw,
> 	.write_raw = adis16203_write_raw,
> 	.update_scan_mode = adis_update_scan_mode,
> };
> 
> static const char * const adis16203_status_error_msgs[] = {
> 	[ADIS16203_DIAG_STAT_SELFTEST_FAIL_BIT] = "Self test failure",
> 	[ADIS16203_DIAG_STAT_SPI_FAIL_BIT] = "SPI failure",
> 	[ADIS16203_DIAG_STAT_FLASH_UPT_BIT] = "Flash update failed",
> 	[ADIS16203_DIAG_STAT_POWER_HIGH_BIT] = "Power supply above 3.625V",
> 	[ADIS16203_DIAG_STAT_POWER_LOW_BIT] = "Power supply below 3.15V",
> };
> 
> static const struct adis_data adis16203_data = {
> 	.read_delay = 20,
> 	.msc_ctrl_reg = ADIS16203_MSC_CTRL,
> 	.glob_cmd_reg = ADIS16203_GLOB_CMD,
> 	.diag_stat_reg = ADIS16203_DIAG_STAT,
> 
> 	.self_test_mask = ADIS16203_MSC_CTRL_SELF_TEST_EN,
> 	.self_test_no_autoclear = true,
> 	.startup_delay = ADIS16203_STARTUP_DELAY,
> 
> 	.status_error_msgs = adis16203_status_error_msgs,
> 	.status_error_mask = BIT(ADIS16203_DIAG_STAT_SELFTEST_FAIL_BIT) |
> 		BIT(ADIS16203_DIAG_STAT_SPI_FAIL_BIT) |
> 		BIT(ADIS16203_DIAG_STAT_FLASH_UPT_BIT) |
> 		BIT(ADIS16203_DIAG_STAT_POWER_HIGH_BIT) |
> 		BIT(ADIS16203_DIAG_STAT_POWER_LOW_BIT),
> };
> 
> static int adis16203_probe(struct spi_device *spi)
> {
> 	int ret;
> 	struct iio_dev *indio_dev;
> 	struct adis *st;
> 
> 	/* setup the industrialio driver allocated elements */

Comment only tells us the obvious...

> 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> 	if (!indio_dev)
> 		return -ENOMEM;
> 	st = iio_priv(indio_dev);
> 	/* this is only used for removal purposes */

As before, doesn't add much as comments  go.

> 	spi_set_drvdata(spi, indio_dev);
> 
> 	indio_dev->name = spi->dev.driver->name;
> 	indio_dev->dev.parent = &spi->dev;
> 	indio_dev->channels = adis16203_channels;
> 	indio_dev->num_channels = ARRAY_SIZE(adis16203_channels);
> 	indio_dev->info = &adis16203_info;
> 	indio_dev->modes = INDIO_DIRECT_MODE;
> 
> 	ret = adis_init(st, indio_dev, spi, &adis16203_data);
> 	if (ret)
> 		return ret;
> 
> 	ret = adis_setup_buffer_and_trigger(st, indio_dev, NULL);
> 	if (ret)
> 		return ret;
> 
> 	/* Get the device into a sane initial state */
> 	ret = adis_initial_startup(st);
> 	if (ret)
> 		goto error_cleanup_buffer_trigger;
> 
> 	ret = iio_device_register(indio_dev);
> 	if (ret)
> 		goto error_cleanup_buffer_trigger;
> 
> 	return 0;
> 
> error_cleanup_buffer_trigger:
> 	adis_cleanup_buffer_and_trigger(st, indio_dev);
> 	return ret;
> }
> 
> static int adis16203_remove(struct spi_device *spi)
> {
> 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> 	struct adis *st = iio_priv(indio_dev);
> 
> 	iio_device_unregister(indio_dev);
> 	adis_cleanup_buffer_and_trigger(st, indio_dev);
> 
> 	return 0;
> }
> 
> static struct spi_driver adis16203_driver = {
> 	.driver = {
> 		.name = "adis16203",
> 	},
> 	.probe = adis16203_probe,
> 	.remove = adis16203_remove,
> };
> module_spi_driver(adis16203_driver);

Device tree binding etc should probably be added + match tables so that
this is useable on modern boards and probes automatically etc.

> 
> MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
> MODULE_DESCRIPTION("Analog Devices ADIS16203 Programmable 360 Degrees Inclinometer");
> MODULE_LICENSE("GPL v2");
> MODULE_ALIAS("spi:adis16203");
