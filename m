Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793905737;
	b=MBFHi6i2LENk8/uCZ0j3wzKhPZ4UyQ9SPYiIhbujC2zCYDuaDIbiLxA0/5lZprDY6X7f
	 smbdtovwRa0mLGcxor+HgxFSSSsNE9fS8zHDhhT45vrWX2gKyxm0qbQn9KrgN1lgTxj+b
	 7wn+eEZQzAQEktHA7bqGOOv43Ndl4dUDH+dxJo9UpuRrfwQy255INVsmM37VOxk+VKjya
	 P1o5q4lf5dT0Siw/LLBiMjIFiud9K732NP8MHf8Ricm0Au65myqn9WjUOoetraV5IMU06
	 lDHvExCn/fWsRabfyg6vlZkPhhCS+NZ9/zoD8Vv7/WOBUmdFM1G06j1/uzgAenYlE6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793905737;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=V7cpDqfJH1y1hZnJH2Vx1+b0eI4492tyg6A/STECMPY=;
	b=b3B/rdzArL09GGzEZNnuPTUZRP+uLJGHEY8LXSAJdvA/hbyDSeGTiPqLjRQyIwJLoYz7
	 B4fsdZc1Koc80mXH50+/HbSx5NtVtULNa3x/bGIkFTafYh42O/FAMRpAcnChBQ29HL2Sj
	 fmftHmzpS05ATerx65kslk9v7qtvfBvX0LDOkxJEqQgwExHmFb3s0ezfGjiYlEIslx9F1
	 8gRVSnRc439PkexCDd6c1y8NGKbYlbGYJy8JTf4Yjc8OrC7ePgFzPAYousJCu1OlU7cFu
	 ixFbF/uPr0cjqhnC1+0YdjWYSPMbGOYhIXIRbL7rlFzBbZAqut1j+dhiwzJtDVbRgoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LET9d5GD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C0F606A326;
	Thu,  5 Nov 2026 19:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LET9d5GD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAD3D1F000C1;
	Thu,  5 Nov 2026 19:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793905736;
	bh=V7cpDqfJH1y1hZnJH2Vx1+b0eI4492tyg6A/STECMPY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LET9d5GDd0AI7Q3ARWLfcNkSwf/TfYOAsmLg3K5t6xVeJvx7g/INQOasebQmjLKkg
	 /PGg3W9WCO3J8LYuq3Ob6Qwl4zr6hU3JsTir091SentB8bi7EC0N6YmdGU1QJg8vAo
	 aeKWauZcS849c6OH1T8KQXyEttfsdWBE7ndjjVcmZ5RQbrEzdz+8gw2VJm0IFdwdT7
	 XQ3Sabv0bmNxxbgqxBlpZOUrQIuoZPlBgkRcPn+H9KwwM4mynp96WyjtOHn9pMg+en
	 9xHWepFf4IQld04OQqXn+lg16EyR0quVDOQb4R5kzVixrOzEp41GyDZiPqjwpgfbZL
	 umqHfLuBo+CAQ==
Date: Thu, 5 Nov 2026 19:08:51 +0000
From: Conor Dooley <conor@kernel.org>
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Olivier Louvignes <olivier@mgcrea.io>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Cercueil <paul@crapouillou.net>,
	Joshua Crofts <joshua.crofts1@gmail.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: adc: Add the Ingenic X1600 ADC
Message-ID: <20261105-pregame-ditch-cb9fb68a0040@spud>
References: <20261102201155.10948-1-olivier@mgcrea.io>
 <20261102201155.10948-2-olivier@mgcrea.io>
 <20261102-salute-cylinder-22c9a8896ca9@spud>
 <C0C6F46A-45B7-4B1E-9398-71CD8A26FBD5@goldelico.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5rHQxFgV20QGdNEt"
Content-Disposition: inline
In-Reply-To: <C0C6F46A-45B7-4B1E-9398-71CD8A26FBD5@goldelico.com>

--5rHQxFgV20QGdNEt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 05, 2026 at 10:57:58AM +0100, H. Nikolaus Schaller wrote:
> Hi Olivier, Conor,
>=20
> > Am 02.11.2026 um 21:48 schrieb Conor Dooley <conor@kernel.org>:
> >=20
> > On Mon, Nov 02, 2026 at 09:11:54PM +0100, Olivier Louvignes wrote:
> >> The X1600's SAR ADC has four auxiliary channels and none of the
> >> touchscreen or battery engines of the JZ47xx ADCs in ingenic,adc.yaml,
> >> so it gets a binding of its own.
> >>=20
> >> Signed-off-by: Olivier Louvignes <olivier@mgcrea.io>
> >> ---
> >> .../bindings/iio/adc/ingenic,x1600-adc.yaml   | 53 +++++++++++++++++++
> >> MAINTAINERS                                   |  5 ++
> >> 2 files changed, 58 insertions(+)
> >> create mode 100644 Documentation/devicetree/bindings/iio/adc/ingenic,x=
1600-adc.yaml
> >>=20
> >> diff --git a/Documentation/devicetree/bindings/iio/adc/ingenic,x1600-a=
dc.yaml b/Documentation/devicetree/bindings/iio/adc/ingenic,x1600-adc.yaml
> >> new file mode 100644
> >> index 000000000000..f6356ea97980
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/iio/adc/ingenic,x1600-adc.yaml
> >> @@ -0,0 +1,53 @@
> >> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/iio/adc/ingenic,x1600-adc.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: Ingenic X1600 ADC
> >> +
> >> +maintainers:
> >> +  - Olivier Louvignes <olivier@mgcrea.io>
> >> +
> >> +description:
> >> +  The SAR ADC of the Ingenic X1600 SoC, with four auxiliary input cha=
nnels
> >> +  measured against a 3.3 V reference.
> >=20
> > The wording here makes me wonder if a 3v3 supply is missing here? Or is
> > this some internal supply on the soc?
>=20
> It is an external SADC_VREFP input pin (ball P12) which is usually connec=
ted to
> the 3v3 supply. But it is specified to be min=3D0V .. typical=3D3.3V ... =
max=3DVADC
> voltage levels.
>=20
> VADC is indeed the power supply for the SADC on a separate ball. It must
> be in the range of 2.97V .. 3.3V .. 3.63V so that it is extremely likely =
to be
> connected to the system 3.3V rail.

Probably there should be at least an optional supply then, in case it
has a dedicated one for $reasons.
pw-bot: changes-requested

Thanks,
Conor.

>=20
> Therefore I do not see a necessity to require a separate regulator refere=
nce here.

--5rHQxFgV20QGdNEt
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCauzUQwAKCRB4tDGHoIJi
0r8CAQCHI9gqXrfjEz8CofeFY5j+Ga0itdM/tPS1ksd1H+qUsAEA1KxEDpDfxkas
NnICKTM6EXj60ZHCA3zoEw8srW6ZJA4=
=0+bX
-----END PGP SIGNATURE-----

--5rHQxFgV20QGdNEt--
