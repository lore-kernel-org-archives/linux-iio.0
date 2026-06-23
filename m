Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0DC3D564B;
	Tue, 23 Jun 2026 14:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782226565; cv=none; b=eTJApCIPolo6fma+V5/eRXpkncgVCr+ZIEbuoZqsfwF6vZZ4LRf3RkjqiMOlvu0JA7hMBZnpZmWB+bb3iStot2N0tlFJKO6D7C02AIQpZHCwodXdM2M2FBFNjxfMABfzwYSzFqCa9bkRXUTlabt3I1ltrgWSjSdFb5wme3gD6gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782226565; c=relaxed/simple;
	bh=8HuuPEDj47GvI52HpcSNbhf0T4HjXvr0urbb+PKwWU4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WTcsF3eFxjbFijd8EphIrtd0QhSIMzAXiKzNNeXopKn4i7LpLbw42mH1adEfcHBr3kBOY7qsLHEJLEvJsXriyGKTghW/215WFQgHjxiHI2OM0WUGtA/IrqyTpF/H+CXem5zorCYJJz1DTgVpuu/CjeVkq6bXsq/EhUfQ6AUqt4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHprJwp5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHprJwp5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24BE21F000E9;
	Tue, 23 Jun 2026 14:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782226563;
	bh=MYr8+7xvQ6gzdXhSNKhj097j0KxrbI8PgPL9YYodcCs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hHprJwp5NlgwOjMU24QQHPlOCFYsfGbDl8LXhb+Cbe6iljVCTHB5j8MwnazmFMleP
	 Js3AHnAr5sHHSotPGCDNEdjbmXi962IwkKkDz5yXi9+WkpzaADFRr8gE1Hcf7dhT1a
	 UtB8LZQjH4TetSnawIIPguc5mEOwkfi5SBGbwf5tbr5pvIBJN71pc25DttcScPjAFu
	 mujyXlQ8t1knM1A8ZAFTK1hxWhGmd4E+ni4z/pXqtdfdE6oPhtPzS5FUgApGYAooFJ
	 JyE6zBkIVlMkxMEmme+q7GpMwRuKaf28zJ+iexOqrzwClWcXj1RL7AClyDr8rbVQfw
	 rNXo1r4ehpvkw==
Date: Tue, 23 Jun 2026 15:55:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Janani Sunil <jan.sun97@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <noname.nuno@gmail.com>, Rodrigo Alencar <455.rodrigo.alencar@gmail.com>,
 Conor Dooley <conor@kernel.org>, Janani Sunil <janani.sunil@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp
 Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: dac: Add AD5529R
Message-ID: <20260623155551.6094388b@jic23-huawei>
In-Reply-To: <0f778d06-726f-4aec-ab3b-f6e091cc9421@gmail.com>
References: <076d7d2d-81a0-49c2-af94-bd65ead66c09@gmail.com>
	<20260619-obstinate-polo-a230bef97fda@spud>
	<20260619-bunch-diocese-dd7805cc17ff@spud>
	<ajU73_TkKrSbqD4f@nsa>
	<20260619-concierge-doozy-9c161533c369@spud>
	<ajVlD-j0nIGrRVow@nsa>
	<20260621153330.79b6600c@jic23-huawei>
	<5u4dnsgxwcwie45f24cacyzf3dko4srhyyyhcpom6tsvhqtmpc@y7d7gmex6n7k>
	<ajkMBh-R_7pYaoAn@nsa>
	<pifhwgj3cp2vc7ia4m6penh52iekzjljrp75y5b7j57vvtooad@32wfqruiqqjl>
	<ajklksIDLsj0BZul@nsa>
	<c72fb508-05a4-429a-9ca7-86e42a115fa8@baylibre.com>
	<0f778d06-726f-4aec-ab3b-f6e091cc9421@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 23 Jun 2026 12:07:52 +0200
Janani Sunil <jan.sun97@gmail.com> wrote:

> On 6/22/26 17:36, David Lechner wrote:
> > On 6/22/26 7:20 AM, Nuno S=C3=A1 wrote: =20
> >> On Mon, Jun 22, 2026 at 12:51:20PM +0100, Rodrigo Alencar wrote: =20
> >>> On 22/06/26 11:29, Nuno S=C3=A1 wrote: =20
> >>>> On Mon, Jun 22, 2026 at 10:24:05AM +0100, Rodrigo Alencar wrote: =20
> >>>>> On 21/06/26 15:33, Jonathan Cameron wrote: =20
> >>>>>> On Fri, 19 Jun 2026 16:54:11 +0100
> >>>>>> Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
> >>>>>> =20
> >>>>>>> On Fri, Jun 19, 2026 at 03:12:07PM +0100, Conor Dooley wrote: =20
> >>>>>>>> On Fri, Jun 19, 2026 at 02:01:08PM +0100, Nuno S=C3=A1 wrote: =20
> >>>>>>>>> On Fri, Jun 19, 2026 at 12:40:54PM +0100, Conor Dooley wrote: =
=20
> >>>>>>>>>> On Fri, Jun 19, 2026 at 12:36:55PM +0100, Conor Dooley wrote: =
=20
> >>>>>>>>>>> On Fri, Jun 19, 2026 at 12:33:11PM +0200, Janani Sunil wrote:=
 =20
