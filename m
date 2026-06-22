Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A4628B4FD;
	Mon, 22 Jun 2026 16:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782145459; cv=none; b=ske9TnD/tA1kA3xICIwadtzspSO6g58rIYGB/hWOLwDSSDoSzHGYEkEcKIvgxy+rhLk+yvYoLw+f4Y71eaSAOZo13NtlOE7Q/tyJn4d/LOqZLTX4JiDmG6u2iChn9N6oAHWZP4tOadkpPraFqEhUQESXWjjeHPjPdn/tjd1C7nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782145459; c=relaxed/simple;
	bh=KFaMx0LT2W3FZgszURcUC2c4hhv2YhJ73rkYGY4ZpE8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WPCyZkMuDenlit4tOtz5OaDTIvACzQCMBRVPONB6uv0qXZfajIblH8oyy4ir3GdFs/NqdhE2i4Ft5sQQpJVQmF+xh+FaV8EWzZrLOP2ycic09LX1hanT4IsVJWeOPmqIdlMxSBkLOGU3QWBxTi2c0qFCQdBYzitnVsdx5juC6GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SpIkI4Cz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SpIkI4Cz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B3B91F000E9;
	Mon, 22 Jun 2026 16:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782145457;
	bh=Pmj17tBD8VFgL/Dnywo94VWwBhE7ccltJKfH5b3/B2E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SpIkI4Cze12aaKT4t89IPl1OLcZpZiL8g7Jmz3fO+7otSPjStLJyzN1fDiomfRWzQ
	 TE5Fj3Hfa4mv+683/YTjOQuoTjZxAsE2/dXsOwpO89qFZU7eS18SNCoP5XZG96Kp52
	 TF3wsqpec71JmEGZ2WbXnnxPub8RrVJ1jl2wd3bjqwxxOJCI4ZniyE9ojh33pSbeZA
	 SQ0MLSns+ZhI6ZRz7kTD19+QivM002w17iArhq2VB5LnvwCDXQQLp/5K1OzwzWvtVh
	 p4lU5/1jOzc9zuAbSkHmoo3XOkjtr4pEfN1bg/x1R8hALjFmgPMyGMIZP5fokZ6NUX
	 yyO8rAG+g9Ycg==
Date: Mon, 22 Jun 2026 17:24:06 +0100
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
Message-ID: <20260622172406.08524ad6@jic23-huawei>
In-Reply-To: <ajkILRPq_g24g4dH@nsa>
References: <076d7d2d-81a0-49c2-af94-bd65ead66c09@gmail.com>
	<20260619-obstinate-polo-a230bef97fda@spud>
	<20260619-bunch-diocese-dd7805cc17ff@spud>
	<ajU73_TkKrSbqD4f@nsa>
	<20260619-concierge-doozy-9c161533c369@spud>
	<ajVlD-j0nIGrRVow@nsa>
	<20260621153330.79b6600c@jic23-huawei>
	<20260621-nutmeg-coauthor-715189372230@spud>
	<ajj6nEb4tATM3C7b@nsa>
	<20260622102722.5900592f@jic23-huawei>
	<ajkILRPq_g24g4dH@nsa>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 22 Jun 2026 11:17:56 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Mon, Jun 22, 2026 at 10:27:22AM +0100, Jonathan Cameron wrote:
> > On Mon, 22 Jun 2026 10:07:01 +0100
> > Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
> >  =20
> > > On Sun, Jun 21, 2026 at 07:35:42PM +0100, Conor Dooley wrote: =20
> > > > On Sun, Jun 21, 2026 at 03:33:40PM +0100, Jonathan Cameron wrote:  =
 =20
> > > > > On Fri, 19 Jun 2026 16:54:11 +0100
> > > > > Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
> > > > >    =20
> > > > > > On Fri, Jun 19, 2026 at 03:12:07PM +0100, Conor Dooley wrote:  =
 =20
