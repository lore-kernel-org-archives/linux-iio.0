Return-Path: <maxime.ripard@free-electrons.com>
Date: Mon, 18 Jul 2016 14:57:53 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: jdelvare@suse.com, linux@roeck-us.net, jic23@kernel.org,
	knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, wens@csie.org,
	lee.jones@linaro.org, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	thomas.petazzoni@free-electrons.com,
	antoine.tenart@free-electrons.com
Subject: Re: [PATCH v2 2/4] iio: adc: add support for Allwinner SoCs ADC
Message-ID: <20160718125753.GF4199@lukather>
References: <1468576754-3273-1-git-send-email-quentin.schulz@free-electrons.com>
 <1468576754-3273-3-git-send-email-quentin.schulz@free-electrons.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aZoGpuMECXJckB41"
In-Reply-To: <1468576754-3273-3-git-send-email-quentin.schulz@free-electrons.com>
List-ID: <linux-iio@vger.kernel.org>


--aZoGpuMECXJckB41
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 15, 2016 at 11:59:12AM +0200, Quentin Schulz wrote:
> The Allwinner SoCs all have an ADC that can also act as a touchscreen
> controller and a thermal sensor. This patch adds the ADC driver which is
> based on the MFD for the same SoCs ADC.
>=20
> This also registers the thermal adc channel in the iio map array so
> iio_hwmon could use it without modifying the Device Tree.
>=20
> This driver probes on three different platform_device_id to take into
> account slight differences between Allwinner SoCs ADCs.
>=20
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
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
>  drivers/iio/adc/Kconfig           |  12 ++
>  drivers/iio/adc/Makefile          |   1 +
>  drivers/iio/adc/sunxi-gpadc-iio.c | 417 ++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 430 insertions(+)
>  create mode 100644 drivers/iio/adc/sunxi-gpadc-iio.c
>=20
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 25378c5..184856f 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -338,6 +338,18 @@ config NAU7802
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called nau7802.
> =20
> +config SUNXI_ADC

We try to avoid the SUNXI prefix usually, otherwise this driver will
have a generic name (or at least is implicitly saying that it supports
all the sunxi SoCs), while it supports only a subset of those SoCs.

> +	tristate "ADC driver for sunxi platforms"

And you should also mention which ADC is supported, since we usually
have several of them.

Something like "Support for the Allwinner SoCs GPADC"

> +	depends on IIO
> +	depends on MFD_SUNXI_ADC

The order of your patches is quite weird. You depend on an option that
is not present yet?

> +	help
> +	  Say yes here to build support for Allwinner (A10, A13 and A31) SoCs
> +	  ADC. This ADC provides 4 channels which can be used as an ADC or as a
> +	  touchscreen input and one channel for thermal sensor.
> +
> +          To compile this driver as a module, choose M here: the module =
will be

Your indentation is weird here, and the wrapping is likely to be wrong
too.

> +	  called sunxi-gpadc-iio.
> +
>  config PALMAS_GPADC
>  	tristate "TI Palmas General Purpose ADC"
>  	depends on MFD_PALMAS
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 38638d4..3e60a1d 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -37,6 +37,7 @@ obj-$(CONFIG_PALMAS_GPADC) +=3D palmas_gpadc.o
>  obj-$(CONFIG_QCOM_SPMI_IADC) +=3D qcom-spmi-iadc.o
>  obj-$(CONFIG_QCOM_SPMI_VADC) +=3D qcom-spmi-vadc.o
>  obj-$(CONFIG_ROCKCHIP_SARADC) +=3D rockchip_saradc.o
> +obj-$(CONFIG_SUNXI_ADC) +=3D sunxi-gpadc-iio.o
>  obj-$(CONFIG_TI_ADC081C) +=3D ti-adc081c.o
>  obj-$(CONFIG_TI_ADC0832) +=3D ti-adc0832.o
>  obj-$(CONFIG_TI_ADC128S052) +=3D ti-adc128s052.o
> diff --git a/drivers/iio/adc/sunxi-gpadc-iio.c b/drivers/iio/adc/sunxi-gp=
adc-iio.c
> new file mode 100644
> index 0000000..87cc913
> --- /dev/null
> +++ b/drivers/iio/adc/sunxi-gpadc-iio.c
> @@ -0,0 +1,417 @@
> +/* ADC driver for sunxi platforms
> + *
> + * Copyright (c) 2016 Quentin Schulz <quentin.schulz@free-electrons>
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms of the GNU General Public License version 2 as publis=
hed by
> + * the Free Software Foundation.

Your wrapping is wrong.

> + */
> +
> +#include <linux/completion.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/driver.h>
> +#include <linux/iio/machine.h>
> +#include <linux/mfd/sunxi-gpadc-mfd.h>
> +
> +#define SUNXI_GPADC_TP_CTRL0			0x00
> +#define SUNXI_GPADC_TP_CTRL1			0x04
> +#define SUNXI_GPADC_TP_CTRL2			0x08
> +#define SUNXI_GPADC_TP_CTRL3			0x0c
> +#define SUNXI_GPADC_TP_TPR			0x18
> +#define SUNXI_GPADC_TP_CDAT			0x1c
> +#define SUNXI_GPADC_TEMP_DATA			0x20
> +#define SUNXI_GPADC_TP_DATA			0x24
> +
> +/* TP_CTRL0 bits */
> +#define SUNXI_GPADC_ADC_FIRST_DLY(x)		((x) << 24) /* 8 bits */
> +#define SUNXI_GPADC_ADC_FIRST_DLY_MODE		BIT(23)
> +#define SUNXI_GPADC_ADC_CLK_SELECT		BIT(22)
> +#define SUNXI_GPADC_ADC_CLK_DIVIDER(x)		((x) << 20) /* 2 bits */
> +#define SUNXI_GPADC_FS_DIV(x)			((x) << 16) /* 4 bits */
> +#define SUNXI_GPADC_T_ACQ(x)			((x) << 0)  /* 16 bits */

