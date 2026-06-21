Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0972BE65B
	for <linux-iio@vger.kernel.org>; Sun, 21 Jun 2026 21:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782076502; cv=none; b=ghYgJ6kqWMvCruoKnIglGbtrsQdu901CTqpSif1L2SihwN2YgB9TmbhbmFg4zi8GQBatdHj83v5RWTHfoAxJsXoU3gslqeUpvg/6KyvWgShOu9xdw4cu8AeJ6I8F+A4AZtlegROPwKsfYh254QiDp74Dbp/I3mPTXXKvl4RtKrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782076502; c=relaxed/simple;
	bh=C0wQVxuqdiK/fp+BVmjKVlnDaGx0dHeZxItIBW4aD3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jln1up5PnwBmUKYVennuJ56mCZ63imV0EdENa+UZV8rjzkRrIcvclE1efSvoDUsrXkdUQQpoEgkyx6jzPT2znpJ6WbjVUjdlgUhlZC914VSuLHN3QIYjFk9p+99KcX9U3OvI0SZLHtoMKT3EmM8svf3YMQfissCzsmM1gr7pDPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=lZd/Q7rL; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="lZd/Q7rL"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7e6b5737bb2so3067237a34.1
        for <linux-iio@vger.kernel.org>; Sun, 21 Jun 2026 14:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782076498; x=1782681298; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W03X9xRHhLEUFBz1GJVjBleFMPeYw6BCaCiOWFJSiAM=;
        b=lZd/Q7rLCahdZK1G12DD0/uIAg3ki28n4ufaPNrxne15cHVARrKslpw70k+oZ+JHGB
         rGxQ9bue58zPujN73r4EbA869RnXG60cQ71xYUrO7JMgmFWlesSwSJzkAZvc8ZQir4I7
         CgmHRtgpF5u2XUW1EY44q66y4t3JqDYkWzrg4NZAUVECZ28QApkGanq775r6dbtMtY7C
         mAICyXCIhe/BbNxISNdUB2cHuBNVhDtE1HFUpl6cUnsIjR1qfrA20HHaZ+t41a60YVkl
         1L1tjss/JulfAmgZuagwmcNvPclDbKiHEKTKJxQc8UyGG5W3y1ETMWAyQlukgMV/FKQa
         9i6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782076498; x=1782681298;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W03X9xRHhLEUFBz1GJVjBleFMPeYw6BCaCiOWFJSiAM=;
        b=dNGKEw8WniJXsiKx5I5RZ/4TjFKtijN1GXkqTumU798RMjNJ6+rc6uMHySdGegu2Hd
         B3uWaF9VatLnBvKTAj9IyOPkN1NvwD+HUhaPlSNwwPkuFQsE0XA7XapRcDTYKqyLCsqu
         t3sqDMn+lWJxlRsn4PxpW/XjzU67ay8Xa5Dw8JsFkdhvoP2tiXIGGSsH3/ZkjN5Ldqyy
         v13tD/W9iVNqSeEE+xr5H5aVu/NiupNC0rlsTh3uWoKmySfbWWnLFITcDxKUTo1Yf4jy
         oxeOztAlnAIIMqkrIyRBCBn2OP5tAtT4WGNtxTdCgCJDT6OViJE3SG+wkvIjnhRyrPoW
         /XaA==
X-Forwarded-Encrypted: i=1; AFNElJ84LMcL8RpOL8uqOUH68h8/tMiB+2exB+RcyD3/fT0yN7SIwNpVa9M2g1jfPzgDkHQQ/IWrS++IoFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoeN8FwGTDfYMe0/7EcpFNBvVnnGnAxCJk/PApRqj2bUPp83ss
	TVDXbjsJqTN0t9N8amc4SqvlcZr2uZgVEf3Uerxo1T2TZi/ys8LiThBqFNpnvCpTRfk=
