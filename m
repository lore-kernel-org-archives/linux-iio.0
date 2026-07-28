Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BEA3B585F;
	Tue, 28 Jul 2026 16:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785255064; cv=none; b=JbkEQgt/GVKYJVsEusf1zBWCoy2CGD/Q5yTxWlNFBK1OAXs4iUsPqaXSc98+3EyVqLANoPGXmMtaIMCgJbqoALdxi8FYgR4dasnR40/1gKjBYyMCx127sd2MGhTH54kXkFSOjim5ggaaGHITPO2fUZZvVV3/EmL3hGm4We7r1N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785255064; c=relaxed/simple;
	bh=zqyea4KlW9sx7WyP8RD66yutgT12sdYjOh4dqAjdo6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZPhc9heyROM0nQ7c3JDtxbaCKWf1qoE017j8CklGOJ0ovN4N1KofYRSRgHSbyi/f0g2JDa7s/E039Bvh1Y+bboCHhls/gmwpzBcWNVSNvo1YLxihzxiFpQFPU88/I5Nk4X8vH0/uL66jjbO7yc2cQ0m9q7l9Cpj/tN0L9uA1IhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IFVpm3Zr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IFVpm3Zr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF4BA1F000E9;
	Tue, 28 Jul 2026 16:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785255063;
	bh=LK45KgmTPBDfsOlZRJLoIZIxy0qO+UzbMPT7ybgozpU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IFVpm3ZrjoXsKOuw74h/r1oiQBCFEgQvVGOpY3ZZvxrZgp3XuDN4XuSSgrZ6hm1JS
	 d3XDkcCsZ9D2wT8oIs0SxcJbTUrEXKmFZeriLYm+OJuuHsEl1kkZ+EYvCQMJJ775/z
	 43RJeBwWOT2CG11HM+wJKio4pqkZQpq5tK13QDQ2o8tHEFzaL79uAwmBO6XrQ9OABw
	 zkN4hpZJ9JsBP5IQaxxi15BBdxYgwBFOT7eUtfFe6aEID0EXnaHGRwvu6dfwBL+AVx
	 ommqUvtZTTEU+EBbIiDZn/nQVaMTFqZI7mz7qajAjkONMtBJ7/sPBF8QS828KIB6qP
	 i2o3yoyA5xysw==
Date: Tue, 28 Jul 2026 17:10:55 +0100
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
Subject: Re: [PATCH v7 1/7] spi: dt-bindings: Add spi-device-addr peripheral
 property
Message-ID: <20260728-barrette-rickety-788b47da503c@spud>
References: <20260722-ad5529r-driver-v7-0-7781cd74ad75@analog.com>
 <20260722-ad5529r-driver-v7-1-7781cd74ad75@analog.com>
 <e2118cfc-feef-4843-917f-844834ef4e60@baylibre.com>
 <20260725230445.60a445a0@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HZvrUuI80rBimIHj"
Content-Disposition: inline
In-Reply-To: <20260725230445.60a445a0@jic23-huawei>

--HZvrUuI80rBimIHj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 25, 2026 at 11:04:45PM +0100, Jonathan Cameron wrote:
> On Sat, 25 Jul 2026 15:55:01 -0500
> David Lechner <dlechner@baylibre.com> wrote:
>=20
> > On 7/22/26 2:54 AM, Janani Sunil wrote:
> > > Some SPI devices support sharing a single chip select across multiple
> > > physical chips by encoding a device address in the SPI frame itself.
> > > Add the generic spi-device-addr property for describing these hardware
> > > addresses. The property is placed on the SPI peripheral node and may
> > > contain multiple addresses.
> > >=20
> > > Signed-off-by: Janani Sunil <janani.sunil@analog.com>
> > > ---
> > >  Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml | 7 =
+++++++
> > >  1 file changed, 7 insertions(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-pro=
ps.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> > > index 880a9f624566..b59d047cf117 100644
> > > --- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> > > +++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> > > @@ -142,6 +142,13 @@ properties:
> > >      minItems: 2
> > >      maxItems: 4
> > > =20
> > > +  spi-device-addr:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > > +    description:
> > > +      Device addresses used when multiple peripherals share a single=
 chip
> > > +      select. The array allows one logical peripheral to comprise mu=
ltiple
> > > +      physical devices, with one address per device. =20
> >=20
> > "per physical device" for clarity.
> >=20
>=20
> We may end up relaxing that again if multichip packages start doing this.
> Fine to add that clarification for now. We can revisit when / if it ever
> needs that relaxing.
>=20
> > > +
> > >    st,spi-midi-ns:
> > >      deprecated: true
> > >      description: |
> > >  =20
> >=20
> > If there is nothing useful the SPI core code can do with this informati=
on,
> > I'm not entirely convinced that this needs to be a common property.
>=20
> I think being common does make some sense from a standarization point of
> view and it isn't obvious where to put it other than under spi.
>=20
> >=20
> > And this only allows for one logical device. If we wanted to treat each
> > address as a logical device (all with same CS), we would need #address-=
cells =3D <2>;
> > instead where the DT "address" is two values, the CS and the device add=
ress.
>=20
> Ah.  Good point for the adc@address or similar needing to match a combina=
tion
> of CS and spi-device-addr.  Conor any thoughts on how this would be done?

I'm sorry, I don't quite understand. Why do you want to support both of
these representations? Hardware wise both of these things would be
describing the same setup, so allowing this alternate "multiple logical
device" typically is not permitted. What even is the use case of it?
Does it matter at all if you have one or more logical devices from a
consumer perspective?

I do have an idea of how to solve the adc@address problem (you can do
adc@address,spi-device-address like some other devices) but as I said I
don't get why it would be needed.

>=20
>=20
> Also feels like this series should update the one use of the microchip bi=
nding
> in tree.
>=20
> arch/riscv/boot/dts/microchip/mpfs-beaglev-fire.dts

I never asked for this cos I maintain the platform and was gonna fix it
up myself, but sure!

--HZvrUuI80rBimIHj
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCamjUjwAKCRB4tDGHoIJi
0mFNAP9Jwjj7O7DOBVj8zE3EFT87Ba1ni0zhggv16veVcF9ajQEAg6puaVmWx6DC
kZ8+kniDQr2Dmg/yIXhaPolKuUKbcQY=
=ncSq
-----END PGP SIGNATURE-----

--HZvrUuI80rBimIHj--
