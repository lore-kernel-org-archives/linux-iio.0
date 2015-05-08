Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48200 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751097AbbEHT47 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 8 May 2015 15:56:59 -0400
Message-ID: <554D1509.7010202@ti.com>
Date: Fri, 8 May 2015 14:56:57 -0500
From: Dan Murphy <dmurphy@ti.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 3/3] iio: heart_monitor: Add TI afe4403 heart monitor
References: <1429720331-1900-1-git-send-email-dmurphy@ti.com> <1429720331-1900-4-git-send-email-dmurphy@ti.com> <553D3091.7010900@kernel.org> <5540CE3A.1000605@ti.com> <554BEC70.2060406@kernel.org>
In-Reply-To: <554BEC70.2060406@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/07/2015 05:51 PM, Jonathan Cameron wrote:
> On 29/04/15 13:27, Dan Murphy wrote:
>> Honathan
>>
>> Again thanks for the review!
>>
>> On 04/26/2015 01:38 PM, Jonathan Cameron wrote:
>>> On 22/04/15 17:32, Dan Murphy wrote:
>>>> Add the TI afe4403 heart rate monitor.
>>>> This device detects reflected LED
>>>> wave length fluctuations and presents an ADC
>>>> value to the user space to be converted to a
>>>> heart rate.
>>>>
>>>> Data sheet located here:
>>>> http://www.ti.com/product/AFE4403/datasheet
>>>>
>>>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>>> Hi Dan,
>>>
>>> Good to see this coming back again!
>>>
>>> Anyhow, various comments inline, but the biggest issue is the ABI usage.
>>> Please take a long hard look at the ABI docs (Documentation/ABI/test/sysfs-bus-iio*) and the use that is being made of them here.  This doesn't conform to
>>> the ABI in a number of places and there is no documentation to imply that
>>> it is creating new ABI.
>>>
>>> There are 4 input channels here Ambient1, Ambient2, led1 and led2.
>>> We also have a two differential channels - though as these are seperated in
>>> time it's just (I think) for convenience.
>>>
>>> These can then feed back to ambient cancellation DACs thus hopefully giving
>>> just the nice led signals an allowing measurement of Pleth (which is what
>>> we are aiming for?)
>>> So two output DAC channels, use extended name to say what they are.
>>> out_voltage0_ambientcancelation (perhaps...)  OR... Perhaps it would
>>> be preferable to treat this as a caliboffset to the input channels.
>>> (I think I prefer this second option).
>>>
>>> Your other channels allow manipulation of the signal chain - I think these
>>> pretty much boil down to gains of one type or another?  If we don't have
>>> a suitable ABI element for all of them then propose it, but they don't
>>> look like output channels to me.
>>>
>>> You do have LED controls however which might be representable as output
>>> channels, but they need to be more clearly described than below.
>>>
>>> One big issue here is that this isn't actually pulse measurement device
>>> at all. It's measuring the pleth signal (photoplethysmography - which here
>>> is just a light intensity measure - I think!) which can via 'magic' be used
>>> to derive a pulse.  That's not a problem, but the channel types aren't
>>> going to include heart_rate as that's not output from the device.
>>>
>>>> ---
>>>>  drivers/iio/Kconfig                 |   1 +
>>>>  drivers/iio/Makefile                |   1 +
>>>>  drivers/iio/heart_monitor/Kconfig   |  19 +
>>>>  drivers/iio/heart_monitor/Makefile  |   6 +
>>>>  drivers/iio/heart_monitor/afe4403.c | 702 ++++++++++++++++++++++++++++++++++++
>>>>  5 files changed, 729 insertions(+)
>>>>  create mode 100644 drivers/iio/heart_monitor/Kconfig
>>>>  create mode 100644 drivers/iio/heart_monitor/Makefile
>>>>  create mode 100644 drivers/iio/heart_monitor/afe4403.c
>>>>
>>>> diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
>>>> index 4011eff..7d13ef7 100644
>>>> --- a/drivers/iio/Kconfig
>>>> +++ b/drivers/iio/Kconfig
>>>> @@ -65,6 +65,7 @@ source "drivers/iio/common/Kconfig"
>>>>  source "drivers/iio/dac/Kconfig"
>>>>  source "drivers/iio/frequency/Kconfig"
>>>>  source "drivers/iio/gyro/Kconfig"
>>>> +source "drivers/iio/heart_monitor/Kconfig"
>>>>  source "drivers/iio/humidity/Kconfig"
>>>>  source "drivers/iio/imu/Kconfig"
>>>>  source "drivers/iio/light/Kconfig"
>>>> diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
>>>> index 698afc2..4372442 100644
>>>> --- a/drivers/iio/Makefile
>>>> +++ b/drivers/iio/Makefile
>>>> @@ -18,6 +18,7 @@ obj-y += common/
>>>>  obj-y += dac/
>>>>  obj-y += gyro/
>>>>  obj-y += frequency/
>>>> +obj-y += heart_monitor/
>>>>  obj-y += humidity/
>>>>  obj-y += imu/
>>>>  obj-y += light/
>>>> diff --git a/drivers/iio/heart_monitor/Kconfig b/drivers/iio/heart_monitor/Kconfig
>>>> new file mode 100644
>>>> index 0000000..fbe4bd4
>>>> --- /dev/null
>>>> +++ b/drivers/iio/heart_monitor/Kconfig
>>>> @@ -0,0 +1,19 @@
>>>> +#
>>>> +# Heart Rate Monitor drivers
>>>> +#
>>>> +# When adding new entries keep the list in alphabetical order
>>>> +
>>>> +menu "Heart Rate Monitors"
>>>> +
>>>> +config AFE4403
>>>> +	tristate "TI AFE4403 Heart Rate Monitor"
>>>> +	depends on SPI_MASTER
>>>> +	select IIO_BUFFER
>>>> +	help
>>>> +	  Say yes to choose the Texas Instruments AFE4403
>>>> +	  heart rate monitor and low-cost pulse oximeter.
>>>> +
>>>> +	  To compile this driver as a module, choose M here: the
>>>> +	  module will be called afe4403 heart rate monitor and
>>>> +	  low-cost pulse oximeter.
>>>> +endmenu
>>>> diff --git a/drivers/iio/heart_monitor/Makefile b/drivers/iio/heart_monitor/Makefile
>>>> new file mode 100644
>>>> index 0000000..77cc5c5
>>>> --- /dev/null
>>>> +++ b/drivers/iio/heart_monitor/Makefile
>>>> @@ -0,0 +1,6 @@
>>>> +#
>>>> +# Makefile for IIO Heart Rate Monitor drivers
>>>> +#
>>>> +
>>>> +# When adding new entries keep the list in alphabetical order
>>>> +obj-$(CONFIG_AFE4403) += afe4403.o
>>>> diff --git a/drivers/iio/heart_monitor/afe4403.c b/drivers/iio/heart_monitor/afe4403.c
>>>> new file mode 100644
>>>> index 0000000..1b77670
>>>> --- /dev/null
>>>> +++ b/drivers/iio/heart_monitor/afe4403.c
>>>> @@ -0,0 +1,702 @@
>>>> +/*
>>>> + * AFE4403 Heart Rate Monitors and Low-Cost Pulse Oximeters
>>>> + *
>>>> + * Author: Dan Murphy <dmurphy@ti.com>
>>>> + *
>>>> + * Copyright: (C) 2015 Texas Instruments, Inc.
>>>> + *
>>>> + * This program is free software; you can redistribute it and/or modify
>>>> + * it under the terms of the GNU General Public License version 2 as
>>>> + * published by the Free Software Foundation.
>>>> + *
>>>> + * This program is distributed in the hope that it will be useful, but
>>>> + * WITHOUT ANY WARRANTY; without even the implied warranty of
>>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>>>> + * General Public License for more details.
>>>> + */
>>>> +
>>>> +#include <linux/device.h>
>>>> +#include <linux/delay.h>
>>>> +#include <linux/err.h>
>>>> +#include <linux/interrupt.h>
>>>> +#include <linux/kernel.h>
>>>> +#include <linux/module.h>
>>>> +#include <linux/of_gpio.h>
>>>> +#include <linux/spi/spi.h>
>>>> +#include <linux/slab.h>
>>>> +#include <linux/sysfs.h>
>>>> +#include <linux/regulator/consumer.h>
>>>> +
>>>> +#include <linux/iio/iio.h>
>>>> +#include <linux/iio/sysfs.h>
>>>> +#include <linux/iio/events.h>
>>>> +
>>>> +#define AFE4403_CONTROL0		0x00
>>>> +#define AFE4403_LED2STC			0x01
>>>> +#define AFE4403_LED2ENDC		0x02
>>>> +#define AFE4403_LED2LEDSTC		0x03
>>>> +#define AFE4403_LED2LEDENDC		0x04
>>>> +#define AFE4403_ALED2STC		0x05
>>>> +#define AFE4403_ALED2ENDC		0x06
>>>> +#define AFE4403_LED1STC			0x07
>>>> +#define AFE4403_LED1ENDC		0x08
>>>> +#define AFE4403_LED1LEDSTC		0x09
>>>> +#define AFE4403_LED1LEDENDC		0x0a
>>>> +#define AFE4403_ALED1STC		0x0b
>>>> +#define AFE4403_ALED1ENDC		0x0c
>>>> +#define AFE4403_LED2CONVST		0x0d
>>>> +#define AFE4403_LED2CONVEND		0x0e
>>>> +#define AFE4403_ALED2CONVST		0x0f
>>>> +#define AFE4403_ALED2CONVEND	0x10
>>>> +#define AFE4403_LED1CONVST		0x11
>>>> +#define AFE4403_LED1CONVEND		0x12
>>>> +#define AFE4403_ALED1CONVST		0x13
>>>> +#define AFE4403_ALED1CONVEND	0x14
>>>> +#define AFE4403_ADCRSTSTCT0		0x15
>>>> +#define AFE4403_ADCRSTENDCT0	0x16
>>>> +#define AFE4403_ADCRSTSTCT1		0x17
>>>> +#define AFE4403_ADCRSTENDCT1	0x18
>>>> +#define AFE4403_ADCRSTSTCT2		0x19
>>>> +#define AFE4403_ADCRSTENDCT2	0x1a
>>>> +#define AFE4403_ADCRSTSTCT3		0x1b
>>>> +#define AFE4403_ADCRSTENDCT3	0x1c
>>>> +#define AFE4403_PRPCOUNT		0x1d
>>>> +#define AFE4403_CONTROL1		0x1e
>>>> +#define AFE4403_SPARE1			0x1f
>>>> +#define AFE4403_TIAGAIN			0x20
>>>> +#define AFE4403_TIA_AMB_GAIN	0x21
>>>> +#define AFE4403_LEDCNTRL		0x22
>>>> +#define AFE4403_CONTROL2		0x23
>>>> +#define AFE4403_SPARE2			0x24
>>>> +#define AFE4403_SPARE3			0x25
>>>> +#define AFE4403_SPARE4			0x26
>>>> +#define AFE4403_ALARM			0x29
>>>> +#define AFE4403_LED2VAL			0x2A
>>>> +#define AFE4403_ALED2VAL		0x2B
>>>> +#define AFE4403_LED1VAL			0x2C
>>>> +#define AFE4403_ALED1VAL		0x2D
>>>> +#define AFE4403_LED2_ALED2VAL	0x2E
>>>> +#define AFE4403_LED1_ALED1VAL	0x2F
>>>> +#define AFE4403_DIAG			0x30
>>>> +#define AFE4403_CONTROL3		0x31
>>>> +#define AFE4403_PDNCYCLESTC		0x32
>>>> +#define AFE4403_PDNCYCLEENDC	0x33
>>>> +
>>>> +#define AFE4403_SPI_ON			0x0
>>>> +#define AFE4403_SPI_OFF			0x1
>>>> +
>>>> +#define AFE4403_SPI_READ		BIT(0)
>>>> +#define AFE4403_SW_RESET		BIT(3)
>>>> +#define AFE4403_PWR_DWN			BIT(0)
>>>> +
>>>> +static DEFINE_MUTEX(afe4403_mutex);
>>>> +
>>>> +/**
>>>> + * struct afe4403_data
>>>> + * @indio_dev - IIO device structure
>>>> + * @spi - SPI device pointer the driver is attached to
>>>> + * @mutex - Read/Write mutex
>>>> + * @regulator - Pointer to the regulator for the IC
>>>> + * @ste_gpio - SPI serial interface enable line
>>>> + * @data_gpio - Interrupt GPIO when AFE data is ready
>>>> + * @reset_gpio - Hard wire GPIO reset line
>>>> + * @timestamp - Timestamp of the IRQ event
>>>> + * @state - Current state of the IC.
>>>> + * @buff - Data buffer containing the 6 LED values and DIAG
>>>> + * @irq - AFE4403 interrupt number
>>>> +**/
>>>> +struct afe4403_data {
>>>> +	struct iio_dev *indio_dev;
>>>> +	struct spi_device *spi;
>>>> +	struct mutex mutex;
>>>> +	struct regulator *regulator;
>>>> +	struct gpio_desc *ste_gpio;
>>>> +	struct gpio_desc *data_gpio;
>>>> +	struct gpio_desc *reset_gpio;
>>>> +	int64_t timestamp;
>>>> +	bool state;
>>>> +	int buff[7];
>>>> +	int irq;
>>>> +};
>>>> +
>>>> +enum afe4403_reg_id {
>>>> +	LED1VAL,
>>>> +	ALED1VAL,
>>>> +	LED2VAL,
>>>> +	ALED2VAL,
>>>> +	LED2_ALED2VAL,
>>>> +	LED1_ALED1VAL,
>>>> +	DIAG,
>>>> +	TIAGAIN,
>>>> +	TIA_AMB_GAIN,
>>>> +	LEDCNTRL,
>>>> +	CONTROL3,
>>>> +};
>>>> +
>>>> +static const struct iio_event_spec afe4403_event = {
>>>> +	.type = IIO_EV_TYPE_MAG,
>>>> +	.dir = IIO_EV_DIR_NONE,
>>>> +	.mask_separate = BIT(IIO_EV_INFO_VALUE) |
>>>> +			BIT(IIO_EV_INFO_ENABLE),
>>>> +};
>>>> +
>>>> +#define AFE4403_WRITE_FREQ_CHAN(index, name) { \
>>>> +	.type = IIO_HEARTRATE,		\
>>>> +	.indexed = 1,				\
>>>> +	.channel = index,			\
>>>> +	.datasheet_name = name, \
>>>> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
>>>> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_FREQUENCY), \
>>>> +	.scan_index = index,		\
>>>> +	.scan_type = {				\
>>>> +		.sign = 'u',			\
>>>> +		.realbits = 24,			\
>>>> +		.storagebits = 32,		\
>>>> +		.endianness = IIO_BE		\
>>>> +	}, \
>>>> +}
>>>> +
>>>> +#define AFE4403_WRITE_BIAS_CHAN(index, name) { \
>>>> +	.type = IIO_HEARTRATE,		\
>>>> +	.indexed = 1,				\
>>>> +	.channel = index,			\
>>>> +	.datasheet_name = name, \
>>>> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
>>>> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_HARDWAREGAIN), \
>>>> +	.scan_index = index,		\
>>>> +	.scan_type = {				\
>>>> +		.sign = 'u',			\
>>>> +		.realbits = 24,			\
>>>> +		.storagebits = 32,		\
>>>> +		.endianness = IIO_BE		\
>>>> +	}, \
>>>> +}
>>>> +
>>>> +#define AFE4403_READ_CHAN(index, name) { \
>>>> +	.type = IIO_HEARTRATE,		\
>>> These really aren't heart rate channels.  They are values that
>>> can be used to work out the heart rate, but not directly or on
>>> their own.
>> True.  These are, as you pointed out LED values that can be expressed that
>> way from the readable channels.
>>
>>>> +	.indexed = 1,				\
>>>> +	.channel = index,			\
>>>> +	.datasheet_name = name, \
>>>> +	.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) | \
>>>> +			      BIT(IIO_CHAN_INFO_RAW),	\
>>> It's very rarely correct to have both processed and raw.  Processed
>>> means we are in the documented units for the type. Here bpm.
>>> _raw means we aren't and need to apply scale and offset
>>> (which may possible not be known).
>> OK.  I did not realized that was the definition of processed
>>
>>>> +	.scan_index = index,		\
>>>> +	.scan_type = {				\
>>>> +		.sign = 'u',			\
>>>> +		.realbits = 24,			\
>>>> +		.storagebits = 32,		\
>>>> +		.endianness = IIO_BE		\
>>>> +	}, \
>>>> +	.event_spec = &afe4403_event,		\
>>>> +	.num_event_specs = 1,			\
>>>> +}
>>>> +
>>>> +static const struct iio_chan_spec afe4403_channels[] = {
>>>> +	/* Read only values from the IC */
>>>> +	AFE4403_READ_CHAN(LED1VAL, "LED1VAL"),
>>> This is a light intensity sample. Hence type should probably be IIO_INTENSITY,
>>> probably using an extended_name to specify it is with the led on.
>>>> +	AFE4403_READ_CHAN(ALED1VAL, "ALED1VAL"),
>>> This is the ambient light intensity so again type should be IIO_INTENSITY though
>>> ambient is usually assumed so may or may not make sense to have an extended
>>> name specifying it is abient.
>>>
>>>> +	AFE4403_READ_CHAN(LED2VAL, "LED2VAL"),
>>>> +	AFE4403_READ_CHAN(ALED2VAL, "ALED2VAL"),
>>>> +	AFE4403_READ_CHAN(LED2_ALED2VAL, "LED2_ALED2"),
>>> I think these are differential channel signals?  Might be a little fiddly
>>> as we don't suport more than one extended name.  Still these are differential
>>> channels and should be specified as such.  Guess we need to allow an
>>> additional extended name to have in_intensity1_led-intensity1_ambient_raw
>>> or similar.  Easy enough to add to the core, though may be worth proposing
>>> the interface as an ABI documentation entry first.
>>>
>>>
>>>> +	AFE4403_READ_CHAN(LED1_ALED1VAL, "LED1_ALED1"),
>>>> +	AFE4403_READ_CHAN(DIAG, "DIAG"),
>>> This is not a channel at all but rather a nasty way of getting direct
>>> access to a register.  Do not do this.  If you want direct access then
>>> debugfs only.  If it makes sense to read this during normal operation then
>>> the driver should be using the individual elements and exposing them as
>>> sensible.
>> This will actually be removed in v2.  This is not needed in production only in
>> product development.
>>
>>>> +
>>>> +	/* Required writing for calibration */
>>>> +	AFE4403_WRITE_BIAS_CHAN(TIAGAIN, "TIAGAIN"),
>>> This is a register with several different things in it.  You need
>>> to break this up and wrap it up in normal abi elements.  It's not
>>> a channel so don't pretend it is. 
>>>> +	AFE4403_WRITE_BIAS_CHAN(TIA_AMB_GAIN, "TIA_AMB_GAIN"),
>>>> +	AFE4403_WRITE_BIAS_CHAN(LEDCNTRL, "LEDCNTRL"),
>>>> +	AFE4403_WRITE_FREQ_CHAN(CONTROL3, "CONTROL3"),
>>> These are also not channels. Don't pretend they are.  If you have
>>> an element that you don't know how to support (there will probably
>>> be some looking at the docs!) then just ask about that element rather
>>> than abusing interfaces like this.
>> I will create dev attributes for these.
>>
>>>> +};
>>>> +
>>>> +/**
>>>> + * Per section 8.5 of the data sheet the SPI interface enable
>>>> + * line needs to be pulled and held low throughout the
>>>> + * data reads and writes.
>>>> +*/
>>>> +static int afe4403_read(struct afe4403_data *afe4403, u8 reg,
>>>> +		unsigned int *data)
>>>> +{
>>>> +	int ret;
>>>> +
>>>> +	mutex_lock(&afe4403_mutex);
>>>> +
>>>> +	gpiod_set_value(afe4403->ste_gpio, 0);
>>>> +	ret = spi_write_then_read(afe4403->spi, (u8 *)&reg, 1, (u8 *)data, 3);
>>>> +	gpiod_set_value(afe4403->ste_gpio, 1);
>>>> +
>>>> +	mutex_unlock(&afe4403_mutex);
>>>> +	return ret;
>>>> +};
>>>> +
>>>> +static int afe4403_write(struct afe4403_data *afe4403, u8 reg,
>>>> +		unsigned int data)
>>>> +{
>>>> +	int ret;
>>>> +	u8 tx[4] = {0x0, 0x0, 0x0, 0x0};
>>>> +
>>>> +	mutex_lock(&afe4403_mutex);
>>>> +
>>>> +	/* Enable write to the device */
>>>> +	tx[0] = AFE4403_CONTROL0;
>>>> +	tx[3] = 0x0;
>>>> +	gpiod_set_value(afe4403->ste_gpio, 0);
>>>> +	ret = spi_write(afe4403->spi, (u8 *)tx, 4);
>>>> +	if (ret)
>>>> +		goto out;
>>>> +	gpiod_set_value(afe4403->ste_gpio, 1);
>>>> +
>>>> +	tx[0] = reg;
>>>> +	tx[1] = (data & 0x0f0000) >> 16;
>>>> +	tx[2] = (data & 0x00ff00) >> 8;
>>>> +	tx[3] = data & 0xff;
>>>> +	gpiod_set_value(afe4403->ste_gpio, 0);
>>>> +	ret = spi_write(afe4403->spi, (u8 *)tx, 4);
>>>> +	if (ret)
>>>> +		goto out;
>>>> +
>>>> +	gpiod_set_value(afe4403->ste_gpio, 1);
>>>> +
>>>> +	/* Re-Enable reading from the device */
>>>> +	tx[0] = AFE4403_CONTROL0;
>>>> +	tx[1] = 0x0;
>>>> +	tx[2] = 0x0;
>>>> +	tx[3] = AFE4403_SPI_READ;
>>>> +	gpiod_set_value(afe4403->ste_gpio, 0);
>>>> +	ret = spi_write(afe4403->spi, (u8 *)tx, 4);
>>>> +
>>>> +out:
>>>> +	gpiod_set_value(afe4403->ste_gpio, 1);
>>>> +	mutex_unlock(&afe4403_mutex);
>>>> +	return ret;
>>>> +};
>>>> +
>>>> +static int afe4403_write_raw(struct iio_dev *indio_dev,
>>>> +			     struct iio_chan_spec const *chan,
>>>> +			     int val, int val2, long mask)
>>>> +{
>>>> +	struct afe4403_data *data = iio_priv(indio_dev);
>>>> +	u8 reg;
>>>> +
>>>> +	if (chan->channel >= ARRAY_SIZE(afe4403_channels))
>>>> +		return -EINVAL;
>>>> +
>>>> +	switch (mask) {
>>>> +	case IIO_CHAN_INFO_RAW:
>>>> +		if (chan->channel == TIAGAIN)
>>>> +			reg = AFE4403_TIAGAIN;
>>>> +		else if (chan->channel == TIA_AMB_GAIN)
>>>> +			reg = AFE4403_TIA_AMB_GAIN;
>>>> +		else if (chan->channel == LEDCNTRL)
>>>> +			reg = AFE4403_LEDCNTRL;
>>>> +		else if (chan->channel == CONTROL3)
>>>> +			reg = AFE4403_CONTROL3;
>>>> +		else
>>>> +			return -EINVAL;
>>>> +		break;
>>>> +	case IIO_CHAN_INFO_HARDWAREGAIN:
>>> some of these registers are the same as those used for _raw.
>>> I don't see any extraction of different elements...
>> This will be removed
>>
>>>> +		if (chan->channel == TIAGAIN)
>>>> +			reg = AFE4403_TIAGAIN;
>>>> +		else if (chan->channel == TIA_AMB_GAIN)
>>>> +			reg = AFE4403_TIA_AMB_GAIN;
>>>> +		else if (chan->channel == LEDCNTRL)
>>>> +			reg = AFE4403_LEDCNTRL;
>>>> +		else
>>>> +			return -EINVAL;
>>>> +
>>>> +		break;
>>>> +	case IIO_CHAN_INFO_FREQUENCY:
>>>> +		if (chan->channel == CONTROL3)
>>>> +			reg = AFE4403_CONTROL3;
>>>> +		else
>>>> +			return -EINVAL;
>>>> +		break;
>>>> +	default:
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>> +	return afe4403_write(data, reg, val);
>>>> +}
>>>> +
>>>> +static int afe4403_read_raw(struct iio_dev *indio_dev,
>>>> +			    struct iio_chan_spec const *chan,
>>>> +			    int *val, int *val2, long mask)
>>>> +{
>>>> +	struct afe4403_data *data = iio_priv(indio_dev);
>>>> +
>>>> +	if (iio_buffer_enabled(indio_dev))
>>>> +			return -EBUSY;
>>>> +
>>>> +	if (chan->channel > ARRAY_SIZE(afe4403_channels))
>>>> +		return -EINVAL;
>>>> +
>>>> +	switch (mask) {
>>>> +	case IIO_CHAN_INFO_RAW:
>>>> +	case IIO_CHAN_INFO_PROCESSED:
>>>> +		*val = data->buff[chan->channel];
>>> So this is reading from a cache.  What filled the cache?
>> Will be removed
>>
>>>> +		return IIO_VAL_INT;
>>>> +	default:
>>>> +		return -EINVAL;
>>>> +	}
>>>> +}
>>>> +
>>>> +static int afe4403_write_event(struct iio_dev *indio_dev,
>>>> +				     const struct iio_chan_spec *chan,
>>>> +				     enum iio_event_type type,
>>>> +				     enum iio_event_direction dir,
>>>> +				     int state)
>>>> +{
>>>> +	struct afe4403_data *afe4403 = iio_priv(indio_dev);
>>>> +	int ret;
>>>> +	unsigned int control_val;
>>>> +
>>>> +	ret = afe4403_read(afe4403, AFE4403_CONTROL2, &control_val);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	if (state)
>>>> +		control_val &= ~AFE4403_PWR_DWN;
>>>> +	else
>>>> +		control_val |= AFE4403_PWR_DWN;
>>>> +
>>>> +	ret = afe4403_write(afe4403, AFE4403_CONTROL2, control_val);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	afe4403->state = state;
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static int afe4403_read_event_value(struct iio_dev *iio,
>>>> +			const struct iio_chan_spec *chan,
>>>> +			enum iio_event_type type,
>>>> +			enum iio_event_direction dir,
>>>> +			enum iio_event_info info,
>>>> +			int *val, int *val2)
>>>> +{
>>>> +	struct afe4403_data *afe4403 = iio_priv(iio);
>>>> +	int ret, reg;
>>>> +
>>>> +	if (chan->channel == LED1VAL)
>>>> +		reg = AFE4403_LED1VAL;
>>>> +	else if (chan->channel == ALED1VAL)
>>>> +		reg = AFE4403_ALED1VAL;
>>>> +	else if (chan->channel == LED2VAL)
>>>> +		reg = AFE4403_LED2VAL;
>>>> +	else if (chan->channel == ALED2VAL)
>>>> +		reg = AFE4403_ALED2VAL;
>>>> +	else if (chan->channel == LED2_ALED2VAL)
>>>> +		reg = AFE4403_LED2_ALED2VAL;
>>>> +	else if (chan->channel == LED1_ALED1VAL)
>>>> +		reg = AFE4403_LED1_ALED1VAL;
>>>> +	else if (chan->channel == DIAG)
>>>> +		reg = AFE4403_DIAG;
>>> Constant look up table to avoid the if else chain.
>>>
>>> Also wha tare you actually querying here?  These don't immediately
>>> look liek they have anything to do with events.
>> The interrupt event is singular from the device and designates that a measurement is complete for the
>> above signals (except DIAG which will go away anyway).
>> The user space then has the ability to read any of these values.
>>
>> The above if..else was an attempt to match registers to the channels but I guess that can be done via
>> a look up table as well.  That would be easier to update in the future.
>>
>>
>>>> +	else
>>>> +		return -EINVAL;
>>>> +
>>>> +	ret = afe4403_read(afe4403, reg, &afe4403->buff[chan->channel]);
>>>> +	if (ret)
>>>> +		goto done;
>>>> +
>>>> +	*val = afe4403->buff[chan->channel];
>>>> +	*val2 = 0;
>>>> +	ret = IIO_VAL_INT;
>>>> +done:
>>>> +	return ret;
>>>> +}
>>>> +
>>>> +static int afe4403_debugfs_reg_access(struct iio_dev *indio_dev,
>>>> +				      unsigned reg, unsigned writeval,
>>>> +				      unsigned *readval)
>>>> +{
>>>> +	struct afe4403_data *afe4403 = iio_priv(indio_dev);
>>>> +	int ret;
>>>> +
>>>> +	if (reg < AFE4403_CONTROL0 || reg > AFE4403_PDNCYCLEENDC)
>>>> +		return -EINVAL;
>>>> +
>>>> +	if (readval != NULL) {
>>>> +		ret = afe4403_read(afe4403, reg, readval);
>>>> +		if (ret)
>>>> +			return ret;
>>>> +	} else if (writeval < 0) {
>>>> +		ret = afe4403_write(afe4403, reg, writeval);
>>>> +		if (ret)
>>>> +			return ret;
>>>> +	} else {
>>>> +		ret = -EINVAL;
>>>> +	}
>>>> +
>>>> +	return ret;
>>>> +}
>>>> +
>>>> +static const struct iio_info afe4403_iio_info = {
>>>> +	.read_raw = &afe4403_read_raw,
>>>> +	.write_raw = &afe4403_write_raw,
>>>> +	.read_event_value = &afe4403_read_event_value,
>>>> +	.write_event_config = &afe4403_write_event,
>>>> +	.debugfs_reg_access = &afe4403_debugfs_reg_access,
>>>> +	.driver_module = THIS_MODULE,
>>>> +};
>>>> +
>>>> +static irqreturn_t afe4403_event_handler(int irq, void *private)
>>>> +{
>>>> +	struct iio_dev *indio_dev = private;
>>>> +	struct afe4403_data *afe4403 = iio_priv(indio_dev);
>>>> +
>>>> +	afe4403->timestamp = iio_get_time_ns();
>>>> +
>>>> +	iio_push_event(indio_dev, IIO_UNMOD_EVENT_CODE(IIO_HEARTRATE,
>>>> +							0,
>>>> +							IIO_EV_TYPE_CHANGE,
>>>> +							IIO_EV_DIR_EITHER),
>>>> +							afe4403->timestamp);
>>> nitpick.  Ideally a blank line here to keep with kernel coding style
>>> conventions.
>> Missed this
>>
>>>> +	return IRQ_HANDLED;
>>>> +}
>>>> +
>>>> +struct afe4403_reg {
>>>> +	uint8_t reg;
>>>> +	u32 value;
>>>> +} afe4403_init_regs[] = {
>>> This is a lot of magic numbers. If at all possible please break them
>>> up into constituent parts where relevant. It acts as convenient
>>> documentation and makes typos in here less likely.
>>> Admitedly this doesn't actually apply to that many of these!
>>> Hmm. Might be worth padding these out to 24 bits for consistency with
>>> the documented register size.
>> OK.  I will define these but I am going to pull these defines with the registers
>> into a header file.  The next part I have to submit will share almost 95% of the registers and
>> bit definitions with only a few changes.
> Just a thought, but if it's that similar, why not share a driver and avoid other repetition?
>> I will define these as AFE440x and where the registers are specific I will define per the part.
> Convention on this is often to just prefix them with the first part that was supported
> (bit like driver naming where you name the driver after the first part that was supported).
> Avoids the issue where the naming becomes inaccurate due to new devices.
>
> Anyhow, sounds like you have this all under control. Looking forward to the next version!
>
> Jonathan

The register addressing is really the only thing these two parts have in common.  One is SPI the other
I2C.  Initialization sequence is different and there are a couple more ABI's for the newer parts and some of the
bits are shuffled around.  But the register addresses and names stayed the same.

I was considering "health" as a generic category as this can house heart rate monitors, glucose
monitors and dedicated oximeters just to name a few.

I have the next version ready the only thing that I have not fixed was the CS/gpio line.
My processor board died on me and I just got it back today.
I can re-submit what I have as RFC as the driver has been pretty much ripped apart.

Dan

<snip>

-- 
------------------
Dan Murphy

