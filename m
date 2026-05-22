Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB2A25B0B8;
	Fri, 22 May 2026 16:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779466254; cv=none; b=SNfcWmiEbUHDPYuHUhmu0rTte/QyO67Mx7Sz4XfZwc1id+bCU9Ul7TONr6zLEQi304ZcyNauoI189eXmIzYTe8RCcI07ibyw1Cei85Y1CqWjHUhvaWBh07Ei3XOLRqfZG437UsebZJTGDOAaFNinViSPuDrNyHyLyIH0NyF8/GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779466254; c=relaxed/simple;
	bh=kZ3uO1OHIz+Oyc/syQrZykUktdTCHmv/DqOGbsRZOt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=owrW92tG5uebI3cNOW/RefpFXpfb8gMzIqxvGiL9XN5k3yude/GH41xtrh2myXTlbGl/rnD5NlYmlCW0m/5saHBMYWeCmM6enfyy8FlG8Y75tOtVvhkPFDLLLQKHKlCYIqCn8stF248o42KF637/4QVR3ZZ9K6JsPUMC2tuwtmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FmHS8Wnx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FmHS8Wnx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7640A1F000E9;
	Fri, 22 May 2026 16:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779466252;
	bh=iN2cfL6+N15d2D6sIkMUpDrp0tb/pVV8+rm64soeidE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FmHS8Wnx1VnRCrPMVSXHMlMIO+ddJST6PH78ZrK7nxOeGFaKp8blaWNBQTBPguoig
	 Rlipz00S76y23y8D2qK/jmhbBSeXjbj07cPTvAAKEAxsUPZahQ/0dxJCvt2lGh8hlP
	 xQypYPlyQ0c2odkus8Fs1BNu1q18NiwFHeJISIecxj9rEULxAdBGgZ62RW8yl0uYMo
	 ZkyoBck/SgL2vqibbuiGP1ib5+u77WAdCRx76RmfR1E/d2zjfUhneGWvoe20IDIrpW
	 1C2Q8dMHxVv4BHD0rmkKeI2OE08wOllY9cNeI4OR8BF7tRZYGooPFsty5Zi0PV0Xog
	 A2uQVxgNes+OQ==
Date: Fri, 22 May 2026 17:10:48 +0100
From: Conor Dooley <conor@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux@analog.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: ad4080: add AD4884 support
Message-ID: <20260522-oyster-uneatable-e96b9521db20@spud>
References: <20260522115337.18188-1-antoniu.miclaus@analog.com>
 <20260522115337.18188-2-antoniu.miclaus@analog.com>
 <20260522133228.06521c5d@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lZtEreREFkGJ1kwy"
Content-Disposition: inline
In-Reply-To: <20260522133228.06521c5d@jic23-huawei>


--lZtEreREFkGJ1kwy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 01:32:28PM +0100, Jonathan Cameron wrote:
> On Fri, 22 May 2026 14:53:36 +0300
> Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:
>=20
> > Add AD4884 compatible string to the AD4080 devicetree binding.
> >=20
> > The AD4884 is a dual-channel, 16-bit, 40 MSPS SAR ADC, sharing the same
> > register map and interface as the AD4080 family. Like the AD4880, it
> > requires two SPI chip selects and two io-backends for its independent
> > ADC channels.
>=20
> I don't see anything in here to say how it is different in a fashion
> that doesn't allow a fall back compatible to the ad4880. Probably just
> needs a statement about the resolution being different.=20

With one,
Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

>=20
> >=20
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > ---
> >  Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml =
b/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
> > index 9c6a56c7c8ef..4a3f7d3e05c3 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
> > @@ -39,6 +39,7 @@ properties:
> >        - adi,ad4087
> >        - adi,ad4088
> >        - adi,ad4880
> > +      - adi,ad4884
> > =20
> >    reg:
> >      minItems: 1
> > @@ -99,7 +100,9 @@ allOf:
> >        properties:
> >          compatible:
> >            contains:
> > -            const: adi,ad4880
> > +            enum:
> > +              - adi,ad4880
> > +              - adi,ad4884
> >      then:
> >        properties:
> >          reg:
>=20

--lZtEreREFkGJ1kwy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCahCACAAKCRB4tDGHoIJi
0vKvAP94ddzMvuSf51+nrjjjLNIBJFlun3nfV0Tbng1XehDt9QD+NwQeCw+uom6i
rzKUBtLYdkfIZPCaGQnYxF3zuGedbwY=
=hQYQ
-----END PGP SIGNATURE-----

--lZtEreREFkGJ1kwy--
