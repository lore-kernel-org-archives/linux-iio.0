Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8543D5679;
	Tue, 23 Jun 2026 14:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782226666; cv=none; b=tRT8UwKRfoBF/fO50vGzT9zqzVVY/V4SHqSNPW8rH9GdFC9yNyugVeHUYBbt+Q6OtFImP0rTt4pfviQ641x+tf/UY45TqGvZ5LnUSbCb+aIMwhbWbGO5QLSmK/zyCjc/5HYHuXJPEM7RI8INot4UMW7IsEAeTAWE62uth0i4vvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782226666; c=relaxed/simple;
	bh=2J2i9Erd3wKQU7FRkyxsVtskSmSaQjSvt5k0Was3J84=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YBjtIbjqk3G9jZzBhYkwUbb4kAF4KqOGllM9eB1kVNFPFYcx9pbXiCpGDLA80RPyWWxyYBUpMADAuZ9q/a3bYf/4EKk9rcAElrhhetUAtFoSOSEasRPZRkiXhSKRy3vI6M3fpxbKB1LDhqs2B3m6H7/Y4hzYWYXqPbdpSxGIuOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I42POLg6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I42POLg6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68EF41F00A3A;
	Tue, 23 Jun 2026 14:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782226665;
	bh=XMyJX8X0OIgflkgnZ3Z7M676JJKYGNQeWHPeaDg3YAE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=I42POLg6TB8wnCM4oWb7uSFeDLhn8SVkRcAkuYHP0ZXOfe87nfe7hrSYlmN8LERDE
	 taqKW+/6Oh1FfEp8Y66WVqdMGS0sOS17IyBV/010OWosspxR2y3JE0y/kCVsR17vJm
	 ZDaKUZOEwBNsNUeGR++IHgS3RfFwwYbcJZbBjNDmuy3A/IBFmydRHJYRxHvcAyG3Qi
	 ePaGntvT3okVbwlVdBlLF2iy1vRd6je0rO1VqenySUhp4Zd8mmOg+fAm1efL8YNU4x
	 6+MvvSHg8OVOddJXkDbMTDtLQp5LTM4mybfivDjQoe7S1ONSjrvsn9HTb69ysvvO1J
	 95Pzyv52z42iQ==
Date: Tue, 23 Jun 2026 15:57:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>, Conor Dooley
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
Message-ID: <20260623155732.318f34f2@jic23-huawei>
In-Reply-To: <5guhkvoxhkzevjm4b45hhk3772akpnz3givr3gb56x5ywamzyf@oiycreun4y62>
References: <20260619-obstinate-polo-a230bef97fda@spud>
	<20260619-bunch-diocese-dd7805cc17ff@spud>
	<ajU73_TkKrSbqD4f@nsa>
	<20260619-concierge-doozy-9c161533c369@spud>
	<ajVlD-j0nIGrRVow@nsa>
	<20260621153330.79b6600c@jic23-huawei>
	<5u4dnsgxwcwie45f24cacyzf3dko4srhyyyhcpom6tsvhqtmpc@y7d7gmex6n7k>
	<ajkMBh-R_7pYaoAn@nsa>
	<pifhwgj3cp2vc7ia4m6penh52iekzjljrp75y5b7j57vvtooad@32wfqruiqqjl>
	<ajklksIDLsj0BZul@nsa>
	<5guhkvoxhkzevjm4b45hhk3772akpnz3givr3gb56x5ywamzyf@oiycreun4y62>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 23 Jun 2026 09:09:14 +0100
Rodrigo Alencar <455.rodrigo.alencar@gmail.com> wrote:

> On 22/06/26 13:20, Nuno S=C3=A1 wrote:
> > On Mon, Jun 22, 2026 at 12:51:20PM +0100, Rodrigo Alencar wrote: =20
> > > On 22/06/26 11:29, Nuno S=C3=A1 wrote: =20
> > > > On Mon, Jun 22, 2026 at 10:24:05AM +0100, Rodrigo Alencar wrote: =20
> > > > > On 21/06/26 15:33, Jonathan Cameron wrote: =20
> > > > > > On Fri, 19 Jun 2026 16:54:11 +0100
> > > > > > Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
> > > > > >  =20
> > > > > > > On Fri, Jun 19, 2026 at 03:12:07PM +0100, Conor Dooley wrote:=
 =20
