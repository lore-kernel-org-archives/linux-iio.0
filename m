Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F5B411A1C;
	Fri,  4 Sep 2026 18:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788548107; cv=none; b=NfPngyZjKp2n9yLQcQWDeqTPWUzrNGtK7elWGb8x3H1WPi+GGcO2haRV2K6DKDG3WJiQw3U0jEhtn8y+tgqQqxgnMhWEbhNRWX/rk+Qu9UyRg0XINAMVozWhe7BtLs1wxdEfPBCVFqaLqsKujPzj79KXdpWRy53oUFlIb4/6bTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788548107; c=relaxed/simple;
	bh=YjE58b0ZQoCsKs3WbBeJHJ5kI3Nan8my01/Dme4uBIg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r+FCIbAQHkKaZKDYffVtroLuyWQw0JaLzSluH+XwODqWKJhqVgIiPOSVHMuA7rz2ytwkn1OFjF7H0y4BODCydcdTZY0wmHEWpFLJyPU1scuilvx3rB+MJaEglQJ582AiXU74OLr4OuMDvcRe3SJEe/F+hlKWoZXbrrrLgkRCUo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cbD6OZg5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cbD6OZg5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E4271F00A3D;
	Fri,  4 Sep 2026 18:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788548105;
	bh=nFbGTsXI67KgKHCEe+rbAoubPtZFCm8gC57qcqknLEU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=cbD6OZg5gbHrVfAIRpkYsrXZhEIM7y63VxcBd7JxgiKyoeCoLYRo44W6NhJKQ/3Ai
	 icAdPmuBVU4h8b7QHe8zJ0UFvN7pxC7MGO5ccG9w8j7yWcuZ8KfVBeH9NopDuZWYQv
	 UKqniwOMIv+RXdRtaIsHIX1n7faaSOGI5pxmRDDUM5vGP0xFdXQpe21BmpWT8e5h7Y
	 k6qP5CNiRJl47tXVpO2GNlt+ypPnuCHbTIE1YmqtyyC3ZJaY/4iZMTqEbWy37ISEM7
	 zbSSg3iJC7c5kUEsvfREmfoWuoednUbtXsrbmwxZscarOhEeD6CWWgtyE/7rf4QeZY
	 XTMjzJ5ak8uzw==
Date: Fri, 4 Sep 2026 19:54:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
Cc: "Schmitt, Marcelo" <Marcelo.Schmitt@analog.com>, "Sa, Nuno"
 <Nuno.Sa@analog.com>, "Hennerich, Michael" <Michael.Hennerich@analog.com>,
 David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, linux <linux@analog.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 4/4] iio: accel: adxl367: add support for INT2
 interrupt pin
Message-ID: <20260904195459.536526cf@jic23-huawei>
In-Reply-To: <CY2PR03MB64993393CCFED1EB17231DC6B69BB52@CY2PR03MB649933.namprd03.prod.outlook.com>
References: <20260831083122.3486-1-antoniu.miclaus@analog.com>
	<20260831083122.3486-5-antoniu.miclaus@analog.com>
	<178828084760.2788519.15283878760227392025.b4-review@b4>
	<CY2PR03MB64993393CCFED1EB17231DC6B69BB52@CY2PR03MB649933.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 4 Sep 2026 09:14:53 +0000
"Miclaus, Antoniu" <Antoniu.Miclaus@analog.com> wrote:

> --
> Antoniu Micl=C4=83u=C5=9F
>=20
> > -----Original Message-----
> > From: Jonathan Cameron <jic23@kernel.org>
> > Sent: Tuesday, September 1, 2026 7:41 PM
> > To: Miclaus, Antoniu <Antoniu.Miclaus@analog.com>
> > Cc: Schmitt, Marcelo <Marcelo.Schmitt@analog.com>; Sa, Nuno
> > <Nuno.Sa@analog.com>; Hennerich, Michael
> > <Michael.Hennerich@analog.com>; Jonathan Cameron <jic23@kernel.org>;
> > David Lechner <dlechner@baylibre.com>; Rob Herring <robh@kernel.org>;
> > Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley
> > <conor+dt@kernel.org>; linux-iio@vger.kernel.org; linux <linux@analog.c=
om>;
> > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v4 4/4] iio: accel: adxl367: add support for INT2 i=
nterrupt
> > pin
> >  =20
> > > The ADXL367 provides two independent interrupt output pins, INT1 and
> > > INT2, each with its own event mapping register (INTMAP1_LOWER at 0x2A
> > > and INTMAP2_LOWER at 0x2B) sharing an identical bit layout. Until now
> > > the driver hardcoded INT1 for all interrupt mappings, so a board that
> > > routes only INT2 to the host could never receive activity, inactivity
> > > or FIFO watermark interrupts.
> > >
> > > Determine the connected pin from the interrupt-names device tree
> > > property using fwnode_irq_get_byname(), and route the interrupt
> > > mappings to the matching register. Use the interrupt number returned =
by
> > > the lookup for devm_request_threaded_irq() so the requested line alwa=
ys
> > > matches the routed INTMAP register, regardless of the order in which =
the
> > > interrupts are listed. When no interrupt-names are present, default to
> > > INT1 and the bus-provided interrupt to preserve the existing behaviou=
r.
> > >
> > > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > > =20
> >=20
> > One follow on thing to look at via sashiko.
> >=20
> > Otherwise, this looks good to me, but given the active discussion on pr=
evious
> > version I'm not going to pick this up until plenty of time has passed
> > or tags have been given. =20
>=20
> Ok, I will send a new version addressing also the sashiko issue in a foll=
ow up patch.

