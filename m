Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205133A4520;
	Tue, 28 Jul 2026 17:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785259071; cv=none; b=tr6nsL10mgYuU/rZTriHKAfOUe8HrtiIBsWCXXVkcni3Ylx4pZBoY4lioPIZueAe+1XRMIr+4L6KLymbXOFdg2L+IT6O0Ib5CNlrU9GqckemnQiDET0li/yndP7ypOKPCcwY1YilQvtIesEQ3y+802lpqpdqZNL3a2ST9okIl6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785259071; c=relaxed/simple;
	bh=G5R7i+aPgn+07RDSIswRGGE2zgpzt38nbqfW+pLRlZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PlGwPaMBOca2OkDSlUsCxxPm6pLctgcE+4mtvV0kNbCh8DQt0zHXWnx9nVC3IHF75vhWgAnhZhHGoA48evgnfZ+dlhy3oM+X93yX0cvwsNSU79qyCZSymG3qD2GE2SyoXfRSMhAXzIJ6TQxPiKB23UAFC9ikJUTe07+lEynftNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mt2SiYcY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mt2SiYcY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 005901F000E9;
	Tue, 28 Jul 2026 17:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785259069;
	bh=cP5uyX/Ak4CcBpcQpYrTmHEcHHF020OXirq0cq4a+uo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Mt2SiYcYqCfJxgQuH1qFE5UstflYD1u3ZbDNsHVLse+r2Q2HhoEjtl3qG3acfqloy
	 lYZj6Uk/wn78AQ+vsnflWobJzBdN7B145rtctbqouCWE8b7X0KElgs1HtuM5+JwDZM
	 dIbf+5/ANQZow6gzuZ7NPbT8JpEytY7/RXFRRCFuH3wd0M2gw0PINi83yJLb2QjGy0
	 YQcqHyA823Bv9qJqmQmsZ5lEBYepSDDWEObe3D90d7Wgy9008gyLbKfahS9IQhxrHg
	 DOqNyBGo8O3F3HufdJYhPt2KTTOIQgPxga0bYf7l7yhYYqNI9FG/uF45x5faDZdZjl
	 yFjjpICBKGGqA==
Date: Tue, 28 Jul 2026 18:17:42 +0100
From: Conor Dooley <conor@kernel.org>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
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
Message-ID: <20260728-riot-laboring-21f5752b0486@spud>
References: <20260722-ad5529r-driver-v7-0-7781cd74ad75@analog.com>
 <20260722-ad5529r-driver-v7-1-7781cd74ad75@analog.com>
 <e2118cfc-feef-4843-917f-844834ef4e60@baylibre.com>
 <20260725230445.60a445a0@jic23-huawei>
 <20260728-barrette-rickety-788b47da503c@spud>
 <amjgbH3VpssOlFzs@nsa>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PTbDVJDQKKZ40tbF"
Content-Disposition: inline
In-Reply-To: <amjgbH3VpssOlFzs@nsa>

--PTbDVJDQKKZ40tbF
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 06:06:32PM +0100, Nuno S=E1 wrote:
> On Tue, Jul 28, 2026 at 05:10:55PM +0100, Conor Dooley wrote:
> > On Sat, Jul 25, 2026 at 11:04:45PM +0100, Jonathan Cameron wrote:
> > > On Sat, 25 Jul 2026 15:55:01 -0500
> > > David Lechner <dlechner@baylibre.com> wrote:
> > >=20
> > > > On 7/22/26 2:54 AM, Janani Sunil wrote:
> > > > > Some SPI devices support sharing a single chip select across mult=
iple
> > > > > physical chips by encoding a device address in the SPI frame itse=
lf.
> > > > > Add the generic spi-device-addr property for describing these har=
dware
> > > > > addresses. The property is placed on the SPI peripheral node and =
may
> > > > > contain multiple addresses.
> > > > >=20
> > > > > Signed-off-by: Janani Sunil <janani.sunil@analog.com>
> > > > > ---
> > > > >  Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml =
| 7 +++++++
> > > > >  1 file changed, 7 insertions(+)
> > > > >=20
> > > > > diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral=
-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.ya=
ml
> > > > > index 880a9f624566..b59d047cf117 100644
> > > > > --- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.=
yaml
> > > > > +++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.=
yaml
> > > > > @@ -142,6 +142,13 @@ properties:
> > > > >      minItems: 2
> > > > >      maxItems: 4
> > > > > =20
> > > > > +  spi-device-addr:
> > > > > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > > > > +    description:
> > > > > +      Device addresses used when multiple peripherals share a si=
ngle chip
> > > > > +      select. The array allows one logical peripheral to compris=
e multiple
> > > > > +      physical devices, with one address per device. =20
> > > >=20
> > > > "per physical device" for clarity.
> > > >=20
> > >=20
> > > We may end up relaxing that again if multichip packages start doing t=
his.
> > > Fine to add that clarification for now. We can revisit when / if it e=
ver
> > > needs that relaxing.
> > >=20
> > > > > +
> > > > >    st,spi-midi-ns:
> > > > >      deprecated: true
> > > > >      description: |
> > > > >  =20
> > > >=20
> > > > If there is nothing useful the SPI core code can do with this infor=
mation,
> > > > I'm not entirely convinced that this needs to be a common property.
> > >=20
> > > I think being common does make some sense from a standarization point=
 of
> > > view and it isn't obvious where to put it other than under spi.
> > >=20
> > > >=20
> > > > And this only allows for one logical device. If we wanted to treat =
each
> > > > address as a logical device (all with same CS), we would need #addr=
ess-cells =3D <2>;
> > > > instead where the DT "address" is two values, the CS and the device=
 address.
> > >=20
> > > Ah.  Good point for the adc@address or similar needing to match a com=
bination
> > > of CS and spi-device-addr.  Conor any thoughts on how this would be d=
one?
> >=20
> > I'm sorry, I don't quite understand. Why do you want to support both of
> > these representations? Hardware wise both of these things would be
> > describing the same setup, so allowing this alternate "multiple logical
> > device" typically is not permitted. What even is the use case of it?
> > Does it matter at all if you have one or more logical devices from a
> > consumer perspective?
> >=20
> > I do have an idea of how to solve the adc@address problem (you can do
> > adc@address,spi-device-address like some other devices) but as I said I
> > don't get why it would be needed.
>=20
> IIUC, I think for the current ADI device it could actually be useful to h=
ave
> the above representation given that, in theory, any of the logical
> devices can have their own supplies, pins, etc (so it would help to have
> each of them as adc@address,spi-device-address)... But we choose not to go
> down that path (in previous versions) for simplicity. So yeah, not sure

You can have either representation, I don't really care, they're much of
a muchness to me. Just you can't have both!

> :).
>=20
> - Nuno S=E1
>=20
> >=20
> > >=20
> > >=20
> > > Also feels like this series should update the one use of the microchi=
p binding
> > > in tree.
> > >=20
> > > arch/riscv/boot/dts/microchip/mpfs-beaglev-fire.dts
> >=20
> > I never asked for this cos I maintain the platform and was gonna fix it
> > up myself, but sure!
>=20
>=20

--PTbDVJDQKKZ40tbF
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCamjkNgAKCRB4tDGHoIJi
0tDzAQD1eLvcNgHKFZmG02MdYRWuzwVyRhI6ahm9VKUXPI8ykgD/amgLx6jgTYB5
8wgMq4RkZLn56LxshmnCbdAkMESb7AU=
=J+ZH
-----END PGP SIGNATURE-----

--PTbDVJDQKKZ40tbF--
