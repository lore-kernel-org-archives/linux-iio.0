Return-Path: <jic23@cam.ac.uk>
Message-ID: <4BE1D162.90309@cam.ac.uk>
Date: Wed, 05 May 2010 21:13:22 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: linux-iio@vger.kernel.org, Barry Song <Barry.Song@analog.com>
Subject: Re: [PATCH RFC] staging:iio: adis16209 accelerometer driver initial
 import
References: <1273073011-13052-1-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1273073011-13052-1-git-send-email-jic23@cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 05/05/10 16:23, Jonathan Cameron wrote:
> From: Barry Song <Barry.Song@analog.com>
Hi All, 

As stated with the original post, here is some coments from me on this
driver as it currently stands.

One or two are related to changes to the core that are clearly needed
(like the ability to have read only scan_element enable attributes for
devices that are always on).  I'll get those done when I have a few
mins.

Barry, I'm happy to do all the other changes mentioned if you can have
a quick look at check I'm not actually going to break anything.  Or if
you would prefer, we can leave these until after the iio changes hit
the analog tree.

Jonathan
> 
> This driver was lifted from the analog devices blackfin tree by
> Jonathan Cameron.  There are currently some over 80 character check patch
> issues left to be fixed that I know of.
> 
> I'd like to move to a more standard review type process for iio drivers hence
> I've posted this one to linux-iio prior to sending it to Greg KH.
> So if anyone has a chance to take a look (and Barry can you sign off if
> you are happy with the changes I've made).
> 
>  drivers/staging/iio/accel/Kconfig             |   10 +
>  drivers/staging/iio/accel/Makefile            |    4 +
>  drivers/staging/iio/accel/adis16209.h         |  171 +++++++
>  drivers/staging/iio/accel/adis16209_core.c    |  654 +++++++++++++++++++++++++
>  drivers/staging/iio/accel/adis16209_ring.c    |  219 +++++++++
>  drivers/staging/iio/accel/adis16209_trigger.c |  124 +++++
>  6 files changed, 1182 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/Kconfig b/drivers/staging/iio/accel/Kconfig
> index 3d3c333..8d7a780 100644
> --- a/drivers/staging/iio/accel/Kconfig
> +++ b/drivers/staging/iio/accel/Kconfig
> @@ -3,6 +3,16 @@
>  #
>  comment "Accelerometers"
>  
> +config ADIS16209
> +       tristate "Analog Devices ADIS16209 Dual-Axis Digital Inclinometer and Accelerometer"
> +       depends on SPI
> +       select IIO_TRIGGER
> +       select IIO_SW_RING
Oops, this one is my fault.  The makefile makes it clear that this driver can be built
without ring support. This select should be dependent on CONFIG_IIO_RING_BUFFER.
> +       help
> +         Say yes here to build support for Analog Devices adis16209 dual-axis digital inclinometer
> +	 and accelerometer.
> +
> +
>  config KXSD9
>  	tristate "Kionix KXSD9 Accelerometer Driver"
>  	depends on SPI
> diff --git a/drivers/staging/iio/accel/Makefile b/drivers/staging/iio/accel/Makefile
> index d5335f9..f8f2124 100644
> --- a/drivers/staging/iio/accel/Makefile
> +++ b/drivers/staging/iio/accel/Makefile
> @@ -1,6 +1,10 @@
>  #
>  # Makefile for industrial I/O accelerometer drivers
>  #
> +adis16209-y             := adis16209_core.o
> +adis16209-$(CONFIG_IIO_RING_BUFFER) += adis16209_ring.o adis16209_trigger.o
> +obj-$(CONFIG_ADIS16209) += adis16209.o
> +
>  obj-$(CONFIG_KXSD9)	+= kxsd9.o
>  
>  lis3l02dq-y		:= lis3l02dq_core.o
> diff --git a/drivers/staging/iio/accel/adis16209.h b/drivers/staging/iio/accel/adis16209.h
> new file mode 100644
> index 0000000..1e59782
> --- /dev/null
> +++ b/drivers/staging/iio/accel/adis16209.h
> @@ -0,0 +1,171 @@
> +#ifndef SPI_ADIS16209_H_
> +#define SPI_ADIS16209_H_
> +
> +#define ADIS16209_STARTUP_DELAY	220 /* ms */
> +
> +#define ADIS16209_READ_REG(a)    a
> +#define ADIS16209_WRITE_REG(a) ((a) | 0x80)
> +
There are quite a few overlong lines in here. Some of the comments are rather
on the obvious side, so some reorganization and removal of unecessary comments
should get this sorted out.
> +#define ADIS16209_FLASH_CNT      0x00 /* Flash memory write count */
> +#define ADIS16209_SUPPLY_OUT     0x02 /* Output, power supply */
> +#define ADIS16209_XACCL_OUT      0x04 /* Output, x-axis accelerometer */
> +#define ADIS16209_YACCL_OUT      0x06 /* Output, y-axis accelerometer */
> +#define ADIS16209_AUX_ADC        0x08 /* Output, auxiliary ADC input */
> +#define ADIS16209_TEMP_OUT       0x0A /* Output, temperature */
> +#define ADIS16209_XINCL_OUT      0x0C /* Output, x-axis inclination */
> +#define ADIS16209_YINCL_OUT      0x0E /* Output, y-axis inclination */
> +#define ADIS16209_ROT_OUT        0x10 /* Output, +/-180 vertical rotational position */
> +#define ADIS16209_XACCL_NULL     0x12 /* Calibration, x-axis acceleration offset null */
> +#define ADIS16209_YACCL_NULL     0x14 /* Calibration, y-axis acceleration offset null */
> +#define ADIS16209_XINCL_NULL     0x16 /* Calibration, x-axis inclination offset null */
> +#define ADIS16209_YINCL_NULL     0x18 /* Calibration, y-axis inclination offset null */
> +#define ADIS16209_ROT_NULL       0x1A /* Calibration, vertical rotation offset null */
> +#define ADIS16209_ALM_MAG1       0x20 /* Alarm 1 amplitude threshold */
> +#define ADIS16209_ALM_MAG2       0x22 /* Alarm 2 amplitude threshold */
> +#define ADIS16209_ALM_SMPL1      0x24 /* Alarm 1, sample period */
> +#define ADIS16209_ALM_SMPL2      0x26 /* Alarm 2, sample period */
> +#define ADIS16209_ALM_CTRL       0x28 /* Alarm control */
> +#define ADIS16209_AUX_DAC        0x30 /* Auxiliary DAC data */
> +#define ADIS16209_GPIO_CTRL      0x32 /* General-purpose digital input/output control */
> +#define ADIS16209_MSC_CTRL       0x34 /* Miscellaneous control */
> +#define ADIS16209_SMPL_PRD       0x36 /* Internal sample period (rate) control */
> +#define ADIS16209_AVG_CNT        0x38 /* Operation, filter configuration */
> +#define ADIS16209_SLP_CNT        0x3A /* Operation, sleep mode control */
> +#define ADIS16209_DIAG_STAT      0x3C /* Diagnostics, system status register */
> +#define ADIS16209_GLOB_CMD       0x3E /* Operation, system command register */
> +
> +#define ADIS16209_OUTPUTS        8
> +
> +/* MSC_CTRL */
> +#define ADIS16209_MSC_CTRL_PWRUP_SELF_TEST	(1 << 10) /* Self-test at power-on: 1 = disabled, 0 = enabled */
> +#define ADIS16209_MSC_CTRL_SELF_TEST_EN	        (1 << 8)  /* Self-test enable */
> +#define ADIS16209_MSC_CTRL_DATA_RDY_EN	        (1 << 2)  /* Data-ready enable: 1 = enabled, 0 = disabled */
> +#define ADIS16209_MSC_CTRL_ACTIVE_HIGH	        (1 << 1)  /* Data-ready polarity: 1 = active high, 0 = active low */
> +#define ADIS16209_MSC_CTRL_DATA_RDY_DIO2	(1 << 0)  /* Data-ready line selection: 1 = DIO2, 0 = DIO1 */
> +
> +/* DIAG_STAT */
> +#define ADIS16209_DIAG_STAT_ALARM2        (1<<9) /* Alarm 2 status: 1 = alarm active, 0 = alarm inactive */
> +#define ADIS16209_DIAG_STAT_ALARM1        (1<<8) /* Alarm 1 status: 1 = alarm active, 0 = alarm inactive */
> +#define ADIS16209_DIAG_STAT_SELFTEST_FAIL (1<<5) /* Self-test diagnostic error flag: 1 = error condition,
> +						0 = normal operation */
> +#define ADIS16209_DIAG_STAT_SPI_FAIL	  (1<<3) /* SPI communications failure */
> +#define ADIS16209_DIAG_STAT_FLASH_UPT	  (1<<2) /* Flash update failure */
> +#define ADIS16209_DIAG_STAT_POWER_HIGH	  (1<<1) /* Power supply above 3.625 V */
> +#define ADIS16209_DIAG_STAT_POWER_LOW	  (1<<0) /* Power supply below 3.15 V */
> +
> +/* GLOB_CMD */
> +#define ADIS16209_GLOB_CMD_SW_RESET	(1<<7)
> +#define ADIS16209_GLOB_CMD_CLEAR_STAT	(1<<4)
> +#define ADIS16209_GLOB_CMD_FACTORY_CAL	(1<<1)
> +
> +#define ADIS16209_MAX_TX 24
> +#define ADIS16209_MAX_RX 24
> +
> +#define ADIS16209_SPI_BURST	(u32)(1000 * 1000)
> +#define ADIS16209_SPI_FAST	(u32)(2000 * 1000)
> +
> +/**
> + * struct adis16209_state - device instance specific data
> + * @us:			actual spi_device
> + * @work_trigger_to_ring: bh for triggered event handling
> + * @work_cont_thresh: CLEAN
> + * @inter:		used to check if new interrupt has been triggered
> + * @last_timestamp:	passing timestamp from th to bh of interrupt handler
> + * @indio_dev:		industrial I/O device structure
> + * @trig:		data ready trigger registered with iio
> + * @tx:			transmit buffer
> + * @rx:			recieve buffer
> + * @buf_lock:		mutex to protect tx and rx
> + **/
> +struct adis16209_state {
> +	struct spi_device		*us;
> +	struct work_struct		work_trigger_to_ring;
> +	struct iio_work_cont		work_cont_thresh;
> +	s64				last_timestamp;
> +	struct iio_dev			*indio_dev;
> +	struct iio_trigger		*trig;
> +	u8				*tx;
> +	u8				*rx;
> +	struct mutex			buf_lock;
> +};
> +
> +int adis16209_spi_write_reg_8(struct device *dev,
> +			      u8 reg_address,
> +			      u8 val);
> +
> +int adis16209_spi_read_burst(struct device *dev, u8 *rx);
> +
> +int adis16209_spi_read_sequence(struct device *dev,
> +				      u8 *tx, u8 *rx, int num);
> +
> +int adis16209_set_irq(struct device *dev, bool enable);
> +
> +int adis16209_reset(struct device *dev);
> +
> +int adis16209_stop_device(struct device *dev);
> +
> +int adis16209_check_status(struct device *dev);
> +
> +#ifdef CONFIG_IIO_RING_BUFFER
> +enum adis16209_scan {
> +	ADIS16209_SCAN_SUPPLY,
> +	ADIS16209_SCAN_ACC_X,
> +	ADIS16209_SCAN_ACC_Y,
> +	ADIS16209_SCAN_AUX_ADC,
> +	ADIS16209_SCAN_TEMP,
> +	ADIS16209_SCAN_INCLI_X,
> +	ADIS16209_SCAN_INCLI_Y,
> +	ADIS16209_SCAN_ROT,
> +};
> +
> +void adis16209_remove_trigger(struct iio_dev *indio_dev);
> +int adis16209_probe_trigger(struct iio_dev *indio_dev);
> +
> +ssize_t adis16209_read_data_from_ring(struct device *dev,
> +				      struct device_attribute *attr,
> +				      char *buf);
> +
> +int adis16209_configure_ring(struct iio_dev *indio_dev);
> +void adis16209_unconfigure_ring(struct iio_dev *indio_dev);
> +
> +int adis16209_initialize_ring(struct iio_ring_buffer *ring);
> +void adis16209_uninitialize_ring(struct iio_ring_buffer *ring);
> +#else /* CONFIG_IIO_RING_BUFFER */
> +
> +static inline void adis16209_remove_trigger(struct iio_dev *indio_dev)
> +{
> +}
> +
> +static inline int adis16209_probe_trigger(struct iio_dev *indio_dev)
> +{
> +	return 0;
> +}
> +
> +static inline ssize_t
> +adis16209_read_data_from_ring(struct device *dev,
> +			      struct device_attribute *attr,
> +			      char *buf)
> +{
> +	return 0;
> +}
> +
> +static int adis16209_configure_ring(struct iio_dev *indio_dev)
> +{
> +	return 0;
> +}
> +
> +static inline void adis16209_unconfigure_ring(struct iio_dev *indio_dev)
> +{
> +}
> +
> +static inline int adis16209_initialize_ring(struct iio_ring_buffer *ring)
> +{
> +	return 0;
> +}
> +
> +static inline void adis16209_uninitialize_ring(struct iio_ring_buffer *ring)
> +{
> +}
> +
> +#endif /* CONFIG_IIO_RING_BUFFER */
> +#endif /* SPI_ADIS16209_H_ */
> diff --git a/drivers/staging/iio/accel/adis16209_core.c b/drivers/staging/iio/accel/adis16209_core.c
> new file mode 100644
> index 0000000..fb0e66d
> --- /dev/null
> +++ b/drivers/staging/iio/accel/adis16209_core.c
> @@ -0,0 +1,654 @@
> +/*
> + * ADIS16209 Programmable Digital Vibration Sensor driver
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
> +
> +#include <linux/sysfs.h>
> +#include <linux/list.h>
> +
> +#include "../iio.h"
> +#include "../sysfs.h"
> +#include "accel.h"
> +#include "../gyro/gyro.h"
> +#include "../adc/adc.h"
> +
> +#include "adis16209.h"
> +
> +#define DRIVER_NAME		"adis16209"
> +
> +/**
> + * adis16209_spi_write_reg_8() - write single byte to a register
> + * @dev: device associated with child of actual device (iio_dev or iio_trig)
> + * @reg_address: the address of the register to be written
> + * @val: the value to write
> + **/
> +int adis16209_spi_write_reg_8(struct device *dev,
> +		u8 reg_address,
> +		u8 val)
> +{
> +	int ret;
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct adis16209_state *st = iio_dev_get_devdata(indio_dev);
> +
> +	mutex_lock(&st->buf_lock);
> +	st->tx[0] = ADIS16209_WRITE_REG(reg_address);
> +	st->tx[1] = val;
> +
> +	ret = spi_write(st->us, st->tx, 2);
> +	mutex_unlock(&st->buf_lock);
> +
> +	return ret;
> +}
> +
> +/**
> + * adis16209_spi_write_reg_16() - write 2 bytes to a pair of registers
> + * @dev: device associated with child of actual device (iio_dev or iio_trig)
> + * @reg_address: the address of the lower of the two registers. Second register
> + *               is assumed to have address one greater.
> + * @val: value to be written
> + **/
> +static int adis16209_spi_write_reg_16(struct device *dev,
> +		u8 lower_reg_address,
> +		u16 value)
> +{
> +	int ret;
> +	struct spi_message msg;
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct adis16209_state *st = iio_dev_get_devdata(indio_dev);
> +	struct spi_transfer xfers[] = {
> +		{
> +			.tx_buf = st->tx,
> +			.bits_per_word = 8,
> +			.len = 2,
> +			.cs_change = 1,
> +		}, {
> +			.tx_buf = st->tx + 2,
> +			.bits_per_word = 8,
> +			.len = 2,
> +			.cs_change = 1,
> +		},
> +	};
> +
> +	mutex_lock(&st->buf_lock);
> +	st->tx[0] = ADIS16209_WRITE_REG(lower_reg_address);
> +	st->tx[1] = value & 0xFF;
> +	st->tx[2] = ADIS16209_WRITE_REG(lower_reg_address + 1);
> +	st->tx[3] = (value >> 8) & 0xFF;
> +
> +	spi_message_init(&msg);
> +	spi_message_add_tail(&xfers[0], &msg);
> +	spi_message_add_tail(&xfers[1], &msg);
> +	ret = spi_sync(st->us, &msg);
> +	mutex_unlock(&st->buf_lock);
> +
> +	return ret;
> +}
> +
> +/**
> + * adis16209_spi_read_reg_16() - read 2 bytes from a 16-bit register
> + * @dev: device associated with child of actual device (iio_dev or iio_trig)
> + * @reg_address: the address of the lower of the two registers. Second register
> + *               is assumed to have address one greater.
> + * @val: somewhere to pass back the value read
> + **/
> +static int adis16209_spi_read_reg_16(struct device *dev,
> +		u8 lower_reg_address,
> +		u16 *val)
> +{
> +	struct spi_message msg;
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct adis16209_state *st = iio_dev_get_devdata(indio_dev);
> +	int ret;
> +	struct spi_transfer xfers[] = {
> +		{
> +			.tx_buf = st->tx,
> +			.bits_per_word = 8,
> +			.len = 2,
> +			.cs_change = 1,
> +			.delay_usecs = 20,
> +		}, {
> +			.rx_buf = st->rx,
> +			.bits_per_word = 8,
> +			.len = 2,
> +			.cs_change = 1,
> +			.delay_usecs = 20,
> +		},
> +	};
> +
> +	mutex_lock(&st->buf_lock);
> +	st->tx[0] = ADIS16209_READ_REG(lower_reg_address);
> +	st->tx[1] = 0;
> +
> +	spi_message_init(&msg);
> +	spi_message_add_tail(&xfers[0], &msg);
> +	spi_message_add_tail(&xfers[1], &msg);
> +	ret = spi_sync(st->us, &msg);
> +	if (ret) {
> +		dev_err(&st->us->dev, "problem when reading 16 bit register 0x%02X",
> +				lower_reg_address);
> +		goto error_ret;
> +	}
> +	*val = (st->rx[0] << 8) | st->rx[1];
> +
> +error_ret:
> +	mutex_unlock(&st->buf_lock);
> +	return ret;
> +}
> +

I do wonder if this function shouldn't really be in the adis16209_ring.c
as it is only used there and hence is just bloat if the buffering isn't enabled.
The disadvantage is it means one single read function is in a different place
from all the others.
> +/**
> + * adis16209_spi_read_burst() - read all data registers
> + * @dev: device associated with child of actual device (iio_dev or iio_trig)
> + * @rx: somewhere to pass back the value read
> + **/
> +int adis16209_spi_read_burst(struct device *dev, u8 *rx)
> +{
> +	struct spi_message msg;
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct adis16209_state *st = iio_dev_get_devdata(indio_dev);
> +	struct spi_transfer xfers[ADIS16209_OUTPUTS + 1];
> +	int ret;
> +	int i;
> +
> +	mutex_lock(&st->buf_lock);
> +
> +	spi_message_init(&msg);
> +
> +	memset(xfers, 0, sizeof(xfers));
> +	for (i = 0; i <= ADIS16209_OUTPUTS; i++) {
> +		xfers[i].bits_per_word = 8;
> +		xfers[i].cs_change = 1;
> +		xfers[i].len = 2;
> +		xfers[i].delay_usecs = 20;
> +		xfers[i].tx_buf = st->tx + 2 * i;
> +		st->tx[2 * i] = ADIS16209_READ_REG(ADIS16209_SUPPLY_OUT + 2 * i);
> +		st->tx[2 * i + 1] = 0;
> +		if (i >= 1)
> +			xfers[i].rx_buf = rx + 2 * (i - 1);
> +		spi_message_add_tail(&xfers[i], &msg);
> +	}
> +
> +	ret = spi_sync(st->us, &msg);
> +	if (ret)
> +		dev_err(&st->us->dev, "problem when burst reading");
> +
> +	mutex_unlock(&st->buf_lock);
> +
> +	return ret;
> +}
> +
I only see one size of signed read.  Hence why does this nice general function
exist?  Admittedly the compiler probably squashes it, but it does add unecessary
code.  Not to mention it results in the mlock being held longer than strictly
necessary.

> +static ssize_t adis16209_spi_read_signed(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf,
> +		unsigned bits)
> +{
> +	int ret;
> +	s16 val = 0;
> +	unsigned shift = 16 - bits;
> +	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> +
> +	ret = adis16209_spi_read_reg_16(dev, this_attr->address, (u16 *)&val);
> +	if (ret)
> +		return ret;
> +
> +	val = ((s16)(val << shift) >> shift);
> +	return sprintf(buf, "%d\n", val);
> +}
> +
> +static ssize_t adis16209_read_12bit_unsigned(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	int ret;
> +	u16 val = 0;
> +	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> +
> +	ret = adis16209_spi_read_reg_16(dev, this_attr->address, &val);
> +	if (ret)
> +		return ret;
> +
> +	return sprintf(buf, "%u\n", val & 0x0FFF);
> +}
> +
> +static ssize_t adis16209_read_14bit_unsigned(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	int ret;
> +	u16 val = 0;
> +	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> +
> +	ret = adis16209_spi_read_reg_16(dev, this_attr->address, &val);
> +	if (ret)
> +		return ret;
> +
> +	return sprintf(buf, "%u\n", val & 0x3FFF);
> +}
> +
> +static ssize_t adis16209_read_temp(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	ssize_t ret;
> +	s16 val;
> +
> +	/* Take the iio_dev status lock */
> +	mutex_lock(&indio_dev->mlock);
> +
> +	ret = adis16209_spi_read_reg_16(dev, ADIS16209_TEMP_OUT, (u16 *)&val);
> +	if (ret)
> +		goto error_ret;
> +
I'm not sure on this. The datasheet doesn't list the temp as a 2's comp
number?  If it is please add a comment here to explain that!
> +	val = ((s16)(val << 4) >> 4);
> +	ret = sprintf(buf, "%d\n", val);
> +
> +error_ret:
> +	mutex_unlock(&indio_dev->mlock);
> +	return ret;
> +}
> +
As stated above, this might as well be rolled together with
read_signed as this is the only user.

> +static ssize_t adis16209_read_14bit_signed(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	ssize_t ret;
> +
> +	/* Take the iio_dev status lock */
> +	mutex_lock(&indio_dev->mlock);
> +	ret =  adis16209_spi_read_signed(dev, attr, buf, 14);
> +	mutex_unlock(&indio_dev->mlock);
> +
> +	return ret;
> +}
> +
> +static ssize_t adis16209_write_16bit(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf,
> +		size_t len)
> +{
> +	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> +	int ret;
> +	long val;
> +
> +	ret = strict_strtol(buf, 10, &val);
> +	if (ret)
> +		goto error_ret;
> +	ret = adis16209_spi_write_reg_16(dev, this_attr->address, val);
> +
> +error_ret:
> +	return ret ? ret : len;
> +}
> +
> +static ssize_t adis16209_write_reset(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf, size_t len)
> +{
> +	if (len < 1)
> +		return -1;
> +	switch (buf[0]) {
> +	case '1':
> +	case 'y':
> +	case 'Y':
> +		return adis16209_reset(dev);
> +	}
Proper error please. -EINVAL seems the most sensible to me.

> +	return -1;
> +}
> +
Whilst there is currently only one non probe user of this (and I don't think
that multiple concurrent calls to that can occur), I'm a little dubious that
no lock is taken to ensure msc isn't changed by someone else between the
read and the write.  Perhaps a comment to ensure that this is revisted if
event interupts are added?
> +int adis16209_set_irq(struct device *dev, bool enable)
> +{
> +	int ret;
> +	u16 msc;
> +	ret = adis16209_spi_read_reg_16(dev, ADIS16209_MSC_CTRL, &msc);
> +	if (ret)
> +		goto error_ret;
> +
> +	msc |= ADIS16209_MSC_CTRL_ACTIVE_HIGH;
> +	msc &= ~ADIS16209_MSC_CTRL_DATA_RDY_DIO2;
> +	if (enable)
> +		msc |= ADIS16209_MSC_CTRL_DATA_RDY_EN;
> +	else
> +		msc &= ~ADIS16209_MSC_CTRL_DATA_RDY_EN;
> +
> +	ret = adis16209_spi_write_reg_16(dev, ADIS16209_MSC_CTRL, msc);
> +	if (ret)
> +		goto error_ret;
> +
> +error_ret:
> +	return ret;
> +}
> +
> +int adis16209_reset(struct device *dev)
> +{
> +	int ret;
> +	ret = adis16209_spi_write_reg_8(dev,
> +			ADIS16209_GLOB_CMD,
> +			ADIS16209_GLOB_CMD_SW_RESET);
> +	if (ret)
> +		dev_err(dev, "problem resetting device");
> +
> +	return ret;
> +}
> +
> +static int adis16209_self_test(struct device *dev)
> +{
> +	int ret;
> +	ret = adis16209_spi_write_reg_16(dev,
> +			ADIS16209_MSC_CTRL,
> +			ADIS16209_MSC_CTRL_SELF_TEST_EN);
> +	if (ret) {
> +		dev_err(dev, "problem starting self test");
> +		goto err_ret;
> +	}
> +
check status can return an error code under some circumstances.
It isn't currently handled.
> +	adis16209_check_status(dev);
> +
> +err_ret:
> +	return ret;
> +}
> +
> +int adis16209_check_status(struct device *dev)
> +{
> +	u16 status;
> +	int ret;
> +
> +	ret = adis16209_spi_read_reg_16(dev, ADIS16209_DIAG_STAT, &status);
> +	if (ret < 0) {
> +		dev_err(dev, "Reading status failed\n");
> +		goto error_ret;
> +	}
> +	ret = status & 0x1F;
> +
> +	if (status & ADIS16209_DIAG_STAT_SELFTEST_FAIL)
> +		dev_err(dev, "Self test failure\n");
> +	if (status & ADIS16209_DIAG_STAT_SPI_FAIL)
> +		dev_err(dev, "SPI failure\n");
> +	if (status & ADIS16209_DIAG_STAT_FLASH_UPT)
> +		dev_err(dev, "Flash update failed\n");
> +	if (status & ADIS16209_DIAG_STAT_POWER_HIGH)
> +		dev_err(dev, "Power supply above 3.625V\n");
> +	if (status & ADIS16209_DIAG_STAT_POWER_LOW)
> +		dev_err(dev, "Power supply below 3.15V\n");
> +
> +error_ret:
> +	return ret;
> +}
> +
> +static int adis16209_initial_setup(struct adis16209_state *st)
> +{
> +	int ret;
> +	struct device *dev = &st->indio_dev->dev;
> +
> +	/* Disable IRQ */
> +	ret = adis16209_set_irq(dev, false);
> +	if (ret) {
> +		dev_err(dev, "disable irq failed");
> +		goto err_ret;
> +	}
> +
> +	/* Do self test */
> +	ret = adis16209_self_test(dev);
> +	if (ret) {
> +		dev_err(dev, "self test failure");
> +		goto err_ret;
> +	}
The result of the logic here is to clear other errors
(by reading status).  It won't even fail if the self
test fails, just print an error.  Now if the next read
occurs fast enough (before next sample cycle) any other
errors will not have been re asserted. (particularly
important if we have power supply problems!).
> +
> +	/* Read status register to check the result */
> +	ret = adis16209_check_status(dev);
> +	if (ret) {
> +		adis16209_reset(dev);
> +		dev_err(dev, "device not playing ball -> reset");
> +		msleep(ADIS16209_STARTUP_DELAY);
> +		ret = adis16209_check_status(dev);
> +		if (ret) {
> +			dev_err(dev, "giving up");
> +			goto err_ret;
> +		}
> +	}
> +
> +	printk(KERN_INFO DRIVER_NAME ": at CS%d (irq %d)\n",
> +			st->us->chip_select, st->us->irq);
> +
> +err_ret:
> +	return ret;
> +}
> +
> +static IIO_DEV_ATTR_IN_NAMED_RAW(supply, adis16209_read_14bit_unsigned,
> +		ADIS16209_SUPPLY_OUT);
> +static IIO_CONST_ATTR(in_supply_scale, "0.30518 mV");
> +static IIO_DEV_ATTR_IN_RAW(0, adis16209_read_12bit_unsigned,
> +		ADIS16209_AUX_ADC);
In the abi doc these should be scalling to volts (and no unit is needed).
> +static IIO_CONST_ATTR(in0_scale, "0.6105 mV");
> +
> +static IIO_DEV_ATTR_ACCEL_X(adis16209_read_14bit_signed,
> +		ADIS16209_XACCL_OUT);
> +static IIO_DEV_ATTR_ACCEL_Y(adis16209_read_14bit_signed,
> +		ADIS16209_YACCL_OUT);
> +static IIO_DEV_ATTR_ACCEL_X_OFFSET(S_IWUSR | S_IRUGO,
> +		adis16209_read_14bit_signed,
> +		adis16209_write_16bit,
> +		ADIS16209_XACCL_NULL);
> +static IIO_DEV_ATTR_ACCEL_Y_OFFSET(S_IWUSR | S_IRUGO,
> +		adis16209_read_14bit_signed,
> +		adis16209_write_16bit,
> +		ADIS16209_YACCL_NULL);
> +static IIO_CONST_ATTR(accel_scale, "0.24414 mg");
> +

I've only just noticed (as I lifted it without a close enough read)
that gyro.h include inclinometer readings.  Given they are acceleration
based we can either move them to accel.h or given they might be established
in some other way, create an incli.h file to contain them.

These (along with the rest of gyro.h) need updating to the _raw naming.
Whether that happens before or after this patch depends on what other
people want to say about this!

> +static IIO_DEV_ATTR_INCLI_X(adis16209_read_14bit_signed,
> +		ADIS16209_XINCL_OUT);
> +static IIO_DEV_ATTR_INCLI_Y(adis16209_read_14bit_signed,
> +		ADIS16209_YINCL_OUT);
> +static IIO_DEV_ATTR_INCLI_X_OFFSET(S_IWUSR | S_IRUGO,
> +		adis16209_read_14bit_signed,
> +		adis16209_write_16bit,
> +		ADIS16209_XACCL_NULL);
> +static IIO_DEV_ATTR_INCLI_Y_OFFSET(S_IWUSR | S_IRUGO,
> +		adis16209_read_14bit_signed,
> +		adis16209_write_16bit,
> +		ADIS16209_YACCL_NULL);
Again, no units plase.
> +static IIO_CONST_ATTR(incli_scale, "0.025 D");
> +
Hmm.. This one is a bit device specific to my mind.  What do
people think? In a sense it is just a signed version of inclination.
Perhaps this is something for documentation rather than in the naming
itself.  I'll try and bash out an explanation (the diagrams on the data
sheet are pretty good for the curious) and add that to the abi spec.

