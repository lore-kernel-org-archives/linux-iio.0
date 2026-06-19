Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1672D0602;
	Fri, 19 Jun 2026 14:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781878334; cv=none; b=PX34MGxzPtv5KApj8epX8I6H1QhhTbsFVVfjL3pnRONTN+kRUDVFdqRsyrz+pY7C7+5TZIBo1shVs4FviVIVNbVZe4onihhNHRn9xsn8tMEISKHHQLt2+HHauMrhyzSQDMl6Qxhel0ZahhD6NfQT97SArChSQnUUI/p1V86MmLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781878334; c=relaxed/simple;
	bh=lTxrd4X/j8Acp+ezn8gTZU00Z3TWrANSh9F7Jp4RNXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OPMFCQyrQH8yLGw1pffdgHJ1M335kWOpEt5wVkoY5oe/8alMtuJCFxjK/1OLN2pJ0RhJ9g7o8sPR2Rud7l5osvDM3oZIP5CbpOWGOpg8UBElEDhtvE9gJnrPpAzfJ4Q5dFlsLh0CDQkYACccH6RJUsbGy67bvv1vaaXjYME72gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZus099i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZus099i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F6E61F00A3E;
	Fri, 19 Jun 2026 14:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781878333;
	bh=vgmUEVEuz00IPzQuWeSvdJebrj41UNbKZI4bgbBtCic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gZus099iJi7CedNbjqiy4F3CPil9S0zD2a0D6o/h30JE7pyYupYphW1y+yNkWfqXS
	 vTp1Angi2cbfhDlVKYV42K0D/9skho0tW8Kg7TDf3vM4y84bX1Gv+Ji+JuHjqPgLkw
	 kXt3M/7LoL3VFmawyFEyRsIJIsGxCEE+nWye+DEWzBjDO+b0ccPQkHzJPfuGf6gCT+
	 Iq8Ub/6lSi1EzVpRTzigkNwzLJ8fSIRkQJkwvZyr3dRZkaTRGI4dJ0ZbaN0B5+IKoP
	 XSRsqJvB0j4Y6Qy/rhGHBWBVTSa5kPAaYhfst/90NHJkER2FjJjuoEcA/1wXbomNlH
	 Cm1KMok1HTHVw==
Date: Fri, 19 Jun 2026 15:12:07 +0100
From: Conor Dooley <conor@kernel.org>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: Janani Sunil <jan.sun97@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
	Rodrigo Alencar <455.rodrigo.alencar@gmail.com>,
	Janani Sunil <janani.sunil@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: dac: Add AD5529R
Message-ID: <20260619-concierge-doozy-9c161533c369@spud>
References: <20260519-ad5529r-driver-v3-0-267c0731aa68@analog.com>
 <20260519-ad5529r-driver-v3-1-267c0731aa68@analog.com>
 <25mh6grzh7zh3b4uytcqnusyv5zjuf6ia4if3ce3oqzqz56ehi@le72iqv7ye3d>
 <603473ac-30e6-45e5-8a3b-c9902715cc9e@gmail.com>
 <20260614204455.408c4d40@jic23-huawei>
 <076d7d2d-81a0-49c2-af94-bd65ead66c09@gmail.com>
 <20260619-obstinate-polo-a230bef97fda@spud>
 <20260619-bunch-diocese-dd7805cc17ff@spud>
 <ajU73_TkKrSbqD4f@nsa>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1Ee5EGgvXsVjyk3T"
Content-Disposition: inline
In-Reply-To: <ajU73_TkKrSbqD4f@nsa>


