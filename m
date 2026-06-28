Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09E3368D6E
	for <linux-iio@vger.kernel.org>; Sun, 28 Jun 2026 15:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782661525; cv=none; b=Ogvhc7ViPTE2lcUbXC0MxsXv+6tQ9Ev1MTsX3y5lShFR8+OJXOzBlxYSRQ3Mkm7uuOjTiV91yU+gcf/1628/kqaZHKDs4VLztTMIVzMmiPXZD/tWEB9LdgPrfaTtgpk6OzLd+OTj/Bj0ejj9OmYV8H2OHeeSFyg3qq69ky4FDQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782661525; c=relaxed/simple;
	bh=+H0yKek5K0Khqt7YK1gSWtncaria+1vViN2GnCBEh5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ic2qWywHb4rBIiqUnDjwZPz5bGnwMCEmuUBLvHHlqIa2YVjBAcUjVieb2/FoIqGe8yjYa/U6cJKu8PE++w3f96bp7zgjsmi8tvT8EVxf8JgWY0ZX0DDYTLRbZD/5FIK6eqEzdWGhFQQpoagwaM4bqRf7jU4q8nsqbq8/GE7QPNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=nEVqfxBQ; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="nEVqfxBQ"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7e9ccbb7aa3so462311a34.1
        for <linux-iio@vger.kernel.org>; Sun, 28 Jun 2026 08:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782661522; x=1783266322; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B2K7USod4RXr86t8YidbbXA5K/zjp7bYDsDgqEvwk0g=;
        b=nEVqfxBQ513EQV7RksntUzUCdfZcFOju8FOu75tulEFL9f2C/MiDyCCqF4SHr0u4XF
         pw5sVBqrYh9nHIuXidPwiK14+M+1pE5420Jyh1+GJMSzevVQsfQdZLlQ55VZRQ9jztUi
         W1cv+akvBuFQxvK8w+1HNU0Y+8WMCwe3yZnlUIAKbTbKGjFh0KWpdhzbqYufUNOOiYsH
         +Rf/+kBiqlvrukAaPkyiVgpCAG5c/CTgsJ0s/ODjhddutnw4c3y+oizdrUG5gfgvo/j9
         FTzoLny/uccUSXuXCM4i//JkKEFOpeWOSom2q6j2E9Vo65Ysf8ilejnRt2+8b/3AbG59
         YVfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782661522; x=1783266322;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B2K7USod4RXr86t8YidbbXA5K/zjp7bYDsDgqEvwk0g=;
        b=e+ly6YRpcCBaJdpsS98rW+Vd1MPD3tOGXCNjE0qzlVgYXvXzm2rX53yOCTMgcXNkbr
         ED+Me8ytIrmeKTF8F38odmxJpwHQ9iDE744kLFs/trwryLhiQztu2iIzg9gXFSSj2F1U
         MvHQPMnN5HywvVRlqqSt4A67Nh32qwbuDuAqD6I8TWPjIim8z6pSExK1lo3p++ydZRHW
         +Z/Y0zpyoOXxZUVZjfQELTT+AQGBeBX6ZjtKsHaJOS+uCOJIVKRnRByWelZJqKxUTccN
         atshrtUH7G6OQrrf125cSGcvd1XOX/LzlC31COOeDqmtug7fBDJ35x8AH2t68G4DILJr
         YHIQ==
X-Forwarded-Encrypted: i=1; AFNElJ9eQX/syCQe3y/ZJ/Zp0DElNU1x8krWWsfl+79zMlIHpwFPCvOxHDWqCqKpfdX8kTLpuO17cA+0AEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHWqa0PAufxQdjfG9i3eHkNKmxQljM72bB3ujhmMNvKWKLdi8L
	O5Z8h/AgaWVXWVK3AGIeUmzn9lhevZ32U0EFcsxHoCEdlwszgaRhkPCizzwCcs4MG8TrRRElauK
	ltz6h
X-Gm-Gg: AfdE7cmr9zrHi1otf8D0fZAjuLm6m9zJK/J1kRf3/KzmH+a72haFxwX/+zPq19qT7ce
	MpYjUHH36misDAiZcoPyL7sTNU06fEwxGy/HTt84qhziD3/qi7QEefz29YYr9TBq4GllDiWpilH
	NZu64HcgM6dDfNIlxgkU3X+7gbneRhmxb2GH+0EtoHa34jDNHZBnvFkHP1v2qUUnZarOsW/eV3E
	pAQlSJuH+/LnJnGYvMGJAsqe2OjVVUlp//ELBGsY5BWAlzviUQ9BIGRR1JjVlF7W8ErSgzAVYpg
	4JujT2A22vFFxpwMJils4fCVYS4D5vznoU0PMyFu9T9vwuo+qnsFLp26ehPIZmzFD3sXmQkKcyp
	uTgW0PeilzkkRDX0Gbw/sJqaLsSsKs0CQTVzNDtRemYB9lhfBI1nA4rN+wSaUOVC40HWxk5JJT1
	l8GdafXJh44todG0WQMsByj+2PnPwir3Yh3loN0/DgsH6iyBGIQ/Hw93WL/cuugY4=