> >>>>>>>>>>>> On 6/14/26 21:44, Jonathan Cameron wrote: =20
> >>>>>>>>>>>>> On Tue, 9 Jun 2026 16:47:23 +0200
> >>>>>>>>>>>>> Janani Sunil <jan.sun97@gmail.com> wrote:
> >>>>>>>>>>>>>     =20
> >>>>>>>>>>>>>> On 5/26/26 15:11, Rodrigo Alencar wrote: =20
> >>>>>>>>>>>>>>> On 26/05/19 05:42PM, Janani Sunil wrote: =20
> >>>>>>>>>>>>>>>> Devicetree bindings for AD5529R 16 channel 12/16 bit hig=
h voltage,
> >>>>>>>>>>>>>>>> buffered voltage output digital-to-analog converter (DAC=
) with an
> >>>>>>>>>>>>>>>> integrated precision reference. =20
> >>>>>>>>>>>>>>> ...
> >>>>>>>>>>>>>>> Probably others may comment on that, but...
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> This parent node may support device addressing for multi-=
device support through
> >>>>>>>>>>>>>>> those ID pins. I suppose that each device may have its ow=
n power supplies or
> >>>>>>>>>>>>>>> other resources like the toggle pins or reset and enable.
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> That way I suppose that an example would look like... =20
> >>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>> +patternProperties:
> >>>>>>>>>>>>>>>> +  "^channel@([0-9]|1[0-5])$":
> >>>>>>>>>>>>>>>> +    type: object
> >>>>>>>>>>>>>>>> +    description: Child nodes for individual channel con=
figuration
> >>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>> +    properties:
> >>>>>>>>>>>>>>>> +      reg:
> >>>>>>>>>>>>>>>> +        description: Channel number.
> >>>>>>>>>>>>>>>> +        minimum: 0
> >>>>>>>>>>>>>>>> +        maximum: 15
> >>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>> +      adi,output-range-microvolt:
> >>>>>>>>>>>>>>>> +        description: |
> >>>>>>>>>>>>>>>> +          Output voltage range for this channel as [min=
, max] in microvolts.
> >>>>>>>>>>>>>>>> +          If not specified, defaults to 0V to 5V range.
> >>>>>>>>>>>>>>>> +        oneOf:
> >>>>>>>>>>>>>>>> +          - items:
> >>>>>>>>>>>>>>>> +              - const: 0
> >>>>>>>>>>>>>>>> +              - enum: [5000000, 10000000, 20000000, 400=
00000]
> >>>>>>>>>>>>>>>> +          - items:
> >>>>>>>>>>>>>>>> +              - const: -5000000
> >>>>>>>>>>>>>>>> +              - const: 5000000
> >>>>>>>>>>>>>>>> +          - items:
> >>>>>>>>>>>>>>>> +              - const: -10000000
> >>>>>>>>>>>>>>>> +              - const: 10000000
> >>>>>>>>>>>>>>>> +          - items:
> >>>>>>>>>>>>>>>> +              - const: -15000000
> >>>>>>>>>>>>>>>> +              - const: 15000000
> >>>>>>>>>>>>>>>> +          - items:
> >>>>>>>>>>>>>>>> +              - const: -20000000
> >>>>>>>>>>>>>>>> +              - const: 20000000
> >>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>> +    required:
> >>>>>>>>>>>>>>>> +      - reg
> >>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>> +    additionalProperties: false
> >>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>> +required:
> >>>>>>>>>>>>>>>> +  - compatible
> >>>>>>>>>>>>>>>> +  - reg
> >>>>>>>>>>>>>>>> +  - vdd-supply
> >>>>>>>>>>>>>>>> +  - avdd-supply
> >>>>>>>>>>>>>>>> +  - hvdd-supply
> >>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>> +dependencies:
> >>>>>>>>>>>>>>>> +  spi-cpha: [ spi-cpol ]
> >>>>>>>>>>>>>>>> +  spi-cpol: [ spi-cpha ]
> >>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>> +allOf:
> >>>>>>>>>>>>>>>> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> >>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>> +unevaluatedProperties: false
> >>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>> +examples:
> >>>>>>>>>>>>>>>> +  - |
> >>>>>>>>>>>>>>>> +    #include <dt-bindings/gpio/gpio.h>
> >>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>> +    spi {
> >>>>>>>>>>>>>>>> +        #address-cells =3D <1>;
> >>>>>>>>>>>>>>>> +        #size-cells =3D <0>;
> >>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>> +        dac@0 {
> >>>>>>>>>>>>>>>> +            compatible =3D "adi,ad5529r-16";
> >>>>>>>>>>>>>>>> +            reg =3D <0>;
> >>>>>>>>>>>>>>>> +            spi-max-frequency =3D <25000000>;
> >>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>> +            vdd-supply =3D <&vdd_regulator>;
> >>>>>>>>>>>>>>>> +            avdd-supply =3D <&avdd_regulator>;
> >>>>>>>>>>>>>>>> +            hvdd-supply =3D <&hvdd_regulator>;
> >>>>>>>>>>>>>>>> +            hvss-supply =3D <&hvss_regulator>;
> >>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>> +            reset-gpios =3D <&gpio0 87 GPIO_ACTIVE_LOW>;
> >>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>> +            #address-cells =3D <1>;
> >>>>>>>>>>>>>>>> +            #size-cells =3D <0>;
> >>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>> +            channel@0 {
> >>>>>>>>>>>>>>>> +                reg =3D <0>;
> >>>>>>>>>>>>>>>> +                adi,output-range-microvolt =3D <0 50000=
00>;
> >>>>>>>>>>>>>>>> +            };
> >>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>> +            channel@1 {
> >>>>>>>>>>>>>>>> +                reg =3D <1>;
> >>>>>>>>>>>>>>>> +                adi,output-range-microvolt =3D <(-10000=
000) 10000000>;
> >>>>>>>>>>>>>>>> +            };
> >>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>> +            channel@2 {
> >>>>>>>>>>>>>>>> +                reg =3D <2>;
> >>>>>>>>>>>>>>>> +                adi,output-range-microvolt =3D <0 40000=
000>;
> >>>>>>>>>>>>>>>> +            };
> >>>>>>>>>>>>>>>> +        };
> >>>>>>>>>>>>>>>> +    }; =20
> >>>>>>>>>>>>>>> ...
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> 	spi {
> >>>>>>>>>>>>>>> 		#address-cells =3D <1>;
> >>>>>>>>>>>>>>> 		#size-cells =3D <0>;
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> 		multi-dac@0 {
> >>>>>>>>>>>>>>> 			compatible =3D "adi,ad5529r-16";
> >>>>>>>>>>>>>>> 			reg =3D <0>;
> >>>>>>>>>>>>>>> 			spi-max-frequency =3D <25000000>;
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> 			#address-cells =3D <1>;
> >>>>>>>>>>>>>>> 			#size-cells =3D <0>;
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> 			dac@0 {
> >>>>>>>>>>>>>>> 				reg =3D <0>;
> >>>>>>>>>>>>>>> 				vdd-supply =3D <&vdd_regulator>;
> >>>>>>>>>>>>>>> 				avdd-supply =3D <&avdd_regulator>;
> >>>>>>>>>>>>>>> 				hvdd-supply =3D <&hvdd_regulator>;
> >>>>>>>>>>>>>>> 				hvss-supply =3D <&hvss_regulator>;
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> 				reset-gpios =3D <&gpio0 87 GPIO_ACTIVE_LOW>;
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> 				#address-cells =3D <1>;
> >>>>>>>>>>>>>>> 				#size-cells =3D <0>;
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> 				channel@0 {
> >>>>>>>>>>>>>>> 					reg =3D <0>;
> >>>>>>>>>>>>>>> 					adi,output-range-microvolt =3D <0 5000000>;
> >>>>>>>>>>>>>>> 				};
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> 				channel@1 {
> >>>>>>>>>>>>>>> 					reg =3D <1>;
> >>>>>>>>>>>>>>> 					adi,output-range-microvolt =3D <(-10000000) 10000000=
>;
> >>>>>>>>>>>>>>> 				};
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> 				channel@2 {
> >>>>>>>>>>>>>>> 					reg =3D <2>;
> >>>>>>>>>>>>>>> 					adi,output-range-microvolt =3D <0 40000000>;
> >>>>>>>>>>>>>>> 				};
> >>>>>>>>>>>>>>> 			}
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> 			dac@1 {
> >>>>>>>>>>>>>>> 				reg =3D <1>;
> >>>>>>>>>>>>>>> 				vdd-supply =3D <&vdd_regulator>;
> >>>>>>>>>>>>>>> 				avdd-supply =3D <&avdd_regulator>;
> >>>>>>>>>>>>>>> 				hvdd-supply =3D <&hvdd_regulator>;
> >>>>>>>>>>>>>>> 				hvss-supply =3D <&hvss_regulator>;
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> 				reset-gpios =3D <&gpio0 88 GPIO_ACTIVE_LOW>;
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> 				#address-cells =3D <1>;
> >>>>>>>>>>>>>>> 				#size-cells =3D <0>;
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> 				channel@0 {
> >>>>>>>>>>>>>>> 					reg =3D <0>;
> >>>>>>>>>>>>>>> 					adi,output-range-microvolt =3D <0 5000000>;
> >>>>>>>>>>>>>>> 				};
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> 				channel@1 {
> >>>>>>>>>>>>>>> 					reg =3D <1>;
> >>>>>>>>>>>>>>> 					adi,output-range-microvolt =3D <(-10000000) 10000000=
>;
> >>>>>>>>>>>>>>> 				};
> >>>>>>>>>>>>>>> 			}
> >>>>>>>>>>>>>>> 		};
> >>>>>>>>>>>>>>> 	};
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> then you might need something like:
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> 	patternProperties:
> >>>>>>>>>>>>>>> 		"^dac@[0-3]$":
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> and put most of the things under this node pattern.
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> So the main driver that you're putting together might nee=
d to handle up to four instances.
> >>>>>>>>>>>>>>> Even if your current driver cannot handle this, the dt-bi=
ndings might need cover that.
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> Need to double check if each dac node needs a separate co=
mpatible, so you would maybe populate
> >>>>>>>>>>>>>>> a platform data to be shared with the child nodes, which =
would be a separate driver.
> >>>>>>>>>>>>>>> (not sure if it would make sense to mix and match ad5529r=
-16 and ad5529r-12). =20
> >>>>>>>>>>>>>> Hi Rodrigo,
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> Thank you for looking at this.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> For now, I would prefer to keep the binding scoped to a si=
ngle AD5529R device instance. The current
> >>>>>>>>>>>>>> hardware/use case we have only needs one device node and t=
he driver is written around that model as well.
> >>>>>>>>>>>>>> While the device addressing pins could allow multi-device =
topology, we do not have an actual platform using
> >>>>>>>>>>>>>> that configuration at the moment, so I would prefer not to=
 introduce an extra parent/child binding structure
