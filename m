Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2D02AD2E;
	Mon, 14 Sep 2026 00:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789346082; cv=none; b=q2JR9A8V24yQJD6M/GKu+2pN+HFm0vnCJE/DJk1y+jfjKh4GZR3BwYk/Ngrn3L4XV7Bq79PwLUGeR4JPIIC6jCb35FFp9IHzsV3pQoYHT/f0ov6WGTXppz1phukmiW86BEDvluGF5L67piSEnhK5sXQKwQ8RlGYQJ4vsPtcPJoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789346082; c=relaxed/simple;
	bh=BtQkPZRan5S/umjTnVznurcGvARVHlL4Wknlh/1UqK8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jh28p/eR1mOcpbFtuwIZ3LrGod5wTn6asxpUUPL23457Bv/MvPRstFt94+fl0Ifx1MkWG39blM5c6BaY6y2y4l11WJ0SUtQvcKFx23fwjg04tie29DaYCJnxJzVjpAlqguh/xV13kn7mZ5TYGEaqTG5AghPVX5QIY0sQTegOktw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QNzf4QPY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QNzf4QPY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D4001F000FF;
	Mon, 14 Sep 2026 00:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789346080;
	bh=v4Ox6U/+NtM+3THu8Sd+9cBneWL99suQ45q+URHWWwI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QNzf4QPYm6zeLZ7hEeV7OTMtA4SEy3s9kCK5ed533sxPTmQg8ExUt0tJj9DPKcxV3
	 ANah/48kaBiaPKZGA/LAK80WsZaK3PC4zSrNFMzwH2XaVbCMDgPAYVot5BK5YD5oM/
	 iJYUAvpaj1Uay4BrSFTZkhA5laqgVyBv6b1rRn63vVtFtEFnkgg/P2fyiZGoIABVBi
	 vK8ODk+dlH0azW9WyARyaeE90EvyI25u7jEWfuLTAr9XgqdZt+VFHvEgglfQh43r15
	 UYL6xMMgtfgjp/r4Zuk8xtQVAhFixqlvUBxR9xZqyFAGKlClScjYFI9OnYN6wVlq6G
	 IqHsNSqlVb7Eg==
Date: Mon, 14 Sep 2026 01:34:33 +0100
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
Message-ID: <20260914013433.0763e7f0@jic23-hlaptop>
In-Reply-To: <aqF4kfOCKcZhDZui@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1788368334.git.marcelo.schmitt@analog.com>
	<d9b759d29fa8ca12b6cf083e180b2556ca4533f0.1788368334.git.marcelo.schmitt@analog.com>
	<20260903-liquefy-prologue-9ec914cccf04@spud>
	<apsufKf-EOvTfpwf@debian-BULLSEYE-live-builder-AMD64>
	<aptA9HP82-ss45JF@debian-BULLSEYE-live-builder-AMD64>
	<20260906202630.64d8fa75@jic23-huawei>
	<aqF4kfOCKcZhDZui@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 9 Sep 2026 12:17:37 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> On 09/06, Jonathan Cameron wrote:
> > On Fri, 4 Sep 2026 19:06:44 -0300
> > Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:
> >  =20
> > > On 09/04, Marcelo Schmitt wrote: =20
> > > > On 09/03, Conor Dooley wrote:   =20
> > > > > On Wed, Sep 02, 2026 at 02:24:02PM -0300, Marcelo Schmitt wrote: =
  =20
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
ns:   =20
> > > > ...   =20
> > > > > I'd also really appreciate a dts example for a system
> > > > > with one-channel-chain or two-channel-chain looks, given the seco=
nd
> > > > > device may require different supplies etc. I have no impression i=
n my
> > > > > head of how the dt would be constructed, so I'd like to see wht y=
ou have
> > > > > in mind.   =20
> > > >    =20
> > > ...
> > >=20
> > > Realized what I said doesn't make much sense. The peripherals can all=
 have
> > > the same configuration and thus share CS, SCLK, and controller SDO. T=
he wiring
> > > would be like the following =20
> >=20
> > That mux in the middle is controlled how? =20
>=20
> The mux is controlled by a GPIO. I ended up drawing the GPIO among SPI li=
nes in the
> connection diagram but the mux controll signal is not part of the SPI con=
troller.