> > > > > > > On Fri, Jun 19, 2026 at 02:01:08PM +0100, Nuno S=C3=A1 wrote:=
     =20
> > > > > > > > On Fri, Jun 19, 2026 at 12:40:54PM +0100, Conor Dooley wrot=
e:     =20
> > > > > > > > > On Fri, Jun 19, 2026 at 12:36:55PM +0100, Conor Dooley wr=
ote:     =20
> > > > > > > > > > On Fri, Jun 19, 2026 at 12:33:11PM +0200, Janani Sunil =
wrote:     =20
> > > > > > > > > > >=20
> > > > > > > > > > > On 6/14/26 21:44, Jonathan Cameron wrote:     =20
> > > > > > > > > > > > On Tue, 9 Jun 2026 16:47:23 +0200
> > > > > > > > > > > > Janani Sunil <jan.sun97@gmail.com> wrote:
> > > > > > > > > > > >      =20
> > > > > > > > > > > > > On 5/26/26 15:11, Rodrigo Alencar wrote:     =20
> > > > > > > > > > > > > > On 26/05/19 05:42PM, Janani Sunil wrote:     =20
> > > > > > > > > > > > > > > Devicetree bindings for AD5529R 16 channel 12=
/16 bit high voltage,
> > > > > > > > > > > > > > > buffered voltage output digital-to-analog con=
verter (DAC) with an
> > > > > > > > > > > > > > > integrated precision reference.     =20
> > > > > > > > > > > > > > ...
> > > > > > > > > > > > > > Probably others may comment on that, but...
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > This parent node may support device addressing =
for multi-device support through
> > > > > > > > > > > > > > those ID pins. I suppose that each device may h=
ave its own power supplies or
> > > > > > > > > > > > > > other resources like the toggle pins or reset a=
nd enable.
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > That way I suppose that an example would look l=
ike...     =20
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +patternProperties:
> > > > > > > > > > > > > > > +  "^channel@([0-9]|1[0-5])$":
> > > > > > > > > > > > > > > +    type: object
> > > > > > > > > > > > > > > +    description: Child nodes for individual =
channel configuration
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +    properties:
> > > > > > > > > > > > > > > +      reg:
> > > > > > > > > > > > > > > +        description: Channel number.
> > > > > > > > > > > > > > > +        minimum: 0
> > > > > > > > > > > > > > > +        maximum: 15
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +      adi,output-range-microvolt:
> > > > > > > > > > > > > > > +        description: |
> > > > > > > > > > > > > > > +          Output voltage range for this chan=
nel as [min, max] in microvolts.
> > > > > > > > > > > > > > > +          If not specified, defaults to 0V t=
o 5V range.
> > > > > > > > > > > > > > > +        oneOf:
> > > > > > > > > > > > > > > +          - items:
> > > > > > > > > > > > > > > +              - const: 0
> > > > > > > > > > > > > > > +              - enum: [5000000, 10000000, 20=
000000, 40000000]
> > > > > > > > > > > > > > > +          - items:
> > > > > > > > > > > > > > > +              - const: -5000000
> > > > > > > > > > > > > > > +              - const: 5000000
> > > > > > > > > > > > > > > +          - items:
> > > > > > > > > > > > > > > +              - const: -10000000
> > > > > > > > > > > > > > > +              - const: 10000000
> > > > > > > > > > > > > > > +          - items:
> > > > > > > > > > > > > > > +              - const: -15000000
> > > > > > > > > > > > > > > +              - const: 15000000
> > > > > > > > > > > > > > > +          - items:
> > > > > > > > > > > > > > > +              - const: -20000000
> > > > > > > > > > > > > > > +              - const: 20000000
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +    required:
> > > > > > > > > > > > > > > +      - reg
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +    additionalProperties: false
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +required:
> > > > > > > > > > > > > > > +  - compatible
> > > > > > > > > > > > > > > +  - reg
> > > > > > > > > > > > > > > +  - vdd-supply
> > > > > > > > > > > > > > > +  - avdd-supply
> > > > > > > > > > > > > > > +  - hvdd-supply
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +dependencies:
> > > > > > > > > > > > > > > +  spi-cpha: [ spi-cpol ]
> > > > > > > > > > > > > > > +  spi-cpol: [ spi-cpha ]
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +allOf:
> > > > > > > > > > > > > > > +  - $ref: /schemas/spi/spi-peripheral-props.=
yaml#
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +unevaluatedProperties: false
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +examples:
> > > > > > > > > > > > > > > +  - |
> > > > > > > > > > > > > > > +    #include <dt-bindings/gpio/gpio.h>
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +    spi {
> > > > > > > > > > > > > > > +        #address-cells =3D <1>;
> > > > > > > > > > > > > > > +        #size-cells =3D <0>;
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +        dac@0 {
> > > > > > > > > > > > > > > +            compatible =3D "adi,ad5529r-16";
> > > > > > > > > > > > > > > +            reg =3D <0>;
> > > > > > > > > > > > > > > +            spi-max-frequency =3D <25000000>;
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +            vdd-supply =3D <&vdd_regulator>;
> > > > > > > > > > > > > > > +            avdd-supply =3D <&avdd_regulator=
>;
> > > > > > > > > > > > > > > +            hvdd-supply =3D <&hvdd_regulator=
>;
> > > > > > > > > > > > > > > +            hvss-supply =3D <&hvss_regulator=
>;
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +            reset-gpios =3D <&gpio0 87 GPIO_=
ACTIVE_LOW>;
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +            #address-cells =3D <1>;
> > > > > > > > > > > > > > > +            #size-cells =3D <0>;
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +            channel@0 {
> > > > > > > > > > > > > > > +                reg =3D <0>;
> > > > > > > > > > > > > > > +                adi,output-range-microvolt =
=3D <0 5000000>;
> > > > > > > > > > > > > > > +            };
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +            channel@1 {
> > > > > > > > > > > > > > > +                reg =3D <1>;
> > > > > > > > > > > > > > > +                adi,output-range-microvolt =
=3D <(-10000000) 10000000>;
> > > > > > > > > > > > > > > +            };
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +            channel@2 {
> > > > > > > > > > > > > > > +                reg =3D <2>;
> > > > > > > > > > > > > > > +                adi,output-range-microvolt =
=3D <0 40000000>;
> > > > > > > > > > > > > > > +            };
> > > > > > > > > > > > > > > +        };
> > > > > > > > > > > > > > > +    };     =20
> > > > > > > > > > > > > > ...
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > 	spi {
> > > > > > > > > > > > > > 		#address-cells =3D <1>;
> > > > > > > > > > > > > > 		#size-cells =3D <0>;
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > 		multi-dac@0 {
> > > > > > > > > > > > > > 			compatible =3D "adi,ad5529r-16";
> > > > > > > > > > > > > > 			reg =3D <0>;
> > > > > > > > > > > > > > 			spi-max-frequency =3D <25000000>;
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > 			#address-cells =3D <1>;
> > > > > > > > > > > > > > 			#size-cells =3D <0>;
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > 			dac@0 {
> > > > > > > > > > > > > > 				reg =3D <0>;
> > > > > > > > > > > > > > 				vdd-supply =3D <&vdd_regulator>;
> > > > > > > > > > > > > > 				avdd-supply =3D <&avdd_regulator>;
> > > > > > > > > > > > > > 				hvdd-supply =3D <&hvdd_regulator>;
> > > > > > > > > > > > > > 				hvss-supply =3D <&hvss_regulator>;
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > 				reset-gpios =3D <&gpio0 87 GPIO_ACTIVE_LOW>;
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > 				#address-cells =3D <1>;
> > > > > > > > > > > > > > 				#size-cells =3D <0>;
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > 				channel@0 {
> > > > > > > > > > > > > > 					reg =3D <0>;
> > > > > > > > > > > > > > 					adi,output-range-microvolt =3D <0 5000000>;
> > > > > > > > > > > > > > 				};
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > 				channel@1 {
> > > > > > > > > > > > > > 					reg =3D <1>;
> > > > > > > > > > > > > > 					adi,output-range-microvolt =3D <(-10000000=
) 10000000>;
> > > > > > > > > > > > > > 				};
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > 				channel@2 {
> > > > > > > > > > > > > > 					reg =3D <2>;
> > > > > > > > > > > > > > 					adi,output-range-microvolt =3D <0 40000000=
>;
> > > > > > > > > > > > > > 				};
> > > > > > > > > > > > > > 			}
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > 			dac@1 {
> > > > > > > > > > > > > > 				reg =3D <1>;
> > > > > > > > > > > > > > 				vdd-supply =3D <&vdd_regulator>;
> > > > > > > > > > > > > > 				avdd-supply =3D <&avdd_regulator>;
> > > > > > > > > > > > > > 				hvdd-supply =3D <&hvdd_regulator>;
> > > > > > > > > > > > > > 				hvss-supply =3D <&hvss_regulator>;
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > 				reset-gpios =3D <&gpio0 88 GPIO_ACTIVE_LOW>;
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > 				#address-cells =3D <1>;
> > > > > > > > > > > > > > 				#size-cells =3D <0>;
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > 				channel@0 {
> > > > > > > > > > > > > > 					reg =3D <0>;
> > > > > > > > > > > > > > 					adi,output-range-microvolt =3D <0 5000000>;
> > > > > > > > > > > > > > 				};
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > 				channel@1 {
> > > > > > > > > > > > > > 					reg =3D <1>;
> > > > > > > > > > > > > > 					adi,output-range-microvolt =3D <(-10000000=
) 10000000>;
> > > > > > > > > > > > > > 				};
> > > > > > > > > > > > > > 			}
> > > > > > > > > > > > > > 		};
> > > > > > > > > > > > > > 	};
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > then you might need something like:
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > 	patternProperties:
> > > > > > > > > > > > > > 		"^dac@[0-3]$":
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > and put most of the things under this node patt=
ern.
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > So the main driver that you're putting together=
 might need to handle up to four instances.