--1Ee5EGgvXsVjyk3T
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 19, 2026 at 02:01:08PM +0100, Nuno S=E1 wrote:
> On Fri, Jun 19, 2026 at 12:40:54PM +0100, Conor Dooley wrote:
> > On Fri, Jun 19, 2026 at 12:36:55PM +0100, Conor Dooley wrote:
> > > On Fri, Jun 19, 2026 at 12:33:11PM +0200, Janani Sunil wrote:
> > > >=20
> > > > On 6/14/26 21:44, Jonathan Cameron wrote:
> > > > > On Tue, 9 Jun 2026 16:47:23 +0200
> > > > > Janani Sunil <jan.sun97@gmail.com> wrote:
> > > > >=20
> > > > > > On 5/26/26 15:11, Rodrigo Alencar wrote:
> > > > > > > On 26/05/19 05:42PM, Janani Sunil wrote:
> > > > > > > > Devicetree bindings for AD5529R 16 channel 12/16 bit high v=
oltage,
> > > > > > > > buffered voltage output digital-to-analog converter (DAC) w=
ith an
> > > > > > > > integrated precision reference.
> > > > > > > ...
> > > > > > > Probably others may comment on that, but...
> > > > > > >=20
> > > > > > > This parent node may support device addressing for multi-devi=
ce support through
> > > > > > > those ID pins. I suppose that each device may have its own po=
wer supplies or
> > > > > > > other resources like the toggle pins or reset and enable.
> > > > > > >=20
> > > > > > > That way I suppose that an example would look like...
> > > > > > > > +
> > > > > > > > +patternProperties:
> > > > > > > > +  "^channel@([0-9]|1[0-5])$":
> > > > > > > > +    type: object
> > > > > > > > +    description: Child nodes for individual channel config=
uration
> > > > > > > > +
> > > > > > > > +    properties:
> > > > > > > > +      reg:
> > > > > > > > +        description: Channel number.
> > > > > > > > +        minimum: 0
> > > > > > > > +        maximum: 15
> > > > > > > > +
> > > > > > > > +      adi,output-range-microvolt:
> > > > > > > > +        description: |
> > > > > > > > +          Output voltage range for this channel as [min, m=
ax] in microvolts.
> > > > > > > > +          If not specified, defaults to 0V to 5V range.
> > > > > > > > +        oneOf:
> > > > > > > > +          - items:
> > > > > > > > +              - const: 0
> > > > > > > > +              - enum: [5000000, 10000000, 20000000, 400000=
00]
> > > > > > > > +          - items:
> > > > > > > > +              - const: -5000000
> > > > > > > > +              - const: 5000000
> > > > > > > > +          - items:
> > > > > > > > +              - const: -10000000
> > > > > > > > +              - const: 10000000
> > > > > > > > +          - items:
> > > > > > > > +              - const: -15000000
> > > > > > > > +              - const: 15000000
> > > > > > > > +          - items:
> > > > > > > > +              - const: -20000000
> > > > > > > > +              - const: 20000000
> > > > > > > > +
> > > > > > > > +    required:
> > > > > > > > +      - reg
> > > > > > > > +
> > > > > > > > +    additionalProperties: false
> > > > > > > > +
> > > > > > > > +required:
> > > > > > > > +  - compatible
> > > > > > > > +  - reg
> > > > > > > > +  - vdd-supply
> > > > > > > > +  - avdd-supply
> > > > > > > > +  - hvdd-supply
> > > > > > > > +
> > > > > > > > +dependencies:
> > > > > > > > +  spi-cpha: [ spi-cpol ]
> > > > > > > > +  spi-cpol: [ spi-cpha ]
> > > > > > > > +
> > > > > > > > +allOf:
> > > > > > > > +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> > > > > > > > +
> > > > > > > > +unevaluatedProperties: false
> > > > > > > > +
> > > > > > > > +examples:
> > > > > > > > +  - |
> > > > > > > > +    #include <dt-bindings/gpio/gpio.h>
> > > > > > > > +
> > > > > > > > +    spi {
> > > > > > > > +        #address-cells =3D <1>;
> > > > > > > > +        #size-cells =3D <0>;
> > > > > > > > +
> > > > > > > > +        dac@0 {
> > > > > > > > +            compatible =3D "adi,ad5529r-16";
> > > > > > > > +            reg =3D <0>;
> > > > > > > > +            spi-max-frequency =3D <25000000>;
> > > > > > > > +
> > > > > > > > +            vdd-supply =3D <&vdd_regulator>;
> > > > > > > > +            avdd-supply =3D <&avdd_regulator>;
> > > > > > > > +            hvdd-supply =3D <&hvdd_regulator>;
> > > > > > > > +            hvss-supply =3D <&hvss_regulator>;
> > > > > > > > +
> > > > > > > > +            reset-gpios =3D <&gpio0 87 GPIO_ACTIVE_LOW>;
> > > > > > > > +
> > > > > > > > +            #address-cells =3D <1>;
> > > > > > > > +            #size-cells =3D <0>;
> > > > > > > > +
> > > > > > > > +            channel@0 {
> > > > > > > > +                reg =3D <0>;
> > > > > > > > +                adi,output-range-microvolt =3D <0 5000000>;
> > > > > > > > +            };
> > > > > > > > +
> > > > > > > > +            channel@1 {
> > > > > > > > +                reg =3D <1>;
> > > > > > > > +                adi,output-range-microvolt =3D <(-10000000=
) 10000000>;
> > > > > > > > +            };
> > > > > > > > +
> > > > > > > > +            channel@2 {
> > > > > > > > +                reg =3D <2>;
> > > > > > > > +                adi,output-range-microvolt =3D <0 40000000=
>;
> > > > > > > > +            };
> > > > > > > > +        };
> > > > > > > > +    };
> > > > > > > ...
> > > > > > >=20
> > > > > > > 	spi {
> > > > > > > 		#address-cells =3D <1>;
> > > > > > > 		#size-cells =3D <0>;
> > > > > > >=20
> > > > > > > 		multi-dac@0 {
> > > > > > > 			compatible =3D "adi,ad5529r-16";
> > > > > > > 			reg =3D <0>;
> > > > > > > 			spi-max-frequency =3D <25000000>;
> > > > > > >=20
> > > > > > > 			#address-cells =3D <1>;
> > > > > > > 			#size-cells =3D <0>;
> > > > > > >=20
> > > > > > > 			dac@0 {
> > > > > > > 				reg =3D <0>;
> > > > > > > 				vdd-supply =3D <&vdd_regulator>;
> > > > > > > 				avdd-supply =3D <&avdd_regulator>;
> > > > > > > 				hvdd-supply =3D <&hvdd_regulator>;
> > > > > > > 				hvss-supply =3D <&hvss_regulator>;
> > > > > > >=20
> > > > > > > 				reset-gpios =3D <&gpio0 87 GPIO_ACTIVE_LOW>;
> > > > > > >=20
> > > > > > > 				#address-cells =3D <1>;
> > > > > > > 				#size-cells =3D <0>;
> > > > > > >=20
> > > > > > > 				channel@0 {
> > > > > > > 					reg =3D <0>;
> > > > > > > 					adi,output-range-microvolt =3D <0 5000000>;
> > > > > > > 				};
> > > > > > >=20
> > > > > > > 				channel@1 {
> > > > > > > 					reg =3D <1>;
> > > > > > > 					adi,output-range-microvolt =3D <(-10000000) 10000000>;
> > > > > > > 				};
> > > > > > >=20
> > > > > > > 				channel@2 {
> > > > > > > 					reg =3D <2>;
> > > > > > > 					adi,output-range-microvolt =3D <0 40000000>;
> > > > > > > 				};
> > > > > > > 			}
> > > > > > >=20
> > > > > > > 			dac@1 {
> > > > > > > 				reg =3D <1>;
> > > > > > > 				vdd-supply =3D <&vdd_regulator>;
> > > > > > > 				avdd-supply =3D <&avdd_regulator>;
> > > > > > > 				hvdd-supply =3D <&hvdd_regulator>;
> > > > > > > 				hvss-supply =3D <&hvss_regulator>;
> > > > > > >=20
> > > > > > > 				reset-gpios =3D <&gpio0 88 GPIO_ACTIVE_LOW>;
> > > > > > >=20
> > > > > > > 				#address-cells =3D <1>;
> > > > > > > 				#size-cells =3D <0>;
> > > > > > >=20
> > > > > > > 				channel@0 {
> > > > > > > 					reg =3D <0>;
> > > > > > > 					adi,output-range-microvolt =3D <0 5000000>;
> > > > > > > 				};
> > > > > > >=20
> > > > > > > 				channel@1 {
> > > > > > > 					reg =3D <1>;
> > > > > > > 					adi,output-range-microvolt =3D <(-10000000) 10000000>;
> > > > > > > 				};
> > > > > > > 			}
> > > > > > > 		};
> > > > > > > 	};
> > > > > > >=20
> > > > > > > then you might need something like:
> > > > > > >=20
> > > > > > > 	patternProperties:
> > > > > > > 		"^dac@[0-3]$":
> > > > > > >=20
> > > > > > > and put most of the things under this node pattern.
> > > > > > >=20
> > > > > > > So the main driver that you're putting together might need to=
 handle up to four instances.
