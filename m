Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6015B30C160;
	Wed, 24 Jun 2026 16:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782318754; cv=none; b=DAwrY2XCZRMmuGGebvUV9zxWjDv9gJmHBEfCTjJX2MpAGug7a/fy2cuNe3+es+o1mhm/kIyp4xdz3+nuOwLp6d8RQjnfFeYqtT4VXnOdR/Rs/S7d98f9MZHui3b3K34BODqMW93ZyCjlfz7s+Ki6T1FCvm98FuuQQQmSi31jy7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782318754; c=relaxed/simple;
	bh=S5o88NrIIGptpfEbCp0nN98EHVlRdrmFCtW62Tbyj6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pp66MDs3cqOV/WgVwVTR7RFXhkqv10UWbtuxSMbVTvNx+2WMKiljVfRj7sZ4gpJTg+bBsfrsl7QOIRozCLKTRA4bVwR4n6BEi0ftodwVLuqZDBdZv+f1te4GSAEnKi+IcB1VB29VpCS4OHMO+9brx4C3VBGdNZFj35MadOgcTgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cDPeqwgd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cDPeqwgd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50FC51F000E9;
	Wed, 24 Jun 2026 16:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782318752;
	bh=4jtyQDgrMgUoHf8r841NWqd5vvUuGg9rIS6XPkH+9tA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cDPeqwgdG+BTnvD59nLEvLsGUhpSoH0YOeFd7FJTB0yKzQKLE/XRDTbjEIGR9uN9h
	 EvufEjhb7gm7iguP4FJEoFjpshfew2WsMS4iB3SSSDP6qsxJ9t+/+RPuTvx9HcEng4
	 tHZILxChAZVddFMQpglmODuls14AJM3G5Rp9+hYX3XENY7TdTPY98H+ugPpbNbTHrU
	 Ey6XI072+xbpdcGMFO6IFzdQQubojygIIfA4+xSsHMZswO645vmnHQK5rDHdV923Mp
	 J4o5wSRPEra49a0xAvfdcarV/SsQz2bLiggtCgSIyZcIirWkrbvfzm+g0aX7M0BrXb
	 OredWpJ+8rPPw==
Date: Wed, 24 Jun 2026 17:32:26 +0100
From: Conor Dooley <conor@kernel.org>
To: Janani Sunil <jan.sun97@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Rodrigo Alencar <455.rodrigo.alencar@gmail.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>,
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
Message-ID: <20260624-decrease-protector-6c883bd1ac47@spud>
References: <20260619-concierge-doozy-9c161533c369@spud>
 <ajVlD-j0nIGrRVow@nsa>
 <20260621153330.79b6600c@jic23-huawei>
 <5u4dnsgxwcwie45f24cacyzf3dko4srhyyyhcpom6tsvhqtmpc@y7d7gmex6n7k>
 <ajkMBh-R_7pYaoAn@nsa>
 <pifhwgj3cp2vc7ia4m6penh52iekzjljrp75y5b7j57vvtooad@32wfqruiqqjl>
 <ajklksIDLsj0BZul@nsa>
 <5guhkvoxhkzevjm4b45hhk3772akpnz3givr3gb56x5ywamzyf@oiycreun4y62>
 <20260623155732.318f34f2@jic23-huawei>
 <9abc53d0-432f-48fc-9e21-4d9a3c5e129f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nH1FK7ntrWpuYvHj"
Content-Disposition: inline
In-Reply-To: <9abc53d0-432f-48fc-9e21-4d9a3c5e129f@gmail.com>


