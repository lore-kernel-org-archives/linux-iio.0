Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46305 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754501AbbA3IQn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 30 Jan 2015 03:16:43 -0500
Date: Fri, 30 Jan 2015 09:16:31 +0100
From: Markus Pargmann <mpa@pengutronix.de>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: Shawn Guo <shawn.guo@linaro.org>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Denis Carikli <denis@eukrea.com>,
	Eric =?utf-8?Q?B=C3=A9nard?= <eric@eukrea.com>,
	Sascha Hauer <kernel@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org,
	Lee Jones <lee.jones@linaro.org>, linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>
Subject: Re: [PATCH v6 5/8] iio: adc: fsl,imx25-gcq driver
Message-ID: <20150130081631.GF16879@pengutronix.de>
References: <1422540556-14828-1-git-send-email-mpa@pengutronix.de>
 <1422540556-14828-6-git-send-email-mpa@pengutronix.de>
 <54CA4419.1060207@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dgjlcl3Tl+kb3YDk"
In-Reply-To: <54CA4419.1060207@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--dgjlcl3Tl+kb3YDk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jan 29, 2015 at 08:00:49PM +0530, Varka Bhadram wrote:
> Hi,
>=20
> On Thursday 29 January 2015 07:39 PM, Markus Pargmann wrote:
> >This is a conversion queue driver for the mx25 SoC. It uses the central
> >ADC which is used by two seperate independent queues. This driver
> >prepares different conversion configurations for each possible input.
> >For a conversion it creates a conversionqueue of one item with the
> >correct configuration for the chosen channel. It then executes the queue
> >once and disables the conversion queue afterwards.
> >
> >The reference voltages are configurable through devicetree subnodes,
> >depending on the connections of the ADC inputs.
> >
> >Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> >Signed-off-by: Denis Carikli <denis@eukrea.com>
> >Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> >---
> >  drivers/iio/adc/Kconfig                     |   7 +
> >  drivers/iio/adc/Makefile                    |   1 +
> >  drivers/iio/adc/fsl-imx25-gcq.c             | 361 ++++++++++++++++++++=
++++++++
> >  include/dt-bindings/iio/adc/fsl-imx25-gcq.h |  18 ++
> >  4 files changed, 387 insertions(+)
> >  create mode 100644 drivers/iio/adc/fsl-imx25-gcq.c
> >  create mode 100644 include/dt-bindings/iio/adc/fsl-imx25-gcq.h
> >
> (...)
>=20
> >+static int mx25_gcq_probe(struct platform_device *pdev)
> >+{
> >+	struct iio_dev *indio_dev;
> >+	struct mx25_gcq_priv *priv;
> >+	struct mx25_tsadc *tsadc =3D dev_get_drvdata(pdev->dev.parent);
> >+	struct device *dev =3D &pdev->dev;
> >+	struct resource *res;
> >+	void __iomem *mem;
> >+	int ret;
> >+
> >+	indio_dev =3D devm_iio_device_alloc(&pdev->dev, sizeof(*priv));
> >+	if (!indio_dev)
> >+		return -ENOMEM;
> >+
> >+	priv =3D iio_priv(indio_dev);
> >+
> >+	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >+	mem =3D devm_ioremap_resource(dev, res);
> >+	if (!mem)
> >+		return -ENOMEM;
> >+
> >+	priv->regs =3D devm_regmap_init_mmio(dev, mem, &mx25_gcq_regconfig);
> >+	if (IS_ERR(priv->regs)) {
> >+		dev_err(dev, "Failed to initialize regmap\n");
> >+		return PTR_ERR(priv->regs);
> >+	}
> >+
> >+	init_completion(&priv->completed);
> >+
> >+	/* Optional external regulator */
> >+	priv->ext_vref =3D devm_regulator_get(&pdev->dev, "vref");
> >+	if (!IS_ERR_OR_NULL(priv->ext_vref)) {
> >+		ret =3D regulator_enable(priv->ext_vref);
> >+		if (ret)
> >+			return ret;
> >+	}
> >+
> >+	ret =3D mx25_gcq_setup_cfgs(pdev, priv);
> >+	if (ret)
> >+		return ret;
> >+
> >+	priv->clk =3D tsadc->clk;
> >+	ret =3D clk_prepare_enable(priv->clk);
> >+	if (ret) {
> >+		dev_err(dev, "Failed to enable clock\n");
> >+		return ret;
> >+	}
> >+
> >+	priv->irq =3D platform_get_irq(pdev, 0);
> >+	if (priv->irq <=3D 0) {
> >+		dev_err(dev, "Failed to get IRQ\n");
> >+		ret =3D priv->irq;
> >+		goto err_clk_unprepare;
> >+	}
> >+
> >+	ret =3D request_irq(priv->irq, mx25_gcq_irq, 0, pdev->name, priv);
>=20
> Use of devm_* API

It seems to be save to use it here, as the interrupt handler only uses
memory allocated for this driver and not the iio framework. So I will
probably change it to devm_*.

Thanks,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--dgjlcl3Tl+kb3YDk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUyz3fAAoJEEpcgKtcEGQQOhwP/iUvNY075UxoKFeuqY84AEdP
gnIiyKxkTumeD0VGwkUs3CwkBT3LlfxQPId4ag+tw5K7W8L1hgaDIP4STlNEqfFZ
iDmn4tNz85l9oR6ucj+yhs0zNFZmZ89dKeRAht3tmNNMjYGYG0TaLHwbRfv/NwMz
Mxm+VB4Z0GlJ5EzmPTGfwsxOrOuHHp+eU/tkfxTjMYOYUSyAOJCE9BjatFkoPY4o
RSOaTS1DvKLPS3z4e1tZXLbQ52+ZuSIz1DrJ0+CMCEphE2qADXp244x3gQY6ZF27
MaP1AkLUNYTS+u3/othPADIqe80af99pKBcYmcrpaz2I22qE/XkKNVDAWt+G2gXj
eHzC79WtJshDhqrqyG39hHnqrqKK3fNaIZFL6IctlmRFGNqqodHxrBZR32pZGGVx
VWcYkjdqmFpelgqw6t6LpOsqoueNRpGt5erJB/L0LuNZ8YWW/3wSoT44kVWwxVXU
3DRK2y81EPWl8jXysUBlM+cN2bJrxjHvIjOcXnGWGIgmC7VUfUnDs5DqlY2x87wW
T1dANGEIaARBuQgb4m1r7mlTzZf1SppcjGrLQkglKxOAeDf2luFd49+x3MZleSf/
jfmQcdR8YDqshF/y+Mp0ocBFeh01GXXU8JTa+7LkqVyZjyqExO+7gWdR7c3t7pHN
uh9vP82uE26sMVub6X50
=lqIy
-----END PGP SIGNATURE-----

--dgjlcl3Tl+kb3YDk--