> > > > > > > > On Fri, Jun 19, 2026 at 02:01:08PM +0100, Nuno S=C3=A1 wrot=
e:   =20
> > > > > > > > > On Fri, Jun 19, 2026 at 12:40:54PM +0100, Conor Dooley wr=
ote:   =20
> > > > > > > > > > On Fri, Jun 19, 2026 at 12:36:55PM +0100, Conor Dooley =
wrote:   =20
> > > > > > > > > > > On Fri, Jun 19, 2026 at 12:33:11PM +0200, Janani Suni=
l wrote:   =20
> > > > > > > > > > > >=20
> > > > > > > > > > > > On 6/14/26 21:44, Jonathan Cameron wrote:   =20
> > > > > > > > > > > > > On Tue, 9 Jun 2026 16:47:23 +0200
> > > > > > > > > > > > > Janani Sunil <jan.sun97@gmail.com> wrote:
> > > > > > > > > > > > >    =20
> > > > > > > > > > > > > > On 5/26/26 15:11, Rodrigo Alencar wrote:   =20
> > > > > > > > > > > > > > > On 26/05/19 05:42PM, Janani Sunil wrote:   =20
> > > > > > > > > > > > > > > > Devicetree bindings for AD5529R 16 channel =
12/16 bit high voltage,
> > > > > > > > > > > > > > > > buffered voltage output digital-to-analog c=
onverter (DAC) with an
> > > > > > > > > > > > > > > > integrated precision reference.   =20
> > > > > > > > > > > > > > > ...
> > > > > > > > > > > > > > > Probably others may comment on that, but...
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > This parent node may support device addressin=
g for multi-device support through
> > > > > > > > > > > > > > > those ID pins. I suppose that each device may=
 have its own power supplies or
> > > > > > > > > > > > > > > other resources like the toggle pins or reset=
 and enable.
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > That way I suppose that an example would look=
 like...   =20
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +patternProperties:
> > > > > > > > > > > > > > > > +  "^channel@([0-9]|1[0-5])$":
> > > > > > > > > > > > > > > > +    type: object
> > > > > > > > > > > > > > > > +    description: Child nodes for individua=
l channel configuration
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +    properties:
> > > > > > > > > > > > > > > > +      reg:
> > > > > > > > > > > > > > > > +        description: Channel number.
> > > > > > > > > > > > > > > > +        minimum: 0
> > > > > > > > > > > > > > > > +        maximum: 15
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +      adi,output-range-microvolt:
> > > > > > > > > > > > > > > > +        description: |
> > > > > > > > > > > > > > > > +          Output voltage range for this ch=
annel as [min, max] in microvolts.
> > > > > > > > > > > > > > > > +          If not specified, defaults to 0V=
 to 5V range.