> > > > > > > > > > > > > > Even if your current driver cannot handle this,=
 the dt-bindings might need cover that.
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > Need to double check if each dac node needs a s=
eparate compatible, so you would maybe populate
> > > > > > > > > > > > > > a platform data to be shared with the child nod=
es, which would be a separate driver.
> > > > > > > > > > > > > > (not sure if it would make sense to mix and mat=
ch ad5529r-16 and ad5529r-12).     =20
> > > > > > > > > > > > > Hi Rodrigo,
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > Thank you for looking at this.
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > For now, I would prefer to keep the binding scope=
d to a single AD5529R device instance. The current
> > > > > > > > > > > > > hardware/use case we have only needs one device n=
ode and the driver is written around that model as well.
> > > > > > > > > > > > > While the device addressing pins could allow mult=
i-device topology, we do not have an actual platform using
> > > > > > > > > > > > > that configuration at the moment, so I would pref=
er not to introduce an extra parent/child binding structure
> > > > > > > > > > > > > speculatively without a validating use case.     =
=20
> > > > > > > > > > > > Interesting feature - kind of similar to address co=
ntrol on a typical i2c bus device, or
> > > > > > > > > > > > looking at it another way a kind of distributed SPI=
 mux.
> > > > > > > > > > > >=20
> > > > > > > > > > > > Challenge of a binding is we need to anticipate the=
 future.  So I think we do need something
