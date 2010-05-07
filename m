Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-33.csi.cam.ac.uk ([131.111.8.133]:47733 "EHLO
	ppsw-33.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752209Ab0EGOWP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 7 May 2010 10:22:15 -0400
Message-ID: <4BE422A9.7030409@cam.ac.uk>
Date: Fri, 07 May 2010 15:24:41 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Barry Song <21cnbao@gmail.com>
CC: linux-iio@vger.kernel.org, Barry Song <Barry.Song@analog.com>
Subject: Re: [PATCH 2/2] staging:iio: adis16240 driver
References: <1273153355-18179-1-git-send-email-jic23@cam.ac.uk> 	<1273153355-18179-2-git-send-email-jic23@cam.ac.uk> <v2t3c17e3571005061954ya1699967zb4f21eb0a339c90f@mail.gmail.com>
In-Reply-To: <v2t3c17e3571005061954ya1699967zb4f21eb0a339c90f@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/07/10 03:54, Barry Song wrote:
> On Thu, May 6, 2010 at 9:42 PM, Jonathan Cameron <jic23@cam.ac.uk> wrote:
>> From: Barry Song <Barry.Song@analog.com>
>>
>> Signed-off-by: Barry Song <Barry.Song@analog.com>
>> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
>> ---
>>
>>  This one is new to the list. Barry informed me that they have completed
>>  testing and hopefully I haven't broken anything. (Barry, please confirm
>>  your sign off, I've put it above to make sure I don't forget it)
> Thanks!
> 
> Signed-off-by: Barry Song <Barry.Song@analog.com>
*Coughs* and we both missed the deliberate mistake. There is no header
in this patch ;)  I'll add that in and send these to Greg now along with
all but the one you nacked from the last series.  Rumour (possibly completely
false) is that we may be very close indeed to the merge window opening.

I'll keep queuing new drivers. If they miss then they can sit in Greg's
for-next tree ready for 2.6.36 from the moment he sets that up.

