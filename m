Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED2D35AC13;
	Tue, 15 Sep 2026 14:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789481194; cv=none; b=KZmelO7r9d60bqDdAhqpMOvT1nWby5L4FY8qy3y3O4NzG3G+fykgcPMX7mnszP6YaYImIf/L1vLj+sLHxkfvEhQOcBVeVKdWF6n2AcxLxP1x/sYnMAs602q+n4yIAtJ1KyXciQBuuyOMs9289e5MXFKjZXp0VckUBcP1ikDpDLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789481194; c=relaxed/simple;
	bh=Ydvqmi7oGtXorKICVb6rxVCDdI63+NfGhRObRmmQEn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OXESX9wKLSiqQM3AQUcWFJmsWjmDj7Lql/WtNKcMYUgXTtlWueoL6SHW2bQPjp2TmP3BBL+XRCGtno3HDthQhN/p218CtKsQ8x1PFvJyhLM8sOmn9finj1PFjaA8goh95ebll584CwSV6+PAFrGApy6/ZxX2pGjTrEk8v+5ubyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=afNAdbEZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="afNAdbEZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 754EC1F000FF;
	Tue, 15 Sep 2026 14:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789481192;
	bh=vDrgeCfksilqmV+oRZGdr+ouCSw9J7x6MWCnT6kEu4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=afNAdbEZyXIqyX2NcvX9f52Rb1Iq1odZMGLzNamM1ZB/EtWjzfFSnaXhjvDs0q5io
	 bUZduPHz1gtZkxEblhNXBo9YXOqbz8DgzWt0b2XM4oLM65sadWnSzN1GUxqqeTuBAw
	 XQQy6JjY5kl/Qgs/fGfo7eQZ0iolI5ySmWv7xAbPlOskIwZz275EjG0Qz/9f3MOb1M
	 NuwMv952Q8g6tzst2Ncu/okeUcrsy0oej4XQOfRDDV0V1FZGJ898aYjufMf/NJ8UoQ
	 DxcjJlK7cdTEHgcDpvkHc1mX5L49KvpIPrhhHTixrbMti6UbnFQIZjFs/hy/0dyzkJ
	 M8ae1igGwJLUg==
Date: Tue, 15 Sep 2026 15:06:27 +0100
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
Message-ID: <20260915-barbell-divided-6dcb0c59af9a@spud>
References: <cover.1788368334.git.marcelo.schmitt@analog.com>
 <d9b759d29fa8ca12b6cf083e180b2556ca4533f0.1788368334.git.marcelo.schmitt@analog.com>
 <20260903-liquefy-prologue-9ec914cccf04@spud>
 <apsufKf-EOvTfpwf@debian-BULLSEYE-live-builder-AMD64>
 <aptA9HP82-ss45JF@debian-BULLSEYE-live-builder-AMD64>
 <20260907-spectator-venomous-7528abe370d8@spud>
 <aqMs2CbWbhzCoDOB@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="02j8IEISV4+meAWL"
Content-Disposition: inline
In-Reply-To: <aqMs2CbWbhzCoDOB@debian-BULLSEYE-live-builder-AMD64>

