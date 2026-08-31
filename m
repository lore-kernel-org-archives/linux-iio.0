Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFE74AC155;
	Mon, 31 Aug 2026 15:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788189405; cv=none; b=skUL8OfpUuM0KaVPKsM9FziBUn1OBoeGAYJoEoRr83P+YRbWnE8Ccmr/GVE742AD89rCjqCfQSleet8ae9uQ+8TKfdYqxsYB56CXb097MlnqQGEd9qukyfRsTnmYR1HTMvvhFEplFXVE1S3Efj3HZFnIY4EKnrtWmvbvt1pxQ50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788189405; c=relaxed/simple;
	bh=GqDlEthcKeCto1IK8aqSMtLvQsYhsCkSSc92Sf6YLWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QHDfCFOicr+mcg08U/zj6zxkEs5/eedI4NpymLAnhOiigZ0SpXTxZWzK1HhdjQ1PDzMbCXIq6ZO/2I5jSBwctS+A+1Y3+KUF4fBDxiBCf/x/0xwWs6xwwqMqJbATJXaZ3J0774jovxuTc3szFDdf7ISofG1b+c1KfSQSId5/i2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jPjmHNMV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jPjmHNMV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9359C1F000E9;
	Mon, 31 Aug 2026 15:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788189403;
	bh=Kx1FB6JgPrk1Y6hTLCOF3WYrXDB4KeTBg4uS8qfCyPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jPjmHNMV/qUIEYqw7osqFfO/AIQGD9T4cag8N8jFQ23U2T0kFUUp4l8Ivr8XVsCc2
	 WQXupcEx89Ua8i9/RCi1O/rx9I8zn7xPwU2+dXDTi0P9N2HPsSaQpVyamgq/aSXUKr
	 HkvL0EVGVnhXhmmN8LjYOPAzxNBaqu61Sa7FAV+wrsS7uoAEArGmj+R0N/jiyNreGG
	 45+js7AkiFVeTY4AOh5D3wFwPP2W+j/wQvxUt5JFOzIDacg8PQhitjRL9n+BWv38Z9
	 0SeVmyVgPSjmWR2cplEY//k5Sxz3lUr2QGltvxgJYPZKLzGEicc5RKqVlCS3kBG4jQ
	 /NqcZPl3/ECCw==
Date: Mon, 31 Aug 2026 16:16:38 +0100
From: Conor Dooley <conor@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>, linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/9] dt-bindings: iio: adc: renesas,r9a09g077-adc:
 document DMA support
Message-ID: <20260831-riveting-unworthy-6c1992bf16f1@spud>
References: <20260828145943.2077589-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <20260828145943.2077589-8-cosmin-gabriel.tanislav.xa@renesas.com>
 <20260828-stoppable-clone-db6c2fefe0fd@spud>
 <CAMuHMdUryFJFQ+NWRzXWTzhW5yWvUsXc9y1=wTS13BGOaKg+5w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="j8cToac23pWMOvDo"
Content-Disposition: inline
In-Reply-To: <CAMuHMdUryFJFQ+NWRzXWTzhW5yWvUsXc9y1=wTS13BGOaKg+5w@mail.gmail.com>

--j8cToac23pWMOvDo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 07:17:00PM +0200, Geert Uytterhoeven wrote:
> Hi Conor,
>=20
> On Fri, 28 Aug 2026 at 18:21, Conor Dooley <conor@kernel.org> wrote:
> > On Fri, Aug 28, 2026 at 05:59:40PM +0300, Cosmin Tanislav wrote:
> > > The ADC can transfer conversion results to memory over DMA.
> > >
> > > Allow up to three DMA specifiers, as the ADC conversion DMA request c=
an
> > > be routed to any of the SoC's three DMA controllers.
> > >
> > > Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.co=
m>
>=20
> > > --- a/Documentation/devicetree/bindings/iio/adc/renesas,r9a09g077-adc=
=2Eyaml
> > > +++ b/Documentation/devicetree/bindings/iio/adc/renesas,r9a09g077-adc=
=2Eyaml
> > > @@ -57,6 +57,18 @@ properties:
> > >        - const: adclk
> > >        - const: pclk
> > >
> > > +  dmas:
> > > +    minItems: 1
> > > +    maxItems: 3
> > > +    description:
> > > +      Must contain a list of references to DMA RX specifiers.
> > > +
> > > +  dma-names:
> > > +    minItems: 1
> > > +    maxItems: 3
> > > +    items:
> > > +      const: rx
> >
> > How does this make any sense?
>=20
> Each entry provides the same functionality; the DMA core picks one that
> is available.  This was one of the design requirements when support
> for DMACs was added to DT.
>=20
> > If the device can make use of three DMA controllers at once, you need 3
> > names. If it cannot, then just limit this to 1.
>=20
> How do you expect that to work with multiple (the number is not fixed)
> different names?

Oh right, this shit has a specific workaround for it in dt-schema
doesn't it? Cos otherwise dma-names has a unique naming mandate.
Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--j8cToac23pWMOvDo
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCapWa1gAKCRB4tDGHoIJi
0rpuAQCTcfwhWoumAaoK1bRsBY51TIgZCreTk6iPqQ1JxZ+w8AD/cwkGk3kLKZuD
5/3Hsty+Y2PuETuYe56k9VYeDOob4Ao=
=/qup
-----END PGP SIGNATURE-----

--j8cToac23pWMOvDo--