> > > > > > > Even if your current driver cannot handle this, the dt-bindin=
gs might need cover that.
> > > > > > >=20
> > > > > > > Need to double check if each dac node needs a separate compat=
ible, so you would maybe populate
> > > > > > > a platform data to be shared with the child nodes, which woul=
d be a separate driver.
> > > > > > > (not sure if it would make sense to mix and match ad5529r-16 =
and ad5529r-12).
> > > > > > Hi Rodrigo,
> > > > > >=20
> > > > > > Thank you for looking at this.
> > > > > >=20
> > > > > > For now, I would prefer to keep the binding scoped to a single =
AD5529R device instance. The current
> > > > > > hardware/use case we have only needs one device node and the dr=
iver is written around that model as well.
> > > > > > While the device addressing pins could allow multi-device topol=
ogy, we do not have an actual platform using
> > > > > > that configuration at the moment, so I would prefer not to intr=
oduce an extra parent/child binding structure
> > > > > > speculatively without a validating use case.
> > > > > Interesting feature - kind of similar to address control on a typ=
ical i2c bus device, or
> > > > > looking at it another way a kind of distributed SPI mux.
> > > > >=20
> > > > > Challenge of a binding is we need to anticipate the future.  So I=
 think we do need something
> > > > > like Rodrigo is suggesting even if we only (for now) support a si=
ngle instance in the driver.
> > > > > That would leave the path open to supporting the addressing at a =
later date.
> > > > > An alternative might be to look at it like a chained device setup=
=2E In those we pretend there
> > > > > is just one device with a lot of channels etc.  The snag is that =
here things are more loosely
> > > > > coupled whereas for those devices it tends to be you have to read=
 / write the same register