We usually prefer to have the bits defined directly after the
registers, and prefixed with the name of the register they belong to.

Something like SUNXI_GPADC_TP_CTRL_T_ACQ in this case

> +
> +/* TP_CTRL1 bits */
> +#define SUNXI_GPADC_STYLUS_UP_DEBOUNCE(x)	((x) << 12) /* 8 bits */
> +#define SUNXI_GPADC_STYLUS_UP_DEBOUNCE_EN	BIT(9)
> +#define SUNXI_GPADC_TOUCH_PAN_CALI_EN		BIT(6)
> +#define SUNXI_GPADC_TP_DUAL_EN			BIT(5)
> +#define SUNXI_GPADC_TP_MODE_EN			BIT(4)
> +#define SUNXI_GPADC_TP_ADC_SELECT		BIT(3)
> +#define SUNXI_GPADC_ADC_CHAN_SELECT(x)		((x) << 0)  /* 3 bits */

Usually the comments are on the line above. However, if you really
want to enforce something, you should rather mask the
value. Otherwise, that comment is pretty useless.

> +
> +/* TP_CTRL1 bits for sun6i SOCs */
> +#define SUNXI_GPADC_SUN6I_TOUCH_PAN_CALI_EN	BIT(7)
> +#define SUNXI_GPADC_SUN6I_TP_DUAL_EN		BIT(6)
> +#define SUNXI_GPADC_SUN6I_TP_MODE_EN		BIT(5)
> +#define SUNXI_GPADC_SUN6I_TP_ADC_SELECT		BIT(4)

Shouldn't that go in either a common define or the touchscreen driver?

> +#define SUNXI_GPADC_SUN6I_ADC_CHAN_SELECT(x)	BIT(x)  /* 4 bits */



> +
> +/* TP_CTRL2 bits */
> +#define SUNXI_GPADC_TP_SENSITIVE_ADJUST(x)	((x) << 28) /* 4 bits */
> +#define SUNXI_GPADC_TP_MODE_SELECT(x)		((x) << 26) /* 2 bits */
> +#define SUNXI_GPADC_PRE_MEA_EN			BIT(24)
> +#define SUNXI_GPADC_PRE_MEA_THRE_CNT(x)		((x) << 0)  /* 24 bits */
> +
> +/* TP_CTRL3 bits */
> +#define SUNXI_GPADC_FILTER_EN			BIT(2)
> +#define SUNXI_GPADC_FILTER_TYPE(x)		((x) << 0)  /* 2 bits */
> +
> +/* TP_INT_FIFOC irq and fifo mask / control bits */
> +#define SUNXI_GPADC_TEMP_IRQ_EN			BIT(18)
> +#define SUNXI_GPADC_TP_OVERRUN_IRQ_EN		BIT(17)
> +#define SUNXI_GPADC_TP_DATA_IRQ_EN		BIT(16)
> +#define SUNXI_GPADC_TP_DATA_XY_CHANGE		BIT(13)
> +#define SUNXI_GPADC_TP_FIFO_TRIG_LEVEL(x)	((x) << 8)  /* 5 bits */
> +#define SUNXI_GPADC_TP_DATA_DRQ_EN		BIT(7)
> +#define SUNXI_GPADC_TP_FIFO_FLUSH		BIT(4)
> +#define SUNXI_GPADC_TP_UP_IRQ_EN		BIT(1)
> +#define SUNXI_GPADC_TP_DOWN_IRQ_EN		BIT(0)
> +
> +/* TP_INT_FIFOS irq and fifo status bits */
> +#define SUNXI_GPADC_TEMP_DATA_PENDING		BIT(18)
> +#define SUNXI_GPADC_FIFO_OVERRUN_PENDING	BIT(17)
> +#define SUNXI_GPADC_FIFO_DATA_PENDING		BIT(16)
> +#define SUNXI_GPADC_TP_IDLE_FLG			BIT(2)
> +#define SUNXI_GPADC_TP_UP_PENDING		BIT(1)
> +#define SUNXI_GPADC_TP_DOWN_PENDING		BIT(0)
> +
> +/* TP_TPR bits */
> +#define SUNXI_GPADC_TEMP_ENABLE(x)		((x) << 16)
> +/* t =3D x * 256 * 16 / clkin */