> > > > > > > > > > > > > > > > +        oneOf:
> > > > > > > > > > > > > > > > +          - items:
> > > > > > > > > > > > > > > > +              - const: 0
> > > > > > > > > > > > > > > > +              - enum: [5000000, 10000000, =
20000000, 40000000]
> > > > > > > > > > > > > > > > +          - items:
> > > > > > > > > > > > > > > > +              - const: -5000000
> > > > > > > > > > > > > > > > +              - const: 5000000
> > > > > > > > > > > > > > > > +          - items:
> > > > > > > > > > > > > > > > +              - const: -10000000
> > > > > > > > > > > > > > > > +              - const: 10000000
> > > > > > > > > > > > > > > > +          - items:
> > > > > > > > > > > > > > > > +              - const: -15000000
> > > > > > > > > > > > > > > > +              - const: 15000000
> > > > > > > > > > > > > > > > +          - items:
> > > > > > > > > > > > > > > > +              - const: -20000000
> > > > > > > > > > > > > > > > +              - const: 20000000
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +    required:
> > > > > > > > > > > > > > > > +      - reg
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +    additionalProperties: false
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +required:
> > > > > > > > > > > > > > > > +  - compatible
> > > > > > > > > > > > > > > > +  - reg
> > > > > > > > > > > > > > > > +  - vdd-supply
> > > > > > > > > > > > > > > > +  - avdd-supply
> > > > > > > > > > > > > > > > +  - hvdd-supply
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +dependencies:
> > > > > > > > > > > > > > > > +  spi-cpha: [ spi-cpol ]
> > > > > > > > > > > > > > > > +  spi-cpol: [ spi-cpha ]
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +allOf:
> > > > > > > > > > > > > > > > +  - $ref: /schemas/spi/spi-peripheral-prop=
s.yaml#
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +unevaluatedProperties: false
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +examples:
> > > > > > > > > > > > > > > > +  - |
> > > > > > > > > > > > > > > > +    #include <dt-bindings/gpio/gpio.h>
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +    spi {
> > > > > > > > > > > > > > > > +        #address-cells =3D <1>;
> > > > > > > > > > > > > > > > +        #size-cells =3D <0>;
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +        dac@0 {
> > > > > > > > > > > > > > > > +            compatible =3D "adi,ad5529r-16=
";
> > > > > > > > > > > > > > > > +            reg =3D <0>;
> > > > > > > > > > > > > > > > +            spi-max-frequency =3D <2500000=
0>;
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +            vdd-supply =3D <&vdd_regulator=
>;
> > > > > > > > > > > > > > > > +            avdd-supply =3D <&avdd_regulat=
or>;
> > > > > > > > > > > > > > > > +            hvdd-supply =3D <&hvdd_regulat=
or>;
> > > > > > > > > > > > > > > > +            hvss-supply =3D <&hvss_regulat=
or>;
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +            reset-gpios =3D <&gpio0 87 GPI=
O_ACTIVE_LOW>;
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +            #address-cells =3D <1>;
> > > > > > > > > > > > > > > > +            #size-cells =3D <0>;
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +            channel@0 {
> > > > > > > > > > > > > > > > +                reg =3D <0>;
> > > > > > > > > > > > > > > > +                adi,output-range-microvolt=
 =3D <0 5000000>;
> > > > > > > > > > > > > > > > +            };
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +            channel@1 {
> > > > > > > > > > > > > > > > +                reg =3D <1>;
> > > > > > > > > > > > > > > > +                adi,output-range-microvolt=
 =3D <(-10000000) 10000000>;
> > > > > > > > > > > > > > > > +            };
> > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > +            channel@2 {
> > > > > > > > > > > > > > > > +                reg =3D <2>;
> > > > > > > > > > > > > > > > +                adi,output-range-microvolt=
 =3D <0 40000000>;
> > > > > > > > > > > > > > > > +            };
> > > > > > > > > > > > > > > > +        };
> > > > > > > > > > > > > > > > +    };   =20
> > > > > > > > > > > > > > > ...
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > 	spi {
> > > > > > > > > > > > > > > 		#address-cells =3D <1>;
> > > > > > > > > > > > > > > 		#size-cells =3D <0>;
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > 		multi-dac@0 {
> > > > > > > > > > > > > > > 			compatible =3D "adi,ad5529r-16";
> > > > > > > > > > > > > > > 			reg =3D <0>;
> > > > > > > > > > > > > > > 			spi-max-frequency =3D <25000000>;
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > 			#address-cells =3D <1>;
> > > > > > > > > > > > > > > 			#size-cells =3D <0>;
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > 			dac@0 {
> > > > > > > > > > > > > > > 				reg =3D <0>;
> > > > > > > > > > > > > > > 				vdd-supply =3D <&vdd_regulator>;
> > > > > > > > > > > > > > > 				avdd-supply =3D <&avdd_regulator>;
> > > > > > > > > > > > > > > 				hvdd-supply =3D <&hvdd_regulator>;
> > > > > > > > > > > > > > > 				hvss-supply =3D <&hvss_regulator>;
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > 				reset-gpios =3D <&gpio0 87 GPIO_ACTIVE_LO=
W>;
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > 				#address-cells =3D <1>;
> > > > > > > > > > > > > > > 				#size-cells =3D <0>;
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > 				channel@0 {
> > > > > > > > > > > > > > > 					reg =3D <0>;
> > > > > > > > > > > > > > > 					adi,output-range-microvolt =3D <0 500000=
0>;
> > > > > > > > > > > > > > > 				};
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > 				channel@1 {
> > > > > > > > > > > > > > > 					reg =3D <1>;
> > > > > > > > > > > > > > > 					adi,output-range-microvolt =3D <(-100000=
00) 10000000>;
> > > > > > > > > > > > > > > 				};
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > 				channel@2 {
> > > > > > > > > > > > > > > 					reg =3D <2>;
> > > > > > > > > > > > > > > 					adi,output-range-microvolt =3D <0 400000=
00>;
> > > > > > > > > > > > > > > 				};
> > > > > > > > > > > > > > > 			}
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > 			dac@1 {
> > > > > > > > > > > > > > > 				reg =3D <1>;
> > > > > > > > > > > > > > > 				vdd-supply =3D <&vdd_regulator>;
> > > > > > > > > > > > > > > 				avdd-supply =3D <&avdd_regulator>;
> > > > > > > > > > > > > > > 				hvdd-supply =3D <&hvdd_regulator>;
> > > > > > > > > > > > > > > 				hvss-supply =3D <&hvss_regulator>;
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > 				reset-gpios =3D <&gpio0 88 GPIO_ACTIVE_LO=
W>;
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > 				#address-cells =3D <1>;
> > > > > > > > > > > > > > > 				#size-cells =3D <0>;
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > 				channel@0 {
> > > > > > > > > > > > > > > 					reg =3D <0>;
> > > > > > > > > > > > > > > 					adi,output-range-microvolt =3D <0 500000=
0>;
> > > > > > > > > > > > > > > 				};
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > 				channel@1 {
> > > > > > > > > > > > > > > 					reg =3D <1>;
> > > > > > > > > > > > > > > 					adi,output-range-microvolt =3D <(-100000=
00) 10000000>;
> > > > > > > > > > > > > > > 				};
> > > > > > > > > > > > > > > 			}
> > > > > > > > > > > > > > > 		};
> > > > > > > > > > > > > > > 	};
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > then you might need something like:
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > 	patternProperties:
> > > > > > > > > > > > > > > 		"^dac@[0-3]$":
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > and put most of the things under this node pa=
ttern.
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > So the main driver that you're putting togeth=
er might need to handle up to four instances.
> > > > > > > > > > > > > > > Even if your current driver cannot handle thi=
s, the dt-bindings might need cover that.
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > Need to double check if each dac node needs a=
 separate compatible, so you would maybe populate