No need for a new version of these - I'll pick them up now.  Just send a new
patch on top.  That might break sashiko though, so you could send these + t=
he
new patch as new version - just stick 'applied' or something like that in t=
he patch
titles so no one spends time reviewing them.

Applied to the testing branch of iio.git

Thanks,

Jonathan

>=20
> >  =20
> > > diff --git a/drivers/iio/accel/adxl367.c b/drivers/iio/accel/adxl367.c
> > > index b4e8dc6d6a5c..9b47e66c49ea 100644
> > > --- a/drivers/iio/accel/adxl367.c
> > > +++ b/drivers/iio/accel/adxl367.c =20
> >  =20
> > > @@ -1430,6 +1434,36 @@ static int adxl367_setup(struct adxl367_state =
=20
> > *st) =20
> > >  	return adxl367_set_measure_en(st, true);
> > >  }
> > >
> > > +static int adxl367_set_int_map_reg(struct adxl367_state *st, int irq)
> > > +{
> > > +	int ret;
> > > +
> > > +	/*
> > > +	 * Route the mappings to whichever of INT1/INT2 is named in the
> > > +	 * interrupt-names property. -EINVAL (property absent) and - =20
> > ENODATA =20
> > > +	 * (name not listed) are not errors; anything else is.
> > > +	 */
> > > +	ret =3D fwnode_irq_get_byname(dev_fwnode(st->dev), "INT1");
> > > +	if (ret > 0) {
> > > +		st->int_map_reg =3D ADXL367_REG_INT1_MAP;
> > > +		return ret;
> > > +	}
> > > +	if (ret !=3D -ENODATA && ret !=3D -EINVAL)
> > > +		return ret;
> > > +
> > > +	ret =3D fwnode_irq_get_byname(dev_fwnode(st->dev), "INT2");
> > > +	if (ret > 0) {
> > > +		st->int_map_reg =3D ADXL367_REG_INT2_MAP;
> > > +		return ret;
> > > +	}
> > > +	if (ret !=3D -ENODATA && ret !=3D -EINVAL)
> > > +		return ret;
> > > +
> > > +	/* No INT1/INT2 named: default to INT1 and the bus interrupt. */
> > > +	st->int_map_reg =3D ADXL367_REG_INT1_MAP;
> > > +	return irq; =20
> >=20
> > I'd like to explore the helper idea for this, but it can be a separate
> > series when someone has the time.
> >  =20
> > > +}
> > > +
> > >  int adxl367_probe(struct device *dev, const struct adxl367_ops *ops,
> > >  		  void *context, struct regmap *regmap, int irq)
> > >  {
> > > @@ -1486,6 +1520,11 @@ int adxl367_probe(struct device *dev, const =20
> > struct adxl367_ops *ops, =20
> > >  	if (ret)
> > >  		return ret;
> > > =20
> >=20
> > [Severity: Medium]
> > Since fwnode_irq_get_byname() inside adxl367_set_int_map_reg() can retu=
rn
> > -EPROBE_DEFER if the interrupt controller is not yet ready, will placin=
g this
> > lookup after adxl367_setup() cause repeated boot delays and leave the d=
evice
> > powered up on deferral?
> >=20
> > Looking at adxl367_probe(), it resets the hardware, sleeps for 15ms, an=
d calls
> > adxl367_setup() which powers up the device into measurement mode.
> >=20
> > If adxl367_set_int_map_reg() then returns -EPROBE_DEFER, the probe abor=
ts
> > without an error cleanup path to power down the device.
> >=20
> > Could this software resource acquisition be performed before the hardwa=
re
> > interaction to avoid unnecessary boot stalls and power leaks during pro=
be
> > deferral?
> >=20
> > -
> >=20
> > This obviously isn't new, but it might make sense to turn the device
> > off at least.
> >=20
> > Can be a follow up patch.
> >=20
> > --
> > Jonathan Cameron <jonathan.cameron@oss.qualcomm.com> =20

