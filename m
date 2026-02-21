Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com [209.85.210.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5C52DEA7B
	for <linux-iio@vger.kernel.org>; Sat, 21 Feb 2026 20:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771706589; cv=none; b=F9wcNKCrxzUBhvr6n4Z6Xk7nl6/Ars167g37aK2ebwzfJSn/mqsTmcqNIdzex3WLKv99IVoe9VtIaXpHGBu9JY91I7MLpHpWh+CiZ1JaS7b769in5uTnpI44h2nYeIYv6+yobh4hiHJtPgV0H2n8wxVTd53WA6Y5ODbvkKvsAe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771706589; c=relaxed/simple;
	bh=VE6eeUmX/aNvzhie5dJ8Y2YArM7BifAAR7+HRiM4tNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dlyAEomRAyAoGarknC2i7xyNdanG05OoZ87RBHT5P2ttXrrjd+7QdUmoDo1iDRhTYLyclCZQk04NuHYuvoB1axXinZFGBmM2/LEOTfTefbnfxQSwYBWGodbo1NggwdLivOnlHP4TyKUu/+HSON2+1CyOeDXyIQgdA7njnvlK/zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2nbDrKY0; arc=none smtp.client-ip=209.85.210.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2nbDrKY0"
Received: by mail-ot1-f67.google.com with SMTP id 46e09a7af769-7d4c7d04890so2879260a34.3
        for <linux-iio@vger.kernel.org>; Sat, 21 Feb 2026 12:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771706584; x=1772311384; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PvKpCMRTgeYg3+BVQGMPDnKEFwtzJ8PAAHOztYiNYDo=;
        b=2nbDrKY0kyRpoilQYVhLaLfwZd6VVtXv5zZNkbCC2pMKfksSARf+5HJNceyy9PdTfS
         XcQtyNd6vF+/X1si0Z+YX0b1WvfcV3O5TdbP8SM4SfPUaw7nUbU+DtpcxBHk98p7nCha
         5cLTcls9B/FTXezpZUm6II9+vlyfvNoFnu9Cvq2ggTsy3Kg5hDWDpL22EWLLPQTrCa34
         0Q9KAjgSOF56pXgq4m3c/KYYNBkHnnTDfl37aXfy0jv7Br4ymaT5r2BmZPA1rBffkqAi
         6T6vYieKfVkiT56rU9ocHlu+77KmIKLcFd0Wst4GjjqO7BetAuXic3Ek1JUT0rPy/uqg
         oqdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771706584; x=1772311384;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PvKpCMRTgeYg3+BVQGMPDnKEFwtzJ8PAAHOztYiNYDo=;
        b=VsOZdhJCHGOv8NSPCDFhFfhcNoE5AeWtxuZgiMurgVI9JbXrQJcA8VuDRGVHujr2/S
         k4yRJiPARA+4F3ddwXjMcfln/aELmqxMKgkTtdSG/6PDCFZeWRyaVYLgnTvWzkwboeSC
         5kkYhknCAmNuHS+oV39jEiRR7VJZpsctrVdQDA9vz/CT5vpVT9u6qnq6ukdgMUTqBkEE
         yzoYnUum06DByzEo6DoZzGA2Cc8KczqLeLTSDJzF5+06LJqORasNqdKwUp8AKSUBSvjh
         LBh/Qiad2t7Z0JpqM8SeC3LR4FgoHalK1aQTkwX4DHlIJZzUR3wHX5ANYRU3GijNF56y
         LUMw==
X-Forwarded-Encrypted: i=1; AJvYcCU4fgchGJRuQ/T1gAPVXONBxL28nCaCRTmsSbUSPqKFC1lxEhltA9pN2GNICVm+uXR5asobGiXoBpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOg42xsaYNRFhO67FDqJAunvKfK+1c68kh7iZQVF0m48JANCmU
	dge0eG+p+Oq3vjZVnnb4qqQGs2swmj/MTdbczHXsKNyXRTiP/ZWNuN0e1G3Z06ji4eU=
X-Gm-Gg: AZuq6aIuUjzVjQDLfZmVg+ZwEdD0qP8kwmCOFx9mhk3LNfuSmmsiADU77hXZfgGeEEO
	T+9Mwss+ppA14GzFtqBmD2Y2+Z/DIxH+/G9j5Ym3a7GxFoDx+fg1vQAKixH/n+5fVScdppSE8D6
	Qh0NpatEv2CALu0tRXlSvBi0XoLK7tzkNwRO3jF9Tqgm7VPknM5FDnVApBQPn6dzdztS4g6TPmB
	sGcwAqogY9V7yTOrhj7tjcqssPvlJKK3bKo9zurk0DTggjeXfNB4exE9m4yqu1nWotkUGu8n0u1
	aM9aKXpJis3VGSAopnFMCQGbdGZxbqzQ38vNcm9imm9a2Jeg0ZbiW5vF2kY/mmqCoxSIIHjq3lN
	TjOkVQ3Cr2rYIf/yxXVPGwzTQnuzJfb8v7OSIdoYAoCYcC7uMs2jHT1PLrVughsG6Vo5Ixy4X+9
	9ZcTpugZUzbJ+weyMrAnsB48pukdJYg4iTaRqgHSc6moHpP1Yz7uQC/4u+mU5ubX6e1qgXOQ==
X-Received: by 2002:a05:6808:5093:b0:45e:8554:1f14 with SMTP id 5614622812f47-464463ff054mr2361330b6e.59.1771706584270;
        Sat, 21 Feb 2026 12:43:04 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:611:96af:f385:64bf? ([2600:8803:e7e4:500:611:96af:f385:64bf])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4644a013cddsm2118373b6e.8.2026.02.21.12.43.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Feb 2026 12:43:03 -0800 (PST)
Message-ID: <41190a42-70ab-45b9-922f-317e792b25a0@baylibre.com>
Date: Sat, 21 Feb 2026 14:43:02 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/8] dt-bindings: iio: frequency: add ad9910
To: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
References: <20260220-ad9910-iio-driver-v1-0-3b264aa48a10@analog.com>
 <20260220-ad9910-iio-driver-v1-1-3b264aa48a10@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260220-ad9910-iio-driver-v1-1-3b264aa48a10@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/20/26 10:46 AM, Rodrigo Alencar via B4 Relay wrote:
> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> DT-bindings for AD9910, a 1 GSPS DDS with 14-bit DAC. It includes
> configurations for the reference clock path, DAC current, reset and basic
> GPIO control.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> ---
>  .../bindings/iio/frequency/adi,ad9910.yaml         | 236 +++++++++++++++++++++
>  MAINTAINERS                                        |   7 +
>  2 files changed, 243 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,ad9910.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,ad9910.yaml
> new file mode 100644
> index 000000000000..43b21d1428ba
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/frequency/adi,ad9910.yaml
> @@ -0,0 +1,236 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/frequency/adi,ad9910.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD9910 Direct Digital Synthesizer
> +
> +maintainers:
> +  - Rodrigo Alencar <rodrigo.alencar@analog.com>
> +
> +description:
> +  The AD9910 is a 1 GSPS direct digital synthesizer (DDS) with an integrated
> +  14-bit DAC. It features single tone mode with 8 configurable profiles,
> +  a digital ramp generator, RAM control, OSK, and a parallel data port for
> +  high-speed streaming.
> +
> +  https://www.analog.com/en/products/ad9910.html
> +
> +properties:
> +  compatible:
> +    const: adi,ad9910
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 70000000
> +
> +  clocks:
> +    maxItems: 1
> +    description:
> +      Reference clock input (REFCLK). When the PLL is enabled, this is
> +      multiplied by adi,pll-multiplier to produce the system clock.
> +      When the PLL is bypassed, the reference clock is used directly or divided
> +      by 2 based on adi,reference-div2-enable to produce the system clock.

Devicetree is just concerned with how it is wired up. The first
sentence is enough.