> > > > > > > > > > > > > > > a platform data to be shared with the child n=
odes, which would be a separate driver.
> > > > > > > > > > > > > > > (not sure if it would make sense to mix and m=
atch ad5529r-16 and ad5529r-12).   =20
> > > > > > > > > > > > > > Hi Rodrigo,
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > Thank you for looking at this.
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > For now, I would prefer to keep the binding sco=
ped to a single AD5529R device instance. The current
> > > > > > > > > > > > > > hardware/use case we have only needs one device=
 node and the driver is written around that model as well.
> > > > > > > > > > > > > > While the device addressing pins could allow mu=
lti-device topology, we do not have an actual platform using
> > > > > > > > > > > > > > that configuration at the moment, so I would pr=
efer not to introduce an extra parent/child binding structure
> > > > > > > > > > > > > > speculatively without a validating use case.   =
=20
> > > > > > > > > > > > > Interesting feature - kind of similar to address =
control on a typical i2c bus device, or
> > > > > > > > > > > > > looking at it another way a kind of distributed S=
PI mux.
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > Challenge of a binding is we need to anticipate t=
he future.  So I think we do need something
> > > > > > > > > > > > > like Rodrigo is suggesting even if we only (for n=
ow) support a single instance in the driver.
> > > > > > > > > > > > > That would leave the path open to supporting the =
addressing at a later date.
> > > > > > > > > > > > > An alternative might be to look at it like a chai=
ned device setup. In those we pretend there
> > > > > > > > > > > > > is just one device with a lot of channels etc.  T=
he snag is that here things are more loosely
> > > > > > > > > > > > > coupled whereas for those devices it tends to be =
you have to read / write the same register
> > > > > > > > > > > > > in all devices in the chain as one big SPI messag=
e.
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > +CC Mark Brown as he may know of some precedence =
for this feature. For his reference..
> > > > > > > > > > > > > - Each of these device has 2 ID pins.  The SPI tr=
ansfers have to contain the 2 bit
> > > > > > > > > > > > > value that matches that or they are ignored.  Thu=
s a single bus + 1 chip select can
> > > > > > > > > > > > > be used to talk to 4 devices.  Question is what t=
hat looks like in device tree + I guess
> > > > > > > > > > > > > longer term how to support it cleanly in SPI.   =
=20
> > > > > > > > > > >=20
> > > > > > > > > > > I'd swear I have seen this before, from some Microchi=
p devices. Let me
> > > > > > > > > > > see if I can find what I am thinking of...   =20
> > > > > > > > > >=20
> > > > > > > > > >=20
> > > > > > > > > > microchip,mcp3911 and microchip,mcp3564 both seem to do=
 this with
