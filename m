Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA383B71CB
	for <linux-iio@vger.kernel.org>; Fri, 26 Jun 2026 18:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782498927; cv=none; b=P+wGXUN9+GYCeL5Q5ctnWEkl26QlKT7eN1O5ccE8BRJnJeMC/5QYPWRijPmH8ZhigIa99Rj11o0JBzDvyhdCJjlqKp6KEt9QjaNMyU0o672rtZNkbn0q+yG4Sa3rzN94+5IaD8MyjgQmXeDATIndHb9hrhg7gW/gb6rHz6IgZrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782498927; c=relaxed/simple;
	bh=dPfHlgQgWfT+hU6VgO6lR7zUegvTyInzXHbdMXw7UNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qD9Ai29eSoDCSeF1Eu9rUWza3S8ba2SuLxo0uvKAi11BVpZlomXLpOWqDCqrzrry/DrakHFjaB3sSMDrT7pCEHF32/LGgobGz5oHhR88Z23cvOmeDKvf4nBLHfmqw/fXswvnU9iSg6aaixL3T++rdEhKhmel0jQTwpg4VhsnjjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=OlVR12Dq; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="OlVR12Dq"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7e6dcc22cbcso997706a34.1
        for <linux-iio@vger.kernel.org>; Fri, 26 Jun 2026 11:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782498924; x=1783103724; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J8Kzxi9SsU9PSUvyY7AuuVFjnGlx1l2npBtoEXDb+RU=;
        b=OlVR12Dql92QYjC5bpaCynMWUJ3W1dy26/XomWvWFRmeLweIdSuyEMR038qhbybbTW
         zEA5xFmchT+BY2tA/DnO9kiGNMBNfYRokjazhS56UQAgvsWXJ2xAF9F1nb8GTbZ6ZUrO
         Mi/vT5LnD+2Ms5QK4TOOMR/b2oatrbZGk2mj3GDOciHDivLun7RwKSs0/FmSwOG0oGge
         q11HxtZi1KackdHccM3JyVZUkTXh/k/qCD+9bmfMnnXoE0zMMZlK5sd9rYlbvWp/M694
         1jtkTx43e24O2S7THDVLxvbXiaax6qJIHcgr/2yVsFz7RGNwH2eL1Oel+bzfPF6U6n8d
         KjDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782498924; x=1783103724;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J8Kzxi9SsU9PSUvyY7AuuVFjnGlx1l2npBtoEXDb+RU=;
        b=U99p7X1ECvfLBx7bFfAWO7n32PgujcNU0erMw1dT/wuuT8ysLHM52pdkxRnTaPA0XO
         22KeeV1uXcwef/dhjAPSAK6RQRTLV4m8avuWgqBMUd6Qo4u69SvHfmHgANdxWMs1A09S
         vpmzvY3aCNFgizmJHZTtzM2WsDgKOL/XgTepI3SLsYlycDKyngy9zvmiAeZ3vDf48FCd
         qCcmNWcEltW0exh0oKz8nkvc8I3Rh/7SFrNtNz9qaU+MeLb/xGbXLbXOMclyl+Lw82Ck
         4VZo6E5a5IG9CLL1XoCvckxBml6bk4lJxVaEkiVkxrL28OLkZxeqlZnHOYg7fd7NCdwZ
         VP1w==
X-Forwarded-Encrypted: i=1; AFNElJ9mYhs2RCCrmNnBTIPbTZf/uR8ydEW6chq8BoxbX5bpvCP1iWMwrV5jJFRYGvuFR4UqWkCAbkZ/uFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdR5DQLYmjGRe5ybkdOss2oGES+ye8dDUQVsNTMvRVW9ZABaVE
	2Q2wRm9G+XnjXhVqsDBUGSGqkI/HdijvhBs5ApIFMgHuqjCeg8j9L7qLgPyVmSwolaQ=
X-Gm-Gg: AfdE7cmnOc5kaleO/PlUpb8kHgzKVeEqim98MFj0x8z5933VVUTRN4y5XopQ48m3kDt
	L0Inisw1tuAgnzB/yy6eBL135Sa2ByldwGHSgWKycnonj900mbCmilBHBJ5IdqLt0UclxHO5tFP
	IyAw0mIwz61STJNnSMitwuxbgoWnCP+1M6hsccLyrPveFs9DIUEO/QI2DCHw3PnRTziOqEUjjW7
	ttpPeMosBMMCxD1Q8ik/MSOJ9TbhliU1a9hf66aEEaDxSL5iD7vfTNa4+fVDJRH01fVN1CZQmow
	tduOUCPTNiDuNsFvs0ug3kQl5qp3m+3btFipyNFNsSdg9htn903FZxPLc2jNNkAyx+qVvo1zjXj
	GNbdeBVko87S0QVjOw/gY7kK9OFSlf6neeJxlgo1w8bT2HdPHdO8eqhtpVwJG/O0QjYmHiSlen3
	fyaeqp11tWso1g5y/T7GKCKw5Qcmg24Y1TMS1NrL2iDN6W0mKifSD/I4P0wK27Wo8=
