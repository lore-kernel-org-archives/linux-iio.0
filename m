Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D7C1F03DE;
	Sun, 16 Aug 2026 18:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786904657; cv=none; b=KpVuHBUI/CFEd4o8+NTXLX2e6YRg8AYgcv2HhnDAbBQ4AvsyjGcX+tm4qf2kmq9MuOHcKvL+Mje2eGyPFvrpp6DpOZbYIyV2w2Kt3qKXhyYbCNAWFiDRQxr8VD68dRV/7C0rwkDVEopnMn6+wv9FKQkJgHZ+Yn7IZYHvOre+XgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786904657; c=relaxed/simple;
	bh=2cGfAPQGO3AjnvfTy1XMbEugMrgsxE1q+wP4hh6B/Ls=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rxeFXnR+14aEp5s8jydFn/QJ/dekIDVz9da78CEu6lreGJ6VnPY+x2aOwpUlMqVxUe17j1SnlDvJjTeIa/+I6Ah2dEoSA4Qhftzsem/KsjNbiSQoG3uhfFiICiqJNrt6otgsREa00rMoQ8etGOw0rAWyqqT/E2hZJfLA7IO/jsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j0+bcFby; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j0+bcFby"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EECC81F000E9;
	Sun, 16 Aug 2026 18:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786904655;
	bh=i1K/xJf04/uyFrses124GIJfdpSPcMte5V3FuSbHXZQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=j0+bcFbyTRTwecTJeG+COCfT2/QGLlvyinLDzD4LufKNdzkg/Kv8YXxwBOG1sHjce
	 aKvmyTe7cdkgmyD6Bh6jvDYxk0r2xKpK5jqWPvIy1yi1Wq+RmYvSwcN0+GWpyS1fWy
	 rF8JDfwuAP8GNYYj5UXUzJ5JKVvelQpqCrERYUv9SL0utj8/pZkIul+MNCVlkBFWR4
	 7gCw7QXHHT6UY4aaQhBk2NxiY/5zu+BSPD+PubwNkPLF/fFameKRb549X0vPIDCzkf
	 1VAsk7PJAvbbcbQZCN79d16nTvb9dbETPPcnM+0VawNR74pRQ8MbzOGv2sTBvl1meI
	 v49XEQ0sGz0yw==
Date: Sun, 16 Aug 2026 19:24:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Janani Sunil <janani.sunil@analog.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Olivier
 Moysan <olivier.moysan@foss.st.com>, Philipp Zabel
 <p.zabel@pengutronix.de>, Linus Walleij <linusw@kernel.org>, Bartosz
 Golaszewski <brgl@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Michael Walle <mwalle@kernel.org>,
 <linux@analog.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <jananisunil.dev@gmail.com>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v3 01/14] dt-bindings: iio: adc: Add AD7768
Message-ID: <20260816192409.145df670@jic23-huawei>
In-Reply-To: <20260813-ad7768-driver-v3-1-cb554399ad26@analog.com>
References: <20260813-ad7768-driver-v3-0-cb554399ad26@analog.com>
	<20260813-ad7768-driver-v3-1-cb554399ad26@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 13 Aug 2026 15:56:54 +0200
Janani Sunil <janani.sunil@analog.com> wrote:

> Devicetree Bindings for AD7768-4 (4 channel) and AD7768 (8 channel)
> simultaneous sampling ADCs.
>=20
> Signed-off-by: Janani Sunil <janani.sunil@analog.com>
> ---
>  .../devicetree/bindings/iio/adc/adi,ad7768.yaml    | 338 +++++++++++++++=
++++++
>  MAINTAINERS                                        |   7 +
>  2 files changed, 345 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7768.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad7768.yaml
> new file mode 100644
> index 000000000000..54241436f47f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7768.yaml
> @@ -0,0 +1,338 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,ad7768.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD7768 and AD7768-4 ADC
> +
> +maintainers:
> +  - Janani Sunil <janani.sunil@analog.com>
> +
> +description: |
> +  The AD7768 is an 8-channel, 24-bit simultaneous sampling ADC with conf=
igurable
> +  power and performance modes. The AD7768-4 is a 4-channel version.
> +
> +  This binding covers SPI mode only (register access via SPI). Pin contr=
ol mode,
> +  where configuration is set via hardware pins rather than SPI registers=
, is not
> +  supported.
> +
> +  The io-backend represents the high-speed data output interface, consum=
ing the
> +  DOUTx data lines, DCLK (data clock), and DRDY (data ready) signals.
> +
> +  Datasheet at:
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
ad7768.pdf
> +
> +  HDL reference design:
> +    https://github.com/analogdevicesinc/hdl/tree/main/projects/ad7768evb
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad7768
> +      - adi,ad7768-4
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +    description:
> +      Master clock (MCLK). Can be supplied as a CMOS clock on the XTAL2/=
MCLK
> +      pin, a crystal oscillator connected between the XTAL1 and XTAL2 pi=
ns, or
> +      an LVDS differential clock on the XTAL1/XTAL2 pin pair. The clock =
source
> +      is selected by the CLK_SEL hardware pin.