That comment would be better next to the code that does that
computation.

> +#define SUNXI_GPADC_TEMP_PERIOD(x)		((x) << 0)
> +
> +#define SUNXI_GPADC_ARCH_SUN4I			BIT(0)
> +#define SUNXI_GPADC_ARCH_SUN5I			BIT(1)
> +#define SUNXI_GPADC_ARCH_SUN6I			BIT(2)
> +
> +struct sunxi_gpadc_dev {
> +	void __iomem			*regs;
> +	struct completion		completion;
> +	int				temp_data;
> +	u32				adc_data;
> +	struct regmap			*regmap;
> +	unsigned int			fifo_data_irq;
> +	unsigned int			temp_data_irq;
> +	unsigned int			flags;
> +};
> +
> +#define SUNXI_GPADC_ADC_CHANNEL(_channel, _name) {		\
> +	.type =3D IIO_VOLTAGE,					\
> +	.indexed =3D 1,						\
> +	.channel =3D _channel,					\
> +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),		\
> +	.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE),	\
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
> +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_PROCESSED),
> +		.datasheet_name =3D "temp_adc",
> +		.extend_name =3D "SoC temperature",
> +	},
> +	{ /* sentinel */ },
> +};
> +
> +static int sunxi_gpadc_adc_read(struct iio_dev *indio_dev, int channel,
> +				int *val)
> +{
> +	struct sunxi_gpadc_dev *info =3D iio_priv(indio_dev);
> +	int ret =3D 0;
> +
> +	mutex_lock(&indio_dev->mlock);
> +
> +	reinit_completion(&info->completion);
> +	if (info->flags & SUNXI_GPADC_ARCH_SUN6I)
> +		regmap_write(info->regmap, SUNXI_GPADC_TP_CTRL1,
> +			     SUNXI_GPADC_SUN6I_TP_MODE_EN |
> +			     SUNXI_GPADC_SUN6I_TP_ADC_SELECT |
> +			     SUNXI_GPADC_SUN6I_ADC_CHAN_SELECT(channel));
> +	else
> +		regmap_write(info->regmap, SUNXI_GPADC_TP_CTRL1,
> +			     SUNXI_GPADC_TP_MODE_EN |
> +			     SUNXI_GPADC_TP_ADC_SELECT |
> +			     SUNXI_GPADC_ADC_CHAN_SELECT(channel));

Using a function pointer that would compute this, or some fields in a
structure to store this would be better.

> +	regmap_write(info->regmap, SUNXI_GPADC_TP_INT_FIFOC,
> +		     SUNXI_GPADC_TP_FIFO_TRIG_LEVEL(1) |
> +		     SUNXI_GPADC_TP_FIFO_FLUSH);
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
> +	mutex_unlock(&indio_dev->mlock);
> +
> +	return ret;
> +}
> +
> +static int sunxi_gpadc_temp_read(struct iio_dev *indio_dev, int *val)
> +{
> +	struct sunxi_gpadc_dev *info =3D iio_priv(indio_dev);
> +	int ret =3D 0;
> +
> +	mutex_lock(&indio_dev->mlock);
> +
> +	reinit_completion(&info->completion);
> +
> +	regmap_write(info->regmap, SUNXI_GPADC_TP_INT_FIFOC,
> +		     SUNXI_GPADC_TP_FIFO_TRIG_LEVEL(1) |
> +		     SUNXI_GPADC_TP_FIFO_FLUSH);
> +	if (info->flags & SUNXI_GPADC_ARCH_SUN6I)
> +		regmap_write(info->regmap, SUNXI_GPADC_TP_CTRL1,
> +			     SUNXI_GPADC_SUN6I_TP_MODE_EN);
> +	else
> +		regmap_write(info->regmap, SUNXI_GPADC_TP_CTRL1,
> +			     SUNXI_GPADC_TP_MODE_EN);
> +	enable_irq(info->temp_data_irq);
> +
> +	if (!wait_for_completion_timeout(&info->completion,
> +					 msecs_to_jiffies(100))) {
> +		ret =3D -ETIMEDOUT;
> +		goto out;
> +	}
> +
> +	if (info->flags & SUNXI_GPADC_ARCH_SUN4I)
> +		*val =3D info->temp_data * 133 - 257000;
> +	else if (info->flags & SUNXI_GPADC_ARCH_SUN5I)
> +		*val =3D info->temp_data * 100 - 144700;
> +	else if (info->flags & SUNXI_GPADC_ARCH_SUN6I)
> +		*val =3D info->temp_data * 167 - 271000;

Ditto, having functions to comptue this and just store the function
pointer would be better.

> +
> +out:
> +	disable_irq(info->temp_data_irq);
> +	mutex_unlock(&indio_dev->mlock);
> +
> +	return ret;
> +
> +}
> +
> +static int sunxi_gpadc_read_raw(struct iio_dev *indio_dev,
> +				struct iio_chan_spec const *chan,
> +				int *val, int *val2, long mask)
> +{
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_PROCESSED:
> +		ret =3D sunxi_gpadc_temp_read(indio_dev, val);
> +		if (ret)
> +			return ret;
> +
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_RAW:
> +		ret =3D sunxi_gpadc_adc_read(indio_dev, chan->channel, val);
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
> +	int ret;
> +
> +	ret =3D regmap_read(info->regmap, SUNXI_GPADC_TEMP_DATA,
> +			  &info->temp_data);
> +	if (ret =3D=3D 0)
> +		complete(&info->completion);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t sunxi_gpadc_fifo_data_irq_handler(int irq, void *dev_=
id)
> +{
> +	struct sunxi_gpadc_dev *info =3D dev_id;
> +	int ret;
> +
> +	ret =3D regmap_read(info->regmap, SUNXI_GPADC_TP_DATA, &info->adc_data);
> +	if (ret =3D=3D 0)
> +		complete(&info->completion);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int sunxi_gpadc_probe(struct platform_device *pdev)
> +{
> +	struct sunxi_gpadc_dev *info;
> +	struct iio_dev *indio_dev;
> +	int ret, irq;
> +	struct sunxi_gpadc_mfd_dev *sunxi_gpadc_mfd_dev;
> +
> +	sunxi_gpadc_mfd_dev =3D dev_get_drvdata(pdev->dev.parent);
> +
> +	indio_dev =3D devm_iio_device_alloc(&pdev->dev, sizeof(*info));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	info =3D iio_priv(indio_dev);
> +
> +	info->regmap =3D sunxi_gpadc_mfd_dev->regmap;
> +	init_completion(&info->completion);
> +	indio_dev->name =3D dev_name(&pdev->dev);
> +	indio_dev->dev.parent =3D &pdev->dev;
> +	indio_dev->dev.of_node =3D pdev->dev.of_node;
> +	indio_dev->info =3D &sunxi_gpadc_iio_info;
> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> +	indio_dev->num_channels =3D ARRAY_SIZE(sunxi_gpadc_channels);
> +	indio_dev->channels =3D sunxi_gpadc_channels;
> +
> +	info->flags =3D platform_get_device_id(pdev)->driver_data;
> +
> +	regmap_write(info->regmap, SUNXI_GPADC_TP_CTRL0, SUNXI_GPADC_FS_DIV(7) |
> +		     SUNXI_GPADC_ADC_CLK_DIVIDER(2) | SUNXI_GPADC_T_ACQ(63));
> +	if (info->flags & SUNXI_GPADC_ARCH_SUN6I)
> +		regmap_write(info->regmap, SUNXI_GPADC_TP_CTRL1,
> +			     SUNXI_GPADC_SUN6I_TP_MODE_EN);
> +	else
> +		regmap_write(info->regmap, SUNXI_GPADC_TP_CTRL1,
> +			     SUNXI_GPADC_TP_MODE_EN);
> +	regmap_write(info->regmap, SUNXI_GPADC_TP_CTRL3, SUNXI_GPADC_FILTER_EN |
> +		     SUNXI_GPADC_FILTER_TYPE(1));
> +	regmap_write(info->regmap, SUNXI_GPADC_TP_TPR,
> +		     SUNXI_GPADC_TEMP_ENABLE(1) |
> +		     SUNXI_GPADC_TEMP_PERIOD(1953));
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
> +	info->temp_data_irq =3D irq;
> +	disable_irq(irq);
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
> +					   sunxi_gpadc_fifo_data_irq_handler,
> +					   0, "fifo_data", info);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev,
> +			"could not request FIFO_DATA_PENDING interrupt: %d\n",
> +			ret);
> +		goto err;
> +	}
> +
> +	info->fifo_data_irq =3D irq;
> +	disable_irq(irq);

