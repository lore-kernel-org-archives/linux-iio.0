Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795717518;
	b=l9V38+CNeV46ogiakD17U2O/c+llPUAujsBrdlFuIpW+Ob+pBM7EOE5FoyMUiJ2ExbJp
	 Q4sAThNjvBOui3oB5Qu/EIj8KYRrZ9Y91JIYS3FfekxSUxNevlDrwVh24ENB84fiVbAKn
	 N1Jkth2JaqSV7hUdwGlqDdS9rSOr/uNs+LqrATMYbTTGj2+0ECFpfokoHB7QCiOebRdRR
	 Sxhv0yETYQRmU9VOFaasrOJ0KVvLwmnOqtTRgsxAGAacQd9zcXJt5TWu2ePFsJhyl/Sh0
	 zcn1s1aV/SeAS+GGGBu4sjyMDISqvoYw40Mitc1mNOb8aKwktJjREaPoOBKxrfuomzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795717518;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=H31adSOeCFpDpgmWUWnmLQhWQC/GR1dbRO0uHdk9MQE=;
	b=ZnbhcfOAub9KlAbYdYZXehlvhN9jiiIxn6mI2vnSd9E1lPxh+vOUrAOf4CVYAIU4u6mG
	 4MW3Cqvv/tII4c6YONse8QKQrgQ1a3eHl8cjUhZEPvGiAsOo34Vsb9MW5vp4vMfkDsgOn
	 4Jq7+YNU3RxKhE5aDbG51Zcvl6eIzm6dT/CIwzPuiKUh/EiTRxh31mJDt7S2BFB04afDR
	 bkffgOIjJLQX5i851kRYpSZj6V9kMr0WyUrHLmb4OMN5INibwxW/nOnLLpjI0Ru7aKQqC
	 Dd0hAGwtdPw5c8Ut4Q0jwNiVSh6r+63xfx/jAvvK4yDMGDDoOyszeOdI9UK0bfMcREA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BxosGxu5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DD5606A323;
	Thu, 26 Nov 2026 18:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BxosGxu5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D73B1F000C0;
	Thu, 26 Nov 2026 18:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795717517;
	bh=H31adSOeCFpDpgmWUWnmLQhWQC/GR1dbRO0uHdk9MQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BxosGxu5TRmDf5xGDNM3cYsPzm07hDlZ2q8/CD0K1nr7HrQJ+d/Eq4zes5XAA0iuQ
	 COHt50cX4ihy82et25zBVVVhgTWAXLlSXsEc0qjsXaHvcXngBUD9b0Byca+rfXsBS9
	 LoIxj3xqasGuDSOXimVpkLY5qXUOiwp6dAwo4B2jDd0ioCSmTj8oRu7FDvQlt3OE1Q
	 quro2U96mP6Nz2KDlGNQWvZ5FeREYPyS+JGpOj6TggcVAww7eaon41zrJMU9JYXP33
	 hv1TDSeHwQ2qz9sntL+jwQpDOnPscUbiTJerrIkC032aSXgXJLJBNQUgSHyUk+5LVj
	 bekzxL3GEfSgA==
Date: Thu, 26 Nov 2026 18:25:13 +0000
From: Conor Dooley <conor@kernel.org>
To: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux@analog.com,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 5/6] dt-bindings: iio: adc: add AD7793 and similar ADCs
Message-ID: <20261126-hunter-catatonic-12f9c835f94e@spud>
References: <20261125-iio-adi-legacy-platdata-v1-0-54e4c8830b57@analog.com>
 <20261125-iio-adi-legacy-platdata-v1-5-54e4c8830b57@analog.com>
 <20261125-whenever-spinning-36a6dc477a00@spud>
 <awgLBWt6MWIRK-cM@nsa>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oFj9t82+62QbHXlO"
Content-Disposition: inline
In-Reply-To: <awgLBWt6MWIRK-cM@nsa>