Ok. So we are effectively making that mux part of of the ad4134 controlled =
hardware.
I guess I don't mind that but shout about it a lot in the driver as anyone =
coming
in will wonder where the magic mux appeared from :)

>=20
> > I'd assume we still have separate chip selects and SDO/SDI shared. So I=
'd expect
> > those to be on one SPI bus and the data to be going into separate buses
> > (maybe all that can be hidden in the backend, not sure).
> >=20
> > Or are you suggesting we are just letting all the chained devices see t=
he
> > same register writes?  That might work I guess with no ability to read =
any register
> > state back other than for first device. =20
> Correct, that's the proposed configuration for daisy-chaining. Since all
> peripherals will receive the same write commands they shall all retain th=
e same
> register configurations (except maybe for error indication registers). Re=
ading
> from the topmost device in the chain would be enough to figure out the st=
atus
> of the other chained devices.

It's errors that concern me about this.  Maybe it's the best we can do.
=20
>=20
> > If you want to do the
> > mux magic below you are going to need to treat it as an SPI mux - just =
with
> > some lines shared. That means this device ends up split into multiple d=
evice
> > (even if only one ad4134 which is messy). =20
> You mean spi-mux.yaml/spi-mux.c? So the goal/intent would be to have one =
IIO
> device for each peripheral in the chain? I think that would also work. Th=
ough,
> the only device bringing ADC sample data is the topmost one so that would=
 be
> the only one buffer capable.

We went through that discussion IIRC for the original chaining devices and =
it
ends up too odd as there is no way for userspace to know that we have this
strange interacting set of devices.

>=20
> >=20
> > So to me this has a simple SPI bus, potentially connected to multiple d=
evices
> > and an IIO backend that deals with DOUT0 etc and the chaining. =20
> Yeah, the benefit of having the mux is being able to connect both AD4134
> interfaces to a single bus while being able to have ADC sample data on al=
l SDI
> lines as the diagrams in patch 13.
>=20
> Alternatively, we could have something like
>=20
>                                                               +----------=
---+
>   +----------------------+                                    |  DATA HOS=
T  |
>   |       AD4134         |                                    |          =
   |
>   |                      |                                    |          =
   |
>   |Data interface  DOUT0 |----------------------------------->| SDI1     =
   |
>   |for ADC data    DOUT1 |----------------------------------->| SDI2     =
   |
>   |sample read     DOUT2 |----------------------------------->| SDI3     =
   |
>   |                DOUT3 |----------------------------------->| SDI4     =
   |
>   |                DCLK  |<--------------+        +---------->| CS       =
   |
>   |                ODR   |<------------+ |        | +-------->| SCLK     =
   |
>   |                      |             | |        | | +------>| SDO      =
   |
>   |                      |             | |        | | | +---->| SDI      =
   |
>   | SPI interface   CS   |<-------+    | +--------|-|-|-|-----| DCLK     =
   |
>   | for register    SCLK |<-----+ |    |          | | | |     |          =
   |
>   | access          SDI  |<---+ | |    |          | | | |     | TRIGGER  =
   |
>   |                 SDO  |--+ | | |    |          | | | |     +----------=
---+
>   +----------------------+  | | | |    +----------|-|-|-|---------+
>                             | | | +---------------+ | | |
>                             | | +-------------------+ | |
>                             | +-----------------------+ |
>                             +---------------------------+
>=20
> The downside of the above is we would need an SPI_MULTI_LANE_MODE_STRIPE =
to read
> only from SDI1 to SDI4.

I don't totally follow that detail, but indeed the control SPI plane would =
be independent
and so we'd need to do something to get that from the binding in a way that=
 distinguishes
it from other spi controllers.  The device would be sitting on two SPI buss=
es, one
of which had the multi channel properties.

To me this one is more natural but I can see both might get built and the c=
omplexity
of representing that as an SPI mux would be you'd be using part of a wider =
spi controller.
Hence I guess maybe the hidden (ish) mux is the way to go.

Jonathan
>=20
> >=20
> > Jonathan
> >  =20
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
> > >   |                   SDO |------->|=C2=AF=C2=AF=C2=AF=C2=AF\       |=
 | |     |                 |
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
> > >=20
> > >             adi,spi-mode =3D "two-channel-chain";
> > >         };
> > >     };
> > >=20
> > > Thanks,
> > > Marcelo =20
> >  =20