--nH1FK7ntrWpuYvHj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 24, 2026 at 05:01:18PM +0200, Janani Sunil wrote:
>=20
> On 6/23/26 16:57, Jonathan Cameron wrote:
> > On Tue, 23 Jun 2026 09:09:14 +0100
> > Rodrigo Alencar <455.rodrigo.alencar@gmail.com> wrote:
> >=20
> > > On 22/06/26 13:20, Nuno S=E1 wrote:
> > > > On Mon, Jun 22, 2026 at 12:51:20PM +0100, Rodrigo Alencar wrote:
> > > > > On 22/06/26 11:29, Nuno S=E1 wrote:
> > > > > > On Mon, Jun 22, 2026 at 10:24:05AM +0100, Rodrigo Alencar wrote:
> > > > > > > On 21/06/26 15:33, Jonathan Cameron wrote:
> > > > > > > > On Fri, 19 Jun 2026 16:54:11 +0100
> > > > > > > > Nuno S=E1 <noname.nuno@gmail.com> wrote:
> > > > > > > > > On Fri, Jun 19, 2026 at 03:12:07PM +0100, Conor Dooley wr=
ote:
> > > > > > > > > > On Fri, Jun 19, 2026 at 02:01:08PM +0100, Nuno S=E1 wro=
te:
> > > > > > > > > > > On Fri, Jun 19, 2026 at 12:40:54PM +0100, Conor Doole=
y wrote:
> > > > > > > > > > > > On Fri, Jun 19, 2026 at 12:36:55PM +0100, Conor Doo=
ley wrote:
> > > > > > > > > > > > > On Fri, Jun 19, 2026 at 12:33:11PM +0200, Janani =
Sunil wrote:
> > > > > > > > > > > > > > On 6/14/26 21:44, Jonathan Cameron wrote:
> > > > > > > > > > > > > > > On Tue, 9 Jun 2026 16:47:23 +0200
> > > > > > > > > > > > > > > Janani Sunil <jan.sun97@gmail.com> wrote:
> > > > > > > > > > > > > > > > On 5/26/26 15:11, Rodrigo Alencar wrote:
> > > > > > > > > > > > > > > > > On 26/05/19 05:42PM, Janani Sunil wrote:
> > > > > > > > > > > > > > > > > > Devicetree bindings for AD5529R 16 chan=
nel 12/16 bit high voltage,
> > > > > > > > > > > > > > > > > > buffered voltage output digital-to-anal=
og converter (DAC) with an
> > > > > > > > > > > > > > > > > > integrated precision reference.
> > > > > > > > > > > > > > > > > ...
> > > > > > > > > > > > > > > > > Probably others may comment on that, but.=
=2E.
> > > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > > This parent node may support device addre=
ssing for multi-device support through
> > > > > > > > > > > > > > > > > those ID pins. I suppose that each device=
 may have its own power supplies or