request_irq starts with irq enabled, which means that you can have an
interrupt showing up between your call to request_irq and the
disable_irq.=20

How would that work?

> +
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
> +		iio_map_array_unregister(indio_dev);

That should go in a separate label.

> +		goto err;
> +	}
> +
> +	return 0;
> +
> +err:
> +	regmap_write(info->regmap, SUNXI_GPADC_TP_CTRL1, 0);
> +	regmap_write(info->regmap, SUNXI_GPADC_TP_TPR, 0);

Why is that needed?

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
> +	regmap_write(info->regmap, SUNXI_GPADC_TP_INT_FIFOC, 0);
> +	regmap_write(info->regmap, SUNXI_GPADC_TP_CTRL1, 0);
> +	regmap_write(info->regmap, SUNXI_GPADC_TP_TPR, 0);
> +
> +	return 0;
> +}
> +
> +static const struct platform_device_id sunxi_gpadc_id[] =3D {
> +	{ "sun4i-a10-gpadc-iio", SUNXI_GPADC_ARCH_SUN4I },
> +	{ "sun5i-a13-gpadc-iio", SUNXI_GPADC_ARCH_SUN5I },
> +	{ "sun6i-a31-gpadc-iio", SUNXI_GPADC_ARCH_SUN6I },
> +	{ /* sentinel */ },
> +};
> +
> +static struct platform_driver sunxi_gpadc_driver =3D {
> +	.driver =3D {
> +		.name =3D "sunxi-gpadc-iio",
> +	},
> +	.id_table =3D sunxi_gpadc_id,
> +	.probe =3D sunxi_gpadc_probe,
> +	.remove =3D sunxi_gpadc_remove,
> +};

