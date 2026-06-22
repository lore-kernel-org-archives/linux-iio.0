Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7A52FFF8B;
	Mon, 22 Jun 2026 16:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782145765; cv=none; b=kT4ZXejv8nCb+hyD7Xuzu5fDnKBeMWokCkWW3bHdVVL9ZSgLVmvceyKjDSw3ZkLfn9HWe/XvIsLiQSs/M8Fqu7JubWd15Z8LdPnf8S9xiKjl51aluXHKRPEgG3z6QWN5gWuYADYcvn5ZJV2z4Ln35GlWBFJN+AggjtMxawMOlQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782145765; c=relaxed/simple;
	bh=2usxyPDX5Nj8Q8dd1mg36tIS1Ywl0dNJ077vN1x7R1M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BX5RzvfpaTiAVW1QOtyMHpdiFM7vav2nZf8Xy9V5MQ0aBbgJc7VbwcoQsn4GeR4EB53iuEB7r6paP9hpInY5EXNk8q1dHk85QDauDp+FhSVvZHBTtPoeNjfVm5jFoXEvKaG3A1xhHZc749u89BGZO6uQtBnMW1zmKSOBOuOvNBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XSRkRuIw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XSRkRuIw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DF8F1F000E9;
	Mon, 22 Jun 2026 16:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782145763;
	bh=wp/FLEbUv6C7JyNRN5yW3vzzzuPb1yXuM80U5wHHwvc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=XSRkRuIwgV1cJETzBchYE+DfmvbIv8dxefNPPbEMKclEXETx1TTXoW5xzATg/NDwE
	 jAfULZ5NP71YFtUGT0tCQ8cIGA2a/5GA+octUQlxZzFvnUqb5XSQk85S5gKYUUr8uT
	 emFGiF7V/ymW2KfMdeUZ4M2D8lq+KB8dP7qxElZpc/fDIcg5oD+04XAc3Qjc166rwz
	 CXbv6/T+YN16aTaTS2zHOUQ2WMrty/+8foU41ig1qcmQyHUN38nHtWnxivYYbbTMAo
	 ZDyyXNS2+UuWf5HSZW9pnNzF8jbqkIhHiZTRwqjA+er/iESg9fzvMhw7DY6gp18oKA
	 tA10cTtXOcyxA==
Date: Mon, 22 Jun 2026 17:29:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>, Conor Dooley
 <conor@kernel.org>, Janani Sunil <jan.sun97@gmail.com>, Janani Sunil
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
Message-ID: <20260622172911.48259a0c@jic23-huawei>
In-Reply-To: <ajkMBh-R_7pYaoAn@nsa>
References: <603473ac-30e6-45e5-8a3b-c9902715cc9e@gmail.com>
	<20260614204455.408c4d40@jic23-huawei>
	<076d7d2d-81a0-49c2-af94-bd65ead66c09@gmail.com>
	<20260619-obstinate-polo-a230bef97fda@spud>
	<20260619-bunch-diocese-dd7805cc17ff@spud>
	<ajU73_TkKrSbqD4f@nsa>
	<20260619-concierge-doozy-9c161533c369@spud>
	<ajVlD-j0nIGrRVow@nsa>
	<20260621153330.79b6600c@jic23-huawei>
	<5u4dnsgxwcwie45f24cacyzf3dko4srhyyyhcpom6tsvhqtmpc@y7d7gmex6n7k>
	<ajkMBh-R_7pYaoAn@nsa>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 22 Jun 2026 11:29:38 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Mon, Jun 22, 2026 at 10:24:05AM +0100, Rodrigo Alencar wrote:
> > On 21/06/26 15:33, Jonathan Cameron wrote: =20
> > > On Fri, 19 Jun 2026 16:54:11 +0100
> > > Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
> > >  =20
> > > > On Fri, Jun 19, 2026 at 03:12:07PM +0100, Conor Dooley wrote: =20
> > > > > On Fri, Jun 19, 2026 at 02:01:08PM +0100, Nuno S=C3=A1 wrote:   =
=20
> > > > > > On Fri, Jun 19, 2026 at 12:40:54PM +0100, Conor Dooley wrote:  =
 =20
> > > > > > > On Fri, Jun 19, 2026 at 12:36:55PM +0100, Conor Dooley wrote:=
   =20