> > > > > > > > > > > > > > > > > other resources like the toggle pins or r=
eset and enable.
> > > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > > That way I suppose that an example would =
look like...
> > > > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > > > +patternProperties:
> > > > > > > > > > > > > > > > > > +  "^channel@([0-9]|1[0-5])$":
> > > > > > > > > > > > > > > > > > +    type: object
> > > > > > > > > > > > > > > > > > +    description: Child nodes for indiv=
idual channel configuration
> > > > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > > > +    properties:
> > > > > > > > > > > > > > > > > > +      reg:
> > > > > > > > > > > > > > > > > > +        description: Channel number.
> > > > > > > > > > > > > > > > > > +        minimum: 0
> > > > > > > > > > > > > > > > > > +        maximum: 15
> > > > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > > > +      adi,output-range-microvolt:
> > > > > > > > > > > > > > > > > > +        description: |
> > > > > > > > > > > > > > > > > > +          Output voltage range for thi=
s channel as [min, max] in microvolts.
> > > > > > > > > > > > > > > > > > +          If not specified, defaults t=
o 0V to 5V range.
> > > > > > > > > > > > > > > > > > +        oneOf:
> > > > > > > > > > > > > > > > > > +          - items:
> > > > > > > > > > > > > > > > > > +              - const: 0
> > > > > > > > > > > > > > > > > > +              - enum: [5000000, 100000=
00, 20000000, 40000000]
> > > > > > > > > > > > > > > > > > +          - items:
> > > > > > > > > > > > > > > > > > +              - const: -5000000
> > > > > > > > > > > > > > > > > > +              - const: 5000000
> > > > > > > > > > > > > > > > > > +          - items:
> > > > > > > > > > > > > > > > > > +              - const: -10000000
> > > > > > > > > > > > > > > > > > +              - const: 10000000
> > > > > > > > > > > > > > > > > > +          - items:
> > > > > > > > > > > > > > > > > > +              - const: -15000000
> > > > > > > > > > > > > > > > > > +              - const: 15000000
> > > > > > > > > > > > > > > > > > +          - items:
> > > > > > > > > > > > > > > > > > +              - const: -20000000
> > > > > > > > > > > > > > > > > > +              - const: 20000000
> > > > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > > > +    required:
> > > > > > > > > > > > > > > > > > +      - reg
> > > > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > > > +    additionalProperties: false
> > > > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > > > +required:
> > > > > > > > > > > > > > > > > > +  - compatible
> > > > > > > > > > > > > > > > > > +  - reg
> > > > > > > > > > > > > > > > > > +  - vdd-supply
> > > > > > > > > > > > > > > > > > +  - avdd-supply
> > > > > > > > > > > > > > > > > > +  - hvdd-supply
> > > > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > > > +dependencies:
> > > > > > > > > > > > > > > > > > +  spi-cpha: [ spi-cpol ]
> > > > > > > > > > > > > > > > > > +  spi-cpol: [ spi-cpha ]
> > > > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > > > +allOf:
> > > > > > > > > > > > > > > > > > +  - $ref: /schemas/spi/spi-peripheral-=
props.yaml#
> > > > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > > > +unevaluatedProperties: false
> > > > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > > > +examples:
> > > > > > > > > > > > > > > > > > +  - |
> > > > > > > > > > > > > > > > > > +    #include <dt-bindings/gpio/gpio.h>
> > > > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > > > +    spi {
> > > > > > > > > > > > > > > > > > +        #address-cells =3D <1>;
> > > > > > > > > > > > > > > > > > +        #size-cells =3D <0>;
> > > > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > > > +        dac@0 {
> > > > > > > > > > > > > > > > > > +            compatible =3D "adi,ad5529=
r-16";
> > > > > > > > > > > > > > > > > > +            reg =3D <0>;
> > > > > > > > > > > > > > > > > > +            spi-max-frequency =3D <250=
00000>;
> > > > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > > > +            vdd-supply =3D <&vdd_regul=
ator>;
> > > > > > > > > > > > > > > > > > +            avdd-supply =3D <&avdd_reg=
ulator>;
> > > > > > > > > > > > > > > > > > +            hvdd-supply =3D <&hvdd_reg=
ulator>;
> > > > > > > > > > > > > > > > > > +            hvss-supply =3D <&hvss_reg=
ulator>;
> > > > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > > > +            reset-gpios =3D <&gpio0 87=
 GPIO_ACTIVE_LOW>;
> > > > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > > > +            #address-cells =3D <1>;
> > > > > > > > > > > > > > > > > > +            #size-cells =3D <0>;
> > > > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > > > +            channel@0 {
> > > > > > > > > > > > > > > > > > +                reg =3D <0>;
> > > > > > > > > > > > > > > > > > +                adi,output-range-micro=
volt =3D <0 5000000>;
> > > > > > > > > > > > > > > > > > +            };
> > > > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > > > +            channel@1 {
> > > > > > > > > > > > > > > > > > +                reg =3D <1>;
> > > > > > > > > > > > > > > > > > +                adi,output-range-micro=
volt =3D <(-10000000) 10000000>;
> > > > > > > > > > > > > > > > > > +            };
> > > > > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > > > > +            channel@2 {
> > > > > > > > > > > > > > > > > > +                reg =3D <2>;
> > > > > > > > > > > > > > > > > > +                adi,output-range-micro=
volt =3D <0 40000000>;
> > > > > > > > > > > > > > > > > > +            };
> > > > > > > > > > > > > > > > > > +        };
> > > > > > > > > > > > > > > > > > +    };
> > > > > > > > > > > > > > > > > ...
> > > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > > 	spi {
> > > > > > > > > > > > > > > > > 		#address-cells =3D <1>;
> > > > > > > > > > > > > > > > > 		#size-cells =3D <0>;
> > > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > > 		multi-dac@0 {
> > > > > > > > > > > > > > > > > 			compatible =3D "adi,ad5529r-16";
> > > > > > > > > > > > > > > > > 			reg =3D <0>;
> > > > > > > > > > > > > > > > > 			spi-max-frequency =3D <25000000>;
> > > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > > 			#address-cells =3D <1>;
> > > > > > > > > > > > > > > > > 			#size-cells =3D <0>;
> > > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > > 			dac@0 {
> > > > > > > > > > > > > > > > > 				reg =3D <0>;
> > > > > > > > > > > > > > > > > 				vdd-supply =3D <&vdd_regulator>;
> > > > > > > > > > > > > > > > > 				avdd-supply =3D <&avdd_regulator>;
> > > > > > > > > > > > > > > > > 				hvdd-supply =3D <&hvdd_regulator>;
> > > > > > > > > > > > > > > > > 				hvss-supply =3D <&hvss_regulator>;
> > > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > > 				reset-gpios =3D <&gpio0 87 GPIO_ACTIV=
E_LOW>;
> > > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > > 				#address-cells =3D <1>;
> > > > > > > > > > > > > > > > > 				#size-cells =3D <0>;
> > > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > > 				channel@0 {
> > > > > > > > > > > > > > > > > 					reg =3D <0>;
> > > > > > > > > > > > > > > > > 					adi,output-range-microvolt =3D <0 50=
00000>;
> > > > > > > > > > > > > > > > > 				};
> > > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > > 				channel@1 {
> > > > > > > > > > > > > > > > > 					reg =3D <1>;
> > > > > > > > > > > > > > > > > 					adi,output-range-microvolt =3D <(-10=
000000) 10000000>;
> > > > > > > > > > > > > > > > > 				};
> > > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > > 				channel@2 {
> > > > > > > > > > > > > > > > > 					reg =3D <2>;
> > > > > > > > > > > > > > > > > 					adi,output-range-microvolt =3D <0 40=
000000>;
> > > > > > > > > > > > > > > > > 				};
> > > > > > > > > > > > > > > > > 			}
> > > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > > 			dac@1 {
> > > > > > > > > > > > > > > > > 				reg =3D <1>;
> > > > > > > > > > > > > > > > > 				vdd-supply =3D <&vdd_regulator>;
> > > > > > > > > > > > > > > > > 				avdd-supply =3D <&avdd_regulator>;
> > > > > > > > > > > > > > > > > 				hvdd-supply =3D <&hvdd_regulator>;
> > > > > > > > > > > > > > > > > 				hvss-supply =3D <&hvss_regulator>;
> > > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > > 				reset-gpios =3D <&gpio0 88 GPIO_ACTIV=
E_LOW>;
> > > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > > 				#address-cells =3D <1>;
> > > > > > > > > > > > > > > > > 				#size-cells =3D <0>;
> > > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > > 				channel@0 {
> > > > > > > > > > > > > > > > > 					reg =3D <0>;
> > > > > > > > > > > > > > > > > 					adi,output-range-microvolt =3D <0 50=
00000>;
> > > > > > > > > > > > > > > > > 				};
> > > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > > 				channel@1 {
> > > > > > > > > > > > > > > > > 					reg =3D <1>;
> > > > > > > > > > > > > > > > > 					adi,output-range-microvolt =3D <(-10=
000000) 10000000>;
> > > > > > > > > > > > > > > > > 				};
> > > > > > > > > > > > > > > > > 			}
> > > > > > > > > > > > > > > > > 		};
> > > > > > > > > > > > > > > > > 	};
> > > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > > then you might need something like:
> > > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > > 	patternProperties:
> > > > > > > > > > > > > > > > > 		"^dac@[0-3]$":
> > > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > > and put most of the things under this nod=
e pattern.
> > > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > > So the main driver that you're putting to=
gether might need to handle up to four instances.
> > > > > > > > > > > > > > > > > Even if your current driver cannot handle=
 this, the dt-bindings might need cover that.
> > > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > > Need to double check if each dac node nee=
ds a separate compatible, so you would maybe populate
> > > > > > > > > > > > > > > > > a platform data to be shared with the chi=
ld nodes, which would be a separate driver.
> > > > > > > > > > > > > > > > > (not sure if it would make sense to mix a=
nd match ad5529r-16 and ad5529r-12).
> > > > > > > > > > > > > > > > Hi Rodrigo,
> > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > Thank you for looking at this.
> > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > For now, I would prefer to keep the binding=
 scoped to a single AD5529R device instance. The current
> > > > > > > > > > > > > > > > hardware/use case we have only needs one de=
vice node and the driver is written around that model as well.
> > > > > > > > > > > > > > > > While the device addressing pins could allo=
w multi-device topology, we do not have an actual platform using
> > > > > > > > > > > > > > > > that configuration at the moment, so I woul=
d prefer not to introduce an extra parent/child binding structure
> > > > > > > > > > > > > > > > speculatively without a validating use case.
> > > > > > > > > > > > > > > Interesting feature - kind of similar to addr=
ess control on a typical i2c bus device, or
> > > > > > > > > > > > > > > looking at it another way a kind of distribut=
ed SPI mux.
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > Challenge of a binding is we need to anticipa=
te the future.  So I think we do need something
> > > > > > > > > > > > > > > like Rodrigo is suggesting even if we only (f=
or now) support a single instance in the driver.
> > > > > > > > > > > > > > > That would leave the path open to supporting =
the addressing at a later date.
> > > > > > > > > > > > > > > An alternative might be to look at it like a =
chained device setup. In those we pretend there
> > > > > > > > > > > > > > > is just one device with a lot of channels etc=
=2E  The snag is that here things are more loosely
> > > > > > > > > > > > > > > coupled whereas for those devices it tends to=
 be you have to read / write the same register
