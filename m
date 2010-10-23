Return-Path: <jic23@cam.ac.uk>
Message-ID: <4CC3198C.7020505@cam.ac.uk>
Date: Sat, 23 Oct 2010 18:21:16 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: Mike Frysinger <vapier@gentoo.org>, linux-iio@vger.kernel.org,
 device-drivers-devel@blackfin.uclinux.org,
 Barry Song <barry.song@analog.com>
Subject: Re: [PATCH 1/3] staging: iio: new adis16201 driver
References: <1287830963-18377-1-git-send-email-vapier@gentoo.org> <4CC3158B.2000109@cam.ac.uk>
In-Reply-To: <4CC3158B.2000109@cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 10/23/10 18:04, Jonathan Cameron wrote:
> On 10/23/10 11:49, Mike Frysinger wrote:
>> From: Barry Song <barry.song@analog.com>
>>
> Hi Mike,
> 
>> IIO driver for dual Axis Accelerometer/inclinometer adis16201 parts.
> Couple of nitpicks in an otherwise excellent driver.  We can probably
> shorten it a fair bit using some of the recent helper function additions
> but that can happen post merge.
> 
> Anyhow, the nitpicks:
> * Capitalization is a bit random in the help message... 
> * Often the status check functions return isn't handled.  This means
> we print out a dev_err message, but then push data on up to userspace
> instad of an appropriate error message.
> * This does the same unnecessary abuse of the event infrastructure
> to handle the trigger as several other drivers.  That's a problem for
> another day and as it's common enough in tree, lets leave it be in this
> driver for now and fix this one along side the others.
> * The combine_8_to_16 never made sense for adis devices, but can be
> trivially ripped out in a follow up patch.  See the other drivers
> in mainline for which particular endian fixing function is needed...
> * Please run checkpatch over this, couple of obvious issues it will
> probably moan about.
> 
> So before sending to Greg, please do a checkpatch pass (I may be wrong
> and it might be fine for some reason).  The rest can easily occur
> after the event and as it might make the merge window if you send
> it to Greg KH quickly send it on asap!
> 
> Of course, if you have time to cleanup the various other things
> mentioned inline that would be great but even with them I'm happy
> to Ack.