> > > > > > > > On Fri, Jun 19, 2026 at 12:33:11PM +0200, Janani Sunil wrot=
e:   =20
> > > > > > > > >=20
> > > > > > > > > On 6/14/26 21:44, Jonathan Cameron wrote:   =20
> > > > > > > > > > On Tue, 9 Jun 2026 16:47:23 +0200
> > > > > > > > > > Janani Sunil <jan.sun97@gmail.com> wrote:
> > > > > > > > > >    =20
> > > > > > > > > > > On 5/26/26 15:11, Rodrigo Alencar wrote:   =20
> > > > > > > > > > > > On 26/05/19 05:42PM, Janani Sunil wrote:   =20
> > > > > > > > > > > > > Devicetree bindings for AD5529R 16 channel 12/16 =
bit high voltage,
> > > > > > > > > > > > > buffered voltage output digital-to-analog convert=
er (DAC) with an
> > > > > > > > > > > > > integrated precision reference.   =20
> > > > > > > > > > > > ...
> > > > > > > > > > > > Probably others may comment on that, but...
> > > > > > > > > > > >=20
> > > > > > > > > > > > This parent node may support device addressing for =
multi-device support through
> > > > > > > > > > > > those ID pins. I suppose that each device may have =
its own power supplies or
> > > > > > > > > > > > other resources like the toggle pins or reset and e=
nable.
> > > > > > > > > > > >=20
> > > > > > > > > > > > That way I suppose that an example would look like.=
..   =20
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +patternProperties:
> > > > > > > > > > > > > +  "^channel@([0-9]|1[0-5])$":
> > > > > > > > > > > > > +    type: object
> > > > > > > > > > > > > +    description: Child nodes for individual chan=
nel configuration
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +    properties:
> > > > > > > > > > > > > +      reg:
> > > > > > > > > > > > > +        description: Channel number.
> > > > > > > > > > > > > +        minimum: 0
> > > > > > > > > > > > > +        maximum: 15
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +      adi,output-range-microvolt:
> > > > > > > > > > > > > +        description: |
> > > > > > > > > > > > > +          Output voltage range for this channel =
as [min, max] in microvolts.
> > > > > > > > > > > > > +          If not specified, defaults to 0V to 5V=
 range.
