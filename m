Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:50549 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752147AbcIDQWL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 4 Sep 2016 12:22:11 -0400
Subject: Re: [PATCH v3 3/3] iio:pressure: initial zpa2326 barometer support
To: Gregor Boirie <gregor.boirie@parrot.com>, linux-iio@vger.kernel.org
References: <cover.1472841954.git.gregor.boirie@parrot.com>
 <53b4bcc7b2d5de2ed61a0aeebf0898fd7b5aa2cb.1472841954.git.gregor.boirie@parrot.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Alexander Kurz <akurz@blala.de>, Tejun Heo <tj@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Daniel Baluta <daniel.baluta@intel.com>,
        Ludovic Tancerel <ludovic.tancerel@maplehightech.com>,
        Vlad Dogaru <vlad.dogaru@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marek Vasut <marex@denx.de>,
        Crestez Dan Leonard <leonard.crestez@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Arnd Bergmann <arnd@arndb.de>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <c9370190-1859-ab66-eaac-8e7e1dbdbf0d@kernel.org>
Date: Sun, 4 Sep 2016 17:22:04 +0100
MIME-Version: 1.0
In-Reply-To: <53b4bcc7b2d5de2ed61a0aeebf0898fd7b5aa2cb.1472841954.git.gregor.boirie@parrot.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/09/16 19:47, Gregor Boirie wrote:
> Introduce driver for Murata ZPA2326 pressure and temperature sensor:
> http://www.murata.com/en-us/products/productdetail?partno=ZPA2326-0311A-R
> 
> Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
Hi Gregor,

I think this got raised before, but I am also not keen on the terminology
of having the 'slave' naming.  As far as the IIO device is concerned it's
the parent and in i2c code for example it's called the client.  I'd call
it parrent I think given it is relative to the IIO device in most cases.

If I read this correctly (more than possible I don't) we are dropping
any earlier elements in the fifo (which is really a filo as it feeds
latest first just to confuse matters).

It's odd to have the fifo only storing the pressures as it may mean if we
use these extra readings we will end up out of sync between temps and
presure readings.

hmm. Tricky little bit of hardware.

If we don't use the hardware fifo (which I think we aren't really using
at the moment) then why not support the trigger use for this device.
The only critical difference is whether we are in oneshot / continuous
mode.  If we detect that the device is using 'our' trigger then
run in continuous mode, if not then run in oneshot?  Bit fiddly in exactly
where you read the data, but not too bad I think...

In theory I'd like to see that fifo used though so you will end up with
what you have now..  Issue is we can't make the switch later as it
would involve ABI breakage for any existing users.  Ah. Just sanity
checked the data rate.  Max 23 Hz! Don't worry about using the fifo
to buffer data if you don't want to - it's more pain than it's worth perhaps.

Right now we export a trigger on the back of any read.. You would have
to stop doing that and instead do it on the back of the dataready interrupt.

So I'd propose (and this may not work so feel free to point out why).

* A conventional dataready interrupt trigger. If its used by this device, then
the pollfunc would do the actual read.

The nasty here is that we need to validate that the trigger is associate
with this device 'before' allowing others to associate.  Could be done I
think in a slightly more than average complexity validate call.

* If another trigger is used then pollfunc would have to initialize a oneshot
read as you already have it doing.

I'd ignore the fifo entirely except as somewhere to get the latest reading
from.  It's slow enough and short enough to not matter much.

This ends up rather like Linus Waleij did in his invense gyro driver which
is another device with fairly similar hardware to this...
Short fifo, only tells us when it's got something or not rather than allowing
a threshold...  

Anyhow, this wouldn't (I think) be too major a chance and crucially it'd
get rid of the 'confusing' userspace interface of not setting the trigger
to the one provided by the device.

Otherwise, various minor bits and bobs inline in what is a pretty nice
driver (from a less than ideal datasheet asuming you don't have a much
better one than the one google feeds me!)

