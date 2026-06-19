Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFF540D59E;
	Fri, 19 Jun 2026 11:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781869261; cv=none; b=Vc5+ylJodB1wTRYPKd7ZtV631E47aCTUgZB+Oc4cjDKDYBvgU3FFVROnRq31ymYTHv4XrMdRG1E/kjTQzkIzQGioaRYXoBw1lF7WEtLarGWcBc+8lFDvat94AwbBHjxHuM0vTCeYRPJFXgcthtyTRDrSKzvCXTZUJe13AyHVtbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781869261; c=relaxed/simple;
	bh=GZZC6aPg4mMBFKS4CBPmjfbf0ShWzLUKtgWEMGf3MJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QlScNIv3IWCtWLjCG6yjxs+262rjMiTDCVPAxF9n0IbIC3afs6NyXJZXa85baogHHzD7Cd0cBqP88WwHOFdeLji+KsBmQ9qOVYFUFfaE7pMTLeORJ1hfIJEovDZ+Ape9PWJtCMxJbLrMVMI0JOkvJMhlUfuO8XfUhnp+EpN6FNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VimNGmB5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VimNGmB5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 411201F000E9;
	Fri, 19 Jun 2026 11:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781869259;
	bh=V8NaQIymO2h7yghwF8WFUG91Usq29eTYCD7e6MwtEWg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VimNGmB5xXzyF+yn9UvjKirZjP0E3XnIqr1fIlgH7BGWinGWZVItmaCKhu76G2vvX
	 0IprsSNGRA6v9j+2vsnXstnDfUYxtaxAcDj4hoifEcqDA7AyN7sBnqmEeMiA9WjlwV
	 AizDKf4+g0IOIMqSmrzXb1tWj0tHAhs0K+U/1JKjEMGFPJKs5Z+vReq12U16vy1I2T
	 20xVC8l0iK6/a/sHMpwPQskIhiIXsG3vwnGn0ihRCsRucgKOwseYJ7JaLEwTM8ycFL
	 FTpxN5I7O84BUXpkKFdSH1SDvbAaouyPcGG5t/vmH0fx876cATy76DVlih980ISyC6
	 wlXsPunEnbVvA==
Date: Fri, 19 Jun 2026 12:40:54 +0100
From: Conor Dooley <conor@kernel.org>
To: Janani Sunil <jan.sun97@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
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
Message-ID: <20260619-bunch-diocese-dd7805cc17ff@spud>
References: <20260519-ad5529r-driver-v3-0-267c0731aa68@analog.com>
 <20260519-ad5529r-driver-v3-1-267c0731aa68@analog.com>
 <25mh6grzh7zh3b4uytcqnusyv5zjuf6ia4if3ce3oqzqz56ehi@le72iqv7ye3d>
 <603473ac-30e6-45e5-8a3b-c9902715cc9e@gmail.com>
 <20260614204455.408c4d40@jic23-huawei>
 <076d7d2d-81a0-49c2-af94-bd65ead66c09@gmail.com>
 <20260619-obstinate-polo-a230bef97fda@spud>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3jc0JybyJ73uQsPl"
Content-Disposition: inline
In-Reply-To: <20260619-obstinate-polo-a230bef97fda@spud>