> > > > > > > > > > > > > +        oneOf:
> > > > > > > > > > > > > +          - items:
> > > > > > > > > > > > > +              - const: 0
> > > > > > > > > > > > > +              - enum: [5000000, 10000000, 200000=
00, 40000000]
> > > > > > > > > > > > > +          - items:
> > > > > > > > > > > > > +              - const: -5000000
> > > > > > > > > > > > > +              - const: 5000000
> > > > > > > > > > > > > +          - items:
> > > > > > > > > > > > > +              - const: -10000000
> > > > > > > > > > > > > +              - const: 10000000
> > > > > > > > > > > > > +          - items:
> > > > > > > > > > > > > +              - const: -15000000
> > > > > > > > > > > > > +              - const: 15000000
> > > > > > > > > > > > > +          - items:
> > > > > > > > > > > > > +              - const: -20000000
> > > > > > > > > > > > > +              - const: 20000000
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +    required:
> > > > > > > > > > > > > +      - reg
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +    additionalProperties: false
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +required:
> > > > > > > > > > > > > +  - compatible
> > > > > > > > > > > > > +  - reg
> > > > > > > > > > > > > +  - vdd-supply
> > > > > > > > > > > > > +  - avdd-supply
> > > > > > > > > > > > > +  - hvdd-supply
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +dependencies:
> > > > > > > > > > > > > +  spi-cpha: [ spi-cpol ]
> > > > > > > > > > > > > +  spi-cpol: [ spi-cpha ]
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +allOf:
> > > > > > > > > > > > > +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +unevaluatedProperties: false
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +examples:
> > > > > > > > > > > > > +  - |
> > > > > > > > > > > > > +    #include <dt-bindings/gpio/gpio.h>
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +    spi {
> > > > > > > > > > > > > +        #address-cells =3D <1>;
> > > > > > > > > > > > > +        #size-cells =3D <0>;
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +        dac@0 {
> > > > > > > > > > > > > +            compatible =3D "adi,ad5529r-16";
> > > > > > > > > > > > > +            reg =3D <0>;
> > > > > > > > > > > > > +            spi-max-frequency =3D <25000000>;
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +            vdd-supply =3D <&vdd_regulator>;
> > > > > > > > > > > > > +            avdd-supply =3D <&avdd_regulator>;
> > > > > > > > > > > > > +            hvdd-supply =3D <&hvdd_regulator>;
> > > > > > > > > > > > > +            hvss-supply =3D <&hvss_regulator>;
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +            reset-gpios =3D <&gpio0 87 GPIO_ACTI=
VE_LOW>;
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +            #address-cells =3D <1>;
> > > > > > > > > > > > > +            #size-cells =3D <0>;
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +            channel@0 {
> > > > > > > > > > > > > +                reg =3D <0>;
> > > > > > > > > > > > > +                adi,output-range-microvolt =3D <=
0 5000000>;
> > > > > > > > > > > > > +            };
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +            channel@1 {
> > > > > > > > > > > > > +                reg =3D <1>;
> > > > > > > > > > > > > +                adi,output-range-microvolt =3D <=
(-10000000) 10000000>;
> > > > > > > > > > > > > +            };
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +            channel@2 {
> > > > > > > > > > > > > +                reg =3D <2>;
> > > > > > > > > > > > > +                adi,output-range-microvolt =3D <=
0 40000000>;
> > > > > > > > > > > > > +            };
> > > > > > > > > > > > > +        };
> > > > > > > > > > > > > +    };   =20
> > > > > > > > > > > > ...
> > > > > > > > > > > >=20
> > > > > > > > > > > > 	spi {
> > > > > > > > > > > > 		#address-cells =3D <1>;
> > > > > > > > > > > > 		#size-cells =3D <0>;
> > > > > > > > > > > >=20
> > > > > > > > > > > > 		multi-dac@0 {
> > > > > > > > > > > > 			compatible =3D "adi,ad5529r-16";
> > > > > > > > > > > > 			reg =3D <0>;
> > > > > > > > > > > > 			spi-max-frequency =3D <25000000>;
> > > > > > > > > > > >=20
> > > > > > > > > > > > 			#address-cells =3D <1>;
> > > > > > > > > > > > 			#size-cells =3D <0>;
> > > > > > > > > > > >=20
> > > > > > > > > > > > 			dac@0 {
> > > > > > > > > > > > 				reg =3D <0>;
> > > > > > > > > > > > 				vdd-supply =3D <&vdd_regulator>;
> > > > > > > > > > > > 				avdd-supply =3D <&avdd_regulator>;
> > > > > > > > > > > > 				hvdd-supply =3D <&hvdd_regulator>;
> > > > > > > > > > > > 				hvss-supply =3D <&hvss_regulator>;
> > > > > > > > > > > >=20
> > > > > > > > > > > > 				reset-gpios =3D <&gpio0 87 GPIO_ACTIVE_LOW>;
> > > > > > > > > > > >=20
> > > > > > > > > > > > 				#address-cells =3D <1>;
> > > > > > > > > > > > 				#size-cells =3D <0>;
> > > > > > > > > > > >=20
> > > > > > > > > > > > 				channel@0 {
> > > > > > > > > > > > 					reg =3D <0>;
> > > > > > > > > > > > 					adi,output-range-microvolt =3D <0 5000000>;
> > > > > > > > > > > > 				};
> > > > > > > > > > > >=20
> > > > > > > > > > > > 				channel@1 {
> > > > > > > > > > > > 					reg =3D <1>;
> > > > > > > > > > > > 					adi,output-range-microvolt =3D <(-10000000) 10=
000000>;
> > > > > > > > > > > > 				};
> > > > > > > > > > > >=20
> > > > > > > > > > > > 				channel@2 {
> > > > > > > > > > > > 					reg =3D <2>;
> > > > > > > > > > > > 					adi,output-range-microvolt =3D <0 40000000>;
> > > > > > > > > > > > 				};
> > > > > > > > > > > > 			}
> > > > > > > > > > > >=20
> > > > > > > > > > > > 			dac@1 {
> > > > > > > > > > > > 				reg =3D <1>;
> > > > > > > > > > > > 				vdd-supply =3D <&vdd_regulator>;
> > > > > > > > > > > > 				avdd-supply =3D <&avdd_regulator>;
> > > > > > > > > > > > 				hvdd-supply =3D <&hvdd_regulator>;
> > > > > > > > > > > > 				hvss-supply =3D <&hvss_regulator>;
> > > > > > > > > > > >=20
> > > > > > > > > > > > 				reset-gpios =3D <&gpio0 88 GPIO_ACTIVE_LOW>;
> > > > > > > > > > > >=20
> > > > > > > > > > > > 				#address-cells =3D <1>;
> > > > > > > > > > > > 				#size-cells =3D <0>;
> > > > > > > > > > > >=20
> > > > > > > > > > > > 				channel@0 {
> > > > > > > > > > > > 					reg =3D <0>;
> > > > > > > > > > > > 					adi,output-range-microvolt =3D <0 5000000>;
> > > > > > > > > > > > 				};
> > > > > > > > > > > >=20
> > > > > > > > > > > > 				channel@1 {
> > > > > > > > > > > > 					reg =3D <1>;
> > > > > > > > > > > > 					adi,output-range-microvolt =3D <(-10000000) 10=
000000>;
> > > > > > > > > > > > 				};
> > > > > > > > > > > > 			}
> > > > > > > > > > > > 		};
> > > > > > > > > > > > 	};
> > > > > > > > > > > >=20
> > > > > > > > > > > > then you might need something like:
> > > > > > > > > > > >=20
> > > > > > > > > > > > 	patternProperties:
> > > > > > > > > > > > 		"^dac@[0-3]$":
> > > > > > > > > > > >=20
> > > > > > > > > > > > and put most of the things under this node pattern.
> > > > > > > > > > > >=20
> > > > > > > > > > > > So the main driver that you're putting together mig=
ht need to handle up to four instances.
> > > > > > > > > > > > Even if your current driver cannot handle this, the=
 dt-bindings might need cover that.
