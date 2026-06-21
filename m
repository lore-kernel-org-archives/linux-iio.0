Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B529368D68;
	Sun, 21 Jun 2026 14:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782052434; cv=none; b=pJiwlsVcXonH89nxH3KCZd2m428xcVNbvdIt8rvrilaDqcPcI15397bTq5nyLiQPBtwUve5t7bXPIKUo7lYGs4akEcHcxJhfauCn18DurtKLbqYWpBQjulOO/UU8iXO615oRHLyVe+V8McQfYv4JhdU+OLhcZCiE7H3dANXIBYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782052434; c=relaxed/simple;
	bh=pGGVMrvKPQG31BRVKoUKRm1AwpOV0e0A59FSZzzfT8U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JL1cNuS84VZi5+i+5TwV0Egr3BbLuUIYZFWkWnD+LU+fMtdPZCOMy/MuMqQlTlnXfeQGXi8cbEfnFY1a7MZlUP00UVfudsK5oKhsjjaQJJWy4Afmim9AeBRgnGU+KIyu6ZwkDom2HLZW2m817aOD4FLhznO570+zf0xhUlP0IIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MdEHEMfw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MdEHEMfw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64EC01F000E9;
	Sun, 21 Jun 2026 14:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782052433;
	bh=jG7mEeZzAT361IEEA2/W5AivgioiU4wcx1aAoJXHOGw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MdEHEMfwlTEZ6FeMru59/lASIeAKwJ+R/RfUXAxhBkZrdKziYcTEnSywUPOMvej6A
	 ojLAWzufjVOuC+W/COzZ49a9OWR32QwMY/yE5peJUnAgJFFdiUpCq2G29Wli8mT5Gp
	 M/TBUbg6Kr5ajSdMbdUnuBJZUdtMU3uMV5CB2LP/h1IfjNOkx2l38HoRMMAdVYSegH
	 9M7UWlN0WNunj41bgRD0fpydDHJWgvxuaF9SDNBe3cxuHhWk81Iy+cJC1PxTZOJgpJ
	 8sv8Pgdpobgloes+RdeK5nEIFkLwzO37KVqi661bgmNpNh42H7mmSC2Vuighk8Bium
	 NnYnCWEu+hvUA==
Date: Sun, 21 Jun 2026 15:33:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Conor Dooley <conor@kernel.org>, Janani Sunil <jan.sun97@gmail.com>,
 Rodrigo Alencar <455.rodrigo.alencar@gmail.com>, Janani Sunil
 <janani.sunil@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp
 Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: dac: Add AD5529R
Message-ID: <20260621153330.79b6600c@jic23-huawei>
In-Reply-To: <ajVlD-j0nIGrRVow@nsa>
References: <20260519-ad5529r-driver-v3-0-267c0731aa68@analog.com>
	<20260519-ad5529r-driver-v3-1-267c0731aa68@analog.com>
	<25mh6grzh7zh3b4uytcqnusyv5zjuf6ia4if3ce3oqzqz56ehi@le72iqv7ye3d>
	<603473ac-30e6-45e5-8a3b-c9902715cc9e@gmail.com>
	<20260614204455.408c4d40@jic23-huawei>
	<076d7d2d-81a0-49c2-af94-bd65ead66c09@gmail.com>
	<20260619-obstinate-polo-a230bef97fda@spud>
	<20260619-bunch-diocese-dd7805cc17ff@spud>
	<ajU73_TkKrSbqD4f@nsa>
	<20260619-concierge-doozy-9c161533c369@spud>
	<ajVlD-j0nIGrRVow@nsa>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 19 Jun 2026 16:54:11 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Fri, Jun 19, 2026 at 03:12:07PM +0100, Conor Dooley wrote:
