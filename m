Return-Path: <maxime.ripard@free-electrons.com>
Date: Fri, 29 Jul 2016 09:12:30 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: jdelvare@suse.com, linux@roeck-us.net, jic23@kernel.org,
	knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, wens@csie.org,
	lee.jones@linaro.org, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	thomas.petazzoni@free-electrons.com,
	antoine.tenart@free-electrons.com
Subject: Re: [PATCH v3 4/4] iio: adc: add support for Allwinner SoCs ADC
Message-ID: <20160729071230.GB6215@lukather>
References: <1469519027-11387-1-git-send-email-quentin.schulz@free-electrons.com>
 <1469519027-11387-5-git-send-email-quentin.schulz@free-electrons.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XF85m9dhOBO43t/C"
In-Reply-To: <1469519027-11387-5-git-send-email-quentin.schulz@free-electrons.com>
List-ID: <linux-iio@vger.kernel.org>


--XF85m9dhOBO43t/C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 26, 2016 at 09:43:47AM +0200, Quentin Schulz wrote:
> The Allwinner SoCs all have an ADC that can also act as a touchscreen
> controller and a thermal sensor. This patch adds the ADC driver which is
> based on the MFD for the same SoCs ADC.
>=20
> This also registers the thermal adc channel in the iio map array so
> iio_hwmon could use it without modifying the Device Tree. This registers
> the driver in the thermal framework.
>=20
> This driver probes on three different platform_device_id to take into
> account slight differences (registers bit and temperature computation)
> between Allwinner SoCs ADCs.
>=20
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
>=20
> I don't like how I get the temperature for the thermal framework
> (sunxi_gpadc_get_temp). I am doing the exact same process as the iio_hwmon
> but in this function. This is duplicated code. I could use
> iio_read_channel_processed but it needs to have the iio_channel structure
> of the thermal sensor which I can only get with iio_channel_get which
> matches the device name with the consumer_dev_name in the iio_map array.
> And frankly, I do not see myself declaring the driver both as the producer
> and the consumer of IIO channels.
>=20
> Moreover, since the thermal sensor is configured to throw an interrupt
> every X seconds, only the first request within these X seconds will not
> time out. This means that because the thermal framework regularly poll the
> thermal sensor, it is really difficult to get a value from sysfs without
> getting first a tonne of times out. I don't know if we can do something
> about that?
>=20
> v3:
>  - correct wrapping,
>  - add comment about thermal sensor inner working,
>  - move defines in mfd header,
>  - use structure to define SoC specific registers or behaviour,
>  - attach this structure to the device according to of_device_id of the
>    platform device,
>  - use new mutex instead of iio_dev mutex,
>  - use atomic flags to avoid race between request_irq and disable_irq in
>    probe,
>  - switch from processed value to raw, offset and scale values for
>    temperature ADC channel,
>  - remove faulty sentinel in iio_chan_spec array,
>  - add pm_runtime support,
>  - register thermal sensor in thermal framework (forgotten since the
>    beginning whereas it is present in current sun4i-ts driver),
>  - remove useless ret variables to store return value of regmap_reads,
>  - move comments on thermal sensor acquisition period in code instead of
>    header,
>  - adding goto label to unregister iio_map_array when failing to register
>    iio_dev,
>=20
> v2:
>  - add SUNXI_GPADC_ prefixes for defines,
>  - correct typo in Kconfig,
>  - reorder alphabetically includes, makefile,
>  - add license header,
>  - fix architecture variations not being handled in interrupt handlers or
>    read raw functions,
>  - fix unability to return negative values from thermal sensor,
>  - add gotos to reduce code repetition,
>  - fix irq variable being unsigned int instead of int,
>  - remove useless dev_err and dev_info,
>  - deactivate all interrupts if probe fails,
>  - fix iio_device_register on NULL variable,
>  - deactivate ADC in the IP when probe fails or when removing driver,
>=20
>  drivers/iio/adc/Kconfig           |  12 +
>  drivers/iio/adc/Makefile          |   1 +
>  drivers/iio/adc/sunxi-gpadc-iio.c | 513 ++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 526 insertions(+)
>  create mode 100644 drivers/iio/adc/sunxi-gpadc-iio.c
>=20
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 25378c5..429ef16 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -384,6 +384,18 @@ config ROCKCHIP_SARADC
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called rockchip_saradc.
> =20
> +config SUN4I_GPADC
> +	tristate "Support for the Allwinner SoCs GPADC"
> +	depends on IIO
> +	depends on MFD_SUN4I_GPADC
> +	help
> +	  Say yes here to build support for Allwinner (A10, A13 and A31) SoCs
> +	  GPADC. This ADC provides 4 channels which can be used as an ADC or as
> +	  a touchscreen input and one channel for thermal sensor.
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called sunxi-gpadc-iio.
> +
>  config TI_ADC081C
>  	tristate "Texas Instruments ADC081C/ADC101C/ADC121C family"
>  	depends on I2C
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 38638d4..14d1739 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -37,6 +37,7 @@ obj-$(CONFIG_PALMAS_GPADC) +=3D palmas_gpadc.o
>  obj-$(CONFIG_QCOM_SPMI_IADC) +=3D qcom-spmi-iadc.o
>  obj-$(CONFIG_QCOM_SPMI_VADC) +=3D qcom-spmi-vadc.o
>  obj-$(CONFIG_ROCKCHIP_SARADC) +=3D rockchip_saradc.o
> +obj-$(CONFIG_SUN4I_GPADC) +=3D sunxi-gpadc-iio.o
>  obj-$(CONFIG_TI_ADC081C) +=3D ti-adc081c.o
>  obj-$(CONFIG_TI_ADC0832) +=3D ti-adc0832.o
>  obj-$(CONFIG_TI_ADC128S052) +=3D ti-adc128s052.o
> diff --git a/drivers/iio/adc/sunxi-gpadc-iio.c b/drivers/iio/adc/sunxi-gp=
adc-iio.c
> new file mode 100644
> index 0000000..5647688
> --- /dev/null
> +++ b/drivers/iio/adc/sunxi-gpadc-iio.c
> @@ -0,0 +1,513 @@
> +/* ADC driver for sunxi platforms' (A10, A13 and A31) GPADC
> + *
> + * Copyright (c) 2016 Quentin Schulz <quentin.schulz@free-electrons>
> + *
> + * This program is free software; you can redistribute it and/or modify =
it under
> + * the terms of the GNU General Public License version 2 as published by=
 the
> + * Free Software Foundation.
> + *
> + * The Allwinner SoCs all have an ADC that can also act as a touchscreen
> + * controller and a thermal sensor.
> + * The thermal sensor works only when the ADC acts as a touchscreen cont=
roller
> + * and is configured to throw an interrupt every fixed periods of time (=
let say
> + * every X seconds).
> + * One would be tempted to disable the IP on the hardware side rather th=
an
> + * disabling interrupts to save some power but that reset the internal c=
lock of
> + * the IP, resulting in having to wait X seconds every time we want to r=
ead the
> + * value of the thermal sensor.
> + * This is also the reason of using autosuspend in pm_runtime. If there =
were no
> + * autosuspend, the thermal sensor would need X seconds after every
> + * pm_runtime_get_sync to get a value from the ADC. The autosuspend allo=
ws the
> + * thermal sensor to be requested again in a certain time span before it=
 gets
> + * shutdown for not being used.
> + */
> +
> +#include <linux/completion.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +#include <linux/thermal.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/driver.h>
> +#include <linux/iio/machine.h>
> +#include <linux/mfd/sunxi-gpadc-mfd.h>
> +
> +const unsigned int sun4i_gpadc_chan_select(unsigned int chan)
> +{
> +	return SUNXI_GPADC_TP_CTRL1_ADC_CHAN_SELECT(chan);
> +}
> +
> +const unsigned int sun6i_gpadc_chan_select(unsigned int chan)
> +{
> +	return SUNXI_GPADC_TP_CTRL1_SUN6I_ADC_CHAN_SELECT(chan);
> +}
> +
> +struct sunxi_gpadc_soc_specific {
> +	const int		temp_offset;
> +	const int		temp_scale;
> +	const unsigned int	tp_mode_en;
> +	const unsigned int	tp_adc_select;
> +	const unsigned int	(*adc_chan_select)(unsigned int chan);
> +};
> +
> +static const struct sunxi_gpadc_soc_specific sun4i_gpadc_soc_specific =
=3D {
> +	.temp_offset =3D -1932,
> +	.temp_scale =3D 133,
> +	.tp_mode_en =3D SUNXI_GPADC_TP_CTRL1_TP_MODE_EN,
> +	.tp_adc_select =3D SUNXI_GPADC_TP_CTRL1_TP_ADC_SELECT,
> +	.adc_chan_select =3D &sun4i_gpadc_chan_select,
> +};
> +
> +static const struct sunxi_gpadc_soc_specific sun5i_gpadc_soc_specific =
=3D {
> +	.temp_offset =3D -1447,
> +	.temp_scale =3D 100,
> +	.tp_mode_en =3D SUNXI_GPADC_TP_CTRL1_TP_MODE_EN,
> +	.tp_adc_select =3D SUNXI_GPADC_TP_CTRL1_TP_ADC_SELECT,
> +	.adc_chan_select =3D &sun4i_gpadc_chan_select,
> +};
> +
> +static const struct sunxi_gpadc_soc_specific sun6i_gpadc_soc_specific =
=3D {
> +	.temp_offset =3D -1623,
> +	.temp_scale =3D 167,
> +	.tp_mode_en =3D SUNXI_GPADC_TP_CTRL1_SUN6I_TP_MODE_EN,
> +	.tp_adc_select =3D SUNXI_GPADC_TP_CTRL1_SUN6I_TP_ADC_SELECT,
> +	.adc_chan_select =3D &sun6i_gpadc_chan_select,
> +};
> +
> +struct sunxi_gpadc_dev {
> +	struct iio_dev				*indio_dev;
> +	void __iomem				*regs;
> +	struct completion			completion;
> +	int					temp_data;
> +	u32					adc_data;
> +	struct regmap				*regmap;
> +	unsigned int				fifo_data_irq;
> +	atomic_t				ignore_fifo_data_irq;
> +	unsigned int				temp_data_irq;
> +	atomic_t				ignore_temp_data_irq;
> +	const struct sunxi_gpadc_soc_specific	*soc_specific;
> +	struct mutex				mutex;
> +};
> +
> +#define SUNXI_GPADC_ADC_CHANNEL(_channel, _name) {		\
> +	.type =3D IIO_VOLTAGE,					\
> +	.indexed =3D 1,						\
> +	.channel =3D _channel,					\
> +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),		\
> +	.datasheet_name =3D _name,				\
> +}
> +
> +static struct iio_map sunxi_gpadc_hwmon_maps[] =3D {
> +	{
> +		.adc_channel_label =3D "temp_adc",
> +		.consumer_dev_name =3D "iio_hwmon.0",
> +	},
> +	{ /* sentinel */ },
> +};
> +
> +static const struct iio_chan_spec sunxi_gpadc_channels[] =3D {
> +	SUNXI_GPADC_ADC_CHANNEL(0, "adc_chan0"),
> +	SUNXI_GPADC_ADC_CHANNEL(1, "adc_chan1"),
> +	SUNXI_GPADC_ADC_CHANNEL(2, "adc_chan2"),
> +	SUNXI_GPADC_ADC_CHANNEL(3, "adc_chan3"),
> +	{
> +		.type =3D IIO_TEMP,
> +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE) |
> +				      BIT(IIO_CHAN_INFO_OFFSET),
> +		.datasheet_name =3D "temp_adc",
> +	},
> +};
> +
> +static int sunxi_gpadc_adc_read(struct iio_dev *indio_dev, int channel,
> +				int *val)
> +{
> +	struct sunxi_gpadc_dev *info =3D iio_priv(indio_dev);
> +	int ret =3D 0;
> +
> +	pm_runtime_get_sync(indio_dev->dev.parent);
> +	mutex_lock(&info->mutex);
> +
> +	reinit_completion(&info->completion);
> +	regmap_write(info->regmap, SUNXI_GPADC_TP_CTRL1,
> +		     info->soc_specific->tp_mode_en |
> +		     info->soc_specific->tp_adc_select |
> +		     info->soc_specific->adc_chan_select(channel));
> +	regmap_write(info->regmap, SUNXI_GPADC_TP_INT_FIFOC,
> +		     SUNXI_GPADC_TP_INT_FIFOC_TP_FIFO_TRIG_LEVEL(1) |
> +		     SUNXI_GPADC_TP_INT_FIFOC_TP_FIFO_FLUSH);
> +	enable_irq(info->fifo_data_irq);
> +
> +	if (!wait_for_completion_timeout(&info->completion,
> +					 msecs_to_jiffies(100))) {
> +		ret =3D -ETIMEDOUT;
> +		goto out;
> +	}
> +
> +	*val =3D info->adc_data;
> +
> +out:
> +	disable_irq(info->fifo_data_irq);
> +	mutex_unlock(&info->mutex);
> +	pm_runtime_mark_last_busy(indio_dev->dev.parent);
> +	pm_runtime_put_autosuspend(indio_dev->dev.parent);
> +
> +	return ret;
> +}
> +
> +static int sunxi_gpadc_temp_read(struct iio_dev *indio_dev, int *val)
> +{
> +	struct sunxi_gpadc_dev *info =3D iio_priv(indio_dev);
> +	int ret =3D 0;
> +
> +	pm_runtime_get_sync(indio_dev->dev.parent);
> +	mutex_lock(&info->mutex);
> +
> +	reinit_completion(&info->completion);
> +
> +	regmap_write(info->regmap, SUNXI_GPADC_TP_INT_FIFOC,
> +		     SUNXI_GPADC_TP_INT_FIFOC_TP_FIFO_TRIG_LEVEL(1) |
> +		     SUNXI_GPADC_TP_INT_FIFOC_TP_FIFO_FLUSH);
> +	/*
> +	 * The temperature sensor returns valid data only when the ADC operates
> +	 * in touchscreen mode.
> +	 */
> +	regmap_write(info->regmap, SUNXI_GPADC_TP_CTRL1,
> +		     info->soc_specific->tp_mode_en);
> +	enable_irq(info->temp_data_irq);
> +
> +	if (!wait_for_completion_timeout(&info->completion,
> +					 msecs_to_jiffies(100))) {
> +		ret =3D -ETIMEDOUT;
> +		goto out;
> +	}
> +
> +	*val =3D info->temp_data;
> +
> +out:
> +	disable_irq(info->temp_data_irq);
> +	mutex_unlock(&info->mutex);
> +	pm_runtime_mark_last_busy(indio_dev->dev.parent);
> +	pm_runtime_put_autosuspend(indio_dev->dev.parent);
> +
> +	return ret;
> +}