Jonathan
> 
>>
>>  Changes I've made in merging this with mainline tree:
>>  * Usual renames to add _raw and get rid of volt etc.
>>  * Other changes:
>>   * accel_xpeak -> accel_x_peak_raw
>>   * accel_xyzpeak -> accel_xyz_squared_raw
>>  * I have taken a number of attribute definitions out of accel.h and into
>>   this driver as I am yet to be convinced that they are general enough.
>>   They can move to there at a later date if we get them turning up in a
>>   couple of drivers.
>>  * Checkpatch and sparse related fixes
>>
>> Clearly this is a very interesting chip and there are lots of interesting
>> features not currently supported by the driver.  Still is a very good base
>> to build on.
>>
>>  drivers/staging/iio/accel/Kconfig             |    9 +
>>  drivers/staging/iio/accel/Makefile            |    4 +
>>  drivers/staging/iio/accel/adis16240_core.c    |  599 +++++++++++++++++++++++++
>>  drivers/staging/iio/accel/adis16240_ring.c    |  254 +++++++++++
>>  drivers/staging/iio/accel/adis16240_trigger.c |  124 +++++
>>  5 files changed, 990 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/staging/iio/accel/Kconfig b/drivers/staging/iio/accel/Kconfig
>> index 1d89e21..8f3f70f 100644
>> --- a/drivers/staging/iio/accel/Kconfig
>> +++ b/drivers/staging/iio/accel/Kconfig
>> @@ -12,6 +12,15 @@ config ADIS16209
>>          Say yes here to build support for Analog Devices adis16209 dual-axis digital inclinometer
>>         and accelerometer.
>>
>> +config ADIS16240
>> +       tristate "Analog Devices ADIS16240 Programmable Impact Sensor and Recorder"
>> +       depends on SPI
>> +       select IIO_TRIGGER if IIO_RING_BUFFER
>> +       select IIO_SW_RING if IIO_RING_BUFFER
>> +       help
>> +         Say yes here to build support for Analog Devices adis16240 programmable
>> +        impact Sensor and recorder.
>> +
>>  config KXSD9
>>        tristate "Kionix KXSD9 Accelerometer Driver"
>>        depends on SPI
>> diff --git a/drivers/staging/iio/accel/Makefile b/drivers/staging/iio/accel/Makefile
>> index f8f2124..0e6762c 100644
>> --- a/drivers/staging/iio/accel/Makefile
>> +++ b/drivers/staging/iio/accel/Makefile
>> @@ -5,6 +5,10 @@ adis16209-y             := adis16209_core.o
>>  adis16209-$(CONFIG_IIO_RING_BUFFER) += adis16209_ring.o adis16209_trigger.o
>>  obj-$(CONFIG_ADIS16209) += adis16209.o
>>
>> +adis16240-y             := adis16240_core.o
>> +adis16240-$(CONFIG_IIO_RING_BUFFER) += adis16240_ring.o adis16240_trigger.o
>> +obj-$(CONFIG_ADIS16240) += adis16240.o
>> +
>>  obj-$(CONFIG_KXSD9)    += kxsd9.o
>>
>>  lis3l02dq-y            := lis3l02dq_core.o
>> diff --git a/drivers/staging/iio/accel/adis16240_core.c b/drivers/staging/iio/accel/adis16240_core.c
>> new file mode 100644
>> index 0000000..54fd6d7
>> --- /dev/null
>> +++ b/drivers/staging/iio/accel/adis16240_core.c
>> @@ -0,0 +1,599 @@
>> +/*
>> + * ADIS16240 Programmable Impact Sensor and Recorder driver
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
>> +
>> +#include <linux/sysfs.h>
>> +#include <linux/list.h>
>> +
>> +#include "../iio.h"
>> +#include "../sysfs.h"
>> +#include "accel.h"
>> +#include "../adc/adc.h"
>> +
>> +#include "adis16240.h"
>> +
>> +#define DRIVER_NAME            "adis16240"
>> +
>> +static int adis16240_check_status(struct device *dev);
>> +
>> +/**
>> + * adis16240_spi_write_reg_8() - write single byte to a register
>> + * @dev: device associated with child of actual device (iio_dev or iio_trig)
>> + * @reg_address: the address of the register to be written
>> + * @val: the value to write
>> + **/
>> +static int adis16240_spi_write_reg_8(struct device *dev,
>> +               u8 reg_address,
>> +               u8 val)
>> +{
>> +       int ret;
>> +       struct iio_dev *indio_dev = dev_get_drvdata(dev);
>> +       struct adis16240_state *st = iio_dev_get_devdata(indio_dev);
>> +
>> +       mutex_lock(&st->buf_lock);
>> +       st->tx[0] = ADIS16240_WRITE_REG(reg_address);
>> +       st->tx[1] = val;
>> +
>> +       ret = spi_write(st->us, st->tx, 2);
>> +       mutex_unlock(&st->buf_lock);
>> +
>> +       return ret;
>> +}
>> +
>> +/**
>> + * adis16240_spi_write_reg_16() - write 2 bytes to a pair of registers
>> + * @dev: device associated with child of actual device (iio_dev or iio_trig)
>> + * @reg_address: the address of the lower of the two registers. Second register
>> + *               is assumed to have address one greater.
>> + * @val: value to be written
>> + **/
>> +static int adis16240_spi_write_reg_16(struct device *dev,
>> +               u8 lower_reg_address,
>> +               u16 value)
>> +{
>> +       int ret;
>> +       struct spi_message msg;
>> +       struct iio_dev *indio_dev = dev_get_drvdata(dev);
>> +       struct adis16240_state *st = iio_dev_get_devdata(indio_dev);
>> +       struct spi_transfer xfers[] = {
>> +               {
>> +                       .tx_buf = st->tx,
>> +                       .bits_per_word = 8,
>> +                       .len = 2,
>> +                       .cs_change = 1,
>> +                       .delay_usecs = 25,
>> +               }, {
>> +                       .tx_buf = st->tx + 2,
>> +                       .bits_per_word = 8,
>> +                       .len = 2,
>> +                       .cs_change = 1,
>> +                       .delay_usecs = 25,
>> +               },
>> +       };
>> +
>> +       mutex_lock(&st->buf_lock);
>> +       st->tx[0] = ADIS16240_WRITE_REG(lower_reg_address);
>> +       st->tx[1] = value & 0xFF;
>> +       st->tx[2] = ADIS16240_WRITE_REG(lower_reg_address + 1);
>> +       st->tx[3] = (value >> 8) & 0xFF;
>> +
>> +       spi_message_init(&msg);
>> +       spi_message_add_tail(&xfers[0], &msg);
>> +       spi_message_add_tail(&xfers[1], &msg);
>> +       ret = spi_sync(st->us, &msg);
>> +       mutex_unlock(&st->buf_lock);
>> +
>> +       return ret;
>> +}
>> +
>> +/**
>> + * adis16240_spi_read_reg_16() - read 2 bytes from a 16-bit register
>> + * @dev: device associated with child of actual device (iio_dev or iio_trig)
>> + * @reg_address: the address of the lower of the two registers. Second register
>> + *               is assumed to have address one greater.
>> + * @val: somewhere to pass back the value read
>> + **/
>> +static int adis16240_spi_read_reg_16(struct device *dev,
>> +               u8 lower_reg_address,
>> +               u16 *val)
>> +{
>> +       struct spi_message msg;
>> +       struct iio_dev *indio_dev = dev_get_drvdata(dev);
>> +       struct adis16240_state *st = iio_dev_get_devdata(indio_dev);
>> +       int ret;
>> +       struct spi_transfer xfers[] = {
>> +               {
>> +                       .tx_buf = st->tx,
>> +                       .bits_per_word = 8,
>> +                       .len = 2,
>> +                       .cs_change = 1,
>> +                       .delay_usecs = 25,
>> +               }, {
>> +                       .rx_buf = st->rx,
>> +                       .bits_per_word = 8,
>> +                       .len = 2,
>> +                       .cs_change = 1,
>> +                       .delay_usecs = 25,
>> +               },
>> +       };
>> +
>> +       mutex_lock(&st->buf_lock);
>> +       st->tx[0] = ADIS16240_READ_REG(lower_reg_address);
>> +       st->tx[1] = 0;
>> +       st->tx[2] = 0;
>> +       st->tx[3] = 0;
>> +
>> +       spi_message_init(&msg);
>> +       spi_message_add_tail(&xfers[0], &msg);
>> +       spi_message_add_tail(&xfers[1], &msg);
>> +       ret = spi_sync(st->us, &msg);
>> +       if (ret) {
>> +               dev_err(&st->us->dev,
>> +                       "problem when reading 16 bit register 0x%02X",
>> +                       lower_reg_address);
>> +               goto error_ret;
>> +       }
>> +       *val = (st->rx[0] << 8) | st->rx[1];
>> +
>> +error_ret:
>> +       mutex_unlock(&st->buf_lock);
>> +       return ret;
>> +}
>> +
>> +static ssize_t adis16240_spi_read_signed(struct device *dev,
>> +               struct device_attribute *attr,
>> +               char *buf,
>> +               unsigned bits)
>> +{
>> +       int ret;
>> +       s16 val = 0;
>> +       unsigned shift = 16 - bits;
>> +       struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>> +
>> +       ret = adis16240_spi_read_reg_16(dev, this_attr->address, (u16 *)&val);
>> +       if (ret)
>> +               return ret;
>> +
>> +       if (val & ADIS16240_ERROR_ACTIVE)
>> +               adis16240_check_status(dev);
>> +
>> +       val = ((s16)(val << shift) >> shift);
>> +       return sprintf(buf, "%d\n", val);
>> +}
>> +
>> +static ssize_t adis16240_read_10bit_unsigned(struct device *dev,
>> +               struct device_attribute *attr,
>> +               char *buf)
>> +{
>> +       int ret;
>> +       u16 val = 0;
>> +       struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>> +
>> +       ret = adis16240_spi_read_reg_16(dev, this_attr->address, &val);
>> +       if (ret)
>> +               return ret;
>> +
>> +       if (val & ADIS16240_ERROR_ACTIVE)
>> +               adis16240_check_status(dev);
>> +
>> +       return sprintf(buf, "%u\n", val & 0x03FF);
>> +}
>> +
>> +static ssize_t adis16240_read_10bit_signed(struct device *dev,
>> +               struct device_attribute *attr,
>> +               char *buf)
>> +{
>> +       struct iio_dev *indio_dev = dev_get_drvdata(dev);
>> +       ssize_t ret;
>> +
>> +       /* Take the iio_dev status lock */
>> +       mutex_lock(&indio_dev->mlock);
>> +       ret =  adis16240_spi_read_signed(dev, attr, buf, 10);
>> +       mutex_unlock(&indio_dev->mlock);
>> +
>> +       return ret;
>> +}
>> +
>> +static ssize_t adis16240_read_12bit_signed(struct device *dev,
>> +               struct device_attribute *attr,
>> +               char *buf)
>> +{
>> +       struct iio_dev *indio_dev = dev_get_drvdata(dev);
>> +       ssize_t ret;
>> +
>> +       /* Take the iio_dev status lock */
>> +       mutex_lock(&indio_dev->mlock);
>> +       ret =  adis16240_spi_read_signed(dev, attr, buf, 12);
>> +       mutex_unlock(&indio_dev->mlock);
>> +
>> +       return ret;
>> +}
>> +
>> +static ssize_t adis16240_write_16bit(struct device *dev,
>> +               struct device_attribute *attr,
>> +               const char *buf,
>> +               size_t len)
>> +{
>> +       struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>> +       int ret;
>> +       long val;
>> +
>> +       ret = strict_strtol(buf, 10, &val);
>> +       if (ret)
>> +               goto error_ret;
>> +       ret = adis16240_spi_write_reg_16(dev, this_attr->address, val);
>> +
>> +error_ret:
>> +       return ret ? ret : len;
>> +}
>> +
>> +static int adis16240_reset(struct device *dev)
>> +{
>> +       int ret;
>> +       ret = adis16240_spi_write_reg_8(dev,
>> +                       ADIS16240_GLOB_CMD,
>> +                       ADIS16240_GLOB_CMD_SW_RESET);
>> +       if (ret)
>> +               dev_err(dev, "problem resetting device");
>> +
>> +       return ret;
>> +}
>> +
>> +static ssize_t adis16240_write_reset(struct device *dev,
>> +               struct device_attribute *attr,
>> +               const char *buf, size_t len)
>> +{
>> +       if (len < 1)
>> +               return -EINVAL;
>> +       switch (buf[0]) {
>> +       case '1':
>> +       case 'y':
>> +       case 'Y':
>> +               return adis16240_reset(dev);
>> +       }
>> +       return -EINVAL;
>> +}
>> +
>> +int adis16240_set_irq(struct device *dev, bool enable)
>> +{
>> +       int ret = 0;
>> +       u16 msc;
>> +
>> +       ret = adis16240_spi_read_reg_16(dev, ADIS16240_MSC_CTRL, &msc);
>> +       if (ret)
>> +               goto error_ret;
>> +
>> +       msc |= ADIS16240_MSC_CTRL_ACTIVE_HIGH;
>> +       msc &= ~ADIS16240_MSC_CTRL_DATA_RDY_DIO2;
>> +       if (enable)
>> +               msc |= ADIS16240_MSC_CTRL_DATA_RDY_EN;
>> +       else
>> +               msc &= ~ADIS16240_MSC_CTRL_DATA_RDY_EN;
>> +
>> +       ret = adis16240_spi_write_reg_16(dev, ADIS16240_MSC_CTRL, msc);
>> +
>> +error_ret:
>> +       return ret;
>> +}
>> +
>> +static int adis16240_self_test(struct device *dev)
>> +{
>> +       int ret;
>> +       ret = adis16240_spi_write_reg_16(dev,
>> +                       ADIS16240_MSC_CTRL,
>> +                       ADIS16240_MSC_CTRL_SELF_TEST_EN);
>> +       if (ret) {
>> +               dev_err(dev, "problem starting self test");
>> +               goto err_ret;
>> +       }
>> +
>> +       msleep(ADIS16240_STARTUP_DELAY);
>> +
>> +       adis16240_check_status(dev);
>> +
>> +err_ret:
>> +       return ret;
>> +}
>> +
>> +static int adis16240_check_status(struct device *dev)
>> +{
>> +       u16 status;
>> +       int ret;
>> +
>> +       ret = adis16240_spi_read_reg_16(dev, ADIS16240_DIAG_STAT, &status);
>> +
>> +       if (ret < 0) {
>> +               dev_err(dev, "Reading status failed\n");
>> +               goto error_ret;
>> +       }
>> +
>> +       ret = status & 0x2F;
>> +       if (status & ADIS16240_DIAG_STAT_PWRON_FAIL)
>> +               dev_err(dev, "Power-on, self-test fail\n");
>> +       if (status & ADIS16240_DIAG_STAT_SPI_FAIL)
>> +               dev_err(dev, "SPI failure\n");
>> +       if (status & ADIS16240_DIAG_STAT_FLASH_UPT)
>> +               dev_err(dev, "Flash update failed\n");
>> +       if (status & ADIS16240_DIAG_STAT_POWER_HIGH)
>> +               dev_err(dev, "Power supply above 3.625V\n");
>> +       if (status & ADIS16240_DIAG_STAT_POWER_LOW)
>> +               dev_err(dev, "Power supply below 2.225V\n");
>> +
>> +error_ret:
>> +       return ret;
>> +}
>> +
>> +static int adis16240_initial_setup(struct adis16240_state *st)
>> +{
>> +       int ret;
>> +       struct device *dev = &st->indio_dev->dev;
>> +
>> +       /* Disable IRQ */
>> +       ret = adis16240_set_irq(dev, false);
>> +       if (ret) {
>> +               dev_err(dev, "disable irq failed");
>> +               goto err_ret;
>> +       }
>> +
>> +       /* Do self test */
>> +       ret = adis16240_self_test(dev);
>> +       if (ret) {
>> +               dev_err(dev, "self test failure");
>> +               goto err_ret;
>> +       }
>> +
>> +       /* Read status register to check the result */
>> +       ret = adis16240_check_status(dev);
>> +       if (ret) {
>> +               adis16240_reset(dev);
>> +               dev_err(dev, "device not playing ball -> reset");
>> +               msleep(ADIS16240_STARTUP_DELAY);
>> +               ret = adis16240_check_status(dev);
>> +               if (ret) {
>> +                       dev_err(dev, "giving up");
>> +                       goto err_ret;
>> +               }
>> +       }
>> +
>> +       printk(KERN_INFO DRIVER_NAME ": at CS%d (irq %d)\n",
>> +                       st->us->chip_select, st->us->irq);
>> +
>> +err_ret:
>> +       return ret;
>> +}
>> +
>> +static IIO_DEV_ATTR_IN_NAMED_RAW(supply, adis16240_read_10bit_unsigned,
>> +               ADIS16240_SUPPLY_OUT);
>> +static IIO_DEV_ATTR_IN_RAW(0, adis16240_read_10bit_signed,
>> +               ADIS16240_AUX_ADC);
>> +static IIO_CONST_ATTR(in_supply_scale, "0.00488");
>> +static IIO_DEV_ATTR_ACCEL_X(adis16240_read_10bit_signed,
>> +               ADIS16240_XACCL_OUT);
>> +static IIO_DEVICE_ATTR(accel_x_peak_raw, S_IRUGO,
>> +                      adis16240_read_10bit_signed, NULL,
>> +                      ADIS16240_XPEAK_OUT);
>> +static IIO_DEV_ATTR_ACCEL_Y(adis16240_read_10bit_signed,
>> +               ADIS16240_YACCL_OUT);
>> +static IIO_DEVICE_ATTR(accel_y_peak_raw, S_IRUGO,
>> +                      adis16240_read_10bit_signed, NULL,
>> +                      ADIS16240_YPEAK_OUT);
>> +static IIO_DEV_ATTR_ACCEL_Z(adis16240_read_10bit_signed,
>> +               ADIS16240_ZACCL_OUT);
>> +static IIO_DEVICE_ATTR(accel_z_peak_raw, S_IRUGO,
>> +                      adis16240_read_10bit_signed, NULL,
>> +                      ADIS16240_ZPEAK_OUT);
>> +
>> +static IIO_DEVICE_ATTR(accel_xyz_squared_peak_raw, S_IRUGO,
>> +                      adis16240_read_12bit_signed, NULL,
>> +                      ADIS16240_XYZPEAK_OUT);
>> +static IIO_DEV_ATTR_ACCEL_X_OFFSET(S_IWUSR | S_IRUGO,
>> +               adis16240_read_10bit_signed,
>> +               adis16240_write_16bit,
>> +               ADIS16240_XACCL_OFF);
>> +static IIO_DEV_ATTR_ACCEL_Y_OFFSET(S_IWUSR | S_IRUGO,
>> +               adis16240_read_10bit_signed,
>> +               adis16240_write_16bit,
>> +               ADIS16240_YACCL_OFF);
>> +static IIO_DEV_ATTR_ACCEL_Z_OFFSET(S_IWUSR | S_IRUGO,
>> +               adis16240_read_10bit_signed,
>> +               adis16240_write_16bit,
>> +               ADIS16240_ZACCL_OFF);
>> +static IIO_DEV_ATTR_TEMP_RAW(adis16240_read_10bit_unsigned);
>> +static IIO_CONST_ATTR(temp_scale, "0.244");
>> +
>> +static IIO_DEVICE_ATTR(reset, S_IWUSR, NULL, adis16240_write_reset, 0);
>> +
>> +static IIO_CONST_ATTR_AVAIL_SAMP_FREQ("4096");
>> +
>> +static IIO_CONST_ATTR(name, "adis16240");
>> +
>> +static struct attribute *adis16240_event_attributes[] = {
>> +       NULL
>> +};
>> +
>> +static struct attribute_group adis16240_event_attribute_group = {
>> +       .attrs = adis16240_event_attributes,
>> +};
>> +
>> +static struct attribute *adis16240_attributes[] = {
>> +       &iio_dev_attr_in_supply_raw.dev_attr.attr,
>> +       &iio_const_attr_in_supply_scale.dev_attr.attr,
>> +       &iio_dev_attr_in0_raw.dev_attr.attr,
>> +       &iio_dev_attr_accel_x_raw.dev_attr.attr,
>> +       &iio_dev_attr_accel_x_offset.dev_attr.attr,
>> +       &iio_dev_attr_accel_x_peak_raw.dev_attr.attr,
>> +       &iio_dev_attr_accel_y_raw.dev_attr.attr,
>> +       &iio_dev_attr_accel_y_offset.dev_attr.attr,
>> +       &iio_dev_attr_accel_y_peak_raw.dev_attr.attr,
>> +       &iio_dev_attr_accel_z_raw.dev_attr.attr,
>> +       &iio_dev_attr_accel_z_offset.dev_attr.attr,
>> +       &iio_dev_attr_accel_z_peak_raw.dev_attr.attr,
>> +       &iio_dev_attr_accel_xyz_squared_peak_raw.dev_attr.attr,
>> +       &iio_dev_attr_temp_raw.dev_attr.attr,
>> +       &iio_const_attr_temp_scale.dev_attr.attr,
>> +       &iio_const_attr_available_sampling_frequency.dev_attr.attr,
>> +       &iio_dev_attr_reset.dev_attr.attr,
>> +       &iio_const_attr_name.dev_attr.attr,
>> +       NULL
>> +};
>> +
>> +static const struct attribute_group adis16240_attribute_group = {
>> +       .attrs = adis16240_attributes,
>> +};
>> +
>> +static int __devinit adis16240_probe(struct spi_device *spi)
>> +{
>> +       int ret, regdone = 0;
>> +       struct adis16240_state *st = kzalloc(sizeof *st, GFP_KERNEL);
>> +       if (!st) {
>> +               ret =  -ENOMEM;
>> +               goto error_ret;
>> +       }
>> +       /* this is only used for removal purposes */
>> +       spi_set_drvdata(spi, st);
>> +
>> +       /* Allocate the comms buffers */
>> +       st->rx = kzalloc(sizeof(*st->rx)*ADIS16240_MAX_RX, GFP_KERNEL);
>> +       if (st->rx == NULL) {
>> +               ret = -ENOMEM;
>> +               goto error_free_st;
>> +       }
>> +       st->tx = kzalloc(sizeof(*st->tx)*ADIS16240_MAX_TX, GFP_KERNEL);
>> +       if (st->tx == NULL) {
>> +               ret = -ENOMEM;
>> +               goto error_free_rx;
>> +       }
>> +       st->us = spi;
>> +       mutex_init(&st->buf_lock);
>> +       /* setup the industrialio driver allocated elements */
>> +       st->indio_dev = iio_allocate_device();
>> +       if (st->indio_dev == NULL) {
>> +               ret = -ENOMEM;
>> +               goto error_free_tx;
>> +       }
>> +
>> +       st->indio_dev->dev.parent = &spi->dev;
>> +       st->indio_dev->num_interrupt_lines = 1;
>> +       st->indio_dev->event_attrs = &adis16240_event_attribute_group;
>> +       st->indio_dev->attrs = &adis16240_attribute_group;
>> +       st->indio_dev->dev_data = (void *)(st);
>> +       st->indio_dev->driver_module = THIS_MODULE;
>> +       st->indio_dev->modes = INDIO_DIRECT_MODE;
>> +
>> +       ret = adis16240_configure_ring(st->indio_dev);
>> +       if (ret)
>> +               goto error_free_dev;
>> +
>> +       ret = iio_device_register(st->indio_dev);
>> +       if (ret)
>> +               goto error_unreg_ring_funcs;
>> +       regdone = 1;
>> +
>> +       ret = adis16240_initialize_ring(st->indio_dev->ring);
>> +       if (ret) {
>> +               printk(KERN_ERR "failed to initialize the ring\n");
>> +               goto error_unreg_ring_funcs;
>> +       }
>> +
>> +       if (spi->irq) {
>> +               ret = iio_register_interrupt_line(spi->irq,
>> +                               st->indio_dev,
>> +                               0,
>> +                               IRQF_TRIGGER_RISING,
>> +                               "adis16240");
>> +               if (ret)
>> +                       goto error_uninitialize_ring;
>> +
>> +               ret = adis16240_probe_trigger(st->indio_dev);
>> +               if (ret)
>> +                       goto error_unregister_line;
>> +       }
>> +
>> +       /* Get the device into a sane initial state */
>> +       ret = adis16240_initial_setup(st);
>> +       if (ret)
>> +               goto error_remove_trigger;
>> +       return 0;
>> +
>> +error_remove_trigger:
>> +       adis16240_remove_trigger(st->indio_dev);
>> +error_unregister_line:
>> +       if (spi->irq)
>> +               iio_unregister_interrupt_line(st->indio_dev, 0);
>> +error_uninitialize_ring:
>> +       adis16240_uninitialize_ring(st->indio_dev->ring);
>> +error_unreg_ring_funcs:
>> +       adis16240_unconfigure_ring(st->indio_dev);
>> +error_free_dev:
>> +       if (regdone)
>> +               iio_device_unregister(st->indio_dev);
>> +       else
>> +               iio_free_device(st->indio_dev);
>> +error_free_tx:
>> +       kfree(st->tx);
>> +error_free_rx:
>> +       kfree(st->rx);
>> +error_free_st:
>> +       kfree(st);
>> +error_ret:
>> +       return ret;
>> +}
>> +
>> +static int adis16240_remove(struct spi_device *spi)
>> +{
>> +       struct adis16240_state *st = spi_get_drvdata(spi);
>> +       struct iio_dev *indio_dev = st->indio_dev;
>> +
>> +       flush_scheduled_work();
>> +
>> +       adis16240_remove_trigger(indio_dev);
>> +       if (spi->irq)
>> +               iio_unregister_interrupt_line(indio_dev, 0);
>> +
>> +       adis16240_uninitialize_ring(indio_dev->ring);
>> +       iio_device_unregister(indio_dev);
>> +       adis16240_unconfigure_ring(indio_dev);
>> +       kfree(st->tx);
>> +       kfree(st->rx);
>> +       kfree(st);
>> +
>> +       return 0;
>> +}
>> +
>> +static struct spi_driver adis16240_driver = {
>> +       .driver = {
>> +               .name = "adis16240",
>> +               .owner = THIS_MODULE,
>> +       },
>> +       .probe = adis16240_probe,
>> +       .remove = __devexit_p(adis16240_remove),
>> +};
>> +
>> +static __init int adis16240_init(void)
>> +{
>> +       return spi_register_driver(&adis16240_driver);
>> +}
>> +module_init(adis16240_init);
>> +
>> +static __exit void adis16240_exit(void)
>> +{
>> +       spi_unregister_driver(&adis16240_driver);
>> +}
>> +module_exit(adis16240_exit);
>> +
>> +MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
>> +MODULE_DESCRIPTION("Analog Devices Programmable Impact Sensor and Recorder");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/drivers/staging/iio/accel/adis16240_ring.c b/drivers/staging/iio/accel/adis16240_ring.c
>> new file mode 100644
>> index 0000000..26b677b
>> --- /dev/null
>> +++ b/drivers/staging/iio/accel/adis16240_ring.c
>> @@ -0,0 +1,254 @@
>> +#include <linux/interrupt.h>
>> +#include <linux/irq.h>
>> +#include <linux/gpio.h>
>> +#include <linux/workqueue.h>
>> +#include <linux/mutex.h>
>> +#include <linux/device.h>
>> +#include <linux/kernel.h>
>> +#include <linux/spi/spi.h>
>> +#include <linux/sysfs.h>
>> +#include <linux/list.h>
>> +
>> +#include "../iio.h"
>> +#include "../sysfs.h"
>> +#include "../ring_sw.h"
>> +#include "accel.h"
>> +#include "../trigger.h"
>> +#include "adis16240.h"
>> +
>> +/**
>> + * combine_8_to_16() utility function to munge to u8s into u16
>> + **/
>> +static inline u16 combine_8_to_16(u8 lower, u8 upper)
>> +{
>> +       u16 _lower = lower;
>> +       u16 _upper = upper;
>> +       return _lower | (_upper << 8);
>> +}
>> +
>> +static IIO_SCAN_EL_C(supply, ADIS16240_SCAN_SUPPLY, IIO_UNSIGNED(10),
>> +               ADIS16240_SUPPLY_OUT, NULL);
>> +static IIO_SCAN_EL_C(accel_x, ADIS16240_SCAN_ACC_X, IIO_SIGNED(10),
>> +               ADIS16240_XACCL_OUT, NULL);
>> +static IIO_SCAN_EL_C(accel_y, ADIS16240_SCAN_ACC_Y, IIO_SIGNED(10),
>> +               ADIS16240_YACCL_OUT, NULL);
>> +static IIO_SCAN_EL_C(accel_z, ADIS16240_SCAN_ACC_Z, IIO_SIGNED(10),
>> +               ADIS16240_ZACCL_OUT, NULL);
>> +static IIO_SCAN_EL_C(aux_adc, ADIS16240_SCAN_AUX_ADC, IIO_UNSIGNED(10),
>> +               ADIS16240_AUX_ADC, NULL);
>> +static IIO_SCAN_EL_C(temp, ADIS16240_SCAN_TEMP, IIO_UNSIGNED(10),
>> +               ADIS16240_TEMP_OUT, NULL);
>> +
>> +static IIO_SCAN_EL_TIMESTAMP(6);
>> +
>> +static struct attribute *adis16240_scan_el_attrs[] = {
>> +       &iio_scan_el_supply.dev_attr.attr,
>> +       &iio_scan_el_accel_x.dev_attr.attr,
>> +       &iio_scan_el_accel_y.dev_attr.attr,
>> +       &iio_scan_el_accel_z.dev_attr.attr,
>> +       &iio_scan_el_aux_adc.dev_attr.attr,
>> +       &iio_scan_el_temp.dev_attr.attr,
>> +       &iio_scan_el_timestamp.dev_attr.attr,
>> +       NULL,
>> +};
>> +
>> +static struct attribute_group adis16240_scan_el_group = {
>> +       .attrs = adis16240_scan_el_attrs,
>> +       .name = "scan_elements",
>> +};
>> +
>> +/**
>> + * adis16240_poll_func_th() top half interrupt handler called by trigger
>> + * @private_data:      iio_dev
>> + **/
>> +static void adis16240_poll_func_th(struct iio_dev *indio_dev)
>> +{
>> +       struct adis16240_state *st = iio_dev_get_devdata(indio_dev);
>> +       st->last_timestamp = indio_dev->trig->timestamp;
>> +       schedule_work(&st->work_trigger_to_ring);
>> +}
>> +
>> +/**
>> + * adis16240_read_ring_data() read data registers which will be placed into ring
>> + * @dev: device associated with child of actual device (iio_dev or iio_trig)
>> + * @rx: somewhere to pass back the value read
>> + **/
>> +static int adis16240_read_ring_data(struct device *dev, u8 *rx)
>> +{
>> +       struct spi_message msg;
>> +       struct iio_dev *indio_dev = dev_get_drvdata(dev);
>> +       struct adis16240_state *st = iio_dev_get_devdata(indio_dev);
>> +       struct spi_transfer xfers[ADIS16240_OUTPUTS + 1];
>> +       int ret;
>> +       int i;
>> +
>> +       mutex_lock(&st->buf_lock);
>> +
>> +       spi_message_init(&msg);
>> +
>> +       memset(xfers, 0, sizeof(xfers));
>> +       for (i = 0; i <= ADIS16240_OUTPUTS; i++) {
>> +               xfers[i].bits_per_word = 8;
>> +               xfers[i].cs_change = 1;
>> +               xfers[i].len = 2;
>> +               xfers[i].delay_usecs = 30;
>> +               xfers[i].tx_buf = st->tx + 2 * i;
>> +               st->tx[2 * i]
>> +                       = ADIS16240_READ_REG(ADIS16240_SUPPLY_OUT + 2 * i);
>> +               st->tx[2 * i + 1] = 0;
>> +               if (i >= 1)
>> +                       xfers[i].rx_buf = rx + 2 * (i - 1);
>> +               spi_message_add_tail(&xfers[i], &msg);
>> +       }
>> +
>> +       ret = spi_sync(st->us, &msg);
>> +       if (ret)
>> +               dev_err(&st->us->dev, "problem when burst reading");
>> +
>> +       mutex_unlock(&st->buf_lock);
>> +
>> +       return ret;
>> +}
>> +
>> +
>> +static void adis16240_trigger_bh_to_ring(struct work_struct *work_s)
>> +{
>> +       struct adis16240_state *st
>> +               = container_of(work_s, struct adis16240_state,
>> +                               work_trigger_to_ring);
>> +
>> +       int i = 0;
>> +       s16 *data;
>> +       size_t datasize = st->indio_dev
>> +               ->ring->access.get_bpd(st->indio_dev->ring);
>> +
>> +       data = kmalloc(datasize , GFP_KERNEL);
>> +       if (data == NULL) {
>> +               dev_err(&st->us->dev, "memory alloc failed in ring bh");
>> +               return;
>> +       }
>> +
>> +       if (st->indio_dev->scan_count)
>> +               if (adis16240_read_ring_data(&st->indio_dev->dev, st->rx) >= 0)
>> +                       for (; i < st->indio_dev->scan_count; i++) {
>> +                               data[i] = combine_8_to_16(st->rx[i*2+1],
>> +                                               st->rx[i*2]);
>> +                       }
>> +
>> +       /* Guaranteed to be aligned with 8 byte boundary */
>> +       if (st->indio_dev->scan_timestamp)
>> +               *((s64 *)(data + ((i + 3)/4)*4)) = st->last_timestamp;
>> +
>> +       st->indio_dev->ring->access.store_to(st->indio_dev->ring,
>> +                       (u8 *)data,
>> +                       st->last_timestamp);
>> +
>> +       iio_trigger_notify_done(st->indio_dev->trig);
>> +       kfree(data);
>> +
>> +       return;
>> +}
>> +
>> +static int adis16240_data_rdy_ring_preenable(struct iio_dev *indio_dev)
>> +{
>> +       size_t size;
>> +       dev_dbg(&indio_dev->dev, "%s\n", __func__);
>> +       /* Check if there are any scan elements enabled, if not fail*/
>> +       if (!(indio_dev->scan_count || indio_dev->scan_timestamp))
>> +               return -EINVAL;
>> +
>> +       if (indio_dev->ring->access.set_bpd) {
>> +               if (indio_dev->scan_timestamp)
>> +                       if (indio_dev->scan_count)
>> +                               /* Timestamp (aligned sizeof(s64) and data */
>> +                               size = (((indio_dev->scan_count * sizeof(s16))
>> +                                        + sizeof(s64) - 1)
>> +                                       & ~(sizeof(s64) - 1))
>> +                                       + sizeof(s64);
>> +                       else /* Timestamp only  */
>> +                               size = sizeof(s64);
>> +               else /* Data only */
>> +                       size = indio_dev->scan_count*sizeof(s16);
>> +               indio_dev->ring->access.set_bpd(indio_dev->ring, size);
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static int adis16240_data_rdy_ring_postenable(struct iio_dev *indio_dev)
>> +{
>> +       return indio_dev->trig
>> +               ? iio_trigger_attach_poll_func(indio_dev->trig,
>> +                               indio_dev->pollfunc)
>> +               : 0;
>> +}
>> +
>> +static int adis16240_data_rdy_ring_predisable(struct iio_dev *indio_dev)
>> +{
>> +       return indio_dev->trig
>> +               ? iio_trigger_dettach_poll_func(indio_dev->trig,
>> +                               indio_dev->pollfunc)
>> +               : 0;
>> +}
>> +
>> +void adis16240_unconfigure_ring(struct iio_dev *indio_dev)
>> +{
>> +       kfree(indio_dev->pollfunc);
>> +       iio_sw_rb_free(indio_dev->ring);
>> +}
>> +
>> +int adis16240_configure_ring(struct iio_dev *indio_dev)
>> +{
>> +       int ret = 0;
>> +       struct adis16240_state *st = indio_dev->dev_data;
>> +       struct iio_ring_buffer *ring;
>> +       INIT_WORK(&st->work_trigger_to_ring, adis16240_trigger_bh_to_ring);
>> +       /* Set default scan mode */
>> +
>> +       iio_scan_mask_set(indio_dev, iio_scan_el_supply.number);
>> +       iio_scan_mask_set(indio_dev, iio_scan_el_accel_x.number);
>> +       iio_scan_mask_set(indio_dev, iio_scan_el_accel_y.number);
>> +       iio_scan_mask_set(indio_dev, iio_scan_el_accel_z.number);
>> +       iio_scan_mask_set(indio_dev, iio_scan_el_temp.number);
>> +       iio_scan_mask_set(indio_dev, iio_scan_el_aux_adc.number);
>> +       indio_dev->scan_timestamp = true;
>> +
>> +       indio_dev->scan_el_attrs = &adis16240_scan_el_group;
>> +
>> +       ring = iio_sw_rb_allocate(indio_dev);
>> +       if (!ring) {
>> +               ret = -ENOMEM;
>> +               return ret;
>> +       }
>> +       indio_dev->ring = ring;
>> +       /* Effectively select the ring buffer implementation */
>> +       iio_ring_sw_register_funcs(&ring->access);
>> +       ring->preenable = &adis16240_data_rdy_ring_preenable;
>> +       ring->postenable = &adis16240_data_rdy_ring_postenable;
>> +       ring->predisable = &adis16240_data_rdy_ring_predisable;
>> +       ring->owner = THIS_MODULE;
>> +
>> +       indio_dev->pollfunc = kzalloc(sizeof(*indio_dev->pollfunc), GFP_KERNEL);
>> +       if (indio_dev->pollfunc == NULL) {
>> +               ret = -ENOMEM;
>> +               goto error_iio_sw_rb_free;;
>> +       }
>> +       indio_dev->pollfunc->poll_func_main = &adis16240_poll_func_th;
>> +       indio_dev->pollfunc->private_data = indio_dev;
>> +       indio_dev->modes |= INDIO_RING_TRIGGERED;
>> +       return 0;
>> +
>> +error_iio_sw_rb_free:
>> +       iio_sw_rb_free(indio_dev->ring);
>> +       return ret;
>> +}
>> +
>> +int adis16240_initialize_ring(struct iio_ring_buffer *ring)
>> +{
>> +       return iio_ring_buffer_register(ring, 0);
>> +}
>> +
>> +void adis16240_uninitialize_ring(struct iio_ring_buffer *ring)
>> +{
>> +       iio_ring_buffer_unregister(ring);
>> +}
>> diff --git a/drivers/staging/iio/accel/adis16240_trigger.c b/drivers/staging/iio/accel/adis16240_trigger.c
>> new file mode 100644
>> index 0000000..df1312e
>> --- /dev/null
>> +++ b/drivers/staging/iio/accel/adis16240_trigger.c
>> @@ -0,0 +1,124 @@
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
>> +#include "adis16240.h"
>> +
>> +/**
>> + * adis16240_data_rdy_trig_poll() the event handler for the data rdy trig
>> + **/
>> +static int adis16240_data_rdy_trig_poll(struct iio_dev *dev_info,
>> +                                      int index,
>> +                                      s64 timestamp,
>> +                                      int no_test)
>> +{
>> +       struct adis16240_state *st = iio_dev_get_devdata(dev_info);
>> +       struct iio_trigger *trig = st->trig;
>> +
>> +       trig->timestamp = timestamp;
>> +       iio_trigger_poll(trig);
>> +
>> +       return IRQ_HANDLED;
>> +}
>> +
>> +IIO_EVENT_SH(data_rdy_trig, &adis16240_data_rdy_trig_poll);
>> +
>> +static DEVICE_ATTR(name, S_IRUGO, iio_trigger_read_name, NULL);
>> +
>> +static struct attribute *adis16240_trigger_attrs[] = {
>> +       &dev_attr_name.attr,
>> +       NULL,
>> +};
>> +
>> +static const struct attribute_group adis16240_trigger_attr_group = {
>> +       .attrs = adis16240_trigger_attrs,
>> +};
>> +
>> +/**
>> + * adis16240_data_rdy_trigger_set_state() set datardy interrupt state
>> + **/
>> +static int adis16240_data_rdy_trigger_set_state(struct iio_trigger *trig,
>> +                                               bool state)
>> +{
>> +       struct adis16240_state *st = trig->private_data;
>> +       struct iio_dev *indio_dev = st->indio_dev;
>> +       int ret = 0;
>> +
>> +       dev_dbg(&indio_dev->dev, "%s (%d)\n", __func__, state);
>> +       ret = adis16240_set_irq(&st->indio_dev->dev, state);
>> +       if (state == false) {
>> +               iio_remove_event_from_list(&iio_event_data_rdy_trig,
>> +                                          &indio_dev->interrupts[0]
>> +                                          ->ev_list);
>> +               flush_scheduled_work();
>> +       } else {
>> +               iio_add_event_to_list(&iio_event_data_rdy_trig,
>> +                                     &indio_dev->interrupts[0]->ev_list);
>> +       }
>> +       return ret;
>> +}
>> +
>> +/**
>> + * adis16240_trig_try_reen() try renabling irq for data rdy trigger
>> + * @trig:      the datardy trigger
>> + **/
>> +static int adis16240_trig_try_reen(struct iio_trigger *trig)
>> +{
>> +       struct adis16240_state *st = trig->private_data;
>> +       enable_irq(st->us->irq);
>> +       return 0;
>> +}
>> +
>> +int adis16240_probe_trigger(struct iio_dev *indio_dev)
>> +{
>> +       int ret;
>> +       struct adis16240_state *st = indio_dev->dev_data;
>> +
>> +       st->trig = iio_allocate_trigger();
>> +       st->trig->name = kmalloc(IIO_TRIGGER_NAME_LENGTH, GFP_KERNEL);
>> +       if (!st->trig->name) {
>> +               ret = -ENOMEM;
>> +               goto error_free_trig;
>> +       }
>> +       snprintf((char *)st->trig->name,
>> +                IIO_TRIGGER_NAME_LENGTH,
>> +                "adis16240-dev%d", indio_dev->id);
>> +       st->trig->dev.parent = &st->us->dev;
>> +       st->trig->owner = THIS_MODULE;
>> +       st->trig->private_data = st;
>> +       st->trig->set_trigger_state = &adis16240_data_rdy_trigger_set_state;
>> +       st->trig->try_reenable = &adis16240_trig_try_reen;
>> +       st->trig->control_attrs = &adis16240_trigger_attr_group;
>> +       ret = iio_trigger_register(st->trig);
>> +
>> +       /* select default trigger */
>> +       indio_dev->trig = st->trig;
>> +       if (ret)
>> +               goto error_free_trig_name;
>> +
>> +       return 0;
>> +
>> +error_free_trig_name:
>> +       kfree(st->trig->name);
>> +error_free_trig:
>> +       iio_free_trigger(st->trig);
>> +
>> +       return ret;
>> +}
>> +
>> +void adis16240_remove_trigger(struct iio_dev *indio_dev)
>> +{
>> +       struct adis16240_state *state = indio_dev->dev_data;
>> +
>> +       iio_trigger_unregister(state->trig);
>> +       kfree(state->trig->name);
>> +       iio_free_trigger(state->trig);
>> +}
>> --
>> 1.6.4.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

