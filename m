Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:43440 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753014AbcGSMlE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 19 Jul 2016 08:41:04 -0400
Date: Tue, 19 Jul 2016 14:40:51 +0200
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
Message-ID: <20160719124051.GB4107@lukather>
References: <1468576754-3273-1-git-send-email-quentin.schulz@free-electrons.com>
 <1468576754-3273-3-git-send-email-quentin.schulz@free-electrons.com>
 <20160718125753.GF4199@lukather>
 <578DED17.7040309@free-electrons.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Pk6IbRAofICFmK5e"
In-Reply-To: <578DED17.7040309@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--Pk6IbRAofICFmK5e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 19, 2016 at 11:04:23AM +0200, Quentin Schulz wrote:
> >> +/* TP_CTRL1 bits */
> >> +#define SUNXI_GPADC_STYLUS_UP_DEBOUNCE(x)	((x) << 12) /* 8 bits */
> >> +#define SUNXI_GPADC_STYLUS_UP_DEBOUNCE_EN	BIT(9)
> >> +#define SUNXI_GPADC_TOUCH_PAN_CALI_EN		BIT(6)
> >> +#define SUNXI_GPADC_TP_DUAL_EN			BIT(5)
> >> +#define SUNXI_GPADC_TP_MODE_EN			BIT(4)
> >> +#define SUNXI_GPADC_TP_ADC_SELECT		BIT(3)
> >> +#define SUNXI_GPADC_ADC_CHAN_SELECT(x)		((x) << 0)  /* 3 bits */
> >=20
> > Usually the comments are on the line above. However, if you really
> > want to enforce something, you should rather mask the
> > value. Otherwise, that comment is pretty useless.
> >=20
>=20
> Do you mean something like that:
> #define SUNXI_GPADC_ADC_CHAN_SELECT(x)		(GENMASK(2,0) & x) ?

Yes.

> >> +/* TP_CTRL1 bits for sun6i SOCs */
> >> +#define SUNXI_GPADC_SUN6I_TOUCH_PAN_CALI_EN	BIT(7)
> >> +#define SUNXI_GPADC_SUN6I_TP_DUAL_EN		BIT(6)
> >> +#define SUNXI_GPADC_SUN6I_TP_MODE_EN		BIT(5)
> >> +#define SUNXI_GPADC_SUN6I_TP_ADC_SELECT		BIT(4)
> >=20
> > Shouldn't that go in either a common define or the touchscreen driver?
> >=20
>=20
> Then shouldn't I put all defines in a common header? (sunxi-gpadc-mfd.h)

You should :)

> >> +	irq =3D regmap_irq_get_virq(sunxi_gpadc_mfd_dev->regmap_irqc, irq);
> >> +	ret =3D devm_request_any_context_irq(&pdev->dev, irq,
> >> +					   sunxi_gpadc_fifo_data_irq_handler,
> >> +					   0, "fifo_data", info);
> >> +	if (ret < 0) {
> >> +		dev_err(&pdev->dev,
> >> +			"could not request FIFO_DATA_PENDING interrupt: %d\n",
> >> +			ret);
> >> +		goto err;
> >> +	}
> >> +
> >> +	info->fifo_data_irq =3D irq;
> >> +	disable_irq(irq);
> >=20
> > request_irq starts with irq enabled, which means that you can have an
> > interrupt showing up between your call to request_irq and the
> > disable_irq.=20
> >=20
> > How would that work?
> >=20
>=20
> Same as what I answered in Jonathan's mail:
>=20
> "Once the interrupt is activated, the IP performs continuous conversions
> (temp_data_irq only periodically). I want these interrupts to be enabled
> only when I read the sysfs file or we get useless interrupts.
> In the current state of this driver's irq handlers, I only set values in
> structures and all the needed structures are already initialized before
> requesting irqs. So it does not look like a race. I can prevent races in
> future versions by adding an atomic flag if wanted."

Then please have a nice comment explaining that.

> >> +static struct platform_driver sunxi_gpadc_driver =3D {
> >> +	.driver =3D {
> >> +		.name =3D "sunxi-gpadc-iio",
> >> +	},
> >> +	.id_table =3D sunxi_gpadc_id,
> >> +	.probe =3D sunxi_gpadc_probe,
> >> +	.remove =3D sunxi_gpadc_remove,
> >> +};
> >=20
> > Having some runtime_pm support for this would be great too.
> >=20
>=20
> Basically disabling the ADC and interrupts (as in the remove) in
> _suspend and _idle and reenabling everything in "before _suspend"-state
> in _resume I guess?

Well, yes and no. Your probe would not do any hardware
initialisation. You can pm_runtime_get_sync before using it, which
will call the suspend hook.

Once you're done, call pm_runtime_put, and that will disable the
hardware.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--Pk6IbRAofICFmK5e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXjh/TAAoJEBx+YmzsjxAg/AMP/AsUHN5QCY7KKED59C4A+Mum
O7VCTwHr7lGwcmbMYZ1k76GlwJMYDi/u3F1Or+iRYBefptmDsSH1Mxob/18lsmtS
BqMyhkID6raPrj/xof7I4dEsMP6uELPAdPdcK9GwftCnnm/YluTAAwbYH/vCNDx+
FeDaFS3OkvSwP+TwcyYywFX4oRoGNjPCq6l4OeZkYfBWJHIf3nVqfxRIO9wDHiWf
lsG4CLokcw4AmTLSxVRm6MbdsEWP7cM70wrhzbx56mjXrQt8inaokhmKqIJC3mkL
sBVyrcL79CPpAQ6RZkSBDdNESCaAtX8JvwkVybRO3hn0RRqPZP7cM0Hhv2pVJiBF
0uOQZAQcFdxcG1aMxbxJEc1BbjS0/t/lCOJ5La3RsI4ObNHY/koOV5ds1JfKmDMv
jL+BKX+uyVC6stsMIDN8A4fDf+WrKSC6rsMe/s+HKY3QK2+CK9/pKKryEwBzx9Xw
Qdh8FfKJ7ME285S0vEOP9UJDR4vJV4yrLvVoPzAA0dD4brqbpLK2FKNboJVs8H9S
VgjNwgAKyKKveccofx8QgCk80qVUpxlXfHnkYobC1nejP8G9f2yteGh2vzBvasdt
rx4sS3/RUENTrh85YpmBlh3lcfQ+SCgl1tstfdgPf3/+KPXhBslcAFWKagWdejlh
Kdj0+5rBhSzhZw4jtV64
=N6AD
-----END PGP SIGNATURE-----

--Pk6IbRAofICFmK5e--
