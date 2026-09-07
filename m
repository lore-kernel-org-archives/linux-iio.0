Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB79D4CC278;
	Mon,  7 Sep 2026 17:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788803585; cv=none; b=Nh7rRHbZW1xub4E65hfDEbJ36aWPzpVq+zxE0YhSt9SKMwq0kTgNV5CKHuHvLhtHlr9XfRbYE0UYl7sD2gFA2m4IzTwzW30N7JyPAXVcVFOkfvVlFpONtVyF/JDo8gVLxB18wGjhblq3RVioaz/Q1mT7XOeXMLWNsEcSkYqM3x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788803585; c=relaxed/simple;
	bh=YEob9+3uE0LvCPS+REEuqlGCRg+gBTeNIHjJ4G7qisU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=psNlizKGiMxwnuWGvYXjMliH1sidZB5+5a6VjrfrJixQxb16kpj4cjWi3hgA/LT6NtwdLbGLrEpb34vDQQTVxe9M1Ti/gToiHQUKlUbyapVVo6zV0xbxLSsrLuwxxFZxAmGqp6fDB68eTFhFLUee7u43KOBHaryTwlg6qMFBH84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D5OrGzVy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D5OrGzVy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC5D81F00A3A;
	Mon,  7 Sep 2026 17:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788803583;
	bh=wsVrdBjgarsPKAo/VONyLn7OmxGtz5mxqy1STU9zaAs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=D5OrGzVy0Yq32Y1hpJiX5YHiC+nmc4837JmsXJcwk+18fblx+E//BZiRxalLu7O+G
	 K2Sqapp+JP4/WOMsqghZHCyUqE8b+dBQWIJ+HAJCxiOAUMPau7aWKJePMvOh77hohw
	 hVHimowHRaVIVodB8fCYUygL9gkeTkB1ce27u1RTxnIn+To3tsLXi1d51rssUgjBNG
	 2aPofYuGjH6rEuis+jTIR9WoapcGipVoL87h+QrVHlumwFElaDK/rPNCRSpJcKBs/A
	 E86SI8rZdpt0tjwAnfygMzQyfTpCKKWpxznkm/eRPFbtSLa1492tQOkBCplzNAMgZt
	 NIsXrT1srG2IQ==
Date: Mon, 7 Sep 2026 18:52:59 +0100
From: Conor Dooley <conor@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux@analog.com, jic23@kernel.org, nuno.sa@analog.com,
	dlechner@baylibre.com, andy@kernel.org,
	Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org
Subject: Re: [PATCH v1 08/13] dt-bindings: iio: adc: adi,ad4134: Document SPI
 connection mode
Message-ID: <20260907-spectator-venomous-7528abe370d8@spud>
References: <cover.1788368334.git.marcelo.schmitt@analog.com>
 <d9b759d29fa8ca12b6cf083e180b2556ca4533f0.1788368334.git.marcelo.schmitt@analog.com>
 <20260903-liquefy-prologue-9ec914cccf04@spud>
 <apsufKf-EOvTfpwf@debian-BULLSEYE-live-builder-AMD64>
 <aptA9HP82-ss45JF@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="n6+ZSME9ltcE4Rq6"
Content-Disposition: inline
In-Reply-To: <aptA9HP82-ss45JF@debian-BULLSEYE-live-builder-AMD64>

--n6+ZSME9ltcE4Rq6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 04, 2026 at 07:06:44PM -0300, Marcelo Schmitt wrote:
> On 09/04, Marcelo Schmitt wrote:
> > On 09/03, Conor Dooley wrote:
> > > On Wed, Sep 02, 2026 at 02:24:02PM -0300, Marcelo Schmitt wrote:
> > > > Document how AD4134 chips are connected to the host SPI controller
> > > > according to different wiring configurations.
> > > >=20
> > > > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > > > ---
> > > >  .../bindings/iio/adc/adi,ad4134.yaml          | 22 +++++++++++++++=
++++
> > > >  1 file changed, 22 insertions(+)
> > > >=20
> > > > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4134.y=
aml b/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
> > > > index ea6d7e026419..d843c02a394a 100644
> > > > --- a/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
> > > > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
> > > > @@ -131,6 +131,28 @@ properties:
> > > >      enum: [ free-running, gated ]
> > > >      default: gated
> > > > =20
> > > > +  adi,spi-mode:
> > > > +    $ref: /schemas/types.yaml#/definitions/string
> > > > +    enum: [ no-cs, 4-wire, one-channel-chain, two-channel-chain ]
> > > > +    description: |
> > > > +      This property indicates the SPI wiring configuration.
> > > > +
> > > > +      When this property is omitted, it is assumed that the device=
 is using
