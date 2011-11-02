Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:50923 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752177Ab1KBMVM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 2 Nov 2011 08:21:12 -0400
Message-ID: <4EB137B3.9090202@cam.ac.uk>
Date: Wed, 02 Nov 2011 12:29:39 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] staging:iio:accel: Add driver for LIS331DLH
References: <1320228564-5452-1-git-send-email-manuel.stahl@iis.fraunhofer.de> <4EB12ABB.7030503@cam.ac.uk> <201111021315.31449.manuel.stahl@iis.fraunhofer.de>
In-Reply-To: <201111021315.31449.manuel.stahl@iis.fraunhofer.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/02/11 12:15, Manuel Stahl wrote:
> Am Mittwoch, 2. November 2011, 12:34:19 schrieb Jonathan Cameron:
>> Hi Manuel,
>>
>> How similar is this to those parts supported by the lis3 driver
>> in misc?  I have no particular problem with supporting this in staging
>> but we are probably going to have more issues making sure nothing is lost
>> if we attempt to merge it with that driver when outside staging.
> 
> It seem this is the first driver to support I2C and SPI.
The driver in misc does.
> 
>>
>> There are also a number of previous drivers out there for this part
>> http://www.gossamer-threads.com/lists/linux/kernel/1300192
>>
>> I have no idea if the lis3lv02d driver support this part currently or
>> not (which was the issue I raised with that previous driver).
> 
> The lis331dlh if really different from the lis3lv02d device. Especially the 
> event stuff. That's why I started a new driver.
Fair enough!
> 
>> Anyhow, we are already carrying the lis3l02dq driver mainly because I have
>> one on a board and it is handy for testing various things, so what's one
>> more.  Having said that we probably want to document this in Kconfig to
>> make it clear why this is there.
> 
> OK, how would you do that?
"Note the the lis331dlh is also supported by misc/lis3... which is currently
the preferred choice for use as an input device."
> 
>> For that matter, I've not really looked at this with a view to merging the
>> support with that driver either!
>>
>> Review, ignoring all those possible issues follows.
>>
>> On 11/02/11 10:09, Manuel Stahl wrote:
>>> Signed-off-by: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
>>> ---
>>>
>>>  drivers/staging/iio/accel/Kconfig          |   24 ++
>>>  drivers/staging/iio/accel/Makefile         |    4 +
>>>  drivers/staging/iio/accel/lis331dlh.h      |  224 +++++++++++++++
>>>  drivers/staging/iio/accel/lis331dlh_core.c |  406
>>>  ++++++++++++++++++++++++++++ drivers/staging/iio/accel/lis331dlh_i2c.c 
>>>  |  176 ++++++++++++
>>>  drivers/staging/iio/accel/lis331dlh_spi.c  |  231 ++++++++++++++++
>>>  6 files changed, 1065 insertions(+), 0 deletions(-)
>>>  create mode 100644 drivers/staging/iio/accel/lis331dlh.h
>>>  create mode 100644 drivers/staging/iio/accel/lis331dlh_core.c
>>>  create mode 100644 drivers/staging/iio/accel/lis331dlh_i2c.c
>>>  create mode 100644 drivers/staging/iio/accel/lis331dlh_spi.c
>>>
>>> diff --git a/drivers/staging/iio/accel/Kconfig
>>> b/drivers/staging/iio/accel/Kconfig index 5ab7167..7473393 100644
>>> --- a/drivers/staging/iio/accel/Kconfig
>>> +++ b/drivers/staging/iio/accel/Kconfig
>>> @@ -94,6 +94,30 @@ config LIS3L02DQ_BUF_RING_SW
>>>
>>>  endchoice
>>>
>>> +config LIS331DLH
>>> +	bool "ST Microelectronics LIS331DLH Accelerometer Driver"
>>> +	help
>>> +	  Say yes here to build support for the ST microelectronics LIS331DLH
>>> +	  accelerometer. The driver supplies direct access via sysfs files.
>>> +
>>> +if LIS331DLH
>>> +
>>> +config LIS331DLH_SPI
>>> +	tristate "ST Microelectronics LIS331DLH Accelerometer Driver (SPI)"
>>> +	depends on SPI
>>> +	help
>>> +	  Say yes here to build SPI interface support for the
>>> +	  ST microelectronics LIS331DLH accelerometer.
>>> +
>>> +config LIS331DLH_I2C
>>> +	tristate "ST Microelectronics LIS331DLH Accelerometer Driver (I2C)"
>>> +	depends on I2C
>>> +	help
>>> +	  Say yes here to build I2C interface support for the
>>> +	  ST microelectronics LIS331DLH accelerometer.
>>> +
>>> +endif # LIS331DLH
>>> +
>>>
>>>  config SCA3000
>>>  
>>>  	depends on IIO_BUFFER
>>>  	depends on SPI
>>>
>>> diff --git a/drivers/staging/iio/accel/Makefile
>>> b/drivers/staging/iio/accel/Makefile index 95c6666..22986b7 100644
>>> --- a/drivers/staging/iio/accel/Makefile
>>> +++ b/drivers/staging/iio/accel/Makefile
>>> @@ -27,6 +27,10 @@ obj-$(CONFIG_ADIS16240) += adis16240.o
>>>
>>>  obj-$(CONFIG_KXSD9)	+= kxsd9.o
>>>
>>> +lis331dlh-y		:= lis331dlh_core.o
>>> +obj-$(CONFIG_LIS331DLH_SPI)	+= lis331dlh.o lis331dlh_spi.o
>>> +obj-$(CONFIG_LIS331DLH_I2C)	+= lis331dlh.o lis331dlh_i2c.o
>>> +
>>>
>>>  lis3l02dq-y		:= lis3l02dq_core.o
>>>  lis3l02dq-$(CONFIG_IIO_BUFFER) += lis3l02dq_ring.o
>>>  obj-$(CONFIG_LIS3L02DQ)	+= lis3l02dq.o
>>>
>>> diff --git a/drivers/staging/iio/accel/lis331dlh.h
>>> b/drivers/staging/iio/accel/lis331dlh.h new file mode 100644
>>> index 0000000..1c5a39d
>>> --- /dev/null
>>> +++ b/drivers/staging/iio/accel/lis331dlh.h
>>> @@ -0,0 +1,224 @@
>>> +/*
>>> + * lis331dlh.h -- support STMicroelectronics LIS331DLH
>>> + *                3d 2g/4g/8g Linear Accelerometers
>>> + *
>>> + * Copyright (c) 2007 Jonathan Cameron <jic23@cam.ac.uk>
>>> + * Copyright (c) 2011 Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify
>>> + * it under the terms of the GNU General Public License version 2 as
>>> + * published by the Free Software Foundation.
>>> + */
>>> +
>>> +#ifndef SPI_LIS331DLH_H_
>>> +#define SPI_LIS331DLH_H_
>>> +
>>> +#include <asm/byteorder.h>
>>
>> This is unusual to see in here, so perhaps a comment saying why you
>> are messing with endianness?
> 
> The endianess of the device can be configured by a register entry. So we don't 
> have to do it in the driver when the devices is set up correctly.
That will do nicely.
> 
>>> +
>>> +#define LIS331DLH "lis331dlh"
>>> +
>>> +#define LIS331DLH_READ_REG(a) ((a) | 0x80)
>>> +#define LIS331DLH_WRITE_REG(a) a
>>> +#define LIS331DLH_I2C_AUTO_INC(a) ((a) | 0x80)
>>> +
>>> +#define LIS331DLH_REG_WHO_AM_I_ADDR			0x0F
>>> +#define LIS331DLH_REG_WHO_AM_I_DEFAULT			0x32
>>> +
>>> +/* Control Register (1 of 5) */
>>> +#define LIS331DLH_REG_CTRL_1_ADDR			0x20
>>> +/* Power ctrl - either bit set corresponds to on */
>>> +#define LIS331DLH_REG_CTRL_1_POWER_OFF			0x00
>>> +#define LIS331DLH_REG_CTRL_1_POWER_ON			0x20
>>> +#define LIS331DLH_REG_CTRL_1_LOW_POWER_05		0x40
>>> +
>>> +/* Data Rate */
>>> +#define LIS331DLH_REG_CTRL_1_DR_50			0x00
>>> +#define LIS331DLH_REG_CTRL_1_DR_100			0x08
>>> +#define LIS331DLH_REG_CTRL_1_DR_400			0x10
>>> +#define LIS331DLH_REG_CTRL_1_DR_1000			0x18
>>> +#define LIS331DLH_REG_CTRL_1_DR_MASK			0x18
>>> +
>>> +/* Axes enable ctrls */
>>> +#define LIS331DLH_REG_CTRL_1_AXES_Z_ENABLE		0x04
>>> +#define LIS331DLH_REG_CTRL_1_AXES_Y_ENABLE		0x02
>>> +#define LIS331DLH_REG_CTRL_1_AXES_X_ENABLE		0x01
>>> +
>>> +/* Control Register (2 of 5) */
>>> +#define LIS331DLH_REG_CTRL_2_ADDR			0x21
>>> +
>>> +#define LIS331DLH_REG_CTRL_2_BOOT			0x80
>>> +
>>> +#define LIS331DLH_REG_CTRL_2_HP_NORM			0x00
>>> +#define LIS331DLH_REG_CTRL_2_HP_REF			0x40
>>> +
>>> +#define LIS331DLH_REG_CTRL_2_FDS_INT			0x10
>>> +#define LIS331DLH_REG_CTRL_2_HPEN2			0x08
>>> +#define LIS331DLH_REG_CTRL_2_HPEN1			0x04
>>> +#define LIS331DLH_REG_CTRL_2_HPCF1			0x02
>>> +#define LIS331DLH_REG_CTRL_2_HPCF0			0x01
>>> +
>>> +/* Control Register (3 of 5) */
>>> +#define LIS331DLH_REG_CTRL_3_ADDR			0x22
>>> +
>>> +#define LIS331DLH_REG_CTRL_3_IHL			0x80
>>> +#define LIS331DLH_REG_CTRL_3_PP_OD			0x40
>>> +#define LIS331DLH_REG_CTRL_3_LIR2			0x20
>>> +#define LIS331DLH_REG_CTRL_3_I2_I			0x00
>>> +#define LIS331DLH_REG_CTRL_3_I2_1OR2			0x08
>>> +#define LIS331DLH_REG_CTRL_3_I2_DRDY			0x10
>>> +#define LIS331DLH_REG_CTRL_3_I2_RUN			0x18
>>> +#define LIS331DLH_REG_CTRL_3_I2_MASK			0x18
>>> +#define LIS331DLH_REG_CTRL_3_LIR1			0x04
>>> +#define LIS331DLH_REG_CTRL_3_I1_I			0x00
>>> +#define LIS331DLH_REG_CTRL_3_I1_1OR2			0x01
>>> +#define LIS331DLH_REG_CTRL_3_I1_DRDY			0x02
>>> +#define LIS331DLH_REG_CTRL_3_I1_RUN			0x03
>>> +#define LIS331DLH_REG_CTRL_3_I1_MASK			0x03
>>> +
>>> +/* Control Register (4 of 5) */
>>> +#define LIS331DLH_REG_CTRL_4_ADDR			0x23
>>> +
>>> +/* Block Data Update only after MSB and LSB read */
>>> +#define LIS331DLH_REG_CTRL_4_BLOCK_UPDATE		0x80
>>> +
>>> +/* Set to big endian output */
>>> +#define LIS331DLH_REG_CTRL_4_BIG_ENDIAN			0x40
>>> +
>>> +/* Full scale selection */
>>> +#define LIS331DLH_REG_CTRL_4_FS_2G			0x00
>>> +#define LIS331DLH_REG_CTRL_4_FS_4G			0x10
>>> +#define LIS331DLH_REG_CTRL_4_FS_8G			0x30
>>> +#define LIS331DLH_REG_CTRL_4_FS_MASK			0x30
>>> +
>>> +/* Self Test Sign */
>>> +#define LIS331DLH_REG_CTRL_4_ST_SIGN			0x08
>>> +
>>> +/* Self Test Enable */
>>> +#define LIS331DLH_REG_CTRL_4_ST_ON			0x02
>>> +
>>> +/* SPI 3 wire mode */
>>> +#define LIS331DLH_REG_CTRL_4_THREE_WIRE_SPI_MODE	0x01
>>> +
>>> +/* Control Register (5 of 5) */
>>> +#define LIS331DLH_REG_CTRL_5_ADDR			0x24
>>> +
>>> +#define LIS331DLH_REG_CTRL_5_SLEEP_WAKE_OFF		0x00
>>> +#define LIS331DLH_REG_CTRL_5_LOW_POWER			0x03
>>> +
>>> +/* Dummy register */
>>> +#define LIS331DLH_REG_HP_FILTER_RESET			0x25
>>> +
>>> +/* Reference register */
>>> +#define LIS331DLH_REG_REFERENCE				0x26
>>> +
>>> +/* Status register */
>>> +#define LIS331DLH_REG_STATUS_ADDR			0x27
>>> +/* XYZ axis data overrun - first is all overrun? */
>>> +#define LIS331DLH_REG_STATUS_XYZ_OVERRUN		0x80
>>> +#define LIS331DLH_REG_STATUS_Z_OVERRUN			0x40
>>> +#define LIS331DLH_REG_STATUS_Y_OVERRUN			0x20
>>> +#define LIS331DLH_REG_STATUS_X_OVERRUN			0x10
>>> +/* XYZ new data available - first is all 3 available? */
>>> +#define LIS331DLH_REG_STATUS_XYZ_NEW_DATA		0x08
>>> +#define LIS331DLH_REG_STATUS_Z_NEW_DATA			0x04
>>> +#define LIS331DLH_REG_STATUS_Y_NEW_DATA			0x02
>>> +#define LIS331DLH_REG_STATUS_X_NEW_DATA			0x01
>>> +
>>> +/* The accelerometer readings - low and high bytes.
>>> +Form of high byte dependant on justification set in ctrl reg */
>>> +#define LIS331DLH_REG_OUT_X_L_ADDR			0x28
>>> +#define LIS331DLH_REG_OUT_X_H_ADDR			0x29
>>> +#define LIS331DLH_REG_OUT_Y_L_ADDR			0x2A
>>> +#define LIS331DLH_REG_OUT_Y_H_ADDR			0x2B
>>> +#define LIS331DLH_REG_OUT_Z_L_ADDR			0x2C
>>> +#define LIS331DLH_REG_OUT_Z_H_ADDR			0x2D
>>> +
>>> +/* Interrupt 1 config register */
>>> +#define LIS331DLH_REG_INT1_CFG_ADDR			0x30
>>> +#define LIS331DLH_REG_INT1_SRC_ADDR			0x31
>>> +#define LIS331DLH_REG_INT1_THS_ADDR			0x32
>>> +#define LIS331DLH_REG_INT1_DURATION_ADDR		0x33
>>> +
>>> +/* Interrupt 2 config register */
>>> +#define LIS331DLH_REG_INT2_CFG_ADDR			0x34
>>> +#define LIS331DLH_REG_INT2_SRC_ADDR			0x35
>>> +#define LIS331DLH_REG_INT2_THS_ADDR			0x36
>>> +#define LIS331DLH_REG_INT2_DURATION_ADDR		0x37
>>> +
>>> +#define LIS331DLH_REG_INT_AOI				0x80
>>> +#define LIS331DLH_REG_INT_6D				0x40
>>> +#define LIS331DLH_REG_INT_Z_HIGH			0x20
>>> +#define LIS331DLH_REG_INT_Z_LOW				0x10
>>> +#define LIS331DLH_REG_INT_Y_HIGH			0x08
>>> +#define LIS331DLH_REG_INT_Y_LOW				0x04
>>> +#define LIS331DLH_REG_INT_X_HIGH			0x02
>>> +#define LIS331DLH_REG_INT_X_LOW				0x01
>>> +
>>> +
>>> +/* Default control settings */
>>> +#define LIS331DLH_DEFAULT_CTRL1  (LIS331DLH_REG_CTRL_1_POWER_ON	     \
>>> +				| LIS331DLH_REG_CTRL_1_DR_50         \
>>> +				| LIS331DLH_REG_CTRL_1_AXES_Z_ENABLE \
>>> +				| LIS331DLH_REG_CTRL_1_AXES_Y_ENABLE \
>>> +				| LIS331DLH_REG_CTRL_1_AXES_X_ENABLE)
>>> +
>>> +#define LIS331DLH_DEFAULT_CTRL2	 LIS331DLH_REG_CTRL_2_HP_NORM
>>> +
>>> +#define LIS331DLH_DEFAULT_CTRL3  LIS331DLH_REG_CTRL_3_I1_DRDY
>>> +
>>> +#ifdef __BIG_ENDIAN
>>> +#define LIS331DLH_REG_CTRL_4_CPU_ENDIAN LIS331DLH_REG_CTRL_4_BIG_ENDIAN
>>> +#else
>>> +#define LIS331DLH_REG_CTRL_4_CPU_ENDIAN 0
>>> +#endif
>>> +
>>> +#define LIS331DLH_DEFAULT_CTRL4  (LIS331DLH_REG_CTRL_4_BLOCK_UPDATE \
>>> +				| LIS331DLH_REG_CTRL_4_CPU_ENDIAN \
>>> +				| LIS331DLH_REG_CTRL_4_FS_2G)
>>> +
>>> +#define LIS331DLH_MAX_TX 12
>>> +#define LIS331DLH_MAX_RX 12
>>> +
>>> +static const u8 read_all_tx_array[] = {
>>> +	LIS331DLH_READ_REG(LIS331DLH_REG_OUT_X_L_ADDR), 0,
>>> +	LIS331DLH_READ_REG(LIS331DLH_REG_OUT_X_H_ADDR), 0,
>>> +	LIS331DLH_READ_REG(LIS331DLH_REG_OUT_Y_L_ADDR), 0,
>>> +	LIS331DLH_READ_REG(LIS331DLH_REG_OUT_Y_H_ADDR), 0,
>>> +	LIS331DLH_READ_REG(LIS331DLH_REG_OUT_Z_L_ADDR), 0,
>>> +	LIS331DLH_READ_REG(LIS331DLH_REG_OUT_Z_H_ADDR), 0,
>>> +};
>>> +
>>> +/**
>>> + * struct lis331dlh_state - device instance specific data
>>> + * @us:			pointer to actual bus (spi/i2c)
>>> + * @buf_lock:		mutex to protect tx and rx
>>> + * @tx:			transmit buffer
>>> + * @rx:			receive buffer (16bit aligned)
>>> + * @read/write		bus specific functions to access registers
>>> + **/
>>> +struct lis331dlh_state {
>>> +	void			*us;
>>> +	struct mutex		buf_lock;
>>> +
>>> +	u8	tx[LIS331DLH_MAX_TX] ____cacheline_aligned;
>>> +	u16	rx[LIS331DLH_MAX_RX/2] ____cacheline_aligned;
>>> +
>>
>> Break this out into a const ops structure so that the two implementations
>> can assign it as one pointer.
> 
> Sounds good.
> 
>>
>>> +	int (*read_reg_8)  (struct lis331dlh_state *st, u8 addr, u8 *val);
>>> +	int (*write_reg_8) (struct lis331dlh_state *st, u8 addr, u8 val);
>>> +	int (*read_reg_16) (struct lis331dlh_state *st, u8 low_addr, u16 
> *val);
>>> +	int (*read_all) (struct lis331dlh_state *st, u8 *rx_array);
>>> +};
>>> +
>>> +int lis331dlh_probe(struct iio_dev *indio_dev, struct device *dev);
>>> +int lis331dlh_remove(struct iio_dev *indio_dev);
>>> +
>>> +int lis331dlh_stop_device(struct iio_dev *indio_dev);
>>> +
>>> +enum LIS331DLH_CHANNELS {
>>> +	LIS331DLH_ACCEL_X,
>>> +	LIS331DLH_ACCEL_Y,
>>> +	LIS331DLH_ACCEL_Z,
>>> +	LIS331DLH_TIMESTAMP,
>>> +};
>>> +
>>> +#endif /* SPI_LIS331DLH_H_ */
>>> diff --git a/drivers/staging/iio/accel/lis331dlh_core.c
>>> b/drivers/staging/iio/accel/lis331dlh_core.c new file mode 100644
>>> index 0000000..0d06f20
>>> --- /dev/null
>>> +++ b/drivers/staging/iio/accel/lis331dlh_core.c
>>> @@ -0,0 +1,406 @@
>>> +/*
>>> + * lis331dlh_core.c	support STMicroelectronics LIS331DLH
>>> + *			3d 2g/4g/8g Linear Accelerometers
>>> + *
>>> + * Copyright (c) 2007 Jonathan Cameron <jic23@cam.ac.uk>
>>> + * Copyright (c) 2011 Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify
>>> + * it under the terms of the GNU General Public License version 2 as
>>> + * published by the Free Software Foundation.
>>> + */
>>> +
>>> +#include <linux/mutex.h>
>>> +#include <linux/device.h>
>>> +#include <linux/kernel.h>
>>> +#include <linux/sysfs.h>
>>> +#include <linux/module.h>
>>> +
>>> +#include "../iio.h"
>>> +#include "../sysfs.h"
>>> +#include "../events.h"
>>> +
>>> +#include "lis331dlh.h"
>>> +
>>> +static int lis331dlh_read_raw(struct iio_dev *indio_dev,
>>> +			      struct iio_chan_spec const *chan,
>>> +			      int *val,
>>> +			      int *val2,
>>> +			      long mask)
>>> +{
>>> +	struct lis331dlh_state *st = iio_priv(indio_dev);
>>> +	s16 value;
>>> +	u8 utemp;
>>> +	ssize_t ret = 0;
>>> +	u8 reg;
>>> +
>>> +	switch (mask) {
>>> +	case 0:
>>> +		/* Take the iio_dev status lock */
>>> +		mutex_lock(&indio_dev->mlock);
>>> +		ret = st->read_reg_16(st, chan->address, (u16 *)&value);
>>> +		*val = value;
>>> +		mutex_unlock(&indio_dev->mlock);
>>> +		return ret ? ret : IIO_VAL_INT;
>>> +	case IIO_CHAN_INFO_SCALE:
>>> +		ret = st->read_reg_8(st, LIS331DLH_REG_CTRL_4_ADDR, &utemp);
>>> +		if (ret)
>>> +			return ret;
>>> +
>>> +		utemp &= LIS331DLH_REG_CTRL_4_FS_MASK;
>>> +		switch (utemp) {
>>> +		case LIS331DLH_REG_CTRL_4_FS_2G:
>>> +			*val2 = 569;
>>> +			break;
>>> +		case LIS331DLH_REG_CTRL_4_FS_4G:
>>> +			*val2 = 1135;
>>> +			break;
>>> +		case LIS331DLH_REG_CTRL_4_FS_8G:
>>> +			*val2 = 2270;
>>> +			break;
>>> +		default:
>>> +			*val2 = 0;
>>> +			break;
>>> +		}
>>> +		*val = 0;
>>> +		return IIO_VAL_INT_PLUS_MICRO;
>>> +	}
>>> +	return -1;
>>> +}
>>> +
>>> +static ssize_t lis331dlh_read_frequency(struct device *dev,
>>> +					struct device_attribute *attr,
>>> +					char *buf)
>>> +{
>>> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>>> +	struct lis331dlh_state *st = iio_priv(indio_dev);
>>> +	int ret, len = 0;
>>> +	u8 val;
>>> +
>>> +	ret = st->read_reg_8(st, LIS331DLH_REG_CTRL_1_ADDR, &val);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	val &= LIS331DLH_REG_CTRL_1_DR_MASK;
>>> +	switch (val) {
>>> +	case LIS331DLH_REG_CTRL_1_DR_50:
>>> +		len = sprintf(buf, "50\n");
>>> +		break;
>>> +	case LIS331DLH_REG_CTRL_1_DR_100:
>>> +		len = sprintf(buf, "100\n");
>>> +		break;
>>> +	case LIS331DLH_REG_CTRL_1_DR_400:
>>> +		len = sprintf(buf, "400\n");
>>> +		break;
>>> +	case LIS331DLH_REG_CTRL_1_DR_1000:
>>> +		len = sprintf(buf, "1000\n");
>>> +		break;
>>> +	}
>>> +	return len;
>>> +}
>>> +
>>> +static ssize_t lis331dlh_write_frequency(struct device *dev,
>>> +					 struct device_attribute *attr,
>>> +					 const char *buf,
>>> +					 size_t len)
>>> +{
>>> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>>> +	struct lis331dlh_state *st = iio_priv(indio_dev);
>>> +	unsigned long freq;
>>> +	int ret;
>>> +	u8 val;
>>> +
>>> +	ret = strict_strtoul(buf, 10, &freq);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	mutex_lock(&indio_dev->mlock);
>>> +	ret = st->read_reg_8(st, LIS331DLH_REG_CTRL_1_ADDR, &val);
>>> +	if (ret)
>>> +		goto error_ret_mutex;
>>> +
>>> +	val &= ~LIS331DLH_REG_CTRL_1_DR_MASK;
>>> +	switch (freq) {
>>> +	case 50:
>>> +		val |= LIS331DLH_REG_CTRL_1_DR_50;
>>> +		break;
>>> +	case 100:
>>> +		val |= LIS331DLH_REG_CTRL_1_DR_100;
>>> +		break;
>>> +	case 400:
>>> +		val |= LIS331DLH_REG_CTRL_1_DR_400;
>>> +		break;
>>> +	case 1000:
>>> +		val |= LIS331DLH_REG_CTRL_1_DR_1000;
>>> +		break;
>>> +	default:
>>> +		ret = -EINVAL;
>>> +		goto error_ret_mutex;
>>> +	};
>>> +
>>> +	ret = st->write_reg_8(st, LIS331DLH_REG_CTRL_1_ADDR, val);
>>> +
>>> +error_ret_mutex:
>>> +	mutex_unlock(&indio_dev->mlock);
>>> +
>>> +	return ret ? ret : len;
>>> +}
>>> +
>>> +static ssize_t lis331dlh_read_range(struct device *dev,
>>> +				    struct device_attribute *attr,
>>> +				    char *buf)
>>> +{
>>> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>>> +	struct lis331dlh_state *st = iio_priv(indio_dev);
>>> +	int ret, len = 0;
>>> +	u8 val;
>>> +
>>> +	ret = st->read_reg_8(st, LIS331DLH_REG_CTRL_4_ADDR, &val);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	val &= LIS331DLH_REG_CTRL_4_FS_MASK;
>>> +	switch (val) {
>>> +	case LIS331DLH_REG_CTRL_4_FS_2G:
>>> +		len = sprintf(buf, "2G\n");
>>
>> We have accelerometers units as m/s^2 not G, so please adjust these
>> to match and verify the rest are correct as well.
> 
> Reported values are correct. This is kind of a special sysfs entry, where we 
> can configure the limits of the device. The possible values here would look 
> somehow strange if expressed in m/s^2. But in general I agree, we should have 
> consistent units whereever possible.
Do it anyway - if userspace apps want to convert this back to G then that's
up to them!
> 
>>
>>> +		break;
>>> +	case LIS331DLH_REG_CTRL_4_FS_4G:
>>> +		len = sprintf(buf, "4G\n");
>>> +		break;
>>> +	case LIS331DLH_REG_CTRL_4_FS_8G:
>>> +		len = sprintf(buf, "8G\n");
>>> +		break;
>>> +	}
>>> +	return len;
>>> +}
>>> +
>>> +static ssize_t lis331dlh_write_range(struct device *dev,
>>> +				     struct device_attribute *attr,
>>> +				     const char *buf,
>>> +				     size_t len)
>>> +{
>>> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>>> +	struct lis331dlh_state *st = iio_priv(indio_dev);
>>> +	unsigned long freq;
>>> +	int ret;
>>> +	u8 val;
>>> +
>>> +	ret = strict_strtoul(buf, 10, &freq);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	mutex_lock(&indio_dev->mlock);
>>> +	ret = st->read_reg_8(st, LIS331DLH_REG_CTRL_4_ADDR, &val);
>>> +	if (ret)
>>> +		goto error_ret_mutex;
>>> +
>>> +	val &= ~LIS331DLH_REG_CTRL_4_FS_MASK;
>>> +	switch (freq) {
>>> +	case 2:
>>> +		val |= LIS331DLH_REG_CTRL_4_FS_2G;
>>> +		break;
>>> +	case 4:
>>> +		val |= LIS331DLH_REG_CTRL_4_FS_4G;
>>> +		break;
>>> +	case 8:
>>> +		val |= LIS331DLH_REG_CTRL_4_FS_8G;
>>> +		break;
>>> +	default:
>>> +		ret = -EINVAL;
>>> +		goto error_ret_mutex;
>>> +	};
>>> +
>>> +	ret = st->write_reg_8(st, LIS331DLH_REG_CTRL_4_ADDR, val);
>>> +
>>> +error_ret_mutex:
>>> +	mutex_unlock(&indio_dev->mlock);
>>> +
>>> +	return ret ? ret : len;
>>> +}
>>> +
>>> +static int lis331dlh_init(struct iio_dev *indio_dev)
>>> +{
>>> +	struct lis331dlh_state *st = iio_priv(indio_dev);
>>> +	int ret;
>>> +	u8 val;
>>> +
>>> +	ret = st->read_reg_8(st, LIS331DLH_REG_WHO_AM_I_ADDR, &val);
>>> +	if (ret || (val != LIS331DLH_REG_WHO_AM_I_DEFAULT)) {
>>> +		dev_err(indio_dev->dev.parent,
>>> +			"reading WHO_AM_I register failed: 0x%02X", val);
>>> +		goto err_ret;
>>> +	}
>>> +
>>> +	/* Write suitable defaults to ctrl1 */
>>> +	ret = st->write_reg_8(st, LIS331DLH_REG_CTRL_1_ADDR,
>>> +				  LIS331DLH_DEFAULT_CTRL1);
>>> +	if (ret) {
>>> +		dev_err(indio_dev->dev.parent,
>>> +				"problem with setup control register 1");
>>> +		goto err_ret;
>>> +	}
>>> +
>>> +	/* Write suitable defaults to ctrl2 */
>>> +	ret = st->write_reg_8(st, LIS331DLH_REG_CTRL_2_ADDR,
>>> +				  LIS331DLH_DEFAULT_CTRL2);
>>> +	if (ret) {
>>> +		dev_err(indio_dev->dev.parent,
>>> +				"problem with setup control register 2");
>>> +		goto err_ret;
>>> +	}
>>> +
>>> +	/* Write suitable defaults to ctrl3 */
>>> +	ret = st->write_reg_8(st, LIS331DLH_REG_CTRL_3_ADDR,
>>> +				  LIS331DLH_DEFAULT_CTRL3);
>>> +	if (ret) {
>>> +		dev_err(indio_dev->dev.parent,
>>> +				"problem with setup control register 3");
>>> +		goto err_ret;
>>> +	}
>>> +
>>> +	/* Write suitable defaults to ctrl4 */
>>> +	ret = st->write_reg_8(st, LIS331DLH_REG_CTRL_4_ADDR,
>>> +				  LIS331DLH_DEFAULT_CTRL4);
>>> +	if (ret) {
>>> +		dev_err(indio_dev->dev.parent,
>>> +				"problem with setup control register 4");
>>> +		goto err_ret;
>>> +	}
>>> +
>>> +	/* Read int1 src reg to clear pending irqs */
>>> +	ret = st->read_reg_8(st, LIS331DLH_REG_INT1_SRC_ADDR, &val);
>>> +	if (ret) {
>>> +		dev_err(indio_dev->dev.parent,
>>> +				"problem with int1 src register");
>>> +		goto err_ret;
>>> +	}
>>> +
>>> +	/* Read int2 src reg to clear pending irqs */
>>> +	ret = st->read_reg_8(st, LIS331DLH_REG_INT2_SRC_ADDR, &val);
>>> +	if (ret) {
>>> +		dev_err(indio_dev->dev.parent,
>>> +				"problem with int2 src register");
>>> +		goto err_ret;
>>> +	}
>>> +
>>> +err_ret:
>>> +	return ret;
>>> +}
>>> +
>>> +static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
>>> +			      lis331dlh_read_frequency,
>>> +			      lis331dlh_write_frequency);
>>> +
>>> +static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("50 100 400 1000");
>>> +
>>
>> Not abi compliant. Should be in_accel_range and for that matter
>> we should add range to the iio_chan_info_enum as it seems to be
>> way more popular than I'd like...
> 
> _min and _max would be the alternative, but then it's rather hard to have 
> proper semantics for configuring these. Furthermore it's not really the range. 
> The device can report greater values than 2G if configured in that mode but 
> the accuracy will drop. 
Nasty! 
> That's why I tend to keep it as a special attribute. 
> Range or min/max should express hard limits.
I'd just map this on to the in_accel_range  (and in_accel_range_available)
and ignore the fact it can report outside the specified range.
> 
>>
>>> +static IIO_DEVICE_ATTR(range, S_IWUSR | S_IRUGO,
>>> +		       lis331dlh_read_range,
>>> +		       lis331dlh_write_range, 0);
>>> +
>>> +#define LIS331DLH_EVENT_MASK					\
>>> +	(IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING) |	\
>>> +	 IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_FALLING))
>>> +
>>> +#define LIS331DLH_ACCEL_CHAN_SPEC(_mod, _si, _addr)		\
>>> +	{ .type = IIO_ACCEL,					\
>>> +	  .modified = 1,					\
>>> +	  .channel2 = _mod,					\
>>> +	  .address = _addr,					\
>>> +	  .info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT,		\
>>> +	  .scan_index = _si,					\
>>> +	  .scan_type = IIO_ST('s', 16, 16, 0),			\
>>> +	  .event_mask = LIS331DLH_EVENT_MASK,			\
>>> +	}
>>> +
>>> +static struct iio_chan_spec lis331dlh_channels[] = {
>>> +	LIS331DLH_ACCEL_CHAN_SPEC(IIO_MOD_X, LIS331DLH_ACCEL_X,
>>> +				  LIS331DLH_REG_OUT_X_L_ADDR),
>>> +	LIS331DLH_ACCEL_CHAN_SPEC(IIO_MOD_Y, LIS331DLH_ACCEL_Y,
>>> +				  LIS331DLH_REG_OUT_Y_L_ADDR),
>>> +	LIS331DLH_ACCEL_CHAN_SPEC(IIO_MOD_Z, LIS331DLH_ACCEL_Z,
>>> +				  LIS331DLH_REG_OUT_Z_L_ADDR),
>>> +	IIO_CHAN_SOFT_TIMESTAMP(LIS331DLH_TIMESTAMP)
>>> +};
>>> +
>>> +static struct attribute *lis331dlh_attributes[] = {
>>> +	&iio_dev_attr_sampling_frequency.dev_attr.attr,
>>> +	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
>>> +	&iio_dev_attr_range.dev_attr.attr,
>>> +	NULL
>>> +};
>>> +
>>> +static const struct attribute_group lis331dlh_attribute_group = {
>>> +	.attrs = lis331dlh_attributes,
>>> +};
>>> +
>>> +static const struct iio_info lis331dlh_info = {
>>> +	.read_raw = &lis331dlh_read_raw,
>>> +	.driver_module = THIS_MODULE,
>>> +	.attrs = &lis331dlh_attribute_group,
>>> +};
>>> +
>>> +int lis331dlh_probe(struct iio_dev *indio_dev, struct device *dev)
>>> +{
>>> +	struct lis331dlh_state *st = iio_priv(indio_dev);
>>> +	int ret;
>>> +
>>> +	mutex_init(&st->buf_lock);
>>> +
>>> +	indio_dev->name = LIS331DLH;
>>> +	indio_dev->dev.parent = dev;
>>> +	indio_dev->info = &lis331dlh_info;
>>> +	indio_dev->channels = lis331dlh_channels;
>>> +	indio_dev->num_channels = ARRAY_SIZE(lis331dlh_channels);
>>> +	indio_dev->modes = INDIO_DIRECT_MODE;
>>> +
>>> +	/* Get the device into a sane initial state */
>>> +	ret = lis331dlh_init(indio_dev);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	ret = iio_device_register(indio_dev);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	return 0;
>>> +}
>>> +EXPORT_SYMBOL_GPL(lis331dlh_probe);
>>> +
>>> +/* Power down the device */
>>> +int lis331dlh_power_down(struct iio_dev *indio_dev)
>>> +{
>>> +	struct lis331dlh_state *st = iio_priv(indio_dev);
>>> +	int ret;
>>> +
>>> +	mutex_lock(&indio_dev->mlock);
>>> +	ret = st->write_reg_8(st, LIS331DLH_REG_CTRL_1_ADDR,
>>> +				  LIS331DLH_REG_CTRL_1_POWER_OFF);
>>> +	if (ret) {
>>> +		dev_err(&indio_dev->dev, "problem with turning device off");
>>> +		goto err_ret;
>>> +	}
>>> +
>>> +err_ret:
>>> +	mutex_unlock(&indio_dev->mlock);
>>> +	return ret;
>>> +}
>>> +EXPORT_SYMBOL_GPL(lis331dlh_power_down);
>>> +
>>> +int lis331dlh_remove(struct iio_dev *indio_dev)
>>> +{
>>> +	int ret;
>>> +
>>> +	ret = lis331dlh_power_down(indio_dev);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	iio_device_unregister(indio_dev);
>>> +	iio_free_device(indio_dev);
>>> +
>>> +	return 0;
>>> +}
>>> +EXPORT_SYMBOL_GPL(lis331dlh_remove);
>>> +
>>> +MODULE_AUTHOR("Manuel Stahl <manuel.stahl@iis.fraunhofer.de>");
>>> +MODULE_DESCRIPTION("ST LIS331DLH Accelerometer driver");
>>> +MODULE_LICENSE("GPL v2");
>>> diff --git a/drivers/staging/iio/accel/lis331dlh_i2c.c
>>> b/drivers/staging/iio/accel/lis331dlh_i2c.c new file mode 100644
>>> index 0000000..35c9c98
>>> --- /dev/null
>>> +++ b/drivers/staging/iio/accel/lis331dlh_i2c.c
>>> @@ -0,0 +1,176 @@
>>> +/*
>>> + * lis331dlh_i2c.c	support STMicroelectronics LISD02DQ
>>> + *			3d 2g/4g/8g Linear Accelerometers
>>> + *
>>> + * Copyright (c) 2007 Jonathan Cameron <jic23@cam.ac.uk>
>>> + * Copyright (c) 2011 Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify
>>> + * it under the terms of the GNU General Public License version 2 as
>>> + * published by the Free Software Foundation.
>>> + */
>>> +
>>> +#include <linux/i2c.h>
>>> +
>>> +#include "../iio.h"
>>> +
>>> +#include "lis331dlh.h"
>>> +
>>> +static int lis331dlh_i2c_read_reg_8(struct lis331dlh_state *st,
>>> +				    u8 reg_address, u8 *val)
>>> +{
>>> +	struct i2c_client *client = st->us;
>>> +	int ret;
>>> +
>>> +	struct i2c_msg msg[] = { {
>>> +		.addr = client->addr,
>>> +		.flags = client->flags & I2C_M_TEN,
>>> +		.len = 1,
>>> +		.buf = &reg_address,
>>> +	}, {
>>> +		.addr = client->addr,
>>> +		.flags = (client->flags & I2C_M_TEN) | I2C_M_RD,
>>> +		.len = 1,
>>> +		.buf = val,
>>> +	} };
>>> +
>>> +	reg_address = LIS331DLH_WRITE_REG(reg_address);
>>> +	ret = i2c_transfer(client->adapter, msg, 2);
>>> +	return (ret == 2) ? 0 : ret;
>>> +}
>>> +
>>> +static int lis331dlh_i2c_write_reg_8(struct lis331dlh_state *st,
>>> +				     u8 reg_address, u8 val)
>>> +{
>>> +	struct i2c_client *client = st->us;
>>> +	u8 buf[2];
>>> +	int ret;
>>> +
>>> +	buf[0] = reg_address;
>>> +	buf[1] = val;
>>
>> use u8 buf[2] = { reg_address, val };
>> to keep this compact. Also, I'd make only negative values errors then
>> you can avoid the messing around with the return value and shorten
>> this somewhat.  Also, thinking about it, this looks like an smbus
>> command, so even better to use the relevant one of those if possible?
>> (I guess they might not play with the 10 bit address). Is this really
>> a device that uses that?
> 
> Yes smbus API is an option here.
> 
>>
>>> +
>>> +	ret = i2c_master_send(client, buf, sizeof(buf));
>>> +	return (ret == sizeof(buf)) ? 0 : ret;
>>> +}
>>> +
>>> +static int lis331dlh_i2c_read_reg_16(struct lis331dlh_state *st,
>>> +				     u8 lower_reg_address, u16 *val)
>>> +{
>>> +	struct i2c_client *client = st->us;
>>> +	int ret;
>>> +
>>> +	struct i2c_msg msg[] = { {
>>> +		.addr = client->addr,
>>> +		.flags = client->flags & I2C_M_TEN,
>>> +		.len = 1,
>>> +		.buf = &lower_reg_address,
>>> +	}, {
>>> +		.addr = client->addr,
>>> +		.flags = (client->flags & I2C_M_TEN) | I2C_M_RD,
>>> +		.len = 2,
>>> +		.buf = (u8 *)val,
>>> +	} };
>>> +
>>> +	lower_reg_address = LIS331DLH_I2C_AUTO_INC(lower_reg_address);
>>> +	ret = i2c_transfer(client->adapter, msg, 2);
>>> +	le16_to_cpus(val);
>>> +	return (ret == 2) ? 0 : ret;
>>> +}
>>> +
>>> +static int lis331dlh_i2c_read_all(struct lis331dlh_state *st, u8
>>> *rx_array) +{
>>> +	struct i2c_client *client = st->us;
>>> +	int ret;
>>> +	u8 reg = LIS331DLH_I2C_AUTO_INC(LIS331DLH_REG_OUT_X_L_ADDR);
>>> +
>>> +	struct i2c_msg msg[] = { {
>>> +		.addr = client->addr,
>>> +		.flags = client->flags & I2C_M_TEN,
>>> +		.len = 1,
>>> +		.buf = &reg,
>>> +	}, {
>>> +		.addr = client->addr,
>>> +		.flags = (client->flags & I2C_M_TEN) | I2C_M_RD,
>>> +		.len = 6,
>>> +		.buf = rx_array,
>>> +	} };
>>> +
>>> +	ret = i2c_transfer(client->adapter, msg, 2);
>>> +	if (ret != 2)
>>> +		return ret;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int lis331dlh_i2c_probe(struct i2c_client *i2c,
>>> +			       const struct i2c_device_id *id)
>>> +{
>>> +	int ret;
>>> +	struct lis331dlh_state *st;
>>> +	struct iio_dev *indio_dev;
>>> +
>>> +	indio_dev = iio_allocate_device(sizeof *st);
>>> +	if (!indio_dev)
>>> +		return -ENOMEM;
>>> +
>>> +	st = iio_priv(indio_dev);
>>> +	st->read_reg_8  = lis331dlh_i2c_read_reg_8;
>>> +	st->write_reg_8 = lis331dlh_i2c_write_reg_8;
>>> +	st->read_reg_16 = lis331dlh_i2c_read_reg_16;
>>> +	st->read_all	= lis331dlh_i2c_read_all;
>>> +
>>> +	st->us = i2c;
>>> +
>>> +	/* this is only used for removal purposes */
>>> +	i2c_set_clientdata(i2c, indio_dev);
>>> +
>>> +	ret = lis331dlh_probe(indio_dev, &i2c->dev);
>>> +	if (ret)
>>> +		goto error_free_dev;
>>> +
>>> +	return 0;
>>> +
>>> +error_free_dev:
>>> +	iio_free_device(indio_dev);
>>> +	return ret;
>>> +}
>>> +
>>> +static int lis331dlh_i2c_remove(struct i2c_client *i2c)
>>> +{
>>> +	struct iio_dev *indio_dev = i2c_get_clientdata(i2c);
>>> +	return lis331dlh_remove(indio_dev);
>>> +}
>>> +
>>> +static const struct i2c_device_id lis331dlh_id[] = {
>>> +	{"lis331dlh", 0x19 },
>>> +	{}
>>> +};
>>> +
>>> +MODULE_DEVICE_TABLE(i2c, lis331dlh_id);
>>> +
>>> +static struct i2c_driver lis331dlh_i2c_driver = {
>>> +	.driver	 = {
>>> +		.name   = "lis331dlh_i2c",
>>> +		.owner  = THIS_MODULE,
>>> +	},
>>> +	.probe	= lis331dlh_i2c_probe,
>>> +	.remove	= __devexit_p(lis331dlh_i2c_remove),
>>> +	.id_table = lis331dlh_id,
>>> +};
>>> +
>>> +static int __init lis331dlh_i2c_module_init(void)
>>> +{
>>> +	return i2c_add_driver(&lis331dlh_i2c_driver);
>>> +}
>>> +
>>> +static void __exit lis331dlh_i2c_module_exit(void)
>>> +{
>>> +	i2c_del_driver(&lis331dlh_i2c_driver);
>>> +}
>>> +
>>> +MODULE_AUTHOR("Manuel Stahl <manuel.stahl@iis.fraunhofer.de>");
>>> +MODULE_DESCRIPTION("ST LIS331DLH Accelerometer I2C driver");
>>> +MODULE_LICENSE("GPL v2");
>>> +
>>> +module_init(lis331dlh_i2c_module_init);
>>> +module_exit(lis331dlh_i2c_module_exit);
>>> diff --git a/drivers/staging/iio/accel/lis331dlh_spi.c
>>> b/drivers/staging/iio/accel/lis331dlh_spi.c new file mode 100644
>>> index 0000000..0aee730
>>> --- /dev/null
>>> +++ b/drivers/staging/iio/accel/lis331dlh_spi.c
>>> @@ -0,0 +1,231 @@
>>> +/*
>>> + * lis331dlh_spi.c	support STMicroelectronics LISD02DQ
>>> + *			3d 2g/4g/8g Linear Accelerometers via SPI
>>> + *
>>> + * Copyright (c) 2007 Jonathan Cameron <jic23@cam.ac.uk>
>>> + * Copyright (c) 2011 Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify
>>> + * it under the terms of the GNU General Public License version 2 as
>>> + * published by the Free Software Foundation.
>>> + */
>>> +
>>> +#include <linux/spi/spi.h>
>>> +
>>> +#include "../iio.h"
>>> +
>>> +#include "lis331dlh.h"
>>> +
>>> +/* At the moment the spi framework doesn't allow global setting of
>>> cs_change. + * It's in the likely to be added comment at the top of
>>> spi.h.
>>> + * This means that use cannot be made of spi_write etc.
>>> + */
>>> +
>>> +/**
>>> + * lis331dlh_spi_read_reg_8() - read single byte from a single register
>>> + * @dev: device asosciated with child of actual device (iio_dev or
>>> iio_trig) + * @reg_address: the address of the register to be read
>>> + * @val: pass back the resulting value
>>> + **/
>>> +static int lis331dlh_spi_read_reg_8(struct lis331dlh_state *st,
>>> +				   u8 reg_address, u8 *val)
>>> +{
>>> +	struct spi_device *spi = st->us;
>>> +	struct spi_message msg;
>>> +	int ret;
>>> +
>>> +	struct spi_transfer xfer = {
>>> +		.tx_buf = st->tx,
>>> +		.rx_buf = st->rx,
>>> +		.bits_per_word = 8,
>>> +		.len = 2,
>>> +		.cs_change = 1,
>>
>> Really, hold cs high between reads?  Surely doesn't do any
>> harm to not do so?
> 
> Ah yes, it's not needed.
> 
>>
>>> +	};
>>> +
>>> +	mutex_lock(&st->buf_lock);
>>> +	st->tx[0] = LIS331DLH_READ_REG(reg_address);
>>> +	st->tx[1] = 0;
>>> +
>>> +	spi_message_init(&msg);
>>> +	spi_message_add_tail(&xfer, &msg);
>>> +	ret = spi_sync(spi, &msg);
>>> +	*val = st->rx[1];
>>> +	mutex_unlock(&st->buf_lock);
>>> +
>>> +	return ret;
>>> +}
>>> +
>>> +/**
>>> + * lis331dlh_spi_write_reg_8() - write single byte to a register
>>> + * @dev: device associated with child of actual device (iio_dev or
>>> iio_trig) + * @reg_address: the address of the register to be writen
>>> + * @val: the value to write
>>> + **/
>>> +static int lis331dlh_spi_write_reg_8(struct lis331dlh_state *st,
>>> +				     u8 reg_address, u8 val)
>>> +{
>>> +	int ret;
>>> +	struct spi_message msg;
>>> +	struct spi_device *spi = st->us;
>>> +	struct spi_transfer xfer = {
>>> +		.tx_buf = st->tx,
>>> +		.bits_per_word = 8,
>>> +		.len = 2,
>>> +		.cs_change = 1,
>>> +	};
>>> +
>>> +	mutex_lock(&st->buf_lock);
>>> +	st->tx[0] = LIS331DLH_WRITE_REG(reg_address);
>>> +	st->tx[1] = val;
>>> +
>>> +	spi_message_init(&msg);
>>> +	spi_message_add_tail(&xfer, &msg);
>>> +	ret = spi_sync(spi, &msg);
>>> +	mutex_unlock(&st->buf_lock);
>>> +
>>> +	return ret;
>>> +}
>>> +
>>> +/**
>>> + * lisl302dq_spi_read_reg_16() - read 2 bytes from a pair of registers
>>> + * @dev: device associated with child of actual device (iio_dev or
>>> iio_trig) + * @reg_address: the address of the lower of the two
>>> registers. Second register + *               is assumed to have address
>>> one greater.
>>> + * @val: somewhere to pass back the value read
>>> + **/
>>> +static int lis331dlh_spi_read_reg_16(struct lis331dlh_state *st,
>>> +				     u8 lower_reg_address,
>>> +				     u16 *val)
>>> +{
>>> +	struct spi_message msg;
>>> +	struct spi_device *spi = st->us;
>>> +	int ret;
>>> +	struct spi_transfer xfers[] = { {
>>> +			.tx_buf = st->tx,
>>> +			.rx_buf = st->rx,
>>> +			.bits_per_word = 8,
>>> +			.len = 2,
>>> +			.cs_change = 1,
>>> +		}, {
>>> +			.tx_buf = st->tx + 2,
>>> +			.rx_buf = st->rx + 2,
>>> +			.bits_per_word = 8,
>>> +			.len = 2,
>>> +			.cs_change = 1,
>>> +
>>
>> weird white space.
> Oh, and now that I look over it, the device has multiple byte read/write 
> capability...
> 
>>
>>> +		},
>>> +	};
>>> +
>>> +	mutex_lock(&st->buf_lock);
>>> +	st->tx[0] = LIS331DLH_READ_REG(lower_reg_address);
>>> +	st->tx[1] = 0;
>>> +	st->tx[2] = LIS331DLH_READ_REG(lower_reg_address+1);
>>> +	st->tx[3] = 0;
>>> +
>>> +	spi_message_init(&msg);
>>> +	spi_message_add_tail(&xfers[0], &msg);
>>> +	spi_message_add_tail(&xfers[1], &msg);
>>> +	ret = spi_sync(spi, &msg);
>>> +	if (ret) {
>>> +		dev_err(&spi->dev, "problem when reading 16 bit register");
>>> +		goto error_ret;
>>> +	}
>>> +	*val = (u16)(st->rx[1]) | ((u16)(st->rx[3]) << 8);
>>> +
>>> +error_ret:
>>> +	mutex_unlock(&st->buf_lock);
>>> +	return ret;
>>> +}
>>> +
>>> +static int lis331dlh_spi_read_all(struct lis331dlh_state *st, u8
>>> *rx_array) +{
>>> +	struct spi_transfer xfers[2];
>>> +	struct spi_message msg;
>>> +	struct spi_device *spi = st->us;
>>> +
>>> +	st->tx[0] = read_all_tx_array[0];
>>> +	xfers[0].tx_buf = st->tx;
>>> +	xfers[0].rx_buf = NULL;
>>> +	xfers[0].bits_per_word = 8;
>>> +	xfers[0].len = 1;
>>> +	xfers[0].cs_change = 1;
>>> +
>>> +	xfers[1].tx_buf = NULL;
>>> +	xfers[1].rx_buf = rx_array;
>>> +	xfers[1].bits_per_word = 8;
>>> +	xfers[1].len = LIS331DLH_SCAN_ELEMENTS * 2;
>>> +	xfers[0].cs_change = 1;
>>> +
>>> +	spi_message_init(&msg);
>>> +	spi_message_add_tail(&xfers[0], &msg);
>>> +	spi_message_add_tail(&xfers[1], &msg);
>>> +
>>> +	return spi_sync(spi, &msg);
>>> +}
>>> +
>>> +static int __devinit lis331dlh_spi_probe(struct spi_device *spi)
>>> +{
>>> +	int ret;
>>> +	struct lis331dlh_state *st;
>>> +	struct iio_dev *indio_dev;
>>> +
>>> +	indio_dev = iio_allocate_device(sizeof *st);
>>> +	if (!indio_dev)
>>> +		return -ENOMEM;
>>> +
>>> +	st = iio_priv(indio_dev);
>>> +	st->read_reg_8  = lis331dlh_spi_read_reg_8;
>>> +	st->write_reg_8 = lis331dlh_spi_write_reg_8;
>>> +	st->read_reg_16 = lis331dlh_spi_read_reg_16;
>>> +	st->read_all	= lis331dlh_spi_read_all;
>>> +
>>> +	st->us = spi;
>>> +
>>> +	spi->mode = SPI_MODE_3;
>>> +	spi_setup(spi);
>>> +
>>> +	/* this is only used tor removal purposes */
>>> +	spi_set_drvdata(spi, indio_dev);
>>> +
>>> +	ret = lis331dlh_probe(indio_dev, &spi->dev);
>>> +	if (ret)
>>> +		goto error_free_st;
>>> +
>>> +	return 0;
>>> +
>>> +error_free_st:
>>> +	kfree(st);
>>> +	return ret;
>>> +}
>>> +
>>> +static int lis331dlh_spi_remove(struct spi_device *spi)
>>> +{
>>> +	struct iio_dev *indio_dev = spi_get_drvdata(spi);
>>> +	return lis331dlh_remove(indio_dev);
>>> +}
>>> +
>>> +static struct spi_driver lis331dlh_spi_driver = {
>>> +	.driver = {
>>> +		.name = "lis331dlh_spi",
>>> +		.owner = THIS_MODULE,
>>> +	},
>>> +	.probe = lis331dlh_spi_probe,
>>> +	.remove = __devexit_p(lis331dlh_spi_remove),
>>> +};
>>> +
>>> +static __init int lis331dlh_spi_module_init(void)
>>> +{
>>> +	return spi_register_driver(&lis331dlh_spi_driver);
>>> +}
>>> +
>>> +static __exit void lis331dlh_spi_module_exit(void)
>>> +{
>>> +	spi_unregister_driver(&lis331dlh_spi_driver);
>>> +}
>>> +
>>> +MODULE_AUTHOR("Manuel Stahl <manuel.stahl@iis.fraunhofer.de>");
>>> +MODULE_DESCRIPTION("ST LIS331DLH Accelerometer SPI driver");
>>> +MODULE_LICENSE("GPL v2");
>>> +
>>> +module_init(lis331dlh_spi_module_init);
>>> +module_exit(lis331dlh_spi_module_exit);
> 
> Thanks for the review. A new version will follow.
> 