> > > > > > > > > > > > like Rodrigo is suggesting even if we only (for now=
) support a single instance in the driver.
> > > > > > > > > > > > That would leave the path open to supporting the ad=
dressing at a later date.
> > > > > > > > > > > > An alternative might be to look at it like a chaine=
d device setup. In those we pretend there
> > > > > > > > > > > > is just one device with a lot of channels etc.  The=
 snag is that here things are more loosely
> > > > > > > > > > > > coupled whereas for those devices it tends to be yo=
u have to read / write the same register
> > > > > > > > > > > > in all devices in the chain as one big SPI message.
> > > > > > > > > > > >=20
> > > > > > > > > > > > +CC Mark Brown as he may know of some precedence fo=
r this feature. For his reference..
> > > > > > > > > > > > - Each of these device has 2 ID pins.  The SPI tran=
sfers have to contain the 2 bit
> > > > > > > > > > > > value that matches that or they are ignored.  Thus =
a single bus + 1 chip select can
> > > > > > > > > > > > be used to talk to 4 devices.  Question is what tha=
t looks like in device tree + I guess
> > > > > > > > > > > > longer term how to support it cleanly in SPI.     =
=20
> > > > > > > > > >=20
> > > > > > > > > > I'd swear I have seen this before, from some Microchip =
devices. Let me
> > > > > > > > > > see if I can find what I am thinking of...     =20
> > > > > > > > >=20
> > > > > > > > >=20
> > > > > > > > > microchip,mcp3911 and microchip,mcp3564 both seem to do t=
his with
> > > > > > > > > slightly different properties.
> > > > > > > > >=20
> > > > > > > > >   microchip,device-addr:
> > > > > > > > >     description: Device address when multiple MCP3911 chi=
ps are present on the same SPI bus.
> > > > > > > > >     $ref: /schemas/types.yaml#/definitions/uint32
> > > > > > > > >     enum: [0, 1, 2, 3]
> > > > > > > > >     default: 0
> > > > > > > > >=20
> > > > > > > > > and
> > > > > > > > >=20
> > > > > > > > >=20
> > > > > > > > >   microchip,hw-device-address:
> > > > > > > > >     $ref: /schemas/types.yaml#/definitions/uint32
> > > > > > > > >     minimum: 0
> > > > > > > > >     maximum: 3
> > > > > > > > >     description:
> > > > > > > > >       The address is set on a per-device basis by fuses i=
n the factory,
> > > > > > > > >       configured on request. If not requested, the fuses =
are set for 0x1.
> > > > > > > > >       The device address is part of the device markings t=
o avoid
> > > > > > > > >       potential confusion. This address is coded on two b=
its, so four possible
> > > > > > > > >       addresses are available when multiple devices are p=
resent on the same
> > > > > > > > >       SPI bus with only one Chip Select line for all devi=
ces.
> > > > > > > > >       Each device communication starts by a CS falling ed=
ge, followed by the
> > > > > > > > >       clocking of the device address (BITS[7:6] - top two=
 bits of COMMAND BYTE
> > > > > > > > >       which is first one on the wire).
> > > > > > > > >=20
> > > > > > > > > This sounds exactly like the sort of feature that you're =
dealing with
> > > > > > > > > here?
> > > > > > > > >      =20
> > > > > > > >=20
> > > > > > > > The core idea yes but for this chip, things are a bit more =
annoying (but
> > > > > > > > Janani can correct me if I'm wrong). Here, each device can,=
 in theory,
> > > > > > > > have it's own supplies, pins and at the very least, channel=
s with maybe
> > > > > > > > different scales. That is why Janani is proposing dac nodes=
. Given I
> > > > > > > > honestly don't like much of that "adi,ad5529r-bus" compatib=
le I wondered
> > > > > > > > about solving this at the spi level.
> > > > > > > >=20
> > > > > > > > Ah and to make it more annoying, we can also mix 12 and 16 =
bits variants
> > > > > > > > together in the same bus.     =20
> > > > > > >=20
> > > > > > > I'm definitely missing something, because that property for t=
he
> > > > > > > microchip devices is not impacted what else is on the bus. AF=
AICT, you
> > > > > > > could have an mcp3911 and an mcp3564 on the same bus even tho=
ugh both
> > > > > > > are completely different devices with different drivers. They=
 have
> > > > > > > individual device nodes and their own supplies etc etc. These=
 aren't
> > > > > > > per-channel properties on an adc or dac, they're per child de=
vice on a
> > > > > > > spi bus.     =20
> > > > > >=20
> > > > > > Maybe I'm the one missing something :). IIRC, spi would not all=
ow two
> > > > > > devices on the same CS right? Because for this chip we would ne=
ed
> > > > > > something like:
> > > > > >=20
> > > > > > spi {
> > > > > > 	dac@0 {
> > > > > > 		reg =3D <0>;
> > > > > > 		adi,pin-id =3D <0>;
> > > > > > 	};
> > > > > >=20
> > > > > > 	dac@1 {
> > > > > > 		reg =3D <0>; // which seems already problematic?
> > > > > > 		adi,pin-id <1>;
> > > > > > 	};
> > > > > >=20
> > > > > > 	...
> > > > > >=20
> > > > > > 	//up to 4
> > > > > > };   =20
> > > > > Yeah. It's not clear to me how that works for the microchip devic=
es
> > > > > (I suspect it doesn't!)
> > > > >=20
> > > > > Just thinking as I type, but could we do something a bit nasty wi=
th
> > > > > a gpio mux that doesn't actually switch but represents the GPIO b=
eing
> > > > > shared?  Given this is all tied to the spi bus that should all ha=
ppen
> > > > > under serializing locks.=20
> > > > >=20
> > > > > Agreed though that this would be nicer as an SPI thing that let
> > > > > us specify that a single CS is share by multiple devices and their
> > > > > is some other signal acting to select which one we are talking to=
.   =20
> > > >=20
> > > > Whether it works or not, I think it is the more correct approach. M=
essing
> > > > with gpio muxes seems completely wrong, given the chip select may n=
ot be
> > > > a gpio at all.
> > > >=20
> > > > Why do you think the microchip devices won't work? Does the spi core
> > > > reject multiple devices with the same chip select being registered =
or
> > > > something like that?   =20
> > >=20
> > > Not sure how things work atm. But I'm fairly sure it used to be like
> > > that. SPI would reject devices on the same controller and CS. Now that
> > > we support more than one CS per controller, not sure how things work.=
  =20
> > We always supported more than one per CS per controller. I guess you me=
an
> > per device. =20
>=20
> Obviously :)
> >  =20
> > >=20
> > > Janani, maybe you can give it a try? =20
> >=20
> > I think we'd need to get it to work with shared gpio proxy which maybe
> > will just get set up under the hood.  This used to be opt in, but seems
> > that changed fairly recently so maybe some of us are working with out
> > of date knowledge!  I haven't played with it yet, so might not be
> > that simple.
> >  =20
>=20
> What I meant for Janani was basically testing two devices on the same CS
> as in my pseudo DT. For the GPIO, you mean having a way to select
> between devices on the same CS?

Nope. It is what you suggest - the implementation in the gpio layer
is to detect the reuse of the same GPIO and insert a proxy layer that
allows multiple consumers.  I think that will provide different gpio
numbers (well descs really) to each of them but I haven't checked the detai=
ls
that closely.

>=20
> For these devices the pin id numbers get's setted up as part of the spi m=
essage
> so my assumption is that all of them will receive the message but only on=
e acks it.

Yup. As much as we have an ack on SPI.  So with a write only message you'd =
never
know if anyone got it.

Jonathan


>=20
> - Nuno S=C3=A1
>=20
> > Jonathan
> >  =20
> > >=20
> > > - Nuno S=C3=A1
> > >  =20
> >  =20
>=20