> >>>>>>>>>>>>>> speculatively without a validating use case. =20
> >>>>>>>>>>>>> Interesting feature - kind of similar to address control on=
 a typical i2c bus device, or
> >>>>>>>>>>>>> looking at it another way a kind of distributed SPI mux.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Challenge of a binding is we need to anticipate the future.=
  So I think we do need something
> >>>>>>>>>>>>> like Rodrigo is suggesting even if we only (for now) suppor=
t a single instance in the driver.
> >>>>>>>>>>>>> That would leave the path open to supporting the addressing=
 at a later date.
> >>>>>>>>>>>>> An alternative might be to look at it like a chained device=
 setup. In those we pretend there
> >>>>>>>>>>>>> is just one device with a lot of channels etc.  The snag is=
 that here things are more loosely
> >>>>>>>>>>>>> coupled whereas for those devices it tends to be you have t=
o read / write the same register
> >>>>>>>>>>>>> in all devices in the chain as one big SPI message.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> +CC Mark Brown as he may know of some precedence for this f=
eature. For his reference..
> >>>>>>>>>>>>> - Each of these device has 2 ID pins.  The SPI transfers ha=
ve to contain the 2 bit
> >>>>>>>>>>>>> value that matches that or they are ignored.  Thus a single=
 bus + 1 chip select can
