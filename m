Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE7932E6BF;
	Tue, 27 Jan 2026 19:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769543732; cv=none; b=gD8wUvcDqMgbRXaZmPtUkEJJspOwwTLD/CRi0/xkhsNUFj2VBHX6rnOLqA2gOQCGlV6H58wdD0pgNg1mjjehriex95yZx40iU6JiYpYXwE6JMMmabMd0/avybh9HbLDp092Imr1ZKp7cE/FkNvmu/YNLlMPW+ZYijBiYm+JMv+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769543732; c=relaxed/simple;
	bh=ryJNG7DESnPd1UpF2pmPSzgUhhO6nC0JuZIn5GzJzLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PTweUm9HCgXNFcTAX0A8eK7MUrDrn6KEGtSEkSkQl7OaIuLnw9OdEEIlNCj5/dBW3Tfsb+HbUdr7fSNG53CmInKkVI0j+9s250rAZ5suh0ywSJSfG7AdNElc89vGnM/MEyNh+lqTXDNLX94rpk741w2uS7UamrUpYQnLM+hP1qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lQ2cbrBx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQ2cbrBx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A2F5C116C6;
	Tue, 27 Jan 2026 19:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769543731;
	bh=ryJNG7DESnPd1UpF2pmPSzgUhhO6nC0JuZIn5GzJzLs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lQ2cbrBx+julbg/m5qTWpFrIiWW73/V2stzqZZv0MGwB0zRcnC+bApHqppjZYx7qG
	 sVxnltBkyZ4j67dQtuUHAY93gD1ryaFcfnLqTZ/K4erkMAa+bAqUleqvw3R2eEtfp0
	 Vh+ARtQuXxXtNCOEVj+PPwH/QSKr7qX/YgkxXzLBpNLdPHIXzaifo/EmsyFm6g5mjN
	 Ntlz2SxEmRps6PppP3t14fA2uW5b/M72DuDUAV04evjWRyUF9cqN8rx2DtTW+6vpiY
	 4wG2t1leSXOna8/VskbxEsdPZ9kBlo94FJDJbYpR1QdtVr7sP3Xh0eTbM2yJ7wwl0x
	 +7gW8TcAyY+3g==
Date: Tue, 27 Jan 2026 19:55:26 +0000
From: Conor Dooley <conor@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	David Jander <david@protonic.nl>
Subject: Re: [PATCH v2 2/8] dt-bindings: iio: dac: maxim,ds4424: add
 maxim,rfs-ohms property
Message-ID: <20260127-rockiness-finalize-e0b50b9d823f@spud>
References: <20260127060939.3914006-1-o.rempel@pengutronix.de>
 <20260127060939.3914006-3-o.rempel@pengutronix.de>
 <20260127-consonant-vividness-13707c7cf8f6@spud>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ohqRuZ8RLnxwa/lz"
Content-Disposition: inline
In-Reply-To: <20260127-consonant-vividness-13707c7cf8f6@spud>


--ohqRuZ8RLnxwa/lz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2026 at 07:49:20PM +0000, Conor Dooley wrote:
> On Tue, Jan 27, 2026 at 07:09:33AM +0100, Oleksij Rempel wrote:
> > The Maxim DS4422/DS4424 and DS4402/DS4404 current DACs determine their
> > full-scale output current via external resistors (Rfs) connected to the
> > FSx pins. Without knowing these values, the full-scale range of the
> > hardware is undefined.
> >=20
> > Add the 'maxim,rfs-ohms' property to describe these physical components.
> > This property is required to provide a complete description of the
> > hardware configuration.
> >=20
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > ---
> > changes v2:
> > - make maxim,rfs-ohms a required property as the hardware range is unde=
fined
> >   without external resistors.
> > - add allOf constraints to enforce 2 vs 4 items in maxim,rfs-ohms based=
 on
> >   compatible string.
> > - drop explicit $ref for maxim,rfs-ohms to fix dt_binding_check warning.
> > - update example in binding to include the new required property.
> > ---
> >  .../bindings/iio/dac/maxim,ds4424.yaml        | 36 +++++++++++++++++++
> >  1 file changed, 36 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/iio/dac/maxim,ds4424.yam=
l b/Documentation/devicetree/bindings/iio/dac/maxim,ds4424.yaml
> > index efe63e6cb55d..400afd8771aa 100644
> > --- a/Documentation/devicetree/bindings/iio/dac/maxim,ds4424.yaml
> > +++ b/Documentation/devicetree/bindings/iio/dac/maxim,ds4424.yaml
> > @@ -27,9 +27,44 @@ properties:
> > =20
> >    vcc-supply: true
> > =20
> > +  maxim,rfs-ohms:
> > +    description: |
> > +      Array of resistance values in Ohms for the external Rfs resistors
> > +      connected to the FS pins.
> > +      - For DS44x2 (2 channels): 2 values required.
> > +      - For DS44x4 (4 channels): 4 values required.
> > +      Typical values range from 40000 (40 kOhm) to 160000 (160 kOhm).
>=20
> Add here
> maxItems: 4
> minItems: 2
>=20
> Are 40kOhm and 160kOhm actual max/min values, or just a suggested range?

Datasheet for the ds4424 seems to imply they're actual max/min values:
"Input resistors (RFS) must be between the speciifed values to ensure the
device meets its accuracy and linearity specifications."
In that case, consider also adding something like:
    items:
      maximum: 40000
      minimum: 160000

Although, that would complain about the 5100 Ohms you're using. How come
the example lies outside of the "typical" range?

> > +
> >  required:
> >    - compatible
> >    - reg
> > +  - maxim,rfs-ohms
> > +
> > +allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - maxim,ds4402
> > +              - maxim,ds4422
> > +    then:
> > +      properties:
> > +        maxim,rfs-ohms:
>=20
> > +          minItems: 2
>=20
> Remove this...
>=20
> > +          maxItems: 2
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - maxim,ds4404
> > +              - maxim,ds4424
> > +    then:
> > +      properties:
> > +        maxim,rfs-ohms:
> > +          minItems: 4
>=20
>=20
> > +          maxItems: 4
>=20
> ...and this. The outer-most constraints should be in the definition and
> the if/else bit just adjusts whichever bounds it needs to.
>=20
> Cheers,
> Conor.
>=20
> pw-bot: changes-requested
>=20
> > =20
> >  additionalProperties: false
> > =20
> > @@ -43,6 +78,7 @@ examples:
> >              compatible =3D "maxim,ds4424";
> >              reg =3D <0x10>; /* When A0, A1 pins are ground */
> >              vcc-supply =3D <&vcc_3v3>;
> > +            maxim,rfs-ohms =3D <5100>, <5100>, <5100>, <5100>;
> >          };
> >      };
> >  ...
> > --=20
> > 2.47.3
> >=20



--ohqRuZ8RLnxwa/lz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaXkYLgAKCRB4tDGHoIJi
0is5AP4pT/1UxmK/iNlAf+6TJ3HRgZfsghl58pGgAeOKffoiOwD9FybYXa0oNEoc
+aG8VhfqghXn3NLsBPW3NTIU+2sY3gI=
=+xVv
-----END PGP SIGNATURE-----

--ohqRuZ8RLnxwa/lz--
