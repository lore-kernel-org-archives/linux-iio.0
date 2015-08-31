Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38460 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753404AbbHaRAT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 31 Aug 2015 13:00:19 -0400
Subject: Re: [PATCH v5 1/2] iio: adc: hi8435: Holt HI-8435 threshold detector
To: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
References: <1440772029-3022-1-git-send-email-vladimir.barinov@cogentembedded.com>
 <1440772072-3069-1-git-send-email-vladimir.barinov@cogentembedded.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, cory.tusar@pid1solutions.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55E4881D.4010407@kernel.org>
Date: Mon, 31 Aug 2015 18:00:13 +0100
MIME-Version: 1.0
In-Reply-To: <1440772072-3069-1-git-send-email-vladimir.barinov@cogentembedded.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 28/08/15 15:27, Vladimir Barinov wrote:
> Add Holt threshold detector driver for HI-8435 chip
> 
> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Applied to the togreg branch of iio.git - initially pushed out as
testing for the auto builders to try and break it.

Thanks for you persistence with this one!  I'm not entirely sure
where we will ultimately end up with chips like this, but this
is certainly a good start!

Jonathan
> ---
> Changes in version 2:
> - Added file sysfs-bus-iio-adc-hi8435
> - Changed naming from "discrete ADC" to "threshold detector"
> - Replaced swab16p/swab32p with be16_to_cpup/be32_to_cpup
> - Made *_show and *_store functions static
> - moved out from iio buffers to iio events
> - removed hi8436/hi8437 chips from the driver
> - moved from debounce_soft_delay/enable to debounce_interval via
>   IIO_CHAN_INFO_DEBOUNCE_TIME
> - added name extention "comparator"
> - moved threshold/hysteresis setup via generic iio event sysfs
> - added software mask/unmask channel events
> - added programming sensor outputs while in test mode via
>   IIO_CHAN_INFO_RAW
> - added channels .ext_info for programming sensing mode
> Changes in version 3:
> - fixed typos
> - moved <linux/interrupt.h> to match alphabetic order
> - fixed missed */event/* prefix in the ABI description
> - added missed colon in sysfs-bus-iio-adc-hi8435 file after "What"
> - moved in_voltageY_comparator_thresh_either_en and debounce_time
>   to sysfs-bus-iio file
> - added error checking for hi8435_write[b|w]
> Changes in version 4:
> - removed software debounce logic
> - fixed typo in comment s/threshold/thresholds
> - removed test_enable sysfs entry
> - removed *_raw entries
> - removed extended_name
> - switched to GPIO descriptor API
> - added comment describing the need of thresholds initialization
> - added debugfs_reg_access
> Changes in version 5:
> - added ABI description about falling/rising thresholds automatic
>  adjustment that avoids odd hysteresis
> - changed reg_buffer[] size to 3 instead of 4
> - modified if/else logic in hi8435_read_event_value function
> - modified if/else logic in hi8435_write_event_value function
> - modified if/else logic in hi8435_iio_push_event function
> 
>  Documentation/ABI/testing/sysfs-bus-iio            |   1 +
>  Documentation/ABI/testing/sysfs-bus-iio-adc-hi8435 |  43 ++
>  drivers/iio/adc/Kconfig                            |  11 +
>  drivers/iio/adc/Makefile                           |   1 +
>  drivers/iio/adc/hi8435.c                           | 531 +++++++++++++++++++++
>  5 files changed, 587 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-hi8435
>  create mode 100644 drivers/iio/adc/hi8435.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 42d360f..20312a0 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -581,6 +581,7 @@ What:		/sys/.../iio:deviceX/events/in_voltageY_supply_thresh_rising_en
>  What:		/sys/.../iio:deviceX/events/in_voltageY_supply_thresh_falling_en
>  What:		/sys/.../iio:deviceX/events/in_voltageY_thresh_rising_en
>  What:		/sys/.../iio:deviceX/events/in_voltageY_thresh_falling_en
> +What:		/sys/.../iio:deviceX/events/in_voltageY_thresh_either_en
>  What:		/sys/.../iio:deviceX/events/in_tempY_thresh_rising_en
>  What:		/sys/.../iio:deviceX/events/in_tempY_thresh_falling_en
>  KernelVersion:	2.6.37
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-hi8435 b/Documentation/ABI/testing/sysfs-bus-iio-adc-hi8435
> new file mode 100644
> index 0000000..f30b4c4
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-hi8435
> @@ -0,0 +1,43 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_sensing_mode
> +Date:		August 2015
> +KernelVersion:	4.2.0
> +Contact:	source@cogentembedded.com
> +Description:
> +		Program sensor type for threshold detector inputs.
> +		Could be either "GND-Open" or "Supply-Open" mode. Y is a
> +		threshold detector input channel. Channels 0..7, 8..15, 16..23
> +		and 24..31 has common sensor types.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/events/in_voltageY_thresh_falling_value
> +Date:		August 2015
> +KernelVersion:	4.2.0
> +Contact:	source@cogentembedded.com
> +Description:
> +		Channel Y low voltage threshold. If sensor input voltage goes lower then
> +		this value then the threshold falling event is pushed.
> +		Depending on in_voltageY_sensing_mode the low voltage threshold
> +		is separately set for "GND-Open" and "Supply-Open" modes.
> +		Channels 0..31 have common low threshold values, but could have different
> +		sensing_modes.
> +		The low voltage threshold range is between 2..21V.
> +		Hysteresis between low and high thresholds can not be lower then 2 and
> +		can not be odd.
> +		If falling threshold results hysteresis to odd value then rising
> +		threshold is automatically subtracted by one.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/events/in_voltageY_thresh_rising_value
> +Date:		August 2015
> +KernelVersion:	4.2.0
> +Contact:	source@cogentembedded.com
> +Description:
> +		Channel Y high voltage threshold. If sensor input voltage goes higher then
> +		this value then the threshold rising event is pushed.
> +		Depending on in_voltageY_sensing_mode the high voltage threshold
> +		is separately set for "GND-Open" and "Supply-Open" modes.
> +		Channels 0..31 have common high threshold values, but could have different
> +		sensing_modes.
> +		The high voltage threshold range is between 3..22V.
> +		Hysteresis between low and high thresholds can not be lower then 2 and
> +		can not be odd.
> +		If rising threshold results hysteresis to odd value then falling
> +		threshold is automatically appended by one.
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index deea62c..4918edc 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -183,6 +183,17 @@ config EXYNOS_ADC
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called exynos_adc.
>  
> +config HI8435
> +	tristate "Holt Integrated Circuits HI-8435 threshold detector"
> +	select IIO_TRIGGERED_EVENT
> +	depends on SPI
> +	help
> +	  If you say yes here you get support for Holt Integrated Circuits
> +	  HI-8435 chip.
> +
> +	  This driver can also be built as a module. If so, the module will be
> +	  called hi8435.
> +
>  config LP8788_ADC
>  	tristate "LP8788 ADC driver"
>  	depends on MFD_LP8788
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index fa5723a..99b37a9 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -19,6 +19,7 @@ obj-$(CONFIG_BERLIN2_ADC) += berlin2-adc.o
>  obj-$(CONFIG_CC10001_ADC) += cc10001_adc.o
>  obj-$(CONFIG_DA9150_GPADC) += da9150-gpadc.o
>  obj-$(CONFIG_EXYNOS_ADC) += exynos_adc.o
> +obj-$(CONFIG_HI8435) += hi8435.o
>  obj-$(CONFIG_LP8788_ADC) += lp8788_adc.o
>  obj-$(CONFIG_MAX1027) += max1027.o
>  obj-$(CONFIG_MAX1363) += max1363.o
> diff --git a/drivers/iio/adc/hi8435.c b/drivers/iio/adc/hi8435.c
> new file mode 100644
> index 0000000..f4f8ea6
> --- /dev/null
> +++ b/drivers/iio/adc/hi8435.c
> @@ -0,0 +1,531 @@
> +/*
> + * Holt Integrated Circuits HI-8435 threshold detector driver
> + *
> + * Copyright (C) 2015 Zodiac Inflight Innovations
> + * Copyright (C) 2015 Cogent Embedded, Inc.
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/iio/events.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_event.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/of_gpio.h>
> +#include <linux/spi/spi.h>
> +
> +#define DRV_NAME "hi8435"
> +
> +/* Register offsets for HI-8435 */
> +#define HI8435_CTRL_REG		0x02
> +#define HI8435_PSEN_REG		0x04
> +#define HI8435_TMDATA_REG	0x1E
> +#define HI8435_GOCENHYS_REG	0x3A
> +#define HI8435_SOCENHYS_REG	0x3C
> +#define HI8435_SO7_0_REG	0x10
> +#define HI8435_SO15_8_REG	0x12
> +#define HI8435_SO23_16_REG	0x14
> +#define HI8435_SO31_24_REG	0x16
> +#define HI8435_SO31_0_REG	0x78
> +
> +#define HI8435_WRITE_OPCODE	0x00
> +#define HI8435_READ_OPCODE	0x80
> +
> +/* CTRL register bits */
> +#define HI8435_CTRL_TEST	0x01
> +#define HI8435_CTRL_SRST	0x02
> +
> +struct hi8435_priv {
> +	struct spi_device *spi;
> +	struct mutex lock;
> +
> +	unsigned long event_scan_mask; /* soft mask/unmask channels events */
> +	unsigned int event_prev_val;
> +
> +	unsigned threshold_lo[2]; /* GND-Open and Supply-Open thresholds */
> +	unsigned threshold_hi[2]; /* GND-Open and Supply-Open thresholds */
> +	u8 reg_buffer[3] ____cacheline_aligned;
> +};
> +
> +static int hi8435_readb(struct hi8435_priv *priv, u8 reg, u8 *val)
> +{
> +	reg |= HI8435_READ_OPCODE;
> +	return spi_write_then_read(priv->spi, &reg, 1, val, 1);
> +}
> +
> +static int hi8435_readw(struct hi8435_priv *priv, u8 reg, u16 *val)
> +{
> +	int ret;
> +
> +	reg |= HI8435_READ_OPCODE;
> +	ret = spi_write_then_read(priv->spi, &reg, 1, val, 2);
> +	*val = be16_to_cpup(val);
> +
> +	return ret;
> +}
> +
> +static int hi8435_readl(struct hi8435_priv *priv, u8 reg, u32 *val)
> +{
> +	int ret;
> +
> +	reg |= HI8435_READ_OPCODE;
> +	ret = spi_write_then_read(priv->spi, &reg, 1, val, 4);
> +	*val = be32_to_cpup(val);
> +
> +	return ret;
> +}
> +
> +static int hi8435_writeb(struct hi8435_priv *priv, u8 reg, u8 val)
> +{
> +	priv->reg_buffer[0] = reg | HI8435_WRITE_OPCODE;
> +	priv->reg_buffer[1] = val;
> +
> +	return spi_write(priv->spi, priv->reg_buffer, 2);
> +}
> +
> +static int hi8435_writew(struct hi8435_priv *priv, u8 reg, u16 val)
> +{
> +	priv->reg_buffer[0] = reg | HI8435_WRITE_OPCODE;
> +	priv->reg_buffer[1] = (val >> 8) & 0xff;
> +	priv->reg_buffer[2] = val & 0xff;
> +
> +	return spi_write(priv->spi, priv->reg_buffer, 3);
> +}
> +
> +static int hi8435_read_event_config(struct iio_dev *idev,
> +				    const struct iio_chan_spec *chan,
> +				    enum iio_event_type type,
> +				    enum iio_event_direction dir)
> +{
> +	struct hi8435_priv *priv = iio_priv(idev);
> +
> +	return !!(priv->event_scan_mask & BIT(chan->channel));
> +}
> +
> +static int hi8435_write_event_config(struct iio_dev *idev,
> +				     const struct iio_chan_spec *chan,
> +				     enum iio_event_type type,
> +				     enum iio_event_direction dir, int state)
> +{
> +	struct hi8435_priv *priv = iio_priv(idev);
> +
> +	priv->event_scan_mask &= ~BIT(chan->channel);
> +	if (state)
> +		priv->event_scan_mask |= BIT(chan->channel);
> +
> +	return 0;
> +}
> +
> +static int hi8435_read_event_value(struct iio_dev *idev,
> +				   const struct iio_chan_spec *chan,
> +				   enum iio_event_type type,
> +				   enum iio_event_direction dir,
> +				   enum iio_event_info info,
> +				   int *val, int *val2)
> +{
> +	struct hi8435_priv *priv = iio_priv(idev);
> +	int ret;
> +	u8 mode, psen;
> +	u16 reg;
> +
> +	ret = hi8435_readb(priv, HI8435_PSEN_REG, &psen);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Supply-Open or GND-Open sensing mode */
> +	mode = !!(psen & BIT(chan->channel / 8));
> +
> +	ret = hi8435_readw(priv, mode ? HI8435_SOCENHYS_REG :
> +				 HI8435_GOCENHYS_REG, &reg);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (dir == IIO_EV_DIR_FALLING)
> +		*val = ((reg & 0xff) - (reg >> 8)) / 2;
> +	else if (dir == IIO_EV_DIR_RISING)
> +		*val = ((reg & 0xff) + (reg >> 8)) / 2;
> +
> +	return IIO_VAL_INT;
> +}
> +
> +static int hi8435_write_event_value(struct iio_dev *idev,
> +				    const struct iio_chan_spec *chan,
> +				    enum iio_event_type type,
> +				    enum iio_event_direction dir,
> +				    enum iio_event_info info,
> +				    int val, int val2)
> +{
> +	struct hi8435_priv *priv = iio_priv(idev);
> +	int ret;
> +	u8 mode, psen;
> +	u16 reg;
> +
> +	ret = hi8435_readb(priv, HI8435_PSEN_REG, &psen);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Supply-Open or GND-Open sensing mode */
> +	mode = !!(psen & BIT(chan->channel / 8));
> +
> +	ret = hi8435_readw(priv, mode ? HI8435_SOCENHYS_REG :
> +				 HI8435_GOCENHYS_REG, &reg);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (dir == IIO_EV_DIR_FALLING) {
> +		/* falling threshold range 2..21V, hysteresis minimum 2V */
> +		if (val < 2 || val > 21 || (val + 2) > priv->threshold_hi[mode])
> +			return -EINVAL;
> +
> +		if (val == priv->threshold_lo[mode])
> +			return 0;
> +
> +		priv->threshold_lo[mode] = val;
> +
> +		/* hysteresis must not be odd */
> +		if ((priv->threshold_hi[mode] - priv->threshold_lo[mode]) % 2)
> +			priv->threshold_hi[mode]--;
> +	} else if (dir == IIO_EV_DIR_RISING) {
> +		/* rising threshold range 3..22V, hysteresis minimum 2V */
> +		if (val < 3 || val > 22 || val < (priv->threshold_lo[mode] + 2))
> +			return -EINVAL;
> +
> +		if (val == priv->threshold_hi[mode])
> +			return 0;
> +
> +		priv->threshold_hi[mode] = val;
> +
> +		/* hysteresis must not be odd */
> +		if ((priv->threshold_hi[mode] - priv->threshold_lo[mode]) % 2)
> +			priv->threshold_lo[mode]++;
> +	}
> +
> +	/* program thresholds */
> +	mutex_lock(&priv->lock);
> +
> +	ret = hi8435_readw(priv, mode ? HI8435_SOCENHYS_REG :
> +				 HI8435_GOCENHYS_REG, &reg);
> +	if (ret < 0) {
> +		mutex_unlock(&priv->lock);
> +		return ret;
> +	}
> +
> +	/* hysteresis */
> +	reg = priv->threshold_hi[mode] - priv->threshold_lo[mode];
> +	reg <<= 8;
> +	/* threshold center */
> +	reg |= (priv->threshold_hi[mode] + priv->threshold_lo[mode]);
> +
> +	ret = hi8435_writew(priv, mode ? HI8435_SOCENHYS_REG :
> +				  HI8435_GOCENHYS_REG, reg);
> +
> +	mutex_unlock(&priv->lock);
> +
> +	return ret;
> +}
> +
> +static int hi8435_debugfs_reg_access(struct iio_dev *idev,
> +				     unsigned reg, unsigned writeval,
> +				     unsigned *readval)
> +{
> +	struct hi8435_priv *priv = iio_priv(idev);
> +	int ret;
> +	u8 val;
> +
> +	if (readval != NULL) {
> +		ret = hi8435_readb(priv, reg, &val);
> +		*readval = val;
> +	} else {
> +		val = (u8)writeval;
> +		ret = hi8435_writeb(priv, reg, val);
> +	}
> +
> +	return ret;
> +}
> +
> +static const struct iio_event_spec hi8435_events[] = {
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_RISING,
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE),
> +	}, {
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_FALLING,
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE),
> +	}, {
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_EITHER,
> +		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
> +	},
> +};
> +
> +static int hi8435_get_sensing_mode(struct iio_dev *idev,
> +				   const struct iio_chan_spec *chan)
> +{
> +	struct hi8435_priv *priv = iio_priv(idev);
> +	int ret;
> +	u8 reg;
> +
> +	ret = hi8435_readb(priv, HI8435_PSEN_REG, &reg);
> +	if (ret < 0)
> +		return ret;
> +
> +	return !!(reg & BIT(chan->channel / 8));
> +}
> +
> +static int hi8435_set_sensing_mode(struct iio_dev *idev,
> +				   const struct iio_chan_spec *chan,
> +				   unsigned int mode)
> +{
> +	struct hi8435_priv *priv = iio_priv(idev);
> +	int ret;
> +	u8 reg;
> +
> +	mutex_lock(&priv->lock);
> +
> +	ret = hi8435_readb(priv, HI8435_PSEN_REG, &reg);
> +	if (ret < 0) {
> +		mutex_unlock(&priv->lock);
> +		return ret;
> +	}
> +
> +	reg &= ~BIT(chan->channel / 8);
> +	if (mode)
> +		reg |= BIT(chan->channel / 8);
> +
> +	ret = hi8435_writeb(priv, HI8435_PSEN_REG, reg);
> +
> +	mutex_unlock(&priv->lock);
> +
> +	return ret;
> +}
> +
> +static const char * const hi8435_sensing_modes[] = { "GND-Open",
> +						     "Supply-Open" };
> +
> +static const struct iio_enum hi8435_sensing_mode = {
> +	.items = hi8435_sensing_modes,
> +	.num_items = ARRAY_SIZE(hi8435_sensing_modes),
> +	.get = hi8435_get_sensing_mode,
> +	.set = hi8435_set_sensing_mode,
> +};
> +
> +static const struct iio_chan_spec_ext_info hi8435_ext_info[] = {
> +	IIO_ENUM("sensing_mode", IIO_SEPARATE, &hi8435_sensing_mode),
> +	{},
> +};
> +
> +#define HI8435_VOLTAGE_CHANNEL(num)			\
> +{							\
> +	.type = IIO_VOLTAGE,				\
> +	.indexed = 1,					\
> +	.channel = num,					\
> +	.event_spec = hi8435_events,			\
> +	.num_event_specs = ARRAY_SIZE(hi8435_events),	\
> +	.ext_info = hi8435_ext_info,			\
> +}
> +
> +static const struct iio_chan_spec hi8435_channels[] = {
> +	HI8435_VOLTAGE_CHANNEL(0),
> +	HI8435_VOLTAGE_CHANNEL(1),
> +	HI8435_VOLTAGE_CHANNEL(2),
> +	HI8435_VOLTAGE_CHANNEL(3),
> +	HI8435_VOLTAGE_CHANNEL(4),
> +	HI8435_VOLTAGE_CHANNEL(5),
> +	HI8435_VOLTAGE_CHANNEL(6),
> +	HI8435_VOLTAGE_CHANNEL(7),
> +	HI8435_VOLTAGE_CHANNEL(8),
> +	HI8435_VOLTAGE_CHANNEL(9),
> +	HI8435_VOLTAGE_CHANNEL(10),
> +	HI8435_VOLTAGE_CHANNEL(11),
> +	HI8435_VOLTAGE_CHANNEL(12),
> +	HI8435_VOLTAGE_CHANNEL(13),
> +	HI8435_VOLTAGE_CHANNEL(14),
> +	HI8435_VOLTAGE_CHANNEL(15),
> +	HI8435_VOLTAGE_CHANNEL(16),
> +	HI8435_VOLTAGE_CHANNEL(17),
> +	HI8435_VOLTAGE_CHANNEL(18),
> +	HI8435_VOLTAGE_CHANNEL(19),
> +	HI8435_VOLTAGE_CHANNEL(20),
> +	HI8435_VOLTAGE_CHANNEL(21),
> +	HI8435_VOLTAGE_CHANNEL(22),
> +	HI8435_VOLTAGE_CHANNEL(23),
> +	HI8435_VOLTAGE_CHANNEL(24),
> +	HI8435_VOLTAGE_CHANNEL(25),
> +	HI8435_VOLTAGE_CHANNEL(26),
> +	HI8435_VOLTAGE_CHANNEL(27),
> +	HI8435_VOLTAGE_CHANNEL(28),
> +	HI8435_VOLTAGE_CHANNEL(29),
> +	HI8435_VOLTAGE_CHANNEL(30),
> +	HI8435_VOLTAGE_CHANNEL(31),
> +	IIO_CHAN_SOFT_TIMESTAMP(32),
> +};
> +
> +static const struct iio_info hi8435_info = {
> +	.driver_module = THIS_MODULE,
> +	.read_event_config = &hi8435_read_event_config,
> +	.write_event_config = hi8435_write_event_config,
> +	.read_event_value = &hi8435_read_event_value,
> +	.write_event_value = &hi8435_write_event_value,
> +	.debugfs_reg_access = &hi8435_debugfs_reg_access,
> +};
> +
> +static void hi8435_iio_push_event(struct iio_dev *idev, unsigned int val)
> +{
> +	struct hi8435_priv *priv = iio_priv(idev);
> +	enum iio_event_direction dir;
> +	unsigned int i;
> +	unsigned int status = priv->event_prev_val ^ val;
> +
> +	if (!status)
> +		return;
> +
> +	for_each_set_bit(i, &priv->event_scan_mask, 32) {
> +		if (status & BIT(i)) {
> +			dir = val & BIT(i) ? IIO_EV_DIR_RISING :
> +					     IIO_EV_DIR_FALLING;
> +			iio_push_event(idev,
> +				       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, i,
> +						    IIO_EV_TYPE_THRESH, dir),
> +				       iio_get_time_ns());
> +		}
> +	}
> +
> +	priv->event_prev_val = val;
> +}
> +
> +static irqreturn_t hi8435_trigger_handler(int irq, void *private)
> +{
> +	struct iio_poll_func *pf = private;
> +	struct iio_dev *idev = pf->indio_dev;
> +	struct hi8435_priv *priv = iio_priv(idev);
> +	u32 val;
> +	int ret;
> +
> +	ret = hi8435_readl(priv, HI8435_SO31_0_REG, &val);
> +	if (ret < 0)
> +		goto err_read;
> +
> +	hi8435_iio_push_event(idev, val);
> +
> +err_read:
> +	iio_trigger_notify_done(idev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int hi8435_probe(struct spi_device *spi)
> +{
> +	struct iio_dev *idev;
> +	struct hi8435_priv *priv;
> +	struct gpio_desc *reset_gpio;
> +	int ret;
> +
> +	idev = devm_iio_device_alloc(&spi->dev, sizeof(*priv));
> +	if (!idev)
> +		return -ENOMEM;
> +
> +	priv = iio_priv(idev);
> +	priv->spi = spi;
> +
> +	reset_gpio = devm_gpiod_get(&spi->dev, NULL, GPIOD_OUT_LOW);
> +	if (IS_ERR(reset_gpio)) {
> +		/* chip s/w reset if h/w reset failed */
> +		hi8435_writeb(priv, HI8435_CTRL_REG, HI8435_CTRL_SRST);
> +		hi8435_writeb(priv, HI8435_CTRL_REG, 0);
> +	} else {
> +		udelay(5);
> +		gpiod_set_value(reset_gpio, 1);
> +	}
> +
> +	spi_set_drvdata(spi, idev);
> +	mutex_init(&priv->lock);
> +
> +	idev->dev.parent	= &spi->dev;
> +	idev->name		= spi_get_device_id(spi)->name;
> +	idev->modes		= INDIO_DIRECT_MODE;
> +	idev->info		= &hi8435_info;
> +	idev->channels		= hi8435_channels;
> +	idev->num_channels	= ARRAY_SIZE(hi8435_channels);
> +
> +	/* unmask all events */
> +	priv->event_scan_mask = ~(0);
> +	/*
> +	 * There is a restriction in the chip - the hysteresis can not be odd.
> +	 * If the hysteresis is set to odd value then chip gets into lock state
> +	 * and not functional anymore.
> +	 * After chip reset the thresholds are in undefined state, so we need to
> +	 * initialize thresholds to some initial values and then prevent
> +	 * userspace setting odd hysteresis.
> +	 *
> +	 * Set threshold low voltage to 2V, threshold high voltage to 4V
> +	 * for both GND-Open and Supply-Open sensing modes.
> +	 */
> +	priv->threshold_lo[0] = priv->threshold_lo[1] = 2;
> +	priv->threshold_hi[0] = priv->threshold_hi[1] = 4;
> +	hi8435_writew(priv, HI8435_GOCENHYS_REG, 0x206);
> +	hi8435_writew(priv, HI8435_SOCENHYS_REG, 0x206);
> +
> +	ret = iio_triggered_event_setup(idev, NULL, hi8435_trigger_handler);
> +	if (ret)
> +		return ret;
> +
> +	ret = iio_device_register(idev);
> +	if (ret < 0) {
> +		dev_err(&spi->dev, "unable to register device\n");
> +		goto unregister_triggered_event;
> +	}
> +
> +	return 0;
> +
> +unregister_triggered_event:
> +	iio_triggered_event_cleanup(idev);
> +	return ret;
> +}
> +
> +static int hi8435_remove(struct spi_device *spi)
> +{
> +	struct iio_dev *idev = spi_get_drvdata(spi);
> +
> +	iio_device_unregister(idev);
> +	iio_triggered_event_cleanup(idev);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id hi8435_dt_ids[] = {
> +	{ .compatible = "holt,hi8435" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, hi8435_dt_ids);
> +
> +static const struct spi_device_id hi8435_id[] = {
> +	{ "hi8435", 0},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, hi8435_id);
> +
> +static struct spi_driver hi8435_driver = {
> +	.driver	= {
> +		.name		= DRV_NAME,
> +		.of_match_table	= of_match_ptr(hi8435_dt_ids),
> +	},
> +	.probe		= hi8435_probe,
> +	.remove		= hi8435_remove,
> +	.id_table	= hi8435_id,
> +};
> +module_spi_driver(hi8435_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Vladimir Barinov");
> +MODULE_DESCRIPTION("HI-8435 threshold detector");
> 