X-Received: by 2002:a05:6830:25d0:b0:7dc:4a43:fb5c with SMTP id 46e09a7af769-7e99c35dc5amr13720497a34.11.1782661521763;
        Sun, 28 Jun 2026 08:45:21 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:f242:ecd6:f61e:d764? ([2600:8803:e7e4:500:f242:ecd6:f61e:d764])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e9b0f726e9sm5522893a34.26.2026.06.28.08.45.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jun 2026 08:45:21 -0700 (PDT)
Message-ID: <946a30c9-01e9-42f1-bd2b-b7934fda85cf@baylibre.com>
Date: Sun, 28 Jun 2026 10:45:20 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] dt-bindings: iio: adc: Add TI ADS126x ADC family
To: Kurt Borja <kuurtb@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260628-ads126x-v2-0-4b1b231325ba@gmail.com>
 <20260628-ads126x-v2-1-4b1b231325ba@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260628-ads126x-v2-1-4b1b231325ba@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/28/26 12:36 AM, Kurt Borja wrote:
> The ADS1262 and ADS1263 are 32-bit, 38.4-kSPS delta-sigma ADCs with an
> integrated PGA, internal reference, excitation and burn-out current
> sources for sensor biasing and diagnostics. The ADS1263 adds a second,
> 24-bit delta-sigma ADC (ADC2) for background measurements.
> 
> Each can configure it's own voltage reference source, the two excitation
> current sources (IDAC), plus input and excitation channels rotation for
> offset and IDAC mismatch cancellation. This lets the device drive and
> ratiometrically measure RTDs and other resistive sensors.
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
>  .../devicetree/bindings/iio/adc/ti,ads1262.yaml    | 309 +++++++++++++++++++++
>  MAINTAINERS                                        |   6 +
>  2 files changed, 315 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1262.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads1262.yaml
> new file mode 100644
> index 0000000000000000..2f4e812ae2af135a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1262.yaml
> @@ -0,0 +1,309 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/ti,ads1262.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI ADS1262/ADS1263 analog to digital converter
> +
> +maintainers:
> +  - Kurt Borja <kuurtb@gmail.com>
> +
> +description: |
> +  The ADS1262 and ADS1263 are 38.4-kSPS, delta-sigma (ΔΣ) ADCs with an
> +  integrated PGA, reference, and internal fault monitors. The ADS1263 integrates
> +  an auxiliary, 24-bit, ΔΣ ADC intended for background measurements.
> +
> +  Datasheets:
> +    - ADS126x: https://www.ti.com/lit/ds/symlink/ads1262.pdf
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: ti,ads1262
> +      - items:
> +          - const: ti,ads1263
> +          - const: ti,ads1262
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +  spi-max-frequency:
> +    maximum: 8000000
> +
> +  spi-cpha: true
> +
> +  interrupts:
> +    description: Data ready (DRDY) interrupt line.
> +    maxItems: 1

Technically, there are two pins with the DRDY signal, so we should have
two interrupts in order to be able to tell which one is wired up.

> +
> +  start-gpios:
> +    description: Start conversion control.
> +    maxItems: 1
> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +  dvdd-supply:
> +    description: Digital power supply.
> +
> +  avdd-supply:
> +    description: Analog power supply.
> +
> +  refp-supply:
> +    description: External positive voltage reference.
> +
> +  refn-supply:
> +    description: External negative voltage reference.
> +

Which pins are these? I see 4 possible external reference sources,
but all go through the AINx pins. So I would expect:

	refp1-supply, refn1-supply, refp2-supply, refn2-supply,
	refp3-supply, refn3-supply, refp4-supply, refn4-supply

Also, similar to the chip I am working on, I expect that these pins
could be connected to a resistor rather than a voltage source, so
could use additional bindings for that.


> +  ti,vbias:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: Enables the level-shift voltage on the AINCOM pin.

VBIAS is a voltage source, so I would expect that to be modeled
as a regulator provider. (If we do that REFOUT should be included
as well.)

