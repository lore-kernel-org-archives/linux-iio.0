Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793838194;
	b=R1t3bg1/VW6bjS6Qod859v5e5PFOXpg80MpZAtHV+1ZK4wzgKwyO5GNYdXR9853OgHxo
	 LpOpGsY9cvQr1apeS8ToKlEntY7YSUFuGV0aAVQCS695cckEWngDPEx2tGDbk1oRTR1n5
	 YdxQnDb/d9CSpwT4qmAQmBu/T1vgBeaOP7fsqoXlM004uOybw3sSoBldUadV8m5JSuFPZ
	 bkKY/C9Iz40YVLL/Stf0nMHSEIkwPwxmaJRjUVU5mPdfML++2+RT7Bd/YjbIk4+T2rkzO
	 SMs2o4mJxQx+n7b1Dwk1lQh7N/XKjWZ8J5EF5HQIJbSMPqYdULXMqLXuWoZCNaFFfLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793838194;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=G/GgkrKdXMKKX27qcIVOvVckFZk3QBrPBjY7nunH4SY=;
	b=dL/7GJvMzMh7AtKrEpm8WHUS4egwBeyRhtnZZH735zs0nqYbLrhwSnh955++11fG0G+R
	 FQQ6sgP5p7wGzkuyg8SqvosN8T346fhWlCGESjw7b7X/2dABigphZJqJqgJtPtWDiZ34Y
	 oLsKzvOq0HtjgHRG3dbsEvvmRqq39g0q06kMYdTBzU/EN/lzFNQjIBxbSQTTqe4K8qv1n
	 /v/O4sak52m4Z+aPSLLEhRDTTXSStI3YOt7UZbtGNB6Le8Kce/s3daDwUyKm7fRcxZcW5
	 wO4IgwThrWHU3yHh4OlQeFJn8G6dS34/M8t2N2tx8NNhCAv3H5/z+t/gvpBPTvTEcuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TjfleZhz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36965606A326;
	Thu,  5 Nov 2026 00:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TjfleZhz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B762A1F000C1;
	Thu,  5 Nov 2026 00:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793838194;
	bh=G/GgkrKdXMKKX27qcIVOvVckFZk3QBrPBjY7nunH4SY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TjfleZhzN+mAoPhY7nSomGHREMnPPDGdYQ/5h1DWbd0kTlHDH+ZZ8PQjZoiXeeasG
	 cQOQ3xp2/aXyuZSFIFa07Tm5PM/nT9pMWsvhRVbXWv4nVC5MkYsptL/POCRfBDg2bE
	 TiVIpwGybN7ifKn34gX4/3zCEmhoznMbg6fgpzlUBbRQr6EkOFdb0QKXhRsvbL+fUu
	 8QhkAQpOV178wRyNaIsmltbylfu+ToJZZXO2XZwqch75uHikceV7ppCjSdowwFX7QX
	 5q2Jey/gGK+WEZLfO8XTXkCOMke35rf8xQE37wU1PGFRGItc62CsxC3ff9zsDT/2oh
	 weO86NLynjt6g==
Date: Thu, 5 Nov 2026 00:23:08 +0000
From: Conor Dooley <conor@kernel.org>
To: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Joshua Crofts <crofts@kernel.org>,
	Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-pwm@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] dt-bindings: iio: adc: adi,ad7625: add LTC2387
 and ADAQ2387x
Message-ID: <20261105-domestic-seminar-a5899614d882@spud>
References: <20261104132143.215581-1-Nicolae-daniel.Deaconescu@analog.com>
 <20261104132143.215581-5-Nicolae-daniel.Deaconescu@analog.com>
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
	protocol="application/pgp-signature"; boundary="ROJN7Ub5gSfSxiiY"
Content-Disposition: inline
In-Reply-To: <20261104132143.215581-5-Nicolae-daniel.Deaconescu@analog.com>