--3jc0JybyJ73uQsPl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 19, 2026 at 12:36:55PM +0100, Conor Dooley wrote:
> On Fri, Jun 19, 2026 at 12:33:11PM +0200, Janani Sunil wrote:
> >=20
> > On 6/14/26 21:44, Jonathan Cameron wrote:
> > > On Tue, 9 Jun 2026 16:47:23 +0200
> > > Janani Sunil <jan.sun97@gmail.com> wrote:
> > >=20
> > > > On 5/26/26 15:11, Rodrigo Alencar wrote:
> > > > > On 26/05/19 05:42PM, Janani Sunil wrote:
> > > > > > Devicetree bindings for AD5529R 16 channel 12/16 bit high volta=
ge,
> > > > > > buffered voltage output digital-to-analog converter (DAC) with =
an
> > > > > > integrated precision reference.
> > > > > ...
> > > > > Probably others may comment on that, but...
> > > > >=20
> > > > > This parent node may support device addressing for multi-device s=
upport through
> > > > > those ID pins. I suppose that each device may have its own power =
supplies or
> > > > > other resources like the toggle pins or reset and enable.
> > > > >=20
> > > > > That way I suppose that an example would look like...
> > > > > > +
> > > > > > +patternProperties:
> > > > > > +  "^channel@([0-9]|1[0-5])$":
> > > > > > +    type: object
> > > > > > +    description: Child nodes for individual channel configurat=
ion
> > > > > > +
> > > > > > +    properties:
> > > > > > +      reg:
> > > > > > +        description: Channel number.
> > > > > > +        minimum: 0
> > > > > > +        maximum: 15
> > > > > > +
> > > > > > +      adi,output-range-microvolt:
> > > > > > +        description: |
> > > > > > +          Output voltage range for this channel as [min, max] =
in microvolts.
> > > > > > +          If not specified, defaults to 0V to 5V range.
> > > > > > +        oneOf:
> > > > > > +          - items:
> > > > > > +              - const: 0
> > > > > > +              - enum: [5000000, 10000000, 20000000, 40000000]
> > > > > > +          - items:
> > > > > > +              - const: -5000000
> > > > > > +              - const: 5000000
> > > > > > +          - items:
> > > > > > +              - const: -10000000
> > > > > > +              - const: 10000000
> > > > > > +          - items:
> > > > > > +              - const: -15000000
> > > > > > +              - const: 15000000
> > > > > > +          - items:
> > > > > > +              - const: -20000000
> > > > > > +              - const: 20000000
> > > > > > +
> > > > > > +    required:
> > > > > > +      - reg
> > > > > > +
> > > > > > +    additionalProperties: false
> > > > > > +
> > > > > > +required:
> > > > > > +  - compatible
> > > > > > +  - reg
> > > > > > +  - vdd-supply
> > > > > > +  - avdd-supply
> > > > > > +  - hvdd-supply
> > > > > > +
> > > > > > +dependencies:
> > > > > > +  spi-cpha: [ spi-cpol ]
> > > > > > +  spi-cpol: [ spi-cpha ]
> > > > > > +
> > > > > > +allOf:
> > > > > > +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> > > > > > +
> > > > > > +unevaluatedProperties: false
> > > > > > +
> > > > > > +examples:
> > > > > > +  - |
> > > > > > +    #include <dt-bindings/gpio/gpio.h>
> > > > > > +
> > > > > > +    spi {
> > > > > > +        #address-cells =3D <1>;
> > > > > > +        #size-cells =3D <0>;
> > > > > > +
> > > > > > +        dac@0 {
> > > > > > +            compatible =3D "adi,ad5529r-16";
> > > > > > +            reg =3D <0>;
> > > > > > +            spi-max-frequency =3D <25000000>;
> > > > > > +
> > > > > > +            vdd-supply =3D <&vdd_regulator>;
> > > > > > +            avdd-supply =3D <&avdd_regulator>;
> > > > > > +            hvdd-supply =3D <&hvdd_regulator>;
> > > > > > +            hvss-supply =3D <&hvss_regulator>;
> > > > > > +
> > > > > > +            reset-gpios =3D <&gpio0 87 GPIO_ACTIVE_LOW>;
> > > > > > +
> > > > > > +            #address-cells =3D <1>;
> > > > > > +            #size-cells =3D <0>;
> > > > > > +
> > > > > > +            channel@0 {
> > > > > > +                reg =3D <0>;
> > > > > > +                adi,output-range-microvolt =3D <0 5000000>;
> > > > > > +            };
> > > > > > +
> > > > > > +            channel@1 {
> > > > > > +                reg =3D <1>;
> > > > > > +                adi,output-range-microvolt =3D <(-10000000) 10=
000000>;
> > > > > > +            };
> > > > > > +
> > > > > > +            channel@2 {
> > > > > > +                reg =3D <2>;
> > > > > > +                adi,output-range-microvolt =3D <0 40000000>;
> > > > > > +            };
> > > > > > +        };
> > > > > > +    };
> > > > > ...
> > > > >=20
> > > > > 	spi {
> > > > > 		#address-cells =3D <1>;
> > > > > 		#size-cells =3D <0>;
> > > > >=20
> > > > > 		multi-dac@0 {
> > > > > 			compatible =3D "adi,ad5529r-16";
> > > > > 			reg =3D <0>;
> > > > > 			spi-max-frequency =3D <25000000>;
> > > > >=20
> > > > > 			#address-cells =3D <1>;
> > > > > 			#size-cells =3D <0>;
> > > > >=20
> > > > > 			dac@0 {
> > > > > 				reg =3D <0>;
> > > > > 				vdd-supply =3D <&vdd_regulator>;
> > > > > 				avdd-supply =3D <&avdd_regulator>;
> > > > > 				hvdd-supply =3D <&hvdd_regulator>;
> > > > > 				hvss-supply =3D <&hvss_regulator>;
> > > > >=20
> > > > > 				reset-gpios =3D <&gpio0 87 GPIO_ACTIVE_LOW>;
> > > > >=20
> > > > > 				#address-cells =3D <1>;
> > > > > 				#size-cells =3D <0>;
> > > > >=20
> > > > > 				channel@0 {
> > > > > 					reg =3D <0>;
> > > > > 					adi,output-range-microvolt =3D <0 5000000>;
> > > > > 				};
> > > > >=20
> > > > > 				channel@1 {
> > > > > 					reg =3D <1>;
> > > > > 					adi,output-range-microvolt =3D <(-10000000) 10000000>;
> > > > > 				};
> > > > >=20
> > > > > 				channel@2 {
> > > > > 					reg =3D <2>;
> > > > > 					adi,output-range-microvolt =3D <0 40000000>;
> > > > > 				};
> > > > > 			}
> > > > >=20
> > > > > 			dac@1 {
> > > > > 				reg =3D <1>;
> > > > > 				vdd-supply =3D <&vdd_regulator>;
> > > > > 				avdd-supply =3D <&avdd_regulator>;
> > > > > 				hvdd-supply =3D <&hvdd_regulator>;
> > > > > 				hvss-supply =3D <&hvss_regulator>;
> > > > >=20
> > > > > 				reset-gpios =3D <&gpio0 88 GPIO_ACTIVE_LOW>;
> > > > >=20
> > > > > 				#address-cells =3D <1>;
> > > > > 				#size-cells =3D <0>;
> > > > >=20
> > > > > 				channel@0 {
> > > > > 					reg =3D <0>;
> > > > > 					adi,output-range-microvolt =3D <0 5000000>;
> > > > > 				};
> > > > >=20
> > > > > 				channel@1 {
> > > > > 					reg =3D <1>;
> > > > > 					adi,output-range-microvolt =3D <(-10000000) 10000000>;
> > > > > 				};
> > > > > 			}
> > > > > 		};
> > > > > 	};
> > > > >=20
> > > > > then you might need something like:
> > > > >=20
> > > > > 	patternProperties:
> > > > > 		"^dac@[0-3]$":
> > > > >=20
> > > > > and put most of the things under this node pattern.
> > > > >=20
> > > > > So the main driver that you're putting together might need to han=
dle up to four instances.
> > > > > Even if your current driver cannot handle this, the dt-bindings m=
ight need cover that.
> > > > >=20
> > > > > Need to double check if each dac node needs a separate compatible=
, so you would maybe populate
> > > > > a platform data to be shared with the child nodes, which would be=
 a separate driver.