> +static IIO_DEV_ATTR_ROT(adis16209_read_14bit_signed,
> +		ADIS16209_ROT_OUT);
> +
I admit to being somewhat confused by the temp part of the
data sheet.  As written here, I would expect the example
reading of 0x04FE as given on the datasheet (as 25 degrees C)
to be 25 - 0.47* 0x4FE Kelvin which I make -898.66 degrees C

As 4FE even if assumed to be 2's complement 12 bit is a positive
number.  Can someone with the magic abilities to understand that bit
of the data sheet explain how it is meant to work!

Whilst we are here, the intent is to have all readings in standard
units (and hence not supply the units in sysfs - just like hwmon
does it).  However we can clean these out and standardise everything
in a later patch set (along with documenting the choices).
> +static IIO_DEV_ATTR_TEMP(adis16209_read_temp);
> +static IIO_CONST_ATTR(temp_offset, "25 K");
> +static IIO_CONST_ATTR(temp_scale, "-0.47 K");
> +
> +static IIO_DEVICE_ATTR(reset, S_IWUSR, NULL, adis16209_write_reset, 0);
> +
> +static IIO_CONST_ATTR(name, "adis16209");
> +
If we need to have this defined as empty I've got a bug in the core code.
I have a couple of drivers without event lines so I think this is definitely
unecessary. I guess there might be an interaction with the trigger code I
haven't handled right. Please poke me if there is!
> +static struct attribute *adis16209_event_attributes[] = {
> +	NULL
> +};
> +
> +static struct attribute_group adis16209_event_attribute_group = {
> +	.attrs = adis16209_event_attributes,
> +};
> +
> +static struct attribute *adis16209_attributes[] = {
> +	&iio_dev_attr_in_supply_raw.dev_attr.attr,
> +	&iio_const_attr_in_supply_scale.dev_attr.attr,
> +	&iio_dev_attr_temp.dev_attr.attr,
> +	&iio_const_attr_temp_offset.dev_attr.attr,
> +	&iio_const_attr_temp_scale.dev_attr.attr,
> +	&iio_dev_attr_reset.dev_attr.attr,
> +	&iio_const_attr_name.dev_attr.attr,
> +	&iio_dev_attr_in0_raw.dev_attr.attr,
> +	&iio_const_attr_in0_scale.dev_attr.attr,
> +	&iio_dev_attr_accel_x_raw.dev_attr.attr,
> +	&iio_dev_attr_accel_y_raw.dev_attr.attr,
> +	&iio_dev_attr_accel_x_offset.dev_attr.attr,
> +	&iio_dev_attr_accel_y_offset.dev_attr.attr,
> +	&iio_const_attr_accel_scale.dev_attr.attr,
> +	&iio_dev_attr_incli_x.dev_attr.attr,
> +	&iio_dev_attr_incli_y.dev_attr.attr,
> +	&iio_dev_attr_incli_x_offset.dev_attr.attr,
> +	&iio_dev_attr_incli_y_offset.dev_attr.attr,
> +	&iio_const_attr_incli_scale.dev_attr.attr,
> +	&iio_dev_attr_rot.dev_attr.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group adis16209_attribute_group = {
> +	.attrs = adis16209_attributes,
> +};
> +
> +static int __devinit adis16209_probe(struct spi_device *spi)
> +{
> +	int ret, regdone = 0;
> +	struct adis16209_state *st = kzalloc(sizeof *st, GFP_KERNEL);
> +	if (!st) {
> +		ret =  -ENOMEM;
> +		goto error_ret;
> +	}
> +	/* this is only used for removal purposes */
> +	spi_set_drvdata(spi, st);
> +
> +	/* Allocate the comms buffers */
> +	st->rx = kzalloc(sizeof(*st->rx)*ADIS16209_MAX_RX, GFP_KERNEL);
> +	if (st->rx == NULL) {
> +		ret = -ENOMEM;
> +		goto error_free_st;
> +	}
> +	st->tx = kzalloc(sizeof(*st->tx)*ADIS16209_MAX_TX, GFP_KERNEL);
> +	if (st->tx == NULL) {
> +		ret = -ENOMEM;
> +		goto error_free_rx;
> +	}
> +	st->us = spi;
> +	mutex_init(&st->buf_lock);
> +	/* setup the industrialio driver allocated elements */
> +	st->indio_dev = iio_allocate_device();
> +	if (st->indio_dev == NULL) {
> +		ret = -ENOMEM;
> +		goto error_free_tx;
> +	}
> +
> +	st->indio_dev->dev.parent = &spi->dev;
> +	st->indio_dev->num_interrupt_lines = 1;
> +	st->indio_dev->event_attrs = &adis16209_event_attribute_group;
As per the above comment, I think the two lines above can go away for
now.

> +	st->indio_dev->attrs = &adis16209_attribute_group;
> +	st->indio_dev->dev_data = (void *)(st);
> +	st->indio_dev->driver_module = THIS_MODULE;
> +	st->indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	ret = adis16209_configure_ring(st->indio_dev);
> +	if (ret)
> +		goto error_free_dev;
> +
> +	ret = iio_device_register(st->indio_dev);
> +	if (ret)
> +		goto error_unreg_ring_funcs;
> +	regdone = 1;
> +
> +	ret = adis16209_initialize_ring(st->indio_dev->ring);
> +	if (ret) {
> +		printk(KERN_ERR "failed to initialize the ring\n");
> +		goto error_unreg_ring_funcs;
> +	}
> +
I'm guessing this might actually have come out of some of my code, but
then I'm still learning :) Do we actually need the gpio_is_valid call?
At the end of the day, if the interrupt is specified do we care about
the gpio bit?  If we do, can we have a comment as its not obvious to me!

> +	if (spi->irq && gpio_is_valid(irq_to_gpio(spi->irq)) > 0) {
> +		ret = iio_register_interrupt_line(spi->irq,
> +				st->indio_dev,
> +				0,
> +				IRQF_TRIGGER_RISING,
> +				"adis16209");
> +		if (ret)
> +			goto error_uninitialize_ring;
> +
> +		ret = adis16209_probe_trigger(st->indio_dev);
> +		if (ret)
> +			goto error_unregister_line;
> +	}
> +
> +	/* Get the device into a sane initial state */
> +	ret = adis16209_initial_setup(st);
> +	if (ret)
> +		goto error_remove_trigger;
> +	return 0;
> +
> +error_remove_trigger:
> +	if (st->indio_dev->modes & INDIO_RING_TRIGGERED)
> +		adis16209_remove_trigger(st->indio_dev);
> +error_unregister_line:
> +	if (st->indio_dev->modes & INDIO_RING_TRIGGERED)
> +		iio_unregister_interrupt_line(st->indio_dev, 0);
> +error_uninitialize_ring:
> +	adis16209_uninitialize_ring(st->indio_dev->ring);
> +error_unreg_ring_funcs:
> +	adis16209_unconfigure_ring(st->indio_dev);
> +error_free_dev:
> +	if (regdone)
> +		iio_device_unregister(st->indio_dev);
> +	else
> +		iio_free_device(st->indio_dev);
> +error_free_tx:
> +	kfree(st->tx);
> +error_free_rx:
> +	kfree(st->rx);
> +error_free_st:
> +	kfree(st);
> +error_ret:
> +	return ret;
> +}
> +
Has this been confirmed?   I'm guessing not, so perhaps
I pinched this one from your tree to early!
> +/* fixme, confirm ordering in this function */
> +static int adis16209_remove(struct spi_device *spi)
> +{
> +	struct adis16209_state *st = spi_get_drvdata(spi);
> +	struct iio_dev *indio_dev = st->indio_dev;
> +
> +	flush_scheduled_work();
> +
I think this should be in the if statement below. (to match the probe).
> +	adis16209_remove_trigger(indio_dev);
> +	if (spi->irq && gpio_is_valid(irq_to_gpio(spi->irq)) > 0)
> +		iio_unregister_interrupt_line(indio_dev, 0);
> +
> +	adis16209_uninitialize_ring(indio_dev->ring);

I think the next two are in the wrong order. Probably doesn't matter, but
it'll read more coherently the other way round (as they reverse what
goes on in probe).
> +	adis16209_unconfigure_ring(indio_dev);
> +	iio_device_unregister(indio_dev);
> +	kfree(st->tx);
> +	kfree(st->rx);
> +	kfree(st);
> +
> +	return 0;
> +}
> +
> +static struct spi_driver adis16209_driver = {
> +	.driver = {
> +		.name = "adis16209",
> +		.owner = THIS_MODULE,
> +	},
> +	.probe = adis16209_probe,
> +	.remove = __devexit_p(adis16209_remove),
> +};
> +
> +static __init int adis16209_init(void)
> +{
> +	return spi_register_driver(&adis16209_driver);
> +}
> +module_init(adis16209_init);
> +
> +static __exit void adis16209_exit(void)
> +{
> +	spi_unregister_driver(&adis16209_driver);
> +}
> +module_exit(adis16209_exit);
> +
> +MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
> +MODULE_DESCRIPTION("Analog Devices ADIS16209 Programmable Digital Vibration Sensor driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/staging/iio/accel/adis16209_ring.c b/drivers/staging/iio/accel/adis16209_ring.c
> new file mode 100644
> index 0000000..9e2073f
> --- /dev/null
> +++ b/drivers/staging/iio/accel/adis16209_ring.c
> @@ -0,0 +1,219 @@
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/gpio.h>
> +#include <linux/workqueue.h>
> +#include <linux/mutex.h>
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/spi/spi.h>
> +#include <linux/sysfs.h>
> +#include <linux/list.h>
> +
> +#include "../iio.h"
> +#include "../sysfs.h"
> +#include "../ring_sw.h"
> +#include "accel.h"
> +#include "../trigger.h"
> +#include "adis16209.h"
> +
> +/**
> + * combine_8_to_16() utility function to munge to u8s into u16
> + **/
> +static inline u16 combine_8_to_16(u8 lower, u8 upper)
> +{
> +	u16 _lower = lower;
> +	u16 _upper = upper;
> +	return _lower | (_upper << 8);
> +}
> +
Hmm. before the recent abi change, there was no point in having read only
scan elements.  Now we need that ability.  I'll add the functionality to the
core and update drivers appropriately. As things currently stand I think
this will change the scan_count, without actually changing what is incomming
as we never disable channels.
> +static IIO_SCAN_EL_C(supply, ADIS16209_SCAN_SUPPLY, IIO_UNSIGNED(14),
> +		     ADIS16209_SUPPLY_OUT, NULL);
> +static IIO_SCAN_EL_C(accel_x, ADIS16209_SCAN_ACC_X, IIO_SIGNED(14),
> +		     ADIS16209_XACCL_OUT, NULL);
> +static IIO_SCAN_EL_C(accel_y, ADIS16209_SCAN_ACC_Y, IIO_SIGNED(14),
> +		     ADIS16209_YACCL_OUT, NULL);
> +static IIO_SCAN_EL_C(aux_adc, ADIS16209_SCAN_AUX_ADC, IIO_UNSIGNED(12),
> +		     ADIS16209_AUX_ADC, NULL);
> +static IIO_SCAN_EL_C(temp, ADIS16209_SCAN_TEMP, IIO_SIGNED(12),
> +		     ADIS16209_TEMP_OUT, NULL);
> +static IIO_SCAN_EL_C(incli_x, ADIS16209_SCAN_INCLI_X, IIO_SIGNED(14),
> +		     ADIS16209_XINCL_OUT, NULL);
> +static IIO_SCAN_EL_C(incli_y, ADIS16209_SCAN_INCLI_Y, IIO_SIGNED(14),
> +		     ADIS16209_YINCL_OUT, NULL);
> +static IIO_SCAN_EL_C(rot, ADIS16209_SCAN_ROT, IIO_SIGNED(14),
> +		     ADIS16209_ROT_OUT, NULL);
> +
> +static IIO_SCAN_EL_TIMESTAMP(8);
> +
> +static struct attribute *adis16209_scan_el_attrs[] = {
> +	&iio_scan_el_supply.dev_attr.attr,
> +	&iio_scan_el_accel_x.dev_attr.attr,
> +	&iio_scan_el_accel_y.dev_attr.attr,
> +	&iio_scan_el_aux_adc.dev_attr.attr,
> +	&iio_scan_el_temp.dev_attr.attr,
> +	&iio_scan_el_incli_x.dev_attr.attr,
> +	&iio_scan_el_incli_y.dev_attr.attr,
> +	&iio_scan_el_rot.dev_attr.attr,
> +	&iio_scan_el_timestamp.dev_attr.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group adis16209_scan_el_group = {
> +	.attrs = adis16209_scan_el_attrs,
> +	.name = "scan_elements",
> +};
> +
> +/**
> + * adis16209_poll_func_th() top half interrupt handler called by trigger
> + * @private_data:	iio_dev
> + **/
> +static void adis16209_poll_func_th(struct iio_dev *indio_dev)
> +{
> +	struct adis16209_state *st = iio_dev_get_devdata(indio_dev);
> +	st->last_timestamp = indio_dev->trig->timestamp;
> +	schedule_work(&st->work_trigger_to_ring);
> +}
> +
> +/* Whilst this makes a lot of calls to iio_sw_ring functions - it is to device
> + * specific to be rolled into the core.
> + */
> +static void adis16209_trigger_bh_to_ring(struct work_struct *work_s)
> +{
> +	struct adis16209_state *st
> +		= container_of(work_s, struct adis16209_state,
> +			       work_trigger_to_ring);
> +
> +	int i = 0;
> +	s16 *data;
> +	size_t datasize = st->indio_dev
> +		->ring->access.get_bpd(st->indio_dev->ring);
> +
> +	data = kmalloc(datasize , GFP_KERNEL);
> +	if (data == NULL) {
> +		dev_err(&st->us->dev, "memory alloc failed in ring bh");
> +		return;
> +	}
> +
As things currently stand (I think all scan elements are read only) this could
be greatly simplified. (afterall scan count etc are fixed).  However this is
good initial work for moving to scan element selection should anyone want to
in the future (this certainly is not a requirement until someone actually cares!).
> +	if (st->indio_dev->scan_count)
> +		if (adis16209_spi_read_burst(&st->indio_dev->dev, st->rx) >= 0)
> +			for (; i < st->indio_dev->scan_count; i++) {
> +				data[i] = combine_8_to_16(st->rx[i*2+1],
> +							  st->rx[i*2]);
> +			}
> +
> +	/* Guaranteed to be aligned with 8 byte boundary */
> +	if (st->indio_dev->scan_timestamp)
> +		*((s64 *)(data + ((i + 3)/4)*4)) = st->last_timestamp;
> +
> +	st->indio_dev->ring->access.store_to(st->indio_dev->ring,
> +					    (u8 *)data,
> +					    st->last_timestamp);
> +
> +	iio_trigger_notify_done(st->indio_dev->trig);
> +	kfree(data);
> +
> +	return;
> +}
Hehe. That looks suspiciously like something I would have writen a long time
back. Oh. It's still in the lis3l02dq as well. For reference I decided that no,
aligned data is much simpler.  If anyone prefers unalighted they can figure out
how to do it.

> +/* in these circumstances is it better to go with unaligned packing and
> + * deal with the cost?*/
> +static int adis16209_data_rdy_ring_preenable(struct iio_dev *indio_dev)
> +{
> +	size_t size;
> +	dev_dbg(&indio_dev->dev, "%s\n", __func__);
> +	/* Check if there are any scan elements enabled, if not fail*/
> +	if (!(indio_dev->scan_count || indio_dev->scan_timestamp))
> +		return -EINVAL;
> +
> +	if (indio_dev->ring->access.set_bpd) {
> +		if (indio_dev->scan_timestamp)
> +			if (indio_dev->scan_count) /* Timestamp and data */
> +				size = 3*sizeof(s64);
That is nasty.   Please change to something based on actual sizes.  It would
actually be preferable to hard code them to this random looking 3 *.

> +			else /* Timestamp only  */
> +				size = sizeof(s64);
> +		else /* Data only */
> +			size = indio_dev->scan_count*sizeof(s16);
> +		indio_dev->ring->access.set_bpd(indio_dev->ring, size);
> +	}
> +
> +	return 0;
> +}
> +
> +static int adis16209_data_rdy_ring_postenable(struct iio_dev *indio_dev)
> +{
> +	return indio_dev->trig
> +		? iio_trigger_attach_poll_func(indio_dev->trig,
> +					       indio_dev->pollfunc)
> +		: 0;
> +}
> +
> +static int adis16209_data_rdy_ring_predisable(struct iio_dev *indio_dev)
> +{
> +	return indio_dev->trig
> +		? iio_trigger_dettach_poll_func(indio_dev->trig,
> +						indio_dev->pollfunc)
> +		: 0;
> +}
> +
> +void adis16209_unconfigure_ring(struct iio_dev *indio_dev)
> +{
> +	kfree(indio_dev->pollfunc);
> +	iio_sw_rb_free(indio_dev->ring);
> +}
> +
> +int adis16209_configure_ring(struct iio_dev *indio_dev)
> +{
> +	int ret = 0;
> +	struct adis16209_state *st = indio_dev->dev_data;
> +	struct iio_ring_buffer *ring;
> +	INIT_WORK(&st->work_trigger_to_ring, adis16209_trigger_bh_to_ring);
> +	/* Set default scan mode */
> +
Don't know who did this first, but I rather like it. I was just writing
directly to the relevant mask. This is much clearer.
> +	iio_scan_mask_set(indio_dev, iio_scan_el_supply.number);
> +	iio_scan_mask_set(indio_dev, iio_scan_el_rot.number);
> +	iio_scan_mask_set(indio_dev, iio_scan_el_accel_x.number);
> +	iio_scan_mask_set(indio_dev, iio_scan_el_accel_y.number);
> +	iio_scan_mask_set(indio_dev, iio_scan_el_temp.number);
> +	iio_scan_mask_set(indio_dev, iio_scan_el_aux_adc.number);
> +	iio_scan_mask_set(indio_dev, iio_scan_el_incli_x.number);
> +	iio_scan_mask_set(indio_dev, iio_scan_el_incli_y.number);
> +	indio_dev->scan_timestamp = true;
> +
> +	indio_dev->scan_el_attrs = &adis16209_scan_el_group;
> +
> +	ring = iio_sw_rb_allocate(indio_dev);
> +	if (!ring) {
> +		ret = -ENOMEM;
> +		return ret;
> +	}
> +	indio_dev->ring = ring;
> +	/* Effectively select the ring buffer implementation */
> +	iio_ring_sw_register_funcs(&ring->access);
> +	ring->preenable = &adis16209_data_rdy_ring_preenable;
> +	ring->postenable = &adis16209_data_rdy_ring_postenable;
> +	ring->predisable = &adis16209_data_rdy_ring_predisable;
> +	ring->owner = THIS_MODULE;
> +
> +	indio_dev->pollfunc = kzalloc(sizeof(*indio_dev->pollfunc), GFP_KERNEL);
> +	if (indio_dev->pollfunc == NULL) {
> +		ret = -ENOMEM;
> +		goto error_iio_sw_rb_free;;
> +	}
> +	indio_dev->pollfunc->poll_func_main = &adis16209_poll_func_th;
> +	indio_dev->pollfunc->private_data = indio_dev;
> +	indio_dev->modes |= INDIO_RING_TRIGGERED;
> +	return 0;
> +
> +error_iio_sw_rb_free:
> +	iio_sw_rb_free(indio_dev->ring);
> +	return ret;
> +}
> +
> +int adis16209_initialize_ring(struct iio_ring_buffer *ring)
> +{
> +	return iio_ring_buffer_register(ring, 0);
> +}
> +
> +void adis16209_uninitialize_ring(struct iio_ring_buffer *ring)
> +{
> +	iio_ring_buffer_unregister(ring);
> +}
> diff --git a/drivers/staging/iio/accel/adis16209_trigger.c b/drivers/staging/iio/accel/adis16209_trigger.c
> new file mode 100644
> index 0000000..4a0507c
> --- /dev/null
> +++ b/drivers/staging/iio/accel/adis16209_trigger.c
> @@ -0,0 +1,124 @@
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/mutex.h>
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/sysfs.h>
> +#include <linux/list.h>
> +#include <linux/spi/spi.h>
> +
> +#include "../iio.h"
> +#include "../sysfs.h"
> +#include "../trigger.h"
> +#include "adis16209.h"
> +
> +/**
> + * adis16209_data_rdy_trig_poll() the event handler for the data rdy trig
> + **/
> +static int adis16209_data_rdy_trig_poll(struct iio_dev *dev_info,
> +				       int index,
> +				       s64 timestamp,
> +				       int no_test)
> +{
> +	struct adis16209_state *st = iio_dev_get_devdata(dev_info);
> +	struct iio_trigger *trig = st->trig;
> +
> +	trig->timestamp = timestamp;
> +	iio_trigger_poll(trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +IIO_EVENT_SH(data_rdy_trig, &adis16209_data_rdy_trig_poll);
> +
> +static DEVICE_ATTR(name, S_IRUGO, iio_trigger_read_name, NULL);
> +
> +static struct attribute *adis16209_trigger_attrs[] = {
> +	&dev_attr_name.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group adis16209_trigger_attr_group = {
> +	.attrs = adis16209_trigger_attrs,
> +};
> +
> +/**
> + * adis16209_data_rdy_trigger_set_state() set datardy interrupt state
> + **/
> +static int adis16209_data_rdy_trigger_set_state(struct iio_trigger *trig,
> +						bool state)
> +{
> +	struct adis16209_state *st = trig->private_data;
> +	struct iio_dev *indio_dev = st->indio_dev;
> +	int ret = 0;
> +
> +	dev_dbg(&indio_dev->dev, "%s (%d)\n", __func__, state);
> +	ret = adis16209_set_irq(&st->indio_dev->dev, state);
> +	if (state == false) {
> +		iio_remove_event_from_list(&iio_event_data_rdy_trig,
> +					   &indio_dev->interrupts[0]
> +					   ->ev_list);
> +		flush_scheduled_work();
> +	} else {
> +		iio_add_event_to_list(&iio_event_data_rdy_trig,
> +				      &indio_dev->interrupts[0]->ev_list);
> +	}
> +	return ret;
> +}
> +
> +/**
> + * adis16209_trig_try_reen() try renabling irq for data rdy trigger
> + * @trig:	the datardy trigger
> + **/
> +static int adis16209_trig_try_reen(struct iio_trigger *trig)
> +{
> +	struct adis16209_state *st = trig->private_data;
> +	enable_irq(st->us->irq);
> +	return 0;
> +}
> +
> +int adis16209_probe_trigger(struct iio_dev *indio_dev)
> +{
> +	int ret;
> +	struct adis16209_state *st = indio_dev->dev_data;
> +
> +	st->trig = iio_allocate_trigger();
> +	st->trig->name = kmalloc(IIO_TRIGGER_NAME_LENGTH, GFP_KERNEL);
> +	if (!st->trig->name) {
> +		ret = -ENOMEM;
> +		goto error_free_trig;
> +	}
> +	snprintf((char *)st->trig->name,
> +		 IIO_TRIGGER_NAME_LENGTH,
> +		 "adis16209-dev%d", indio_dev->id);
> +	st->trig->dev.parent = &st->us->dev;
> +	st->trig->owner = THIS_MODULE;
> +	st->trig->private_data = st;
> +	st->trig->set_trigger_state = &adis16209_data_rdy_trigger_set_state;
> +	st->trig->try_reenable = &adis16209_trig_try_reen;
> +	st->trig->control_attrs = &adis16209_trigger_attr_group;
> +	ret = iio_trigger_register(st->trig);
> +
> +	/* select default trigger */
> +	indio_dev->trig = st->trig;
> +	if (ret)
> +		goto error_free_trig_name;
> +
> +	return 0;
> +
> +error_free_trig_name:
> +	kfree(st->trig->name);
> +error_free_trig:
> +	iio_free_trigger(st->trig);
> +
> +	return ret;
> +}
> +
> +void adis16209_remove_trigger(struct iio_dev *indio_dev)
> +{
> +	struct adis16209_state *state = indio_dev->dev_data;
> +
> +	iio_trigger_unregister(state->trig);
> +	kfree(state->trig->name);
> +	iio_free_trigger(state->trig);
> +}