--02j8IEISV4+meAWL
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 07:19:04PM -0300, Marcelo Schmitt wrote:
> Hello Conor, sorry for delayed reply.
>=20
> On 09/07, Conor Dooley wrote:
> > On Fri, Sep 04, 2026 at 07:06:44PM -0300, Marcelo Schmitt wrote:
> > > On 09/04, Marcelo Schmitt wrote:
> > > > On 09/03, Conor Dooley wrote:
> > > > > On Wed, Sep 02, 2026 at 02:24:02PM -0300, Marcelo Schmitt wrote:
> > > > > > Document how AD4134 chips are connected to the host SPI control=
ler
> > > > > > according to different wiring configurations.
> > > > > >=20
> > > > > > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > > > > > ---
> > > > > >  .../bindings/iio/adc/adi,ad4134.yaml          | 22 +++++++++++=
++++++++
> > > > > >  1 file changed, 22 insertions(+)
> > > > > >=20
> > > > > > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad41=
34.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
> > > > > > index ea6d7e026419..d843c02a394a 100644
> > > > > > --- a/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
> > > > > > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
> > > > > > @@ -131,6 +131,28 @@ properties:
> > > > > >      enum: [ free-running, gated ]
> > > > > >      default: gated
> > > > > > =20
> > > > > > +  adi,spi-mode:
> > > > > > +    $ref: /schemas/types.yaml#/definitions/string
> > > > > > +    enum: [ no-cs, 4-wire, one-channel-chain, two-channel-chai=
n ]
> > > > > > +    description: |
> > > > > > +      This property indicates the SPI wiring configuration.
> > > > > > +
> > > > > > +      When this property is omitted, it is assumed that the de=
vice is using
> > > > > > +      'no-cs' wiring. When this property is present, it indica=
tes that the
> > > > > > +      device is using one of the following wiring configuratio=
ns:
> > > > >=20
> > > > ...
> > > > > I'd also really appreciate a dts example for a system
> > > > > with one-channel-chain or two-channel-chain looks, given the seco=
nd
> > > > > device may require different supplies etc. I have no impression i=
n my
> > > > > head of how the dt would be constructed, so I'd like to see wht y=
ou have
> > > > > in mind.
> > > >=20
> > > ...
> > >=20
> > > Realized what I said doesn't make much sense. The peripherals can all=
 have
> > > the same configuration and thus share CS, SCLK, and controller SDO. T=
he wiring
> > > would be like the following
> > >=20
> > > ::
> > >=20
> > >   +-----------------------+                               +----------=
-------+
> > >   |         AD4134        |                               | SPI Contr=
oller  |
> > >   |                       |                               |          =
       |
> > >   |                       |                               |          =
       |
> > >   | SPI interface    SCLK |<--------------------+---------| SCLK     =
       |
> > >   | for register       CS |<--------------------|-+-------| CS       =
       |
> > >   | access            SDI |<--------------------|-|-+-----| SDO      =
       |
> > >   |                   SDO |------->|=AF=AF=AF=AF\       | | |     |  =
               |
> > >   |                       |        |MUX  >------|-|-|---->| SDI0     =
       |
> > >   | Data interface  DOUT0 |------->|____/<------|-|-|---- | GPIO     =
       |
> > >   | for ADC sample  DOUT1 |---------------------|-|-|---->| SDI1     =
       |
> > >   | data read        DCLK |<-------------+------|-|-|-----| DCLK     =
       |
> > >   |                 DOUT2 |<-+           |      | | |     |          =
       |
> > >   |                 DOUT3 |<-|-+         |      | | |     |          =
       |
> > >   |                   ODR |<-|-|---------|--+   | | |  +->| Offload T=
rigger |
> > >   +-----------------------+  | |         |  |   | | |  |  +----------=
-------+
> > >                              | |         |  |   | | |  +--| PWM1     =
       |
> > >                              | |         |  +---| | | ----| PWM0     =
       |