Jonathan
> ---
>  .../devicetree/bindings/iio/pressure/zpa2326.txt   |   25 +
>  drivers/iio/pressure/Kconfig                       |   35 +
>  drivers/iio/pressure/Makefile                      |    3 +
>  drivers/iio/pressure/zpa2326.c                     | 1871 ++++++++++++++++++++
>  drivers/iio/pressure/zpa2326.h                     |   95 +
>  drivers/iio/pressure/zpa2326_i2c.c                 |   98 +
>  drivers/iio/pressure/zpa2326_spi.c                 |  102 ++
>  7 files changed, 2229 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/pressure/zpa2326.txt
>  create mode 100644 drivers/iio/pressure/zpa2326.c
>  create mode 100644 drivers/iio/pressure/zpa2326.h
>  create mode 100644 drivers/iio/pressure/zpa2326_i2c.c
>  create mode 100644 drivers/iio/pressure/zpa2326_spi.c
> 
> diff --git a/Documentation/devicetree/bindings/iio/pressure/zpa2326.txt b/Documentation/devicetree/bindings/iio/pressure/zpa2326.txt
> new file mode 100644
> index 0000000..83f5139
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/pressure/zpa2326.txt
> @@ -0,0 +1,25 @@
> +Murata ZPA2326 pressure sensor
> +
> +Pressure sensor from Murata with SPI and I2C bus interfaces.
> +
> +Required properties:
> +- compatible: "murata,zpa2326"
> +- reg: the I2C address or SPI chip select the device will respond to
> +
> +Optional properties:
> +- interrupt-parent: should be the phandle for the interrupt controller
> +- interrupts: interrupt mapping for IRQ
> +- vdd-supply: an optional regulator that needs to be on to provide VDD
> +  power to the sensor
> +- vref-supply: an optional regulator that needs to be on to provide VREF
> +  power to the sensor
> +
> +Example:
> +
> +zpa2326@5c {
> +	compatible = "murata,zpa2326";
> +	reg = <0x5c>;
> +	interrupt-parent = <&gpio>;
> +	interrupts = <12>;
> +	vdd-supply = <&ldo_1v8_gnss>;
> +};
> diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
> index d130cdc..2134f20 100644
> --- a/drivers/iio/pressure/Kconfig
> +++ b/drivers/iio/pressure/Kconfig
> @@ -187,4 +187,39 @@ config HP206C
>  	  This driver can also be built as a module. If so, the module will
>  	  be called hp206c.
>  
> +config ZPA2326
> +	tristate "Murata ZPA2326 pressure sensor driver"
> +	depends on I2C || SPI_MASTER
> +	select REGMAP
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
> +	help
> +	  Say Y here to build support for the Murata ZPA2326 pressure and
> +	  temperature sensor.
> +
> +	  To compile this driver as a module, choose M here: the module will
> +	  be called zpa2326.
> +
> +config ZPA2326_I2C
> +	tristate "support I2C bus connection"
> +	depends on I2C && ZPA2326
> +	select REGMAP_I2C
> +	help
> +	  Say Y here to build I2C bus support for the Murata ZPA2326 pressure
> +	  and temperature sensor.
> +
> +	  To compile this driver as a module, choose M here: the module will
> +	  be called zpa2326_i2c.
> +
> +config ZPA2326_SPI
> +	tristate "support SPI bus connection"
> +	depends on SPI_MASTER && ZPA2326
> +	select REGMAP_SPI
> +	help
> +	  Say Y here to build SPI bus support for the Murata ZPA2326 pressure
> +	  and temperature sensor.
> +
> +	  To compile this driver as a module, choose M here: the module will
> +	  be called zpa2326_spi.
> +
>  endmenu
> diff --git a/drivers/iio/pressure/Makefile b/drivers/iio/pressure/Makefile
> index 7f395be..fff7718 100644
> --- a/drivers/iio/pressure/Makefile
> +++ b/drivers/iio/pressure/Makefile
> @@ -22,6 +22,9 @@ st_pressure-y := st_pressure_core.o
>  st_pressure-$(CONFIG_IIO_BUFFER) += st_pressure_buffer.o
>  obj-$(CONFIG_T5403) += t5403.o
>  obj-$(CONFIG_HP206C) += hp206c.o
> +obj-$(CONFIG_ZPA2326) += zpa2326.o
> +obj-$(CONFIG_ZPA2326_I2C) += zpa2326_i2c.o
> +obj-$(CONFIG_ZPA2326_SPI) += zpa2326_spi.o
>  
>  obj-$(CONFIG_IIO_ST_PRESS_I2C) += st_pressure_i2c.o
>  obj-$(CONFIG_IIO_ST_PRESS_SPI) += st_pressure_spi.o
> diff --git a/drivers/iio/pressure/zpa2326.c b/drivers/iio/pressure/zpa2326.c
> new file mode 100644
> index 0000000..c751365
> --- /dev/null
> +++ b/drivers/iio/pressure/zpa2326.c
> @@ -0,0 +1,1871 @@
> +/*
> + * Murata ZPA2326 pressure and temperature sensor IIO driver
> + *
> + * Copyright (c) 2016 Parrot S.A.
> + *
> + * Author: Gregor Boirie <gregor.boirie@parrot.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published by
> + * the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
Unneeded blank line.
> + */
> +
> +/**
> + * DOC: ZPA2326 theory of operations
> + *
> + * This driver supports the following IIO modes: %INDIO_DIRECT_MODE,
> + * %INDIO_BUFFER_SOFTWARE and %INDIO_BUFFER_TRIGGERED.
> + * A hardware trigger is also implemented to dispatch registered IIO trigger
> + * consumers upon "sample ready" interrupts.
Nice to have though adds a fair 'suprise' to the userspace side! Not sure what
we do about that.
> + * ZPA2326 hardware supports 2 sampling mode: one shot and continuous.
> + *
> + * A complete one shot sampling cycle gets device out of low power mode,
> + * performs pressure and temperature measurements, then automatically switches
> + * back to low power mode. It is meant for on demand sampling with optimal power
> + * saving at the cost of lower sampling rate and higher software overhead.
> + * This is a natural candidate for IIO read_raw hook implementation
> + * (%INDIO_DIRECT_MODE). It is also used for triggered buffering support to
> + * ensure explicit synchronization with external trigger events
> + * (%INDIO_BUFFER_TRIGGERED).
> + *
> + * The continuous mode works according to a periodic hardware measurement
> + * process continuously pushing samples into an internal hardware FIFO (for
> + * pressure samples only). Measurement cycle completion may be signaled by a
> + * "sample ready" interrupt.
> + * Typical software sequence of operations :
> + * - get device out of low power mode,
> + * - setup hardware sampling period,
> + * - at end of period, upon data ready interrupt: pop pressure samples out of
> + *   hardware FIFO and fetch temperature sample
> + * - when no longer needed, stop sampling process by putting device into
> + *   low power mode.
> + * This mode is used to implement %INDIO_BUFFER_SOFTWARE mode if device tree
> + * declares a valid interrupt line. It is not compatible with trigger driven
> + * acquisition.
> + *
> + * Note that hardware sampling frequency is taken into account for
> + * %INDIO_BUFFER_SOFTWARE mode only as the highest sampling rate seems to be the
> + * most energy efficient.
> + *
> + * TODO:
> + *   preset pressure threshold crossing / IIO events ;
> + *   differential pressure sampling ;
> + *   hardware samples averaging.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include "zpa2326.h"
> +
> +/* 200 ms should be enough for the longest conversion time in one-shot mode. */
> +#define ZPA2326_CONVERSION_JIFFIES (HZ / 5)
> +
> +/* There should be a 1 ms delay (Tpup) after getting out of reset. */
> +#define ZPA2326_TPUP_USEC_MIN      (1000)
> +#define ZPA2326_TPUP_USEC_MAX      (2000)
> +
> +/**
> + * struct zpa2326_frequency - Hardware sampling frequency descriptor
> + * @hz : Frequency in Hertz.
> + * @odr: Output Data Rate word as expected by %ZPA2326_CTRL_REG3_REG.
> + */
> +struct zpa2326_frequency {
> +	int hz;
> +	u16 odr;
> +};
> +
> +/*
> + * Keep these in strict ascending order: last array entry is expected to
> + * correspond to the highest sampling frequency.
> + */
> +static const struct zpa2326_frequency zpa2326_sampling_frequencies[] = {
> +	{ .hz = 1,  .odr = 1 << ZPA2326_CTRL_REG3_ODR_SHIFT },
> +	{ .hz = 5,  .odr = 5 << ZPA2326_CTRL_REG3_ODR_SHIFT },
> +	{ .hz = 11, .odr = 6 << ZPA2326_CTRL_REG3_ODR_SHIFT },
> +	{ .hz = 23, .odr = 7 << ZPA2326_CTRL_REG3_ODR_SHIFT },
> +};
> +
> +/* Return the highest hardware sampling frequency available. */
> +static const struct zpa2326_frequency *zpa2326_highest_frequency(void)
> +{
> +	return &zpa2326_sampling_frequencies[
> +		ARRAY_SIZE(zpa2326_sampling_frequencies) - 1];
> +}
> +
> +/**
> + * struct zpa_private - Per-device internal private state
> + * @timestamp:  Buffered samples ready datum.
> + * @regmap:     Underlying I2C / SPI bus adapter used to abstract slave register
> + *              accesses.
> + * @result:     Allows sampling logic to get completion status of operations
> + *              that interrupt handlers perform asynchronously.
> + * @data_ready: Interrupt handler uses this to wake user context up at sampling
> + *              operation completion.
> + * @trigger:    Optional hardware / interrupt driven trigger used to notify
> + *              external devices a new sample is ready.
> + * @waken:      Flag indicating whether or not device has just been powered on.
> + * @irq:        Optional interrupt line: negative if not declared into DT, in
> + *              which case sampling logic keeps polling status register to
> + *              detect completion.
> + * @frequency:  Current hardware sampling frequency.
> + * @vref:       Power / voltage reference.
> + * @vdd:        Power supply.
> + */
> +struct zpa2326_private {
> +	s64                             timestamp;
> +	struct regmap                  *regmap;
> +	int                             result;
> +	struct completion               data_ready;
> +	struct iio_trigger             *trigger;
> +	bool                            waken;
> +	int                             irq;
> +	const struct zpa2326_frequency *frequency;
> +	struct regulator               *vref;
> +	struct regulator               *vdd;
> +};
> +
> +#define zpa2326_err(_idev, _format, _arg...) \
> +	dev_err(zpa2326_iio2slave(_idev), _format, ##_arg)
> +
> +#define zpa2326_warn(_idev, _format, _arg...) \
> +	dev_warn(zpa2326_iio2slave(_idev), _format, ##_arg)
> +
> +#define zpa2326_dbg(_idev, _format, _arg...) \
> +	dev_dbg(zpa2326_iio2slave(_idev), _format, ##_arg)
> +
> +static struct zpa2326_private *zpa2326_iio2priv(const struct iio_dev *indio_dev)
The extra characters in zpa2326_iio_to_priv don't outweigh my horror at
txt speak ;)
> +{
> +	return (struct zpa2326_private *)iio_priv(indio_dev);
> +}
> +

These read / write wrappers don't add much so could just put the relevant
code inline. I don't really care though if you want to keep them as is!
> +/**
> + * zpa2326_read_byte() - Fetch single byte from slave register.
> + * @indio_dev: IIO device the slave is attached to.
> + * @address:   Address of register to read from.
> + *
> + * Return: The fetched byte when successful, a negative error code otherwise.
> + */
> +static int zpa2326_read_byte(const struct iio_dev *indio_dev, u8 address)
> +{
> +	unsigned int val;
> +	int          err;
> +
> +	err = regmap_read(zpa2326_iio2priv(indio_dev)->regmap, address, &val);
> +	if (err)
> +		return err;
> +
> +	return val;
> +}
> +
> +/**
> + * zpa2326_write_byte() - Store single byte to slave register.
> + * @indio_dev: IIO device the slave is attached to
> + * @address:   Address of register to write to
> + * @value:     value to store into register
> + *
> + * Return: Zero when successful, a negative error code otherwise.
> + */
> +static int zpa2326_write_byte(const struct iio_dev *indio_dev,
> +			      u8                    address,
> +			      u8                    value)
> +{
> +	return regmap_write(zpa2326_iio2priv(indio_dev)->regmap, address,
> +			    value);
> +}
> +
> +/**
> + * zpa2326_read_block() - Fetch multiple bytes from a block of contiguous slave
> + *                        registers.
> + * @indio_dev: IIO device the slave is attached to.
> + * @address:   Start address of contiguous registers block to read from.
> + * @length:    Number of bytes to fetch.
> + * @value:     Location to store fetched data into.
> + *
> + * Return: Zero when successful, a negative error code otherwise.
> + */
> +static int zpa2326_read_block(const struct iio_dev *indio_dev,
> +			      u8                    address,
> +			      u8                    length,
> +			      u8                   *value)
> +{
> +	return regmap_bulk_read(zpa2326_iio2priv(indio_dev)->regmap, address,
> +				value, length);
> +}
> +
> +bool zpa2326_isreg_writeable(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case ZPA2326_REF_P_XL_REG:
> +	case ZPA2326_REF_P_L_REG:
> +	case ZPA2326_REF_P_H_REG:
> +	case ZPA2326_RES_CONF_REG:
> +	case ZPA2326_CTRL_REG0_REG:
> +	case ZPA2326_CTRL_REG1_REG:
> +	case ZPA2326_CTRL_REG2_REG:
> +	case ZPA2326_CTRL_REG3_REG:
> +	case ZPA2326_THS_P_LOW_REG:
> +	case ZPA2326_THS_P_HIGH_REG:
> +		return true;
> +
> +	default:
> +		return false;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(zpa2326_isreg_writeable);
> +
> +bool zpa2326_isreg_readable(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case ZPA2326_REF_P_XL_REG:
> +	case ZPA2326_REF_P_L_REG:
> +	case ZPA2326_REF_P_H_REG:
> +	case ZPA2326_DEVICE_ID_REG:
> +	case ZPA2326_RES_CONF_REG:
> +	case ZPA2326_CTRL_REG0_REG:
> +	case ZPA2326_CTRL_REG1_REG:
> +	case ZPA2326_CTRL_REG2_REG:
> +	case ZPA2326_CTRL_REG3_REG:
> +	case ZPA2326_INT_SOURCE_REG:
> +	case ZPA2326_THS_P_LOW_REG:
> +	case ZPA2326_THS_P_HIGH_REG:
> +	case ZPA2326_STATUS_REG:
> +	case ZPA2326_PRESS_OUT_XL_REG:
> +	case ZPA2326_PRESS_OUT_L_REG:
> +	case ZPA2326_PRESS_OUT_H_REG:
> +	case ZPA2326_TEMP_OUT_L_REG:
> +	case ZPA2326_TEMP_OUT_H_REG:
> +		return true;
> +
> +	default:
> +		return false;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(zpa2326_isreg_readable);
> +
> +bool zpa2326_isreg_precious(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case ZPA2326_INT_SOURCE_REG:
> +	case ZPA2326_PRESS_OUT_H_REG:
> +		return true;
> +
> +	default:
> +		return false;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(zpa2326_isreg_precious);
> +
> +/**
> + * zpa2326_enable_device() - Enable device, i.e. get out of low power mode.
> + * @indio_dev: The IIO device associated with the hardware to enable.
> + *
> + * Required to access complete register space and to perform any sampling
> + * or control operations.
> + *
> + * Return: Zero when successful, a negative error code otherwise.
> + */
> +static int zpa2326_enable_device(const struct iio_dev *indio_dev)
> +{
> +	int err = zpa2326_write_byte(indio_dev, ZPA2326_CTRL_REG0_REG,
> +				     ZPA2326_CTRL_REG0_ENABLE);
> +	if (err) {
> +		zpa2326_err(indio_dev, "failed to enable device (%d)", err);
> +		return err;
> +	}
> +
> +	zpa2326_dbg(indio_dev, "enabled");
> +	return 0;
> +}
> +
> +/**
> + * zpa2326_disable_device() - Disable device, i.e. switch to low power mode.
> + * @indio_dev: The IIO device associated with the hardware to disable.
> + *
> + * Only %ZPA2326_DEVICE_ID_REG and %ZPA2326_CTRL_REG0_REG registers may be
> + * accessed once device is in the disabled state.
I'd call this zpa2326_sleep or something like that.  Disabled seems too harsh
as I'd expect the power supply to be turned off if we were realy disabling it.
> + *
> + * Return: Zero when successful, a negative error code otherwise.
> + */
> +static int zpa2326_disable_device(const struct iio_dev *indio_dev)
> +{
> +	int err = zpa2326_write_byte(indio_dev, ZPA2326_CTRL_REG0_REG, 0);
> +
> +	if (err) {
> +		zpa2326_err(indio_dev, "failed to disable device (%d)", err);
> +		return err;
> +	}
> +
> +	zpa2326_dbg(indio_dev, "disabled");
> +	return 0;
> +}
> +
> +/**
> + * zpa2326_reset_device() - Reset device to default hardware state.
> + * @indio_dev: The IIO device associated with the hardware to reset.
> + *
> + * Disable sampling and empty hardware FIFO.
> + * Device must be enabled before reset, i.e. not in low power mode.
> + *
> + * Return: Zero when successful, a negative error code otherwise.
> + */
> +static int zpa2326_reset_device(const struct iio_dev *indio_dev)
> +{
> +	int err = zpa2326_write_byte(indio_dev, ZPA2326_CTRL_REG2_REG,
> +				     ZPA2326_CTRL_REG2_SWRESET);
> +	if (err) {
> +		zpa2326_err(indio_dev, "failed to reset device (%d)", err);
> +		return err;
> +	}
> +
> +	usleep_range(ZPA2326_TPUP_USEC_MIN, ZPA2326_TPUP_USEC_MAX);
> +
> +	zpa2326_dbg(indio_dev, "reset");
blank line and in all similar simple return cases...
> +	return 0;
> +}
> +
> +/**
> + * zpa2326_start_oneshot() - Start a single sampling cycle, i.e. in one shot
> + *                           mode.
> + * @indio_dev: The IIO device associated with the sampling hardware.
> + *
> + * Device must have been previously enabled and configured for one shot mode.
> + * Device will be switched back to low power mode at end of cycle.
> + *
> + * Return: Zero when successful, a negative error code otherwise.
> + */
> +static int zpa2326_start_oneshot(const struct iio_dev *indio_dev)
> +{
> +	int err = zpa2326_write_byte(indio_dev, ZPA2326_CTRL_REG0_REG,
> +				     ZPA2326_CTRL_REG0_ENABLE |
> +				     ZPA2326_CTRL_REG0_ONE_SHOT);
> +	if (err) {
> +		zpa2326_err(indio_dev, "failed to start one shot cycle (%d)",
> +			    err);
> +		return err;
> +	}
> +
> +	zpa2326_dbg(indio_dev, "one shot cycle started");
> +	return 0;
> +}
> +
> +/**
> + * zpa2326_power_on() - Power on device to allow subsequent configuration.
> + * @indio_dev: The IIO device associated with the sampling hardware.
> + * @private:   Internal private state related to @indio_dev.
> + *
> + * Sampling will be disabled, preventing strange things from happening in our
> + * back. Hardware FIFO content will be cleared.
> + * When successful, device will be left in the enabled state to allow further
> + * configuration.
> + *
> + * Return: Zero when successful, a negative error code otherwise.
> + */
> +static int zpa2326_power_on(const struct iio_dev         *indio_dev,
> +			    const struct zpa2326_private *private)
> +{
> +	int err = regulator_enable(private->vref);
> +
> +	if (err)
> +		return err;
> +
> +	err = regulator_enable(private->vdd);
> +	if (err)
> +		goto vref;
> +
> +	zpa2326_dbg(indio_dev, "powered on");
> +
> +	err = zpa2326_enable_device(indio_dev);
> +	if (err)
> +		goto vdd;
> +
> +	err = zpa2326_reset_device(indio_dev);
> +	if (err)
> +		goto disable;
> +
> +	return 0;
> +
> +disable:
> +	zpa2326_disable_device(indio_dev);
> +vdd:
> +	regulator_disable(private->vdd);
> +vref:
> +	regulator_disable(private->vref);
> +
> +	zpa2326_dbg(indio_dev, "powered off");
> +	return err;
> +}
> +
> +/**
> + * zpa2326_power_off() - Power off device, i.e. disable attached power
> + *                       regulators.
> + * @indio_dev: The IIO device associated with the sampling hardware.
> + * @private:   Internal private state related to @indio_dev.
> + *
> + * Return: Zero when successful, a negative error code otherwise.
> + */
> +static void zpa2326_power_off(const struct iio_dev         *indio_dev,
> +			      const struct zpa2326_private *private)
> +{
> +	regulator_disable(private->vdd);
> +	regulator_disable(private->vref);
> +
> +	zpa2326_dbg(indio_dev, "powered off");
> +}
> +
> +/**
> + * zpa2326_config_oneshot() - Setup device for one shot / on demand mode.
> + * @indio_dev: The IIO device associated with the sampling hardware.
> + * @irq:       Optional interrupt line the hardware uses to notify new data
> + *             samples are ready. A negative value indicates no interrupt are
> + *             available, meaning polling is required.
Why not use the conventional choice of 0 for no interrupt specified?
> + *
> + * Output Data Rate is configured for the highest possible rate so that
> + * conversion time and power consumption are reduced to a minimum.
> + * Note that hardware internal averaging machinery (not implemented in this
> + * driver) is not applicable in this mode.
> + *
> + * Device must have been previously enabled before calling
> + * zpa2326_config_oneshot().
> + *
> + * Return: Zero when successful, a negative error code otherwise.
> + */
> +static int zpa2326_config_oneshot(const struct iio_dev *indio_dev,
> +				  int                   irq)
> +{
> +	const struct zpa2326_frequency *freq = zpa2326_highest_frequency();
> +	int                             err;
> +
> +	/* Setup highest available Output Data Rate for one shot mode. */
> +	err = zpa2326_write_byte(indio_dev, ZPA2326_CTRL_REG3_REG, freq->odr);
> +	if (err)
> +		return err;
> +
> +	if (irq > 0)
> +		/* Request interrupt when new sample is available. */
> +		err = zpa2326_write_byte(indio_dev, ZPA2326_CTRL_REG1_REG,
> +					 (u8)~ZPA2326_CTRL_REG1_MASK_DATA_RDY);
> +	if (err) {
> +		dev_err(zpa2326_iio2slave(indio_dev),
> +			"failed to setup one shot mode (%d)", err);
> +		return err;
> +	}
> +
> +	dev_dbg(zpa2326_iio2slave(indio_dev), "one shot mode setup @%dHz",
> +		freq->hz);
blank line.
> +	return 0;
> +}
> +
> +/**
> + * zpa2326_clear_fifo() - Clear remaining entries in hardware FIFO.
> + * @indio_dev: The IIO device associated with the sampling hardware.
> + * @min_count: Number of samples present within hardware FIFO.
> + *
> + * @min_count argument is a hint corresponding to the known minimum number of
> + * samples currently living in the FIFO. This allows to reduce the number of bus
> + * accesses by skipping status register read operation as long as we know for
> + * sure there are still entries left.
> + *
> + * Return: Zero when successful, a negative error code otherwise.
> + */
> +static int zpa2326_clear_fifo(const struct iio_dev *indio_dev,
> +			      unsigned int          min_count)
> +{
> +	int err;
> +
> +	if (!min_count) {
> +		/*
> +		 * No hint: read status register to determine whether FIFO is
> +		 * empty or not.
> +		 */
> +		err = zpa2326_read_byte(indio_dev, ZPA2326_STATUS_REG);
> +		if (err < 0)
> +			goto err;
> +
> +		if (err & ZPA2326_STATUS_FIFO_E)
> +			/* Fifo is empty: nothing to trash. */
> +			return 0;
> +	}
> +
> +	/* Clear FIFO. */
> +	do {
> +		/*
> +		 * A single fetch from pressure MSB register is enough to pop
> +		 * values out of FIFO.
> +		 */
> +		err = zpa2326_read_byte(indio_dev, ZPA2326_PRESS_OUT_H_REG);
> +		if (err < 0)
> +			goto err;
> +
> +		if (min_count) {
> +			/*
> +			 * We know for sure there are at least min_count entries
> +			 * left in FIFO. Skip status register read.
> +			 */
> +			min_count--;
> +			continue;
> +		}
> +
> +		err = zpa2326_read_byte(indio_dev, ZPA2326_STATUS_REG);
> +		if (err < 0)
> +			goto err;
> +
> +	} while (!(err & ZPA2326_STATUS_FIFO_E));
> +
> +	zpa2326_dbg(indio_dev, "FIFO cleared");
> +	return 0;
> +
> +err:
> +	zpa2326_err(indio_dev, "failed to clear FIFO (%d)", err);
> +	return err;
> +}
> +
> +/**
> + * zpa2326_dequeue_pressure() - Retrieve the most recent pressure sample from
> + *                              hardware FIFO.
> + * @indio_dev: The IIO device associated with the sampling hardware.
> + * @pressure:  Sampled pressure output.
> + *
> + * Note that ZPA2326 hardware FIFO stores pressure samples only.
> + *
> + * Return: Zero when successful, a negative error code otherwise.
> + */
> +static int zpa2326_dequeue_pressure(const struct iio_dev *indio_dev,
> +				    u32                  *pressure)
> +{
> +	int err = zpa2326_read_byte(indio_dev, ZPA2326_STATUS_REG);
> +	int cleared = -1;
> +
> +	if (err < 0)
> +		return err;
> +
> +	*pressure = 0;
> +
> +	if (err & ZPA2326_STATUS_P_OR) {
> +		/*
> +		 * Fifo overrun : first sample dequeued from FIFO is the
> +		 * newest.
> +		 */
> +		zpa2326_warn(indio_dev, "FIFO overflow");
> +
> +		err = zpa2326_read_block(indio_dev, ZPA2326_PRESS_OUT_XL_REG, 3,
> +					 (u8 *)pressure);
> +		if (err)
> +			return err;
> +
> +#define ZPA2326_FIFO_DEPTH (16U)
> +		/* Hardware FIFO may hold no more than 16 pressure samples. */
> +		return zpa2326_clear_fifo(indio_dev, ZPA2326_FIFO_DEPTH - 1);
> +	}
> +
> +	/*
> +	 * Fifo has not overflown : retrieve newest sample. We need to pop
> +	 * values out until FIFO is empty : last fetched pressure is the newest.
> +	 * In nominal cases, we should find a single queued sample only.
> +	 */
> +	do {
> +		err = zpa2326_read_block(indio_dev, ZPA2326_PRESS_OUT_XL_REG, 3,
> +					 (u8 *)pressure);
> +		if (err)
> +			return err;
> +
> +		err = zpa2326_read_byte(indio_dev, ZPA2326_STATUS_REG);
> +		if (err < 0)
> +			return err;
> +
> +		cleared++;
> +	} while (!(err & ZPA2326_STATUS_FIFO_E));
> +
> +	if (cleared)
When running without trigger we could push these into the software fifo?
(or am I just confused which is more than likely!)
> +		/*
> +		 * Samples were pushed by hardware during previous rounds but we
> +		 * didn't consume them fast enough: inform user.
> +		 */
> +		zpa2326_warn(indio_dev, "cleared %d FIFO entries", cleared);
> +
> +	return 0;
> +}
> +
> +/**
> + * zpa2326_fill_sample_buffer() - Enqueue new channel samples to IIO buffer.
> + * @indio_dev: The IIO device associated with the sampling hardware.
> + * @private:   Internal private state related to @indio_dev.
> + *
> + * Return: Zero when successful, a negative error code otherwise.
> + */
> +static int zpa2326_fill_sample_buffer(struct iio_dev               *indio_dev,
> +				      const struct zpa2326_private *private)
> +{
> +	struct {
> +		u32 pressure;
> +		u16 temperature;
> +		u64 timestamp;
> +	}   sample;
> +	int err;
> +
> +	if (test_bit(0, indio_dev->active_scan_mask)) {
> +		/* Get current pressure from hardware FIFO. */
> +		err = zpa2326_dequeue_pressure(indio_dev, &sample.pressure);
> +		if (err) {
> +			zpa2326_warn(indio_dev, "failed to fetch pressure (%d)",
> +				     err);
> +			return err;
> +		}
> +	}
> +
> +	if (test_bit(1, indio_dev->active_scan_mask)) {
> +		/* Get current temperature. */
> +		err = zpa2326_read_block(indio_dev, ZPA2326_TEMP_OUT_L_REG, 2,
> +					 (u8 *)&sample.temperature);
Could this lead to the situation where we are feeding newer temps out
alongside old pressure readings?

Wonderfully inconsistent and confusing hardware here ;)
> +		if (err) {
> +			zpa2326_warn(indio_dev,
> +				     "failed to fetch temperature (%d)", err);
> +			return err;
> +		}
> +	}
> +
> +	/*
> +	 * Now push samples using timestamp stored either :
> +	 *   - by hardware interrupt handler if interrupt is available: see
> +	 *     zpa2326_handle_irq(),
> +	 *   - or oneshot completion polling machinery : see
> +	 *     zpa2326_trigger_oneshot().
> +	 */
> +	iio_push_to_buffers_with_timestamp(indio_dev, &sample,
> +					   private->timestamp);
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM
> +static int zpa2326_runtime_suspend(struct device *slave)
> +{
> +	const struct iio_dev *indio_dev = dev_get_drvdata(slave);
> +
> +	if (pm_runtime_autosuspend_expiration(slave))
> +		/* Userspace changed autosuspend delay. */
> +		return -EAGAIN;
> +
> +	zpa2326_power_off(indio_dev, zpa2326_iio2priv(indio_dev));
> +
> +	return 0;
> +}
> +
> +static int zpa2326_runtime_resume(struct device *slave)
> +{
> +	const struct iio_dev *indio_dev = dev_get_drvdata(slave);
> +
> +	return zpa2326_power_on(indio_dev, zpa2326_iio2priv(indio_dev));
> +}
> +
> +const struct dev_pm_ops zpa2326_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> +				pm_runtime_force_resume)
> +	SET_RUNTIME_PM_OPS(zpa2326_runtime_suspend, zpa2326_runtime_resume,
> +			   NULL)
> +};
> +EXPORT_SYMBOL_GPL(zpa2326_pm_ops);
> +
> +/**
> + * zpa2326_resume() - Request the PM layer to power supply the device.
> + * @indio_dev: The IIO device associated with the sampling hardware.
> + *
> + * Return:
> + *  < 0 - a negative error code meaning failure ;
> + *    0 - success, device has just been powered up ;
> + *    1 - success, device was already powered.
> + */
> +static int zpa2326_resume(const struct iio_dev *indio_dev)
> +{
> +	struct device *slave = zpa2326_iio2slave(indio_dev);
> +	int            err = pm_runtime_get_sync(slave);
> +
> +	if (err < 0)
> +		return err;
> +
> +	if (err > 0) {
> +		/*
> +		 * Device was already power supplied: get it out of low power
> +		 * mode and inform caller.
> +		 */
> +		zpa2326_enable_device(indio_dev);
> +		return 1;
> +	}
> +
> +	/* Inform caller device has just been brought back to life. */
> +	return 0;
> +}
> +
> +/**
> + * zpa2326_suspend() - Schedule a power down using autosuspend feature of PM
> + *                     layer.
> + * @indio_dev: The IIO device associated with the sampling hardware.
> + *
> + * Device is switched to low power mode at first to save power even when
> + * attached regulator is a "dummy" one.
> + */
> +static void zpa2326_suspend(struct iio_dev *indio_dev)
> +{
> +	struct device *slave = zpa2326_iio2slave(indio_dev);
> +
> +	zpa2326_disable_device(indio_dev);
> +
> +	pm_runtime_mark_last_busy(slave);
> +	pm_runtime_put_autosuspend(slave);
> +}
> +
> +static void zpa2326_init_runtime(struct device *slave)
> +{
> +	pm_runtime_get_noresume(slave);
> +	pm_runtime_set_active(slave);
> +	pm_runtime_enable(slave);
> +	pm_runtime_set_autosuspend_delay(slave, 1000);
> +	pm_runtime_use_autosuspend(slave);
> +	pm_runtime_mark_last_busy(slave);
> +	pm_runtime_put_autosuspend(slave);
> +}
> +
> +static void zpa2326_fini_runtime(struct device *slave)
> +{
> +	pm_runtime_disable(slave);
> +	pm_runtime_set_suspended(slave);
> +}
> +#else /* !CONFIG_PM */
> +static int zpa2326_resume(const struct iio_dev *indio_dev)
> +{
> +	zpa2326_enable_device(indio_dev);
blank line.
> +	return 0;
> +}
> +
> +static void zpa2326_suspend(struct iio_dev *indio_dev)
> +{
> +	zpa2326_disable_device(indio_dev);
> +}
> +
> +#define zpa2326_init_runtime(_slave)
> +#define zpa2326_fini_runtime(_slave)
> +#endif /* !CONFIG_PM */
> +
> +/**
> + * zpa2326_handle_irq() - Process hardware interrupts.
> + * @irq:  Interrupt line the hardware uses to notify new data has arrived.
> + * @data: The IIO device associated with the sampling hardware.
> + *
> + * Timestamp buffered samples as soon as possible then schedule threaded bottom
> + * half.
> + *
> + * Return: Always successful.
> + */
> +static irqreturn_t zpa2326_handle_irq(int irq, void *data)
> +{
> +	struct iio_dev *indio_dev = (struct iio_dev *)data;
> +
> +	if (iio_buffer_enabled(indio_dev)) {
> +		struct zpa2326_private *priv = zpa2326_iio2priv(indio_dev);
> +
> +		/* Timestamping needed for buffered sampling only. */
> +		priv->timestamp = iio_get_time_ns(indio_dev);
> +	}
> +
> +	return IRQ_WAKE_THREAD;
> +}
> +
> +/**
> + * zpa2326_handle_threaded_irq() - Interrupt bottom-half handler.
> + * @irq:  Interrupt line the hardware uses to notify new data has arrived.
> + * @data: The IIO device associated with the sampling hardware.
> + *
> + * Mainly ensures interrupt is caused by a real "new sample available"
> + * condition. This relies upon the ability to perform blocking / sleeping bus
> + * accesses to slave's registers. This is why zpa2326_handle_threaded_irq() is
> + * called from within a thread, i.e. not called from hard interrupt context.
> + *
> + * Return:
> + *   %IRQ_NONE - no consistent interrupt happened ;
> + *   %IRQ_HANDLED - there was new samples available.
> + */
> +static irqreturn_t zpa2326_handle_threaded_irq(int irq, void *data)
> +{
> +	struct iio_dev         *indio_dev = (struct iio_dev *)data;
> +	struct zpa2326_private *priv = zpa2326_iio2priv(indio_dev);
> +	irqreturn_t             ret = IRQ_NONE;
> +
> +	/*
> +	 * Device works according to a level interrupt scheme: reading interrupt
> +	 * status de-asserts interrupt line.
> +	 */
> +	priv->result = zpa2326_read_byte(indio_dev, ZPA2326_INT_SOURCE_REG);
> +	if (priv->result < 0) {
> +		if (indio_dev->currentmode == INDIO_BUFFER_SOFTWARE)
> +			return IRQ_NONE;
> +
> +		goto complete;
> +	}
> +
> +	/* Data ready is the only interrupt source we requested. */
> +	if (!(priv->result & ZPA2326_INT_SOURCE_DATA_RDY)) {
> +		/*
> +		 * Interrupt happened but no new sample available: likely caused
> +		 * by spurious interrupts, in which case, returning IRQ_NONE
> +		 * allows to benefit from the generic spurious interrupts
> +		 * handling.
> +		 */
> +		zpa2326_warn(indio_dev, "unexpected interrupt status %02x",
> +			     priv->result);
> +
> +		if (indio_dev->currentmode == INDIO_BUFFER_SOFTWARE)
> +			return IRQ_NONE;
> +
> +		priv->result = -ENODATA;
> +		goto complete;
> +	}
> +
> +	/* New sample available: dispatch internal trigger consumers. */
> +	iio_trigger_poll_chained(priv->trigger);
> +
> +	if (indio_dev->currentmode == INDIO_BUFFER_SOFTWARE) {
> +		/* Continuous sampling enabled: populate IIO buffer. */
> +		zpa2326_fill_sample_buffer(indio_dev, priv);
> +		return IRQ_HANDLED;
> +	}
> +
> +	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED)
This has me a little confused. This path is basically the completion of
a oneshot read when in triggered buffer mode using say a hrt trigger?
> +		priv->result = zpa2326_fill_sample_buffer(indio_dev, priv);
> +	else
> +		priv->result = 0;
> +
> +	ret = IRQ_HANDLED;
> +
> +complete:
> +	/*
> +	 * Wake up direct or triggered buffer mode waiters: see
> +	 * zpa2326_sample_oneshot() and zpa2326_trigger_oneshot().
> +	 */
> +	complete(&priv->data_ready);
> +	return ret;
> +}
> +
> +/**
> + * zpa2326_wait_oneshot_completion() - Wait for oneshot data ready interrupt.
> + * @indio_dev: The IIO device associated with the sampling hardware.
> + * @private:   Internal private state related to @indio_dev.
> + *
> + * Return: Zero when successful, a negative error code otherwise.
> + */
> +static int zpa2326_wait_oneshot_completion(const struct iio_dev     *indio_dev,
> +					   struct zpa2326_private   *private)
> +{
> +	int ret = wait_for_completion_interruptible_timeout(
> +			&private->data_ready, ZPA2326_CONVERSION_JIFFIES);
> +	if (ret > 0)
> +		/*
> +		 * Interrupt handler completed before timeout: return operation
> +		 * status.
> +		 */
> +		return private->result;
> +
> +	/* Clear all interrupts just to be sure. */
> +	zpa2326_read_byte(indio_dev, ZPA2326_INT_SOURCE_REG);
> +
> +	if (!ret)
> +		/* Timed out. */
> +		ret = -ETIME;
> +
> +	if (ret != -ERESTARTSYS)
> +		zpa2326_warn(indio_dev, "no one shot interrupt occurred (%d)",
> +			     ret);
> +
> +	return ret;
> +}
> +
> +static int zpa2326_init_irq(struct device          *slave,
> +			    struct iio_dev         *indio_dev,
> +			    struct zpa2326_private *private,
> +			    int                     irq)
> +{
> +	int err;
> +
> +	if (irq <= 0) {
> +		/*
> +		 * Platform declared no interrupt line: device will be polled
> +		 * for data availability.
> +		 */
> +		private->irq = -1;
Given irq = 0 is no irq, perhaps there is no need to have -1 instead of just
less than 0 (i.e. a direct assignment).
> +		dev_info(slave, "no interrupt found, running in polling mode");
> +		return 0;
> +	}
> +
> +	private->irq = irq;
> +	init_completion(&private->data_ready);
> +
> +	/* Request handler to be scheduled into threaded interrupt context. */
> +	err = devm_request_threaded_irq(slave, irq, zpa2326_handle_irq,
> +					zpa2326_handle_threaded_irq,
> +					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> +					dev_name(slave), indio_dev);
> +	if (err) {
> +		dev_err(slave, "failed to request interrupt %d (%d)", irq, err);
> +		return err;
> +	}
> +
> +	dev_info(slave, "using interrupt %d", irq);
blank line.
> +	return 0;
> +}
> +
> +/**
> + * zpa2326_claim_direct_mode() - Request exclusive access to device.
> + * @indio_dev: The IIO device associated with the sampling hardware.
> + *
> + * Ensure exclusive access to prevent from modifying device setup in the back of
> + * ongoing operations.
> + * In the mean time, power on device to get access to the complete register map.
> + *
> + * Return: Zero when successful, a negative error code otherwise.
> + */
> +static int zpa2326_claim_direct_mode(struct iio_dev *indio_dev)
This needs to have a name that reflects it is also doing a resume call.
Confused me later in the code when you had checks for positive return values.

Might be simpler to just use both statements inline and drop these wrappers
entirely.  A few more lines of code, but much more obvious what is going on!
> +{
> +	/* Gain exclusive access for userspace usage. */
> +	int ret = iio_device_claim_direct_mode(indio_dev);
> +
> +	if (ret)
> +		return ret;
> +
> +	/* Bring device back to life. */
> +	ret = zpa2326_resume(indio_dev);
> +	if (ret < 0)
> +		goto release;
> +
> +	return ret;
> +
> +release:
> +	/* Relinquish exclusive access. */
> +	iio_device_release_direct_mode(indio_dev);
> +	return ret;
> +}
> +
> +/**
> + * zpa2326_release_direct_mode() - Release exclusive access to device.
> + * @indio_dev: The IIO device associated with the sampling hardware.
> + *
> + * Once released, device is left in low power mode.
> + */
> +static void zpa2326_release_direct_mode(struct iio_dev *indio_dev)
> +{
> +	zpa2326_suspend(indio_dev);
> +	iio_device_release_direct_mode(indio_dev);
> +}
> +
> +/**
> + * zpa2326_poll_oneshot_completion() - Actively poll for one shot data ready.
> + * @indio_dev: The IIO device associated with the sampling hardware.
> + *
> + * Loop over registers content to detect end of sampling cycle. Used when DT
> + * declared no valid interrupt lines.
> + *
> + * Return: Zero when successful, a negative error code otherwise.
> + */
> +static int zpa2326_poll_oneshot_completion(const struct iio_dev *indio_dev)
> +{
> +	unsigned long tmout = jiffies + ZPA2326_CONVERSION_JIFFIES;
> +	int           err;
> +
> +	/*
> +	 * At least, 100 ms is needed for the device to complete its one-shot
> +	 * cycle.
> +	 */
> +	if (msleep_interruptible(100))
> +		return -ERESTARTSYS;
> +
> +	/* Poll for conversion completion in hardware. */
> +	while (true) {
> +		err = zpa2326_read_byte(indio_dev, ZPA2326_CTRL_REG0_REG);
> +		if (err < 0)
> +			goto err;
> +
> +		if (!(err & ZPA2326_CTRL_REG0_ONE_SHOT))
> +			/* One-shot bit self clears at conversion end. */
> +			break;
> +
> +		if (time_after(jiffies, tmout)) {
> +			/* Prevent from waiting forever : let's time out. */
> +			err = -ETIME;
> +			goto err;
> +		}
> +
> +		usleep_range(10000, 20000);
> +	}
> +
> +	/*
> +	 * In oneshot mode, pressure sample availability guarantees that
> +	 * temperature conversion has also completed : just check pressure
> +	 * status bit to keep things simple.
> +	 */
> +	err = zpa2326_read_byte(indio_dev, ZPA2326_STATUS_REG);
> +	if (err < 0)
> +		goto err;
> +
> +	if (!(err & ZPA2326_STATUS_P_DA)) {
> +		/* No sample available. */
> +		err = -ENODATA;
> +		goto err;
> +	}
> +
> +	return 0;
> +
> +err:
> +	zpa2326_warn(indio_dev, "failed to poll one shot completion (%d)", err);
> +	return err;
> +}
> +
> +/**
> + * zpa2326_fetch_raw_sample() - Retrieve a raw sample and convert it to CPU
> + *                              endianness.
> + * @indio_dev: The IIO device associated with the sampling hardware.
> + * @type:      Type of measurement / channel to fetch from.
> + * @value:     Sample output.
> + *
> + * Return: Zero when successful, a negative error code otherwise.
> + */
> +static int zpa2326_fetch_raw_sample(const struct iio_dev *indio_dev,
> +				    enum iio_chan_type    type,
> +				    int                  *value)
> +{
> +	int err;
> +
> +	switch (type) {
> +	case IIO_PRESSURE:
> +		zpa2326_dbg(indio_dev, "fetching raw pressure sample");
> +
> +		err = zpa2326_read_block(indio_dev, ZPA2326_PRESS_OUT_XL_REG, 3,
> +					 (u8 *)value);
> +		if (err) {
> +			zpa2326_warn(indio_dev, "failed to fetch pressure (%d)",
> +				     err);
> +			return err;
> +		}
> +
> +		/* Pressure is a 24 bits wide little-endian unsigned int. */
> +		*value = (((u8 *)value)[2] << 16) | (((u8 *)value)[1] << 8) |
> +			 ((u8 *)value)[0];
> +
> +		return IIO_VAL_INT;
> +
> +	case IIO_TEMP:
> +		zpa2326_dbg(indio_dev, "fetching raw temperature sample");
> +
> +		err = zpa2326_read_block(indio_dev, ZPA2326_TEMP_OUT_L_REG, 2,
> +					 (u8 *)value);
> +		if (err) {
> +			zpa2326_warn(indio_dev,
> +				     "failed to fetch temperature (%d)", err);
> +			return err;
> +		}
> +
> +		/* Temperature is a 16 bits wide little-endian signed int. */
> +		*value = (int)le16_to_cpup((__le16 *)value);
> +
> +		return IIO_VAL_INT;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +/**
> + * zpa2326_sample_oneshot() - Perform a complete one shot sampling cycle.
> + * @indio_dev: The IIO device associated with the sampling hardware.
> + * @type:      Type of measurement / channel to fetch from.
> + * @value:     Sample output.
> + *
> + * Return: Zero when successful, a negative error code otherwise.
> + */
> +static int zpa2326_sample_oneshot(struct iio_dev     *indio_dev,
> +				  enum iio_chan_type  type,
> +				  int                *value)
> +{
> +	/* Gain exclusive access to device. */
> +	int                     ret = zpa2326_claim_direct_mode(indio_dev);
This is a non trivial function call.  Do it after the variable definitions.
(only ones I allow here tend to be simple pointer manipulations like the
next line).
> +	struct zpa2326_private *priv = zpa2326_iio2priv(indio_dev);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	if (ret > 0) {
> +		/*
> +		 * We were already power supplied. Just clear hardware FIFO to
> +		 * get rid of samples acquired during previous rounds (if any).
> +		 * Sampling operation always generates both temperature and
> +		 * pressure samples. The latter are always enqueued into
> +		 * hardware FIFO. This may lead to situations were pressure
> +		 * samples still sit into FIFO when previous cycle(s) fetched
> +		 * temperature data only.
> +		 * Hence, we need to clear hardware FIFO content to prevent from
> +		 * getting outdated values at the end of current cycle.
> +		 */
> +		if (type == IIO_PRESSURE) {
> +			ret = zpa2326_clear_fifo(indio_dev, 0);
> +			if (ret)
> +				goto release;
> +		}
> +	} else {
> +		/*
> +		 * We have just been power supplied, i.e. device is in default
> +		 * "out of reset" state, meaning we need to reconfigure it
> +		 * entirely.
> +		 */
> +		ret = zpa2326_config_oneshot(indio_dev, priv->irq);
> +		if (ret)
> +			goto release;
> +	}
> +
> +	/* Start a sampling cycle in oneshot mode. */
> +	ret = zpa2326_start_oneshot(indio_dev);
> +	if (ret)
> +		goto release;
> +
> +	/* Wait for sampling cycle to complete. */
> +	zpa2326_dbg(indio_dev, "waiting for one shot completion");
> +
> +	if (priv->irq > 0)
> +		ret = zpa2326_wait_oneshot_completion(indio_dev, priv);
> +	else
> +		ret = zpa2326_poll_oneshot_completion(indio_dev);
> +
> +	if (ret)
> +		goto release;
> +
> +	/* Retrieve raw sample value and convert it to CPU endianness. */
> +	ret = zpa2326_fetch_raw_sample(indio_dev, type, value);
> +
> +release:
> +	zpa2326_release_direct_mode(indio_dev);
> +	return ret;
> +}
> +
> +static int zpa2326_validate_trigger(struct iio_dev     *indio_dev,
> +				    struct iio_trigger *trigger)
> +{
> +	int ret = 0;
> +
> +	mutex_lock(&indio_dev->mlock);
> +
> +	/*
> +	 * Reject external trigger attachment if setting up continuous hardware
> +	 * sampling mode.
> +	 */
> +	if (indio_dev->currentmode == INDIO_BUFFER_SOFTWARE)
> +		ret = -EBUSY;
> +
> +	mutex_unlock(&indio_dev->mlock);
> +
> +	return ret;
> +}
> +
> +/**
> + * zpa2326_trigger_oneshot() - Perform an IIO buffered sampling round in one
> + *                             shot mode.
> + * @irq:  The software interrupt assigned to @data
> + * @data: The IIO poll function dispatched by external trigger our device is
> + *        attached to.
> + *
> + * Bottom-half handler called by the IIO trigger our device is currently
trigger to which our device
> + * attached. Allows to synchronize this device buffered sampling with external
Allows us...
> + * events (such as timer expiration, external device sample ready, etc...).
> + *
> + * Basically run the same sequence of operations as for zpa2326_sample_oneshot()
> + * with the following hereafter. Hardware FIFO is not cleared since already done
> + * at buffering enable time and samples dequeueing always retrieves the most
> + * recent value. Samples endianness is not processed since delegated to
> + * userspace in buffered mode.
> + *
> + * Return:
> + *   %IRQ_NONE - no consistent interrupt happened ;
> + *   %IRQ_HANDLED - there was new samples available.
> + */
> +static irqreturn_t zpa2326_trigger_oneshot(int irq, void *data)
> +{
> +	struct iio_poll_func   *pf = data;
> +	struct iio_dev         *indio_dev = pf->indio_dev;
> +	struct zpa2326_private *priv = zpa2326_iio2priv(indio_dev);
> +
> +	/* Start a one shot sampling cycle. */
> +	if (zpa2326_start_oneshot(indio_dev))
> +		goto err;
> +
> +	if (priv->irq <= 0) {
> +		/* No interrupt available: poll for sampling completion. */
> +		if (zpa2326_poll_oneshot_completion(indio_dev))
> +			goto disable;
> +
> +		/* Only timestamp sample once it is ready. */
> +		priv->timestamp = iio_get_time_ns(indio_dev);
> +
> +		/* Enqueue to IIO buffer / userspace. */
> +		zpa2326_fill_sample_buffer(indio_dev, priv);
> +	} else {
> +		/* Interrupt handlers will timestamp and get samples for us. */
> +		if (zpa2326_wait_oneshot_completion(indio_dev, priv))
> +			goto disable;
> +	}
> +
> +	/* Inform attached trigger we are done. */
> +	iio_trigger_notify_done(indio_dev->trig);
> +	return IRQ_HANDLED;
> +
> +disable:
> +	zpa2326_disable_device(indio_dev);
> +err:
> +	iio_trigger_notify_done(indio_dev->trig);
Hmm. Not really the right return value - will result in a 'no one claimed
this interrupt' problem.  It isn't really possible to return an error from
an interrupt handler to anywhere useful.  I'd just return IRQ_HANDLED I think..
> +	return IRQ_NONE;
> +}
> +
> +/**
> + * zpa2326_preenable_ring() - Prepare device for configuring continuous or
> + *                            triggered sampling modes.
> + * @indio_dev: The IIO device associated with the sampling hardware.
> + *
> + * Basically power up device.
> + * Called with IIO device's lock held.
> + *
> + * Return: Zero when successful, a negative error code otherwise.
> + */
> +static int zpa2326_preenable_ring(struct iio_dev *indio_dev)
> +{
> +	int ret = zpa2326_resume(indio_dev);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Tell zpa2326_postenable_ring() if we have just been powered on. */
> +	zpa2326_iio2priv(indio_dev)->waken = !ret;
> +
> +	return 0;
> +}
> +
> +/**
> + * zpa2326_postenable_ring() - Configure and start continuous or triggered
> + *                             sampling.
> + * @indio_dev: The IIO device associated with the sampling hardware.
> + *
> + * If an error is returned, IIO layer will call our postdisable hook for us,
> + * i.e. no need to explicitly power device off here.
> + * Called with IIO device's lock held.
> + *
> + * Return: Zero when successful, a negative error code otherwise.
> + */
> +static int zpa2326_postenable_ring(struct iio_dev *indio_dev)
> +{
> +	const struct zpa2326_private *priv = zpa2326_iio2priv(indio_dev);
> +	int                           err;
> +
> +	if (!priv->waken) {
> +		/*
> +		 * We were already power supplied. Just clear hardware FIFO to
> +		 * get rid of samples acquired during previous rounds (if any).
> +		 */
> +		err = zpa2326_clear_fifo(indio_dev, 0);
> +		if (err)
> +			return err;
> +	}
> +
> +	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
> +		/* Prepare device for triggered buffering usage. */
> +
> +		if (priv->waken) {
> +			/*
> +			 * We have just been power supplied, i.e. device is in
> +			 * default "out of reset" state, meaning we need to
> +			 * properly reconfigure it for on trigger demand usage.
> +			 */
> +			err = zpa2326_config_oneshot(indio_dev, priv->irq);
> +			if (err)
> +				return err;
> +		}
> +
> +		/* Plug our own trigger event handler. */
> +		err = iio_triggered_buffer_postenable(indio_dev);
> +		if (err)
> +			return err;
> +
> +		/*
> +		 * Switch back to low power. A complete one shot sampling cycle
> +		 * will be started upon trigger notification.
> +		 */
> +		return zpa2326_disable_device(indio_dev);
> +	}
> +
> +	/* Prepare then start continuous sampling session. */
Hmm. adds to indentation but I'd prefer this to be under an else to
raise it to an alternative to the above...
> +
> +	if (priv->waken) {
> +		/*
> +		 * We have just been power supplied, i.e. device is in default
> +		 * "out of reset" state, meaning we need to unmask data ready
> +		 * interrupt to process new samples.
> +		 */
> +		err = zpa2326_write_byte(indio_dev, ZPA2326_CTRL_REG1_REG,
> +					 (u8)~ZPA2326_CTRL_REG1_MASK_DATA_RDY);
Ah that suprised me.  So if I understand you correctly, it won't put stuff
in the fifo unless dataready interrupt is on?  Would explain why you don't
have a set_state for the trigger.
> +		if (err)
> +			goto err;
> +	}
> +
> +	/* Start continuous sampling at required frequency. */
> +	err = zpa2326_write_byte(indio_dev, ZPA2326_CTRL_REG3_REG,
> +				 ZPA2326_CTRL_REG3_ENABLE_MEAS |
> +				 priv->frequency->odr);
> +	if (err)
> +		goto err;
> +
> +	zpa2326_dbg(indio_dev, "continuous mode setup @%dHz",
> +		    priv->frequency->hz);
> +	return 0;
> +
> +err:
> +	zpa2326_err(indio_dev, "failed to setup continuous mode (%d)", err);
> +	return err;
> +}
> +
> +/**
> + * zpa2326_predisable_ring() - Stop continuous / triggered sampling.
> + * @indio_dev: The IIO device associated with the sampling hardware.
> + *
> + * Called with IIO device's lock held.
> + *
> + * Return: Zero when successful, a negative error code otherwise.
> + */
> +static int zpa2326_predisable_ring(struct iio_dev *indio_dev)
> +{
> +	if (indio_dev->currentmode == INDIO_BUFFER_SOFTWARE) {
> +		int irq = zpa2326_iio2priv(indio_dev)->irq;
> +		int err;
> +
> +		/*
> +		 * As device is working in continuous mode, handlers may be
> +		 * accessing resources we are currently freeing...
> +		 * Prevent this by disabling interrupt handlers and ensure
> +		 * the device will generate no more interrupts unless explicitly
> +		 * required to, i.e. by restoring back to default one shot mode.
> +		 */
> +		disable_irq(irq);
> +
> +		/*
> +		 * Disable continuous sampling mode to restore settings for
> +		 * one shot / direct sampling operations.
> +		 */
> +		err = zpa2326_write_byte(indio_dev, ZPA2326_CTRL_REG3_REG,
> +					 zpa2326_highest_frequency()->odr);
> +		if (err)
> +			goto err;
> +
> +		/*
> +		 * Now that device won't generate interrupts on its own,
> +		 * acknowledge any currently active interrupts (may happen on
> +		 * rare occasions while stopping continuous mode).
> +		 */
> +		err = zpa2326_read_byte(indio_dev, ZPA2326_INT_SOURCE_REG);
> +		if (err < 0)
> +			goto err;
> +
> +		/*
> +		 * Re-enable interrupts only if we can guarantee the device will
> +		 * generate no more interrupts to prevent handlers from
> +		 * accessing released resources.
> +		 */
> +		enable_irq(irq);
> +		return 0;
> +
> +err:
> +		zpa2326_err(indio_dev,
> +			    "failed to stop buffering, leaving interrupt disabled... (%d)",
> +			    err);
> +		return err;
> +	}
> +
> +	/* Triggered buffering: unplug our own trigger event handler. */
> +	return iio_triggered_buffer_predisable(indio_dev);
> +}
> +
> +static int zpa2326_postdisable_ring(struct iio_dev *indio_dev)
> +{
> +	zpa2326_suspend(indio_dev);
blank line here.
> +	return 0;
> +}
> +
> +static const struct iio_buffer_setup_ops zpa2326_ring_setup_ops = {
> +	.preenable   = zpa2326_preenable_ring,
> +	.postenable  = zpa2326_postenable_ring,
> +	.predisable  = zpa2326_predisable_ring,
> +	.postdisable = zpa2326_postdisable_ring
> +};
> +
> +static int zpa2326_init_ring(struct device  *slave,
> +			     struct iio_dev *indio_dev,
> +			     int             irq)
> +{
> +	int err = devm_iio_triggered_buffer_setup(slave, indio_dev, NULL,
> +						  zpa2326_trigger_oneshot,
> +						  &zpa2326_ring_setup_ops);
> +	if (err)
> +		return err;
> +
> +	if (irq > 0)
> +		/* Allow continuous hardware sampling if interrupt available. */
> +		indio_dev->modes |= INDIO_BUFFER_SOFTWARE;
It doesn't feel like this statement belongs in an init_ring function.
> +
> +	return 0;
> +}
> +
> +static int zpa2326_validate_device(struct iio_trigger *trigger,
> +				   struct iio_dev     *indio_dev)
> +{
> +	/*
> +	 * Using our own interrupt driven trigger to start a triggered buffer
> +	 * sampling round is pure nonsense: use continuous hardware sampling
> +	 * mode instead, i.e. %INDIO_BUFFER_SOFTWARE.
> +	 * Synchronize against an external trigger / device otherwise.
> +	 */
> +	if (indio_dev == (struct iio_dev *)iio_trigger_get_drvdata(trigger))
> +		return -EINVAL;
Wow, this is the first driver I've seen that rejects it's own trigger.
Can see your logic, but this may create some 'surprises' for userspace ;)
Hmm. Not sure how we would provide an indication of applicability.
Maybe we need some sort of attribute for triggers to give some indication
of when they will work....  Job for another day but this definitely
turned up expectations upsidedown!

My initial thought would be to drop the trigger support entirely as too
'weird'.  Are you using it to drive other sensors?

> +
> +	return 0;
> +}
> +
> +static const struct iio_trigger_ops zpa2326_trigger_ops = {
> +	.owner           = THIS_MODULE,
> +	.validate_device = zpa2326_validate_device,
No set_trigger_state?  You can, I think, mask the interrupt.
> +};
> +
> +/**
> + * zpa2326_init_trigger() - Create an interrupt driven / hardware trigger
> + *                          allowing to notify external devices a new sample is
> + *                          ready.
> + * @slave:     Hardware sampling device @indio_dev is a child of.
> + * @indio_dev: The IIO device associated with the sampling hardware.
> + * @private:   Internal private state related to @indio_dev.
> + * @irq:       Optional interrupt line the hardware uses to notify new data
> + *             samples are ready. A negative value indicates no interrupt are
> + *             available, meaning polling is required.
> + *
> + * Only relevant when DT declares a valid interrupt line.
> + *
> + * Return: Zero when successful, a negative error code otherwise.
> + */
> +static int zpa2326_init_trigger(struct device          *slave,
> +				struct iio_dev         *indio_dev,
> +				struct zpa2326_private *private,
> +				int                     irq)
> +{
> +	struct iio_trigger *trigger;
> +	int                 ret;
> +
> +	if (irq <= 0)
> +		return 0;
> +
> +	trigger = devm_iio_trigger_alloc(slave, "%s-sample-ready-dev%d",
> +					 indio_dev->name, indio_dev->id);
> +	if (!trigger)
> +		return -ENOMEM;
> +
> +	/* Basic setup. */
> +	trigger->dev.parent = slave;
> +	trigger->ops = &zpa2326_trigger_ops;
> +	iio_trigger_set_drvdata(trigger, indio_dev);
> +
> +	private->trigger = trigger;
> +
> +	/* Register to triggers space. */
> +	ret = devm_iio_trigger_register(slave, trigger);
> +	if (ret)
> +		dev_err(slave, "failed to register hardware trigger (%d)", ret);
> +
> +	return ret;
> +}
> +
> +/*
> + * Debugfs stuff
> + *
> + * Note this is mostly unusable with power management enabled systems since
> + * registers content is lost during power off -> on transitions.
> + */
> +#if defined(CONFIG_DEBUG_FS)
> +#define zpa2326_debugfs_ptr(_ptr) _ptr
> +
> +static int zpa2326_debugfs_read(struct iio_dev *indio_dev,
> +				u8              reg,
> +				unsigned int   *value)
> +{
> +	int ret = zpa2326_claim_direct_mode(indio_dev);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = zpa2326_read_byte(indio_dev, reg);
> +	if (ret < 0)
> +		goto release;
> +
> +	*value = ret;
> +	ret = 0;
> +
> +release:
> +	zpa2326_release_direct_mode(indio_dev);
blank line
> +	return ret;
> +}
> +
> +static int zpa2326_debugfs_write(struct iio_dev *indio_dev,
> +				 u8              reg,
> +				 unsigned int    value)
> +{
> +	int ret = zpa2326_claim_direct_mode(indio_dev);
This one need some explanation?  Why can't we allow debugfs writes during
buffered mode?  Fair enough that we can't but you should say why.
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = zpa2326_write_byte(indio_dev, reg, value);
> +
> +	zpa2326_release_direct_mode(indio_dev);
blank line here.
> +	return ret;
> +}
> +
> +static int zpa2326_debugfs_reg_access(struct iio_dev *indio_dev,
> +				      unsigned int    reg,
> +				      unsigned int    writeval,
> +				      unsigned int   *readval)
> +{
> +	if (readval)
> +		return zpa2326_debugfs_read(indio_dev, reg, readval);
Ever so slight preference from me for an 'else' here to make it obvious
that the two statements are at the same 'level' in some sense.
> +
> +	return zpa2326_debugfs_write(indio_dev, reg, writeval);
> +}
> +#else  /* !CONFIG_DEBUG_FS */
> +#define zpa2326_debugfs_ptr(_ptr) NULL
> +#endif /* !CONFIG_DEBUG_FS */
> +
> +static int zpa2326_get_frequency(struct iio_dev *indio_dev)
> +{
> +	const struct zpa2326_frequency *freq;
> +
> +	mutex_lock(&indio_dev->mlock);
Hmm. This explict taking of the lock is to protect the frequency variable?
Shouldn't be needed I think as a read of that will be atomic.

If it is needed then it should be protected by a local lock. mlock is
strictly for mode change protection.  You will of course have
to take your additional lock when writing as well as mlock via the mode claim
functions.
> +	freq = zpa2326_iio2priv(indio_dev)->frequency;
> +	mutex_unlock(&indio_dev->mlock);
> +
> +	return freq->hz;
> +}
> +
> +static int zpa2326_set_frequency(struct iio_dev *indio_dev, int hz)
> +{
> +	struct zpa2326_private *priv = zpa2326_iio2priv(indio_dev);
> +	int                     freq, err;
> +
> +	/* Check if requested frequency is supported. */
> +	for (freq = 0; freq < ARRAY_SIZE(zpa2326_sampling_frequencies); freq++)
> +		if (zpa2326_sampling_frequencies[freq].hz == hz)
> +			break;
> +	if (freq == ARRAY_SIZE(zpa2326_sampling_frequencies))
> +		return -EINVAL;
> +
> +	/* Don't allow changing frequency if buffered sampling is ongoing. */
> +	err = iio_device_claim_direct_mode(indio_dev);
> +	if (err)
> +		return err;
No harm in doing the claim earlier in the function and makes it more
obvious we aren't going to try under those circumstances. (slightly!)
> +
> +	priv->frequency = &zpa2326_sampling_frequencies[freq];
> +
> +	iio_device_release_direct_mode(indio_dev);
Nitpick : Blank line here.
> +	return 0;
> +}
> +
> +/* Expose supported hardware sampling frequencies (Hz) through sysfs. */
> +static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("1 5 11 23");
> +
> +static struct attribute *zpa2326_attributes[] = {
> +	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group zpa2326_attribute_group = {
> +	.attrs = zpa2326_attributes,
> +};
> +
> +static int zpa2326_read_raw(struct iio_dev             *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int                        *val,
> +			    int                        *val2,
> +			    long                        mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		return zpa2326_sample_oneshot(indio_dev, chan->type, val);
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_PRESSURE:
> +			/*
> +			 * Pressure resolution is 1/64 Pascal. Scale to kPascal
> +			 * as required by IIO ABI.
> +			 */
> +			*val = 1;
> +			*val2 = 64000;
> +			return IIO_VAL_FRACTIONAL;
> +
> +		case IIO_TEMP:
> +			/*
> +			 * Temperature follows the equation:
> +			 *     Temp[degC] = Tempcode * 0.00649 - 176.83
> +			 * where:
> +			 *     Tempcode is composed the raw sampled 16 bits.
> +			 *
> +			 * Hence, to produce a temperature in milli-degrees
> +			 * Celsius according to IIO ABI, we need to apply the
> +			 * following equation to raw samples:
> +			 *     Temp[milli degC] = (Tempcode + Offset) * Scale
> +			 * where:
> +			 *     Offset = -176.83 / 0.00649
> +			 *     Scale = 0.00649 * 1000
> +			 */
> +			*val = 6;
> +			*val2 = 490000;
> +			return IIO_VAL_INT_PLUS_MICRO;
> +
> +		default:
> +			return -EINVAL;
> +		}
> +
> +	case IIO_CHAN_INFO_OFFSET:
> +		switch (chan->type) {
> +		case IIO_TEMP:
> +			*val = -17683000;
> +			*val2 = 649;
> +			return IIO_VAL_FRACTIONAL;
> +
> +		default:
> +			return -EINVAL;
> +		}
> +
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*val = zpa2326_get_frequency(indio_dev);
> +		return IIO_VAL_INT;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int zpa2326_write_raw(struct iio_dev             *indio_dev,
> +			     const struct iio_chan_spec *chan,
> +			     int                         val,
> +			     int                         val2,
> +			     long                        mask)
> +{
> +	if (mask != IIO_CHAN_INFO_SAMP_FREQ)
> +		return -EINVAL;
> +
> +	return zpa2326_set_frequency(indio_dev, val);
To be fussy, should check val2 and probably return -EINVAL if it's set to
anything other than 0.
> +}
> +
> +static const struct iio_chan_spec zpa2326_channels[] = {
> +	[0] = {
> +		.type                    = IIO_PRESSURE,
> +		.scan_index              = 0,
> +		.scan_type               = {
> +			.sign                   = 'u',
> +			.realbits               = 24,
> +			.storagebits            = 32,
> +			.endianness             = IIO_LE,
> +		},
> +		.info_mask_separate      = BIT(IIO_CHAN_INFO_RAW) |
> +					   BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +	},
> +	[1] = {
> +		.type                    = IIO_TEMP,
> +		.scan_index              = 1,
> +		.scan_type               = {
> +			.sign                   = 's',
> +			.realbits               = 16,
> +			.storagebits            = 16,
> +			.endianness             = IIO_LE,
> +		},
> +		.info_mask_separate      = BIT(IIO_CHAN_INFO_RAW) |
> +					   BIT(IIO_CHAN_INFO_SCALE) |
> +					   BIT(IIO_CHAN_INFO_OFFSET),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +	},
> +	[2] = IIO_CHAN_SOFT_TIMESTAMP(2),
> +};
> +
> +static const struct iio_info zpa2326_info = {
> +	.driver_module      = THIS_MODULE,
> +	.attrs              = &zpa2326_attribute_group,
> +	.read_raw           = zpa2326_read_raw,
> +	.write_raw          = zpa2326_write_raw,
> +	.debugfs_reg_access = zpa2326_debugfs_ptr(zpa2326_debugfs_reg_access),
> +	.validate_trigger   = zpa2326_validate_trigger,
> +};
> +
I'd be tempted to call this zpa2326_create_iio_managed or similar
to indicate that it doesn't need to be unwound by hand during remove
(but isn't a devm function really as that prefix would imply).

> +static struct iio_dev *zpa2326_create_iio(struct device *device,
> +					  const char    *name,
> +					  struct regmap *regmap)
> +{
> +	struct iio_dev *indio_dev;
> +
> +	/* Allocate space to hold IIO device internal state. */
> +	indio_dev = devm_iio_device_alloc(device,
> +					  sizeof(struct zpa2326_private));
> +	if (!indio_dev)
> +		return NULL;
> +
> +	/* Setup for userspace synchronous on demand sampling. */
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->dev.parent = device;
> +	indio_dev->channels = zpa2326_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(zpa2326_channels);
> +	indio_dev->name = name;
> +	indio_dev->info = &zpa2326_info;
> +
> +	/* Plug device's underlying bus abstraction. */
> +	zpa2326_iio2priv(indio_dev)->regmap = regmap;
> +
> +	/* Init hardware sampling frequency to highest rate supported. */
> +	zpa2326_iio2priv(indio_dev)->frequency = zpa2326_highest_frequency();
Up until this last step you have clearly been just setting up the
infrastructure of the iio_device.  This last bit feels out of place to
me as it is to do with configuring the device.

> +
> +	return indio_dev;
> +}
> +
> +static int zpa2326_detect_hardware(struct device          *slave,
> +				   struct zpa2326_private *private,
> +				   unsigned int            hwid,
> +				   struct regmap          *regmap)
> +{
> +	int          err;
> +	unsigned int id;
> +
> +	private->vref = devm_regulator_get(slave, "vref");
> +	if (IS_ERR(private->vref))
> +		return PTR_ERR(private->vref);
This has nothing to do with hardware detection (well other than you
can't detect it until it's turned on!)
I wonder if this code would have been more readable as a monolithic
probe function rather than adding artificial boundaries.
> +
> +	private->vdd = devm_regulator_get(slave, "vdd");
> +	if (IS_ERR(private->vdd))
> +		return PTR_ERR(private->vdd);
> +
> +	err = regulator_enable(private->vref);
> +	if (err)
> +		return err;
> +
> +	err = regulator_enable(private->vdd);
> +	if (err)
> +		goto vref;
> +
> +	usleep_range(ZPA2326_TPUP_USEC_MIN, ZPA2326_TPUP_USEC_MAX);
> +
> +	/*
> +	 * Read identification register to check we are talking to the right
> +	 * slave.
> +	 */
> +	err = regmap_read(regmap, ZPA2326_DEVICE_ID_REG, &id);
> +	if (err)
> +		goto vdd;
> +
> +	if (id != hwid) {
> +		dev_err(slave, "found device with unexpected id %02x", id);
> +		err = -ENODEV;
> +		goto vdd;
> +	}
> +
> +	return 0;
> +
> +vdd:
> +	regulator_disable(private->vdd);
> +vref:
> +	regulator_disable(private->vref);
> +	return err;
> +}
> +
> +int zpa2326_probe(struct device        *slave,
> +		  const char           *name,
> +		  int                   irq,
> +		  unsigned int          hwid,
> +		  struct regmap        *regmap)
> +{
> +	struct iio_dev         *indio_dev = zpa2326_create_iio(slave, name,
> +							       regmap);
I'm not keen on this mixture of direct allocation from functions and
bare variable definitions. It makes things less readable to save a line
or two..

Drop the function call down a few lines to effectively have:

struct iio_dev *indio_dev;
...

indio_dev = ...
> +	struct zpa2326_private *priv;
> +	int                     err;
> +
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	priv = zpa2326_iio2priv(indio_dev);
> +
> +	err = zpa2326_detect_hardware(slave, priv, hwid, regmap);
There is stuff in here not related (directly) to hardware detection.
This abstraction into functions is really making this code harder
to review as I can't immediately see that the action of this is
reversed by zpa2326_power_off from the naming...
> +	if (err)
> +		return err;
> +
> +	err = zpa2326_init_ring(slave, indio_dev, irq);
> +	if (err)
> +		goto disable;
> +
> +	err = zpa2326_init_trigger(slave, indio_dev, priv, irq);
This one function is well defined so would make sense to keep it as is
though should make it clear that everything it does is _managed and
hence doesn't need manual unwinding.

I'm also not overwhelmingly keen on the remove order being different than
the probe due to those two regulators needing manual disabling.
hmm. Won't do any harm, but perhaps a comment to make that explicit will
remove the chance of missunderstandings by future readers.

> +	if (err)
> +		goto disable;
> +
> +	err = zpa2326_init_irq(slave, indio_dev, priv, irq);
> +	if (err)
> +		goto disable;
> +
> +	err = zpa2326_config_oneshot(indio_dev, irq);
> +	if (err)
> +		goto disable;
> +
Comment on this just being sleep mode, or make the naming make that clear.
> +	err = zpa2326_disable_device(indio_dev);
> +	if (err)
> +		goto off;
> +
> +	dev_set_drvdata(slave, indio_dev);
> +
> +	zpa2326_init_runtime(slave);
> +
> +	err = iio_device_register(indio_dev);
> +	if (err) {
> +		zpa2326_fini_runtime(slave);
Hmm. The disable_device below is harmless if run twice? so I'd
be tempted to simplify your error path and just let it run on
cases where the device is already in sleep mode.   A quick comment
to say it is harmless will do the job.
> +		goto off;
> +	}
> +
> +	dev_dbg(slave, "%s barometer ready", name);
I know these are only debug statements, but now the
driver is working I'd be tempted to thin them out somewhat as
even in debug mode, these seem a little too chatty!
> +	return 0;
> +
> +disable:
> +	zpa2326_disable_device(indio_dev);
> +off:
> +	zpa2326_power_off(indio_dev, priv);
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(zpa2326_probe);
> +
> +void zpa2326_remove(const struct device *slave)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(slave);
> +
> +	iio_device_unregister(indio_dev);
> +	zpa2326_fini_runtime(zpa2326_iio2slave(indio_dev));
> +	zpa2326_disable_device(indio_dev);
> +	zpa2326_power_off(indio_dev, zpa2326_iio2priv(indio_dev));
> +}
> +EXPORT_SYMBOL_GPL(zpa2326_remove);
> +
> +MODULE_AUTHOR("Gregor Boirie <gregor.boirie@parrot.com>");
> +MODULE_DESCRIPTION("Core driver for Murata ZPA2326 pressure sensor");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/pressure/zpa2326.h b/drivers/iio/pressure/zpa2326.h
> new file mode 100644
> index 0000000..81ca523
> --- /dev/null
> +++ b/drivers/iio/pressure/zpa2326.h
> @@ -0,0 +1,95 @@
> +/*
> + * Murata ZPA2326 pressure and temperature sensor IIO driver
> + *
> + * Copyright (c) 2016 Parrot S.A.
> + *
> + * Author: Gregor Boirie <gregor.boirie@parrot.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published by
> + * the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + */
> +
> +#ifndef _ZPA2326_H
> +#define _ZPA2326_H
> +
> +#include <linux/iio/iio.h>
> +
> +/* Register map. */
> +#define ZPA2326_REF_P_XL_REG            (0x8)
> +#define ZPA2326_REF_P_L_REG             (0x9)
> +#define ZPA2326_REF_P_H_REG             (0xa)
> +#define ZPA2326_DEVICE_ID_REG           (0xf)
> +#define ZPA2326_DEVICE_ID               (0xb9)
> +#define ZPA2326_RES_CONF_REG            (0x10)
> +#define ZPA2326_CTRL_REG0_REG           (0x20)
> +#define ZPA2326_CTRL_REG0_ONE_SHOT      BIT(0)
> +#define ZPA2326_CTRL_REG0_ENABLE        BIT(1)
> +#define ZPA2326_CTRL_REG1_REG           (0x21)
> +#define ZPA2326_CTRL_REG1_MASK_DATA_RDY BIT(2)
> +#define ZPA2326_CTRL_REG2_REG           (0x22)
> +#define ZPA2326_CTRL_REG2_SWRESET       BIT(2)
> +#define ZPA2326_CTRL_REG3_REG           (0x23)
> +#define ZPA2326_CTRL_REG3_ODR_SHIFT     (4)
> +#define ZPA2326_CTRL_REG3_ENABLE_MEAS   BIT(7)
> +#define ZPA2326_INT_SOURCE_REG          (0x24)
> +#define ZPA2326_INT_SOURCE_DATA_RDY     BIT(2)
> +#define ZPA2326_THS_P_LOW_REG           (0x25)
> +#define ZPA2326_THS_P_HIGH_REG          (0x26)
> +#define ZPA2326_STATUS_REG              (0x27)
> +#define ZPA2326_STATUS_P_DA             BIT(1)
> +#define ZPA2326_STATUS_FIFO_E           BIT(2)
> +#define ZPA2326_STATUS_P_OR             BIT(5)
> +#define ZPA2326_PRESS_OUT_XL_REG        (0x28)
> +#define ZPA2326_PRESS_OUT_L_REG         (0x29)
> +#define ZPA2326_PRESS_OUT_H_REG         (0x2a)
> +#define ZPA2326_TEMP_OUT_L_REG          (0x2b)
> +#define ZPA2326_TEMP_OUT_H_REG          (0x2c)
> +
> +bool zpa2326_isreg_writeable(struct device *dev, unsigned int reg);
> +bool zpa2326_isreg_readable(struct device *dev, unsigned int reg);
> +bool zpa2326_isreg_precious(struct device *dev, unsigned int reg);
> +
> +struct regmap;
> +
> +/**
> + * zpa2326_probe() - Instantiate and register core ZPA2326 IIO device
> + * @slave:  Hardware sampling device the IIO device to remove is a child of.
> + * @name:   Arbitrary name to identify the device.
> + * @irq:    Interrupt line, negative if none.
> + * @hwid:   Expected device hardware id.
> + * @regmap: Registers map used to abstract underlying bus accesses.
> + *
> + * Return: Zero when successful, a negative error code otherwise.
> + */
> +int zpa2326_probe(struct device        *slave,
> +		  const char           *name,
> +		  int                   irq,
> +		  unsigned int          hwid,
> +		  struct regmap        *regmap);
> +
> +/**
> + * zpa2326_remove() - Unregister and destroy core ZPA2326 IIO device.
> + * @slave: Hardware sampling device the IIO device to remove is a child of.
> + */
> +void zpa2326_remove(const struct device *slave);
> +
> +static inline struct device *zpa2326_iio2slave(const struct iio_dev *indio_dev)
Not sure I like the naming.
zpa2326_iio_to_parrent perhaps?
> +{
> +	return indio_dev->dev.parent;
> +}
> +
> +#ifdef CONFIG_PM
> +#include <linux/pm.h>
> +extern const struct dev_pm_ops zpa2326_pm_ops;
> +#define ZPA2326_PM_OPS (&zpa2326_pm_ops)
> +#else
> +#define ZPA2326_PM_OPS (NULL)
> +#endif
> +
> +#endif
> diff --git a/drivers/iio/pressure/zpa2326_i2c.c b/drivers/iio/pressure/zpa2326_i2c.c
> new file mode 100644
> index 0000000..dfcd808
> --- /dev/null
> +++ b/drivers/iio/pressure/zpa2326_i2c.c
> @@ -0,0 +1,98 @@
> +/*
> + * Murata ZPA2326 I2C pressure and temperature sensor driver
> + *
> + * Copyright (c) 2016 Parrot S.A.
> + *
> + * Author: Gregor Boirie <gregor.boirie@parrot.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published by
> + * the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/i2c.h>
> +#include <linux/of_device.h>
> +#include "zpa2326.h"
> +
> +/*
> + * read_flag_mask:
> + *   - address bit 7 must be set to request a register read operation
> + */
> +static const struct regmap_config zpa2326_regmap_i2c_config = {
> +	.reg_bits       = 8,
> +	.val_bits       = 8,
> +	.writeable_reg  = zpa2326_isreg_writeable,
> +	.readable_reg   = zpa2326_isreg_readable,
> +	.precious_reg   = zpa2326_isreg_precious,
> +	.max_register   = ZPA2326_TEMP_OUT_H_REG,
> +	.read_flag_mask = BIT(7),
> +	.cache_type     = REGCACHE_NONE,
> +};
> +
> +static unsigned int zpa2326_i2c_hwid(const struct i2c_client *client)
> +{
> +	/* Identification register bit 1 mirrors device address bit 0. */
> +#define ZPA2326_SA0(_addr)          (_addr & BIT(0))
> +#define ZPA2326_DEVICE_ID_SA0_SHIFT (1)
> +
> +	return (ZPA2326_DEVICE_ID |
> +		(ZPA2326_SA0(client->addr) << ZPA2326_DEVICE_ID_SA0_SHIFT));
> +}
> +
> +static int zpa2326_probe_i2c(struct i2c_client          *client,
> +			     const struct i2c_device_id *i2c_id)
> +{
> +	struct regmap *regmap;
> +
> +	regmap = devm_regmap_init_i2c(client, &zpa2326_regmap_i2c_config);
> +	if (IS_ERR(regmap)) {
> +		dev_err(&client->dev, "failed to init registers map");
> +		return PTR_ERR(regmap);
> +	}
> +
> +	return zpa2326_probe(&client->dev, i2c_id->name, client->irq,
> +			     zpa2326_i2c_hwid(client), regmap);
> +}
> +
> +static int zpa2326_remove_i2c(struct i2c_client *client)
> +{
> +	zpa2326_remove(&client->dev);
Nitpick: Blank line here.
> +	return 0;
> +}
> +
> +static const struct i2c_device_id zpa2326_i2c_ids[] = {
> +	{ "zpa2326", 0 },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(i2c, zpa2326_i2c_ids);
> +
> +#if defined(CONFIG_OF)
> +static const struct of_device_id zpa2326_i2c_matches[] = {
> +	{ .compatible = "murata,zpa2326" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, zpa2326_i2c_matches);
> +#endif
> +
> +static struct i2c_driver zpa2326_i2c_driver = {
> +	.driver = {
> +		.name           = "zpa2326-i2c",
> +		.of_match_table = of_match_ptr(zpa2326_i2c_matches),
> +		.pm             = ZPA2326_PM_OPS,
> +	},
> +	.probe    = zpa2326_probe_i2c,
> +	.remove   = zpa2326_remove_i2c,
> +	.id_table = zpa2326_i2c_ids,
> +};
> +module_i2c_driver(zpa2326_i2c_driver);
> +
> +MODULE_AUTHOR("Gregor Boirie <gregor.boirie@parrot.com>");
> +MODULE_DESCRIPTION("I2C driver for Murata ZPA2326 pressure sensor");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/pressure/zpa2326_spi.c b/drivers/iio/pressure/zpa2326_spi.c
> new file mode 100644
> index 0000000..66e826b
> --- /dev/null
> +++ b/drivers/iio/pressure/zpa2326_spi.c
> @@ -0,0 +1,102 @@
> +/*
> + * Murata ZPA2326 SPI pressure and temperature sensor driver
> + *
> + * Copyright (c) 2016 Parrot S.A.
> + *
> + * Author: Gregor Boirie <gregor.boirie@parrot.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published by
> + * the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/spi/spi.h>
> +#include <linux/of_device.h>
> +#include "zpa2326.h"
> +
> +/*
> + * read_flag_mask:
> + *   - address bit 7 must be set to request a register read operation
> + *   - address bit 6 must be set to request register address auto increment
> + */
> +static const struct regmap_config zpa2326_regmap_spi_config = {
> +	.reg_bits       = 8,
> +	.val_bits       = 8,
> +	.writeable_reg  = zpa2326_isreg_writeable,
> +	.readable_reg   = zpa2326_isreg_readable,
> +	.precious_reg   = zpa2326_isreg_precious,
> +	.max_register   = ZPA2326_TEMP_OUT_H_REG,
> +	.read_flag_mask = BIT(7) | BIT(6),
> +	.cache_type     = REGCACHE_NONE,
> +};
> +
> +static int zpa2326_probe_spi(struct spi_device *slave)
> +{
> +	struct regmap *regmap;
> +	int            err;
> +
> +	regmap = devm_regmap_init_spi(slave, &zpa2326_regmap_spi_config);
> +	if (IS_ERR(regmap)) {
> +		dev_err(&slave->dev, "failed to init registers map");
> +		return PTR_ERR(regmap);
> +	}
> +
> +	/*
> +	 * Enforce SPI slave settings to prevent from DT misconfiguration.
> +	 *
> +	 * Clock is idle high. Sampling happens on trailing edge, i.e., rising
> +	 * edge. Maximum bus frequency is 1 mHz. Registers are 8 bits wide.
MHz (presuambly rather than milli Hz)
> +	 */
> +	slave->mode = SPI_MODE_3;
> +	slave->max_speed_hz = min(slave->max_speed_hz, 1000U * 1000U);
Err, why not just 1000000U?  Is there meaning to the sum?
> +	slave->bits_per_word = 8;
> +	err = spi_setup(slave);
> +	if (err < 0)
> +		return err;
> +
> +	return zpa2326_probe(&slave->dev, spi_get_device_id(slave)->name,
> +			     slave->irq, ZPA2326_DEVICE_ID, regmap);
> +}
> +
> +static int zpa2326_remove_spi(struct spi_device *slave)
> +{
> +	zpa2326_remove(&slave->dev);
Nitpick: blank line here preferred.
> +	return 0;
> +}
> +
> +static const struct spi_device_id zpa2326_spi_ids[] = {
> +	{ "zpa2326", 0 },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(spi, zpa2326_spi_ids);
> +
> +#if defined(CONFIG_OF)
> +static const struct of_device_id zpa2326_spi_matches[] = {
> +	{ .compatible = "murata,zpa2326" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, zpa2326_spi_matches);
> +#endif
> +
> +static struct spi_driver zpa2326_spi_driver = {
> +	.driver = {
> +		.name           = "zpa2326-spi",
> +		.of_match_table = of_match_ptr(zpa2326_spi_matches),
> +		.pm             = ZPA2326_PM_OPS,
> +	},
> +	.probe    = zpa2326_probe_spi,
> +	.remove   = zpa2326_remove_spi,
> +	.id_table = zpa2326_spi_ids,
> +};
> +module_spi_driver(zpa2326_spi_driver);
> +
> +MODULE_AUTHOR("Gregor Boirie <gregor.boirie@parrot.com>");
> +MODULE_DESCRIPTION("SPI driver for Murata ZPA2326 pressure sensor");
> +MODULE_LICENSE("GPL v2");
> 

