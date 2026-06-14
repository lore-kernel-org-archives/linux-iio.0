Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4D13090D9;
	Sun, 14 Jun 2026 17:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781458414; cv=none; b=BMb/zERUVpvD/+BsskhYy00sDWL3aTrr8X3gSWggdYiUz0QK8Gi7c81iv9DL4hnIbEqhmiSbFB5JqFOjMUyJB92ZTx/7ApgIS5OZW84+Mr984W0EDg6c/9Z2iLamts01WWGWbI+uhdUvxgFHT8vSJyOXvnV2N1zsc7oo/ofL6DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781458414; c=relaxed/simple;
	bh=Ejr4LuwCLJRkdyjrZcsQOgULx+WdNLApkAb0G1G9tiM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jOrzLE7PiieY7Vgp33IIZiHADTeEOfF5HjL3XgoZea/UJXz5eVY8kbkEvXo2ehpYLenQj2m4R/ovtdfWH/OV+Y9PYGvrD3A3wP+U6wyR1J/rUZzpdEXajs6szEC1sloleiWUbFKmDFOPuHTRQwuP6jyg/yIljHVt0BH/GtruM9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WA6mEgRs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WA6mEgRs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 242141F000E9;
	Sun, 14 Jun 2026 17:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781458413;
	bh=H36ZdTXYcL5jG6aCubkRrWkVsZoLgIJaC2aIa5YdpdE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WA6mEgRsHKu/WUT9d6EePxnOUMZRkUJ7z2U+zT7MlOxw4FV4Ev7gLsouiIceiZ2JA
	 S83OKmvh1p0DFNC1LYlAJt/+zoCVqguEFK5i01nKPg/NaD7rEolWOTM0eNtmSlj1Hn
	 mMwe1KGYDunrMKmrZ900I0iAEv+JIfZ5kQHPeFbLyt2BdfKv8iz/lTDrujKwfICga2
	 xui7SM9nqLnvc7IEulCLc+lw9dUxFjjVu9qPnKwUI+0jn5Vy9rYC7Hlg7Y/rf2z7pZ
	 m81hrY6Vb/p35UfZzT4/1bMNbHig1nJV5m85VTYYUEQuFP71hICrgBaHxKH+Q2EacH
	 h410D5bBrfKFA==
Date: Sun, 14 Jun 2026 18:33:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: rodrigo.alencar@analog.com, Michael Auchter <michael.auchter@ni.com>,
 linux@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, Michael
 Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook
 <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v2 06/12] iio: dac: ad5686: consume optional reset
 signal
Message-ID: <20260614183322.61e05109@jic23-huawei>
In-Reply-To: <ltafhuqwbdnj7qadn2p5f7exwcpz4fvr5jaizj7q4peqgt2x4b@z23ss3usjskv>
References: <20260609-ad5686-new-features-v2-0-70b423f5c76d@analog.com>
	<20260609-ad5686-new-features-v2-6-70b423f5c76d@analog.com>
	<ltafhuqwbdnj7qadn2p5f7exwcpz4fvr5jaizj7q4peqgt2x4b@z23ss3usjskv>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 9 Jun 2026 12:17:01 +0100
Rodrigo Alencar <455.rodrigo.alencar@gmail.com> wrote:

> On 09/06/26 10:29, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential is=
sue(s) to consider:
> > - [Medium] Premature reset line deassertion during power ramp-up due to=
 the use of '_deasserted' combined with a manual pulse.
> > --
> >=20
> > commit 61717352bc99739a9f89195c3320a934e033ad38
> > Author: Rodrigo Alencar <rodrigo.alencar@analog.com>
> >=20
> > iio: dac: ad5686: consume optional reset signal
> >=20
> > Add RESET pin GPIO support through an optional reset control, which is =
local
> > to the probe function, and include a delay for the required reset pulse=
 width.
> >  =20
> > > diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
> > > index fc3863274b291..700798b80f044 100644
> > > --- a/drivers/iio/dac/ad5686.c
> > > +++ b/drivers/iio/dac/ad5686.c =20
> > [ ... ] =20
> > > @@ -506,7 +508,15 @@ int ad5686_probe(struct device *dev,
> > >  		return dev_err_probe(dev, -EINVAL,
> > >  				     "invalid or not provided vref voltage\n");
> > > =20
> > > +	rstc =3D devm_reset_control_get_optional_exclusive_deasserted(dev, =
NULL); =20
> >=20
> > [Severity: Medium]
> > Does this prematurely deassert the reset line during power ramp-up?
> >=20
> > Because devm_reset_control_get_optional_exclusive_deasserted() automati=
cally
> > and immediately deasserts the reset line upon acquisition, the reset li=
ne is
> > driven high while the power supply is still stabilizing, before the 5 us
> > power-up delay has elapsed.
> >=20
> > This creates an unwanted rising edge on the reset pin during power ramp=
-up,
> > which could cause the device to enter an unknown state or latch up.
> >=20
> > Should this use devm_reset_control_get_optional_exclusive() instead, wh=
ich
> > does not modify the line state during acquisition, allowing the manual =
toggle
> > sequence below to safely reset the device after power is stable? =20
>=20
> It has been discussed that it is better to get deasserted and manually cr=
eate
> the reset pulse. Will move this down (after the fsleep(5) power-up time).=
 Or
> better move this up (before the regulator enable)...

I don't think we need to ensure a pulse. Just that the line is asserted bef=
ore
deassert.  So to my mind sashiko is correct with it's suggestion.
Just get it in unknown state, ensure that it is asserted (may already be),
then deassert.


>=20
> > > +	if (IS_ERR(rstc))
> > > +		return dev_err_probe(dev, PTR_ERR(rstc),
> > > +				     "Failed to get reset control\n");
> > > +
> > >  	fsleep(5); /* power-up time */
> > > +	reset_control_assert(rstc);
> > > +	fsleep(1); /* reset pulse: comfortably bigger than the spec */
> > > +	reset_control_deassert(rstc);
> > > =20
> > >  	/* Initialize masks to all ones */
> > >  	st->pwr_down_mask =3D ~0; =20
> >=20
> > --=20
> > Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609-ad5686=
-new-features-v2-0-70b423f5c76d@analog.com?part=3D6 =20
>=20