> > On Fri, Jun 19, 2026 at 02:01:08PM +0100, Nuno S=C3=A1 wrote: =20
> > > On Fri, Jun 19, 2026 at 12:40:54PM +0100, Conor Dooley wrote: =20
> > > > On Fri, Jun 19, 2026 at 12:36:55PM +0100, Conor Dooley wrote: =20
> > > > > On Fri, Jun 19, 2026 at 12:33:11PM +0200, Janani Sunil wrote: =20
> > > > > >=20
> > > > > > On 6/14/26 21:44, Jonathan Cameron wrote: =20
> > > > > > > On Tue, 9 Jun 2026 16:47:23 +0200
> > > > > > > Janani Sunil <jan.sun97@gmail.com> wrote:
> > > > > > >  =20
> > > > > > > > On 5/26/26 15:11, Rodrigo Alencar wrote: =20
> > > > > > > > > On 26/05/19 05:42PM, Janani Sunil wrote: =20
> > > > > > > > > > Devicetree bindings for AD5529R 16 channel 12/16 bit hi=
gh voltage,
> > > > > > > > > > buffered voltage output digital-to-analog converter (DA=
C) with an
> > > > > > > > > > integrated precision reference. =20
> > > > > > > > > ...
> > > > > > > > > Probably others may comment on that, but...
> > > > > > > > >=20
> > > > > > > > > This parent node may support device addressing for multi-=
device support through
> > > > > > > > > those ID pins. I suppose that each device may have its ow=
n power supplies or
> > > > > > > > > other resources like the toggle pins or reset and enable.
> > > > > > > > >=20
> > > > > > > > > That way I suppose that an example would look like... =20
> > > > > > > > > > +
> > > > > > > > > > +patternProperties:
> > > > > > > > > > +  "^channel@([0-9]|1[0-5])$":
> > > > > > > > > > +    type: object
> > > > > > > > > > +    description: Child nodes for individual channel co=
nfiguration
> > > > > > > > > > +
> > > > > > > > > > +    properties:
> > > > > > > > > > +      reg:
> > > > > > > > > > +        description: Channel number.
> > > > > > > > > > +        minimum: 0
> > > > > > > > > > +        maximum: 15
> > > > > > > > > > +
> > > > > > > > > > +      adi,output-range-microvolt:
> > > > > > > > > > +        description: |
> > > > > > > > > > +          Output voltage range for this channel as [mi=
n, max] in microvolts.
> > > > > > > > > > +          If not specified, defaults to 0V to 5V range.
> > > > > > > > > > +        oneOf:
> > > > > > > > > > +          - items:
> > > > > > > > > > +              - const: 0
> > > > > > > > > > +              - enum: [5000000, 10000000, 20000000, 40=
000000]
> > > > > > > > > > +          - items:
> > > > > > > > > > +              - const: -5000000
> > > > > > > > > > +              - const: 5000000
> > > > > > > > > > +          - items:
> > > > > > > > > > +              - const: -10000000
> > > > > > > > > > +              - const: 10000000
> > > > > > > > > > +          - items:
> > > > > > > > > > +              - const: -15000000
> > > > > > > > > > +              - const: 15000000
> > > > > > > > > > +          - items:
> > > > > > > > > > +              - const: -20000000
> > > > > > > > > > +              - const: 20000000
> > > > > > > > > > +
> > > > > > > > > > +    required:
> > > > > > > > > > +      - reg
> > > > > > > > > > +
> > > > > > > > > > +    additionalProperties: false
> > > > > > > > > > +
> > > > > > > > > > +required:
> > > > > > > > > > +  - compatible
> > > > > > > > > > +  - reg
> > > > > > > > > > +  - vdd-supply
> > > > > > > > > > +  - avdd-supply
> > > > > > > > > > +  - hvdd-supply
> > > > > > > > > > +
> > > > > > > > > > +dependencies:
> > > > > > > > > > +  spi-cpha: [ spi-cpol ]
> > > > > > > > > > +  spi-cpol: [ spi-cpha ]
> > > > > > > > > > +
> > > > > > > > > > +allOf:
> > > > > > > > > > +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> > > > > > > > > > +
> > > > > > > > > > +unevaluatedProperties: false
> > > > > > > > > > +
> > > > > > > > > > +examples:
> > > > > > > > > > +  - |
> > > > > > > > > > +    #include <dt-bindings/gpio/gpio.h>
> > > > > > > > > > +
> > > > > > > > > > +    spi {
> > > > > > > > > > +        #address-cells =3D <1>;
> > > > > > > > > > +        #size-cells =3D <0>;
> > > > > > > > > > +
> > > > > > > > > > +        dac@0 {
> > > > > > > > > > +            compatible =3D "adi,ad5529r-16";
> > > > > > > > > > +            reg =3D <0>;
> > > > > > > > > > +            spi-max-frequency =3D <25000000>;
> > > > > > > > > > +
> > > > > > > > > > +            vdd-supply =3D <&vdd_regulator>;
> > > > > > > > > > +            avdd-supply =3D <&avdd_regulator>;
> > > > > > > > > > +            hvdd-supply =3D <&hvdd_regulator>;
> > > > > > > > > > +            hvss-supply =3D <&hvss_regulator>;
> > > > > > > > > > +
> > > > > > > > > > +            reset-gpios =3D <&gpio0 87 GPIO_ACTIVE_LOW=
>;
> > > > > > > > > > +
> > > > > > > > > > +            #address-cells =3D <1>;
> > > > > > > > > > +            #size-cells =3D <0>;
> > > > > > > > > > +
> > > > > > > > > > +            channel@0 {
> > > > > > > > > > +                reg =3D <0>;
> > > > > > > > > > +                adi,output-range-microvolt =3D <0 5000=
000>;
> > > > > > > > > > +            };
> > > > > > > > > > +
> > > > > > > > > > +            channel@1 {
> > > > > > > > > > +                reg =3D <1>;
> > > > > > > > > > +                adi,output-range-microvolt =3D <(-1000=
0000) 10000000>;
> > > > > > > > > > +            };
> > > > > > > > > > +
> > > > > > > > > > +            channel@2 {
> > > > > > > > > > +                reg =3D <2>;
> > > > > > > > > > +                adi,output-range-microvolt =3D <0 4000=
0000>;
> > > > > > > > > > +            };
> > > > > > > > > > +        };
> > > > > > > > > > +    }; =20
> > > > > > > > > ...
> > > > > > > > >=20
> > > > > > > > > 	spi {
> > > > > > > > > 		#address-cells =3D <1>;
> > > > > > > > > 		#size-cells =3D <0>;
> > > > > > > > >=20
> > > > > > > > > 		multi-dac@0 {
> > > > > > > > > 			compatible =3D "adi,ad5529r-16";
> > > > > > > > > 			reg =3D <0>;
> > > > > > > > > 			spi-max-frequency =3D <25000000>;
> > > > > > > > >=20
> > > > > > > > > 			#address-cells =3D <1>;
> > > > > > > > > 			#size-cells =3D <0>;
> > > > > > > > >=20
> > > > > > > > > 			dac@0 {
> > > > > > > > > 				reg =3D <0>;
> > > > > > > > > 				vdd-supply =3D <&vdd_regulator>;
> > > > > > > > > 				avdd-supply =3D <&avdd_regulator>;
> > > > > > > > > 				hvdd-supply =3D <&hvdd_regulator>;
> > > > > > > > > 				hvss-supply =3D <&hvss_regulator>;
> > > > > > > > >=20
> > > > > > > > > 				reset-gpios =3D <&gpio0 87 GPIO_ACTIVE_LOW>;
> > > > > > > > >=20
> > > > > > > > > 				#address-cells =3D <1>;
> > > > > > > > > 				#size-cells =3D <0>;
> > > > > > > > >=20
> > > > > > > > > 				channel@0 {
> > > > > > > > > 					reg =3D <0>;
> > > > > > > > > 					adi,output-range-microvolt =3D <0 5000000>;
> > > > > > > > > 				};
> > > > > > > > >=20
> > > > > > > > > 				channel@1 {
> > > > > > > > > 					reg =3D <1>;
> > > > > > > > > 					adi,output-range-microvolt =3D <(-10000000) 10000000=
>;
> > > > > > > > > 				};
> > > > > > > > >=20
> > > > > > > > > 				channel@2 {
> > > > > > > > > 					reg =3D <2>;
> > > > > > > > > 					adi,output-range-microvolt =3D <0 40000000>;
> > > > > > > > > 				};
> > > > > > > > > 			}
> > > > > > > > >=20
> > > > > > > > > 			dac@1 {
> > > > > > > > > 				reg =3D <1>;
> > > > > > > > > 				vdd-supply =3D <&vdd_regulator>;
> > > > > > > > > 				avdd-supply =3D <&avdd_regulator>;
> > > > > > > > > 				hvdd-supply =3D <&hvdd_regulator>;
> > > > > > > > > 				hvss-supply =3D <&hvss_regulator>;
> > > > > > > > >=20
> > > > > > > > > 				reset-gpios =3D <&gpio0 88 GPIO_ACTIVE_LOW>;
> > > > > > > > >=20
> > > > > > > > > 				#address-cells =3D <1>;
> > > > > > > > > 				#size-cells =3D <0>;
> > > > > > > > >=20
> > > > > > > > > 				channel@0 {
> > > > > > > > > 					reg =3D <0>;
> > > > > > > > > 					adi,output-range-microvolt =3D <0 5000000>;
> > > > > > > > > 				};
> > > > > > > > >=20
> > > > > > > > > 				channel@1 {
> > > > > > > > > 					reg =3D <1>;
> > > > > > > > > 					adi,output-range-microvolt =3D <(-10000000) 10000000=
>;
> > > > > > > > > 				};
> > > > > > > > > 			}
> > > > > > > > > 		};
> > > > > > > > > 	};
> > > > > > > > >=20
> > > > > > > > > then you might need something like:
> > > > > > > > >=20
> > > > > > > > > 	patternProperties:
> > > > > > > > > 		"^dac@[0-3]$":
> > > > > > > > >=20
> > > > > > > > > and put most of the things under this node pattern.
> > > > > > > > >=20
> > > > > > > > > So the main driver that you're putting together might nee=
d to handle up to four instances.
> > > > > > > > > Even if your current driver cannot handle this, the dt-bi=
ndings might need cover that.
> > > > > > > > >=20
> > > > > > > > > Need to double check if each dac node needs a separate co=
mpatible, so you would maybe populate
> > > > > > > > > a platform data to be shared with the child nodes, which =
would be a separate driver.
> > > > > > > > > (not sure if it would make sense to mix and match ad5529r=
-16 and ad5529r-12). =20
> > > > > > > > Hi Rodrigo,
> > > > > > > >=20
> > > > > > > > Thank you for looking at this.
> > > > > > > >=20
> > > > > > > > For now, I would prefer to keep the binding scoped to a sin=
gle AD5529R device instance. The current
> > > > > > > > hardware/use case we have only needs one device node and th=
e driver is written around that model as well.
> > > > > > > > While the device addressing pins could allow multi-device t=
opology, we do not have an actual platform using
> > > > > > > > that configuration at the moment, so I would prefer not to =
introduce an extra parent/child binding structure
> > > > > > > > speculatively without a validating use case. =20
> > > > > > > Interesting feature - kind of similar to address control on a=
 typical i2c bus device, or