> +
> +  dvdd-io33-supply:
> +    description: 3.3V Digital I/O supply.
> +
> +  avdd33-supply:
> +    description: 3.3V Analog DAC supply.
> +
> +  dvdd18-supply:
> +    description: 1.8V Digital Core supply.
> +
> +  avdd18-supply:
> +    description: 1.8V Analog Core supply.
> +
> +  resets:
> +    minItems: 1
> +    maxItems: 2
> +
> +  reset-names:
> +    oneOf:
> +      - items:
> +          - const: dev
> +      - items:
> +          - const: dev
> +          - const: io

This could be a bit more clear. Does dev == MASTER_RESET pin?
And what about DAC_RSET?

> +
> +  reset-gpios:
> +    maxItems: 2
> +    description:
> +      GPIOs controlling the device reset and the I/O_RESET pins. This is only
> +      used if resets property is not defined.
> +
> +  powerdown-gpios:
> +    maxItems: 1
> +    description:
> +      GPIO controlling the EXT_PWR_DWN pin.
> +
> +  update-gpios:
> +    maxItems: 1
> +    description:
> +      GPIO controlling the I/O_UPDATE pin.
> +
> +  profile-gpios:
> +    minItems: 3
> +    maxItems: 3
> +    description:
> +      GPIOs controlling the PROFILE[2:0] pins for profile selection.
> +

Looks like possibly some interrupts as well: RAM_SWP_OVR and SYNC_SMP_ERR

> +  adi,pll-multiplier:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 12
> +    maximum: 127
> +    description:
> +      PLL feedback divider value (N). The system clock frequency is
> +      REFCLK * N. When not specified, the PLL is bypassed.

What determines the value that should be selected here? This doesn't seem like
something we would normally put in the devicetree. (Smells like configuration
rather than describing what is wired up.)

> +
> +  adi,pll-vco-select:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 5
> +    description: |
> +      VCO frequency range selection (0-5). When not specified and the PLL
> +      is enabled, the VCO range is automatically selected based on the
> +      computed system clock frequency. Typical VCO frequency ranges are:
> +      - Range 0: 370 MHz to 510 MHz (Auto-selected when <= 465 MHz)
> +      - Range 1: 420 MHz to 590 MHz (Auto-selected when > 465 MHz and <= 545 MHz)
> +      - Range 2: 500 MHz to 700 MHz (Auto-selected when > 545 MHz and <= 650 MHz)
> +      - Range 3: 600 MHz to 880 MHz (Auto-selected when > 650 MHz and <= 790 MHz)
> +      - Range 4: 700 MHz to 950 MHz (Auto-selected when > 790 MHz and <= 885 MHz)
> +      - Range 5: 820 MHz to 1050 MHz (Auto-selected when > 885 MHz)
> +

Same here. How does this depend on how the chip is wired up?

> +  adi,charge-pump-current-microamp:
> +    minimum: 212
> +    maximum: 387
> +    default: 387
> +    description:
> +      PLL charge pump current in microamps. Only applicable when the PLL
> +      is enabled. The value is rounded to the nearest supported step.
> +
> +  adi,refclk-out-drive-strength:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum: [ disabled, low, medium, high ]
> +    default: disabled
> +    description:
> +      Reference clock output (DRV0) drive strength. Only applicable when
> +      the PLL is enabled.
> +
> +  adi,reference-div2-enable:
> +    type: boolean
> +    description:
> +      Enable the reference clock input divider. When enabled, the input
> +      reference frequency is halved before deriving the system clock.
> +      This is only applicable when the PLL is bypassed.
> +
> +  adi,inverse-sinc-enable:
> +    type: boolean
> +    description:
> +      Enable the inverse sinc filter that compensates for the sinc roll-off
> +      of the DAC output. When it is enabled, the filter introduces up to 3 dB
> +      of insertion loss.
> +
> +  adi,sine-output-enable:
> +    type: boolean
> +    description:
> +      Select sine wave output from the DDS core. When not set, the
> +      output is a cosine wave.