This left me with the question of how 1 pin selects between 3 modes.
So I had a look at the rather extensive datasheet section on this.
No explicit binding works fine for CMOS as that is purely a pinstrap.
I think we need more for LVDS vs XTAL given there are rules around
needing to keep a channel enabled to keep the XTAL excitation on and
the LVDS rules are even more complex.

So I think we need the binding to provide the info on what the clock actual=
ly
is somewhere.  We have in the past done this with clock-names,
that might work here as well or we may need more than that.

For background here is an example

To enable the LVDS clock, there are two options. Set GPIO4
to an output, then writing to the LVDS bit field in the POWER_
CLOCK register enables the LVDS clock. Or, set GPIO4 to an
input. Then GPIO4 must be tied to Logic 0. An SPI write to Bit 3
of Register 0x04 enables the LVDS clock option and disables the
crystal excitation circuitry.
The following steps must be carried out to enable LVDS clocking to
be used:
  1. Set the CLK_SEL pin to Logic 1.
  2. Set the FILTER/GPIO4 pin (Pin 11) to Logic 0. This disables the
     crystal excitation circuitry.
  3. Power up the AD7768 with no external clock applied. Initially, it
     will run off the internal clock for SPI writes until Step 4 and Step
     5 have been carried out.
  4. Enable this option by writing to the LVDS_Enable bit (Bit 3) in
     the Power_Mode register (Register 0x04).
  5. Apply the LVDS signals on Pin 31 and Pin 32.


> +
> +  avdd1-supply:
> +    description:
> +      Analog supply voltage for the AVDD1A and AVDD1B pins (5V =C2=B1 10=
% with
> +      respect to AVSS). Powers the analog front end, reference input, and
> +      common-mode output circuitry. Both pins must be tied to the same
> +      potential.
> +
> +  avss-supply:
> +    description:
> +      Negative analog supply rail for the AVSS1A, AVSS1B, AVSS2A, AVSS2B,
> +      and AVSS pins. This rail is referenced to DGND and all AVSS pins m=
ust
> +      be tied to the same potential. In single-supply operation AVSS is
> +      nominally 0V; in split-supply operation it can range from 0V to
> +      -2.75V with respect to DGND.

Where there is a nominal ground option, a common thing to do is to
make the supply optional - with it absence meaning we can assume 0V.

> +
> +  ref1-supply:
> +    description:
> +      Differential reference voltage supply for the REF1+/REF1- input pa=
ir.
> +      REF1+ voltage range is from (AVSS + 1V) to AVDD1; REF1- voltage ra=
nge
> +      is from AVSS to (AVDD1 - 1V). The differential reference voltage r=
ange
> +      is 1V to |AVDD1 - AVSS|. On the AD7768 this reference is used for
> +      channels 0 to 3; on the AD7768-4 for channels 0 and 1.
Given we want to provide offsets from nominal ground and that there is no
statement that the reference supplies are symmetric, I'd expect them to be =
split
into a pair of supplies, one for positive and one for negative.

(unless I'm missing a statement about symmetry in which case a single suppl=
y is
fine).

> +
> +  ref2-supply:
> +    description:
> +      Differential reference voltage supply for the REF2+/REF2- input pa=
ir.
> +      REF2+ voltage range is from (AVSS + 1V) to AVDD1; REF2- voltage ra=
nge
> +      is from AVSS to (AVDD1 - 1V). The differential reference voltage r=
ange
> +      is 1V to |AVDD1 - AVSS|. On the AD7768 this reference is used for
> +      channels 4 to 7; on the AD7768-4 for channels 2 and 3.


> +  adi,data-lines-number:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [1, 2, 4, 8]
> +    description:
> +      Number of DOUTx lines used for the high-speed data output interface
> +      (distinct from the SPI control interface). AD7768 supports 1, 2, o=
r 8
> +      lines; AD7768-4 supports 1 or 4 lines. Defaults to the maximum num=
ber
> +      of lines for the selected variant if omitted.

