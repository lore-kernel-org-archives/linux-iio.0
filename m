Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A548D225788;
	Thu, 11 Jun 2026 12:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781180168; cv=none; b=icrs8NaEvO2R2d36pqmDij98s2i2uBkRUgxT6B/ecghLQDZtRcnVk0Nn8IowK0mAC/9+2mwLgNqRcyKdllNtjHVc3/udeT+asR/v5ME9uajaK+FuYto781FyKd64Elf3QhZISVlSq28HTBG3SRo17XCVKuZLdmKMq3OodlT6lKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781180168; c=relaxed/simple;
	bh=/E9CebWIsdqXHLkmNQBEPYXj7Q0HHdb/sq2JvQF1U+c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sldxO/5nefeg4SVyLY/++//KZlAmNvzUXhsvKQ7U4uBCkmlA85PZo1TQoDm6zMvdaNS6mHbFWyiegpOXfR4bBAt1/uOql2aSSNKl+0II9fDALX9myPhxnrU4JfQb0gq+2gMquQ9/adQ50QnCS68jhhwGaBStiR/OTPbS5sKd33Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XB1h+NKK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XB1h+NKK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73D231F00898;
	Thu, 11 Jun 2026 12:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781180167;
	bh=XjeIm4jYdWHpNXpVmG1qtgMAtZQ4g7WyebQszvH0RiU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=XB1h+NKKSOKABEI+dx5vxX1qeXHhwSUTBQESRkuP3q0leydJB1eyFACqOQYCtOa5L
	 xvb9O8Y7ZDuqZgaNSOBBLyhVkOUJ+R9kuW2+xN/Y2dQg74zw+FvbwK4ica5tLn55jY
	 MA/zHYpbupHRKL1/8zb1NiVlKvsD6gr46HgQXsnVBtKKQl1Mx05hEDqGiM5E3g27lV
	 1IUEdO3Q+l0HUT2p8r0VlHXvm23VGXAdrh+VjTJhRVA0oLiim4B+TX9fpC4/kqB31f
	 jqPlxSdsVX98qU0gFA7suKm10DmmHe29FQNtYj9s4i7ROTByb4HkWkHJF0vo5fKASx
	 ZKxp4naUvcAPg==
Date: Thu, 11 Jun 2026 13:15:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nguyen Minh Tien <zizuzacker@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: Add TI ADS1220
Message-ID: <20260611131558.7a604407@jic23-huawei>
In-Reply-To: <20260610151342.44274-2-zizuzacker@gmail.com>
References: <20260610151342.44274-1-zizuzacker@gmail.com>
	<20260610151342.44274-2-zizuzacker@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jun 2026 22:13:41 +0700
Nguyen Minh Tien <zizuzacker@gmail.com> wrote:

> The ADS1220 is a 24-bit, 2-kSPS, 4-channel delta-sigma ADC from Texas
> Instruments with an SPI (mode 1) interface, a programmable gain amplifier,
> an internal 2.048V reference and a dedicated DRDY data-ready output.
> 
> Add a device tree binding describing the SPI device and its per-input
> channel child nodes (single-ended AINx or the multiplexer's differential
> pairs), the optional external/AVDD reference selection and the DRDY
> interrupt.
> 
> Signed-off-by: Nguyen Minh Tien <zizuzacker@gmail.com>

Given Andy asked the big questions, I'll focus in on what is here
with assumption there is a good reason this can't be merged with existing
driver and / or binding.  Note that it is fine to combine bindings but not
drivers, or indeed the other way around.

There are some interesting complex corners on this device - such as the RTD
configurations (current outputs on what would otherwise be input channels).
It might be worth looking at some of the other RTD supporting sensors
in tree and how their bindings are done.  The bridge setup is also
a little interesting as we need to know to enable the bypass of AIN3 to
AVSS.

Normally we strongly push for a binding to be complete as possible from
the start, even if the driver doesn't support some features yet but
here that may make it more complex.

Just a couple of comments below

Thanks,

Jonathan