X-Gm-Gg: AfdE7cnALhG2AaOucCukZt2cI6JEveAySdtXUX7X1qcW959e0rFFM1hSE9SK9HFdEr7
	PuVxGJVVfz0IykAkQv8CkZmFjhjXm4D32mnbLEyypdD6BA6G6eqyTn2pK1m2RcaaojxTvwmvRGs
	/CGlwCwzRa/iIFiu2FwD2fFfwirpWQfmPigCuPg7Haq6vMiiJDe+d9HPGwVuss0SrMF710AV28B
	wdYlRUEsx8Wb22IRBhUYfuKY+8QTGuCBMQG2BIElT3VJgS1/JAuLDDzGnhC0R+8p0uwejQze1Mj
	kzEFpurjWEC6ApaYxVpn2BtAJq0vkWRFjjJcwe3xdpP6/grfYBG52BzTmdQTE662BHEHFXSzz0p
	4t+t6P2An/54N7cG3LafVy74v8Plx2a8BKg/IKnoZobl+y21GgWuM+JUSOUbi1cwCR4URdSREoS
	zh4so8JJt2sPs65zkqMp176Af6wuteRmly6IT65pqqbD2MOIA5KjUtMzA36xwCG7A=
X-Received: by 2002:a05:6830:67e7:b0:7dd:e032:3ce5 with SMTP id 46e09a7af769-7e9323916d6mr9434422a34.17.1782076498392;
        Sun, 21 Jun 2026 14:14:58 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:b69c:5a77:b8fb:a5cf? ([2600:8803:e7e4:500:b69c:5a77:b8fb:a5cf])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e943d5dc07sm5223437a34.0.2026.06.21.14.14.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jun 2026 14:14:58 -0700 (PDT)
Message-ID: <da875b00-6f93-444b-982c-30b8001dd8e0@baylibre.com>
Date: Sun, 21 Jun 2026 16:14:57 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dt-bindings: iio: adc: add ti,ads122c14
To: Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Kurt Borja <kuurtb@gmail.com>,
 Nguyen Minh Tien <zizuzacker@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260615-iio-adc-ti-ads122c14-v1-0-e6bdadf7cb2b@baylibre.com>
 <20260615-iio-adc-ti-ads122c14-v1-1-e6bdadf7cb2b@baylibre.com>
 <20260621194102.08d7fdd6@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260621194102.08d7fdd6@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/21/26 1:41 PM, Jonathan Cameron wrote:
> On Mon, 15 Jun 2026 16:59:59 -0500
> "David Lechner (TI)" <dlechner@baylibre.com> wrote:
> 
>> Add new bindings for ti,ads122c14 and similar devices.
>>
>> This is an ADC that is primarily intended for use with temperature
>> sensors. There are a few unusual properties because of this. In
>> particular, the reference voltage source and current output requirements
>> can be different for each measurement, so these are included in the
>> channel bindings.
>>
>> The REFP/REFN reference voltage is usually just connected to a resistor
>> that is being driven by the ADC's current outputs, so there is special
>> property for this case rather than requiring a regulator to be defined
>> to represent that.
>>
>> ti,vref-source is reused from ti,tlv320adcx140.yaml (otherwise might
>> have preferred an enum of strings).
>>
>> Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
> 
> A few queries inline though I'm only just starting to get my head
> around this device...
> 
> Thanks
> 
> Jonathan
> 
>> ---
>>  .../devicetree/bindings/iio/adc/ti,ads112c14.yaml  | 224 +++++++++++++++++++++
>>  MAINTAINERS                                        |   7 +
>>  include/dt-bindings/iio/adc/ti,ads112c14.h         |  11 +
>>  3 files changed, 242 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads112c14.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads112c14.yaml
>> new file mode 100644
>> index 000000000000..dc7f37cad772
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads112c14.yaml
>> @@ -0,0 +1,224 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/iio/adc/ti,ads112c14.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Texas Instruments' ADS112C14 and similar ADC chips
>> +
>> +description: |
>> +  Supports the following Texas Instruments' ADC chips:
>> +  - ADS112C14 (16-bit)
>> +  - ADS122C14 (24-bit)
>> +
>> +  https://www.ti.com/lit/ds/symlink/ads122c14.pdf
>> +
>> +  These chips are primarily designed for use with temperature sensors such as
>> +  RTDs and thermocouples. The channel bindings reflect this in that each channel
>> +  represents the conditions required to make a measurement rather than strictly
>> +  just the physical input channels.
>> +
>> +maintainers:
>> +  - David Lechner <dlechner@baylibre.com>
>> +
>> +unevaluatedProperties: false
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - ti,ads112c14
>> +      - ti,ads122c14
>> +
>> +  reg:
>> +    items:
>> +      - minimum: 0x40
>> +        maximum: 0x47
>> +
>> +  clocks:
>> +    maxItems: 1
>> +    description: Optional external clock connected to GPIO3 pin.
>> +
>> +  avdd-supply: true
>> +  dvdd-supply: true
>> +
>> +  refp-supply: true
>> +  refn-supply: true
>> +
>> +  refp-refn-resistor-ohms:
>> +    description:
>> +      The resistance of the external resistor between REFP and REFN when using
>> +      resistor bridge driven by current outputs for RTD measurements.
>> +
>> +  interrupts:
>> +    minItems: 1
>> +    items:
>> +      - description: FAULT interrupt (GPIO2 pin)
>> +      - description: DRDY interrupt (GPIO3 pin)
>> +
>> +  interrupt-names:
>> +    minItems: 1
>> +    maxItems: 2
>> +    items:
>> +      enum: [fault, drdy]
>> +
>> +  gpio-controller: true
>> +  '#gpio-cells':
>> +    const: 2
>> +
>> +  '#address-cells':
>> +    const: 1
>> +
>> +  '#size-cells':
>> +    const: 0
>> +
>> +patternProperties:
>> +  ^channel@[0-7]$:
>> +    $ref: adc.yaml
>> +
>> +    unevaluatedProperties: false
>> +
>> +    properties:
>> +      reg:
>> +        maximum: 16 # arbitrary limit, channel@ can be any combination of AIN0-AIN7
>> +
>> +      single-channel:
>> +        maximum: 7
>> +
>> +      diff-channels:
>> +        items:
>> +          maximum: 7
>> +
>> +      bipolar:
>> +        description:
>> +          Set this flag if the differential input can be negative.
> 
> I'd leave that description to adc.yaml   Maybe that doc could be improved though
> given it basically says bipolar == bipolar mode ;)

It seems not always obvious to me which properties from adc.yaml apply
and which ones don't to a given ADC that makes use of it. So I was
hoping to have some way of saying that bipolar is applicable to this
chip. 

> 
>> +
>> +      excitation-channels:
>> +        description: AINx pins used as current output.
>> +        $ref: /schemas/types.yaml#/definitions/uint32-array
>> +        minItems: 1
>> +        maxItems: 2
>> +        items:
>> +          maximum: 7
>> +
>> +      excitation-current-microamp:
> 
> There seem to be separate controls. Are their usecases where this needs
> to be in array?

I'll have to ask, but probably yes since there are separate controls
so `maxItems: 2` would be appropriate.

> 
>> +        description: The current output of the excitation channels in microamps.
>> +        minimum: 1
>> +        maximum: 1000
>> +
>> +      current-chopping:
>> +        $ref: /schemas/types.yaml#/definitions/flag
>> +        description:
>> +          If provided, the two excitation channels are to be used with current
>> +          chopping enabled.
> 
> Can I have a reference for that? My initial read suggests it's the input channels

No. :-)

I must have got two ideas mixed together in my head to come up with
this. Clearly this should be `input-channel-rotation` or something like
that (we discussed in another thread already). Also curious if you thing
any of these properties are common enough to promote to adc.yaml or if we
should just make them e.g. `ti,input-channel-rotation` (you might not have
had time to read the threads on that yet).