> > > > > (not sure if it would make sense to mix and match ad5529r-16 and =
ad5529r-12).
> > > > Hi Rodrigo,
> > > >=20
> > > > Thank you for looking at this.
> > > >=20
> > > > For now, I would prefer to keep the binding scoped to a single AD55=
29R device instance. The current
> > > > hardware/use case we have only needs one device node and the driver=
 is written around that model as well.
> > > > While the device addressing pins could allow multi-device topology,=
 we do not have an actual platform using
> > > > that configuration at the moment, so I would prefer not to introduc=
e an extra parent/child binding structure
> > > > speculatively without a validating use case.
> > > Interesting feature - kind of similar to address control on a typical=
 i2c bus device, or
> > > looking at it another way a kind of distributed SPI mux.
> > >=20
> > > Challenge of a binding is we need to anticipate the future.  So I thi=
nk we do need something
> > > like Rodrigo is suggesting even if we only (for now) support a single=
 instance in the driver.
> > > That would leave the path open to supporting the addressing at a late=
r date.
> > > An alternative might be to look at it like a chained device setup. In=
 those we pretend there
> > > is just one device with a lot of channels etc.  The snag is that here=
 things are more loosely
> > > coupled whereas for those devices it tends to be you have to read / w=
rite the same register
> > > in all devices in the chain as one big SPI message.
> > >=20
> > > +CC Mark Brown as he may know of some precedence for this feature. Fo=
r his reference..
> > > - Each of these device has 2 ID pins.  The SPI transfers have to cont=
ain the 2 bit
> > > value that matches that or they are ignored.  Thus a single bus + 1 c=
hip select can
> > > be used to talk to 4 devices.  Question is what that looks like in de=
vice tree + I guess
> > > longer term how to support it cleanly in SPI.
>=20
> I'd swear I have seen this before, from some Microchip devices. Let me
> see if I can find what I am thinking of...


microchip,mcp3911 and microchip,mcp3564 both seem to do this with
slightly different properties.

  microchip,device-addr:
    description: Device address when multiple MCP3911 chips are present on =
the same SPI bus.
    $ref: /schemas/types.yaml#/definitions/uint32
    enum: [0, 1, 2, 3]
    default: 0

and


  microchip,hw-device-address:
    $ref: /schemas/types.yaml#/definitions/uint32
    minimum: 0
    maximum: 3
    description:
      The address is set on a per-device basis by fuses in the factory,
      configured on request. If not requested, the fuses are set for 0x1.
      The device address is part of the device markings to avoid
      potential confusion. This address is coded on two bits, so four possi=
ble
      addresses are available when multiple devices are present on the same
      SPI bus with only one Chip Select line for all devices.
      Each device communication starts by a CS falling edge, followed by the
      clocking of the device address (BITS[7:6] - top two bits of COMMAND B=
YTE
      which is first one on the wire).

This sounds exactly like the sort of feature that you're dealing with
here?


--3jc0JybyJ73uQsPl
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCajUqxgAKCRB4tDGHoIJi
0qZcAP0T/Wl9uIPL4MddTjXoDbgVyp/v718Z52E1733pHn2RwwD8Df6/fV0qKP16
CqXIDIlTZZGOhBxuQfUyCMURyv1EXAI=
=EnyT
-----END PGP SIGNATURE-----

--3jc0JybyJ73uQsPl--