And these last few are really getting into things that are typically
controlled by the IIO driver and not hard-coded.

> +
> +  adi,sync-clk-disable:
> +    type: boolean
> +    description:
> +      Disable the SYNC_CLK output pin. SYNC_CLK runs at one quarter
> +      of the system clock frequency.

Clock outputs should be described as clock-controller and #clock-cells.
The actual enabling/disabling can be done at runtime.

> +
> +  adi,pdclk-disable:
> +    type: boolean
> +    description:
> +      Disable the parallel data clock (PDCLK) output. PDCLK runs at
> +      one quarter of the system clock frequency.
> +
> +  adi,pdclk-invert:
> +    type: boolean
> +    description:
> +      Invert the polarity of the PDCLK output.
> +
> +  adi,tx-enable-invert:
> +    type: boolean
> +    description:
> +      Invert the polarity of the TX_ENABLE input pin.
> +
> +  adi,dac-output-current-microamp:
> +    minimum: 8640
> +    maximum: 31590
> +    default: 20070
> +    description:
> +      DAC full-scale output current in microamps.
> +
> +dependencies:
> +  adi,pll-vco-select: [ 'adi,pll-multiplier' ]
> +  adi,charge-pump-current-microamp: [ 'adi,pll-multiplier' ]
> +  adi,refclk-out-drive-strength: [ 'adi,pll-multiplier' ]
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - dvdd-io33-supply
> +  - avdd33-supply
> +  - dvdd18-supply
> +  - avdd18-supply
> +
> +dependentSchemas:
> +  resets:
> +    properties:
> +      reset-gpios: false
> +  reset-gpios:
> +    properties:
> +      resets: false

This seems too strict. Couldn't we have some resets from a reset
controller and others from gpios?

Or maybe the reset bindings are enough and we don't need the gpio
bindings for the same pin?

> +  adi,reference-div2-enable:
> +    properties:
> +      adi,pll-multiplier: false
> +  adi,pll-multiplier:
> +    properties:
> +      adi,reference-div2-enable: false
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        dds@0 {
> +            compatible = "adi,ad9910";
> +            reg = <0>;
> +            spi-max-frequency = <1000000>;
> +            clocks = <&ad9910_refclk>;
> +
> +            dvdd-io33-supply = <&vdd_io33>;
> +            avdd33-supply = <&vdd_a33>;
> +            dvdd18-supply = <&vdd_d18>;
> +            avdd18-supply = <&vdd_a18>;
> +
> +            reset-gpios = <&gpio 0 GPIO_ACTIVE_HIGH>,
> +                          <&gpio 1 GPIO_ACTIVE_HIGH>;
> +            powerdown-gpios = <&gpio 2 GPIO_ACTIVE_HIGH>;
> +            update-gpios = <&gpio 3 GPIO_ACTIVE_HIGH>;
> +            profile-gpios = <&gpio 4 GPIO_ACTIVE_HIGH>,
> +                            <&gpio 5 GPIO_ACTIVE_HIGH>,
> +                            <&gpio 6 GPIO_ACTIVE_HIGH>;
> +
> +            adi,pll-multiplier = <40>;
> +            adi,charge-pump-current-microamp = <387>;
> +            adi,refclk-out-drive-strength = "disabled";
> +            adi,inverse-sinc-enable;
> +        };
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1251965d70bd..79b4180e2334 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1610,6 +1610,13 @@ W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/devicetree/bindings/iio/dac/adi,ad9739a.yaml
>  F:	drivers/iio/dac/ad9739a.c
>  
> +ANALOG DEVICES INC AD9910 DRIVER
> +M:	Rodrigo Alencar <rodrigo.alencar@analog.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Supported
> +W:	https://ez.analog.com/linux-software-drivers
> +F:	Documentation/devicetree/bindings/iio/frequency/adi,ad9910.yaml
> +
>  ANALOG DEVICES INC MAX22007 DRIVER
>  M:	Janani Sunil <janani.sunil@analog.com>
>  L:	linux-iio@vger.kernel.org
> 