> >>>>>>>>>>>>> be used to talk to 4 devices.  Question is what that looks =
like in device tree + I guess
> >>>>>>>>>>>>> longer term how to support it cleanly in SPI. =20
> >>>>>>>>>>> I'd swear I have seen this before, from some Microchip device=
s. Let me
> >>>>>>>>>>> see if I can find what I am thinking of... =20
> >>>>>>>>>>
> >>>>>>>>>> microchip,mcp3911 and microchip,mcp3564 both seem to do this w=
ith
> >>>>>>>>>> slightly different properties.
> >>>>>>>>>>
> >>>>>>>>>>    microchip,device-addr:
> >>>>>>>>>>      description: Device address when multiple MCP3911 chips a=
re present on the same SPI bus.
> >>>>>>>>>>      $ref: /schemas/types.yaml#/definitions/uint32
> >>>>>>>>>>      enum: [0, 1, 2, 3]
> >>>>>>>>>>      default: 0
> >>>>>>>>>>
> >>>>>>>>>> and
> >>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>>    microchip,hw-device-address:
> >>>>>>>>>>      $ref: /schemas/types.yaml#/definitions/uint32
> >>>>>>>>>>      minimum: 0
> >>>>>>>>>>      maximum: 3
> >>>>>>>>>>      description:
> >>>>>>>>>>        The address is set on a per-device basis by fuses in th=
e factory,
> >>>>>>>>>>        configured on request. If not requested, the fuses are =
set for 0x1.
> >>>>>>>>>>        The device address is part of the device markings to av=
oid
> >>>>>>>>>>        potential confusion. This address is coded on two bits,=
 so four possible
