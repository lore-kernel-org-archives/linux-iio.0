Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89523A8745
	for <linux-iio@vger.kernel.org>; Mon, 29 Jun 2026 07:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782717116; cv=none; b=Q77lJ1czOZnr/zDrYuj8g5FFZdHVZ9PTmZUmBTNiBQ12+TtZgtnXop7VKEosDIS4Q8tA/gdiYNk/fccMLvN3IgCE+RrP88q0eGUvf89fUIeUkhDWd9hDZ9ZzwmdJqsSrOHKFN/BhoxPNuJuxrPeKobOLrsGFaig6twYBhHeBx+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782717116; c=relaxed/simple;
	bh=4xPgIzs1Ct0nCYvo63JBCNqk45nAfIG3AogfSxV3MSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FfILSKcZPSP68bMMt8uii2qoyLt/ibSr8ZPyk7aA9Y737Rm0W0A4eO8ve/RRndvKZExhp+KJm5PZyAPsBa7Vx/zxF/lPYRvNtlXrtvUlExibsDC+SUrAYZNziov/p2h2KhWaIWXE6jIPRhY6G/HrAR1Ky81gjVwtFWp61cJJEl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n1XRu3xJ; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n1XRu3xJ"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-847921eed4aso180336b3a.3
        for <linux-iio@vger.kernel.org>; Mon, 29 Jun 2026 00:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782717113; x=1783321913; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ocU4bbQQvRYUjNRGEheDIX/JjGUc9Z8ZjL6L4LmeVWQ=;
        b=n1XRu3xJ4TlskXVUEZx6N5nscC+IIi1wj6Ofgz0NJFHqkn9LJnyOJ60sj6Qamizzp3
         6Zvl+KX39c3DHnubybUKFVhNqILclFYDYIpcfccaZFpofnHtuWIrI8C0AyQ1SJx+1egy
         74e5+XDZ7cjpsn7xXy5re4x/kuppvl1IbYs624bZloiaU4YUtYMNu4o4zbbYxOhMRFhM
         DrVi20RBt+o72I1Uqc1kftRunzGSMegjLU+lqaQHKyzY+ZmJ1xyDfscCjM0fpIWjN6mc
         j+wr9jLiSX7MulWjqa7WgF1ijXCM7RdAY0TKsU2BM6f4Pei93MXbgwc7of2FtyIRh1aM
         u6Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782717113; x=1783321913;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ocU4bbQQvRYUjNRGEheDIX/JjGUc9Z8ZjL6L4LmeVWQ=;
        b=kQKZuBRX8KBWzEU7iDrrG/HmpDBZLbhc0K3Yrfy1f4hBNX0dB4nXETzc6wyfVcqyWI
         4/EprQ5gtyNRZak8J/xO/ZZrT0G7kqgQr8HQ6UWufn2nT+Z6fFIVIdyaad9RWvBWggSx
         LGxHjvrMjh9s7lAm8mfJkzHzgPARsl3EF8NYn3lMcrYMJLyw2Urn8Yr3+irECr+02AtS
         ER/jzQvJnXDmblwtfOKMKKDDcSQh8P382Jt60OJNFmS1FyU/1dqu+HwGeF6SgS6cRolX
         pcZ4PjV5I9bdZ/0bRCjsZzMF0filr0PpLJpC52QB/UywQHyBE2lfqicAOxTkZDgB3nau
         KFXw==
X-Forwarded-Encrypted: i=1; AHgh+RpyJ/b5LqgRTHn7QuraFCm1l2h6UjtbbUV9d9OtLN4osoIYwSU6tUuAd0619J8eebaoN7M3yqJgFqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUV53zXkUGQ+5Mx6xcPxcGe0N5Rnq5jWqNN3/CTJsedf9WfHd6
	ctcRg9qfnfEve3HdrVK63Ow7vnYz3JBrRd1ZCyVv7AYZhJ8/QfUVo2Ov
