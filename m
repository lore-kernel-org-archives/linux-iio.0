Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFDF313546
	for <linux-iio@vger.kernel.org>; Fri, 12 Jun 2026 16:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781280652; cv=none; b=oudlnBMTk/uPUO6pyKXIMAXUs4aRt/YD5/hgMJFgZ3JOQeKTnHbyB1sTkqHn4uiQ0zW+0FF0J5zBz9iXdvYrA+aWIQa1mPc9CPzNhif0ecmPmoX9EuTllB8Gof37UIFhM5hA7ByI+wGkjo5qcbQhiJMJzJhPv0EmjTdxjgNLPfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781280652; c=relaxed/simple;
	bh=kcA8/YqeceHkDTks91P3C8LuI7xU6e5a0iE6M02dbOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Na1sUBQoUZl0aiPtbL54W44V4h61gJx7ljUkJ8MlSd8CESxwXZwlvhhAHlrdap+uAQHfPcoTVL2xmK7v3jZp/PWOKD+5tKHQeGbgr/MxeSzpTzPTzzw0BATlp5OpkmvtuxjLZj+32K39AlvmrTbxi3gm2nRCBldPQIDm5ByvipY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=NZCtUWmt; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="NZCtUWmt"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-6cec1485789so412303137.0
        for <linux-iio@vger.kernel.org>; Fri, 12 Jun 2026 09:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781280648; x=1781885448; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GEbMYrHpODEdrCctGaUdr56/QW91l/U1sHGIDNsbyLA=;
        b=NZCtUWmtxollHJfxm61BLshCNoKzCaTIrdMBuhu1BkpPwH7essU9wWMBRGAYNpOBFn
         ldwnme4PcPYTiSipayO+nFO83h7ZLhOCcg9f5zcK4q91hpGKJp5+LxXrwOEH9RX62IU3
         QUrMNfA3DVlFsI6bI7ZATu69e5CRxk98VaumNVlO9262c726P/LRUaKOoszQBqtngSJ7
         8FPwtblPbd6fYmQtWahON0dNUbVvHKGNxi2F/Mk4rkh2+aH2eyQoMbgkMIgIuqw0Xg1F
         Z8j3OvepQLu76Et0zItW3K1ZZiFN5v5nOFfI62zACF254djdr6SCxWcThLUFoXMhOcE9
         VLQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781280648; x=1781885448;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GEbMYrHpODEdrCctGaUdr56/QW91l/U1sHGIDNsbyLA=;
        b=EOGgBu1kfAX+V2uFxv/RVdHnHb+qLrUDFbjxefRcV4Isq8IZ1Fu6Pey5X/QW6S0igf
         7OFcsTT/hJxRKBsb6vCdbR3sQBEAnKIGCl73HwTLmsLh8cHyKpAbSOWdqIpk3nxopDBI
         j5i/hZFxbIn332nPjYlDnFvXhKZfapD6WVJi/K2NVyNNeh2of9wTknEGgF9/rU9WHfsK
         HqEfzpKhw7ucg6gktl91nAe6+BLD+lgi7nVY0otfo8JPf8DQ9+IDnLLzvch+K0lQKE2r
         TSRAjmuDcAFXPinyzGAMkS5M7WIYxZ+tcVy7HyjlUMvu/51qpFHFD6ORUfSs9SVlG6Rw
         hAHw==
X-Gm-Message-State: AOJu0YyE25UNuE0L0WXT3gymUDeN0Z/p98o/djeThZLawDm37w1UGSKt
	82MNdvFWxQ2Gt80D6muD8WW3WUOvVXPTuOMleZ7U1ewkhbQK1/zFWRFfAuxR2owdXWg=