This looks like the exact same function than above, can't that be
factored (for example by passing the interrupt number as argument, and
giving it a way to know if it's going to be used for the ADC or
temperature as an argument?)

> +static int sunxi_gpadc_temp_offset(struct iio_dev *indio_dev, int *val)
> +{
> +	struct sunxi_gpadc_dev *info =3D iio_priv(indio_dev);
> +
> +	*val =3D info->soc_specific->temp_offset;
> +
> +	return 0;
> +}
> +
> +static int sunxi_gpadc_temp_scale(struct iio_dev *indio_dev, int *val)
> +{
> +	struct sunxi_gpadc_dev *info =3D iio_priv(indio_dev);
> +
> +	*val =3D info->soc_specific->temp_scale;
> +
> +	return 0;
> +}
> +
> +static int sunxi_gpadc_read_raw(struct iio_dev *indio_dev,
> +				struct iio_chan_spec const *chan, int *val,
> +				int *val2, long mask)
> +{
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_OFFSET:
> +		ret =3D sunxi_gpadc_temp_offset(indio_dev, val);
> +		if (ret)
> +			return ret;
> +
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_RAW:
> +		if (chan->type =3D=3D IIO_VOLTAGE) {
> +			ret =3D sunxi_gpadc_adc_read(indio_dev, chan->channel,
> +						   val);
> +			if (ret)
> +				return ret;
> +		} else {
> +			ret =3D sunxi_gpadc_temp_read(indio_dev, val);
> +			if (ret)
> +				return ret;
> +		}
> +
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		ret =3D sunxi_gpadc_temp_scale(indio_dev, val);
> +		if (ret)
> +			return ret;
> +
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static const struct iio_info sunxi_gpadc_iio_info =3D {
> +	.read_raw =3D sunxi_gpadc_read_raw,
> +	.driver_module =3D THIS_MODULE,
> +};
> +
> +static irqreturn_t sunxi_gpadc_temp_data_irq_handler(int irq, void *dev_=
id)
> +{
> +	struct sunxi_gpadc_dev *info =3D dev_id;
> +
> +	if (atomic_read(&info->ignore_temp_data_irq))
> +		return IRQ_HANDLED;
> +
> +	if (!regmap_read(info->regmap, SUNXI_GPADC_TEMP_DATA, &info->temp_data))
> +		complete(&info->completion);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t sunxi_gpadc_fifo_data_irq_handler(int irq, void *dev_=
id)
> +{
> +	struct sunxi_gpadc_dev *info =3D dev_id;
> +
> +	if (atomic_read(&info->ignore_fifo_data_irq))
> +		return IRQ_HANDLED;
> +
> +	if (!regmap_read(info->regmap, SUNXI_GPADC_TP_DATA, &info->adc_data))
> +		complete(&info->completion);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int sunxi_gpadc_runtime_suspend(struct device *dev)
> +{
> +	struct sunxi_gpadc_dev *info =3D iio_priv(dev_get_drvdata(dev));
> +
> +	mutex_lock(&info->mutex);
> +
> +	/* Disable the ADC on IP */
> +	regmap_write(info->regmap, SUNXI_GPADC_TP_CTRL1, 0);
> +	/* Disable temperature sensor on IP */
> +	regmap_write(info->regmap, SUNXI_GPADC_TP_TPR, 0);
> +
> +	mutex_unlock(&info->mutex);

Having some comments somewhere about what this mutex protects would be
great (just like checkpatch tells you about).

However, I'm not sure this is even possible. Isn't the point of the
runtime_pm precisely to not be called while you're using the device?

> +
> +	return 0;
> +}
> +
> +static int sunxi_gpadc_runtime_resume(struct device *dev)
> +{
> +	struct sunxi_gpadc_dev *info =3D iio_priv(dev_get_drvdata(dev));
> +
> +	mutex_lock(&info->mutex);
> +
> +	/* clkin =3D 6MHz */
> +	regmap_write(info->regmap, SUNXI_GPADC_TP_CTRL0,
> +		     SUNXI_GPADC_TP_CTRL0_ADC_CLK_DIVIDER(2) |
> +		     SUNXI_GPADC_TP_CTRL0_FS_DIV(7) |
> +		     SUNXI_GPADC_TP_CTRL0_T_ACQ(63));
> +	regmap_write(info->regmap, SUNXI_GPADC_TP_CTRL1,
> +		     info->soc_specific->tp_mode_en);
> +	regmap_write(info->regmap, SUNXI_GPADC_TP_CTRL3,
> +		     SUNXI_GPADC_TP_CTRL3_FILTER_EN |
> +		     SUNXI_GPADC_TP_CTRL3_FILTER_TYPE(1));
> +	/* period =3D SUNXI_GPADC_TP_TPR_TEMP_PERIOD * 256 * 16 / clkin; ~1.3s =
*/
> +	regmap_write(info->regmap, SUNXI_GPADC_TP_TPR,
> +		     SUNXI_GPADC_TP_TPR_TEMP_ENABLE |
> +		     SUNXI_GPADC_TP_TPR_TEMP_PERIOD(1953));
> +
> +	mutex_unlock(&info->mutex);
> +
> +	return 0;
> +}
> +
> +static int sunxi_gpadc_get_temp(void *data, int *temp)
> +{
> +	struct sunxi_gpadc_dev *info =3D (struct sunxi_gpadc_dev *)data;
> +	int val, scale, offset;
> +
> +	/* If reading temperature times out, take stored previous value. */
> +	if (sunxi_gpadc_temp_read(info->indio_dev, &val))
> +		val =3D info->temp_data;
> +	sunxi_gpadc_temp_scale(info->indio_dev, &scale);
> +	sunxi_gpadc_temp_offset(info->indio_dev, &offset);
> +
> +	*temp =3D (val + offset) * scale;
> +
> +	return 0;
> +}
> +
> +static const struct thermal_zone_of_device_ops sunxi_ts_tz_ops =3D {
> +	.get_temp =3D &sunxi_gpadc_get_temp,
> +};
> +
> +static const struct dev_pm_ops sunxi_gpadc_pm_ops =3D {
> +	.runtime_suspend =3D &sunxi_gpadc_runtime_suspend,
> +	.runtime_resume =3D &sunxi_gpadc_runtime_resume,
> +};
> +
> +static int sunxi_gpadc_probe(struct platform_device *pdev)
> +{
> +	struct sunxi_gpadc_dev *info;
> +	struct iio_dev *indio_dev;
> +	int ret, irq;
> +	struct sunxi_gpadc_mfd_dev *sunxi_gpadc_mfd_dev;
> +	struct thermal_zone_device *tzd;
> +
> +	sunxi_gpadc_mfd_dev =3D dev_get_drvdata(pdev->dev.parent);
> +
> +	indio_dev =3D devm_iio_device_alloc(&pdev->dev, sizeof(*info));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	info =3D iio_priv(indio_dev);
> +
> +	mutex_init(&info->mutex);
> +	info->regmap =3D sunxi_gpadc_mfd_dev->regmap;
> +	info->indio_dev =3D indio_dev;
> +	atomic_set(&info->ignore_fifo_data_irq, 1);
> +	atomic_set(&info->ignore_temp_data_irq, 1);
> +	init_completion(&info->completion);
> +	indio_dev->name =3D dev_name(&pdev->dev);
> +	indio_dev->dev.parent =3D &pdev->dev;
> +	indio_dev->dev.of_node =3D pdev->dev.of_node;
> +	indio_dev->info =3D &sunxi_gpadc_iio_info;
> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> +	indio_dev->num_channels =3D ARRAY_SIZE(sunxi_gpadc_channels);
> +	indio_dev->channels =3D sunxi_gpadc_channels;
> +
> +	info->soc_specific =3D (struct sunxi_gpadc_soc_specific *)platform_get_=
device_id(pdev)->driver_data;

I'm not sure that cast is necessary (and you can probably shorten that
structure name).

> +
> +	tzd =3D devm_thermal_zone_of_sensor_register(&pdev->dev, 0, info,
> +						   &sunxi_ts_tz_ops);
> +	if (IS_ERR(tzd)) {
> +		dev_err(&pdev->dev, "could not register thermal sensor: %ld\n",
> +			PTR_ERR(tzd));
> +		return PTR_ERR(tzd);
> +	}
> +
> +	pm_runtime_set_autosuspend_delay(&pdev->dev,
> +					 SUNXI_GPADC_AUTOSUSPEND_DELAY);
> +	pm_runtime_use_autosuspend(&pdev->dev);
> +	pm_runtime_set_suspended(&pdev->dev);
> +	pm_runtime_enable(&pdev->dev);
> +
> +	irq =3D platform_get_irq_byname(pdev, "TEMP_DATA_PENDING");
> +	if (irq < 0) {
> +		dev_err(&pdev->dev,
> +			"no TEMP_DATA_PENDING interrupt registered\n");
> +		ret =3D irq;
> +		goto err;
> +	}
> +
> +	irq =3D regmap_irq_get_virq(sunxi_gpadc_mfd_dev->regmap_irqc, irq);
> +	ret =3D devm_request_any_context_irq(&pdev->dev, irq,
> +					   sunxi_gpadc_temp_data_irq_handler, 0,
> +					   "temp_data", info);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev,
> +			"could not request TEMP_DATA_PENDING interrupt: %d\n",
> +			ret);
> +		goto err;
> +	}
> +
> +	disable_irq(irq);
> +	info->temp_data_irq =3D irq;
> +	atomic_set(&info->ignore_temp_data_irq, 0);
> +
> +	irq =3D platform_get_irq_byname(pdev, "FIFO_DATA_PENDING");
> +	if (irq < 0) {
> +		dev_err(&pdev->dev,
> +			"no FIFO_DATA_PENDING interrupt registered\n");
> +		ret =3D irq;
> +		goto err;
> +	}
> +
> +	irq =3D regmap_irq_get_virq(sunxi_gpadc_mfd_dev->regmap_irqc, irq);
> +	ret =3D devm_request_any_context_irq(&pdev->dev, irq,
> +					   sunxi_gpadc_fifo_data_irq_handler, 0,
> +					   "fifo_data", info);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev,
> +			"could not request FIFO_DATA_PENDING interrupt: %d\n",
> +			ret);
> +		goto err;
> +	}
> +
> +	disable_irq(irq);
> +	info->fifo_data_irq =3D irq;
> +	atomic_set(&info->ignore_fifo_data_irq, 0);