Having some runtime_pm support for this would be great too.

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--aZoGpuMECXJckB41
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXjNJRAAoJEBx+YmzsjxAg4tcQALGms3I/2ifWUKujnw84aCWp
95oIvobnMAG/u6zfhRbV7IeF29+YQlSaer+W8t1aJXWy8aH9jBREgx7yWmDq1P4J
wdneGGbayPflngcd93Qd6wqd647fpMJ3p6vCnTH8HgEwaJ34pZJQxZcZob+nhppx
VWV+UMAtF3WvTK508wglJ5gKab3hwp0VUWYrm+9/v2XbIY/u/CRyYmf/Qytv1CXA
lrHnn5upJexJjWJny3ZI62jxIZGaNnV5w+HXKF+HyCdrBU17kNyA/Tf8hbPjYKIh
3/0Ak72aa2Ff7jTyt3CcGtoYL7RnKUMNosmVCmLFK0mxMXYBjYTsL0V05uFhLn79
0LsEgJ87aTCojc9GXoA5edLOciK/CtJW3NGbukhEvBJBmFRIbzRk1DFsPi/GK1dY
lFc3Uo8Xs/4LaKEngBzCsi32vgEZOZ5zZrJpZl9y5f6GA0ytxOUnRdpLIZTfAHBL
08k1JUSmvtPrxeKv1U3uGe5Kc62dBpT3ekdc6ztq7Ns1bj6uvQphRruOAEhYJgfq
ZH4ESlhkYgMuvHtEr8JehSd1c5rifOkL8HtOR9tB1SsY27J/lGJz7dUcu5C+KOFL
tPheEWnbHHUPxZdtDEC/KhoOvBAOIshKlTSLdMbTQqDsdhdBRGiE9FHxe4wgVhc6
9RWaXHuoeaFTPPWHc6zx
=180E
-----END PGP SIGNATURE-----

--aZoGpuMECXJckB41--
