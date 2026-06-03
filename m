Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF211A0BF1
	for <linux-iio@vger.kernel.org>; Wed,  3 Jun 2026 12:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780491439; cv=none; b=kzjQx3W52RXQxqfJ8jjNfhKdN6Xj26CoZlPFarUYt8IFOknBpd/VpildYU/ZS+y7U6b8g1RT8dh9cYJwXcsYIev2Es41oc6no5Kq99lTAdly3IAN/w6rp5NSXJ/F3Gvt4KWwHg5svo2TbcOIsBNSIkU3dLfXJeiDu9XEHlVx8Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780491439; c=relaxed/simple;
	bh=pHsMjf9jOADay95AmSheayfTht4Ho2nDz85KLsw11og=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sh/uHV1wYE3LKiSGbq4s9tw3xD7sRPb6IqWVW0llYqEj+kx9aNuqxs/C2ootI039bbRia9d5UnD7xxnm6Ar2isyHlvdnjKAPd7NTPKXt8YU4yiwz7UrtFkMafs9J1KBjLZMAVos9kQI2ondYkXVb/GREhh2v5pP3S4OUVtaloRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1wUl9n-0005og-Nv; Wed, 03 Jun 2026 14:57:15 +0200
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1wUl9m-000uml-2B;
	Wed, 03 Jun 2026 14:57:14 +0200
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1wUl9m-000000009Wj-2PbL;
	Wed, 03 Jun 2026 14:57:14 +0200
Message-ID: <b21934ee7bc0b588a7a07a8bad93f2792a61df38.camel@pengutronix.de>
Subject: Re: [PATCH 06/12] iio: dac: ad5686: consume optional reset signal
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Jonathan Cameron <jic23@kernel.org>, Nuno =?ISO-8859-1?Q?S=E1?=
	 <noname.nuno@gmail.com>
Cc: rodrigo.alencar@analog.com, Michael Auchter <michael.auchter@ni.com>, 
	linux@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, Michael
 Hennerich	 <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor Dooley
 <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>
Date: Wed, 03 Jun 2026 14:57:14 +0200
In-Reply-To: <20260603130833.007c1526@jic23-huawei>
References: <20260602-ad5686-new-features-v1-0-691e01883d27@analog.com>
		<20260602-ad5686-new-features-v1-6-691e01883d27@analog.com>
		<ah_k9A9535Vz6PCw@nsa> <20260603130833.007c1526@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org

On Mi, 2026-06-03 at 13:08 +0100, Jonathan Cameron wrote:
> On Wed, 3 Jun 2026 09:28:26 +0100
> Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
>=20
> > On Tue, Jun 02, 2026 at 05:33:53PM +0100, Rodrigo Alencar via B4 Relay =
wrote:
> > > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > >=20
> > > Add RESET pin GPIO support through an optional reset control, which i=
s
> > > local to the probe function. Also, include delays for power-up time a=
nd
> > > reset pulse width.
> > >=20
> > > Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > > ---
> > >  drivers/iio/dac/ad5686.c | 13 +++++++++++++
> > >  1 file changed, 13 insertions(+)
> > >=20
> > > diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
> > > index 4a8c587ff116..345ca2436332 100644
> > > --- a/drivers/iio/dac/ad5686.c
> > > +++ b/drivers/iio/dac/ad5686.c
> > > @@ -8,12 +8,14 @@
> > >  #include <linux/array_size.h>
> > >  #include <linux/bitfield.h>
> > >  #include <linux/bitops.h>
> > > +#include <linux/delay.h>
> > >  #include <linux/dev_printk.h>
> > >  #include <linux/errno.h>
> > >  #include <linux/export.h>
> > >  #include <linux/kstrtox.h>
> > >  #include <linux/module.h>
> > >  #include <linux/regulator/consumer.h>
> > > +#include <linux/reset.h>
> > >  #include <linux/sysfs.h>
> > >  #include <linux/wordpart.h>
> > > =20
> > > @@ -471,6 +473,7 @@ int ad5686_probe(struct device *dev,
> > >  		 const struct ad5686_chip_info *chip_info,
> > >  		 const char *name, const struct ad5686_bus_ops *ops)
> > >  {
> > > +	struct reset_control *rstc;
> > >  	struct ad5686_state *st;
> > >  	struct iio_dev *indio_dev;
> > >  	int ret, i;
> > > @@ -506,6 +509,16 @@ int ad5686_probe(struct device *dev,
> > >  		return dev_err_probe(dev, -EINVAL,
> > >  				     "invalid or not provided vref voltage\n");
> > > =20
> > > +	rstc =3D devm_reset_control_get_optional_exclusive(dev, NULL);
> > > +	if (IS_ERR(rstc))
> > > +		return dev_err_probe(dev, PTR_ERR(rstc),
> > > +				     "Failed to get reset control\n"); =20
> >=20
> > On top of what Andy stated, I'm fairly sure
> > devm_reset_control_get_optional_exclusive() returns with the GPIO
> > asserted.
>=20
> We've been getting reports on that not being the case from Sashiko
> and when I last looked into one of those it definitely isn't documented
> as doing so and I got the impression it is a reset controller specific
> thing.

The reset controller API does not prescribe that freshly acquired
resets start in asserted state, because that isn't possible for self-
clearing resets.

If the chip needs to see the deasserted -> asserted flank, the driver
should start with a deassert.

> Do we are fine here because the gpio reset controller reset_gpio_probe()
> includes:
> 	priv->reset =3D devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
> 	if (IS_ERR(priv->reset))
> 		return dev_err_probe(dev, PTR_ERR(priv->reset),
> 				     "Could not get reset gpios\n");
> Which I guess puts it in to reset?

Yes. I would like consumer drivers to not rely on implicit knowledge
about the reset controller driver, though.

> So do we assume gpio reset or not for this sort of driver that specifies
> in the binding reset-gpios. Now if the following is implying we need
> a deasserted to asserted transition (maybe?) then we'd need to force
> a deassert first.

Iff the transition is necessary, explicitly deassert-then-assert.


regards
Philipp