X-Gm-Gg: AfdE7cmGyBqASSaeh5Qg/rDmZ9JUJyStlSm9XjZ/HrHpuMsc6O60E9g1jlopoq6sDQ8
	MJkNyrAfe/VIlZzNi5Mxz7WhtNYwoTyG+PXSe+r2t3sEEaToPAF1HLrzOIMM7ZuLzEw0fDpda7z
	qnClfM60bF4gDiULLtn0SruEyAnOnp09ctDAiHAdwSt4RTRDeBpncHO71vO9wQSms2EuUUBP2x0
	w7PwGwOLC+CTnxTNsShw3lrDKdhoc1dguOnzoOwThKdoCLSVMc00ZEjOaHlcrxsrAHghAFRm2RO
	T0J7+596PLOt2d4QwO3MvP3eQmkZFEDBRpJsIK4z4M5OK2w0mmDG/jT1tpLI1S5tzsvW+4ro/Nm
	OrKo7giaHJdkS0WEPDpAyCVjUkcU9TEq+dAOwz898reUSMKIGS219akGW9c4Oz0m4mI0kZkFFl+
	umTXrnSP6N45k+4hKm3l9cuQ8D+wA3V4IFLfMjkZBkXpciADYPpAUwL29H1hmWQW1Y
X-Received: by 2002:a05:6a00:8005:b0:845:d284:9e14 with SMTP id d2e1a72fcca58-845d284a9e5mr8108752b3a.59.1782717113038;
        Mon, 29 Jun 2026 00:11:53 -0700 (PDT)