> > > > +      'no-cs' wiring. When this property is present, it indicates =
that the
> > > > +      device is using one of the following wiring configurations:
> > >=20
> > ...
> > > I'd also really appreciate a dts example for a system
> > > with one-channel-chain or two-channel-chain looks, given the second
> > > device may require different supplies etc. I have no impression in my
> > > head of how the dt would be constructed, so I'd like to see wht you h=
ave
> > > in mind.
> >=20
> ...
>=20
> Realized what I said doesn't make much sense. The peripherals can all have
> the same configuration and thus share CS, SCLK, and controller SDO. The w=
iring
> would be like the following
>=20
> ::
>=20
>   +-----------------------+                               +--------------=
---+
>   |         AD4134        |                               | SPI Controlle=
r  |
>   |                       |                               |              =
   |
>   |                       |                               |              =
   |
>   | SPI interface    SCLK |<--------------------+---------| SCLK         =
   |
>   | for register       CS |<--------------------|-+-------| CS           =
   |
>   | access            SDI |<--------------------|-|-+-----| SDO          =
   |
>   |                   SDO |------->|=AF=AF=AF=AF\       | | |     |      =
           |
>   |                       |        |MUX  >------|-|-|---->| SDI0         =
   |
>   | Data interface  DOUT0 |------->|____/<------|-|-|---- | GPIO         =
   |
>   | for ADC sample  DOUT1 |---------------------|-|-|---->| SDI1         =
   |
>   | data read        DCLK |<-------------+------|-|-|-----| DCLK         =
   |
>   |                 DOUT2 |<-+           |      | | |     |              =
   |
>   |                 DOUT3 |<-|-+         |      | | |     |              =
   |
>   |                   ODR |<-|-|---------|--+   | | |  +->| Offload Trigg=
er |
>   +-----------------------+  | |         |  |   | | |  |  +--------------=
---+
>                              | |         |  |   | | |  +--| PWM1         =
   |
>                              | |         |  +---| | | ----| PWM0         =
   |
>                              | |         |  |   | | |    +---------------=
--+
>                              | |         |  |   | | |
>   +-----------------------+  | |         |  |   | | |
>   |         AD4134        |  | |         |  |   | | |
>   |                       |  | |         |  |   | | |
>   | SPI interface         |  | |         |  |   | | |
>   | for register     SCLK |<-|-|---------|--|---+ | |
>   | access             CS |<-|-|---------|--|---|-+ |
>   |                   SDI |<-|-|---------|--|---|-|-+
>   |                   SDO |  | |         |  |   | | |
>   | Data interface        |  | |         |  |   | | |
>   | for ADC sample  DOUT0 |--+ |         |  |   | | |
>   | data read       DOUT1 |----+         |  |   | | |
>   |                 DOUT2 |<-+           |  |   | | |
>   |                 DOUT3 |<-|-+         |  |   | | |
>   |                  DCLK |<-|-|---------+  |   | | |
>   |                   ODR |<-|-|---------|--+   | | |
>   +-----------------------+  | |         |  |   | | |
>                              | |         |  |   | | |
>                              | |         |  |   | | |
>                              | |         |  |   | | |
>   +-----------------------+  | |         |  |   | | |
>   |         AD4134        |  | |         |  |   | | |
>   |                       |  | |         |  |   | | |
>   |                       |  | |         |  |   | | |
>   | SPI interface    SCLK |<-|-|---------|--|---+ | |
>   | for register       CS |<-|-|---------|--|-----+ |
>   | access            SDI |<-|-|---------|--|-------+
>   |                       |  | |         |  |
>   | Data interface        |  | |         |  |
>   | for ADC sample  DOUT0 |--+ |         |  |
>   | data read       DOUT1 |----+         |  |
>   |                 DOUT2 |              |  |
>   |                 DOUT3 |              |  |
>   |                  DCLK |<-------------+  |
>   |                   ODR |<----------------+
>   +-----------------------+
>=20
>=20
> So we would set them as only one daisy-chained device.
>=20
>     spi {
>         ...
>         adc@0 {
>             compatible =3D "adi,ad4134";
>             reg =3D <0>;
>             spi-rx-bus-width =3D <1>, <1>; /* 2 lanes of 1 bit each */
>=20
>             <supplies, clock, and other properties ...>=20
>=20
>             #daisy-chained-devices =3D <2>;

Does this property actually provide value here? I assume it does because
otherwise you don't know how many devices there are.

>             adi,spi-mode =3D "two-channel-chain";

How does this interact with spi-rx-bus-width? Is the value of this
consistent with adi,spi-mode? IOW, for adi,spi-mode =3D "one.." will there
only ever be Dout0 connected to the host and for adi,spi-mode =3D "two.."
will Dout1 and Dout0 both be connected?


--n6+ZSME9ltcE4Rq6
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCap75+gAKCRB4tDGHoIJi
0q5LAQDx62EY+AFAzDAtzCp1+6FnL3pZMjBjOvgyLMgEbnVt9AEA6pyQiAt0cLcL
YrWcVVLAd0X48SealNR6jCunC56JhQM=
=ojBZ
-----END PGP SIGNATURE-----

--n6+ZSME9ltcE4Rq6--
