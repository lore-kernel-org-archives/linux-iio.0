Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793232418;
	b=BID5HFoBZEe9KafvAm3nEFwX78aK3gTPKQnqCZjByyaqMcvKZjSyaUTA6Xl14x3Bhqy2
	 Oplw7w0iivBneNQ3NOc7aY6Un4wkl1JbCktpcqhqFWhZejDtF/jTlTDMt0805xcubpxTn
	 JiED7YIAcRhNbiSTIFdZ974ElBXax9oseeKVWeNDLpmqmxVAZh3flAWJEjaigwoRCV/Yc
	 g4JKHeQJOwVc2t6FvbnoN6hhrjqe/CFDkhLkepSD6ErboRir/FTVREptzrelu5lcMB/t9
	 /LZfpSBExAtg28rg49h+eCmNGY55FmP3RKrJh3XKJ9SBWkbpQ/+eTlUYmutTI7m2bIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793232418;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=3fvI0TM8+FK8rZAgbHGjXojlMkSEHOIDbZUA5VlGZkE=;
	b=dNP/XvljL+BwhslsvobcybWxT6Gp7cdwO12NKNRlrcqe/mjpI4gRgD5Jv+3JIVRhSR/F
	 +xu2YRGt2vWzMm7wGV0Jd96bzK8NB4GWUHDEHoDKT5j3LWTK+hIyBKV/58JYQChCyYMME
	 +MpX2PuETAtnw1KrlVmb98bbQ3oP1EcFiGds433YjfIbXWNd3R0YUinMibEgFDeeCYP0/
	 nQlxvPfGEzruFKWZg7SsWlgAhcTfWDlIg9pNpfWTWh6ZitwW65ceEtj09ICVcXElz+dJG
	 p4aJyAjE/mPAd/QqAWyoEEtD6KiziDO7I4h66Wz9OdzcSKtGTHGbMZK9LyEuyreIN1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AbUz4Ahf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD95606A31A;
	Thu, 29 Oct 2026 00:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AbUz4Ahf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFB0D1F01825;
	Thu, 29 Oct 2026 00:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793232417;
	bh=3fvI0TM8+FK8rZAgbHGjXojlMkSEHOIDbZUA5VlGZkE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AbUz4AhfG/N19UL54LGvXeIdheWyC95cXavm4fWb811lbIpM6QIIodtY804X9Vdu+
	 fPa5GzS3kJMRqjuVMnKDxroBwScqdAIMpwsDEpj5GH4mhmzngQ6xSJj7yBeoTEsYPJ
	 UBLO0jKmJgdBnSom18wOgM08938wj4fUpDWwjlD1HlTEpgL8WXYUCFLRYqV8CxHLVE
	 2fJJ3kVffvero8ipyEtZEq7NNUObOMNlr8kZ0K9N0u+6eHFcIelxsxJ1oBMYwgf6Qu
	 ZFv9D0mhfeKgWmtxt1cmbLNK2wtU/iy2/SJj5W7PBkapXT+k/pi/epUIUXaQ0wck0x
	 QUIsgf2fdQdBw==
Date: Thu, 29 Oct 2026 00:06:52 +0000
From: Conor Dooley <conor@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jesper X Nilsson <jesper.x.nilsson@axis.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@axis.com
Subject: Re: [PATCH v2 1/4] dt-bindings: iio: light: opt4001: add opt4041
Message-ID: <20261029-urban-grumble-cf73863f17e1@spud>
References: <20261023-opt4041-v2-0-ee320812804c@axis.com>
 <20261023-opt4041-v2-1-ee320812804c@axis.com>
 <20261023215409.4c4ff7d6@jic23-hlaptop>
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
	protocol="application/pgp-signature"; boundary="DK5ad8uOBVKaADIa"
Content-Disposition: inline
In-Reply-To: <20261023215409.4c4ff7d6@jic23-hlaptop>

--DK5ad8uOBVKaADIa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 09:54:09PM +0100, Jonathan Cameron wrote:
> On Fri, 23 Oct 2026 14:30:28 +0200
> Jesper X Nilsson <jesper.x.nilsson@axis.com> wrote:
>=20
> > Add a new compatible for opt4041. The opt4041 is only available in the
> > SOT-5X3 package. The device is pin compatible with the opt4001-sot-5x3
> > and shares the same properties. The opt4041 has one additional channel
> > compared to opt4001, the extra channel has a wide spectral bandwidth
> > ranging from 380nm to 1000nm.
> >=20
> > Datasheet: https://www.ti.com/lit/gpn/opt4041
> > Signed-off-by: Jesper X Nilsson <jesper.x.nilsson@axis.com>
> > ---
> >  Documentation/devicetree/bindings/iio/light/ti,opt4001.yaml | 9 ++++++=
+--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/iio/light/ti,opt4001.yam=
l b/Documentation/devicetree/bindings/iio/light/ti,opt4001.yaml
> > index 12b0c7ed5d72..35e9b0deb944 100644
> > --- a/Documentation/devicetree/bindings/iio/light/ti,opt4001.yaml
> > +++ b/Documentation/devicetree/bindings/iio/light/ti,opt4001.yaml
> > @@ -4,7 +4,7 @@
> >  $id: http://devicetree.org/schemas/iio/light/ti,opt4001.yaml#
> >  $schema: http://devicetree.org/meta-schemas/core.yaml#
> > =20
> > -title: Texas Instruments OPT4001 Ambient Light Sensor
> > +title: Texas Instruments OPT4001/OPT4041 Ambient Light Sensor
> > =20
> >  maintainers:
> >    - Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>
> > @@ -13,13 +13,16 @@ description:
> >    Ambient light sensor with an i2c interface.
> >    Last part of compatible is for the packaging used.
> >    Picostar is a 4 pinned SMT and sot-5x3 is a 8 pinned SOT.
> > +  OPT4041 is only available as sot-5x3 and adds a wide band channel.
>=20
> I guess we keep the compatible naming because some crazy
> person might one day release it in a different package.

Ye it is a bit weird. I did notice it but passed it off cos the
existing device was like that and there was a behavioural difference in
the driver between the two packages for the 4001. Maybe this fancy
picostarTM package is no longer a thing? Would really need to get
someone from TI to tell us what the plans are.

>=20
> J
> >    https://www.ti.com/lit/gpn/opt4001
> > +  https://www.ti.com/lit/gpn/opt4041
> > =20
> >  properties:
> >    compatible:
> >      enum:
> >        - ti,opt4001-picostar
> >        - ti,opt4001-sot-5x3
> > +      - ti,opt4041-sot-5x3
> > =20
> >    reg:
> >      maxItems: 1
> > @@ -39,7 +42,9 @@ allOf:
> >        properties:
> >          compatible:
> >            contains:
> > -            const: ti,opt4001-sot-5x3
> > +            enum:
> > +              - ti,opt4001-sot-5x3
> > +              - ti,opt4041-sot-5x3
> >      then:
> >        properties:
> >          interrupts:
> >=20
>=20

--DK5ad8uOBVKaADIa
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCauKOHAAKCRB4tDGHoIJi
0nCwAP48Tc61zu/MajdD4L0PWJOHi7czGSAylmDIYXgHGSv8EAD+OewuyIZWrqWp
7/QCD4sct+JR0AYBf7tNMHS0Ya6pPA4=
=iE73
-----END PGP SIGNATURE-----

--DK5ad8uOBVKaADIa--