> > > > > > > > > > slightly different properties.
> > > > > > > > > >=20
> > > > > > > > > >   microchip,device-addr:
> > > > > > > > > >     description: Device address when multiple MCP3911 c=
hips are present on the same SPI bus.
> > > > > > > > > >     $ref: /schemas/types.yaml#/definitions/uint32
> > > > > > > > > >     enum: [0, 1, 2, 3]
> > > > > > > > > >     default: 0
> > > > > > > > > >=20
> > > > > > > > > > and
> > > > > > > > > >=20
> > > > > > > > > >=20
> > > > > > > > > >   microchip,hw-device-address:
> > > > > > > > > >     $ref: /schemas/types.yaml#/definitions/uint32
> > > > > > > > > >     minimum: 0
> > > > > > > > > >     maximum: 3
> > > > > > > > > >     description:
> > > > > > > > > >       The address is set on a per-device basis by fuses=
 in the factory,
> > > > > > > > > >       configured on request. If not requested, the fuse=
s are set for 0x1.
> > > > > > > > > >       The device address is part of the device markings=
 to avoid
> > > > > > > > > >       potential confusion. This address is coded on two=
 bits, so four possible
> > > > > > > > > >       addresses are available when multiple devices are=
 present on the same
> > > > > > > > > >       SPI bus with only one Chip Select line for all de=
vices.
> > > > > > > > > >       Each device communication starts by a CS falling =
edge, followed by the
> > > > > > > > > >       clocking of the device address (BITS[7:6] - top t=
wo bits of COMMAND BYTE
> > > > > > > > > >       which is first one on the wire).
> > > > > > > > > >=20
> > > > > > > > > > This sounds exactly like the sort of feature that you'r=
e dealing with
> > > > > > > > > > here?
> > > > > > > > > >    =20
> > > > > > > > >=20
> > > > > > > > > The core idea yes but for this chip, things are a bit mor=
e annoying (but
> > > > > > > > > Janani can correct me if I'm wrong). Here, each device ca=
n, in theory,
> > > > > > > > > have it's own supplies, pins and at the very least, chann=
els with maybe
> > > > > > > > > different scales. That is why Janani is proposing dac nod=
es. Given I
> > > > > > > > > honestly don't like much of that "adi,ad5529r-bus" compat=
ible I wondered
> > > > > > > > > about solving this at the spi level.
> > > > > > > > >=20
> > > > > > > > > Ah and to make it more annoying, we can also mix 12 and 1=
6 bits variants
> > > > > > > > > together in the same bus.   =20
> > > > > > > >=20
> > > > > > > > I'm definitely missing something, because that property for=
 the
> > > > > > > > microchip devices is not impacted what else is on the bus. =
AFAICT, you
> > > > > > > > could have an mcp3911 and an mcp3564 on the same bus even t=
hough both
> > > > > > > > are completely different devices with different drivers. Th=
ey have
> > > > > > > > individual device nodes and their own supplies etc etc. The=
se aren't
> > > > > > > > per-channel properties on an adc or dac, they're per child =
device on a
> > > > > > > > spi bus.   =20
> > > > > > >=20
> > > > > > > Maybe I'm the one missing something :). IIRC, spi would not a=
llow two
> > > > > > > devices on the same CS right? Because for this chip we would =
need
> > > > > > > something like:
> > > > > > >=20
> > > > > > > spi {
> > > > > > > 	dac@0 {
> > > > > > > 		reg =3D <0>;
> > > > > > > 		adi,pin-id =3D <0>;
> > > > > > > 	};
> > > > > > >=20
> > > > > > > 	dac@1 {
> > > > > > > 		reg =3D <0>; // which seems already problematic?
> > > > > > > 		adi,pin-id <1>;
> > > > > > > 	};
> > > > > > >=20
> > > > > > > 	...
> > > > > > >=20
> > > > > > > 	//up to 4
> > > > > > > }; =20
> > > > > > Yeah. It's not clear to me how that works for the microchip dev=
ices
> > > > > > (I suspect it doesn't!)
> > > > > >=20
> > > > > > Just thinking as I type, but could we do something a bit nasty =
with
> > > > > > a gpio mux that doesn't actually switch but represents the GPIO=
 being
> > > > > > shared?  Given this is all tied to the spi bus that should all =
happen
> > > > > > under serializing locks.=20
> > > > > >=20
> > > > > > Agreed though that this would be nicer as an SPI thing that let
> > > > > > us specify that a single CS is share by multiple devices and th=
eir
> > > > > > is some other signal acting to select which one we are talking =
to.
> > > > > >  =20
> > > > >=20
> > > > > If the device-addressing on the same chip-select is to be handled
> > > > > by the spi framework, wouldn't we lose device-specific features?
> > > > >=20
> > > > > I understand that this multi-device feature is there mostly to ex=
tend the
> > > > > channel count from 16 to 32, 48 or 64. I suppose the command:
> > > > >=20
> > > > > 	"MULTI DEVICE SW LDAC MODE"
> > > > >=20
> > > > > exists so that software can update channel values accross multipl=
e devices. =20
> > > >=20
> > > > Right! You do have a point! I agree the main driver for a feature l=
ike
> > > > this is likely to extend the channel count and effectively "aggrega=
te"
> > > > devices.
> > > >=20
> > > > But I would say that even with the spi solution the MULTI DEVICE st=
uff
> > > > should be doable (as we still need a sort of adi,pin-id property). =
 =20
> > >=20
> > > I don't think we can have something like an IIO buffer shared by mult=
iple
> > > devices. Synchronizing separate devices would be doable with proper h=
ardware
> > > support for this (probably involving an FGPA). =20
> >=20
> > True!
> >  =20
> > >   =20
> > > > But yes, I do feel that the whole feature is for aggregation so see=
ing
> > > > one device with 32 channels is the expectation here? Rather than se=
eing
> > > > two devices with 16 channels. =20
> > >=20
> > > Yes, I think aggregation is the whole point there... so that the IIO =
driver
> > > is multi-device-aware. =20
> >=20
> > Which makes me feel that different pins per device might be possible
> > from an HW point of view but does not make much sense. For example, for
> > the buffer example I would expect LDAC to be shared between all the
> > devices. =20
>=20
> That is why I would still suggest the multi-dac node in the middle...
> the parent node can hold shared resources, while the dac children can
> have their own, overriding or inheriting stuff.
>=20
Before going down that path I'd want confirmation this is something we
actually think anyone will build.

Jonathan


