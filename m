Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB30324B06;
	Tue, 28 Jul 2026 16:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785254464; cv=none; b=KV0bdHni0jC/NCcyNChiDoYnyM8jOt73joaoE3sK36vTavve1YInm3jhOO8+p/rMLF3UMIcbciT2d+46TDIjzeC00h7xIvqwuegOR92Ft9ShW3s0rr923ul6tCeGZ5M8oH0TSQ6ItsEerjFbdwM0WuIggsQD7nkWf6HUxGt7FM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785254464; c=relaxed/simple;
	bh=czRWxwPdV0B/TC9cXN1ww//UFiMOnbUt5OusGyRLRdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PHVDcwFBZpfcOw5d1Zl7cjoA5Z2IwQel0gHclFTan0eXP+sBlXl9+sGI5KPsBusFXLzIZuAJui1TBJe3ztP9/RJFVG87rfMzjsz8OwjBGUmHAU8p9dS1jV1lrXB33NHStxqEs5xzHCgOCgZbrkmGs2SqakhLG15Ypz6FjQ5/aG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fl/g7mzg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fl/g7mzg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D76C41F000E9;
	Tue, 28 Jul 2026 16:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785254462;
	bh=+1ypUeeD+B1IwxzZUM25vLW6cTdOr3YMLvqGxJNEiDk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fl/g7mzgatzU05Syo9DEk3Dm2ynabnYerxBsx9Q2ml+z7r7w/l61mxRNZ3alVb903
	 k4yMsVtWFbKpKTatT/enw2xYEK2mrdRxPcbfHTKdM37QXIibXabplwyRgmzIfs9w+F
	 sG6M7wlgZyGtGTCCRJQau8ISxenSX6K4VfdmwsVBZjnm/8HAoRje9DiP8qhRryF8qh
	 KV3MKZGzmWNDihur5nC8KTiksrFkrQ5hkETwb3js6qN8Vyv0gFGrCLarMQnIZIZzxx
	 JwvyIgi00vKu2MTGcv/ePd50imGydE2/K8ScXv+1v/fcne4tzxHcCpv9eBlnsYOMT3
	 tAMVErJ6ZtdUg==
Date: Tue, 28 Jul 2026 17:00:55 +0100
From: Conor Dooley <conor@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Janani Sunil <janani.sunil@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Mark Brown <broonie@kernel.org>,
	Marius Cristea <marius.cristea@microchip.com>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Kent Gustavsson <kent@minoris.se>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, Janani Sunil <jan.sun97@gmail.com>,
	linux-spi@vger.kernel.org, Kent Gustavsson <nedo80@gmail.com>
Subject: Re: [PATCH v7 2/7] dt-bindings: iio: adc: microchip,mcp3564: Add
 spi-device-addr
Message-ID: <20260728-patronize-thwarting-56fab2e11077@spud>
References: <20260722-ad5529r-driver-v7-0-7781cd74ad75@analog.com>
 <20260722-ad5529r-driver-v7-2-7781cd74ad75@analog.com>
 <cb4098c1-4bad-4a11-9a6f-a833e554f197@baylibre.com>
 <20260725230739.63ff7000@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xuABnB4oaxi0GLxH"
Content-Disposition: inline
In-Reply-To: <20260725230739.63ff7000@jic23-huawei>

--xuABnB4oaxi0GLxH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 25, 2026 at 11:07:39PM +0100, Jonathan Cameron wrote:
> On Sat, 25 Jul 2026 15:57:07 -0500
> David Lechner <dlechner@baylibre.com> wrote:
>=20
> > On 7/22/26 2:54 AM, Janani Sunil wrote:
> > > Add the generic spi-device-addr property to the binding and deprecate
> > > the existing vendor specific microchip,hw-device-address property.
> > >=20
> > > Signed-off-by: Janani Sunil <janani.sunil@analog.com>
> > > ---
> > >  .../devicetree/bindings/iio/adc/microchip,mcp3564.yaml         | 10 =
++++++++--
> > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3=
564.yaml b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3564.yaml
> > > index 675319276197..de1ea289e7f5 100644
> > > --- a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3564.yaml
> > > +++ b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3564.yaml
> > > @@ -80,6 +80,7 @@ properties:
> > >      $ref: /schemas/types.yaml#/definitions/uint32
> > >      minimum: 0
> > >      maximum: 3
> > > +    deprecated: true
> > >      description:
> > >        The address is set on a per-device basis by fuses in the facto=
ry,
> > >        configured on request. If not requested, the fuses are set for=
 0x1.
> > > @@ -91,6 +92,12 @@ properties:
> > >        clocking of the device address (BITS[7:6] - top two bits of CO=
MMAND BYTE
> > >        which is first one on the wire).
> > > =20
> > > +  spi-device-addr:
> > > +    maxItems: 1 =20
> >=20
> > Does it not make sense to all for more than once device connected
> > to the same CS here? I would expect maxItems to be 4 to match the
> > number of possible addresses.
> >=20
>=20
> I think for this part their isn't a reason to aggregate.
> No magic accesses that touch them all at once.  So this hits
> exactly the point you raised about how we set the address for
> more than one of them.

No David is actually right here, and maxitems should be 4.
Setting the address for multiple was already discussed I thought, with
the property being an array and each compatible being used to determine
the "stride" between entries based on the number of supported channels?

>=20
> Jonathan
>=20
> > > +    items:
> > > +      enum: [0, 1, 2, 3]
> > > +    default: [1]
> > > +
> > >    "#io-channel-cells":
> > >      const: 1
> > > =20
> > > @@ -123,7 +130,6 @@ dependencies:
> > >  required:
> > >    - compatible
> > >    - reg
> > > -  - microchip,hw-device-address
> > >    - spi-max-frequency
> > > =20
> > >  allOf:
> > > @@ -159,7 +165,7 @@ examples:
> > >              spi-cpha;
> > >              spi-cpol;
> > >              spi-max-frequency =3D <10000000>;
> > > -            microchip,hw-device-address =3D <1>;
> > > +            spi-device-addr =3D <1>;
> > > =20
> > >              #address-cells =3D <1>;
> > >              #size-cells =3D <0>;
> > >  =20
> >=20
>=20

--xuABnB4oaxi0GLxH
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCamjSNwAKCRB4tDGHoIJi
0rn4AP42ioQsDXk1nWfaQ52szjKb9oAfOTImJ1DGK2rKiMAIMAEA+twTrfpIzo0F
YYUt5tBk1kRPX4fcAx5R0otddEZVbww=
=qzWE
-----END PGP SIGNATURE-----

--xuABnB4oaxi0GLxH--
