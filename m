Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:34915 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750998AbcGRIii (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 18 Jul 2016 04:38:38 -0400
Date: Mon, 18 Jul 2016 10:38:26 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: sun4i_lradc: new driver
Message-ID: <20160718083826.GA22880@lukather>
References: <1468350252-11405-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1468350252-11405-2-git-send-email-alexandre.belloni@free-electrons.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
In-Reply-To: <1468350252-11405-2-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Alex,

On Tue, Jul 12, 2016 at 09:04:12PM +0200, Alexandre Belloni wrote:
> Add an IIO driver for the Allwinner Low Resolution ADC. This ADC is usual=
ly
> used for physical buttons connected using a resistor ladder.
>=20
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
> Changes in v2:
>  - prefixed defines with SUN4I_LRADC_
>  - removed sun4i_lradc_write_raw_get_fmt
>  - set indio_dev->dev.of_node
>  - pushed devm_iio_device_register() at the end of the probe function
>  - added a remove function to call regulator_disable()

I have the feeling that a description on how you plan to deprecate and
remove the old input drivers is needed here.

>=20
>  drivers/iio/adc/Kconfig       |  10 ++
>  drivers/iio/adc/Makefile      |   3 +-
>  drivers/iio/adc/sun4i_lradc.c | 323 ++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 335 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/iio/adc/sun4i_lradc.c
>=20
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 25378c5882e2..87aaac6a5f44 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -384,6 +384,16 @@ config ROCKCHIP_SARADC
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called rockchip_saradc.
> =20
> +config SUN4I_LRADC
> +	tristate "Allwinner sun4i LRADC driver"
> +	depends on ARCH_SUNXI || COMPILE_TEST
> +	select IIO_TRIGGER
> +	help
> +	  Say yes here to build support for the LRADC found on Allwinner SoCs.
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called sun4i_lradc.
> +
>  config TI_ADC081C
>  	tristate "Texas Instruments ADC081C/ADC101C/ADC121C family"
>  	depends on I2C
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 38638d46f972..a3b165af6bde 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -1,4 +1,4 @@
> -#
> +

Unneeded change?

>  # Makefile for IIO ADC drivers
>  #
> =20
> @@ -37,6 +37,7 @@ obj-$(CONFIG_PALMAS_GPADC) +=3D palmas_gpadc.o
>  obj-$(CONFIG_QCOM_SPMI_IADC) +=3D qcom-spmi-iadc.o
>  obj-$(CONFIG_QCOM_SPMI_VADC) +=3D qcom-spmi-vadc.o
>  obj-$(CONFIG_ROCKCHIP_SARADC) +=3D rockchip_saradc.o
> +obj-$(CONFIG_SUN4I_LRADC) +=3D sun4i_lradc.o
>  obj-$(CONFIG_TI_ADC081C) +=3D ti-adc081c.o
>  obj-$(CONFIG_TI_ADC0832) +=3D ti-adc0832.o
>  obj-$(CONFIG_TI_ADC128S052) +=3D ti-adc128s052.o
> diff --git a/drivers/iio/adc/sun4i_lradc.c b/drivers/iio/adc/sun4i_lradc.c
> new file mode 100644
> index 000000000000..cd42e1a994b9
> --- /dev/null
> +++ b/drivers/iio/adc/sun4i_lradc.c
> @@ -0,0 +1,323 @@
> +/*
> + * Driver for the LRADC present on the  Allwinner sun4i
> + *
> + * Copyright 2016 Free Electrons
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/sched.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/regulator/consumer.h>
> +
> +#define SUN4I_LRADC_CTRL		0x00
> +#define SUN4I_LRADC_INTC		0x04
> +#define SUN4I_LRADC_INTS		0x08
> +#define SUN4I_LRADC_DATA0		0x0c
> +#define SUN4I_LRADC_DATA1		0x10
> +
> +/* LRADC_CTRL bits */
> +#define SUN4I_LRADC_FIRST_CONVERT_DLY(x)	((x) << 24) /* 8 bits */
> +#define SUN4I_LRADC_CHAN_SELECT(x)		((x) << 22) /* 2 bits */
> +#define SUN4I_LRADC_CONTINUE_TIME_SEL(x)	((x) << 16) /* 4 bits */
> +#define SUN4I_LRADC_KEY_MODE_SEL(x)		((x) << 12) /* 2 bits */
> +#define SUN4I_LRADC_LEVELA_B_CNT(x)		((x) << 8)  /* 4 bits */
> +#define SUN4I_LRADC_HOLD_EN			BIT(6)
> +#define SUN4I_LRADC_LEVELB_VOL(x)		((x) << 4)  /* 2 bits */
> +#define SUN4I_LRADC_SAMPLE_RATE(x)		((x) << 2)  /* 2 bits */
> +#define SUN4I_LRADC_EN				BIT(0)

Usually, we place the bits define right next to their register
definition (with a prefix that identifies which registers it belongs
to)

Something like SUN4I_LRADC_CTRL_EN for the last one.

> +
> +/* LRADC_INTC and LRADC_INTS bits */
> +#define SUN4I_LRADC_CHAN1_KEYUP_IRQ		BIT(12)
> +#define SUN4I_LRADC_CHAN1_ALRDY_HOLD_IRQ	BIT(11)
> +#define SUN4I_LRADC_CHAN1_HOLD_IRQ		BIT(10)
> +#define	SUN4I_LRADC_CHAN1_KEYDOWN_IRQ	BIT(9)

This alignment looks weird compared to the others.

> +#define SUN4I_LRADC_CHAN1_DATA_IRQ		BIT(8)
> +#define SUN4I_LRADC_CHAN0_KEYUP_IRQ		BIT(4)
> +#define SUN4I_LRADC_CHAN0_ALRDY_HOLD_IRQ	BIT(3)
> +#define SUN4I_LRADC_CHAN0_HOLD_IRQ		BIT(2)
> +#define	SUN4I_LRADC_CHAN0_KEYDOWN_IRQ	BIT(1)

Ditto.

> +#define SUN4I_LRADC_CHAN0_DATA_IRQ		BIT(0)
> +
> +#define NUM_SUN4I_LRADC_CHANS		2
> +
> +struct sun4i_lradc_state {
> +	void __iomem *base;
> +	struct regulator *vref_supply;
> +	u32 vref_mv;
> +	struct completion data_ok[NUM_SUN4I_LRADC_CHANS];
> +	spinlock_t lock;
> +};
> +
> +#define SUN4I_LRADC_CHANNEL(chan) {				\
> +	.type =3D IIO_VOLTAGE,					\
> +	.indexed =3D 1,						\
> +	.channel =3D (chan),					\
> +	.scan_index =3D (chan),					\
> +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),		\
> +	.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE) |	\
> +				BIT(IIO_CHAN_INFO_SAMP_FREQ)	\
> +}
> +
> +static const struct iio_chan_spec sun4i_lradc_chan_array[] =3D {
> +	SUN4I_LRADC_CHANNEL(0),
> +	SUN4I_LRADC_CHANNEL(1),
> +};
> +
> +static const struct {
> +	int val;
> +	int val2;
> +} sun4i_lradc_sample_freq_avail[] =3D {
> +	{250, 0},
> +	{125, 0},
> +	{62, 500000},
> +	{32, 250000},
> +};
> +
> +static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("32.25 62.5 125 250");
> +
> +static struct attribute *sun4i_lradc_attributes[] =3D {
> +	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group sun4i_lradc_attribute_group =3D {
> +	.attrs =3D sun4i_lradc_attributes,
> +};
> +
> +static irqreturn_t sun4i_lradc_irq(int irq, void *dev_id)
> +{
> +	struct iio_dev *indio_dev =3D dev_id;
> +	struct sun4i_lradc_state *st =3D iio_priv(indio_dev);
> +	u32 ints, intc;
> +
> +	spin_lock(&st->lock);
> +
> +	ints =3D readl(st->base + SUN4I_LRADC_INTS);
> +	intc =3D readl(st->base + SUN4I_LRADC_INTC);
> +
> +	if (ints & SUN4I_LRADC_CHAN0_DATA_IRQ)
> +		complete_all(&st->data_ok[0]);
> +
> +	if (ints & SUN4I_LRADC_CHAN1_DATA_IRQ)
> +		complete_all(&st->data_ok[1]);
> +
> +	intc &=3D ~ints;
> +	writel(intc, st->base + SUN4I_LRADC_INTC);
> +	writel(ints, st->base + SUN4I_LRADC_INTS);

Why do you need to modify the interrupt enabled?

> +
> +	spin_unlock(&st->lock);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int sun4i_lradc_read_raw(struct iio_dev *indio_dev,
> +				struct iio_chan_spec const *chan,
> +				int *val, int *val2, long mask)
> +{
> +	struct sun4i_lradc_state *st =3D iio_priv(indio_dev);
> +	int ret, tmp, idx;
> +	unsigned long flags;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		reinit_completion(&st->data_ok[chan->channel]);
> +		spin_lock_irqsave(&st->lock, flags);
> +		tmp =3D readl(st->base + SUN4I_LRADC_INTC);
> +
> +		if (chan->channel)
> +			tmp |=3D SUN4I_LRADC_CHAN1_DATA_IRQ;
> +		else
> +			tmp |=3D SUN4I_LRADC_CHAN0_DATA_IRQ;
> +
> +		writel(tmp, st->base + SUN4I_LRADC_INTC);
> +		spin_unlock_irqrestore(&st->lock, flags);
> +
> +		ret =3D wait_for_completion_interruptible_timeout(
> +			&st->data_ok[chan->channel],
> +			msecs_to_jiffies(1000));
> +		if (ret =3D=3D 0)
> +			return -ETIMEDOUT;
> +
> +		if (chan->channel)
> +			*val =3D readl(st->base + SUN4I_LRADC_DATA1);
> +		else
> +			*val =3D readl(st->base + SUN4I_LRADC_DATA0);
> +
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		*val =3D st->vref_mv;
> +		*val2 =3D 6;
> +
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		tmp =3D readl(st->base + SUN4I_LRADC_CTRL);
> +		idx =3D (tmp >> 2) & 0x3;
> +		*val =3D sun4i_lradc_sample_freq_avail[idx].val;
> +		*val2 =3D sun4i_lradc_sample_freq_avail[idx].val2;
> +		return IIO_VAL_INT_PLUS_MICRO;
> +
> +	default:
> +		break;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int sun4i_lradc_write_raw(struct iio_dev *indio_dev,
> +				 struct iio_chan_spec const *chan,
> +				 int val, int val2, long mask)
> +{
> +	struct sun4i_lradc_state *st =3D iio_priv(indio_dev);
> +	u32 ctrl;
> +	int i;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		for (i =3D 0; i < ARRAY_SIZE(sun4i_lradc_sample_freq_avail); i++)
> +			if (sun4i_lradc_sample_freq_avail[i].val =3D=3D val &&
> +			    sun4i_lradc_sample_freq_avail[i].val2 =3D=3D val2)
> +				break;
> +		if (i =3D=3D ARRAY_SIZE(sun4i_lradc_sample_freq_avail))
> +			return -EINVAL;
> +
> +		ctrl =3D readl(st->base + SUN4I_LRADC_CTRL);
> +		ctrl &=3D ~SUN4I_LRADC_SAMPLE_RATE(0x3);
> +		writel(ctrl | SUN4I_LRADC_SAMPLE_RATE(i),
> +		       st->base + SUN4I_LRADC_CTRL);
> +
> +		return 0;
> +
> +	default:
> +		break;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static const struct iio_info sun4i_lradc_info =3D {
> +	.driver_module =3D THIS_MODULE,
> +	.read_raw =3D sun4i_lradc_read_raw,
> +	.write_raw =3D sun4i_lradc_write_raw,
> +	.attrs =3D &sun4i_lradc_attribute_group,
> +};
> +
> +static int sun4i_lradc_probe(struct platform_device *pdev)
> +{
> +	struct iio_dev *indio_dev;
> +	struct device *dev =3D &pdev->dev;
> +	struct sun4i_lradc_state *st;
> +	int err;
> +
> +	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st =3D iio_priv(indio_dev);
> +
> +	platform_set_drvdata(pdev, indio_dev);
> +
> +	indio_dev->dev.parent =3D dev;
> +	indio_dev->dev.of_node =3D dev->of_node;
> +	indio_dev->name =3D dev_name(dev);
> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> +	indio_dev->info =3D &sun4i_lradc_info;
> +
> +	st->vref_supply =3D devm_regulator_get(dev, "vref");
> +	if (IS_ERR(st->vref_supply))
> +		return PTR_ERR(st->vref_supply);
> +
> +	st->base =3D devm_ioremap_resource(dev,
> +			platform_get_resource(pdev, IORESOURCE_MEM, 0));
> +	if (IS_ERR(st->base))
> +		return PTR_ERR(st->base);
> +
> +	/* Disable then clear all interrupts */
> +	writel(0, st->base + SUN4I_LRADC_INTC);
> +	writel(0xffffffff, st->base + SUN4I_LRADC_INTS);
> +
> +	err =3D devm_request_irq(dev, platform_get_irq(pdev, 0),
> +			       sun4i_lradc_irq, 0,
> +			       "sun4i-a10-lradc", indio_dev);
> +	if (err)
> +		return err;
> +
> +	/* Setup the ADC channels available on the board */
> +	indio_dev->num_channels =3D ARRAY_SIZE(sun4i_lradc_chan_array);
> +	indio_dev->channels =3D sun4i_lradc_chan_array;
> +
> +	err =3D regulator_enable(st->vref_supply);
> +	if (err)
> +		return err;
> +
> +	/* lradc Vref internally is divided by 2/3 */
> +	st->vref_mv =3D regulator_get_voltage(st->vref_supply) * 2 / 3000;
> +
> +	init_completion(&st->data_ok[0]);
> +	init_completion(&st->data_ok[1]);
> +	spin_lock_init(&st->lock);
> +
> +	/* Continuous mode on both channels */
> +	writel(SUN4I_LRADC_CHAN_SELECT(0x3) | SUN4I_LRADC_KEY_MODE_SEL(0x2) |
> +	       SUN4I_LRADC_SAMPLE_RATE(0x00) | SUN4I_LRADC_EN,
> +	       st->base + SUN4I_LRADC_CTRL);
> +
> +	err =3D devm_iio_device_register(dev, indio_dev);
> +	if (err < 0) {
> +		dev_err(dev, "Couldn't register the device.\n");
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +
> +static int sun4i_lradc_remove(struct platform_device *pdev)
> +{
> +	struct iio_dev *indio_dev =3D platform_get_drvdata(pdev);
> +	struct sun4i_lradc_state *st =3D iio_priv(indio_dev);
> +
> +	regulator_disable(st->vref_supply);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id sun4i_lradc_of_match[] =3D {
> +	{ .compatible =3D "allwinner,sun4i-a10-lradc", },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, sun4i_lradc_of_match);
> +
> +static struct platform_driver sun4i_lradc_driver =3D {
> +	.probe	=3D sun4i_lradc_probe,
> +	.remove =3D sun4i_lradc_remove,
> +	.driver =3D {
> +		.name	=3D "sun4i-a10-lradc",
> +		.of_match_table =3D of_match_ptr(sun4i_lradc_of_match),
> +	},
> +};

It would be great if you could also add some runtime_pm support. We're
going to start working on the power management in a near future,
having it already would save us time.

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXjJWCAAoJEBx+YmzsjxAgxh4QALUqqXl1+yqqyw8i5akoskQX
j422zJsNgAhUCjNYTr1s160829mpV0Qn4T29tQB3Uo53d5gsdXFlC22L5Hh0f+tM
a+8dXzCQM2qCLGg98xmhDW9+w5aQFZSbpoTiE+rU7Gdlq2D5evpViWmdrvbyKhva
TpfAs8M6eM0jU3L3ntOFp3pQh8aGkPKsr++pdBiZaEX/B4XrDspRJEUfkiKgLcY9
4e+gtqxOtnFvKbvuHSb1uX8c3WVr53kxkMEcd6blEtIUQ54LmL6VNWRkBVpOPMew
Bp/Mk2Jbq0/149O/sTN1OWcOd53ynl7R2dwk4yngyPEDlP6HWsgtDJA0iJgd7DOO
TgIXAMgt5HxfzDKWdbtJkKWsfzbih3WvTwUWh/UC205u8M9N+ayJKm7lO62CY6gU
LO/mZRhwIMr85bMNz2QSJKdpEiS2jjIucxKwTf49/XXGUH28jDTkp9UBb95BVCfi
WCoG4rYdE2CpyIKB2AAyhZF1SCAjtoKW/CU8V8uQACwtXQ90nHHbMC8PnB9o+aZf
+5s5L9Z32bDNfVYhRF6iBcS8grNCfEz5BO+qfKpz/TzBz4385kVAFYyYGr3oAPLu
ggvtZeDLZfR4Chw4vjDCxM1y35yBrz2/1penSadVqf+hBQKMZ5hCYAyN0Au2lgiN
HNdWtuuBaN8WeZYFmX1v
=4Kvz
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