I just noticed in reviewing your next driver in this series, that there
are missing elements that are obligatory in scan_elements attribute
group.  Please fix those before sending on (should be fairly trivial).
>>
>> Signed-off-by: Barry Song <barry.song@analog.com>
>> Signed-off-by: Mike Frysinger <vapier@gentoo.org>
> Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
> 
>> ---
>>  drivers/staging/iio/accel/Kconfig             |    9 +
>>  drivers/staging/iio/accel/Makefile            |    4 +
>>  drivers/staging/iio/accel/adis16201.h         |  150 ++++++
>>  drivers/staging/iio/accel/adis16201_core.c    |  640 +++++++++++++++++++++++++
>>  drivers/staging/iio/accel/adis16201_ring.c    |  260 ++++++++++
>>  drivers/staging/iio/accel/adis16201_trigger.c |  122 +++++
>>  6 files changed, 1185 insertions(+), 0 deletions(-)
>>  create mode 100644 drivers/staging/iio/accel/adis16201.h
>>  create mode 100644 drivers/staging/iio/accel/adis16201_core.c
>>  create mode 100644 drivers/staging/iio/accel/adis16201_ring.c
>>  create mode 100644 drivers/staging/iio/accel/adis16201_trigger.c
>>
>> diff --git a/drivers/staging/iio/accel/Kconfig b/drivers/staging/iio/accel/Kconfig
>> index 5926c03..0b87557 100644
>> --- a/drivers/staging/iio/accel/Kconfig
>> +++ b/drivers/staging/iio/accel/Kconfig
>> @@ -3,6 +3,15 @@
>>  #
>>  comment "Accelerometers"
>>  
>> +config ADIS16201
>> +	tristate "Analog Devices ADIS16201 Dual-Axis Digital Inclinometer and Accelerometer"
>> +	depends on SPI
>> +	select IIO_TRIGGER if IIO_RING_BUFFER
>> +	select IIO_SW_RING if IIO_RING_BUFFER
>> +	help
>> +	  Say yes here to build support for Analog Devices adis16201 dual-axis
>> +	  digital inclinometer and accelerometer.
>> +
>>  config ADIS16209
>>  	tristate "Analog Devices ADIS16209 Dual-Axis Digital Inclinometer and Accelerometer"
>>  	depends on SPI
>> diff --git a/drivers/staging/iio/accel/Makefile b/drivers/staging/iio/accel/Makefile
>> index ff84703..4a22a01 100644
>> --- a/drivers/staging/iio/accel/Makefile
>> +++ b/drivers/staging/iio/accel/Makefile
>> @@ -2,6 +2,10 @@
>>  # Makefile for industrial I/O accelerometer drivers
>>  #
>>  
>> +adis16201-y             := adis16201_core.o
>> +adis16201-$(CONFIG_IIO_RING_BUFFER) += adis16201_ring.o adis16201_trigger.o
>> +obj-$(CONFIG_ADIS16201) += adis16201.o
>> +
>>  adis16209-y             := adis16209_core.o
>>  adis16209-$(CONFIG_IIO_RING_BUFFER) += adis16209_ring.o adis16209_trigger.o
>>  obj-$(CONFIG_ADIS16209) += adis16209.o
>> diff --git a/drivers/staging/iio/accel/adis16201.h b/drivers/staging/iio/accel/adis16201.h
>> new file mode 100644
>> index 0000000..b739ea2
>> --- /dev/null
>> +++ b/drivers/staging/iio/accel/adis16201.h
>> @@ -0,0 +1,150 @@
>> +#ifndef SPI_ADIS16201_H_
>> +#define SPI_ADIS16201_H_
>> +
>> +#define ADIS16201_STARTUP_DELAY	220 /* ms */
>> +
>> +#define ADIS16201_READ_REG(a)    a
>> +#define ADIS16201_WRITE_REG(a) ((a) | 0x80)
>> +
>> +#define ADIS16201_FLASH_CNT      0x00 /* Flash memory write count */
>> +#define ADIS16201_SUPPLY_OUT     0x02 /* Output, power supply */
>> +#define ADIS16201_XACCL_OUT      0x04 /* Output, x-axis accelerometer */
>> +#define ADIS16201_YACCL_OUT      0x06 /* Output, y-axis accelerometer */
>> +#define ADIS16201_AUX_ADC        0x08 /* Output, auxiliary ADC input */
>> +#define ADIS16201_TEMP_OUT       0x0A /* Output, temperature */
>> +#define ADIS16201_XINCL_OUT      0x0C /* Output, x-axis inclination */
>> +#define ADIS16201_YINCL_OUT      0x0E /* Output, y-axis inclination */
>> +#define ADIS16201_XACCL_OFFS     0x10 /* Calibration, x-axis acceleration offset */
>> +#define ADIS16201_YACCL_OFFS     0x12 /* Calibration, y-axis acceleration offset */
>> +#define ADIS16201_XACCL_SCALE    0x14 /* x-axis acceleration scale factor */
>> +#define ADIS16201_YACCL_SCALE    0x16 /* y-axis acceleration scale factor */
>> +#define ADIS16201_XINCL_OFFS     0x18 /* Calibration, x-axis inclination offset */
>> +#define ADIS16201_YINCL_OFFS     0x1A /* Calibration, y-axis inclination offset */
>> +#define ADIS16201_XINCL_SCALE    0x1C /* x-axis inclination scale factor */
>> +#define ADIS16201_YINCL_SCALE    0x1E /* y-axis inclination scale factor */
>> +#define ADIS16201_ALM_MAG1       0x20 /* Alarm 1 amplitude threshold */
>> +#define ADIS16201_ALM_MAG2       0x22 /* Alarm 2 amplitude threshold */
>> +#define ADIS16201_ALM_SMPL1      0x24 /* Alarm 1, sample period */
>> +#define ADIS16201_ALM_SMPL2      0x26 /* Alarm 2, sample period */
>> +#define ADIS16201_ALM_CTRL       0x28 /* Alarm control */
>> +#define ADIS16201_AUX_DAC        0x30 /* Auxiliary DAC data */
>> +#define ADIS16201_GPIO_CTRL      0x32 /* General-purpose digital input/output control */
>> +#define ADIS16201_MSC_CTRL       0x34 /* Miscellaneous control */
>> +#define ADIS16201_SMPL_PRD       0x36 /* Internal sample period (rate) control */
>> +#define ADIS16201_AVG_CNT        0x38 /* Operation, filter configuration */
>> +#define ADIS16201_SLP_CNT        0x3A /* Operation, sleep mode control */
>> +#define ADIS16201_DIAG_STAT      0x3C /* Diagnostics, system status register */
>> +#define ADIS16201_GLOB_CMD       0x3E /* Operation, system command register */
>> +
>> +#define ADIS16201_OUTPUTS        7
>> +
>> +/* MSC_CTRL */
>> +#define ADIS16201_MSC_CTRL_SELF_TEST_EN	        (1 << 8)  /* Self-test enable */
>> +#define ADIS16201_MSC_CTRL_DATA_RDY_EN	        (1 << 2)  /* Data-ready enable: 1 = enabled, 0 = disabled */
>> +#define ADIS16201_MSC_CTRL_ACTIVE_HIGH	        (1 << 1)  /* Data-ready polarity: 1 = active high, 0 = active low */
>> +#define ADIS16201_MSC_CTRL_DATA_RDY_DIO1	(1 << 0)  /* Data-ready line selection: 1 = DIO1, 0 = DIO0 */
>> +
>> +/* DIAG_STAT */
>> +#define ADIS16201_DIAG_STAT_ALARM2        (1<<9) /* Alarm 2 status: 1 = alarm active, 0 = alarm inactive */
>> +#define ADIS16201_DIAG_STAT_ALARM1        (1<<8) /* Alarm 1 status: 1 = alarm active, 0 = alarm inactive */
>> +#define ADIS16201_DIAG_STAT_SPI_FAIL	  (1<<3) /* SPI communications failure */
>> +#define ADIS16201_DIAG_STAT_FLASH_UPT	  (1<<2) /* Flash update failure */
>> +#define ADIS16201_DIAG_STAT_POWER_HIGH	  (1<<1) /* Power supply above 3.625 V */
>> +#define ADIS16201_DIAG_STAT_POWER_LOW	  (1<<0) /* Power supply below 3.15 V */
>> +
>> +/* GLOB_CMD */
>> +#define ADIS16201_GLOB_CMD_SW_RESET	(1<<7)
>> +#define ADIS16201_GLOB_CMD_FACTORY_CAL	(1<<1)
>> +
>> +#define ADIS16201_MAX_TX 24
> This looks a bit big to me. Worst case is read_ring_data.  That looks to 
> use &st->tx[14] and the length is 2 so I'm guessing this only needs to be 16
> rather than 24 (probably a cut and paste value from another driver?)
> 
>> +#define ADIS16201_MAX_RX 24
> I think rx only goes up to 14 though please confirm that.
>> +
>> +#define ADIS16201_ERROR_ACTIVE          (1<<14)
>> +
>> +/**
>> + * struct adis16201_state - device instance specific data
>> + * @us:			actual spi_device
>> + * @work_trigger_to_ring: bh for triggered event handling
>> + * @inter:		used to check if new interrupt has been triggered
>> + * @last_timestamp:	passing timestamp from th to bh of interrupt handler
>> + * @indio_dev:		industrial I/O device structure
>> + * @trig:		data ready trigger registered with iio
>> + * @tx:			transmit buffer
>> + * @rx:			recieve buffer
>> + * @buf_lock:		mutex to protect tx and rx
>> + **/
>> +struct adis16201_state {
>> +	struct spi_device		*us;
>> +	struct work_struct		work_trigger_to_ring;
>> +	s64				last_timestamp;
>> +	struct iio_dev			*indio_dev;
>> +	struct iio_trigger		*trig;
>> +	u8				*tx;
>> +	u8				*rx;
>> +	struct mutex			buf_lock;
>> +};
>> +
>> +int adis16201_set_irq(struct device *dev, bool enable);
>> +
>> +#ifdef CONFIG_IIO_RING_BUFFER
>> +enum adis16201_scan {
>> +	ADIS16201_SCAN_SUPPLY,
>> +	ADIS16201_SCAN_ACC_X,
>> +	ADIS16201_SCAN_ACC_Y,
>> +	ADIS16201_SCAN_AUX_ADC,
>> +	ADIS16201_SCAN_TEMP,
>> +	ADIS16201_SCAN_INCLI_X,
>> +	ADIS16201_SCAN_INCLI_Y,
>> +};
>> +
>> +void adis16201_remove_trigger(struct iio_dev *indio_dev);
>> +int adis16201_probe_trigger(struct iio_dev *indio_dev);
>> +
>> +ssize_t adis16201_read_data_from_ring(struct device *dev,
>> +				      struct device_attribute *attr,
>> +				      char *buf);
>> +
>> +int adis16201_configure_ring(struct iio_dev *indio_dev);
>> +void adis16201_unconfigure_ring(struct iio_dev *indio_dev);
>> +
>> +int adis16201_initialize_ring(struct iio_ring_buffer *ring);
>> +void adis16201_uninitialize_ring(struct iio_ring_buffer *ring);
>> +#else /* CONFIG_IIO_RING_BUFFER */
>> +
>> +static inline void adis16201_remove_trigger(struct iio_dev *indio_dev)
>> +{
>> +}
>> +
>> +static inline int adis16201_probe_trigger(struct iio_dev *indio_dev)
>> +{
>> +	return 0;
>> +}
>> +
>> +static inline ssize_t
>> +adis16201_read_data_from_ring(struct device *dev,
>> +			      struct device_attribute *attr,
>> +			      char *buf)
>> +{
>> +	return 0;
>> +}
>> +
>> +static int adis16201_configure_ring(struct iio_dev *indio_dev)
>> +{
>> +	return 0;
>> +}
>> +
>> +static inline void adis16201_unconfigure_ring(struct iio_dev *indio_dev)
>> +{
>> +}
>> +
>> +static inline int adis16201_initialize_ring(struct iio_ring_buffer *ring)
>> +{
>> +	return 0;
>> +}
>> +
>> +static inline void adis16201_uninitialize_ring(struct iio_ring_buffer *ring)
>> +{
>> +}
>> +
>> +#endif /* CONFIG_IIO_RING_BUFFER */
>> +#endif /* SPI_ADIS16201_H_ */
>> diff --git a/drivers/staging/iio/accel/adis16201_core.c b/drivers/staging/iio/accel/adis16201_core.c
>> new file mode 100644
>> index 0000000..c2f85a5
>> --- /dev/null
>> +++ b/drivers/staging/iio/accel/adis16201_core.c
>> @@ -0,0 +1,640 @@
>> +/*
>> + * ADIS16201 Programmable Digital Vibration Sensor driver
>> + *
>> + * Copyright 2010 Analog Devices Inc.
>> + *
>> + * Licensed under the GPL-2 or later.
>> + */
>> +
>> +#include <linux/interrupt.h>
>> +#include <linux/irq.h>
>> +#include <linux/gpio.h>
>> +#include <linux/delay.h>
>> +#include <linux/mutex.h>
>> +#include <linux/device.h>
>> +#include <linux/kernel.h>
>> +#include <linux/spi/spi.h>
>> +#include <linux/slab.h>
>> +#include <linux/sysfs.h>
>> +#include <linux/list.h>
>> +
>> +#include "../iio.h"
>> +#include "../sysfs.h"
>> +#include "accel.h"
>> +#include "inclinometer.h"
>> +#include "../gyro/gyro.h"
>> +#include "../adc/adc.h"
>> +
>> +#include "adis16201.h"
>> +
>> +#define DRIVER_NAME		"adis16201"
>> +
>> +static int adis16201_check_status(struct device *dev);
>> +
>> +/**
>> + * adis16201_spi_write_reg_8() - write single byte to a register
>> + * @dev: device associated with child of actual device (iio_dev or iio_trig)
>> + * @reg_address: the address of the register to be written
>> + * @val: the value to write
>> + **/
>> +static int adis16201_spi_write_reg_8(struct device *dev,
>> +		u8 reg_address,
>> +		u8 val)
>> +{
>> +	int ret;
>> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>> +	struct adis16201_state *st = iio_dev_get_devdata(indio_dev);
>> +
>> +	mutex_lock(&st->buf_lock);
>> +	st->tx[0] = ADIS16201_WRITE_REG(reg_address);
>> +	st->tx[1] = val;
>> +
>> +	ret = spi_write(st->us, st->tx, 2);
>> +	mutex_unlock(&st->buf_lock);
>> +
>> +	return ret;
>> +}
>> +
>> +/**
>> + * adis16201_spi_write_reg_16() - write 2 bytes to a pair of registers
>> + * @dev: device associated with child of actual device (iio_dev or iio_trig)
>> + * @reg_address: the address of the lower of the two registers. Second register
>> + *               is assumed to have address one greater.
>> + * @val: value to be written
>> + **/
>> +static int adis16201_spi_write_reg_16(struct device *dev,
>> +		u8 lower_reg_address,
>> +		u16 value)
>> +{
>> +	int ret;
>> +	struct spi_message msg;
>> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>> +	struct adis16201_state *st = iio_dev_get_devdata(indio_dev);
>> +	struct spi_transfer xfers[] = {
>> +		{
>> +			.tx_buf = st->tx,
>> +			.bits_per_word = 8,
>> +			.len = 2,
>> +			.cs_change = 1,
>> +		}, {
>> +			.tx_buf = st->tx + 2,
>> +			.bits_per_word = 8,
>> +			.len = 2,
>> +			.cs_change = 1,
>> +		},
>> +	};
>> +
>> +	mutex_lock(&st->buf_lock);
>> +	st->tx[0] = ADIS16201_WRITE_REG(lower_reg_address);
>> +	st->tx[1] = value & 0xFF;
>> +	st->tx[2] = ADIS16201_WRITE_REG(lower_reg_address + 1);
>> +	st->tx[3] = (value >> 8) & 0xFF;
>> +
>> +	spi_message_init(&msg);
>> +	spi_message_add_tail(&xfers[0], &msg);
>> +	spi_message_add_tail(&xfers[1], &msg);
>> +	ret = spi_sync(st->us, &msg);
>> +	mutex_unlock(&st->buf_lock);
>> +
>> +	return ret;
>> +}
>> +
>> +/**
>> + * adis16201_spi_read_reg_16() - read 2 bytes from a 16-bit register
>> + * @dev: device associated with child of actual device (iio_dev or iio_trig)
>> + * @reg_address: the address of the lower of the two registers. Second register
>> + *               is assumed to have address one greater.
>> + * @val: somewhere to pass back the value read
>> + **/
>> +static int adis16201_spi_read_reg_16(struct device *dev,
>> +		u8 lower_reg_address,
>> +		u16 *val)
>> +{
>> +	struct spi_message msg;
>> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>> +	struct adis16201_state *st = iio_dev_get_devdata(indio_dev);
>> +	int ret;
>> +	struct spi_transfer xfers[] = {
>> +		{
>> +			.tx_buf = st->tx,
>> +			.bits_per_word = 8,
>> +			.len = 2,
>> +			.cs_change = 1,
>> +			.delay_usecs = 20,
>> +		}, {
>> +			.rx_buf = st->rx,
>> +			.bits_per_word = 8,
>> +			.len = 2,
>> +			.cs_change = 1,
>> +			.delay_usecs = 20,
>> +		},
>> +	};
>> +
>> +	mutex_lock(&st->buf_lock);
>> +	st->tx[0] = ADIS16201_READ_REG(lower_reg_address);
>> +	st->tx[1] = 0;
>> +
>> +	spi_message_init(&msg);
>> +	spi_message_add_tail(&xfers[0], &msg);
>> +	spi_message_add_tail(&xfers[1], &msg);
>> +	ret = spi_sync(st->us, &msg);
>> +	if (ret) {
>> +		dev_err(&st->us->dev, "problem when reading 16 bit register 0x%02X",
>> +				lower_reg_address);
>> +		goto error_ret;
>> +	}
>> +	*val = (st->rx[0] << 8) | st->rx[1];
>> +
>> +error_ret:
>> +	mutex_unlock(&st->buf_lock);
>> +	return ret;
>> +}
>> +
>> +static ssize_t adis16201_read_12bit_unsigned(struct device *dev,
>> +		struct device_attribute *attr,
>> +		char *buf)
>> +{
>> +	int ret;
>> +	u16 val = 0;
>> +	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>> +
>> +	ret = adis16201_spi_read_reg_16(dev, this_attr->address, &val);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (val & ADIS16201_ERROR_ACTIVE)
>> +		adis16201_check_status(dev);
>> +
>> +	return sprintf(buf, "%u\n", val & 0x0FFF);
>> +}
>> +
>> +static ssize_t adis16201_read_temp(struct device *dev,
>> +		struct device_attribute *attr,
>> +		char *buf)
>> +{
>> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>> +	ssize_t ret;
>> +	u16 val;
>> +
>> +	/* Take the iio_dev status lock */
>> +	mutex_lock(&indio_dev->mlock);
>> +
>> +	ret = adis16201_spi_read_reg_16(dev, ADIS16201_TEMP_OUT, (u16 *)&val);
>> +	if (ret)
>> +		goto error_ret;
>> +
>> +	if (val & ADIS16201_ERROR_ACTIVE)
>> +		adis16201_check_status(dev);
>> +
>> +	val &= 0xFFF;
>> +	ret = sprintf(buf, "%d\n", val);
>> +
>> +error_ret:
>> +	mutex_unlock(&indio_dev->mlock);
>> +	return ret;
>> +}
>> +
>> +static ssize_t adis16201_read_9bit_signed(struct device *dev,
>> +		struct device_attribute *attr,
>> +		char *buf)
>> +{
>> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>> +	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>> +	s16 val = 0;
>> +	ssize_t ret;
>> +
>> +	mutex_lock(&indio_dev->mlock);
>> +
>> +	ret = adis16201_spi_read_reg_16(dev, this_attr->address, (u16 *)&val);
>> +	if (!ret) {
>> +		if (val & ADIS16201_ERROR_ACTIVE)
>> +			adis16201_check_status(dev);
> Return val eaten.
>> +
>> +		val = ((s16)(val << 7) >> 7);
>> +		ret = sprintf(buf, "%d\n", val);
>> +	}
>> +
>> +	mutex_unlock(&indio_dev->mlock);
>> +
>> +	return ret;
>> +}
>> +
>> +static ssize_t adis16201_read_12bit_signed(struct device *dev,
>> +		struct device_attribute *attr,
>> +		char *buf)
>> +{
>> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>> +	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>> +	s16 val = 0;
>> +	ssize_t ret;
>> +
>> +	mutex_lock(&indio_dev->mlock);
>> +
>> +	ret = adis16201_spi_read_reg_16(dev, this_attr->address, (u16 *)&val);
>> +	if (!ret) {
>> +		if (val & ADIS16201_ERROR_ACTIVE)
>> +			adis16201_check_status(dev);
> Eating possibly useful return value?
>> +
>> +		val = ((s16)(val << 4) >> 4);
>> +		ret = sprintf(buf, "%d\n", val);
>> +	}
>> +
>> +	mutex_unlock(&indio_dev->mlock);
>> +
>> +	return ret;
>> +}
>> +
>> +static ssize_t adis16201_read_14bit_signed(struct device *dev,
>> +		struct device_attribute *attr,
>> +		char *buf)
>> +{
>> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>> +	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>> +	s16 val = 0;
>> +	ssize_t ret;
>> +
>> +	mutex_lock(&indio_dev->mlock);
>> +
>> +	ret = adis16201_spi_read_reg_16(dev, this_attr->address, (u16 *)&val);
>> +	if (!ret) {
>> +		if (val & ADIS16201_ERROR_ACTIVE)
>> +			adis16201_check_status(dev);
> Should be taking notice of the return value of check_status.
>> +
>> +		val = ((s16)(val << 2) >> 2);
>> +		ret = sprintf(buf, "%d\n", val);
>> +	}
>> +
>> +	mutex_unlock(&indio_dev->mlock);
>> +
>> +	return ret;
>> +}
>> +
>> +static ssize_t adis16201_write_16bit(struct device *dev,
>> +		struct device_attribute *attr,
>> +		const char *buf,
>> +		size_t len)
>> +{
>> +	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>> +	int ret;
>> +	long val;
>> +
>> +	ret = strict_strtol(buf, 10, &val);
>> +	if (ret)
>> +		goto error_ret;
>> +	ret = adis16201_spi_write_reg_16(dev, this_attr->address, val);
>> +
>> +error_ret:
>> +	return ret ? ret : len;
>> +}
>> +
>> +static int adis16201_reset(struct device *dev)
>> +{
>> +	int ret;
>> +	ret = adis16201_spi_write_reg_8(dev,
>> +			ADIS16201_GLOB_CMD,
>> +			ADIS16201_GLOB_CMD_SW_RESET);
>> +	if (ret)
>> +		dev_err(dev, "problem resetting device");
>> +
>> +	return ret;
>> +}
>> +
>> +static ssize_t adis16201_write_reset(struct device *dev,
>> +		struct device_attribute *attr,
>> +		const char *buf, size_t len)
>> +{
>> +	if (len < 1)
>> +		return -EINVAL;
>> +	switch (buf[0]) {
>> +	case '1':
>> +	case 'y':
>> +	case 'Y':
>> +		return adis16201_reset(dev);
>> +	}
>> +	return -EINVAL;
>> +}
>> +
>> +int adis16201_set_irq(struct device *dev, bool enable)
>> +{
>> +	int ret = 0;
>> +	u16 msc;
>> +
>> +	ret = adis16201_spi_read_reg_16(dev, ADIS16201_MSC_CTRL, &msc);
>> +	if (ret)
>> +		goto error_ret;
>> +
> Ideally these should probably be controlled by some platform data, but
> as ever that can be added by whoever needs it.
>> +	msc |= ADIS16201_MSC_CTRL_ACTIVE_HIGH;
>> +	msc &= ~ADIS16201_MSC_CTRL_DATA_RDY_DIO1;
>> +	if (enable)
>> +		msc |= ADIS16201_MSC_CTRL_DATA_RDY_EN;
>> +	else
>> +		msc &= ~ADIS16201_MSC_CTRL_DATA_RDY_EN;
>> +
>> +	ret = adis16201_spi_write_reg_16(dev, ADIS16201_MSC_CTRL, msc);
>> +
>> +error_ret:
>> +	return ret;
>> +}
>> +
>> +static int adis16201_check_status(struct device *dev)
>> +{
>> +	u16 status;
>> +	int ret;
>> +
>> +	ret = adis16201_spi_read_reg_16(dev, ADIS16201_DIAG_STAT, &status);
>> +	if (ret < 0) {
>> +		dev_err(dev, "Reading status failed\n");
>> +		goto error_ret;
>> +	}
>> +	ret = status & 0xF;
>> +
>> +	if (status & ADIS16201_DIAG_STAT_SPI_FAIL)
>> +		dev_err(dev, "SPI failure\n");
>> +	if (status & ADIS16201_DIAG_STAT_FLASH_UPT)
>> +		dev_err(dev, "Flash update failed\n");
>> +	if (status & ADIS16201_DIAG_STAT_POWER_HIGH)
>> +		dev_err(dev, "Power supply above 3.625V\n");
>> +	if (status & ADIS16201_DIAG_STAT_POWER_LOW)
>> +		dev_err(dev, "Power supply below 3.15V\n");
>> +
>> +error_ret:
>> +	return ret;
>> +}
>> +
>> +static int adis16201_self_test(struct device *dev)
>> +{
>> +	int ret;
>> +	ret = adis16201_spi_write_reg_16(dev,
>> +			ADIS16201_MSC_CTRL,
>> +			ADIS16201_MSC_CTRL_SELF_TEST_EN);
>> +	if (ret) {
>> +		dev_err(dev, "problem starting self test");
>> +		goto err_ret;
>> +	}
>> +
>> +	adis16201_check_status(dev);
> again I'd like to see any errors from this passed on.
>> +
>> +err_ret:
>> +	return ret;
>> +}
>> +
>> +static int adis16201_initial_setup(struct adis16201_state *st)
>> +{
>> +	int ret;
>> +	struct device *dev = &st->indio_dev->dev;
>> +
>> +	/* Disable IRQ */
>> +	ret = adis16201_set_irq(dev, false);
>> +	if (ret) {
>> +		dev_err(dev, "disable irq failed");
>> +		goto err_ret;
>> +	}
>> +
>> +	/* Do self test */
>> +	ret = adis16201_self_test(dev);
>> +	if (ret) {
>> +		dev_err(dev, "self test failure");
>> +		goto err_ret;
>> +	}
>> +
>> +	/* Read status register to check the result */
>> +	ret = adis16201_check_status(dev);
>> +	if (ret) {
>> +		adis16201_reset(dev);
>> +		dev_err(dev, "device not playing ball -> reset");
>> +		msleep(ADIS16201_STARTUP_DELAY);
>> +		ret = adis16201_check_status(dev);
>> +		if (ret) {
>> +			dev_err(dev, "giving up");
>> +			goto err_ret;
>> +		}
>> +	}
>> +
>> +	printk(KERN_INFO DRIVER_NAME ": at CS%d (irq %d)\n",
>> +			st->us->chip_select, st->us->irq);
>> +
>> +err_ret:
>> +	return ret;
>> +}
>> +
>> +static IIO_DEV_ATTR_IN_NAMED_RAW(supply, adis16201_read_12bit_unsigned,
>> +		ADIS16201_SUPPLY_OUT);
>> +static IIO_CONST_ATTR(in_supply_scale, "0.00122");
>> +static IIO_DEV_ATTR_IN_RAW(0, adis16201_read_12bit_unsigned,
>> +		ADIS16201_AUX_ADC);
>> +static IIO_CONST_ATTR(in0_scale, "0.00061");
>> +
>> +static IIO_DEV_ATTR_ACCEL_X(adis16201_read_14bit_signed,
>> +		ADIS16201_XACCL_OUT);
>> +static IIO_DEV_ATTR_ACCEL_Y(adis16201_read_14bit_signed,
>> +		ADIS16201_YACCL_OUT);
>> +static IIO_DEV_ATTR_ACCEL_X_OFFSET(S_IWUSR | S_IRUGO,
>> +		adis16201_read_12bit_signed,
>> +		adis16201_write_16bit,
>> +		ADIS16201_XACCL_OFFS);
>> +static IIO_DEV_ATTR_ACCEL_Y_OFFSET(S_IWUSR | S_IRUGO,
>> +		adis16201_read_12bit_signed,
>> +		adis16201_write_16bit,
>> +		ADIS16201_YACCL_OFFS);
>> +static IIO_CONST_ATTR(accel_scale, "0.4625");
>> +
>> +static IIO_DEV_ATTR_INCLI_X(adis16201_read_14bit_signed,
>> +		ADIS16201_XINCL_OUT);
>> +static IIO_DEV_ATTR_INCLI_Y(adis16201_read_14bit_signed,
>> +		ADIS16201_YINCL_OUT);
>> +static IIO_DEV_ATTR_INCLI_X_OFFSET(S_IWUSR | S_IRUGO,
>> +		adis16201_read_9bit_signed,
>> +		adis16201_write_16bit,
>> +		ADIS16201_XACCL_OFFS);
>> +static IIO_DEV_ATTR_INCLI_Y_OFFSET(S_IWUSR | S_IRUGO,
>> +		adis16201_read_9bit_signed,
>> +		adis16201_write_16bit,
>> +		ADIS16201_YACCL_OFFS);
>> +static IIO_CONST_ATTR(incli_scale, "0.1");
>> +
>> +static IIO_DEV_ATTR_TEMP(adis16201_read_temp);
>> +static IIO_CONST_ATTR(temp_offset, "25");
>> +static IIO_CONST_ATTR(temp_scale, "-0.47");
>> +
>> +static IIO_DEVICE_ATTR(reset, S_IWUSR, NULL, adis16201_write_reset, 0);
>> +
>> +static IIO_CONST_ATTR(name, "adis16201");
>> +
> 
> This is always a bad sign.  If there are no event attribute then we
> shouldn't be using the event infrastructure at all.  This one snuck
> into some of Analog's drivers a while back.  I'll clean them all out
> once we have ironed out some problems with the adis16350 mass merge
> of drivers (that may or may not be connnected to the replacement of
> this form of code!).
> 
> Still, not great to see it again, but it does work so lets leave it
> here for now.
>> +static struct attribute *adis16201_event_attributes[] = {
>> +	NULL
>> +};
>> +
>> +static struct attribute_group adis16201_event_attribute_group = {
>> +	.attrs = adis16201_event_attributes,
>> +};
>> +
>> +static struct attribute *adis16201_attributes[] = {
>> +	&iio_dev_attr_in_supply_raw.dev_attr.attr,
>> +	&iio_const_attr_in_supply_scale.dev_attr.attr,
>> +	&iio_dev_attr_temp.dev_attr.attr,
>> +	&iio_const_attr_temp_offset.dev_attr.attr,
>> +	&iio_const_attr_temp_scale.dev_attr.attr,
>> +	&iio_dev_attr_reset.dev_attr.attr,
>> +	&iio_const_attr_name.dev_attr.attr,
>> +	&iio_dev_attr_in0_raw.dev_attr.attr,
>> +	&iio_const_attr_in0_scale.dev_attr.attr,
>> +	&iio_dev_attr_accel_x_raw.dev_attr.attr,
>> +	&iio_dev_attr_accel_y_raw.dev_attr.attr,
>> +	&iio_dev_attr_accel_x_offset.dev_attr.attr,
>> +	&iio_dev_attr_accel_y_offset.dev_attr.attr,
>> +	&iio_const_attr_accel_scale.dev_attr.attr,
>> +	&iio_dev_attr_incli_x_raw.dev_attr.attr,
>> +	&iio_dev_attr_incli_y_raw.dev_attr.attr,
>> +	&iio_dev_attr_incli_x_offset.dev_attr.attr,
>> +	&iio_dev_attr_incli_y_offset.dev_attr.attr,
>> +	&iio_const_attr_incli_scale.dev_attr.attr,
>> +	NULL
>> +};
>> +
>> +static const struct attribute_group adis16201_attribute_group = {
>> +	.attrs = adis16201_attributes,
>> +};
>> +
>> +static int __devinit adis16201_probe(struct spi_device *spi)
>> +{
>> +	int ret, regdone = 0;
>> +	struct adis16201_state *st = kzalloc(sizeof *st, GFP_KERNEL);
>> +	if (!st) {
>> +		ret =  -ENOMEM;
>> +		goto error_ret;
>> +	}
>> +	/* this is only used for removal purposes */
>> +	spi_set_drvdata(spi, st);
>> +
>> +	/* Allocate the comms buffers */
>> +	st->rx = kzalloc(sizeof(*st->rx)*ADIS16201_MAX_RX, GFP_KERNEL);
>> +	if (st->rx == NULL) {
>> +		ret = -ENOMEM;
>> +		goto error_free_st;
>> +	}
>> +	st->tx = kzalloc(sizeof(*st->tx)*ADIS16201_MAX_TX, GFP_KERNEL);
>> +	if (st->tx == NULL) {
>> +		ret = -ENOMEM;
>> +		goto error_free_rx;
>> +	}
>> +	st->us = spi;
>> +	mutex_init(&st->buf_lock);
>> +	/* setup the industrialio driver allocated elements */
>> +	st->indio_dev = iio_allocate_device();
>> +	if (st->indio_dev == NULL) {
>> +		ret = -ENOMEM;
>> +		goto error_free_tx;
>> +	}
>> +
>> +	st->indio_dev->dev.parent = &spi->dev;
>> +	st->indio_dev->num_interrupt_lines = 1;
>> +	st->indio_dev->event_attrs = &adis16201_event_attribute_group;
>> +	st->indio_dev->attrs = &adis16201_attribute_group;
>> +	st->indio_dev->dev_data = (void *)(st);
>> +	st->indio_dev->driver_module = THIS_MODULE;
>> +	st->indio_dev->modes = INDIO_DIRECT_MODE;
>> +
>> +	ret = adis16201_configure_ring(st->indio_dev);
>> +	if (ret)
>> +		goto error_free_dev;
>> +
>> +	ret = iio_device_register(st->indio_dev);
>> +	if (ret)
>> +		goto error_unreg_ring_funcs;
>> +	regdone = 1;
>> +
>> +	ret = adis16201_initialize_ring(st->indio_dev->ring);
>> +	if (ret) {
>> +		printk(KERN_ERR "failed to initialize the ring\n");
>> +		goto error_unreg_ring_funcs;
>> +	}
>> +
>> +	if (spi->irq) {
>> +		ret = iio_register_interrupt_line(spi->irq,
>> +				st->indio_dev,
>> +				0,
>> +				IRQF_TRIGGER_RISING,
>> +				"adis16201");
>> +		if (ret)
>> +			goto error_uninitialize_ring;
>> +
>> +		ret = adis16201_probe_trigger(st->indio_dev);
>> +		if (ret)
>> +			goto error_unregister_line;
>> +	}
>> +
>> +	/* Get the device into a sane initial state */
>> +	ret = adis16201_initial_setup(st);
>> +	if (ret)
>> +		goto error_remove_trigger;
>> +	return 0;
>> +
>> +error_remove_trigger:
>> +	adis16201_remove_trigger(st->indio_dev);
>> +error_unregister_line:
>> +	if (spi->irq)
>> +		iio_unregister_interrupt_line(st->indio_dev, 0);
>> +error_uninitialize_ring:
>> +	adis16201_uninitialize_ring(st->indio_dev->ring);
>> +error_unreg_ring_funcs:
>> +	adis16201_unconfigure_ring(st->indio_dev);
>> +error_free_dev:
>> +	if (regdone)
>> +		iio_device_unregister(st->indio_dev);
>> +	else
>> +		iio_free_device(st->indio_dev);
>> +error_free_tx:
>> +	kfree(st->tx);
>> +error_free_rx:
>> +	kfree(st->rx);
>> +error_free_st:
>> +	kfree(st);
>> +error_ret:
>> +	return ret;
>> +}
>> +
>> +static int adis16201_remove(struct spi_device *spi)
>> +{
>> +	struct adis16201_state *st = spi_get_drvdata(spi);
>> +	struct iio_dev *indio_dev = st->indio_dev;
>> +
>> +	flush_scheduled_work();
>> +
>> +	adis16201_remove_trigger(indio_dev);
>> +	if (spi->irq)
>> +		iio_unregister_interrupt_line(indio_dev, 0);
>> +
>> +	adis16201_uninitialize_ring(indio_dev->ring);
>> +	iio_device_unregister(indio_dev);
>> +	adis16201_unconfigure_ring(indio_dev);
>> +	kfree(st->tx);
>> +	kfree(st->rx);
>> +	kfree(st);
>> +
>> +	return 0;
>> +}
>> +
>> +static struct spi_driver adis16201_driver = {
>> +	.driver = {
>> +		.name = "adis16201",
>> +		.owner = THIS_MODULE,
>> +	},
>> +	.probe = adis16201_probe,
>> +	.remove = __devexit_p(adis16201_remove),
>> +};
>> +
>> +static __init int adis16201_init(void)
>> +{
>> +	return spi_register_driver(&adis16201_driver);
>> +}
>> +module_init(adis16201_init);
>> +
>> +static __exit void adis16201_exit(void)
>> +{
>> +	spi_unregister_driver(&adis16201_driver);
>> +}
>> +module_exit(adis16201_exit);
>> +
>> +MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
>> +MODULE_DESCRIPTION("Analog Devices ADIS16201 Programmable Digital Vibration Sensor driver");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/drivers/staging/iio/accel/adis16201_ring.c b/drivers/staging/iio/accel/adis16201_ring.c
>> new file mode 100644
>> index 0000000..83fee28
>> --- /dev/null
>> +++ b/drivers/staging/iio/accel/adis16201_ring.c
>> @@ -0,0 +1,260 @@
>> +#include <linux/interrupt.h>
>> +#include <linux/irq.h>
>> +#include <linux/gpio.h>
>> +#include <linux/workqueue.h>
>> +#include <linux/mutex.h>
>> +#include <linux/device.h>
>> +#include <linux/kernel.h>
>> +#include <linux/spi/spi.h>
>> +#include <linux/slab.h>
>> +#include <linux/sysfs.h>
>> +#include <linux/list.h>
>> +
>> +#include "../iio.h"
>> +#include "../sysfs.h"
>> +#include "../ring_sw.h"
>> +#include "accel.h"
>> +#include "../trigger.h"
>> +#include "adis16201.h"
>> +
>> +/**
>> + * combine_8_to_16() utility function to munge to u8s into u16
>> + **/
>> +static inline u16 combine_8_to_16(u8 lower, u8 upper)
>> +{
>> +	u16 _lower = lower;
>> +	u16 _upper = upper;
>> +	return _lower | (_upper << 8);
>> +}
> This is a hangover from Barry copying the lis3l02dq driver (where this
> sort of function made sense). Needs replacing with a generic endian
> fiddling alternative.  We can do that as a follow up patch.
>> +
>> +static IIO_SCAN_EL_C(supply, ADIS16201_SCAN_SUPPLY, IIO_UNSIGNED(12),
>> +		     ADIS16201_SUPPLY_OUT, NULL);
>> +static IIO_SCAN_EL_C(accel_x, ADIS16201_SCAN_ACC_X, IIO_SIGNED(14),
>> +		     ADIS16201_XACCL_OUT, NULL);
>> +static IIO_SCAN_EL_C(accel_y, ADIS16201_SCAN_ACC_Y, IIO_SIGNED(14),
>> +		     ADIS16201_YACCL_OUT, NULL);
>> +static IIO_SCAN_EL_C(aux_adc, ADIS16201_SCAN_AUX_ADC, IIO_UNSIGNED(12),
>> +		     ADIS16201_AUX_ADC, NULL);
>> +static IIO_SCAN_EL_C(temp, ADIS16201_SCAN_TEMP, IIO_UNSIGNED(12),
>> +		     ADIS16201_TEMP_OUT, NULL);
>> +static IIO_SCAN_EL_C(incli_x, ADIS16201_SCAN_INCLI_X, IIO_SIGNED(14),
>> +		     ADIS16201_XINCL_OUT, NULL);
>> +static IIO_SCAN_EL_C(incli_y, ADIS16201_SCAN_INCLI_Y, IIO_SIGNED(14),
>> +		     ADIS16201_YINCL_OUT, NULL);
>> +
>> +static IIO_SCAN_EL_TIMESTAMP(7);
>> +
>> +static struct attribute *adis16201_scan_el_attrs[] = {
>> +	&iio_scan_el_supply.dev_attr.attr,
>> +	&iio_scan_el_accel_x.dev_attr.attr,
>> +	&iio_scan_el_accel_y.dev_attr.attr,
>> +	&iio_scan_el_aux_adc.dev_attr.attr,
>> +	&iio_scan_el_temp.dev_attr.attr,
>> +	&iio_scan_el_incli_x.dev_attr.attr,
>> +	&iio_scan_el_incli_y.dev_attr.attr,
>> +	&iio_scan_el_timestamp.dev_attr.attr,
>> +	NULL,
>> +};
>> +
>> +static struct attribute_group adis16201_scan_el_group = {
>> +	.attrs = adis16201_scan_el_attrs,
>> +	.name = "scan_elements",
>> +};
>> +
>> +/**
>> + * adis16201_poll_func_th() top half interrupt handler called by trigger
>> + * @private_data:	iio_dev
>> + **/
>> +static void adis16201_poll_func_th(struct iio_dev *indio_dev, s64 time)
>> +{
>> +	struct adis16201_state *st = iio_dev_get_devdata(indio_dev);
>> +	st->last_timestamp = time;
>> +	schedule_work(&st->work_trigger_to_ring);
>> +}
>> +
>> +/**
>> + * adis16201_read_ring_data() read data registers which will be placed into ring
>> + * @dev: device associated with child of actual device (iio_dev or iio_trig)
>> + * @rx: somewhere to pass back the value read
>> + **/
>> +static int adis16201_read_ring_data(struct device *dev, u8 *rx)
>> +{
>> +	struct spi_message msg;
>> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>> +	struct adis16201_state *st = iio_dev_get_devdata(indio_dev);
>> +	struct spi_transfer xfers[ADIS16201_OUTPUTS + 1];
>> +	int ret;
>> +	int i;
>> +
>> +	mutex_lock(&st->buf_lock);
>> +
>> +	spi_message_init(&msg);
>> +
>> +	memset(xfers, 0, sizeof(xfers));
>> +	for (i = 0; i <= ADIS16201_OUTPUTS; i++) {
>> +		xfers[i].bits_per_word = 8;
>> +		xfers[i].cs_change = 1;
>> +		xfers[i].len = 2;
>> +		xfers[i].delay_usecs = 20;
>> +		xfers[i].tx_buf = st->tx + 2 * i;
>> +		st->tx[2 * i] = ADIS16201_READ_REG(ADIS16201_SUPPLY_OUT + 2 * i);
>> +		st->tx[2 * i + 1] = 0;
>> +		if (i >= 1)
>> +			xfers[i].rx_buf = rx + 2 * (i - 1);
>> +		spi_message_add_tail(&xfers[i], &msg);
>> +	}
> Might be nice to play some caching games here, but that's true of
> most of the drivers in the tree so definitely a job for another day!
>> +
>> +	ret = spi_sync(st->us, &msg);
>> +	if (ret)
>> +		dev_err(&st->us->dev, "problem when burst reading");
>> +
>> +	mutex_unlock(&st->buf_lock);
>> +
>> +	return ret;
>> +}
>> +
>> +/* Whilst this makes a lot of calls to iio_sw_ring functions - it is to device
>> + * specific to be rolled into the core.
>> + */
>> +static void adis16201_trigger_bh_to_ring(struct work_struct *work_s)
>> +{
>> +	struct adis16201_state *st
>> +		= container_of(work_s, struct adis16201_state,
>> +			       work_trigger_to_ring);
>> +
>> +	int i = 0;
>> +	s16 *data;
>> +	size_t datasize = st->indio_dev
>> +		->ring->access.get_bpd(st->indio_dev->ring);
>> +
>> +	data = kmalloc(datasize , GFP_KERNEL);
>> +	if (data == NULL) {
>> +		dev_err(&st->us->dev, "memory alloc failed in ring bh");
>> +		return;
>> +	}
>> +
>> +	if (st->indio_dev->scan_count)
>> +		if (adis16201_read_ring_data(&st->indio_dev->dev, st->rx) >= 0)
>> +			for (; i < st->indio_dev->scan_count; i++) {
>> +				data[i] = combine_8_to_16(st->rx[i*2+1],
>> +							  st->rx[i*2]);
>> +			}
> Unwanted brackets around the statement above.  Would have thorught checkpatch
> would moan about that.
>> +
>> +	/* Guaranteed to be aligned with 8 byte boundary */
>> +	if (st->indio_dev->scan_timestamp)
>> +		*((s64 *)(data + ((i + 3)/4)*4)) = st->last_timestamp;
>> +
>> +	st->indio_dev->ring->access.store_to(st->indio_dev->ring,
>> +					    (u8 *)data,
>> +					    st->last_timestamp);
>> +
>> +	iio_trigger_notify_done(st->indio_dev->trig);
>> +	kfree(data);
>> +
>> +	return;
>> +}
>> +
>> +/* in these circumstances is it better to go with unaligned packing and
>> + * deal with the cost?*/
>> +static int adis16201_data_rdy_ring_preenable(struct iio_dev *indio_dev)
>> +{
>> +	size_t size;
>> +	dev_dbg(&indio_dev->dev, "%s\n", __func__);
>> +	/* Check if there are any scan elements enabled, if not fail*/
>> +	if (!(indio_dev->scan_count || indio_dev->scan_timestamp))
>> +		return -EINVAL;
>> +
>> +	if (indio_dev->ring->access.set_bpd) {
>> +		if (indio_dev->scan_timestamp)
>> +			if (indio_dev->scan_count)
>> +				/* Timestamp and data, let timestamp aligned with sizeof(s64) */
> That's looks rather a long line.  Guessing checkpatch moans?
>> +				size = (((indio_dev->scan_count * sizeof(s16)) + sizeof(s64) - 1) & ~(sizeof(s64) - 1))
>> +					+ sizeof(s64);
>> +			else /* Timestamp only  */
>> +				size = sizeof(s64);
>> +		else /* Data only */
>> +			size = indio_dev->scan_count*sizeof(s16);
>> +		indio_dev->ring->access.set_bpd(indio_dev->ring, size);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
> These can all be replaced with the generic calls, but that can trivially occur
> as a follow up patch (we did it for all the in tree drivers a while back).
>> +static int adis16201_data_rdy_ring_postenable(struct iio_dev *indio_dev)
>> +{
>> +	return indio_dev->trig
>> +		? iio_trigger_attach_poll_func(indio_dev->trig,
>> +					       indio_dev->pollfunc)
>> +		: 0;
>> +}
>> +
>> +static int adis16201_data_rdy_ring_predisable(struct iio_dev *indio_dev)
>> +{
>> +	return indio_dev->trig
>> +		? iio_trigger_dettach_poll_func(indio_dev->trig,
>> +						indio_dev->pollfunc)
>> +		: 0;
>> +}
>> +
>> +void adis16201_unconfigure_ring(struct iio_dev *indio_dev)
>> +{
>> +	kfree(indio_dev->pollfunc);
>> +	iio_sw_rb_free(indio_dev->ring);
>> +}
>> +
>> +int adis16201_configure_ring(struct iio_dev *indio_dev)
>> +{
>> +	int ret = 0;
>> +	struct adis16201_state *st = indio_dev->dev_data;
>> +	struct iio_ring_buffer *ring;
>> +	INIT_WORK(&st->work_trigger_to_ring, adis16201_trigger_bh_to_ring);
>> +	/* Set default scan mode */
>> +
>> +	iio_scan_mask_set(indio_dev, iio_scan_el_supply.number);
>> +	iio_scan_mask_set(indio_dev, iio_scan_el_accel_x.number);
>> +	iio_scan_mask_set(indio_dev, iio_scan_el_accel_y.number);
>> +	iio_scan_mask_set(indio_dev, iio_scan_el_temp.number);
>> +	iio_scan_mask_set(indio_dev, iio_scan_el_aux_adc.number);
>> +	iio_scan_mask_set(indio_dev, iio_scan_el_incli_x.number);
>> +	iio_scan_mask_set(indio_dev, iio_scan_el_incli_y.number);
>> +	indio_dev->scan_timestamp = true;
>> +
>> +	indio_dev->scan_el_attrs = &adis16201_scan_el_group;
>> +
>> +	ring = iio_sw_rb_allocate(indio_dev);
>> +	if (!ring) {
>> +		ret = -ENOMEM;
>> +		return ret;
>> +	}
>> +	indio_dev->ring = ring;
>> +	/* Effectively select the ring buffer implementation */
>> +	iio_ring_sw_register_funcs(&ring->access);
>> +	ring->preenable = &adis16201_data_rdy_ring_preenable;
>> +	ring->postenable = &adis16201_data_rdy_ring_postenable;
>> +	ring->predisable = &adis16201_data_rdy_ring_predisable;
>> +	ring->owner = THIS_MODULE;
>> +
>> +	indio_dev->pollfunc = kzalloc(sizeof(*indio_dev->pollfunc), GFP_KERNEL);
>> +	if (indio_dev->pollfunc == NULL) {
>> +		ret = -ENOMEM;
>> +		goto error_iio_sw_rb_free;;
>> +	}
>> +	indio_dev->pollfunc->poll_func_main = &adis16201_poll_func_th;
>> +	indio_dev->pollfunc->private_data = indio_dev;
>> +	indio_dev->modes |= INDIO_RING_TRIGGERED;
>> +	return 0;
>> +
>> +error_iio_sw_rb_free:
>> +	iio_sw_rb_free(indio_dev->ring);
>> +	return ret;
>> +}
>> +
> 
> Nothing wrong with this driver, but this makes it pretty obvious that stubbs
> for iio_ring_buffer_register in the core would save us a few pointless functions
> in the case where we don't have ring support.   One for the todo list.
>> +int adis16201_initialize_ring(struct iio_ring_buffer *ring)
>> +{
>> +	return iio_ring_buffer_register(ring, 0);
>> +}
>> +
>> +void adis16201_uninitialize_ring(struct iio_ring_buffer *ring)
>> +{
>> +	iio_ring_buffer_unregister(ring);
>> +}
>> diff --git a/drivers/staging/iio/accel/adis16201_trigger.c b/drivers/staging/iio/accel/adis16201_trigger.c
>> new file mode 100644
>> index 0000000..8a9cea19
>> --- /dev/null
>> +++ b/drivers/staging/iio/accel/adis16201_trigger.c
>> @@ -0,0 +1,122 @@
>> +#include <linux/interrupt.h>
>> +#include <linux/irq.h>
>> +#include <linux/mutex.h>
>> +#include <linux/device.h>
>> +#include <linux/kernel.h>
>> +#include <linux/sysfs.h>
>> +#include <linux/list.h>
>> +#include <linux/spi/spi.h>
>> +
>> +#include "../iio.h"
>> +#include "../sysfs.h"
>> +#include "../trigger.h"
>> +#include "adis16201.h"
>> +
> As stated above this should really directly setup and handle the interrupt
> itself rather than using the events infrastructure.  We can easily do that
> at a later date.
>> +/**
>> + * adis16201_data_rdy_trig_poll() the event handler for the data rdy trig
>> + **/
>> +static int adis16201_data_rdy_trig_poll(struct iio_dev *dev_info,
>> +				       int index,
>> +				       s64 timestamp,
>> +				       int no_test)
>> +{
>> +	struct adis16201_state *st = iio_dev_get_devdata(dev_info);
>> +	struct iio_trigger *trig = st->trig;
>> +
>> +	iio_trigger_poll(trig, timestamp);
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +IIO_EVENT_SH(data_rdy_trig, &adis16201_data_rdy_trig_poll);
>> +
>> +static DEVICE_ATTR(name, S_IRUGO, iio_trigger_read_name, NULL);
>> +
>> +static struct attribute *adis16201_trigger_attrs[] = {
>> +	&dev_attr_name.attr,
>> +	NULL,
>> +};
>> +
>> +static const struct attribute_group adis16201_trigger_attr_group = {
>> +	.attrs = adis16201_trigger_attrs,
>> +};
>> +
>> +/**
>> + * adis16201_data_rdy_trigger_set_state() set datardy interrupt state
>> + **/
>> +static int adis16201_data_rdy_trigger_set_state(struct iio_trigger *trig,
>> +						bool state)
>> +{
>> +	struct adis16201_state *st = trig->private_data;
>> +	struct iio_dev *indio_dev = st->indio_dev;
>> +	int ret = 0;
>> +
>> +	dev_dbg(&indio_dev->dev, "%s (%d)\n", __func__, state);
>> +	ret = adis16201_set_irq(&st->indio_dev->dev, state);
>> +	if (state == false) {
>> +		iio_remove_event_from_list(&iio_event_data_rdy_trig,
>> +					   &indio_dev->interrupts[0]
>> +					   ->ev_list);
>> +		flush_scheduled_work();
>> +	} else {
>> +		iio_add_event_to_list(&iio_event_data_rdy_trig,
>> +				      &indio_dev->interrupts[0]->ev_list);
>> +	}
>> +	return ret;
>> +}
>> +
>> +/**
>> + * adis16201_trig_try_reen() try renabling irq for data rdy trigger
>> + * @trig:	the datardy trigger
>> + **/
>> +static int adis16201_trig_try_reen(struct iio_trigger *trig)
>> +{
>> +	struct adis16201_state *st = trig->private_data;
>> +	enable_irq(st->us->irq);
>> +	return 0;
>> +}
>> +
>> +int adis16201_probe_trigger(struct iio_dev *indio_dev)
>> +{
>> +	int ret;
>> +	struct adis16201_state *st = indio_dev->dev_data;
>> +
>> +	st->trig = iio_allocate_trigger();
>> +	st->trig->name = kasprintf(GFP_KERNEL,
>> +				"adis16201-dev%d",
>> +				indio_dev->id);
>> +	if (!st->trig->name) {
>> +		ret = -ENOMEM;
>> +		goto error_free_trig;
>> +	}
>> +	st->trig->dev.parent = &st->us->dev;
>> +	st->trig->owner = THIS_MODULE;
>> +	st->trig->private_data = st;
>> +	st->trig->set_trigger_state = &adis16201_data_rdy_trigger_set_state;
>> +	st->trig->try_reenable = &adis16201_trig_try_reen;
>> +	st->trig->control_attrs = &adis16201_trigger_attr_group;
>> +	ret = iio_trigger_register(st->trig);
>> +
>> +	/* select default trigger */
>> +	indio_dev->trig = st->trig;
>> +	if (ret)
>> +		goto error_free_trig_name;
>> +
>> +	return 0;
>> +
>> +error_free_trig_name:
>> +	kfree(st->trig->name);
>> +error_free_trig:
>> +	iio_free_trigger(st->trig);
>> +
>> +	return ret;
>> +}
>> +
>> +void adis16201_remove_trigger(struct iio_dev *indio_dev)
>> +{
>> +	struct adis16201_state *state = indio_dev->dev_data;
>> +
>> +	iio_trigger_unregister(state->trig);
>> +	kfree(state->trig->name);
>> +	iio_free_trigger(state->trig);
>> +}
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
