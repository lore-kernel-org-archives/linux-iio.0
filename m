Return-Path: <pmeerw@pmeerw.net>
Date: Mon, 7 Mar 2016 15:24:38 +0100 (CET)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Lars-Peter Clausen <lars@metafoo.de>
cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
    linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] staging:iio:adis16220: Remove adis16204 driver
In-Reply-To: <1457360552-12314-2-git-send-email-lars@metafoo.de>
Message-ID: <alpine.DEB.2.02.1603071524000.17976@pmeerw.net>
References: <1457360552-12314-1-git-send-email-lars@metafoo.de> <1457360552-12314-2-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>


the mail subject should say 'Remove adis16220 ...'

> The ADIS16220 part has been obsoleted, which makes it hard to get the
> hardware to even test the driver. Considering this there is no expectation
> that the driver will be cleaned up and be able to move out of staging, so
> remove the driver.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  drivers/staging/iio/accel/Kconfig          |  11 -
>  drivers/staging/iio/accel/Makefile         |   3 -
>  drivers/staging/iio/accel/adis16220.h      | 140 --------
>  drivers/staging/iio/accel/adis16220_core.c | 494 -----------------------------
>  4 files changed, 648 deletions(-)
>  delete mode 100644 drivers/staging/iio/accel/adis16220.h
>  delete mode 100644 drivers/staging/iio/accel/adis16220_core.c
> 
> diff --git a/drivers/staging/iio/accel/Kconfig b/drivers/staging/iio/accel/Kconfig
> index 5bc9803..f066aa3 100644
> --- a/drivers/staging/iio/accel/Kconfig
> +++ b/drivers/staging/iio/accel/Kconfig
> @@ -39,17 +39,6 @@ config ADIS16209
>  	  To compile this driver as a module, say M here: the module will be
>  	  called adis16209.
>  
> -config ADIS16220
> -	tristate "Analog Devices ADIS16220 Programmable Digital Vibration Sensor"
> -	depends on SPI
> -	select IIO_ADIS_LIB
> -	help
> -	  Say Y here to build support for Analog Devices adis16220 programmable
> -	  digital vibration sensor.
> -
> -	  To compile this driver as a module, say M here: the module will be
> -	  called adis16220.
> -
>  config ADIS16240
>  	tristate "Analog Devices ADIS16240 Programmable Impact Sensor and Recorder"
>  	depends on SPI
> diff --git a/drivers/staging/iio/accel/Makefile b/drivers/staging/iio/accel/Makefile
> index 8ad9732..415329c 100644
> --- a/drivers/staging/iio/accel/Makefile
> +++ b/drivers/staging/iio/accel/Makefile
> @@ -11,9 +11,6 @@ obj-$(CONFIG_ADIS16203) += adis16203.o
>  adis16209-y             := adis16209_core.o
>  obj-$(CONFIG_ADIS16209) += adis16209.o
>  
> -adis16220-y             := adis16220_core.o
> -obj-$(CONFIG_ADIS16220) += adis16220.o
> -
>  adis16240-y             := adis16240_core.o
>  obj-$(CONFIG_ADIS16240) += adis16240.o
>  
> diff --git a/drivers/staging/iio/accel/adis16220.h b/drivers/staging/iio/accel/adis16220.h
> deleted file mode 100644
> index eab8633..0000000
> --- a/drivers/staging/iio/accel/adis16220.h
> +++ /dev/null
> @@ -1,140 +0,0 @@
> -#ifndef SPI_ADIS16220_H_
> -#define SPI_ADIS16220_H_
> -
> -#include <linux/iio/imu/adis.h>
> -
> -#define ADIS16220_STARTUP_DELAY	220 /* ms */
> -
> -/* Flash memory write count */
> -#define ADIS16220_FLASH_CNT     0x00
> -/* Control, acceleration offset adjustment control */
> -#define ADIS16220_ACCL_NULL     0x02
> -/* Control, AIN1 offset adjustment control */
> -#define ADIS16220_AIN1_NULL     0x04
> -/* Control, AIN2 offset adjustment control */
> -#define ADIS16220_AIN2_NULL     0x06
> -/* Output, power supply during capture */
> -#define ADIS16220_CAPT_SUPPLY   0x0A
> -/* Output, temperature during capture */
> -#define ADIS16220_CAPT_TEMP     0x0C
> -/* Output, peak acceleration during capture */
> -#define ADIS16220_CAPT_PEAKA    0x0E
> -/* Output, peak AIN1 level during capture */
> -#define ADIS16220_CAPT_PEAK1    0x10
> -/* Output, peak AIN2 level during capture */
> -#define ADIS16220_CAPT_PEAK2    0x12
> -/* Output, capture buffer for acceleration */
> -#define ADIS16220_CAPT_BUFA     0x14
> -/* Output, capture buffer for AIN1 */
> -#define ADIS16220_CAPT_BUF1     0x16
> -/* Output, capture buffer for AIN2 */
> -#define ADIS16220_CAPT_BUF2     0x18
> -/* Control, capture buffer address pointer */
> -#define ADIS16220_CAPT_PNTR     0x1A
> -/* Control, capture control register */
> -#define ADIS16220_CAPT_CTRL     0x1C
> -/* Control, capture period (automatic mode) */
> -#define ADIS16220_CAPT_PRD      0x1E
> -/* Control, Alarm A, acceleration peak threshold */
> -#define ADIS16220_ALM_MAGA      0x20
> -/* Control, Alarm 1, AIN1 peak threshold */
> -#define ADIS16220_ALM_MAG1      0x22
> -/* Control, Alarm 2, AIN2 peak threshold */
> -#define ADIS16220_ALM_MAG2      0x24
> -/* Control, Alarm S, peak threshold */
> -#define ADIS16220_ALM_MAGS      0x26
> -/* Control, alarm configuration register */
> -#define ADIS16220_ALM_CTRL      0x28
> -/* Control, general I/O configuration */
> -#define ADIS16220_GPIO_CTRL     0x32
> -/* Control, self-test control, AIN configuration */
> -#define ADIS16220_MSC_CTRL      0x34
> -/* Control, digital I/O configuration */
> -#define ADIS16220_DIO_CTRL      0x36
> -/* Control, filter configuration */
> -#define ADIS16220_AVG_CNT       0x38
> -/* Status, system status */
> -#define ADIS16220_DIAG_STAT     0x3C
> -/* Control, system commands */
> -#define ADIS16220_GLOB_CMD      0x3E
> -/* Status, self-test response */
> -#define ADIS16220_ST_DELTA      0x40
> -/* Lot Identification Code 1 */
> -#define ADIS16220_LOT_ID1       0x52
> -/* Lot Identification Code 2 */
> -#define ADIS16220_LOT_ID2       0x54
> -/* Product identifier; convert to decimal = 16220 */
> -#define ADIS16220_PROD_ID       0x56
> -/* Serial number */
> -#define ADIS16220_SERIAL_NUM    0x58
> -
> -#define ADIS16220_CAPTURE_SIZE  2048
> -
> -/* MSC_CTRL */
> -#define ADIS16220_MSC_CTRL_SELF_TEST_EN	        BIT(8)
> -#define ADIS16220_MSC_CTRL_POWER_SUP_COM_AIN1	BIT(1)
> -#define ADIS16220_MSC_CTRL_POWER_SUP_COM_AIN2	BIT(0)
> -
> -/* DIO_CTRL */
> -#define ADIS16220_MSC_CTRL_DIO2_BUSY_IND     (BIT(5) | BIT(4))
> -#define ADIS16220_MSC_CTRL_DIO1_BUSY_IND     (BIT(3) | BIT(2))
> -#define ADIS16220_MSC_CTRL_DIO2_ACT_HIGH     BIT(1)
> -#define ADIS16220_MSC_CTRL_DIO1_ACT_HIGH     BIT(0)
> -
> -/* DIAG_STAT */
> -/* AIN2 sample > ALM_MAG2 */
> -#define ADIS16220_DIAG_STAT_ALM_MAG2    BIT(14)
> -/* AIN1 sample > ALM_MAG1 */
> -#define ADIS16220_DIAG_STAT_ALM_MAG1    BIT(13)
> -/* Acceleration sample > ALM_MAGA */
> -#define ADIS16220_DIAG_STAT_ALM_MAGA    BIT(12)
> -/* Error condition programmed into ALM_MAGS[11:0] and ALM_CTRL[5:4] is true */
> -#define ADIS16220_DIAG_STAT_ALM_MAGS    BIT(11)
> -/* |Peak value in AIN2 data capture| > ALM_MAG2 */
> -#define ADIS16220_DIAG_STAT_PEAK_AIN2   BIT(10)
> -/* |Peak value in AIN1 data capture| > ALM_MAG1 */
> -#define ADIS16220_DIAG_STAT_PEAK_AIN1   BIT(9)
> -/* |Peak value in acceleration data capture| > ALM_MAGA */
> -#define ADIS16220_DIAG_STAT_PEAK_ACCEL  BIT(8)
> -/* Data ready, capture complete */
> -#define ADIS16220_DIAG_STAT_DATA_RDY    BIT(7)
> -#define ADIS16220_DIAG_STAT_FLASH_CHK	BIT(6)
> -#define ADIS16220_DIAG_STAT_SELF_TEST	BIT(5)
> -/* Capture period violation/interruption */
> -#define ADIS16220_DIAG_STAT_VIOLATION_BIT	4
> -/* SPI communications failure */
> -#define ADIS16220_DIAG_STAT_SPI_FAIL_BIT	3
> -/* Flash update failure */
> -#define ADIS16220_DIAG_STAT_FLASH_UPT_BIT	2
> -/* Power supply above 3.625 V */
> -#define ADIS16220_DIAG_STAT_POWER_HIGH_BIT	1
> -/* Power supply below 3.15 V */
> -#define ADIS16220_DIAG_STAT_POWER_LOW_BIT	0
> -
> -/* GLOB_CMD */
> -#define ADIS16220_GLOB_CMD_SW_RESET	BIT(7)
> -#define ADIS16220_GLOB_CMD_SELF_TEST	BIT(2)
> -#define ADIS16220_GLOB_CMD_PWR_DOWN	BIT(1)
> -
> -#define ADIS16220_MAX_TX 2048
> -#define ADIS16220_MAX_RX 2048
> -
> -#define ADIS16220_SPI_BURST	(u32)(1000 * 1000)
> -#define ADIS16220_SPI_FAST	(u32)(2000 * 1000)
> -
> -/**
> - * struct adis16220_state - device instance specific data
> - * @adis:		adis device
> - * @tx:			transmit buffer
> - * @rx:			receive buffer
> - * @buf_lock:		mutex to protect tx and rx
> - **/
> -struct adis16220_state {
> -	struct adis adis;
> -
> -	struct mutex		buf_lock;
> -	u8			tx[ADIS16220_MAX_TX] ____cacheline_aligned;
> -	u8			rx[ADIS16220_MAX_RX];
> -};
> -
> -#endif /* SPI_ADIS16220_H_ */
> diff --git a/drivers/staging/iio/accel/adis16220_core.c b/drivers/staging/iio/accel/adis16220_core.c
> deleted file mode 100644
> index d016521..0000000
> --- a/drivers/staging/iio/accel/adis16220_core.c
> +++ /dev/null
> @@ -1,494 +0,0 @@
> -/*
> - * ADIS16220 Programmable Digital Vibration Sensor driver
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
> -
> -#include "adis16220.h"
> -
> -static ssize_t adis16220_read_16bit(struct device *dev,
> -				    struct device_attribute *attr,
> -				    char *buf)
> -{
> -	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct adis16220_state *st = iio_priv(indio_dev);
> -	ssize_t ret;
> -	u16 val;
> -
> -	/* Take the iio_dev status lock */
> -	mutex_lock(&indio_dev->mlock);
> -	ret = adis_read_reg_16(&st->adis, this_attr->address, &val);
> -	mutex_unlock(&indio_dev->mlock);
> -	if (ret)
> -		return ret;
> -	return sprintf(buf, "%u\n", val);
> -}
> -
> -static ssize_t adis16220_write_16bit(struct device *dev,
> -				     struct device_attribute *attr,
> -				     const char *buf,
> -				     size_t len)
> -{
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> -	struct adis16220_state *st = iio_priv(indio_dev);
> -	int ret;
> -	u16 val;
> -
> -	ret = kstrtou16(buf, 10, &val);
> -	if (ret)
> -		goto error_ret;
> -	ret = adis_write_reg_16(&st->adis, this_attr->address, val);
> -
> -error_ret:
> -	return ret ? ret : len;
> -}
> -
> -static int adis16220_capture(struct iio_dev *indio_dev)
> -{
> -	struct adis16220_state *st = iio_priv(indio_dev);
> -	int ret;
> -
> -	 /* initiates a manual data capture */
> -	ret = adis_write_reg_16(&st->adis, ADIS16220_GLOB_CMD, 0xBF08);
> -	if (ret)
> -		dev_err(&indio_dev->dev, "problem beginning capture");
> -
> -	usleep_range(10000, 11000); /* delay for capture to finish */
> -
> -	return ret;
> -}
> -
> -static ssize_t adis16220_write_capture(struct device *dev,
> -				       struct device_attribute *attr,
> -				       const char *buf, size_t len)
> -{
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	bool val;
> -	int ret;
> -
> -	ret = strtobool(buf, &val);
> -	if (ret)
> -		return ret;
> -	if (!val)
> -		return -EINVAL;
> -	ret = adis16220_capture(indio_dev);
> -	if (ret)
> -		return ret;
> -
> -	return len;
> -}
> -
> -static ssize_t adis16220_capture_buffer_read(struct iio_dev *indio_dev,
> -					     char *buf,
> -					     loff_t off,
> -					     size_t count,
> -					     int addr)
> -{
> -	struct adis16220_state *st = iio_priv(indio_dev);
> -	struct spi_transfer xfers[] = {
> -		{
> -			.tx_buf = st->tx,
> -			.bits_per_word = 8,
> -			.len = 2,
> -			.cs_change = 1,
> -			.delay_usecs = 25,
> -		}, {
> -			.tx_buf = st->tx,
> -			.rx_buf = st->rx,
> -			.bits_per_word = 8,
> -			.cs_change = 1,
> -			.delay_usecs = 25,
> -		},
> -	};
> -	int ret;
> -	int i;
> -
> -	if (unlikely(!count))
> -		return count;
> -
> -	if ((off >= ADIS16220_CAPTURE_SIZE) || (count & 1) || (off & 1))
> -		return -EINVAL;
> -
> -	if (off + count > ADIS16220_CAPTURE_SIZE)
> -		count = ADIS16220_CAPTURE_SIZE - off;
> -
> -	/* write the begin position of capture buffer */
> -	ret = adis_write_reg_16(&st->adis,
> -				ADIS16220_CAPT_PNTR,
> -				off > 1);
> -	if (ret)
> -		return -EIO;
> -
> -	/* read count/2 values from capture buffer */
> -	mutex_lock(&st->buf_lock);
> -
> -	for (i = 0; i < count; i += 2) {
> -		st->tx[i] = ADIS_READ_REG(addr);
> -		st->tx[i + 1] = 0;
> -	}
> -	xfers[1].len = count;
> -
> -	ret = spi_sync_transfer(st->adis.spi, xfers, ARRAY_SIZE(xfers));
> -	if (ret) {
> -		mutex_unlock(&st->buf_lock);
> -		return -EIO;
> -	}
> -
> -	memcpy(buf, st->rx, count);
> -
> -	mutex_unlock(&st->buf_lock);
> -	return count;
> -}
> -
> -static ssize_t adis16220_accel_bin_read(struct file *filp, struct kobject *kobj,
> -					struct bin_attribute *attr,
> -					char *buf,
> -					loff_t off,
> -					size_t count)
> -{
> -	struct iio_dev *indio_dev = dev_to_iio_dev(kobj_to_dev(kobj));
> -
> -	return adis16220_capture_buffer_read(indio_dev, buf,
> -					off, count,
> -					ADIS16220_CAPT_BUFA);
> -}
> -
> -static struct bin_attribute accel_bin = {
> -	.attr = {
> -		.name = "accel_bin",
> -		.mode = S_IRUGO,
> -	},
> -	.read = adis16220_accel_bin_read,
> -	.size = ADIS16220_CAPTURE_SIZE,
> -};
> -
> -static ssize_t adis16220_adc1_bin_read(struct file *filp, struct kobject *kobj,
> -				       struct bin_attribute *attr,
> -				       char *buf, loff_t off,
> -				       size_t count)
> -{
> -	struct iio_dev *indio_dev = dev_to_iio_dev(kobj_to_dev(kobj));
> -
> -	return adis16220_capture_buffer_read(indio_dev, buf,
> -					off, count,
> -					ADIS16220_CAPT_BUF1);
> -}
> -
> -static struct bin_attribute adc1_bin = {
> -	.attr = {
> -		.name = "in0_bin",
> -		.mode = S_IRUGO,
> -	},
> -	.read =  adis16220_adc1_bin_read,
> -	.size = ADIS16220_CAPTURE_SIZE,
> -};
> -
> -static ssize_t adis16220_adc2_bin_read(struct file *filp, struct kobject *kobj,
> -				       struct bin_attribute *attr,
> -				       char *buf, loff_t off,
> -				       size_t count)
> -{
> -	struct iio_dev *indio_dev = dev_to_iio_dev(kobj_to_dev(kobj));
> -
> -	return adis16220_capture_buffer_read(indio_dev, buf,
> -					off, count,
> -					ADIS16220_CAPT_BUF2);
> -}
> -
> -static struct bin_attribute adc2_bin = {
> -	.attr = {
> -		.name = "in1_bin",
> -		.mode = S_IRUGO,
> -	},
> -	.read =  adis16220_adc2_bin_read,
> -	.size = ADIS16220_CAPTURE_SIZE,
> -};
> -
> -#define IIO_DEV_ATTR_CAPTURE(_store)				\
> -	IIO_DEVICE_ATTR(capture, S_IWUSR, NULL, _store, 0)
> -
> -static IIO_DEV_ATTR_CAPTURE(adis16220_write_capture);
> -
> -#define IIO_DEV_ATTR_CAPTURE_COUNT(_mode, _show, _store, _addr)		\
> -	IIO_DEVICE_ATTR(capture_count, _mode, _show, _store, _addr)
> -
> -static IIO_DEV_ATTR_CAPTURE_COUNT(S_IWUSR | S_IRUGO,
> -		adis16220_read_16bit,
> -		adis16220_write_16bit,
> -		ADIS16220_CAPT_PNTR);
> -
> -enum adis16220_channel {
> -	in_supply, in_1, in_2, accel, temp
> -};
> -
> -struct adis16220_address_spec {
> -	u8 addr;
> -	u8 bits;
> -	bool sign;
> -};
> -
> -/* Address / bits / signed */
> -static const struct adis16220_address_spec adis16220_addresses[][3] = {
> -	[in_supply] =	{ { ADIS16220_CAPT_SUPPLY,	12, 0 }, },
> -	[in_1] =	{ { ADIS16220_CAPT_BUF1,	16, 1 },
> -			  { ADIS16220_AIN1_NULL,	16, 1 },
> -			  { ADIS16220_CAPT_PEAK1,	16, 1 }, },
> -	[in_2] =	{ { ADIS16220_CAPT_BUF2,	16, 1 },
> -			  { ADIS16220_AIN2_NULL,	16, 1 },
> -			  { ADIS16220_CAPT_PEAK2,	16, 1 }, },
> -	[accel] =	{ { ADIS16220_CAPT_BUFA,	16, 1 },
> -			  { ADIS16220_ACCL_NULL,	16, 1 },
> -			  { ADIS16220_CAPT_PEAKA,	16, 1 }, },
> -	[temp] =	{ { ADIS16220_CAPT_TEMP,	12, 0 }, }
> -};
> -
> -static int adis16220_read_raw(struct iio_dev *indio_dev,
> -			      struct iio_chan_spec const *chan,
> -			      int *val, int *val2,
> -			      long mask)
> -{
> -	struct adis16220_state *st = iio_priv(indio_dev);
> -	const struct adis16220_address_spec *addr;
> -	int ret = -EINVAL;
> -	int addrind = 0;
> -	u16 uval;
> -	s16 sval;
> -	u8 bits;
> -
> -	switch (mask) {
> -	case IIO_CHAN_INFO_RAW:
> -		addrind = 0;
> -		break;
> -	case IIO_CHAN_INFO_OFFSET:
> -		if (chan->type == IIO_TEMP) {
> -			*val = 25000 / -470 - 1278; /* 25 C = 1278 */
> -			return IIO_VAL_INT;
> -		}
> -		addrind = 1;
> -		break;
> -	case IIO_CHAN_INFO_PEAK:
> -		addrind = 2;
> -		break;
> -	case IIO_CHAN_INFO_SCALE:
> -		switch (chan->type) {
> -		case IIO_TEMP:
> -			*val = -470; /* -0.47 C */
> -			*val2 = 0;
> -			return IIO_VAL_INT_PLUS_MICRO;
> -		case IIO_ACCEL:
> -			*val2 = IIO_G_TO_M_S_2(19073); /* 19.073 g */
> -			return IIO_VAL_INT_PLUS_MICRO;
> -		case IIO_VOLTAGE:
> -			if (chan->channel == 0) {
> -				*val = 1;
> -				*val2 = 220700; /* 1.2207 mV */
> -			} else {
> -				/* Should really be dependent on VDD */
> -				*val2 = 305180; /* 305.18 uV */
> -			}
> -			return IIO_VAL_INT_PLUS_MICRO;
> -		default:
> -			return -EINVAL;
> -		}
> -	default:
> -		return -EINVAL;
> -	}
> -	addr = &adis16220_addresses[chan->address][addrind];
> -	if (addr->sign) {
> -		ret = adis_read_reg_16(&st->adis, addr->addr, &sval);
> -		if (ret)
> -			return ret;
> -		bits = addr->bits;
> -		sval &= (1 << bits) - 1;
> -		sval = (s16)(sval << (16 - bits)) >> (16 - bits);
> -		*val = sval;
> -		return IIO_VAL_INT;
> -	}
> -	ret = adis_read_reg_16(&st->adis, addr->addr, &uval);
> -	if (ret)
> -		return ret;
> -	bits = addr->bits;
> -	uval &= (1 << bits) - 1;
> -	*val = uval;
> -	return IIO_VAL_INT;
> -}
> -
> -static const struct iio_chan_spec adis16220_channels[] = {
> -	{
> -		.type = IIO_VOLTAGE,
> -		.indexed = 1,
> -		.channel = 0,
> -		.extend_name = "supply",
> -		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> -			BIT(IIO_CHAN_INFO_SCALE),
> -		.address = in_supply,
> -	}, {
> -		.type = IIO_ACCEL,
> -		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> -			BIT(IIO_CHAN_INFO_OFFSET) |
> -			BIT(IIO_CHAN_INFO_SCALE) |
> -			BIT(IIO_CHAN_INFO_PEAK),
> -		.address = accel,
> -	}, {
> -		.type = IIO_TEMP,
> -		.indexed = 1,
> -		.channel = 0,
> -		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> -			BIT(IIO_CHAN_INFO_OFFSET) |
> -			BIT(IIO_CHAN_INFO_SCALE),
> -		.address = temp,
> -	}, {
> -		.type = IIO_VOLTAGE,
> -		.indexed = 1,
> -		.channel = 1,
> -		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> -			BIT(IIO_CHAN_INFO_OFFSET) |
> -			BIT(IIO_CHAN_INFO_SCALE),
> -		.address = in_1,
> -	}, {
> -		.type = IIO_VOLTAGE,
> -		.indexed = 1,
> -		.channel = 2,
> -		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> -		.address = in_2,
> -	}
> -};
> -
> -static struct attribute *adis16220_attributes[] = {
> -	&iio_dev_attr_capture.dev_attr.attr,
> -	&iio_dev_attr_capture_count.dev_attr.attr,
> -	NULL
> -};
> -
> -static const struct attribute_group adis16220_attribute_group = {
> -	.attrs = adis16220_attributes,
> -};
> -
> -static const struct iio_info adis16220_info = {
> -	.attrs = &adis16220_attribute_group,
> -	.driver_module = THIS_MODULE,
> -	.read_raw = &adis16220_read_raw,
> -};
> -
> -static const char * const adis16220_status_error_msgs[] = {
> -	[ADIS16220_DIAG_STAT_VIOLATION_BIT] = "Capture period violation/interruption",
> -	[ADIS16220_DIAG_STAT_SPI_FAIL_BIT] = "SPI failure",
> -	[ADIS16220_DIAG_STAT_FLASH_UPT_BIT] = "Flash update failed",
> -	[ADIS16220_DIAG_STAT_POWER_HIGH_BIT] = "Power supply above 3.625V",
> -	[ADIS16220_DIAG_STAT_POWER_LOW_BIT] = "Power supply below 3.15V",
> -};
> -
> -static const struct adis_data adis16220_data = {
> -	.read_delay = 35,
> -	.write_delay = 35,
> -	.msc_ctrl_reg = ADIS16220_MSC_CTRL,
> -	.glob_cmd_reg = ADIS16220_GLOB_CMD,
> -	.diag_stat_reg = ADIS16220_DIAG_STAT,
> -
> -	.self_test_mask = ADIS16220_MSC_CTRL_SELF_TEST_EN,
> -	.startup_delay = ADIS16220_STARTUP_DELAY,
> -
> -	.status_error_msgs = adis16220_status_error_msgs,
> -	.status_error_mask = BIT(ADIS16220_DIAG_STAT_VIOLATION_BIT) |
> -		BIT(ADIS16220_DIAG_STAT_SPI_FAIL_BIT) |
> -		BIT(ADIS16220_DIAG_STAT_FLASH_UPT_BIT) |
> -		BIT(ADIS16220_DIAG_STAT_POWER_HIGH_BIT) |
> -		BIT(ADIS16220_DIAG_STAT_POWER_LOW_BIT),
> -};
> -
> -static int adis16220_probe(struct spi_device *spi)
> -{
> -	int ret;
> -	struct adis16220_state *st;
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
> -	indio_dev->info = &adis16220_info;
> -	indio_dev->modes = INDIO_DIRECT_MODE;
> -	indio_dev->channels = adis16220_channels;
> -	indio_dev->num_channels = ARRAY_SIZE(adis16220_channels);
> -
> -	ret = devm_iio_device_register(&spi->dev, indio_dev);
> -	if (ret)
> -		return ret;
> -
> -	ret = sysfs_create_bin_file(&indio_dev->dev.kobj, &accel_bin);
> -	if (ret)
> -		return ret;
> -
> -	ret = sysfs_create_bin_file(&indio_dev->dev.kobj, &adc1_bin);
> -	if (ret)
> -		goto error_rm_accel_bin;
> -
> -	ret = sysfs_create_bin_file(&indio_dev->dev.kobj, &adc2_bin);
> -	if (ret)
> -		goto error_rm_adc1_bin;
> -
> -	ret = adis_init(&st->adis, indio_dev, spi, &adis16220_data);
> -	if (ret)
> -		goto error_rm_adc2_bin;
> -	/* Get the device into a sane initial state */
> -	ret = adis_initial_startup(&st->adis);
> -	if (ret)
> -		goto error_rm_adc2_bin;
> -	return 0;
> -
> -error_rm_adc2_bin:
> -	sysfs_remove_bin_file(&indio_dev->dev.kobj, &adc2_bin);
> -error_rm_adc1_bin:
> -	sysfs_remove_bin_file(&indio_dev->dev.kobj, &adc1_bin);
> -error_rm_accel_bin:
> -	sysfs_remove_bin_file(&indio_dev->dev.kobj, &accel_bin);
> -	return ret;
> -}
> -
> -static int adis16220_remove(struct spi_device *spi)
> -{
> -	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> -
> -	sysfs_remove_bin_file(&indio_dev->dev.kobj, &adc2_bin);
> -	sysfs_remove_bin_file(&indio_dev->dev.kobj, &adc1_bin);
> -	sysfs_remove_bin_file(&indio_dev->dev.kobj, &accel_bin);
> -
> -	return 0;
> -}
> -
> -static struct spi_driver adis16220_driver = {
> -	.driver = {
> -		.name = "adis16220",
> -	},
> -	.probe = adis16220_probe,
> -	.remove = adis16220_remove,
> -};
> -module_spi_driver(adis16220_driver);
> -
> -MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
> -MODULE_DESCRIPTION("Analog Devices ADIS16220 Digital Vibration Sensor");
> -MODULE_LICENSE("GPL v2");
> -MODULE_ALIAS("spi:adis16220");
> 

-- 

Peter Meerwald-Stadler
+43-664-2444418 (mobile)