> > > > > > > > > > > > > > > in all devices in the chain as one big SPI me=
ssage.
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > +CC Mark Brown as he may know of some precede=
nce for this feature. For his reference..
> > > > > > > > > > > > > > > - Each of these device has 2 ID pins.  The SP=
I transfers have to contain the 2 bit
> > > > > > > > > > > > > > > value that matches that or they are ignored. =
 Thus a single bus + 1 chip select can
> > > > > > > > > > > > > > > be used to talk to 4 devices.  Question is wh=
at that looks like in device tree + I guess
> > > > > > > > > > > > > > > longer term how to support it cleanly in SPI.
> > > > > > > > > > > > > I'd swear I have seen this before, from some Micr=
ochip devices. Let me
> > > > > > > > > > > > > see if I can find what I am thinking of...
> > > > > > > > > > > >=20
> > > > > > > > > > > > microchip,mcp3911 and microchip,mcp3564 both seem t=
o do this with
> > > > > > > > > > > > slightly different properties.
> > > > > > > > > > > >=20
> > > > > > > > > > > >    microchip,device-addr:
> > > > > > > > > > > >      description: Device address when multiple MCP3=
911 chips are present on the same SPI bus.
> > > > > > > > > > > >      $ref: /schemas/types.yaml#/definitions/uint32
> > > > > > > > > > > >      enum: [0, 1, 2, 3]
> > > > > > > > > > > >      default: 0
> > > > > > > > > > > >=20
> > > > > > > > > > > > and
> > > > > > > > > > > >=20
> > > > > > > > > > > >=20
> > > > > > > > > > > >    microchip,hw-device-address:
> > > > > > > > > > > >      $ref: /schemas/types.yaml#/definitions/uint32
> > > > > > > > > > > >      minimum: 0
> > > > > > > > > > > >      maximum: 3
> > > > > > > > > > > >      description:
> > > > > > > > > > > >        The address is set on a per-device basis by =
fuses in the factory,
> > > > > > > > > > > >        configured on request. If not requested, the=
 fuses are set for 0x1.
