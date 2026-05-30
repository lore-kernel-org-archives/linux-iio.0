Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62392DC79A;
	Sat, 30 May 2026 23:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780182709; cv=none; b=j33LALuiIw4axc9Et7KwiAGRSuVl/sJmv4tOMtYKPOqTCxNvIsI7EstEsr6DUfNWt08uVCuY9MfIY3vWx++wdXUGrYtMVqCvxUmkAQMbdhjdye5J4gVpWYJDIX2wAcZrE5j1B/xwTwy+zbKRkBQoqeBU9De0iiscidWrKtsZdgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780182709; c=relaxed/simple;
	bh=JxCHsqyx82Eg7xxLsxDPxKJZersRU1eya8nz9d6Ws94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KgeRaWeN8Qn1EabXAavnnd2P3A5O9hcEhG91Wb68LWPTYvKX0sa+RrAT0pkMF97gIsnXEu4l6WULcXMkTynbAyHCT2cg0uDnGAu00IjDTaiaTdC9UsmrNRE7McyKRBk9mzuoMrpnQbYwtrpEgTaMo7Vs/ZzPE2gi6DKY+FGgHKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cT/Grrsl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cT/Grrsl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07CBD1F00893;
	Sat, 30 May 2026 23:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780182708;
	bh=QY0/+e+KNY7EeUMYH//8eNjIBXcxLjHjGZf4xhZ7cE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cT/GrrslCCvRktzotxchjaz7eTCXEczYZlMyL3bYkcrBFPlV4M/kdaNC8k9fs4aeh
	 VelIvfS9BtU4iawRYPW/XSKsKb/awjh3gFr+VY2XNdXiFkyyL1r6fZSgv1Oa/Omu1h
	 STPBXq9TfC6s6S22QTD1ZNv/Uq+66JLXMd5x3FlOH1Y6qc2HVBYn8jG8tj0uBoB9fB
	 qE4B8SxMZNAmJGLNslXCr8SzAIsRfNw0cpVdGgTOOzjMpYHNo7Sq7S2CCjzD/Xbg3f
	 aAeIaRcp4a49EzaGrz7vDw+9uw+/JL2G8oRP3l0NFW6OyBso3PGMto2K2jw1nTs+KW
	 LGHPa2rB9E3pg==
Date: Sun, 31 May 2026 00:11:44 +0100
From: Conor Dooley <conor@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Taha Narimani <tahanarimani3443@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: iio: adc: Add schema for AD7816/7/8 digital
 temperature sensor
Message-ID: <20260531-mama-demanding-edf694ceb099@spud>
References: <20260530133126.54460-1-tahanarimani3443@gmail.com>
 <20260530135302.54688-1-tahanarimani3443@gmail.com>
 <20260530155817.6169e5e2@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0pKiDVqOA+ZCCJCE"
Content-Disposition: inline
In-Reply-To: <20260530155817.6169e5e2@jic23-huawei>


--0pKiDVqOA+ZCCJCE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 30, 2026 at 03:58:17PM +0100, Jonathan Cameron wrote:
> On Sat, 30 May 2026 13:53:00 +0000
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +    description: OTI (Over Temperature Indicator) interrupt.

> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +    spi {
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        adc@0 {
> > +            compatible =3D "adi,ad7816";
> > +            reg =3D <0>;
> > +            spi-max-frequency =3D <1000000>;
> > +            rdwr-gpios =3D <&gpio 5 GPIO_ACTIVE_HIGH>;
> > +            convert-gpios =3D <&gpio 6 GPIO_ACTIVE_HIGH>;
> > +            busy-gpios =3D <&gpio 7 GPIO_ACTIVE_HIGH>;
> > +            interrupts =3D <20 IRQ_TYPE_LEVEL_LOW>;
> > +            interrupt-parent =3D <&gpio>;
>=20
> You don't have any interrupts in the binding. So this shouldn't
> pass testing.

There is an interrupts property in the binding, unless you meant
something else?

>=20
> > +        };
> > +    };
>=20

--0pKiDVqOA+ZCCJCE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCahturwAKCRB4tDGHoIJi
0gfAAQCneNI6VLFrU90IsQ7TsC4XDyCYH1xKZOshGV9AdDN4CQD+KyNaEs7mzyCP
a2OhzqpgOhoIr9Whyj+UA4RfNyLQtgE=
=P3an
-----END PGP SIGNATURE-----

--0pKiDVqOA+ZCCJCE--