> > >                              | |         |  |   | | |    +-----------=
------+
> > >                              | |         |  |   | | |
> > >   +-----------------------+  | |         |  |   | | |
> > >   |         AD4134        |  | |         |  |   | | |
> > >   |                       |  | |         |  |   | | |
> > >   | SPI interface         |  | |         |  |   | | |
> > >   | for register     SCLK |<-|-|---------|--|---+ | |
> > >   | access             CS |<-|-|---------|--|---|-+ |
> > >   |                   SDI |<-|-|---------|--|---|-|-+
> > >   |                   SDO |  | |         |  |   | | |
> > >   | Data interface        |  | |         |  |   | | |
> > >   | for ADC sample  DOUT0 |--+ |         |  |   | | |
> > >   | data read       DOUT1 |----+         |  |   | | |
> > >   |                 DOUT2 |<-+           |  |   | | |
> > >   |                 DOUT3 |<-|-+         |  |   | | |
> > >   |                  DCLK |<-|-|---------+  |   | | |
> > >   |                   ODR |<-|-|---------|--+   | | |
> > >   +-----------------------+  | |         |  |   | | |
> > >                              | |         |  |   | | |
> > >                              | |         |  |   | | |
> > >                              | |         |  |   | | |
> > >   +-----------------------+  | |         |  |   | | |
> > >   |         AD4134        |  | |         |  |   | | |
> > >   |                       |  | |         |  |   | | |
> > >   |                       |  | |         |  |   | | |
> > >   | SPI interface    SCLK |<-|-|---------|--|---+ | |
> > >   | for register       CS |<-|-|---------|--|-----+ |
> > >   | access            SDI |<-|-|---------|--|-------+
> > >   |                       |  | |         |  |
> > >   | Data interface        |  | |         |  |
> > >   | for ADC sample  DOUT0 |--+ |         |  |
> > >   | data read       DOUT1 |----+         |  |
> > >   |                 DOUT2 |              |  |
> > >   |                 DOUT3 |              |  |
> > >   |                  DCLK |<-------------+  |
> > >   |                   ODR |<----------------+
> > >   +-----------------------+
> > >=20
> > >=20
> > > So we would set them as only one daisy-chained device.
> > >=20
> > >     spi {
> > >         ...
> > >         adc@0 {
> > >             compatible =3D "adi,ad4134";
> > >             reg =3D <0>;
> > >             spi-rx-bus-width =3D <1>, <1>; /* 2 lanes of 1 bit each */
> > >=20
> > >             <supplies, clock, and other properties ...>=20
> > >=20
> > >             #daisy-chained-devices =3D <2>;
> >=20
> > Does this property actually provide value here? I assume it does because
> > otherwise you don't know how many devices there are.
>=20
> Yes, the number of daisy-chained-devices is needed to determine how much =
data
> to transfer on ADC sample read. We already have some documentation in
> Documentation/devicetree/bindings/common-properties.txt
>=20
> >=20
> > >             adi,spi-mode =3D "two-channel-chain";
> >=20
> > How does this interact with spi-rx-bus-width? Is the value of this
> > consistent with adi,spi-mode? IOW, for adi,spi-mode =3D "one.." will th=
ere
> > only ever be Dout0 connected to the host and for adi,spi-mode =3D "two.=
=2E"
> > will Dout1 and Dout0 both be connected?
>=20
> For this particular ADC design, yes.
> adi,spi-mode =3D "one-channel-chain" always expects spi-rx-bus-width =3D =
<1> (only DOUT0) and
> adi,spi-mode =3D "two-channel-chain" always expects spi-rx-bus-width =3D =
<1>, <1> (DOUT0, DOOUT1).
> Though, it is possible to have spi-rx-bus-width =3D <1> and
> spi-rx-bus-width =3D <1>, <1> in non-chained setups.
>=20
> Will make the constraints explicit on v2.

If you think that helps, sure. I was mostly asking this for my own
education, because this kind of device is new to me, so that I know what
to expect from future bindings of the same kind (and to have a record on
lore when I inevitably forget).

> allOf:
>   ...
>   - oneOf:
>       - required: [adi,spi-mode, '#daisy-chained-devices']
>         properties:
>           adi,spi-mode:
>             const: one-channel-chain
>           spi-rx-bus-width:
>             maxItems: 1

Is this enough of a constraint? Someone could still put in
spi-rx-bus-width =3D <2>...

>       - required: [adi,spi-mode, '#daisy-chained-devices']
>         properties:
>           adi,spi-mode:
>             const: two-channel-chain
>           spi-rx-bus-width:
>             minItems: 2
>             maxItems: 2

=2E..or spi-rx-bus-width =3D <2>, <3> here which conflicts with your
comment above, right?

Prob worth limiting the actual item to 1, if you're gonna add
constraints like this.

>       - properties:
>           '#daisy-chained-devices': false
>=20
>=20
> Best regards,
> Marcelo

--02j8IEISV4+meAWL
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaqlQ4wAKCRB4tDGHoIJi
0jK8AP4kewj6h6y9P7+FEpGzYtadpIaHbtheWP44Wr85QSVzFQEAhPRUAYfd97Zq
5S1/yVIYUtFRR6FZCaS9c+pO00E7kQ8=
=5ej0
-----END PGP SIGNATURE-----

--02j8IEISV4+meAWL--
