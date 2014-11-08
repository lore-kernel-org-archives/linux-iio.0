Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37212 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753519AbaKHLsC (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 8 Nov 2014 06:48:02 -0500
Message-ID: <545E02EE.2090706@kernel.org>
Date: Sat, 08 Nov 2014 11:47:58 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Dan Murphy <dmurphy@ti.com>, linux-iio@vger.kernel.org
CC: pmeerw@pmeerw.net, daniel.baluta@intel.com, k.wrona@samsung.com
Subject: Re: [RFC v2 3/3] iio: heart_monitor: Add TI afe4403 heart monitor
References: <1415287106-13491-1-git-send-email-dmurphy@ti.com> <1415287106-13491-3-git-send-email-dmurphy@ti.com>
In-Reply-To: <1415287106-13491-3-git-send-email-dmurphy@ti.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/11/14 15:18, Dan Murphy wrote:
> Add the TI afe4403 heart rate monitor.
> This device detects reflected LED
> wave length fluctuations and presents an ADC
> value to the user space to be converted to a
> heart rate.
> 
> Data sheet located here:
> http://www.ti.com/product/AFE4403/datasheet
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
Hi Dan,

Firstly, you push all sorts of data through as channels.  Don't do that.
This device can be concieved of as having 4 light intensity channels.
If you want to access those registers you need to cleanly define interfaces
to do so.

Some there appears to be some confusion in here between events and
buffered output. Events are pushed out using iio_push_event not
the buffered interface.  They emerge via a different chardev from main
data flow.  Normal data flow uses the buffered interface - events are
used for unpredictable things such as threshold crossing detectors or similar.

You currently have write_event_config (used for enabling etc) but not
any means of accessing the event_values (write_event_value).

Also the spi interface enable line looks rather like a chip select to me.
Do we need all the special handling in here?

Code is nice and clean though.

Jonathan
> ---
> 
> v2 - Updated per v1 comments - http://marc.info/?l=linux-iio&m=141399220114111&w=2
> 
>  drivers/iio/Kconfig                 |   1 +
>  drivers/iio/Makefile                |   1 +
>  drivers/iio/heart_monitor/Kconfig   |  20 ++
>  drivers/iio/heart_monitor/Makefile  |   6 +
>  drivers/iio/heart_monitor/afe4403.c | 676 ++++++++++++++++++++++++++++++++++++
>  5 files changed, 704 insertions(+)
>  create mode 100644 drivers/iio/heart_monitor/Kconfig
>  create mode 100644 drivers/iio/heart_monitor/Makefile
>  create mode 100644 drivers/iio/heart_monitor/afe4403.c
> 
> diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
> index 345395e..2dbb229 100644
> --- a/drivers/iio/Kconfig
> +++ b/drivers/iio/Kconfig
> @@ -66,6 +66,7 @@ source "drivers/iio/common/Kconfig"
>  source "drivers/iio/dac/Kconfig"
>  source "drivers/iio/frequency/Kconfig"
>  source "drivers/iio/gyro/Kconfig"
> +source "drivers/iio/heart_monitor/Kconfig"
>  source "drivers/iio/humidity/Kconfig"
>  source "drivers/iio/imu/Kconfig"
>  source "drivers/iio/light/Kconfig"
> diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
> index 698afc2..4372442 100644
> --- a/drivers/iio/Makefile
> +++ b/drivers/iio/Makefile
> @@ -18,6 +18,7 @@ obj-y += common/
>  obj-y += dac/
>  obj-y += gyro/
>  obj-y += frequency/
> +obj-y += heart_monitor/
>  obj-y += humidity/
>  obj-y += imu/
>  obj-y += light/
> diff --git a/drivers/iio/heart_monitor/Kconfig b/drivers/iio/heart_monitor/Kconfig
> new file mode 100644
> index 0000000..aee0cab
> --- /dev/null
> +++ b/drivers/iio/heart_monitor/Kconfig
> @@ -0,0 +1,20 @@
> +#
> +# Heart Rate Monitor drivers
> +#
> +# When adding new entries keep the list in alphabetical order
> +
> +menu "Heart Rate Monitors"
> +
> +config AFE4403
> +	tristate "TI AFE4403 Heart Rate Monitor"
> +	depends on SPI_MASTER
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
You don't seem to be using this...
> +	help
> +	  Say yes to choose the Texas Instruments AFE4403
> +	  heart rate monitor and low-cost pulse oximeter.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called afe4403 heart rate monitor and
> +	  low-cost pulse oximeter.
> +endmenu
> diff --git a/drivers/iio/heart_monitor/Makefile b/drivers/iio/heart_monitor/Makefile
> new file mode 100644
> index 0000000..77cc5c5
> --- /dev/null
> +++ b/drivers/iio/heart_monitor/Makefile
> @@ -0,0 +1,6 @@
> +#
> +# Makefile for IIO Heart Rate Monitor drivers
> +#
> +
> +# When adding new entries keep the list in alphabetical order
> +obj-$(CONFIG_AFE4403) += afe4403.o
> diff --git a/drivers/iio/heart_monitor/afe4403.c b/drivers/iio/heart_monitor/afe4403.c
> new file mode 100644
> index 0000000..9f47b57
> --- /dev/null
> +++ b/drivers/iio/heart_monitor/afe4403.c
> @@ -0,0 +1,676 @@
> +/*
> + * AFE4403 Heart Rate Monitors and Low-Cost Pulse Oximeters
> + *
> + * Author: Dan Murphy <dmurphy@ti.com>
> + *
> + * Copyright: (C) 2014 Texas Instruments, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_gpio.h>
> +#include <linux/spi/spi.h>
> +#include <linux/slab.h>
> +#include <linux/sysfs.h>
> +#include <linux/regulator/consumer.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/driver.h>
> +#include <linux/iio/machine.h>
> +#include <linux/iio/events.h>
> +#include <linux/iio/kfifo_buf.h>
> +
> +#define AFE4403_CONTROL0		0x00
> +#define AFE4403_LED2STC			0x01
> +#define AFE4403_LED2ENDC		0x02
> +#define AFE4403_LED2LEDSTC		0x03
> +#define AFE4403_LED2LEDENDC		0x04
> +#define AFE4403_ALED2STC		0x05
> +#define AFE4403_ALED2ENDC		0x06
> +#define AFE4403_LED1STC			0x07
> +#define AFE4403_LED1ENDC		0x08
> +#define AFE4403_LED1LEDSTC		0x09
> +#define AFE4403_LED1LEDENDC		0x0a
> +#define AFE4403_ALED1STC		0x0b
> +#define AFE4403_ALED1ENDC		0x0c
> +#define AFE4403_LED2CONVST		0x0d
> +#define AFE4403_LED2CONVEND		0x0e
> +#define AFE4403_ALED2CONVST		0x0f
> +#define AFE4403_ALED2CONVEND	0x10
> +#define AFE4403_LED1CONVST		0x11
> +#define AFE4403_LED1CONVEND		0x12
> +#define AFE4403_ALED1CONVST		0x13
> +#define AFE4403_ALED1CONVEND	0x14
> +#define AFE4403_ADCRSTSTCT0		0x15
> +#define AFE4403_ADCRSTENDCT0	0x16
> +#define AFE4403_ADCRSTSTCT1		0x17
> +#define AFE4403_ADCRSTENDCT1	0x18
> +#define AFE4403_ADCRSTSTCT2		0x19
> +#define AFE4403_ADCRSTENDCT2	0x1a
> +#define AFE4403_ADCRSTSTCT3		0x1b
> +#define AFE4403_ADCRSTENDCT3	0x1c
> +#define AFE4403_PRPCOUNT		0x1d
> +#define AFE4403_CONTROL1		0x1e
> +#define AFE4403_SPARE1			0x1f
> +#define AFE4403_TIAGAIN			0x20
> +#define AFE4403_TIA_AMB_GAIN	0x21
> +#define AFE4403_LEDCNTRL		0x22
> +#define AFE4403_CONTROL2		0x23
> +#define AFE4403_SPARE2			0x24
> +#define AFE4403_SPARE3			0x25
> +#define AFE4403_SPARE4			0x26
> +#define AFE4403_ALARM			0x29
> +#define AFE4403_LED2VAL			0x2A
> +#define AFE4403_ALED2VAL		0x2B
> +#define AFE4403_LED1VAL			0x2C
> +#define AFE4403_ALED1VAL		0x2D
> +#define AFE4403_LED2_ALED2VAL	0x2E
> +#define AFE4403_LED1_ALED1VAL	0x2F
> +#define AFE4403_DIAG			0x30
> +#define AFE4403_CONTROL3		0x31
> +#define AFE4403_PDNCYCLESTC		0x32
> +#define AFE4403_PDNCYCLEENDC	0x33
> +
> +#define AFE4403_SPI_ON			0x0
> +#define AFE4403_SPI_OFF			0x1
> +
> +#define AFE4403_SPI_READ		BIT(0)
> +#define AFE4403_SW_RESET		BIT(3)
> +#define AFE4403_PWR_DWN			BIT(0)
> +
> +static DEFINE_MUTEX(afe4403_mutex);
> +
> +/**
> + * struct afe4403_data
> + * @indio_dev - IIO device structure
> + * @map - IIO map link between consumer and device channels
> + * @spi - SPI device pointer the driver is attached to
> + * @regulator - Pointer to the regulator for the IC
> + * @ste_gpio - SPI serial interface enable line
> + * @data_gpio - Interrupt GPIO when AFE data is ready
> + * @reset_gpio - Hard wire GPIO reset line
> + * @mutex - Read/Write mutex
> + * @data_buffer - Data buffer containing the 4 LED values and DIAG
> + * @irq - AFE4403 interrupt number
> +**/
> +struct afe4403_data {
> +	struct iio_dev *indio_dev;
> +	struct iio_map *map;
> +	struct spi_device *spi;
> +	struct regulator *regulator;
> +	struct gpio_desc *ste_gpio;
> +	struct gpio_desc *data_gpio;
> +	struct gpio_desc *reset_gpio;
> +	int data_buffer[5];
It's a little esoteric, but data_buffer must have space for an 8 byte
aligned space for the timestamp at the end to take the timestamp.
Hence this needs to be
int data_buffer[8];
> +	int irq;
> +};
> +
> +enum afe4403_reg_id {
> +	LED1VAL,
> +	ALED1VAL,
> +	LED2VAL,
> +	ALED2VAL,
> +	DIAG,
> +	TIAGAIN,
> +	TIA_AMB_GAIN,
> +	LEDCNTRL,
> +	CONTROL3,
> +};
> +
> +static const struct iio_event_spec afe4403_events[] = {
> +	{
> +		.type = IIO_EV_TYPE_MAG,
> +		.dir = IIO_EV_DIR_EITHER,
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
> +			BIT(IIO_EV_INFO_ENABLE),
> +	},
> +};
> +
> +#define AFE4403_COMMON_CHAN(index, name) { \
> +		.type = IIO_HEARTRATE,		\

You can't just wrap up any old data in a new type.  This needs to be defined
clearly including base units.  As far as I can see here you actually
just have a set of light intensity values.  The fact they are synchronized
with led's flashing doesn't effect what they are measuring.
A heart rate channel would have to output how many pulses we have a minute
for example.   Here you just have data that may be used in userspace to
establish that.  So feel free to leave this in the heart rate directory
but make sure it is clear what the data being exposed to userspace is.

As I read it you use this for lots of different things.  Please don't.
It's a real channel to be read or written.  Nothing else.

> +		.indexed = 1,				\
> +		.channel = index,			\
> +		.datasheet_name = name, \
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) \
> +				| BIT(IIO_CHAN_INFO_SCALE), \
> +		.scan_index = index,		\
> +		.scan_type = {				\
> +			.sign = 'u',			\
> +			.realbits = 24,			\
> +			.storagebits = 24,		\
> +			.endianness = IIO_BE		\
> +		}, \
You don't seem to actually have any events in the iio sense.  You
have standard data channels pumping out data.

