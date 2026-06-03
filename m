Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1063B3891;
	Wed,  3 Jun 2026 12:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780488526; cv=none; b=eaB6VwZH0nmXCqAp13JcnFsb3sAHURwegFjYgVtXu8GdEVeVu4Py0d+eBeKNBQdUJa4mHOTfEC7cNTe+8nWPOxtyhjnTjW1WDSz8pEXYboRyuToSjLUDxtxQpYOJPE1rh3F4CKXLS5RNS0Hyu5bweZg8r5SbrWboq0xlF4R2rZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780488526; c=relaxed/simple;
	bh=+Z3LJbqMdB1/pubFkCbyOzArzx4j7FsU+htL71UYJTY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i1TFg5TS7jPq+zYh1aO5nKxqn9GerReAGgemZ5nMS1X1E/oVA+4nSOB3PN52SlaG8d2E1n6ZPuor8e1Svl9xv+3ve3zKDxHdJBfIm6pQ9e7ZuSmHBV8mkcu7AsGzirr/otcWNP39gR65qDqQ5GFXVqvuvpcZdMN57ZdVnh7VxgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YuFv3aeo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YuFv3aeo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1A0C1F00893;
	Wed,  3 Jun 2026 12:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780488524;
	bh=B96vpYrwUCDd8STmPrmAJlLy99SdCRv4DLQWSqvzipU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YuFv3aeonbCNwOXlRwKdtmsQrCDOWKwvMEJ1EH/vxR12FEYIMnot2aHb1FW6y97gX
	 0QIUpIPrBIfXvg1e4uNy5kX15Gm2gPuvdG2nBxt0QWAvL2OjL2b+esaI21O1kpMGdH
	 b2jCN5YBVvVXMinKOlhCaKbEXB5JbTe0k+9rCvAvCcBi8ufE7kqmnOYK4fXHsiSkXz
	 UJBquLz7rZOrLjbPhs4+O3/dEgKeUqLoPu1FNCfyr5jGf8Zz3HJBsdP0zgSADBu1eU
	 kBhsYkrl0R40SQ1WPIqyMttixJcQWbcI5F9tRzsa/6mCBQhYft+uYjrAtXyLpNgZoc
	 KC8b580OgSOaQ==
Date: Wed, 3 Jun 2026 13:08:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: rodrigo.alencar@analog.com, Michael Auchter <michael.auchter@ni.com>,
 linux@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, Michael
 Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook
 <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH 06/12] iio: dac: ad5686: consume optional reset signal
Message-ID: <20260603130833.007c1526@jic23-huawei>
In-Reply-To: <ah_k9A9535Vz6PCw@nsa>
References: <20260602-ad5686-new-features-v1-0-691e01883d27@analog.com>
	<20260602-ad5686-new-features-v1-6-691e01883d27@analog.com>
	<ah_k9A9535Vz6PCw@nsa>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 3 Jun 2026 09:28:26 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Tue, Jun 02, 2026 at 05:33:53PM +0100, Rodrigo Alencar via B4 Relay wr=
ote:
> > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> >=20
> > Add RESET pin GPIO support through an optional reset control, which is
> > local to the probe function. Also, include delays for power-up time and
> > reset pulse width.
> >=20
> > Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > ---
> >  drivers/iio/dac/ad5686.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >=20
> > diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
> > index 4a8c587ff116..345ca2436332 100644
> > --- a/drivers/iio/dac/ad5686.c
> > +++ b/drivers/iio/dac/ad5686.c
> > @@ -8,12 +8,14 @@
> >  #include <linux/array_size.h>
> >  #include <linux/bitfield.h>
> >  #include <linux/bitops.h>
> > +#include <linux/delay.h>
> >  #include <linux/dev_printk.h>
> >  #include <linux/errno.h>
> >  #include <linux/export.h>
> >  #include <linux/kstrtox.h>
> >  #include <linux/module.h>
> >  #include <linux/regulator/consumer.h>
> > +#include <linux/reset.h>
> >  #include <linux/sysfs.h>
> >  #include <linux/wordpart.h>
> > =20
> > @@ -471,6 +473,7 @@ int ad5686_probe(struct device *dev,
> >  		 const struct ad5686_chip_info *chip_info,
> >  		 const char *name, const struct ad5686_bus_ops *ops)
> >  {
> > +	struct reset_control *rstc;
> >  	struct ad5686_state *st;
> >  	struct iio_dev *indio_dev;
> >  	int ret, i;
> > @@ -506,6 +509,16 @@ int ad5686_probe(struct device *dev,
> >  		return dev_err_probe(dev, -EINVAL,
> >  				     "invalid or not provided vref voltage\n");
> > =20
> > +	rstc =3D devm_reset_control_get_optional_exclusive(dev, NULL);
> > +	if (IS_ERR(rstc))
> > +		return dev_err_probe(dev, PTR_ERR(rstc),
> > +				     "Failed to get reset control\n"); =20
>=20
> On top of what Andy stated, I'm fairly sure
> devm_reset_control_get_optional_exclusive() returns with the GPIO
> asserted.

We've been getting reports on that not being the case from Sashiko
and when I last looked into one of those it definitely isn't documented
as doing so and I got the impression it is a reset controller specific
thing.  Do we are fine here because the gpio reset controller reset_gpio_pr=
obe()
includes:
	priv->reset =3D devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
	if (IS_ERR(priv->reset))
		return dev_err_probe(dev, PTR_ERR(priv->reset),
				     "Could not get reset gpios\n");
Which I guess puts it in to reset?

So do we assume gpio reset or not for this sort of driver that specifies
in the binding reset-gpios. Now if the following is implying we need
a deasserted to asserted transition (maybe?) then we'd need to force
a deassert first.

Btw I used claude to explore this and it hallucinated the reverse polarity
providing otherwise correct code for what was in reset_gpio_probe() but
oddly editing that one line.  I was being lazy and using the web UI rather
than a version with access to my git tree so maybe it scraped some
buggy code from a downstream tree.  Anyhow watch out for subtle garbage!
It also took a few requests to get it to figure out the logical nature
of the GPIO signals rather than assuming they were controlling whether
the line was high or low directly.

Jonathan


>=20
> > +
> > +	udelay(5); /* power-up time */
> > +	reset_control_assert(rstc);
> > +	udelay(1); /* reset pulse: comfortably bigger than the spec */
> > +	reset_control_deassert(rstc);
> > +
> >  	/* Initialize masks to all ones */
> >  	st->pwr_down_mask =3D ~0;
> >  	st->pwr_down_mode =3D ~0;
> >=20
> > --=20
> > 2.43.0
> >=20
> >  =20