> ---
>  .../bindings/iio/adc/ti,ads1220.yaml          | 146 ++++++++++++++++++
>  1 file changed, 146 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads1220.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1220.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads1220.yaml
> new file mode 100644
> index 000000000..1fedffc2a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1220.yaml
> @@ -0,0 +1,146 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/ti,ads1220.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments ADS1220 ADC
> +
> +maintainers:
> +  - Nguyen Minh Tien <zizuzacker@gmail.com>
> +
> +description:
> +  The TI ADS1220 is a precision 24-bit, 2-kSPS, delta-sigma ADC with an SPI
> +  (mode 1) interface. It provides two differential or four single-ended inputs
> +  through a multiplexer, a programmable gain amplifier (gain 1 to 128), an
> +  internal 2.048V reference and oscillator, two programmable excitation current
> +  sources and a 50/60Hz rejection filter. A dedicated DRDY output signals when a
> +  new conversion result is available.

Ideally put a datasheet reference in this description.

> +
> +properties:
> +  compatible:
> +    const: ti,ads1220
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-cpha: true
> +
> +  interrupts:
> +    description: DRDY pin, signals that a new conversion result is ready.
> +    maxItems: 1
> +
> +  avdd-supply:
> +    description: Analog power supply (AVDD/AVSS).
> +
> +  dvdd-supply:
> +    description: Digital power supply (DVDD/DGND).
> +
> +  vref-supply:
> +    description:
> +      External reference voltage (REFP0/REFN0). If omitted, the internal
> +      2.048V reference is used unless ti,vref-avdd is set.
> +
> +  ti,vref-avdd:
> +    type: boolean
> +    description:
> +      Use the analog supply (AVDD/AVSS) as the conversion reference instead of
> +      the internal 2.048V reference. Suited to ratiometric single-supply
> +      measurements (for example a potentiometer wired across AVDD), giving a
> +      full 0..AVDD input range without an external reference. Ignored when
> +      vref-supply is present.
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +  "#io-channel-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#address-cells"
> +  - "#size-cells"
> +  - avdd-supply
> +  - dvdd-supply
> +
> +patternProperties:
> +  "^channel@[0-6]$":
> +    $ref: adc.yaml
> +    type: object
> +    description: Represents one ADC input configuration (channel).
> +
> +    properties:
> +      reg:
> +        minimum: 0
> +        maximum: 6

Why 6?  Is the idea that you might have both differential and single ended
inputs from the same physical wires, or overlapping differential
pairs? In practice that rarely reflects how boards are wired. 
However I can't immediately figure out a combination that ends up with 7 channels.

> +
> +      diff-channels:
> +        description:
> +          Differential input pair routable by the ADS1220 multiplexer.
> +        oneOf:
> +          - items: [const: 0, const: 1]
> +          - items: [const: 0, const: 2]
> +          - items: [const: 0, const: 3]
> +          - items: [const: 1, const: 2]
> +          - items: [const: 1, const: 3]
> +          - items: [const: 2, const: 3]
> +          - items: [const: 1, const: 0]
> +          - items: [const: 3, const: 2]
> +
> +      single-channel:
> +        description:
> +          Single-ended input channel AINx measured against AVSS.
> +        minimum: 0
> +        maximum: 3
> +
> +    oneOf:
> +      - required: [diff-channels]
> +      - required: [single-channel]
> +
> +    required:
> +      - reg
> +
> +    unevaluatedProperties: false
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        adc@0 {
> +            compatible = "ti,ads1220";
> +            reg = <0>;
> +            spi-max-frequency = <2500000>;
> +            spi-cpha;
> +            interrupt-parent = <&pio>;
> +            interrupts = <4 4 IRQ_TYPE_EDGE_FALLING>;
> +            avdd-supply = <&reg_vcc3v3>;
> +            dvdd-supply = <&reg_vcc3v3>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            #io-channel-cells = <1>;
> +
> +            channel@0 {
> +                reg = <0>;
> +                single-channel = <0>;
> +            };
> +
> +            channel@1 {
> +                reg = <1>;
> +                diff-channels = <0 1>;
> +            };
> +        };
> +    };
> +...