> +		.event_spec = afe4403_events,		\
> +		.num_event_specs = ARRAY_SIZE(afe4403_events),	\
> +	}
> +
> +static const struct iio_chan_spec afe4403_channels[] = {
> +	/* Read only values from the IC */
> +	[LED1VAL] = AFE4403_COMMON_CHAN(0, "LED1VAL"),
So this one is a measure of a photodiode?  Use the existing light
intensity type.
> +	[ALED1VAL] = AFE4403_COMMON_CHAN(1, "ALED1VAL"),
This is the ambient measurement for led1.  Again light intensity
type.
> +	[LED2VAL] = AFE4403_COMMON_CHAN(2, "LED2VAL"),
> +	[ALED1VAL] = AFE4403_COMMON_CHAN(3, "ALED2VAL"),
enum index is wrong.  Same for ambient on channel 2.

I have no problem with adding modifiers if needed to specify more about
what these are measuring...

> +	[DIAG] = AFE4403_COMMON_CHAN(4, "DIAG"),
This is a set of flags - not a data channel at all
Needs totaly different handling.  Look to be fault diagnostics.
Feel free to read them in the buffering code, but they want
to be spat out as warnings to the kernel log not written as data.

> +
> +	/* Required writing for calibration */
I've talked about these below.  Do not abuse channels to get magic
values in...
> +	[TIAGAIN] = AFE4403_COMMON_CHAN(5, "TIAGAIN"),
> +	[TIA_AMB_GAIN] = AFE4403_COMMON_CHAN(6, "TIA_AMB_GAIN"),
> +	[LEDCNTRL] = AFE4403_COMMON_CHAN(7, "LEDCNTRL"),
> +	[CONTROL3] = AFE4403_COMMON_CHAN(8, "CONTROL3"),
> +};
> +
> +static struct iio_map afe4403_default_iio_maps[] = {
> +	{
> +		.consumer_dev_name = "afe4403_heartrate",
> +		.consumer_channel = "afe4403_led1value",
> +		.adc_channel_label = "LED1VAL",
> +	},
> +	{
> +		.consumer_dev_name = "afe4403_heartrate",
> +		.consumer_channel = "afe4403_aled1value",
> +		.adc_channel_label = "ALED1VAL",
> +	},
> +	{
> +		.consumer_dev_name = "afe4403_heartrate",
> +		.consumer_channel = "afe4403_led2value",
> +		.adc_channel_label = "LED2VAL",
> +	},
> +	{
> +		.consumer_dev_name = "afe4403_heartrate",
> +		.consumer_channel = "afe4403_aled2value",
> +		.adc_channel_label = "ALED2VAL",
> +	},
> +	{
> +		.consumer_dev_name = "afe4403_heartrate",
> +		.consumer_channel = "afe4403_diagnostics",
> +		.adc_channel_label = "DIAG",
> +	},
What is actually using these within the kernel?
> +};
> +
> +/**
> + * Per section 8.5 of the data sheet the SPI interface enable
> + * line needs to be pulled and held low throughout the
> + * data reads and writes.
Is this just a chip select line in the conventional sense?
> +*/
> +static int afe4403_read(struct afe4403_data *afe4403, u8 reg,
> +		unsigned int *data)
> +{
> +	int ret;
> +
> +	mutex_lock(&afe4403_mutex);
> +
> +	gpiod_set_value(afe4403->ste_gpio, 0);
> +	ret = spi_write_then_read(afe4403->spi, (u8 *)&reg, 1, (u8 *)data, 3);
Type casting reg is not needed...

> +	gpiod_set_value(afe4403->ste_gpio, 1);
> +
> +	mutex_unlock(&afe4403_mutex);
> +	return ret;
> +};
> +
> +static int afe4403_write(struct afe4403_data *afe4403, u8 reg,
> +		unsigned int data)
> +{
> +	int ret;
> +	u8 tx[4] = {0x0, 0x0, 0x0, 0x0};
Why not put the first set of values in here?
> +
> +	mutex_lock(&afe4403_mutex);
> +
> +	/* Enable write to the device */
> +	tx[0] = AFE4403_CONTROL0;
> +	tx[3] = 0x0;
> +	gpiod_set_value(afe4403->ste_gpio, 0);
> +	ret = spi_write(afe4403->spi, (u8 *)tx
It's already a u8 *
, 4);
> +	if (ret)
> +		goto out;
> +	gpiod_set_value(afe4403->ste_gpio, 1);
> +
> +	tx[0] = reg;
> +	tx[1] = (data & 0x0f0000) >> 16;
> +	tx[2] = (data & 0x00ff00) >> 8;
> +	tx[3] = data & 0xff;
> +	gpiod_set_value(afe4403->ste_gpio, 0);
> +	ret = spi_write(afe4403->spi, (u8 *)tx, 4);
> +	if (ret)
> +		goto out;
> +
> +	gpiod_set_value(afe4403->ste_gpio, 1);
> +
> +	/* Re-Enable reading from the device */
> +	tx[0] = AFE4403_CONTROL0;
> +	tx[1] = 0x0;
> +	tx[2] = 0x0;
> +	tx[3] = AFE4403_SPI_READ;
> +	gpiod_set_value(afe4403->ste_gpio, 0);
> +	ret = spi_write(afe4403->spi, (u8 *)tx, 4);
> +
> +out:
> +	gpiod_set_value(afe4403->ste_gpio, 1);
> +	mutex_unlock(&afe4403_mutex);
> +	return ret;
> +};
> +
> +static int afe4403_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int val, int val2, long mask)
> +{
> +	struct afe4403_data *data = iio_priv(indio_dev);
> +	u8 reg;
> +
> +	if (chan->channel >= ARRAY_SIZE(afe4403_channels))
> +		return -EINVAL;
> +
> +	if (chan->channel < 5)
> +		return -EINVAL;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:

You don't have any defined output channel so writing the raw
value seems unlikely to be desireable.  This hasn't caused issues
because you haven't registered any channels actually using this
and hence it can never be called...

> +	case IIO_CHAN_INFO_SCALE:
> +		if (chan->channel == 5)
> +			reg = AFE4403_TIAGAIN;
> +		else if (chan->channel == 6)
> +			reg = AFE4403_TIA_AMB_GAIN;
> +		else if (chan->channel == 7)
> +			reg = AFE4403_LEDCNTRL;
> +		else if (chan->channel == 8)
> +			reg = AFE4403_CONTROL2;
> +		else
> +			return -EINVAL;
> +
> +		return afe4403_write(data, reg, val);
So you are using this interface for general register access?
Don't do this.  

If you need explict access to these registers then define a interface
for them that does not use 'magic numbers'.

Taking just TIAGAIN for now.  This has a resistance and capacitance
values...  I'm not clear from a very quick look on whether these
are controlling these values to the amplifer or specifying what
the fitted parts in the surrounding circuit are.

You need to work out what actually wants to be exposed to userspace then
consider the interface.  I suspect quite a lot is board specific so
belongs in the devicetree or similar.


> +	default:
> +		break;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int afe4403_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long mask)
> +{
> +	struct afe4403_data *data = iio_priv(indio_dev);
> +
> +	if (iio_buffer_enabled(indio_dev))
> +			return -EBUSY;
> +
> +	if (chan->channel > ARRAY_SIZE(afe4403_channels))
> +		return -EINVAL;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_PROCESSED:
> +		*val = data->data_buffer[chan->channel];
> +		return IIO_VAL_INT;
So this provides sysfs access to the last data read via the interrupt?
Is that ever useful?

on this device I'd simply not provide raw/ processed output.

Also note that processed means that the measurements are all in the
defined base units as per the IIO ABI Documentation/ABI/testing/sysfs-bus-iio.
Might be true here, but seems a little unlikely ;)
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int afe4403_write_event(struct iio_dev *indio_dev,
> +				     const struct iio_chan_spec *chan,
> +				     enum iio_event_type type,
> +				     enum iio_event_direction dir,
> +				     int state)
> +{
> +	struct afe4403_data *afe4403 = iio_priv(indio_dev);
> +	int ret;
> +	unsigned int control_val;
> +
> +	ret = afe4403_read(afe4403, AFE4403_CONTROL2, &control_val);
> +	if (ret)
> +		return ret;
> +
> +	if (state)
> +		control_val &= ~AFE4403_PWR_DWN;
> +	else
> +		control_val |= AFE4403_PWR_DWN;
So this is turning the whole device on / off? This isn't what the
event writing code is for at all.
You want to be looking at the buffered interface and the control
functions for that.  Then you can disable the device if no channels
are enabled..
> +
> +	ret = afe4403_write(afe4403, AFE4403_CONTROL2, control_val);
> +	if (ret)
> +		return ret;
> +
> +	ret = afe4403_read(afe4403, AFE4403_CONTROL2, &control_val);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static const struct iio_info afe4403_iio_info = {
> +	.read_raw = &afe4403_read_raw,
> +	.write_raw = &afe4403_write_raw,
> +	.write_event_config = &afe4403_write_event,
> +	.driver_module = THIS_MODULE,
> +};
> +
> +static irqreturn_t afe4403_event_handler(int irq, void *data)

The meaning of events in IIO is usual rather different to this.
(threshold events etc) - this is main data flow I think?
Hence I'd be tempted to rename the function to avoid possile future
confusion.

This also looks rather like a dataready event so ideally you'd run this
out as a trigger (other devices can then synchronize with these measurements).

> +{
> +	struct iio_dev *indio_dev = data;
> +	struct afe4403_data *afe4403 = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = afe4403_read(afe4403, AFE4403_LED1VAL, &afe4403->data_buffer[0]);
> +	if (ret)
> +		goto done;

> +
> +	ret = afe4403_read(afe4403, AFE4403_ALED1VAL, &afe4403->data_buffer[1]);
> +	if (ret)
> +		goto done;
> +
> +	ret = afe4403_read(afe4403, AFE4403_LED2VAL, &afe4403->data_buffer[2]);
> +	if (ret)
> +		goto done;
> +
> +	ret = afe4403_read(afe4403, AFE4403_ALED2VAL, &afe4403->data_buffer[3]);
> +	if (ret)
> +		goto done;
> +
> +	ret = afe4403_read(afe4403, AFE4403_DIAG, &afe4403->data_buffer[4]);
> +	if (ret)
> +		goto done;
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, &afe4403->data_buffer,
> +		iio_get_time_ns());
> +done:
> +	return IRQ_HANDLED;
> +}
> +
> +struct afe4403_reg {
> +	uint8_t reg;
> +	u32 value;
> +} afe4403_init_regs[] = {
> +	{ AFE4403_LED2STC,  0x0820},
> +	{ AFE4403_LED2ENDC, 0x0f9e },
> +	{ AFE4403_LED2LEDSTC, 0x07d0 },
> +	{ AFE4403_LED2LEDENDC, 0x0f9f },
> +	{ AFE4403_ALED2STC, 0x0050 },
> +	{ AFE4403_ALED2ENDC, 0x07ce },
> +	{ AFE4403_LED1STC, 0xc350 },
> +	{ AFE4403_LED1ENDC, 0xc350 },
> +	{ AFE4403_LED1LEDSTC, 0xc350 },
> +	{ AFE4403_LED1LEDENDC, 0xc350 },
> +	{ AFE4403_ALED1STC, 0x0ff0 },
> +	{ AFE4403_ALED1ENDC, 0x176e },
> +	{ AFE4403_LED2CONVST, 0x1775 },
> +	{ AFE4403_LED2CONVEND, 0x1f3f },
> +	{ AFE4403_ALED2CONVST, 0x1f45 },
> +	{ AFE4403_ALED2CONVEND, 0x270f },
> +	{ AFE4403_LED1CONVST, 0x2715 },
> +	{ AFE4403_LED1CONVEND, 0x2edf },
> +	{ AFE4403_ALED1CONVST, 0x2ee5 },
> +	{ AFE4403_ALED1CONVEND, 0x36af },
> +	{ AFE4403_ADCRSTSTCT0, 0x1770 },
> +	{ AFE4403_ADCRSTENDCT0, 0x1774 },
> +	{ AFE4403_ADCRSTSTCT1, 0x1f40 },
> +	{ AFE4403_ADCRSTENDCT1, 0x1f44 },
> +	{ AFE4403_ADCRSTSTCT2, 0x2710 },
> +	{ AFE4403_ADCRSTENDCT2, 0x2714 },
> +	{ AFE4403_ADCRSTSTCT3, 0x2ee0 },
> +	{ AFE4403_ADCRSTENDCT3, 0x2ee4 },
> +	{ AFE4403_PRPCOUNT, 0x09c3f },
> +	{ AFE4403_CONTROL1, 0x0107 },
> +	{ AFE4403_TIAGAIN, 0x8006 },
> +	{ AFE4403_TIA_AMB_GAIN, 0x06 },
> +	{ AFE4403_LEDCNTRL, 0x11414 },
> +	{ AFE4403_CONTROL2, 0x20000 },
> +};
> +
> +static int afe4403_init(struct afe4403_data *afe4403)
> +{
> +	int ret, i, reg_count;
> +
> +	/* Hard reset the device needs to be held for 1ms per data sheet */
> +	if (afe4403->reset_gpio) {
> +		gpiod_set_value(afe4403->reset_gpio, 0);
> +		udelay(1000);
> +		gpiod_set_value(afe4403->reset_gpio, 1);
> +	} else {
> +		/* Soft reset the device */
> +		ret = afe4403_write(afe4403, AFE4403_CONTROL0, AFE4403_SW_RESET);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	reg_count = ARRAY_SIZE(afe4403_init_regs) / sizeof(afe4403_init_regs[0]);
> +	for (i = 0; i < reg_count; i++) {
> +		ret = afe4403_write(afe4403, afe4403_init_regs[i].reg,
> +					afe4403_init_regs[i].value);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return ret;
> +};
> +
> +static int afe4403_iio_buffered_hardware_setup(struct iio_dev *indio_dev)
> +{
> +	struct iio_buffer *buffer;
> +	int ret;
> +
> +	buffer = iio_kfifo_allocate(indio_dev);
> +	if (!buffer)
> +		return -ENOMEM;
> +
> +	iio_device_attach_buffer(indio_dev, buffer);
> +
> +	ret = iio_buffer_register(indio_dev,
> +				  indio_dev->channels,
> +				  indio_dev->num_channels);
> +	if (ret)
> +		goto error_kfifo_free;
> +
> +	return 0;
> +
> +error_kfifo_free:
> +	iio_kfifo_free(indio_dev->buffer);
> +	return ret;
> +}
> +
> +static int afe4403_spi_probe(struct spi_device *spi)
> +{
> +	struct afe4403_data *afe4403;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*afe4403));
> +	if (indio_dev == NULL) {
> +		dev_err(&spi->dev, "Failed to allocate iio device\n");
> +		return -ENOMEM;
> +	}
> +
> +	spi_set_drvdata(spi, indio_dev);
> +
> +	afe4403 = iio_priv(indio_dev);
> +	afe4403->spi = spi;
> +
> +	indio_dev->dev.parent = &spi->dev;
> +	indio_dev->name = "afe4403";
> +	indio_dev->info = &afe4403_iio_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_HARDWARE;
> +	indio_dev->channels = afe4403_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(afe4403_channels);
> +
> +	afe4403->ste_gpio = devm_gpiod_get(&spi->dev, "ste");
> +	if (IS_ERR(afe4403->ste_gpio)) {
> +		ret = PTR_ERR(afe4403->ste_gpio);
> +		if (ret != -ENOENT && ret != -ENOSYS) {
What error codes are ok?
> +			dev_err(&spi->dev, "Failed to allocate spi gpio\n");
> +			return ret;
> +		}
> +		afe4403->ste_gpio = NULL;
Can the driver still function if this occurs? 
> +	} else {
> +		gpiod_direction_output(afe4403->ste_gpio, 1);
> +	}
> +
> +	afe4403->data_gpio = devm_gpiod_get(&spi->dev, "data-ready");
> +	if (IS_ERR(afe4403->data_gpio)) {
> +		ret = PTR_ERR(afe4403->data_gpio);
> +		if (ret != -ENOENT && ret != -ENOSYS) {
> +			dev_err(&spi->dev, "Failed to allocate data_ready gpio\n");
> +			return ret;
> +		}
> +		afe4403->data_gpio = NULL;
Can the driver still function if this occurs?  If it can then use the optional
form...  
> +	} else {
> +		gpiod_direction_input(afe4403->data_gpio);
> +		afe4403->irq = gpiod_to_irq(afe4403->data_gpio);
> +	}
> +
> +	afe4403->reset_gpio = devm_gpiod_get(&spi->dev, "reset");

There is a devm_gpiod_get_optional, which will tidy this up for you somewhat.

> +	if (IS_ERR(afe4403->reset_gpio)) {
> +		ret = PTR_ERR(afe4403->reset_gpio);
> +		if (ret != -ENOENT && ret != -ENOSYS) {
> +			dev_err(&spi->dev, "Failed to allocate reset gpio\n");
> +			return ret;
> +		}
> +		afe4403->reset_gpio = NULL;
> +	} else {
> +		gpiod_direction_output(afe4403->reset_gpio, 1);
> +	}
> +
> +	afe4403->regulator = devm_regulator_get(&spi->dev, "led");
> +	if (IS_ERR(afe4403->regulator)) {
> +		ret = PTR_ERR(afe4403->regulator);
> +		dev_err(&spi->dev,
> +			"unable to get regulator, error: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = iio_map_array_register(indio_dev, afe4403_default_iio_maps);
> +	if (ret) {
> +		dev_err(&indio_dev->dev, "iio map err: %d\n", ret);
> +		return ret;
> +	}
> +	afe4403->map = afe4403_default_iio_maps;
Is this ever used anywaywhere?

> +
> +	ret = afe4403_iio_buffered_hardware_setup(indio_dev);
> +	if (ret) {
> +		dev_err(&spi->dev, "Failed to allocate iio buffers %i\n", ret);
> +		goto buffer_setup_failed;
> +	}
I'd prefer afe4403_iio_buffered_hardware_setup to have an equivalent
unwinding function.  That way the error handling below and the work
in remove will be more obviously a mirror of the setup code.
(e.g. took me a moment to work out where the fifo you free below
was being allocated!)
> +
> +	ret = devm_request_threaded_irq(&spi->dev, afe4403->irq,
> +				   NULL,
> +				   afe4403_event_handler,
> +				   IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +				   "afe4403 int",
> +				   indio_dev);
> +	if (ret) {
> +		dev_err(&spi->dev, "Failed to allocate thread %i\n", ret);
> +		goto req_thread_failed;
> +	}
> +
> +	ret = devm_iio_device_register(&spi->dev, indio_dev);
> +	if (ret < 0)
> +		goto req_thread_failed;
> +
This ordering is 'unusual'.  The register above exposes the
device to userspace - potentially introducing some unusual
conditions if the init still needs to be performed before the
device will respond.  There's a reason the register is almost
always the last thing in the probe function! 

Also the devm release functions will always occur after anything
explicitly in the remove function.  This means that the unwind
will not be in the reverse order of the setup. Hence
devm_iio_device_register is only usable if there is nothing to
do in remove.

> +	ret = afe4403_init(afe4403);
> +	if (ret) {
> +		dev_err(&spi->dev, "Failed to init device\n");
> +		goto req_thread_failed;
> +	}
> +
> +	return 0;
> +
> +req_thread_failed:
> +	iio_kfifo_free(indio_dev->buffer);
> +	iio_buffer_unregister(indio_dev);
It's a devm register currently so you don't need to do this.

> +buffer_setup_failed:
> +	iio_map_array_unregister(indio_dev);
> +	return ret;
> +}
> +
> +static int afe4403_spi_remove(struct spi_device *spi)
> +{
> +	struct afe4403_data *afe4403 = dev_get_drvdata(&spi->dev);
> +
> +	iio_kfifo_free(afe4403->indio_dev->buffer);
> +	iio_buffer_unregister(afe4403->indio_dev);
> +
> +	if (!IS_ERR(afe4403->regulator))
> +		regulator_disable(afe4403->regulator);
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int afe4403_suspend(struct device *dev)
> +{
> +	struct afe4403_data *afe4403 = dev_get_drvdata(dev);
> +	int ret = 0;
> +
> +	ret = afe4403_write(afe4403, AFE4403_CONTROL2, AFE4403_PWR_DWN);
> +	if (ret)
> +		goto out;
> +
> +	ret = regulator_disable(afe4403->regulator);
> +	if (ret)
> +		dev_err(dev, "Failed to disable regulator\n");
> +
> +out:
> +	return ret;
> +}
> +
> +static int afe4403_resume(struct device *dev)
> +{
> +	struct afe4403_data *afe4403 = dev_get_drvdata(dev);
> +	int ret = 0;
> +
> +	ret = afe4403_write(afe4403, AFE4403_CONTROL2, ~AFE4403_PWR_DWN);
> +	if (ret)
> +		goto out;
> +
> +	ret = regulator_enable(afe4403->regulator);
> +	if (ret)
> +		dev_err(dev, "Failed to disable regulator\n");
> +
> +out:
> +	return ret;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(afe4403_pm_ops, afe4403_suspend, afe4403_resume);
> +#define AFE4403_PM_OPS (&afe4403_pm_ops)
> +#else
> +#define AFE4403_PM_OPS NULL
> +#endif
> +
> +#if IS_ENABLED(CONFIG_OF)
> +static const struct of_device_id afe4403_of_match[] = {
> +	{ .compatible = "ti,afe4403", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, afe4403_of_match);
> +#endif
> +
> +static struct spi_driver afe4403_spi_driver = {
> +	.driver = {
> +		.name = "afe4403",
> +		.owner = THIS_MODULE,
> +		.of_match_table = of_match_ptr(afe4403_of_match),
> +		.pm	= AFE4403_PM_OPS,
> +	},
> +	.probe = afe4403_spi_probe,
> +	.remove = afe4403_spi_remove,
> +};
> +
> +static int __init afe4403_spi_init(void)
> +{
> +	return spi_register_driver(&afe4403_spi_driver);
> +}
> +module_init(afe4403_spi_init);

module_spi_driver to cut down on the boiler plate.

> +
> +MODULE_AUTHOR("Dan Murphy <dmurphy@ti.com>");
> +MODULE_DESCRIPTION("TI AFE4403 Heart Rate and Pulse Oximeter");
> +MODULE_LICENSE("GPL");
> 