--ROJN7Ub5gSfSxiiY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 04, 2026 at 03:21:42PM +0200, Nicolae-Daniel Deaconescu wrote:
> From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
>=20
> Add the LTC2387-16, LTC2387-18, ADAQ23875, ADAQ23876 and ADAQ23878 to the
> binding. They are single channel differential ADCs like the AD762x and
> AD796x and are read the same way: CNV and CLK are driven by two PWMs and
> the LVDS data is captured by an AXI ADC. They differ in what is around the
> converter:
>=20
> - Their output is double data rate on one or two lanes, selected by the
>   TWOLANES pin, described by adi,use-two-lanes.
> - They have no EN pins, and no clocks property, because the PWM provider
>   reports the clock its waveforms are derived from. The second PWM is nam=
ed
>   clk, as that is the pin it drives, where the AD762x and AD796x name it
>   clk_gate.
> - The supplies are VDD, VDDL and OVDD on the LTC2387, and VDD, VIO, VS+ a=
nd
>   VS- on the ADAQ modules.
> - The ADAQ modules have a fully differential amplifier in front of the AD=
C.
>   Its gain is fixed on the ADAQ23875 and set by pin strapping on the
>   ADAQ23876 and ADAQ23878, described by adi,gain-milli.
>=20
> The properties and supplies of the two groups of parts are made exclusive.
> The gain is described in the devicetree as the pin strapping can't be read
> from the part. There is no fallback compatible, as a driver for one of the
> existing parts would read these wrongly: their output is double data rate
> and has other timing limits.
>=20
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> Co-developed-by: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@ana=
log.com>
> Signed-off-by: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analo=
g.com>
> ---
>  .../bindings/iio/adc/adi,ad7625.yaml          | 193 +++++++++++++++++-
>  1 file changed, 184 insertions(+), 9 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7625.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad7625.yaml
> index 8848562af28f..dbdded88236c 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7625.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7625.yaml
> @@ -4,7 +4,7 @@
>  $id: http://devicetree.org/schemas/iio/adc/adi,ad7625.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
> =20
> -title: Analog Devices Fast PulSAR Analog to Digital Converters
> +title: Analog Devices Fast PulSAR, LTC2387 and ADAQ2387x Analog to Digit=
al Converters
> =20
>  maintainers:
>    - Michael Hennerich <Michael.Hennerich@analog.com>
> @@ -17,6 +17,11 @@ description: |
>    * https://www.analog.com/en/products/ad7626.html
>    * https://www.analog.com/en/products/ad7960.html
>    * https://www.analog.com/en/products/ad7961.html
> +  * https://www.analog.com/en/products/ltc2387-16.html
> +  * https://www.analog.com/en/products/ltc2387-18.html
> +  * https://www.analog.com/en/products/adaq23875.html
> +  * https://www.analog.com/en/products/adaq23876.html
> +  * https://www.analog.com/en/products/adaq23878.html
> =20
>  properties:
>    compatible:
> @@ -25,14 +30,37 @@ properties:
>        - adi,ad7626
>        - adi,ad7960
>        - adi,ad7961
> +      - adi,adaq23875
> +      - adi,adaq23876
> +      - adi,adaq23878
> +      - adi,ltc2387-16
> +      - adi,ltc2387-18
> =20
>    vdd1-supply: true
>    vdd2-supply: true
>    vio-supply: true
> =20
> +  vdd-supply:
> +    description: 5V analog power supply (VDD), LTC2387 and ADAQ parts on=
ly.
> +
> +  vddl-supply:
> +    description: 2.5V analog power supply (VDDL), LTC2387 parts only.
> +
> +  ovdd-supply:
> +    description: 2.5V output power supply (OVDD), LTC2387 parts only.
> +
> +  vs-p-supply:
> +    description: Amplifier positive supply (VS+), ADAQ parts only.
> +
> +  vs-n-supply:
> +    description:
> +      Amplifier negative supply (VS-), ADAQ parts only. Leave it out if =
VS-
> +      is tied to ground.
> +
>    ref-supply:
>      description:
> -      Voltage regulator for the external reference voltage (REF).
> +      Voltage regulator for the external reference voltage (REF, or REFB=
UF
> +      on the LTC2387 and ADAQ2387x).
> =20
>    refin-supply:
>      description:
> @@ -40,18 +68,23 @@ properties:
> =20
>    clocks:
>      description:
> -      The clock connected to the CLK pins, gated by the clk_gate PWM.
> +      The clock connected to the CLK pins, gated by the clk_gate PWM. Not
> +      described for the LTC2387 and ADAQ parts.
>      maxItems: 1
> =20
>    pwms:
>      items:
>        - description: PWM connected to the CNV input on the ADC.
> -      - description: PWM that gates the clock connected to the ADC's CLK=
 input.
> +      - description:
> +          PWM that gates the clock connected to the ADC's CLK input, so =
that
> +          it sees the burst of pulses for each conversion. It is named
> +          clk_gate for the AD762x and AD796x, and clk for the LTC2387 and
> +          ADAQ2387x.
> =20
>    pwm-names:
>      items:
>        - const: cnv
> -      - const: clk_gate
> +      - enum: [clk_gate, clk]
> =20
>    io-backends:
>      description:
> @@ -91,6 +124,23 @@ properties:
>        Indicates if EN3 is hard-wired to the high state. If neither this
>        nor en3-gpios are present, then EN3 is hard-wired low.
> =20
> +  adi,use-two-lanes:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Describes whether the TWOLANES pin of an LTC2387 or ADAQ part is s=
et
> +      high, selecting two-lane LVDS output, or low, selecting one-lane
> +      output (the default).
> +
> +  adi,gain-milli:
> +    description:
> +      Gain of the fully-differential amplifier that the ADAQ modules
> +      integrate ahead of the LTC2387 die, expressed as gain * 1000. It is
> +      fixed on the ADAQ23875 and set by pin strapping on the ADAQ23876 a=
nd
> +      ADAQ23878, so it must match the board. Not allowed on the ADAQ2387=
5,
> +      whose gain is fixed at 2.
> +    $ref: /schemas/types.yaml#/definitions/uint16
> +    enum: [370, 730, 870, 1380, 2250]
> +
>    en0-gpios:
>      description:
>        Configurable EN0 pin.
> @@ -109,10 +159,6 @@ properties:
> =20
>  required:
>    - compatible
> -  - vdd1-supply
> -  - vdd2-supply
> -  - vio-supply
> -  - clocks
>    - pwms
>    - pwm-names
>    - io-backends
> @@ -157,6 +203,111 @@ allOf:
>          - required: [ref-supply]
>          - required: [refin-supply]
> =20

> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - adi,ad7625
> +              - adi,ad7626
> +              - adi,ad7960
> +              - adi,ad7961
> +    then:
> +      properties:
> +        pwm-names:
> +          items:
> +            - const: cnv
> +            - const: clk_gate
> +        vdd-supply: false
> +        vddl-supply: false
> +        ovdd-supply: false
> +        vs-p-supply: false
> +        vs-n-supply: false
> +        adi,use-two-lanes: false
> +        adi,gain-milli: false
> +      required:
> +        - vdd1-supply
> +        - vdd2-supply
> +        - vio-supply
> +        - clocks
> +    else:
> +      # The LTC2387 and ADAQ parts have no EN pins and no clock to descr=
ibe.
> +      properties:
> +        pwm-names:
> +          items:
> +            - const: cnv
> +            - const: clk
> +        vdd1-supply: false
> +        vdd2-supply: false
> +        clocks: false
> +        # REFIN is the bandgap output and the input of the reference buf=
fer.
> +        # An external reference goes to REFBUF, through ref-supply.
> +        refin-supply: false
> +        en0-gpios: false
> +        en1-gpios: false
> +        en2-gpios: false
> +        en3-gpios: false
> +        adi,en0-always-on: false
> +        adi,en1-always-on: false
> +        adi,en2-always-on: false
> +        adi,en3-always-on: false
> +        adi,no-dco: false
> +      required:
> +        - vdd-supply

Honestly, when the devices are this different, I don't think having a
shared binding is worth it. Shared driver perhaps, but when so many
properties don't apply the things should be kept in different binding
files I think, this is just confusingly different IMO.

Thanks for sorting out the clocks thing though.

Conor.

> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - adi,ltc2387-16
> +              - adi,ltc2387-18
> +    then:
> +      properties:
> +        vio-supply: false
> +        vs-p-supply: false
> +        vs-n-supply: false
> +        adi,gain-milli: false
> +      required:
> +        - vddl-supply
> +        - ovdd-supply
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - adi,adaq23875
> +              - adi,adaq23876
> +              - adi,adaq23878
> +    then:
> +      properties:
> +        vddl-supply: false
> +        ovdd-supply: false
> +      required:
> +        - vio-supply
> +        - vs-p-supply
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: adi,adaq23875
> +    then:
> +      properties:
> +        adi,gain-milli: false
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - adi,adaq23876
> +              - adi,adaq23878
> +    then:
> +      required:
> +        - adi,gain-milli
> +
>  additionalProperties: false
> =20
>  examples:
> @@ -174,3 +325,27 @@ examples:
>          en0-gpios =3D <&gpio0 86 GPIO_ACTIVE_HIGH>;
>          en1-gpios =3D <&gpio0 87 GPIO_ACTIVE_HIGH>;
>      };
> +  - |
> +    adc {
> +        compatible =3D "adi,ltc2387-16";
> +        io-backends =3D <&axi_adc>;
> +        ovdd-supply =3D <&supply_2_5V>;
> +        pwms =3D <&axi_pwm_gen 0 0 0>, <&axi_pwm_gen 1 0 0>;
> +        pwm-names =3D "cnv", "clk";
> +        ref-supply =3D <&supply_4_096V>;
> +        vdd-supply =3D <&supply_5V>;
> +        vddl-supply =3D <&supply_2_5V>;
> +    };
> +  - |
> +    adc {
> +        compatible =3D "adi,adaq23878";
> +        io-backends =3D <&axi_adc>;
> +        pwms =3D <&axi_pwm_gen 0 0 0>, <&axi_pwm_gen 1 0 0>;
> +        pwm-names =3D "cnv", "clk";
> +        vdd-supply =3D <&supply_5V>;
> +        vio-supply =3D <&supply_2_5V>;
> +        vs-n-supply =3D <&supply_0V>;
> +        vs-p-supply =3D <&supply_5V>;
> +        adi,gain-milli =3D /bits/ 16 <870>;
> +        adi,use-two-lanes;
> +    };
> --=20
> 2.34.1
>=20

--ROJN7Ub5gSfSxiiY
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCauvMbAAKCRB4tDGHoIJi
0i10AQD/tNisJywPmYC8U477uiHkiKqvDIqD9qHn8joLigTBwAEA3D/r1NmAHU9Y
Miz0fVKmQ8Oicn+94n9XdF0YZziMBg0=
=KgFr
-----END PGP SIGNATURE-----

--ROJN7Ub5gSfSxiiY--