> > > > > > > > > > > >        The device address is part of the device mar=
kings to avoid
> > > > > > > > > > > >        potential confusion. This address is coded o=
n two bits, so four possible
> > > > > > > > > > > >        addresses are available when multiple device=
s are present on the same
> > > > > > > > > > > >        SPI bus with only one Chip Select line for a=
ll devices.
> > > > > > > > > > > >        Each device communication starts by a CS fal=
ling edge, followed by the
> > > > > > > > > > > >        clocking of the device address (BITS[7:6] - =
top two bits of COMMAND BYTE
> > > > > > > > > > > >        which is first one on the wire).
> > > > > > > > > > > >=20
> > > > > > > > > > > > This sounds exactly like the sort of feature that y=
ou're dealing with
> > > > > > > > > > > > here?
> > > > > > > > > > > The core idea yes but for this chip, things are a bit=
 more annoying (but
> > > > > > > > > > > Janani can correct me if I'm wrong). Here, each devic=
e can, in theory,
> > > > > > > > > > > have it's own supplies, pins and at the very least, c=
hannels with maybe
> > > > > > > > > > > different scales. That is why Janani is proposing dac=
 nodes. Given I
> > > > > > > > > > > honestly don't like much of that "adi,ad5529r-bus" co=
mpatible I wondered
> > > > > > > > > > > about solving this at the spi level.
> > > > > > > > > > >=20
> > > > > > > > > > > Ah and to make it more annoying, we can also mix 12 a=
nd 16 bits variants
> > > > > > > > > > > together in the same bus.
> > > > > > > > > > I'm definitely missing something, because that property=
 for the
> > > > > > > > > > microchip devices is not impacted what else is on the b=
us. AFAICT, you
> > > > > > > > > > could have an mcp3911 and an mcp3564 on the same bus ev=
en though both
> > > > > > > > > > are completely different devices with different drivers=
=2E They have
> > > > > > > > > > individual device nodes and their own supplies etc etc.=
 These aren't
> > > > > > > > > > per-channel properties on an adc or dac, they're per ch=
ild device on a
> > > > > > > > > > spi bus.
> > > > > > > > > Maybe I'm the one missing something :). IIRC, spi would n=
ot allow two
> > > > > > > > > devices on the same CS right? Because for this chip we wo=
uld need
> > > > > > > > > something like:
> > > > > > > > >=20
> > > > > > > > > spi {
> > > > > > > > > 	dac@0 {
> > > > > > > > > 		reg =3D <0>;
> > > > > > > > > 		adi,pin-id =3D <0>;
> > > > > > > > > 	};
> > > > > > > > >=20
> > > > > > > > > 	dac@1 {
> > > > > > > > > 		reg =3D <0>; // which seems already problematic?
> > > > > > > > > 		adi,pin-id <1>;
> > > > > > > > > 	};
> > > > > > > > >=20
> > > > > > > > > 	...
> > > > > > > > >=20
> > > > > > > > > 	//up to 4
> > > > > > > > > };
> > > > > > > > Yeah. It's not clear to me how that works for the microchip=
 devices
> > > > > > > > (I suspect it doesn't!)
> > > > > > > >=20
> > > > > > > > Just thinking as I type, but could we do something a bit na=
sty with
> > > > > > > > a gpio mux that doesn't actually switch but represents the =
GPIO being
> > > > > > > > shared?  Given this is all tied to the spi bus that should =
all happen
> > > > > > > > under serializing locks.
> > > > > > > >=20
> > > > > > > > Agreed though that this would be nicer as an SPI thing that=
 let
> > > > > > > > us specify that a single CS is share by multiple devices an=
d their
> > > > > > > > is some other signal acting to select which one we are talk=
ing to.
> > > > > > > If the device-addressing on the same chip-select is to be han=
dled
> > > > > > > by the spi framework, wouldn't we lose device-specific featur=
es?
> > > > > > >=20
> > > > > > > I understand that this multi-device feature is there mostly t=
o extend the
> > > > > > > channel count from 16 to 32, 48 or 64. I suppose the command:
> > > > > > >=20
> > > > > > > 	"MULTI DEVICE SW LDAC MODE"
> > > > > > >=20
> > > > > > > exists so that software can update channel values accross mul=
tiple devices.
> > > > > > Right! You do have a point! I agree the main driver for a featu=
re like
> > > > > > this is likely to extend the channel count and effectively "agg=
regate"
> > > > > > devices.
> > > > > >=20
> > > > > > But I would say that even with the spi solution the MULTI DEVIC=
E stuff
> > > > > > should be doable (as we still need a sort of adi,pin-id propert=
y).
> > > > > I don't think we can have something like an IIO buffer shared by =
multiple
> > > > > devices. Synchronizing separate devices would be doable with prop=
er hardware
> > > > > support for this (probably involving an FGPA).
> > > > True!
> > > > > > But yes, I do feel that the whole feature is for aggregation so=
 seeing
> > > > > > one device with 32 channels is the expectation here? Rather tha=
n seeing
> > > > > > two devices with 16 channels.
> > > > > Yes, I think aggregation is the whole point there... so that the =
IIO driver
> > > > > is multi-device-aware.
> > > > Which makes me feel that different pins per device might be possible
> > > > from an HW point of view but does not make much sense. For example,=
 for
> > > > the buffer example I would expect LDAC to be shared between all the
> > > > devices.
> > > That is why I would still suggest the multi-dac node in the middle...
> > > the parent node can hold shared resources, while the dac children can
> > > have their own, overriding or inheriting stuff.
> > >=20
> > Before going down that path I'd want confirmation this is something we
> > actually think anyone will build.
> >=20
> > Jonathan
>=20
> To directly answer your question- we currently do not have a platform tha=
t supports multi device topology with independent supplies or reset lines.
> Given that, I agree to start with the parallel wiring assumption and defe=
r per chip resource variation under there is a solid use case. I will also =
drop the "adi,resolution" proposal and proceed with "adi,device-addrs" in t=
he AD5529R binding.
> With all of the above, the proposed binding for the multi-device follow u=
p series would look like:
>=20
>=20
>     dac@0 {
>         compatible =3D "adi,ad5529r-16";
>         reg =3D <0>;
>         adi,device-addrs =3D <0 1>;

I think this should be put in the channel itself and made generic.

>         reset-gpios =3D <&gpio0 87 GPIO_ACTIVE_LOW>;
>         vdd-supply  =3D <&vdd_reg>;
>         hvdd-supply =3D <&hvdd_reg>;
>=20
>         channel@0  { reg =3D <0>;  adi,output-range-microvolt =3D <0 5000=
000>; };
>         channel@16 { reg =3D <16>; adi,output-range-microvolt =3D <0 4000=
0000>; };
>     };
>=20
> Does this look reasonable to everyone?
>=20
> Regards,
> Janani Sunil
>=20

--nH1FK7ntrWpuYvHj
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCajwGmgAKCRB4tDGHoIJi
0goAAP9cZ9BUIVklWBkTl2yFn9OyT5OW5h9pOIvF++VDu87oaQD/eq2pzi/ZEzGS
luZXxjNq8b2bUuy10IdKIXqzfhArbAo=
=d40l
-----END PGP SIGNATURE-----

--nH1FK7ntrWpuYvHj--