> +
> +  clocks:
> +    maxItems: 1
> +
> +  '#io-channel-cells':
> +    minimum: 1
> +    maximum: 2
> +
> +  '#gpio-cells':
> +    const: 2
> +
> +  gpio-controller: true
> +
> +patternProperties:
> +  "^channel@[0-9]+$":
> +    $ref: /schemas/iio/adc/adc.yaml#
> +    unevaluatedProperties: false
> +
> +    properties:
> +      reg:
> +        maxItems: 1
> +

If we want to allow single-ended/pseudo-differential inputs, then we should
also allow single-channel (positive pin) and common-mode-channel (negative
pin) properties.

This will also require additional common-mode-<N>-supply properties to allow
for the negative pin connected to something other than GND.

> +      diff-channels:
> +        description: |
> +          Selects the analog input configuration for this channel. The first
> +          value is the positive input and the second is the negative input.
> +          The following values are available:
> +          0: AIN0 pin
> +          1: AIN1 pin
> +          2: AIN2 pin
> +          3: AIN3 pin
> +          4: AIN4 pin
> +          5: AIN5 pin
> +          6: AIN6 pin
> +          7: AIN7 pin
> +          8: AIN8 pin
> +          9: AIN9 pin
> +          10: AINCOM pin

> +          11: Temperature sensor monitor
> +          12: Analog power supply monitor
> +          13: Digital power supply monitor
> +          14: TDAC test signal

These are all internal signals, so not sure it makes sense to have
them in the devicetree. It would make more sense to have fixed
channels defined in the driver for these since they are always there.

We probably also need a separate property (a bool/flag?) to say that
this channel is a TDAC output rather than an analog input. Although
that is for testing, so maybe something to omit for now until we
actually have an application that uses it (to make sure we get it
right)?


> +          15: Float (open connection)

How could we have a differential input with one or both pins open?
Likely this will just be the setting for pins not specified as something
else in the devicetree.

> +        items:
> +          minimum: 0
> +          maximum: 15
> +
> +      reference-sources:
> +        minItems: 2
> +        description:
> +          Indicates the reference sources for this channel. The first and second
> +          items are the positive and negative sources of the main ADC (ADC1).
> +          The third item is the reference source of the secondary ADC (ADC2).
> +        items:
> +          - enum: [internal, ain0, ain2, ain4, avdd]
> +          - enum: [internal, ain1, ain3, ain5, avss]
> +          - enum: [internal, ain0-ain1, ain2-ain3, ain4-ain5, avdd-avss]
> +
> +      excitation-channels:
> +        $ref: /schemas/types.yaml#/definitions/uint32-array
> +        minItems: 2

minItems should be 1 since there are applications that only use one
current source.

> +        maxItems: 2
> +        description: |
> +          Selects pins for the IDAC sources from the following options:
> +            0: AIN0
> +            1: AIN1
> +            2: AIN2
> +            3: AIN3
> +            4: AIN4
> +            5: AIN5
> +            6: AIN6
> +            7: AIN7
> +            8: AIN8
> +            9: AIN9
> +            10: AINCOM
> +            11: No Connection

Having a value for "no connection" doesn't make sense. We would just omit the
property or only have one item in the array.

> +          The first value corresponds to IDAC1 and the second to IDAC2.
> +        items:
> +          minimum: 0
> +          maximum: 11
> +
> +      excitation-current-nanoamp:
> +        minItems: 2
> +        maxItems: 2
> +        description:
> +          The first value corresponds to IDAC1 and the second to IDAC2.
> +        items:
> +          enum: [0, 50000, 100000, 250000, 500000, 750000, 1000000, 1500000,
> +                 2000000, 2500000, 3000000]

In the chip I am working on, I left out 0 with the intention that we
would just omit the property in that case. If we do include 0, then we
should also have `default: 0`. Not sure which way would be preferred by
others though.

> +
> +      burn-out-current-nanoamp:
> +        description:
> +          The ADC incorporates a sensor bias current source that can be used to
> +          apply a small test current to diagnose broken sensor leads or problems
> +          existing in the sensor.

This description doesn't add anything that adc.yaml doesn't already say, so can
be omitted.

> +        enum: [0, 500, 2000, 10000, 50000, 200000]

Same thing here about 0 value.

> +
> +      ti,burn-out-resistor:
> +        $ref: /schemas/types.yaml#/definitions/flag
> +        description: |

Don't see a reason to need | here.

> +          Instead of a fixed current, the sensor bias (burn-out) current source
> +          can be pulled using an internal 10 MΩ resistor.
> +
> +      ti,burn-out-polarity:
> +        $ref: /schemas/types.yaml#/definitions/string
> +        description:
> +          The sensor bias can be configured to either pull-up or pull-down mode.
> +          In pull-up mode, the current flows into the positive input and flows
> +          out of the negative input. In pull-down mode, the polarities are
> +          reversed.
> +        enum: [pull-up, pull-down]

