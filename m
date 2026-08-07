Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5324D441606
	for <linux-iio@vger.kernel.org>; Fri,  7 Aug 2026 20:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786134241; cv=none; b=byHFetV3k4NHDBLuH+H2B1mUV3qVr9bry5pA+YcBX0cIWQuRf3gI2kGAhz0ZtYgilDJA/Y3/Fi6No/1zjfnI7jEx56NxG4eImV79ULd1uu1CLCBpVxMX2HuVNB9dGhdkxC9l/m3wS5CUxOhlFxgDV3ILYupXo/SNwmukH2ps/J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786134241; c=relaxed/simple;
	bh=n2eolYt5CCjeMz0TzIeeW8hw38gmzPboW1aYo9XSOT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dyGucf9uHQM6ty1xmPiOpwXiax8OdbN7Gq4qB1Id3wrL8jZd16wwb/jiG6AI+DeL/TfW1rpDi4rv9LiTBjdgKWQRNJax+cUq0jhRwmjY7rdekZKFW1Xh4dZOKou/dfqpWc2lONTlxGdRUwr0br1dBgysWZ+nb38wvBB/DtCyIYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=pb/paLRn; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="pb/paLRn"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7ee125ec926so2734791a34.2
        for <linux-iio@vger.kernel.org>; Fri, 07 Aug 2026 13:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1786134238; x=1786739038; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2J94HMnY+/NqeWFTSOyyflcz5JBZ7AWbftpPkiQyAxY=;
        b=pb/paLRnuz+UmApw1/ltZT62on/uFe5B9KscFULelbeCccabD4SvNmoRpeiYiNUy8F
         IsIGXW5Tsosbnw3nQBpUgm6UaMCe2TZHILrlncth/Go0ZcFmA2DjrWxcPJu87zbLzf22
         IzfoImxQxLB3b/vgbYbgogmb37LbW674XD++X+39AgZtIEO/L518TRhOpu4AwT/IlhD7
         mCxjCY4wF3nRr3YFkZcVijykDlALBY336Kozqjaj+oQYZCJSnsKgOjlrk6DJJYEnzYEv
         Jq6UheqgvpdBq7jM+0MCoUoyxHa0CBgYKFzIrPqLUKuJd1an+2QDNHo+ANsWzDzc111N
         JD7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786134238; x=1786739038;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2J94HMnY+/NqeWFTSOyyflcz5JBZ7AWbftpPkiQyAxY=;
        b=ksLb1RaNCDUbDuWaUi2m44s2yK8vMsXvjfVKSZDbfmbb7qeQb8W30DZkK3kUiHoN+2
         xKPjNfRG0b9kKd8tfxvlyMfl738uHassz6UTUtU+hofHfiRknjMKze+AEgpZAb3IC+Zo
         Sk4/WtadVN/zYQ8vwH96JZbWOwW3xgzafYpP1UwH5tWCSTKuCTDJkgNHaMWwvK3OjzSL
         cRlDB+slX7hHCZp4QlrKsK6s4LQ3AmdmjeD26fTMi+q8GXjqCA/PVa6ByyDKtNJheQt0
         UFM32bqHBDDfKeKpilBPWvghXKrP2igOEB8rHqdUXine+3azVCEbr7v5AWyRXCTX71i7
         SvfQ==
X-Gm-Message-State: AOJu0YyzqAv6+N4EIfajfNmuGz7ZfmIc0QnK7ule+FI6Nq8vX8HmQvkA
	Jcc/U9BFldx52Ezvj2/DtydVdeOhuMPn0ytwYmXUQ5qgpcDjnwXGzzlGCjAavavTT5I=
X-Gm-Gg: AR+sD11pVBUap2tL9qqhpO28Ty4hecT6I6VkA99PKRkenG8nOzw6bEO/owTHB0Tq6Qc
	pAjRYg+nNPZGJoqzDYkbSc9UhiG3k7CgTYwLNMR69/ETA2gx5rDQq1EqkCcEddHzW4czQTTxex/
	u8LEzK5TBwC5Ru3k5BrmPlQvEAvLZTh+kaakrGmw82RnmH58gGYajRaMOF+m0kiYFdOsg2e9xJ6
	EFqmY/oHxkULlf6UKKX9+bEVSPSGYCZRpGfBh9nBo7smpVuwXRycof2pyEPOLZNOeYRbbnb9VKS
	l5eWoLlPU4zYVx9gKKCk6HqHolMBrvJOC2UCHJNRnSdOpopWUVG6fHEeB+S4kA6u16oHeDx+4Hh
	/S29ZAbYZRoL5gt+KvCT8fie3H4d4duviCDQASKGYmC1Fcbzz6HUKZG7GEcNuydhyGSWvIutxwx
	+fprZuFeeA7jT2OXA/kQXxkqPOHmoXhLfkW/s0eAG1Bx+6DRlukKrsAVOG1E+h5xo7bYt5Brxgs
	0S2mqF6+Xv8U/z8UK2wE2l8rP65TRJ5yY+j6QNc1Ge3r14=