> >>>>>>>>>>        addresses are available when multiple devices are prese=
nt on the same
> >>>>>>>>>>        SPI bus with only one Chip Select line for all devices.
> >>>>>>>>>>        Each device communication starts by a CS falling edge, =
followed by the
> >>>>>>>>>>        clocking of the device address (BITS[7:6] - top two bit=
s of COMMAND BYTE
> >>>>>>>>>>        which is first one on the wire).
> >>>>>>>>>>
> >>>>>>>>>> This sounds exactly like the sort of feature that you're deali=
ng with
> >>>>>>>>>> here?
> >>>>>>>>>>     =20
> >>>>>>>>> The core idea yes but for this chip, things are a bit more anno=
ying (but
> >>>>>>>>> Janani can correct me if I'm wrong). Here, each device can, in =
theory,
> >>>>>>>>> have it's own supplies, pins and at the very least, channels wi=
th maybe
> >>>>>>>>> different scales. That is why Janani is proposing dac nodes. Gi=
ven I
> >>>>>>>>> honestly don't like much of that "adi,ad5529r-bus" compatible I=
 wondered
> >>>>>>>>> about solving this at the spi level.
> >>>>>>>>>
> >>>>>>>>> Ah and to make it more annoying, we can also mix 12 and 16 bits=
 variants
> >>>>>>>>> together in the same bus. =20
> >>>>>>>> I'm definitely missing something, because that property for the
> >>>>>>>> microchip devices is not impacted what else is on the bus. AFAIC=
T, you
> >>>>>>>> could have an mcp3911 and an mcp3564 on the same bus even though=
 both
> >>>>>>>> are completely different devices with different drivers. They ha=
ve
> >>>>>>>> individual device nodes and their own supplies etc etc. These ar=
en't
> >>>>>>>> per-channel properties on an adc or dac, they're per child devic=
e on a
> >>>>>>>> spi bus. =20
> >>>>>>> Maybe I'm the one missing something :). IIRC, spi would not allow=
 two
> >>>>>>> devices on the same CS right? Because for this chip we would need
> >>>>>>> something like:
> >>>>>>>
> >>>>>>> spi {
> >>>>>>> 	dac@0 {
> >>>>>>> 		reg =3D <0>;
> >>>>>>> 		adi,pin-id =3D <0>;
> >>>>>>> 	};
> >>>>>>>
> >>>>>>> 	dac@1 {
> >>>>>>> 		reg =3D <0>; // which seems already problematic?
> >>>>>>> 		adi,pin-id <1>;
> >>>>>>> 	};
> >>>>>>>
> >>>>>>> 	...
> >>>>>>>
> >>>>>>> 	//up to 4
> >>>>>>> }; =20
> >>>>>> Yeah. It's not clear to me how that works for the microchip devices
> >>>>>> (I suspect it doesn't!)
> >>>>>>
> >>>>>> Just thinking as I type, but could we do something a bit nasty with
> >>>>>> a gpio mux that doesn't actually switch but represents the GPIO be=
ing
> >>>>>> shared?  Given this is all tied to the spi bus that should all hap=
pen
> >>>>>> under serializing locks.
> >>>>>>
> >>>>>> Agreed though that this would be nicer as an SPI thing that let
> >>>>>> us specify that a single CS is share by multiple devices and their
> >>>>>> is some other signal acting to select which one we are talking to.
> >>>>>> =20
> >>>>> If the device-addressing on the same chip-select is to be handled
> >>>>> by the spi framework, wouldn't we lose device-specific features?
> >>>>>
> >>>>> I understand that this multi-device feature is there mostly to exte=
nd the
> >>>>> channel count from 16 to 32, 48 or 64. I suppose the command:
> >>>>>
> >>>>> 	"MULTI DEVICE SW LDAC MODE"
> >>>>>
> >>>>> exists so that software can update channel values accross multiple =
devices. =20
> >>>> Right! You do have a point! I agree the main driver for a feature li=
ke
> >>>> this is likely to extend the channel count and effectively "aggregat=
e"
> >>>> devices.
> >>>>
> >>>> But I would say that even with the spi solution the MULTI DEVICE stu=
ff
> >>>> should be doable (as we still need a sort of adi,pin-id property). =
=20
> >>> I don't think we can have something like an IIO buffer shared by mult=
iple
> >>> devices. Synchronizing separate devices would be doable with proper h=
ardware
> >>> support for this (probably involving an FGPA). =20
> >> True!
> >> =20
> >>>    =20
> >>>> But yes, I do feel that the whole feature is for aggregation so seei=
ng
> >>>> one device with 32 channels is the expectation here? Rather than see=
ing
> >>>> two devices with 16 channels. =20
> >>> Yes, I think aggregation is the whole point there... so that the IIO =
driver
> >>> is multi-device-aware. =20
> >> Which makes me feel that different pins per device might be possible
> >> from an HW point of view but does not make much sense. For example, for
> >> the buffer example I would expect LDAC to be shared between all the
> >> devices.
> >>
> >> - Nuno S=C3=A1 =20
> > I think I mentioned this on a previous revision, but I still think the
> > simplest way to go about it would be to assume that all chips treated
> > as an aggregate device have everything wired in parallel and just add
> > support for per-chip wiring on an as-needed basis. This is how we have
> > handled daisy-chained devices so far. =20
>=20
> Hi David,
>=20
> One thing about this approach is that is does not cover a combination  of=
 12 and 16 bit parts in the chain,
> since the compatible string would be at the top level and apply to all ch=
ips. To handle this without per chip child nodes or per-chip compatible,
> I propose an "adi, resolution" property as an integer array, indexed by t=
he device position:
>=20

To me mixed parts, smells like a case that we will probably never see.  If
a customer actually has a design doing that we can add optional dt
bindings at that time.

So I'd stick to separate compatibles.=20

>=20
> dac@0 {
>      compatible =3D "adi,ad5529r";
>      reg =3D <0>;
>      adi,device-addrs =3D <0 1>;
>      adi,resolution   =3D <16 12>;   /* per-chip, indexed by position */
>      reset-gpios =3D <&gpio0 87 GPIO_ACTIVE_LOW>;
>      vdd-supply  =3D <&vdd_reg>;
>      hvdd-supply =3D <&hvdd_reg>;
>=20
>      channel@0  { reg =3D <0>;  adi,output-range-microvolt =3D <0 5000000=
>; };
>      channel@16 { reg =3D <16>; adi,output-range-microvolt =3D <0 4000000=
0>; };




> };
>=20
>=20
> 1) This follows the daisy-chain/aggregated model as you suggested, exposi=
ng N*16 channels as a single IIO device.
> 2) Keeps the binding flat- no phantom compatible at a parent bus node, no=
 per-chip child nodes.
> 3) Enables a 12 bit + 16 bit device combination in the chain, without nee=
ding a per-chip compatible.
> 4) adi, device-addrs specifies the HW address, allowing the driver to enc=
ode it into the SPI frame.
> 5) Supplies and GPIOs remain simple- assuming parallel wiring across all =
chips.
>=20
> Jonathan, you had earlier suggested using separate compatibles
>   (adi,ad5529r-16 and adi,ad5529r-12) to handle the
>   resolution difference.
> However, with the aggregated flat binding model,
>   separate per-chip compatibles would require child nodes which brings
> back the phantom compatible problem at the parent level. The
>   adi,resolution array is intended as an alternative that achieves the
> same goal-expressing per-chip resolution, without needing a per-chip
>   compatible or child node structure.
>=20
> Does this look reasonable?
>=20
> Best Regards,
> Janani Sunil
>=20
>=20