> that are chopped.  For GC_EN
> "When enabled, the device automatically swaps
> the analog inputs and takes the average of two consecutive conversions to
> cancel the internal offset voltage"
> 
> 
>> +
>> +      ti,vref-source:
>> +        description: |
>> +          Indicates the source for the reference voltage for this channel.
>> +          0 - Internal 2.5V reference
>> +          1 - Internal 1.25V reference
>> +          2 - External reference (REFP-REFN)
>> +          3 - AVDD as reference
>> +
>> +          For convenience, macros for these values are available in
>> +          dt-bindings/iio/adc/ti,ads112c14.h.
>> +        $ref: /schemas/types.yaml#/definitions/uint32
>> +        maximum: 3
>> +        default: 0
>> +
>> +    dependencies:
>> +      excitation-channels: [ excitation-current-microamp ]
>> +      excitation-current-microamp: [ excitation-channels ]
>> +      current-chopping: [ excitation-channels ]
>> +
>> +    oneOf:
>> +      - required: [ single-channel ]
>> +      - required: [ diff-channels ]
> 
>> +examples:
>> +  - |
>> +    #include <dt-bindings/iio/adc/ti,ads112c14.h>
>> +
>> +    i2c {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        adc@40 {
>> +            compatible = "ti,ads112c14";
>> +            reg = <0x40>;
>> +
>> +            avdd-supply = <&avdd>;
>> +            dvdd-supply = <&dvdd>;
>> +
>> +            /* 3-Wire RTD: Two IDACs, One Measurement (AIN1-AIN2) */
>> +
>> +            refp-refn-resistor-ohms = <500>;
>> +
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +
>> +            channel@0 {
>> +              reg = <0>;
>> +              diff-channels = <1>, <2>;
>> +              excitation-channels = <0>, <3>;
>> +              excitation-current-microamp = <500>;
>> +              current-chopping;
>> +              ti,vref-source = <ADS112C14_VREF_SOURCE_EXTERNAL>;
>> +              label = "rtd";
>> +            };
>> +        };
>> +    };
>> +  - |
>> +    #include <dt-bindings/iio/adc/ti,ads112c14.h>
>> +
>> +    i2c {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        adc@40 {
>> +            compatible = "ti,ads112c14";
>> +            reg = <0x40>;
>> +
>> +            avdd-supply = <&avdd>;
>> +            dvdd-supply = <&dvdd>;
>> +
>> +            /* Resistive Bridge Measurement With a Thermistor for Temperature Compensation*/
>> +
>> +            refp-supply = <&avdd>;
>> +
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +
>> +            channel@0 {
>> +              reg = <0>;
>> +              diff-channels = <6>, <7>;
>> +              bipolar;
>> +              ti,vref-source = <ADS112C14_VREF_SOURCE_EXTERNAL>;
>> +              label = "bridge";
>> +            };
>> +
>> +            channel@1 {
>> +              reg = <1>;
>> +              diff-channels = <1>, <2>;
>> +              ti,vref-source = <ADS112C14_VREF_SOURCE_INTERNAL_2_5V>;
>> +              label = "thermistor";
> 
> Hmm. I'm interested to see where this goes, but generally when we have
> a thermistor we attempt to ultimately convert it to a temperature
> channel and I'm not seeing info here to allow us to do that.

Since the hardware doesn't have any special features for handling
specific sensor types, it seems like a case of the driver trying to
do things that the hardware doesn't do, which we generally try to
avoid in the kernel.

For cases where we want a quick and easy (and not necessarily accurate)
temperature conversion done in the kernel, we could make a generic thermistor
analog front end binding and driver like we already have for RTDs and
(linear) temperature transducers. This seems more sensible to me rather
than having to re-implement such a thing in each ADC that could be used
with a thermistor.

> 
>> +            };
>> +        };
>> +    };
> 
> 