X-Gm-Gg: Acq92OHPRY3NI9zfL8InJQEOS0sZkTGUI0wUuQ2GWmu3FBhDIlGzoFB15Lzht9olLo5
	FUwnmK1Y66JaL2YvUFiH5HnPU0TuaBDFNBlDqTR5VHI1h/jkM+iD/4vU4/F+/x2GoTN90xTcNUV
	mP2+2fDBNaFP4Lm4ZB0yG6QJWblDy5W09g81XkaYElrCS+gdiC5xIl3b2q7uhcZO1TQ3rFiuzRH
	ebCKzWzNlylxEwFkm5tSgCRLcwSgZiLx+ZFYSls4NuJaXWb5ShSGzDhu7yiu+uT6xAQnd086DA3
	UG4btdUW75sq/NfsUSsLY5j+Sokwv2quTXBFpmmEe2DbSeslI/NakaRvlmvmTfKeL9aDW4PZmpw
	3oKMzcwP8l0keiOzy7aksiSa9SRRTN7xwPUiZNjp3W2SfSv4o/MfOj5t6IXWkzbvdmnVZYFTSK9
	5U9t4zzugMR0/ODNOVu5lfD/ADB+j9kkt6VuPYUhTC9emWxIJrUlPU8WU4ZN6Zn+v/ieHn/oU=
X-Received: by 2002:a05:6102:4187:b0:639:3b08:d64c with SMTP id ada2fe7eead31-71e88c4f8abmr2050956137.13.1781280648334;
        Fri, 12 Jun 2026 09:10:48 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:cba0:23d4:353:6048? ([2600:8803:e7e4:500:cba0:23d4:353:6048])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-96674088249sm1807953241.12.2026.06.12.09.10.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2026 09:10:47 -0700 (PDT)
Message-ID: <788b7c6f-fae8-47cd-b78a-33f2803d8c88@baylibre.com>
Date: Fri, 12 Jun 2026 11:10:45 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: Add TI ADS1220
To: Nguyen Minh Tien <zizuzacker@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20260610151342.44274-1-zizuzacker@gmail.com>
 <20260610151342.44274-2-zizuzacker@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260610151342.44274-2-zizuzacker@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/10/26 10:13 AM, Nguyen Minh Tien wrote:
> The ADS1220 is a 24-bit, 2-kSPS, 4-channel delta-sigma ADC from Texas
> Instruments with an SPI (mode 1) interface, a programmable gain amplifier,
> an internal 2.048V reference and a dedicated DRDY data-ready output.
> 
> Add a device tree binding describing the SPI device and its per-input
> channel child nodes (single-ended AINx or the multiplexer's differential
> pairs), the optional external/AVDD reference selection and the DRDY
> interrupt.

FYI, I have a similar chip I am working on (at least in terms of wiring)
that I plan to submit probably next week. I think the DT bindings will
be quite similar, so you might want to wait and see how the review goes
for that (TI ADS122C14).

It could be similar enough that you could add this chip to what I am
doing rather than having separate files.

> 
> Signed-off-by: Nguyen Minh Tien <zizuzacker@gmail.com>
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

There are actually 2 DRDY pins, so we need some way to describe which one
is wired up.

So...

  interrupt-names:
    items:
      - enum: [drdy, dout-drdy]
  

And we have found that when dout-drdy is used, some interrupt controllers
can't handle it correctly and we also need a dout-drdy-gpios to read the pin.

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

If the pins are REFx0, then let's call it ref0-supply.

There is also a ref1-supply (alternate REFP1/REFN1 function of AIN1/AIN3) so that
needs to be included as well.

Also, in the case when the sensor is an RDT, we only care about the resistor
across these inputs rather than the voltage. So in the one I am working on,
I added extra properties for that.

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

On the chip I am working on, we want to select the reference source per-channel
rather than globally, so might want to do the same here.


There is also an optional external clock, so we need clocks property.

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

I would add a comment explaining that the limit here is arbitrary. Also wouldn't
hurt to make it a bit bigger. Technically, someone could have every possible
combination of all inputs (16 differential + 4 single-ended).

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

Sometimes, the same channel may be used as both positive and negative
for a diagnostic, so I would just allow any combination instead of
listing specific combinations.

> +
> +      single-channel:
> +        description:
> +          Single-ended input channel AINx measured against AVSS.
> +        minimum: 0
> +        maximum: 3

On the chip I am working on, I also added properties here for required
current outputs for the RDT case.

And as mentioned above, a property here to select the reference voltage
that this specific channel uses It could be Internal, REFx0, REFx1 or AVDD,
so a boolean flag is not enough.


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