Received: from [172.19.1.42] (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845ebe987fcsm2596068b3a.39.2026.06.29.00.11.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 00:11:52 -0700 (PDT)
Message-ID: <7e96cc1a-eb60-4eeb-937d-64e83bc35279@gmail.com>
Date: Mon, 29 Jun 2026 15:11:48 +0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: Add Nuvoton MA35D1 EADC
To: David Lechner <dlechner@baylibre.com>, jic23@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
Cc: nuno.sa@analog.com, andy@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, cwweng@nuvoton.com
References: <20260625110638.38438-1-cwweng.linux@gmail.com>
 <20260625110638.38438-2-cwweng.linux@gmail.com>
 <40485b4e-6585-42a1-9b84-3019328574c5@baylibre.com>
Content-Language: en-US
From: Chi-Wen Weng <cwweng.linux@gmail.com>
In-Reply-To: <40485b4e-6585-42a1-9b84-3019328574c5@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi David,

Thanks for the review.

 > Datasheet says there are 4 interrupts.

Yes, the controller has four EOC interrupt outputs, ADINT0 to ADINT3.
The initial driver only uses ADINT0, but the hardware does provide four
interrupt lines.

I will update the binding to allow up to four interrupt entries and
document the order as ADINT0, ADINT1, ADINT2 and ADINT3. The example
will keep a single interrupt entry since that is the only one used by
the initial driver.

 > Should there be an optional vref-supply for the V_REF pin?

Yes, I agree. I will add an optional vref-supply property.

I will also update the driver so that it does not force the external
reference path unconditionally. If vref-supply is present, the driver
will enable it and use it to report the ADC scale. Otherwise, the driver
will use the internal reference path.

 > Should there be a dmas property? Datasheet says it supports PDMA 
transfer.

The hardware does support PDMA, but DMA support is intentionally not
included in this initial upstream version. The initial driver will only
support interrupt-driven direct raw reads, and the MA35D1 PDMA provider
is not upstream yet.

I would prefer to leave dmas/dma-names out of the initial binding and
add them later together with DMA support. Please let me know if you
would prefer optional DMA properties to be described now.

 > I assume 8 is for the internal batter voltage channel? Often, we don't
 > include fixed internal channels like this in the devicetree since they
 > are always the same and don't depend on external wiring.

Correct. Channels 0 to 7 are the external ADC input pins, while channel
8 is the internal VBAT input. I will limit the DT child channel nodes to
external channels 0 to 7.

If VBAT support is added later, it can be exposed by the driver as a
fixed internal channel rather than being described by devicetree.

 > adc.yaml already specifies minItems and maxItems, so we don't need to
 > repeat it.

Since I plan to simplify v2 and drop differential channel support from
the initial submission, I will remove diff-channels from the initial
binding.

Differential input support can be added later once the fixed hardware
pair constraints and signed output handling are implemented in the
driver.

 > This (and reg) are uint32, so don't really need minimum: 0.
 >
 > Also, I assume that 8 is for the internal battery voltage channel,
 > which wouldn't make sense as part of a differential input.

Will fix. The v2 binding will restrict child nodes to external channels
0 to 7 and drop the unnecessary minimum: 0.

Thanks,
Chi-Wen


David Lechner 於 2026/6/28 上午 04:05 寫道:
> On 6/25/26 6:06 AM, Chi-Wen Weng wrote:
>> From: Chi-Wen Weng <cwweng@nuvoton.com>
>>
>> Add devicetree binding for the Enhanced ADC controller found on
>> Nuvoton MA35D1 SoCs.
>>
>> The controller has one register region, one interrupt and one functional
>> clock. ADC inputs are described using standard channel child nodes,
>> including optional differential channel pairs.
>>
>> Signed-off-by: Chi-Wen Weng <cwweng@nuvoton.com>
>> ---
>>   .../bindings/iio/adc/nuvoton,ma35d1-eadc.yaml | 100 ++++++++++++++++++
>>   1 file changed, 100 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/iio/adc/nuvoton,ma35d1-eadc.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/nuvoton,ma35d1-eadc.yaml b/Documentation/devicetree/bindings/iio/adc/nuvoton,ma35d1-eadc.yaml
>> new file mode 100644
>> index 000000000000..ae7ad0f7689a
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/adc/nuvoton,ma35d1-eadc.yaml
>> @@ -0,0 +1,100 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/iio/adc/nuvoton,ma35d1-eadc.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Nuvoton MA35D1 Enhanced Analog to Digital Converter
>> +
>> +maintainers:
>> +  - Chi-Wen Weng <cwweng@nuvoton.com>
>> +
>> +description: |
>> +  The Nuvoton MA35D1 Enhanced Analog to Digital Converter (EADC) is a
>> +  12-bit ADC controller integrated in the MA35D1 SoC. Each enabled ADC
>> +  input is described by a child channel node.
>> +
>> +properties:
>> +  compatible:
>> +    const: nuvoton,ma35d1-eadc
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
> Datasheet says there are 4 interrupts.
>
>> +
>> +  clocks:
>> +    maxItems: 1
> Should there be an optional vref-supply for the V_REF pin?
>
> Should there be a dmas property? Datasheet says it supports
> PDMA transfer.
>
>> +
>> +  '#address-cells':
>> +    const: 1
>> +
>> +  '#size-cells':
>> +    const: 0
>> +
>> +patternProperties:
>> +  '^channel@[0-8]$':
>> +    type: object
>> +    $ref: adc.yaml
>> +    unevaluatedProperties: false
>> +
>> +    properties:
>> +      reg:
>> +        minimum: 0
>> +        maximum: 8
> I assume 8 is for the internal batter voltage channel? Often, we don't
> include fixed internal channels like this in the devicetree since they
> are always the same and don't depend on external wiring.
>
>> +
>> +      diff-channels:
>> +        minItems: 2
>> +        maxItems: 2
> adc.yaml already specifies minItems and maxItems, so we don't need to repeat it.
>
>> +        items:
>> +          minimum: 0
>> +          maximum: 8
> This (and reg) are uint32, so don't really need minimum: 0.
>
> Also, I assume that 8 is for the internal battery voltage channel, which
> wouldn't make sense as part of a differential input.
>
>> +
>> +    required:
>> +      - reg
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +  - clocks
>> +  - '#address-cells'
>> +  - '#size-cells'
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +
>> +    soc {
>> +        #address-cells = <2>;
>> +        #size-cells = <2>;
>> +
>> +        adc@40430000 {
>> +            compatible = "nuvoton,ma35d1-eadc";
>> +            reg = <0x0 0x40430000 0x0 0x10000>;
>> +            interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
>> +            clocks = <&clk EADC_GATE>;
>> +
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +
>> +            channel@0 {
>> +                reg = <0>;
>> +            };
>> +
>> +            channel@1 {
>> +                reg = <1>;
>> +            };
>> +
>> +            channel@2 {
>> +                reg = <2>;
>> +                diff-channels = <2 3>;
>> +            };
>> +        };
>> +    };
>> +...