X-Received: by 2002:a05:6830:2781:b0:7e9:b4d0:53a2 with SMTP id 46e09a7af769-7e9b4d05d30mr1036708a34.27.1782498924389;
        Fri, 26 Jun 2026 11:35:24 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:f1f0:2d9f:2f31:3426? ([2600:8803:e7e4:500:f1f0:2d9f:2f31:3426])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e9aa7d5b3asm2176015a34.23.2026.06.26.11.35.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jun 2026 11:35:23 -0700 (PDT)
Message-ID: <82294468-c4cf-4003-93f1-31a113c79979@baylibre.com>
Date: Fri, 26 Jun 2026 13:35:22 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] dt-bindings: iio: adc: add ti,ads122c14
To: Conor Dooley <conor@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chris Hall <c-hall@ti.com>,
 Patrick Edwards <pedwards@ti.com>, Kurt Borja <kuurtb@gmail.com>,
 Nguyen Minh Tien <zizuzacker@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260625-iio-adc-ti-ads122c14-v2-0-ceb9b0b561cb@baylibre.com>
 <20260625-iio-adc-ti-ads122c14-v2-5-ceb9b0b561cb@baylibre.com>
 <20260626-rising-legged-dea08bb68bfe@spud>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260626-rising-legged-dea08bb68bfe@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/26/26 11:18 AM, Conor Dooley wrote:
> On Thu, Jun 25, 2026 at 04:55:07PM -0500, David Lechner (TI) wrote:
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
>> ---
>>
>> v2 changes:
>> * Added ti, vendor prefix when appropriate.
>> * Others are now standardized properties from adc.yaml.
>> * Moved top-level unevaluatedProperties.
>> * Fixed some issues with the channel@ matching and reg property.
>> * Dropped description on bipolar property.
>> * Renamed currnet-chopping to input-channel-rotation.
>> * Drop header file and use string enum instead for reference-sources.
>> * Added burn-out-current-nanoamp property.
>> * Drop allOf: and just use oneOf: directly.
>> * Fix inconsistent indentation in the examples.
>> ---
>>  .../devicetree/bindings/iio/adc/ti,ads112c14.yaml  | 205 +++++++++++++++++++++
>>  MAINTAINERS                                        |   6 +
>>  2 files changed, 211 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads112c14.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads112c14.yaml
>> new file mode 100644
>> index 000000000000..59ee4d652a08
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads112c14.yaml
>> @@ -0,0 +1,205 @@
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
>> +  ti,refp-refn-resistor-ohms:
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
>> +  ^channel@[0-7a-f]$:
> 
> How does this work/what's the intention here?
> 
> 0-7 I get, why a-f but not 8 or 9?

bah, just a typo, not intentional

Should be [0-9a-f] to match maximum: 15 on reg.

> 
>> +    $ref: adc.yaml
>> +
>> +    unevaluatedProperties: false
>> +
>> +    properties:
>> +      reg:
>> +        items:
>> +          - maximum: 15 # arbitrary limit, channel@ can be any combination of AIN0-AIN7
>> +
>> +      single-channel:
>> +        maximum: 7
>> +
>> +      diff-channels:
>> +        items:
>> +          maximum: 7
>> +
>> +      bipolar: true
>> +
>> +      input-channel-rotation: true
>> +
>> +      excitation-channels:
>> +        maxItems: 2
>> +        items:
>> +          maximum: 7
>> +
>> +      excitation-current-nanoamp:
>> +        maxItems: 2
>> +        items:
>> +          enum: [1000, 10000, 20000, 30000, 40000, 50000, 60000, 70000, 80000,
>> +                 90000, 100000, 200000, 300000, 400000, 500000, 600000, 700000,
>> +                 800000, 900000, 1000000]
>> +
>> +      burn-out-current-nanoamp:
>> +        enum: [200, 1000, 10000]
>> +
>> +      reference-sources:
>> +        items:
>> +          - enum: [internal-2.5v, internal-1.25v, external, avdd]
>> +            default: internal-2.5v
>> +
>> +    dependencies:
>> +      excitation-channels: [ excitation-current-nanoamp ]
>> +      excitation-current-nanoamp: [ excitation-channels ]
>> +
>> +    oneOf:
>> +      - required: [ single-channel ]
>> +      - required: [ diff-channels ]
>> +
>> +unevaluatedProperties: false
>> +
>> +required:
>> +  - compatible
> 
> reg?

I thought reg being required by i2c-controller.yaml was already good enough.

https://github.com/devicetree-org/dt-schema/blob/2203c1720f4ebeebd7f8d10e9dc1812993482fab/dtschema/schemas/i2c/i2c-controller.yaml#L219

> 
>> +  - avdd-supply
>> +  - dvdd-supply
>> +
>> +dependencies:
>> +  refn-supply: [ refp-supply ]
>> +
>> +oneOf:
>> +  - required: [ refp-supply ]
>> +  - required: [ "ti,refp-refn-resistor-ohms" ]
>> +  - properties:
>> +      refp-supply: false
>> +      refn-supply: false
>> +      ti,refp-refn-resistor-ohms: false
> 
> I assume you've tested this to make sure it enforces the behaviour that
> you want?


yes