--oFj9t82+62QbHXlO
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 26, 2026 at 12:24:28PM +0000, Nuno S=E1 wrote:
> On Wed, Nov 25, 2026 at 05:41:08PM +0000, Conor Dooley wrote:
> > On Wed, Nov 25, 2026 at 10:19:21AM +0000, Nuno S=E1 wrote:
> > > Add a binding for the AD7785, AD7792, AD7793, AD7794, AD7795, AD7796,
> > > AD7797, AD7798 and AD7799 low power sigma-delta ADCs. The driver has
> > > supported these parts for a long time, but only through platform data.
> > >=20
> > > The ADC reference is described by which supplies are present: REFIN
> > > (REFIN1 on the AD7794/AD7795), then REFIN2, and otherwise the internal
> > > 1.17 V reference. In the same way, an external clock on the CLK pin is
> > > used if one is given, and the internal 64 kHz clock otherwise.
> > >=20
> > > The remaining properties describe how the analog front end is wired:
> > > the input buffer (enabled by default, as it is at power-up), unipolar
> > > or bipolar coding, the burnout current sources, the bias voltage
> > > generator and the excitation current sources.
> > >=20
> > > Signed-off-by: Nuno S=E1 <nuno.sa@analog.com>
> > > ---
> > >  .../devicetree/bindings/iio/adc/adi,ad7793.yaml    | 236 +++++++++++=
++++++++++
> > >  MAINTAINERS                                        |  10 +
> > >  2 files changed, 246 insertions(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7793.yam=
l b/Documentation/devicetree/bindings/iio/adc/adi,ad7793.yaml
> > > new file mode 100644
> > > index 000000000000..c4a0be06e5c0
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7793.yaml
> > > @@ -0,0 +1,236 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/iio/adc/adi,ad7793.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Analog Devices AD7793 and similar sigma-delta ADCs
> > > +
> > > +maintainers:
> > > +  - Michael Hennerich <michael.hennerich@analog.com>
> > > +  - Nuno S=E1 <nuno.sa@analog.com>
> > > +
> > > +description:
> > > +  Low power, low noise sigma-delta ADCs with an SPI interface.
> > > +
> > > +  https://www.analog.com/media/en/technical-documentation/data-sheet=
s/AD7785.pdf
> > > +  https://www.analog.com/media/en/technical-documentation/data-sheet=
s/AD7792_7793.pdf
> > > +  https://www.analog.com/media/en/technical-documentation/data-sheet=
s/AD7794_7795.pdf
> > > +  https://www.analog.com/media/en/technical-documentation/data-sheet=
s/AD7796_7797.pdf
> > > +  https://www.analog.com/media/en/technical-documentation/data-sheet=
s/AD7798_7799.pdf
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - adi,ad7785
> > > +      - adi,ad7792
> > > +      - adi,ad7793
> > > +      - adi,ad7794
> > > +      - adi,ad7795
> > > +      - adi,ad7796
> > > +      - adi,ad7797
> > > +      - adi,ad7798
> > > +      - adi,ad7799
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  spi-cpol: true
> > > +
> > > +  spi-cpha: true
> > > +
> > > +  interrupts:
> > > +    description: Interrupt connected to the DOUT/RDY pin.
> > > +    maxItems: 1
> > > +
> > > +  rdy-gpios:
> > > +    description:
> > > +      GPIO reading the DOUT/RDY line. DOUT/RDY also toggles during S=
PI
> > > +      transfers, which usually triggers spurious interrupts. Reading=
 this GPIO
> > > +      allows to tell those apart from real conversion done events.
> > > +    maxItems: 1
> > > +
> > > +  avdd-supply: true
> > > +
> > > +  dvdd-supply: true
> > > +
> > > +  refin-supply:
> > > +    description:
> > > +      External reference applied between REFIN(+) and REFIN(-), or b=
etween
> > > +      REFIN1(+) and REFIN1(-) on the AD7794 and AD7795. If present, =
it is used
> > > +      as the ADC reference. If neither refin-supply nor refin2-suppl=
y are
> > > +      present, the internal 1.17 V reference is used.
> > > +
> > > +  refin2-supply:
> > > +    description:
> > > +      External reference applied between REFIN2(+) and REFIN2(-). Us=
ed as the
> > > +      ADC reference if refin-supply is not present.
> > > +
> > > +  clocks:
> > > +    description:
> > > +      External clock connected to the CLK pin. Either 64 kHz, or 128=
 kHz in
> > > +      which case it gets divided by 2 internally. If not present, th=
e internal
> > > +      64 kHz clock is used.
> > > +    maxItems: 1
> > > +
> > > +  bipolar:
> > > +    description: see Documentation/devicetree/bindings/iio/adc/adc.y=
aml
> > > +    type: boolean
> >=20
> > This is odd, why not ref the file normally?
>=20
> Yes, was not sure on this one but saw precedence in:
>=20
> https://elixir.bootlin.com/linux/v7.4-rc1/source/Documentation/devicetree=
/bindings/iio/adc/adi,ad7192.yaml#L106
>=20
> Which might obviously be wrong! And I just noticed that in that one we
> do have it again referenced in the channel properties. So it might be
> just some legacy thing.

Ah right of course, adc.yaml is for channels...

>=20
> But in here the case is really this is a device wide (not per channel)
> property. But I realize that can just do:
>=20
> $ref: /schemas/iio/adc/adc.yaml#/properties/bipolar
>=20
> right?

Happens a good bit for ports, I don't see why not here either.

>=20
> >=20
> > > +
> > > +  adi,buffer-disable:
> > > +    description:
> > > +      Operate the analog inputs in unbuffered mode. Unbuffered mode =
allows the
> > > +      inputs to go from 30 mV below GND to 30 mV above AVDD, while b=
uffered
> > > +      mode needs 100 mV of headroom to the supply rails but tolerate=
s source
> > > +      impedances in front of the inputs. Buffered mode is always use=
d for gains
> > > +      higher than 2.
> > > +    type: boolean
> >=20
> > What determines if the gain is higher than 2?
>=20
> Userspace does, through the scale attribute. So this property only has an=
 effect when the gain is 1 or 2.
> For higher gains the buffer is always on
>=20
> >=20
> > > +
> > > +  adi,burnout-currents-enable:
> > > +    description:
> > > +      Enable the 100 nA burnout current sources in the signal path, =
which allow
> > > +      to detect an open circuit on the selected analog input. They c=
an only be
> > > +      enabled when either the buffer or the in-amp is active.
> >=20
> > The former should be somewhat enforceable with the binding, what
> > determins this in-amp's setting?
>=20
> Same deal. For gains >=3D 4, the in-amp becomes active in the path (and t=
he buffer is forced on),
> so there's no way we can enforce this at the binding level:
>=20
> For gains 1 or 2, with adi,buffer-disable, adi,burnout-currents-enable is=
 irrelevant, as the
> datasheet onl allows the burnout currents with the buffer or in-amp activ=
e.
>=20
> For gains >=3D 4 it's the other way around: adi,buffer-disable is irrelev=
ant.
>=20
> So it should be the driver to make sure all of it remains sane.
>=20
> But I did take a look on the datasheet and this actually seems wrong to
> be honest (the burnout stuff). Datasheet:
>=20
> "These currents can be used to verify that an external transducer is stil=
l operational before
> attempting to take measurements on that channel."
> "For normal operation, these burnout currents are turned off by writing a=
 0 to the BO bit
> in the configuration register."
>=20
> So I'll just drop the burnout property and maybe have it as a debugfs
> thing.

For both of these properties, I think meaning assigned to them should
change (if kept). e.g. buffer-disable should not be a property that
disables the buffer, but instead tells software that the conditions for
disabling the buffer have been met by the hardware, and it is up to the
software to disable it if the gain is suitable. I assume that the buffer
doesn't auto turn off when the gain drops below 2 and the driver has to
intentionally deactivate it?

Conor.

>=20
> - Nuno S=E1
>=20
> >=20
> > > +    type: boolean
> > > +
> > > +  adi,vbias-pin:
> > > +    description:
> > > +      Negative analog input (AINx(-)) to bias to AVDD / 2 with the b=
ias voltage
> > > +      generator.
> > > +    $ref: /schemas/types.yaml#/definitions/string
> > > +    enum: [ain1, ain2, ain3]
> > > +
> > > +  adi,vbias-boost-enable:
> > > +    description:
> > > +      Increase the current of the bias voltage generator, reducing i=
ts power-up
> > > +      time.
> > > +    type: boolean
> > > +
> > > +  adi,excitation-current-microamp:
> > > +    description:
> > > +      Enables the excitation current sources IEXC1 and IEXC2. Both a=
re always
> > > +      enabled together and set to this same value. Where each one is=
 connected
> > > +      is given by adi,excitation-pins.
> > > +    enum: [10, 210, 1000]
> > > +
> > > +  adi,excitation-pins:
> > > +    description:
> > > +      Output pins the excitation current sources IEXC1 and IEXC2 are=
 routed
> > > +      to, in that order. The default routes IEXC1 to IOUT1 and IEXC2=
 to IOUT2.
> > > +      Both sources can be routed to the same pin, which then outputs=
 twice the
> > > +      configured current. This is not allowed when
> > > +      adi,excitation-current-microamp is 1000.
> > > +    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
> > > +    minItems: 2
> > > +    maxItems: 2
> > > +    items:
> > > +      enum: [iout1, iout2]
> > > +    default: [iout1, iout2]
> > > +
> > > +dependencies:
> > > +  adi,vbias-boost-enable: [ 'adi,vbias-pin' ]
> > > +  adi,excitation-pins: [ 'adi,excitation-current-microamp' ]
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - interrupts
> > > +  - avdd-supply
> > > +  - dvdd-supply
> > > +
> > > +allOf:
> > > +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> > > +  - if:
> > > +      properties:
> > > +        adi,excitation-current-microamp:
> > > +          const: 1000
> > > +      required:
> > > +        - adi,excitation-current-microamp
> > > +    then:
> > > +      properties:
> > > +        adi,excitation-pins:
> > > +          oneOf:
> > > +            - items:
> > > +                - const: iout1
> > > +                - const: iout2
> > > +            - items:
> > > +                - const: iout2
> > > +                - const: iout1
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          contains:
> > > +            enum:
> > > +              - adi,ad7785
> > > +              - adi,ad7792
> > > +              - adi,ad7793
> > > +    then:
> > > +      properties:
> > > +        refin2-supply: false
> > > +        adi,vbias-pin:
> > > +          enum: [ain1, ain2]
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          contains:
> > > +            enum:
> > > +              - adi,ad7796
> > > +              - adi,ad7797
> > > +              - adi,ad7798
> > > +              - adi,ad7799
> > > +    then:
> > > +      properties:
> > > +        refin2-supply: false
> > > +        adi,vbias-pin: false
> > > +        adi,vbias-boost-enable: false
> > > +        adi,excitation-current-microamp: false
> > > +        adi,excitation-pins: false
> > > +      required:
> > > +        - refin-supply
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          contains:
> > > +            enum:
> > > +              - adi,ad7796
> > > +              - adi,ad7797
> > > +    then:
> > > +      properties:
> > > +        adi,buffer-disable: false
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          contains:
> > > +            enum:
> > > +              - adi,ad7798
> > > +              - adi,ad7799
> > > +    then:
> > > +      properties:
> > > +        clocks: false
> > > +
> > > +unevaluatedProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    #include <dt-bindings/interrupt-controller/irq.h>
> > > +
> > > +    spi {
> > > +        #address-cells =3D <1>;
> > > +        #size-cells =3D <0>;
> > > +
> > > +        adc@0 {
> > > +            compatible =3D "adi,ad7793";
> > > +            reg =3D <0>;
> > > +            spi-max-frequency =3D <5000000>;
> > > +            spi-cpol;
> > > +            spi-cpha;
> > > +            interrupts =3D <25 IRQ_TYPE_EDGE_FALLING>;
> > > +            interrupt-parent =3D <&gpio>;
> > > +            avdd-supply =3D <&avdd>;
> > > +            dvdd-supply =3D <&dvdd>;
> > > +            refin-supply =3D <&vref>;
> > > +            adi,vbias-pin =3D "ain2";
> > > +            adi,excitation-current-microamp =3D <210>;
> > > +        };
> > > +    };
> > > +...
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 658895c3b0fa..e55236f4accb 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -1731,6 +1731,16 @@ W:	https://ez.analog.com/linux-software-drivers
> > >  F:	Documentation/devicetree/bindings/iio/adc/adi,ad7780.yaml
> > >  F:	drivers/iio/adc/ad7780.c
> > > =20
> > > +ANALOG DEVICES INC AD7793 DRIVER
> > > +M:	Michael Hennerich <Michael.Hennerich@analog.com>
> > > +M:	Nuno S=E1 <nuno.sa@analog.com>
> > > +L:	linux-iio@vger.kernel.org
> > > +S:	Supported
> > > +W:	https://ez.analog.com/linux-software-drivers
> > > +F:	Documentation/devicetree/bindings/iio/adc/adi,ad7793.yaml
> > > +F:	drivers/iio/adc/ad7793.c
> > > +F:	include/linux/platform_data/ad7793.h
> > > +
> > >  ANALOG DEVICES INC AD8366 DRIVER
> > >  M:	Michael Hennerich <Michael.Hennerich@analog.com>
> > >  M:	Rodrigo Alencar <rodrigo.alencar@analog.com>
> > >=20
> > > --=20
> > > 2.56.0
> > >=20
>=20
>=20

--oFj9t82+62QbHXlO
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCawh5iAAKCRB4tDGHoIJi
0pHkAQDAmJq5sxmrznUrxSZ46t+DebxK/67x3NcvILoWOigYOwEA/8Gk8x0ShH3s
fwu0VuzVcWvoFpooBh6Jl3sySkHuWg8=
=6VgK
-----END PGP SIGNATURE-----

--oFj9t82+62QbHXlO--