X-Received: by 2002:a05:6830:8286:b0:7e6:ee6d:cb1f with SMTP id 46e09a7af769-7f1e59c5ab5mr17070316a34.0.1786134238198;
        Fri, 07 Aug 2026 13:23:58 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:b714:88c:313d:dee2? ([2600:8803:e7e4:500:b714:88c:313d:dee2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f35b76fe2fsm1910393a34.16.2026.08.07.13.23.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2026 13:23:57 -0700 (PDT)
Message-ID: <34ff47a2-1a53-4d99-a864-5bf633e05d4f@baylibre.com>
Date: Fri, 7 Aug 2026 15:23:56 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: adc: ti,ads112c04: Add binding
 for ADS112C04
To: Kyle Hsieh <kylehsieh1995@gmail.com>, Jonathan Cameron
 <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260805-ti-ads112c04-driver-v3-0-49f436829e01@gmail.com>
 <20260805-ti-ads112c04-driver-v3-1-49f436829e01@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260805-ti-ads112c04-driver-v3-1-49f436829e01@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/5/26 12:38 AM, Kyle Hsieh wrote:
> Add device tree binding documentation for Texas Instruments ADS112C04
> I2C Analog-to-Digital Converters.
> 
> These devices provide 4-channel, 16-bit delta-sigma ADCs with an I2C
> interface, programmable gain amplifier (PGA), and data-ready (DRDY)
> interrupt output.
> 
> The binding uses child nodes to dynamically define the connected
> single-ended or differential channels.
> 
> Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
> ---
>  .../devicetree/bindings/iio/adc/ti,ads112c04.yaml  | 146 +++++++++++++++++++++
>  1 file changed, 146 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads112c04.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads112c04.yaml
> new file mode 100644
> index 000000000000..ff079bb5b3dd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads112c04.yaml
> @@ -0,0 +1,146 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/ti,ads112c04.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments ADS112C04 ADC
> +
> +maintainers:
> +  - Kyle Hsieh <kylehsieh1995@gmail.com>
> +
> +description:
> +  The ADS112C04 (16-bit) are precision analog-to-digital converters (ADCs)
> +  with an I2C interface. They feature a flexible input multiplexer, a
> +  low-noise programmable gain amplifier (PGA), two programmable excitation
> +  current sources, a voltage reference, and a precision temperature sensor.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,ads112c04
> +
> +  reg:
> +    maxItems: 1
> +    description: I2C address of the device.
> +
> +  interrupts:
> +    maxItems: 1
> +    description: Data ready (DRDY) interrupt output.
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +  reset-gpios:
> +    maxItems: 1
> +    description: GPIO connected to the RESET pin. Active low.
> +
> +  avdd-supply: true
> +  dvdd-supply: true
> +
> +  refp-supply: true
> +  refn-supply: true
> +
> +  ti,refp-refn-resistor-ohms:
> +    description: Resistance of the external resistor between REFP and REFN.
> +
> +patternProperties:
> +  "^channel@[0-9a-b]$":
> +    $ref: adc.yaml
> +    unevaluatedProperties: false
> +    properties:
> +      reg:
> +        items:
> +          - maximum: 11
> +
> +      single-channel:
> +        maximum: 3
> +
> +      diff-channels:
> +        items:
> +          maximum: 3
> +
> +      excitation-channels:
> +        maxItems: 2
> +        items:
> +          maximum: 3

I{1,2}MUX can also be routed to the REFP and REFN pins, so we need to
go up to 5 here and add a description that explains the mapping.

> +
> +      excitation-current-nanoamp:
> +        maxItems: 2
> +        items:
> +          enum: [10000, 50000, 100000, 250000, 500000, 1000000, 1500000]
> +

The current outputs are not independently configurable on this one
so maxItems: 1 would be fine on this one.

Or I think this works too:

      excitation-current-nanoamp:
        items:
          - enum: [10000, 50000, 100000, 250000, 500000, 1000000, 1500000]


> +      burn-out-current-nanoamp:
> +        items:
> +          - enum: [10000]

When there is only one possibility:

             - const: 10000

> +
> +      reference-sources:
> +        items:
> +          - enum: [internal-2.048v, external, avdd]
> +            default: internal-2.048v

Since there is only one internal, we can just call it "internal".

> +
> +    dependencies:
> +      excitation-channels: [ excitation-current-nanoamp ]
> +      excitation-current-nanoamp: [ excitation-channels ]
> +
> +    oneOf:
> +      - required: [ single-channel ]
> +      - required: [ diff-channels ]
> +
> +required:
> +  - compatible
> +  - reg
> +  - avdd-supply
> +  - dvdd-supply
> +
> +dependencies:
> +  refn-supply: [ refp-supply ]
> +
> +oneOf:
> +  - required:
> +      - refp-supply
> +  - required:
> +      - ti,refp-refn-resistor-ohms
> +  - properties:
> +      refp-supply: false
> +      refn-supply: false
> +      ti,refp-refn-resistor-ohms: false
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        adc@40 {
> +            compatible = "ti,ads112c04";
> +            reg = <0x40>;
> +            interrupt-parent = <&gpio>;
> +            interrupts = <12 IRQ_TYPE_EDGE_FALLING>;
> +
> +            reset-gpios = <&gpio 13 GPIO_ACTIVE_LOW>;
> +            avdd-supply = <&vdd_3v3_reg>;
> +            dvdd-supply = <&vdd_3v3_reg>;
> +            refp-supply = <&vref_reg>;
> +
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            channel@0 {
> +                reg = <0>;
> +                diff-channels = <0>, <1>;
> +            };
> +
> +            channel@1 {
> +                reg = <1>;
> +                single-channel = <2>;
> +            };
> +        };
> +    };
> 

