Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D5C126C02;
	Sun,  6 Sep 2026 19:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788722798; cv=none; b=cjsotwcZBbZzfsHr4HO07FVaG9d66LFrXfJ85I+L1ry9KJot0Eh0MXGbGwMigm/ZtzqXbTP3TbwyFcfwU47xgcZDoDb+10+TWojGiidjLoVm75hr2JEfF+/ffFxxK9BrX9DlLUL7C5qJYcc3Lj1Il7zZy1/0DeporOOVvAifobg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788722798; c=relaxed/simple;
	bh=US1G9RjDnKOUlxnrr3RUS8dXtFGEo68OYqCU4wRpnsw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qV9cmteLx3KlLHJ+5k+n7YutEK5WoLwRO7UDws27nbFnDKgJ/dhfEgJl5qFYEplosaNgu+QnPG9zBkxnvgdlp9y5n5YQvGM2VbP6YmMrzT3HtNaCfUOp2cF7O05X7eW4gzFz5WyvOa0HVv+/cSfkXb7r6MIR7HV5vreKsVHFlrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hdqR4pK/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hdqR4pK/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F9991F00A3A;
	Sun,  6 Sep 2026 19:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788722796;
	bh=9ixawut2S9r983EsH04soarW6ihd+uZaRCYhJJQkJtI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hdqR4pK/pr1n9cCn/iWlGWeG6wPSfoMIJE0Q8KzbLUTvVjKYBx0p/z8ExWHTTGexp
	 b6GZccbAjMK21wcCjH/KgJk+DaqJpAot4x/0kpSsG1p9g22XBFIK28H+JiU5Ke6A7n
	 OojvHo/H447ttUEyu9qcpQZTI+J+hyPvQJqzUweL/ARRkb+d2Zr9d/JFiet3M58Te9
	 /LFGtzZn0CaRl0AAyuUoEEmpwW/DbMiWm27eNhOCyP6ZpZLJeyrCAWNEFQu0TZqH9A
	 Q9prOzFweR1uzVQYmHg+/nmXcJc4Mrm8s3bBLJWU3VE3uAqxoxzDObSRLnXvm1olHx
	 tby5Re9iTI9wg==
Date: Sun, 6 Sep 2026 20:26:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Conor Dooley <conor@kernel.org>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux@analog.com,
 nuno.sa@analog.com, dlechner@baylibre.com, andy@kernel.org,
 Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org
Subject: Re: [PATCH v1 08/13] dt-bindings: iio: adc: adi,ad4134: Document
 SPI connection mode
Message-ID: <20260906202630.64d8fa75@jic23-huawei>
In-Reply-To: <aptA9HP82-ss45JF@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1788368334.git.marcelo.schmitt@analog.com>
	<d9b759d29fa8ca12b6cf083e180b2556ca4533f0.1788368334.git.marcelo.schmitt@analog.com>
	<20260903-liquefy-prologue-9ec914cccf04@spud>
	<apsufKf-EOvTfpwf@debian-BULLSEYE-live-builder-AMD64>
	<aptA9HP82-ss45JF@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 4 Sep 2026 19:06:44 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> On 09/04, Marcelo Schmitt wrote:
> > On 09/03, Conor Dooley wrote: =20
> > > On Wed, Sep 02, 2026 at 02:24:02PM -0300, Marcelo Schmitt wrote: =20
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
> > > > +      device is using one of the following wiring configurations: =
=20
> > ... =20
> > > I'd also really appreciate a dts example for a system
> > > with one-channel-chain or two-channel-chain looks, given the second
> > > device may require different supplies etc. I have no impression in my
> > > head of how the dt would be constructed, so I'd like to see wht you h=
ave
> > > in mind. =20
> >  =20
> ...
>=20
> Realized what I said doesn't make much sense. The peripherals can all have
> the same configuration and thus share CS, SCLK, and controller SDO. The w=
iring
> would be like the following

That mux in the middle is controlled how?
I'd assume we still have separate chip selects and SDO/SDI shared. So I'd e=
xpect
those to be on one SPI bus and the data to be going into separate buses
(maybe all that can be hidden in the backend, not sure).

Or are you suggesting we are just letting all the chained devices see the
same register writes?  That might work I guess with no ability to read any =
register
state back other than for first device.  If you want to do the
mux magic below you are going to need to treat it as an SPI mux - just with
some lines shared. That means this device ends up split into multiple device
(even if only one ad4134 which is messy).

So to me this has a simple SPI bus, potentially connected to multiple devic=
es
and an IIO backend that deals with DOUT0 etc and the chaining.

Jonathan

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
>   |                   SDO |------->|=C2=AF=C2=AF=C2=AF=C2=AF\       | | |=
     |                 |
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
>=20
>             adi,spi-mode =3D "two-channel-chain";
>         };
>     };
>=20
> Thanks,
> Marcelo