> > > > > > > looking at it another way a kind of distributed SPI mux.
> > > > > > >=20
> > > > > > > Challenge of a binding is we need to anticipate the future.  =
So I think we do need something
> > > > > > > like Rodrigo is suggesting even if we only (for now) support =
a single instance in the driver.
> > > > > > > That would leave the path open to supporting the addressing a=
t a later date.
> > > > > > > An alternative might be to look at it like a chained device s=
etup. In those we pretend there
> > > > > > > is just one device with a lot of channels etc.  The snag is t=
hat here things are more loosely
> > > > > > > coupled whereas for those devices it tends to be you have to =
read / write the same register
> > > > > > > in all devices in the chain as one big SPI message.
> > > > > > >=20
> > > > > > > +CC Mark Brown as he may know of some precedence for this fea=
ture. For his reference..
> > > > > > > - Each of these device has 2 ID pins.  The SPI transfers have=
 to contain the 2 bit
> > > > > > > value that matches that or they are ignored.  Thus a single b=
us + 1 chip select can
> > > > > > > be used to talk to 4 devices.  Question is what that looks li=
ke in device tree + I guess
> > > > > > > longer term how to support it cleanly in SPI. =20
> > > > >=20
> > > > > I'd swear I have seen this before, from some Microchip devices. L=
et me
> > > > > see if I can find what I am thinking of... =20
> > > >=20
> > > >=20
> > > > microchip,mcp3911 and microchip,mcp3564 both seem to do this with
> > > > slightly different properties.
> > > >=20
> > > >   microchip,device-addr:
> > > >     description: Device address when multiple MCP3911 chips are pre=
sent on the same SPI bus.
> > > >     $ref: /schemas/types.yaml#/definitions/uint32
> > > >     enum: [0, 1, 2, 3]
> > > >     default: 0
> > > >=20
> > > > and
> > > >=20
> > > >=20
> > > >   microchip,hw-device-address:
> > > >     $ref: /schemas/types.yaml#/definitions/uint32
> > > >     minimum: 0
> > > >     maximum: 3
> > > >     description:
> > > >       The address is set on a per-device basis by fuses in the fact=
ory,
> > > >       configured on request. If not requested, the fuses are set fo=
r 0x1.
> > > >       The device address is part of the device markings to avoid
> > > >       potential confusion. This address is coded on two bits, so fo=
ur possible
> > > >       addresses are available when multiple devices are present on =
the same
> > > >       SPI bus with only one Chip Select line for all devices.
> > > >       Each device communication starts by a CS falling edge, follow=
ed by the
> > > >       clocking of the device address (BITS[7:6] - top two bits of C=
OMMAND BYTE
> > > >       which is first one on the wire).
> > > >=20
> > > > This sounds exactly like the sort of feature that you're dealing wi=
th
> > > > here?
> > > >  =20
> > >=20
> > > The core idea yes but for this chip, things are a bit more annoying (=
but
> > > Janani can correct me if I'm wrong). Here, each device can, in theory,
> > > have it's own supplies, pins and at the very least, channels with may=
be
> > > different scales. That is why Janani is proposing dac nodes. Given I
> > > honestly don't like much of that "adi,ad5529r-bus" compatible I wonde=
red
> > > about solving this at the spi level.
> > >=20
> > > Ah and to make it more annoying, we can also mix 12 and 16 bits varia=
nts
> > > together in the same bus. =20
> >=20
> > I'm definitely missing something, because that property for the
> > microchip devices is not impacted what else is on the bus. AFAICT, you
> > could have an mcp3911 and an mcp3564 on the same bus even though both
> > are completely different devices with different drivers. They have
> > individual device nodes and their own supplies etc etc. These aren't
> > per-channel properties on an adc or dac, they're per child device on a
> > spi bus. =20
>=20
> Maybe I'm the one missing something :). IIRC, spi would not allow two
> devices on the same CS right? Because for this chip we would need
> something like:
>=20
> spi {
> 	dac@0 {
> 		reg =3D <0>;
> 		adi,pin-id =3D <0>;
> 	};
>=20
> 	dac@1 {
> 		reg =3D <0>; // which seems already problematic?
> 		adi,pin-id <1>;
> 	};
>=20
> 	...
>=20
> 	//up to 4
> };
Yeah. It's not clear to me how that works for the microchip devices
(I suspect it doesn't!)

Just thinking as I type, but could we do something a bit nasty with
a gpio mux that doesn't actually switch but represents the GPIO being
shared?  Given this is all tied to the spi bus that should all happen
under serializing locks.=20

Agreed though that this would be nicer as an SPI thing that let
us specify that a single CS is share by multiple devices and their
is some other signal acting to select which one we are talking to.

Jonathan


>=20
> - Nuno S=C3=A1
>=20
>=20

