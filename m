Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A0A43DA50;
	Tue,  6 Oct 2026 15:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791302369; cv=none; b=vFkYQFtR3RRm6nhaczPue9hayXDP21T24Ep5tk2FhcM+9OIE/Hsd3637f0NoE8kFG0IXBmGvtV+qLHXCTG1w8yb6d0GQXVJfQeUZd3Hp3lSjow9aWPW9ywEeFL3xs8oTA3i2TXzVs5pwOz8hOL9ItV558Efq7p9p/cZeQZ3Zlbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791302369; c=relaxed/simple;
	bh=tF4DZadjAnhSeunXrNq06uHSevNVFzYrRri2EGTqylM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nkX5wkjYubnb9bGvmYTT0vBsTAPNHEWXT+mAVQgF//fse7I9+YhP8z0UfafBeqZn1BCwKlm0xnLcbFWOkTIf6+AQZHpWX+kgX7aIUGPeepSUwN7C39vbWRbId1l/gPkh/YEIDEW/im7/apiE2QxziJuRq3X8aoW6UsAAf29KtPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gj/ThtFM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gj/ThtFM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9EE51F0089D;
	Tue,  6 Oct 2026 15:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791302367;
	bh=SOExgyoOJDUbBxw57Jd8DLtCxRntAzBWatUantBFvdo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=gj/ThtFM5d7BGT74qtbUMWUFB/5E8RvPRhphS+iJILnsq69ho4u078xsWhGo0Zhfb
	 Z50+tZCQzdFBhllFWAxd2oqD0AAK5Q/EC8Dh5+7fMHAgf08UWvBjQ2o1c8zJ0iRUIb
	 I2ik5/F/E1LevbG9Z7WGQxlbluqkG9GITJdjJ8OpH3+E2I8A1mCi3abd5N2g4Fmo9p
	 QCzCQtPmliZsJ8OswH4zFiC6CxZqIT29RqRAfm7Mg6nC5swdDYbfCN5QdCl+BJ9Iee
	 jannwXfaWD3UAaLB23T/80pV2GsAB5c7OmMFZzaM11Zv46Q4o5/INRKwXaFXv0oGxB
	 ZrYO5b5oKAPFQ==
Message-ID: <1aace5d9-82c5-419a-a916-756312afe599@kernel.org>
Date: Tue, 6 Oct 2026 17:59:21 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: iio: adc: add bindings for stm32 mdf
 filter
To: Olivier MOYSAN <olivier.moysan@foss.st.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261001145702.2628429-1-olivier.moysan@foss.st.com>
 <20261001145702.2628429-2-olivier.moysan@foss.st.com>
 <20261002-pragmatic-smart-piculet-cacb3e@quoll>
 <57322a17-7fae-434a-b60a-f879855cbb2b@foss.st.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <57322a17-7fae-434a-b60a-f879855cbb2b@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/10/2026 17:48, Olivier MOYSAN wrote:
>>>
>>> diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-mdf-adc.yaml b/Documentation/devicetree/bindings/iio/adc/st,stm32-mdf-adc.yaml
>>> new file mode 100644
>>> index 000000000000..f2fbc3e150e8
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-mdf-adc.yaml
>>
>> Filename follows compatible, so st,stm32mp23-mdf
>>
> 
> stmp32mp25 is the main SoC, while stm32mp23 is a variant.
> file renamed st,stm32mp25-mdf.yaml

Sure, that's fine.

> 
>>> @@ -0,0 +1,383 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/iio/adc/st,stm32-mdf-adc.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: STMicroelectronics STM32 Multi-function Digital Filter (MDF) ADC
>>> +
>>> +maintainers:
>>> +  - Olivier Moysan <olivier.moysan@foss.st.com>
>>> +
>>> +description: |
>>> +  STM32 MDF ADC is a sigma delta analog-to-digital converter dedicated to
>>> +  interface external sigma delta modulators to STM32 micro controllers.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - st,stm32mp25-mdf
>>> +      - st,stm32mp23-mdf
>>
>> Why reversed order?
>>
> 
> Ok. Reordered alphabetically
> 
>>> +  ranges: true
>>> +
>>> +  clock-ranges: true
>>
>> Do you need it here?
> 
> clock-ranges property is used to allow the filter child nodes to inherit 
> the MDF kernel clock from the parent node.