> > > > > in all devices in the chain as one big SPI message.
> > > > >=20
> > > > > +CC Mark Brown as he may know of some precedence for this feature=
=2E For his reference..
> > > > > - Each of these device has 2 ID pins.  The SPI transfers have to =
contain the 2 bit
> > > > > value that matches that or they are ignored.  Thus a single bus +=
 1 chip select can
> > > > > be used to talk to 4 devices.  Question is what that looks like i=
n device tree + I guess
> > > > > longer term how to support it cleanly in SPI.
> > >=20
> > > I'd swear I have seen this before, from some Microchip devices. Let me
> > > see if I can find what I am thinking of...
> >=20
> >=20
> > microchip,mcp3911 and microchip,mcp3564 both seem to do this with
> > slightly different properties.
> >=20
> >   microchip,device-addr:
> >     description: Device address when multiple MCP3911 chips are present=
 on the same SPI bus.
> >     $ref: /schemas/types.yaml#/definitions/uint32
> >     enum: [0, 1, 2, 3]
> >     default: 0
> >=20
> > and
> >=20
> >=20
> >   microchip,hw-device-address:
> >     $ref: /schemas/types.yaml#/definitions/uint32
> >     minimum: 0
> >     maximum: 3
> >     description:
> >       The address is set on a per-device basis by fuses in the factory,
> >       configured on request. If not requested, the fuses are set for 0x=
1.
> >       The device address is part of the device markings to avoid
> >       potential confusion. This address is coded on two bits, so four p=
ossible
> >       addresses are available when multiple devices are present on the =
same
> >       SPI bus with only one Chip Select line for all devices.
> >       Each device communication starts by a CS falling edge, followed b=
y the
> >       clocking of the device address (BITS[7:6] - top two bits of COMMA=
ND BYTE
> >       which is first one on the wire).
> >=20
> > This sounds exactly like the sort of feature that you're dealing with
> > here?
> >=20
>=20
> The core idea yes but for this chip, things are a bit more annoying (but
> Janani can correct me if I'm wrong). Here, each device can, in theory,
> have it's own supplies, pins and at the very least, channels with maybe
> different scales. That is why Janani is proposing dac nodes. Given I
> honestly don't like much of that "adi,ad5529r-bus" compatible I wondered
> about solving this at the spi level.
>=20
> Ah and to make it more annoying, we can also mix 12 and 16 bits variants
> together in the same bus.

I'm definitely missing something, because that property for the
microchip devices is not impacted what else is on the bus. AFAICT, you
could have an mcp3911 and an mcp3564 on the same bus even though both
are completely different devices with different drivers. They have
individual device nodes and their own supplies etc etc. These aren't
per-channel properties on an adc or dac, they're per child device on a
spi bus.

--1Ee5EGgvXsVjyk3T
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCajVONwAKCRB4tDGHoIJi
0g8+AP9yIAaFkTEFQkgh3bofClVqISovOXw4pSJXpMYXyyU5sQEAxEAsbSUZTDDl
WJ0uJup4Vu6cETB9OPtAVv5R9LrgYA4=
=1f1K
-----END PGP SIGNATURE-----

--1Ee5EGgvXsVjyk3T--