The default statement is a bit hidden and I'm not sure useful as it's not
an obvious default.  Maybe drop that and make this a required property?

...

> +patternProperties:
> +  "^channel@[0-7]$":
> +    type: object
> +    description: |

Don't think the | is useful on this one ads no real formatting to preserve

> +      Represents the external channels which are connected to the device.
> +      AD7768 supports channels 0-7, AD7768-4 supports channels 0-3.

...

> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    spi {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        adc@0 {
> +            compatible =3D "adi,ad7768";
> +            reg =3D <0>;
> +            spi-max-frequency =3D <1000000>;
> +
> +            avdd1-supply =3D <&avdd1_regulator>;
> +            avss-supply =3D <&avss_regulator>;
> +            avdd2-supply =3D <&avdd2_regulator>;
> +            iovdd-supply =3D <&iovdd_regulator>;
> +            ref1-supply =3D <&ref1_regulator>;
> +            ref2-supply =3D <&ref2_regulator>;
> +            reset-gpios =3D <&gpio0 86 GPIO_ACTIVE_LOW>;
> +
> +            clocks =3D <&ad7768_mclk>;
> +
> +            adi,data-lines-number =3D <8>;
> +            gpio-controller;
> +            #gpio-cells =3D <2>;
> +
> +            io-backends =3D <&iio_backend>;
> +
> +            #address-cells =3D <1>;
> +            #size-cells =3D <0>;
> +
> +            channel@0 {
> +                reg =3D <0>;
> +                adi,prechargebuf-pos-enable;
> +                adi,refbuf-pos-enable;
> +            };
> +
> +            channel@1 {
> +                reg =3D <1>;
> +                adi,prechargebuf-pos-enable;
> +                adi,prechargebuf-neg-enable;
> +                adi,refbuf-pos-enable;
> +                adi,refbuf-neg-enable;
> +            };
> +
> +            channel@7 {
> +                reg =3D <7>;
> +                adi,prechargebuf-pos-enable;
> +                adi,refbuf-pos-enable;
> +            };
> +        };
> +    };
> +
> +  - |

To me the second example doesn't add much value as it is very similar
to the first. Either drop it or see if there is value in illustrating
different things with another example.

> +    spi {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        adc@1 {
> +            compatible =3D "adi,ad7768-4";
> +            reg =3D <1>;
> +            spi-max-frequency =3D <1000000>;
> +
> +            avdd1-supply =3D <&avdd1_regulator>;
> +            avss-supply =3D <&avss_regulator>;
> +            avdd2-supply =3D <&avdd2_regulator>;
> +            iovdd-supply =3D <&iovdd_regulator>;
> +            ref1-supply =3D <&ref1_regulator>;
> +            ref2-supply =3D <&ref2_regulator>;
> +
> +            clocks =3D <&ad7768_mclk>;
> +
> +            adi,data-lines-number =3D <4>;
> +
> +            io-backends =3D <&iio_backend>;
> +
> +            #address-cells =3D <1>;
> +            #size-cells =3D <0>;
> +
> +            regulators {
> +                vcm-output {
> +                    regulator-name =3D "vcm-output";
> +                    regulator-min-microvolt =3D <2140000>;
> +                    regulator-max-microvolt =3D <2140000>;
> +                    regulator-always-on;
> +                };
> +            };
> +
> +            channel@0 {
> +                reg =3D <0>;
> +                adi,prechargebuf-pos-enable;
> +                adi,refbuf-pos-enable;
> +            };
> +
> +            channel@3 {
> +                reg =3D <3>;
> +                adi,prechargebuf-pos-enable;
> +                adi,refbuf-pos-enable;
> +            };
> +        };
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2b1ec46c5919..d667a0411f28 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1633,6 +1633,13 @@ F:	Documentation/devicetree/bindings/iio/adc/adi,a=
d7768-1.yaml
>  F:	drivers/iio/adc/ad7768-1.c
>  F:	include/dt-bindings/iio/adc/adi,ad7768-1.h
> =20
> +ANALOG DEVICES INC AD7768 DRIVER
> +M:	Janani Sunil <janani.sunil@analog.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Supported
> +W:	https://ez.analog.com/linux-software-drivers
> +F:	Documentation/devicetree/bindings/iio/adc/adi,ad7768.yaml
> +
>  ANALOG DEVICES INC AD7780 DRIVER
>  M:	Michael Hennerich <Michael.Hennerich@analog.com>
>  M:	Renato Lui Geh <renatogeh@gmail.com>
>=20