Needs a default.

> +
> +      input-chopping:
> +        $ref: /schemas/types.yaml#/definitions/flag
> +        description:
> +          When enabled, the ADC performs two internal conversions to cancel the
> +          input offset voltage. The first conversion is taken with normal input
> +          polarity. The ADC reverses the internal input polarity for the second
> +          conversion. The difference of the two conversions is computed to yield
> +          the final corrected result with the offset voltage removed.
> +
> +      ti,idac-chopping:

I would call this ti,excitation-channel-chopping to match the excitation-channel
property. Or since this isn't a generic property, call it ti,idac-rotation to
match the datasheet.

> +        $ref: /schemas/types.yaml#/definitions/flag
> +        description:
> +          Automatically swap the IDAC1 and IDAC2 connections of alternate
> +          conversions. The ADC averages the alternate conversions to eliminate
> +          IDAC mismatch.
> +
> +      ti,pga-bypass:
> +        $ref: /schemas/types.yaml#/definitions/flag
> +        description: Bypass the Programmable Gain Amplifier (PGA).

Why would this need to be a DT property? I didn't read this datasheet
too much, but in other chips I have seen there are usually rules that
PGA has to be bypassed under certain conditions, but not others, so
this seems like something for the driver to handle rather than the
devicetree.

> +
> +    dependencies:
> +      excitation-channels: [excitation-current-nanoamp]
> +      excitation-current-nanoamp: [excitation-channels]
> +      burn-out-current-nanoamp:
> +        not:
> +          required:
> +            - ti,burn-out-resistor
> +
> +    required:
> +      - reg
> +
> +dependencies:
> +  refn-supply: [refp-supply]
> +
> +required:
> +  - compatible
> +  - reg
> +  - avdd-supply
> +  - dvdd-supply
> +  - '#address-cells'
> +  - '#size-cells'
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: ti,ads1263
> +    then:
> +      properties:
> +        '#io-channel-cells':
> +          const: 2
> +      patternProperties:
> +        "^channel@[0-9]+$":
> +          properties:
> +            reference-sources:
> +              minItems: 3
> +    else:
> +      properties:
> +        '#io-channel-cells':
> +          const: 1
> +      patternProperties:
> +        "^channel@[0-9]+$":
> +          properties:
> +            reference-sources:
> +              maxItems: 2
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        adc@0 {
> +            compatible = "ti,ads1262";
> +            reg = <0>;
> +            spi-max-frequency = <8000000>;
> +            spi-cpha;
> +            avdd-supply = <&avdd>;
> +            dvdd-supply = <&dvdd>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            reset-gpios = <&gpio 18 GPIO_ACTIVE_LOW>;
> +            interrupts-extended = <&gpio 10 IRQ_TYPE_EDGE_FALLING>;
> +
> +            channel@0 {
> +                reg = <0>;
> +                diff-channels = <0x0 0xA>;

I would just use decimal instead of hex for these. That is how they are
listed in the description anyway.

> +            };
> +        };
> +    };
> +
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        adc@0 {
> +            compatible = "ti,ads1263", "ti,ads1262";
> +            reg = <0>;
> +            spi-max-frequency = <8000000>;
> +            spi-cpha;
> +            avdd-supply = <&avdd>;
> +            dvdd-supply = <&dvdd>;
> +            refp-supply = <&refp>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            reset-gpios = <&gpio 18 GPIO_ACTIVE_LOW>;
> +            interrupts-extended = <&gpio 10 IRQ_TYPE_EDGE_FALLING>;
> +
> +            channel@0 {
> +                reg = <0>;
> +                diff-channels = <0x4 0x5>;
> +                reference-sources = "ain2", "ain3", "ain2-ain3";
> +                excitation-channels = <0x1 0x6>;
> +                excitation-current-nanoamp = <500000 500000>;
> +            };
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6c0471487974f145..9b83d294734b574d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -26923,6 +26923,12 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/iio/adc/ti,ads1018.yaml
>  F:	drivers/iio/adc/ti-ads1018.c
>  
> +TI ADS1262 ADC DRIVER
> +M:	Kurt Borja <kuurtb@gmail.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/adc/ti,ads1262.yaml
> +
>  TI ADS7924 ADC DRIVER
>  M:	Hugo Villeneuve <hvilleneuve@dimonoff.com>
>  L:	linux-iio@vger.kernel.org
> 