You answered why you need it in DTS. I question why do you need it in
the binding? Do you see a warning?

> 
>>
>>> +
>>> +  resets:
>>> +    maxItems: 1
>>> +
>>> +  reset-names:
>>> +    items:
>>> +      - const: mdf


>>> +        then:
>>> +          patternProperties:
>>> +            "^channel@[0-7]$":
>>> +              required:
>>> +                - io-backends
>>> +
>>> +      - if:
>>> +          properties:
>>> +            compatible:
>>> +              contains:
>>> +                const: st,stm32mp25-mdf-dmic
>>> +
>>> +        then:
>>> +          patternProperties:
>>> +            "^mdf-dai+$":
>>
>> This makes no sense. Why is this a pattern and why mdf-daiiiii is
>> correct name?
>>
> 
> "^mdf-dai$" is intended here
> 
>> Not mentioning that your are not supposed to define properties in if
>> block (do you see any code like that?). Mixing addressable and
>> non-addressable children is another odd thing.
>>
> 
> This binding is inspired by the one already adopted for the DFSDM
> https://www.kernel.org/doc/Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml
> 
> I assume can move the mdf-dai node definition outside the conditional 
> branch easily.
> However, it seems to me more complicated to avoid mixing addressable and 
> non-addressable nodes here. Can we keep this binding aligned with the 
> DFSDM model? Or would you have another suggestion?

Why was this model chosen in that dfsdm? The child has no resources, so
it should never been made a separate node.


> 
>> This entire schema is quite chaotic and overcomplicated.
>>
>>> +              type: object
>>> +              description: child node
>>> +
>>> +              properties:
>>> +                compatible:
>>> +                  enum:
>>> +                    - st,stm32mp25-mdf-dai
>>> +
>>> +                "#sound-dai-cells":
>>> +                  const: 0
>>> +
>>> +                io-channels:
>>> +                  description:
>>> +                    From common IIO binding. Used to pipe external sigma delta
>>> +                    modulator or internal ADC output to MDF channel.
>>> +
>>> +                power-domains:
>>> +                  maxItems: 1
>>> +
>>> +                port:
>>> +                  $ref: /schemas/sound/audio-graph-port.yaml#
>>> +                  unevaluatedProperties: false
>>> +
>>> +              required:
>>> +                - compatible
>>> +                - "#sound-dai-cells"
>>> +                - io-channels
>>> +
>>> +              additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    #include <dt-bindings/clock/st,stm32mp25-rcc.h>
>>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>>> +    mdf1: mdf@504d0000 {
>>
>> Node names should be generic. See also an explanation and list of
>> examples (not exhaustive) in DT specification:
>> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
>> If you cannot find a name matching your device, please check in kernel
>> sources for similar cases or you can grow the spec (via pull request to
>> DT spec repo).
>>
>> And drop unused labels.
>>
> 
> The MDF is a digital filter for sigma-delta bitstreams, rather than the 
> analog-to-digital converter itself. So "adc" would not be adapted. I did 
> not find "filter", that probably would be the more relevant generic name.
> The closest similar case is the DFSDM peripheral, which already uses a 
> specific naming:
>      dfsdm: dfsdm@4400d000 { ...
> https://www.kernel.org/doc/Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml
> 
> What is your recommendation: keep the naming "mdf" or make a pull 
> request to add "filter" or another more appropriate name ?
> 
>>> +      compatible = "st,stm32mp25-mdf";
>>> +      ranges = <0 0x504d0000 0x1000>;
>>> +      reg = <0x504d0000 0x8>, <0x504d0ff0 0x10>;
>>
>> Address ranges of 2 and 4 words?
>>
> 
> These two sections correspond to MDF common registers managed by the core
> - Control registers: 2 x 32 bits registers
> - Identification registers: 4 x 32 bits registers
> The other registers are managed by filter and serial interface driver
> 


Unfortunately this leaves impression of incomplete DT or too granular
split of devices to match your driver model.

Best regards,
Krzysztof