These two blocks to handle the IRQs look very similar, you porbably
want to factor them.

> +	ret =3D iio_map_array_register(indio_dev, sunxi_gpadc_hwmon_maps);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "failed to register iio map array\n");
> +		goto err;
> +	}
> +
> +	platform_set_drvdata(pdev, indio_dev);
> +
> +	ret =3D iio_device_register(indio_dev);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "could not register the device\n");
> +		goto err_map;
> +	}

> +
> +	return 0;
> +
> +err_map:
> +	iio_map_array_unregister(indio_dev);
> +
> +err:
> +	pm_runtime_put(&pdev->dev);

You're never disabling it?


> +	/* Disable all hardware interrupts */
> +	regmap_write(info->regmap, SUNXI_GPADC_TP_INT_FIFOC, 0);

This looks like the wrong place to do that. You'll disable the
interrupts of all the devices of the MFD, which is probbaly not what
you want to do (and if you do, you want to do it in the MFD driver).

> +
> +	return ret;
> +}
> +
> +static int sunxi_gpadc_remove(struct platform_device *pdev)
> +{
> +	struct sunxi_gpadc_dev *info;
> +	struct iio_dev *indio_dev =3D platform_get_drvdata(pdev);
> +
> +	info =3D iio_priv(indio_dev);
> +	iio_device_unregister(indio_dev);
> +	iio_map_array_unregister(indio_dev);
> +	pm_runtime_put(&pdev->dev);
> +	pm_runtime_disable(&pdev->dev);
> +	/* Disable all hardware interrupts */
> +	regmap_write(info->regmap, SUNXI_GPADC_TP_INT_FIFOC, 0);
> +
> +	return 0;
> +}
> +
> +static const struct platform_device_id sunxi_gpadc_id[] =3D {
> +	{ "sun4i-a10-gpadc-iio", (kernel_ulong_t)&sun4i_gpadc_soc_specific },
> +	{ "sun5i-a13-gpadc-iio", (kernel_ulong_t)&sun5i_gpadc_soc_specific },
> +	{ "sun6i-a31-gpadc-iio", (kernel_ulong_t)&sun6i_gpadc_soc_specific },

kernel_ulong_t ? that's weird.


> +	{ /* sentinel */ },
> +};
> +
> +static struct platform_driver sunxi_gpadc_driver =3D {
> +	.driver =3D {
> +		.name =3D "sunxi-gpadc-iio",
> +		.pm =3D &sunxi_gpadc_pm_ops,
> +	},
> +	.id_table =3D sunxi_gpadc_id,
> +	.probe =3D sunxi_gpadc_probe,
> +	.remove =3D sunxi_gpadc_remove,
> +};
> +
> +module_platform_driver(sunxi_gpadc_driver);
> +
> +MODULE_DESCRIPTION("ADC driver for sunxi platforms");
> +MODULE_AUTHOR("Quentin Schulz <quentin.schulz@free-electrons.com>");
> +MODULE_LICENSE("GPL v2");

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--XF85m9dhOBO43t/C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXmwHeAAoJEBx+YmzsjxAgwOgP/2d22zq7Ux8/3z7n6oM6BN+K
YPgFmaFKIo76NTgPEDdPPU4fCoA1UgE0/SD3TKt+Rxu4HdY82mrnJZ5iNux56Ujt
GjI4mSIneIDldKvuhFxjWIJX5FUpPFGfUvJJ6zMsblNHr4ptZqI7gjhvXY40YZb2
1xhSz4cAhggCHccKyTHk/qrl2VzZNQ7Oj3FgMjOkV8PiK33OCvJhx90aHcGK0Ew8
fxDbpct1EqOJrn6vBARJvvN4PO95F27TVVko2jJY83/YpSaFAi8LN77cq+fFHFyz
aXyNM7zfMcTZSm3cZ3+xNX9v+J8Gf8WrN/2OmP993SSoClJr9VcXDkm9VW9Y5xAe
RNLtBYZ6OTq3WddRRwkeHy2/oZDZBCoHPZ3WhRl7o8vgqgfcG/OU+k3MND+AhEc4
/x06zv6Pek9ELr/yqhl4mT3V58Pf1aLNSR0nCGuX9MLHTZMa8y2QANSq8XDtZo9Y
1pKoSbFZa3GDmp3hVAICVNMfnwYngKRpCBDn0vAlJYnWhjMdmm6cTSYuBBXieaZf
y8TKOQqYBolbcAjmwdl5aO4+TtdgUzDdGstuKZxvyjlTuf6Kt9Nmy7n2fzAVoT2l
YCokyYeqBPYDc+bMbhvDTLbuFbyn+pIvAXoZsT0z/DDqWasYcTiD8XvgEWJYSkhI
7Yv+a4BrqaF9h3Hh0SYr
=RQ6G
-----END PGP SIGNATURE-----

--XF85m9dhOBO43t/C--