> > > > > > > > > > > >=20
> > > > > > > > > > > > Need to double check if each dac node needs a separ=
ate compatible, so you would maybe populate
> > > > > > > > > > > > a platform data to be shared with the child nodes, =
which would be a separate driver.
> > > > > > > > > > > > (not sure if it would make sense to mix and match a=
d5529r-16 and ad5529r-12).   =20
> > > > > > > > > > > Hi Rodrigo,
> > > > > > > > > > >=20
> > > > > > > > > > > Thank you for looking at this.
> > > > > > > > > > >=20
> > > > > > > > > > > For now, I would prefer to keep the binding scoped to=
 a single AD5529R device instance. The current
> > > > > > > > > > > hardware/use case we have only needs one device node =
and the driver is written around that model as well.
> > > > > > > > > > > While the device addressing pins could allow multi-de=
vice topology, we do not have an actual platform using
> > > > > > > > > > > that configuration at the moment, so I would prefer n=
ot to introduce an extra parent/child binding structure
> > > > > > > > > > > speculatively without a validating use case.   =20
> > > > > > > > > > Interesting feature - kind of similar to address contro=
l on a typical i2c bus device, or
> > > > > > > > > > looking at it another way a kind of distributed SPI mux.
> > > > > > > > > >=20
> > > > > > > > > > Challenge of a binding is we need to anticipate the fut=
ure.  So I think we do need something
> > > > > > > > > > like Rodrigo is suggesting even if we only (for now) su=
pport a single instance in the driver.
> > > > > > > > > > That would leave the path open to supporting the addres=
sing at a later date.
> > > > > > > > > > An alternative might be to look at it like a chained de=
vice setup. In those we pretend there
> > > > > > > > > > is just one device with a lot of channels etc.  The sna=
g is that here things are more loosely
> > > > > > > > > > coupled whereas for those devices it tends to be you ha=
ve to read / write the same register
> > > > > > > > > > in all devices in the chain as one big SPI message.
> > > > > > > > > >=20
> > > > > > > > > > +CC Mark Brown as he may know of some precedence for th=
is feature. For his reference..
> > > > > > > > > > - Each of these device has 2 ID pins.  The SPI transfer=
s have to contain the 2 bit
> > > > > > > > > > value that matches that or they are ignored.  Thus a si=
ngle bus + 1 chip select can
> > > > > > > > > > be used to talk to 4 devices.  Question is what that lo=
oks like in device tree + I guess
> > > > > > > > > > longer term how to support it cleanly in SPI.   =20
> > > > > > > >=20
> > > > > > > > I'd swear I have seen this before, from some Microchip devi=
ces. Let me
> > > > > > > > see if I can find what I am thinking of...   =20
> > > > > > >=20
> > > > > > >=20
> > > > > > > microchip,mcp3911 and microchip,mcp3564 both seem to do this =
with
> > > > > > > slightly different properties.
> > > > > > >=20
> > > > > > >   microchip,device-addr:
> > > > > > >     description: Device address when multiple MCP3911 chips a=
re present on the same SPI bus.
> > > > > > >     $ref: /schemas/types.yaml#/definitions/uint32
> > > > > > >     enum: [0, 1, 2, 3]
> > > > > > >     default: 0
> > > > > > >=20
> > > > > > > and
> > > > > > >=20
> > > > > > >=20
> > > > > > >   microchip,hw-device-address:
> > > > > > >     $ref: /schemas/types.yaml#/definitions/uint32
> > > > > > >     minimum: 0
> > > > > > >     maximum: 3
> > > > > > >     description:
> > > > > > >       The address is set on a per-device basis by fuses in th=
e factory,
> > > > > > >       configured on request. If not requested, the fuses are =
set for 0x1.
> > > > > > >       The device address is part of the device markings to av=
oid
> > > > > > >       potential confusion. This address is coded on two bits,=
 so four possible
