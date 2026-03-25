Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D551E3A5456;
	Wed, 25 Mar 2026 18:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774462430; cv=none; b=Gepvo4kfeppqNYg9HxJjqcILLHshFm47luoKIblh6XpRxJEQp/PYXdLKyZuz1tb1snGo65rXWZAGhWfF7Pcyn7aG0NQQPzo9MwRDaVbJwUhxtpJSD9/l6RrEK+3ZLFxo/CT31F7Z5gur/0GKp+Q2P4y/dsW0gp0WL+RjybFNZLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774462430; c=relaxed/simple;
	bh=TX+dEV9BOagcgeEFEy9LiULeUsY+tlP+4jI7VBGea/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E4T+2HMVw/Us+g048NNRRACpVGG08mH6uj4wkQi+pBWZZNV7ja5dZDjWouQPAQFbVyZq8IYdOcopadDyJiKuhGMcWrkedGAaZA+XehljUjwfdwfOIkrGjr7CxU9a9RI32EjO1AdQPceLqth8buDub9dkw7EMOL2zT8yGZwUQpro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxhsdLF4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxhsdLF4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1FCFC4CEF7;
	Wed, 25 Mar 2026 18:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774462430;
	bh=TX+dEV9BOagcgeEFEy9LiULeUsY+tlP+4jI7VBGea/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oxhsdLF4QxzJdzzFXmfNgsUtULH9Fi4XS+dQNtHwpf9XQXfXe6mlOefqerynTTfM+
	 JbCcpLb47MPfcMFJxw1uREnMLNUs22Fng20MlnEKnSQposKygdFB4KP7JzlBqpBT5N
	 Yr1XJa/px7b4xuhYU0PmMH38S1prxaRTaxY1KRqWRyuEthtp35NEsyldNUGgrGJoA0
	 0WtXIunPjGTuslPj8HXNz/e9poTg1Go1OsrQaL95xFIm+qK2PkUFYXN3Ph/2jb9Pcu
	 dDiVL0rEH2AK/SRi3yznQUcsfa606RCpYtN9SVq2jrqX66FpuhnnUi8n79kDcF0TXI
	 Rxg2bLN4PRx6w==
Date: Wed, 25 Mar 2026 18:13:45 +0000
From: Conor Dooley <conor@kernel.org>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>,
	rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: iio: amplifiers: ad8366: add adrf5702/3
 support
Message-ID: <20260325-possibly-deploy-3ff69076a6e9@spud>
References: <20260325-adrf570x-iio-support-v1-0-9a2685eb2e55@analog.com>
 <20260325-adrf570x-iio-support-v1-1-9a2685eb2e55@analog.com>
 <20260325124627.00006828@huawei.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="POO0s8yAjvUWIQ8G"
Content-Disposition: inline
In-Reply-To: <20260325124627.00006828@huawei.com>


--POO0s8yAjvUWIQ8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2026 at 12:46:27PM +0000, Jonathan Cameron wrote:
> On Wed, 25 Mar 2026 11:12:02 +0000
> Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.o=
rg> wrote:
>=20
> > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> >=20
> > Add compatible entries for ADRF5702 and ADRF5703 Digital Attenuators.
>=20
> Explain how they are different from the existing supported devices.
>=20
> Something simple like the "Each device has its own gain range and step,
> hence no fallback compatibles are used." that you had in the original pat=
ch
> is what we need here.

Which means that this is a v2 that doesn't say it is a v2, or explain
what has changed?

>=20
> >=20
> > Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > ---
> >  Documentation/devicetree/bindings/iio/amplifiers/adi,ad8366.yaml | 4 +=
+++
> >  1 file changed, 4 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/iio/amplifiers/adi,ad836=
6.yaml b/Documentation/devicetree/bindings/iio/amplifiers/adi,ad8366.yaml
> > index 2719de1166a1..065637ce33a5 100644
> > --- a/Documentation/devicetree/bindings/iio/amplifiers/adi,ad8366.yaml
> > +++ b/Documentation/devicetree/bindings/iio/amplifiers/adi,ad8366.yaml
> > @@ -20,6 +20,8 @@ properties:
> >        - adi,ad8366
> >        - adi,ada4961
> >        - adi,adl5240
> > +      - adi,adrf5702
> > +      - adi,adrf5703
> >        - adi,adrf5720
> >        - adi,adrf5730
> >        - adi,adrf5731
> > @@ -66,6 +68,8 @@ allOf:
> >                anyOf:
> >                  - const: adi,ad8366
> >                  - const: adi,ada4961
> > +                - const: adi,adrf5702
> > +                - const: adi,adrf5703
> >                  - const: adi,adrf5720
> >                  - const: adi,adrf5730
> >                  - const: adi,adrf5731
> >=20
>=20

pw-bot: changes-requested

--POO0s8yAjvUWIQ8G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCacQl2QAKCRB4tDGHoIJi
0tRjAQCnircq7tWhPtXLYboL/3Dz8elnSwfxJliqfNpU4gJgKwEA9YCsUNoOTEVw
2+CW4mZHft4LwvYrExkuHNggBEdU8Ao=
=OoE2
-----END PGP SIGNATURE-----

--POO0s8yAjvUWIQ8G--