> > > > > > >       addresses are available when multiple devices are prese=
nt on the same
> > > > > > >       SPI bus with only one Chip Select line for all devices.
> > > > > > >       Each device communication starts by a CS falling edge, =
followed by the
> > > > > > >       clocking of the device address (BITS[7:6] - top two bit=
s of COMMAND BYTE
> > > > > > >       which is first one on the wire).
> > > > > > >=20
> > > > > > > This sounds exactly like the sort of feature that you're deal=
ing with
> > > > > > > here?
> > > > > > >    =20
> > > > > >=20
> > > > > > The core idea yes but for this chip, things are a bit more anno=
ying (but
> > > > > > Janani can correct me if I'm wrong). Here, each device can, in =
theory,
> > > > > > have it's own supplies, pins and at the very least, channels wi=
th maybe
> > > > > > different scales. That is why Janani is proposing dac nodes. Gi=
ven I
> > > > > > honestly don't like much of that "adi,ad5529r-bus" compatible I=
 wondered
> > > > > > about solving this at the spi level.
> > > > > >=20
> > > > > > Ah and to make it more annoying, we can also mix 12 and 16 bits=
 variants
> > > > > > together in the same bus.   =20
> > > > >=20
> > > > > I'm definitely missing something, because that property for the
> > > > > microchip devices is not impacted what else is on the bus. AFAICT=
, you
> > > > > could have an mcp3911 and an mcp3564 on the same bus even though =
both
> > > > > are completely different devices with different drivers. They have
> > > > > individual device nodes and their own supplies etc etc. These are=
n't
> > > > > per-channel properties on an adc or dac, they're per child device=
 on a
> > > > > spi bus.   =20
> > > >=20
> > > > Maybe I'm the one missing something :). IIRC, spi would not allow t=
wo
> > > > devices on the same CS right? Because for this chip we would need
> > > > something like:
> > > >=20
> > > > spi {
> > > > 	dac@0 {
> > > > 		reg =3D <0>;
> > > > 		adi,pin-id =3D <0>;
> > > > 	};
> > > >=20
> > > > 	dac@1 {
> > > > 		reg =3D <0>; // which seems already problematic?
> > > > 		adi,pin-id <1>;
> > > > 	};
> > > >=20
> > > > 	...
> > > >=20
> > > > 	//up to 4
> > > > }; =20
> > > Yeah. It's not clear to me how that works for the microchip devices
> > > (I suspect it doesn't!)
> > >=20
> > > Just thinking as I type, but could we do something a bit nasty with
> > > a gpio mux that doesn't actually switch but represents the GPIO being
> > > shared?  Given this is all tied to the spi bus that should all happen
> > > under serializing locks.=20
> > >=20
> > > Agreed though that this would be nicer as an SPI thing that let
> > > us specify that a single CS is share by multiple devices and their
> > > is some other signal acting to select which one we are talking to.
> > >  =20
> >=20
> > If the device-addressing on the same chip-select is to be handled
> > by the spi framework, wouldn't we lose device-specific features?
> >=20
> > I understand that this multi-device feature is there mostly to extend t=
he
> > channel count from 16 to 32, 48 or 64. I suppose the command:
> >=20
> > 	"MULTI DEVICE SW LDAC MODE"
> >=20
> > exists so that software can update channel values accross multiple devi=
ces. =20
>=20
> Right! You do have a point! I agree the main driver for a feature like
> this is likely to extend the channel count and effectively "aggregate"
> devices.
>=20
> But I would say that even with the spi solution the MULTI DEVICE stuff
> should be doable (as we still need a sort of adi,pin-id property).=20
>=20
> But yes, I do feel that the whole feature is for aggregation so seeing
> one device with 32 channels is the expectation here? Rather than seeing
> two devices with 16 channels.

Agreed - if we have messages that address both devices at once that needs
to be a unified driver and given they are about triggering simultaneous
update of all channels it needs to look like one big device.
This ends up similar to how we handle daisy chain devices.

The question of what to do on devices that don't have this feature
is rather different. Good thing you read the datasheet :)

Jonathan

>=20
> - Nuno S=C3=A1
>=20
> >=20
> > --=20
> > Kind regards,
> >=20
> > Rodrigo Alencar =20

