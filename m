Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794363357;
	b=aPgM0c0UAKGReaF4IQbS/yu/ezR0eBSVa+tckgPURudrlpLrQ+z7H9/V4wsNm5/qBMrB
	 MAgsinavknxf8h1ZnEtALLm6q5XwZCTBQV2fTnj4OVc4Ejr6CoHQa1Jc3S1ONRSvUkbLL
	 jQWpimKXPCT9aJtRvkjzJMVTRNQ/fVl+F6VoIvzwIvuAdzmwSEA+uuYWTZeZaAoRP6znq
	 aG0Z1mKVgyIItiARFACWNYQ6nIjxuC3WdmLPbV5buuQWWhv+AYE8hkTsVU2hEXHl4vBzR
	 fVbDhP8QOj9wgzli0Q5H62iEb0CjCjJfTPYb2Oe1/LTaVDYvqzYSXCaL3QyA4rfmQEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794363357;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=T+BHmu+//774PUA/C/Ol2aryXkGv6dUO8fp7NLeJH6s=;
	b=BdVovERY8MtdEUer887CzQhKHncJ5X2+Sg2C8hMDAfuKEMJhakdfd3QspvybJMvAU8y0
	 cPWNOSkvXx/cJFY5HishJVEKMyNoLLrTO6t3y+6N6kllzQUbFS3thqi7y43reSzNHnLp3
	 /uwVC9t4T/TBoDIt/sARQyRTQ9NlnUiyDdXIW6vTILndoEvNhg/kL/YoYK3h9totsJHdx
	 PxXPzkcGyozNdkwSeTONEi6u0Mt1m55cmJEZI0zkgUHv1lzwqAyuUB774Fmt4eRi+Wa4X
	 xsKXr0yVGrexorWfCeUY9KJHjUwCSsDsjCvhCwesmNWZK+HdfQwXBnm7X234ZZAICYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CXt+3qNM;
	arc=none smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8CA60A260A
	for <linux-iio@vger.kernel.org>; Wed, 11 Nov 2026 02:15:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E8CA60A260A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CXt+3qNM
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cdab8873d9dso1148945a12.1
        for <linux-iio@vger.kernel.org>; Tue, 10 Nov 2026 18:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794363355; x=1794968155; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T+BHmu+//774PUA/C/Ol2aryXkGv6dUO8fp7NLeJH6s=;
        b=CXt+3qNMRUnbm9t+MkTTz3ayoItXXbLXGTb74ZqGgPCAYHfi0DgG/z6y5RITKqItsk
         k6vvHupJDYBt9YcOMj1oXW+YxBam1oSfWseWvPvBxUfYbjgceCN/TaxzLrmJACeAFMWp
         JS62vrb1VX+E9RFoZkNgBEVCriCTfDiVjpT8xQsYSK2aR/vkWhpHE5KeqS0isSjwdPpa
         k4tBoQoxvFvaalIeSSHUTn13nE/54eyRsv4aQeeOyJrrwR2/m27MeVGYf4eL20Z9DfM8
         /h04UGc5MrxyAuwJN9eNAqC0/eQVvYXSkKeGn9/QlmKdQSoEb5QZOd3PZFpg5gjrheq2
         osuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794363355; x=1794968155;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T+BHmu+//774PUA/C/Ol2aryXkGv6dUO8fp7NLeJH6s=;
        b=Dt7JQd3bjyntGzpnRMh6s3eJGKqb/5Pm5bWc2E+PoZPTPQYLUOhEUViJaJFu3FUC0m
         TU5ZhOduen+49htVR5SOqb+k5xnqTTY0cPUzTea36SZ1cdshkAMi0vgghm9Q78JMoH6n
         p5l7qehKIdIgCbL1o5cF0nGlkf7o7cS1Wf+RT5TJMxoOknCmqEHkfFWBbitILVX523Md
         VL98lzaB58rMZodDI+k4uDzkLelaMhkFliAiqjx9hbEwEj3rqwYD5ztekhq3ArxjnD32
         iA6s4/IDsbGt8M+yMk1pf6fnncx9DqXnFZIxy9tk5NGdPipfVIjycHgKXPbiASYOKrr6
         b7rQ==
X-Forwarded-Encrypted: i=1; AL+hErHaTdbf13CSxcNxi7zyQRxO4A/KMF9UnQjno1sSaFdv9cDqPm6zZThlNemlLoe7GlqPtxbP6UFXClw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/b+AjSQudaaPa9hS4fcapw0nGYIzYR16pgEF/RGJklmDAdPE6p
	QEhBBzVTABJmdc74e/K6XuAOLR7bWEaIKBZaheoULUHYuDdVYu9QQTRA
X-Gm-Gg: AYBFou1cbwA+KMIuus1VmPKNQvCpENMS5mtQP4kfYd9tubYnVGrwgX29c2LVTlR340g
	i2BvPIShKM5z+/YdtQX2DHxubofID5TmJfypJeCM6XZpdn5R9g4P4GOMixJYqVqwDR6oiNBl99f
	ghzkNuDrQSldPvoWbsOsLOE5MStIrhMuX//Nlz3IrGXKQlCbRq7tUDng1QAfW8jkgsee3jjLV5u
	p6BkVt20ZeS/fiYOiOxxt5y7QHdJW9DMk9Et6QRqGilrh//g+UCCeSTdGuNLtfolpMqgh3yQKow
	Wydnsz56+/Gkf/Z3y55YU5a8tma1cRUv3r7yaTHE5zGucN3dnK+R/GMBJvDCHmj1Rb+5Mg6ZyXT
	36G7hGxkVp0pmtIAwnjypnE/HUBMsF6XeG5tIIPHXrv8Hn+SD/F11DFIouJBbZaHot+6wO7WCNK
	6KYgfjdnboeNEOp9sub9U7GEL6Ou6gCO2+4Joh9wppdP03/o0oFWO3p0FWJK9/eCaGmOvPN0rCg
	NEjFc8ga/x/U+toouVY9mLajciuwafUkPij9D7y+tlGttJb48e4ga51ZehPbP7ZLm6qc8xILrn8
	rS49+zY4s+ixDaEx1X5pu4cHXMgB8HVFa29fjYYGgCTLwYTZssBaCf5qhbpcj5RagkfAzWV94yu
	+9VYP0gRCe1dw+sCcWzvrlCwn8w==
X-Received: by 2002:a17:90b:2e83:b0:3a7:8350:3f7e with SMTP id 98e67ed59e1d1-3b182fe6fc9mr915474a91.44.1794363355359;
        Tue, 10 Nov 2026 18:15:55 -0800 (PST)
Received: from [172.19.1.42] (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b17e1d73d1sm1920215a91.11.2026.11.10.18.15.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 18:15:54 -0800 (PST)
Message-ID: <f01f7e4b-8c71-461b-bd1f-28de2594abbc@gmail.com>
Date: Wed, 11 Nov 2026 10:15:51 +0800
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: adc: Add Nuvoton MA35D1 EADC
To: Rob Herring <robh@kernel.org>
Cc: jic23@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, cwweng@nuvoton.com
References: <20261104091136.151269-1-cwweng.linux@gmail.com>
 <20261104091136.151269-2-cwweng.linux@gmail.com>
 <20261110190827.GA1322356-robh@kernel.org>
Content-Language: en-US
From: Chi-Wen Weng <cwweng.linux@gmail.com>
In-Reply-To: <20261110190827.GA1322356-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Rob Herring 於 2026/11/11 上午 03:08 寫道:
> On Wed, Nov 04, 2026 at 05:11:35PM +0800, Chi-Wen Weng wrote:
>> From: Chi-Wen Weng <cwweng@nuvoton.com>
>>
>> Add a binding for the Enhanced Analog-to-Digital Converter found on
>> Nuvoton MA35D1 SoCs.
>>
>> The controller has eight external analog inputs. They can be used as
>> single-ended inputs or as the four fixed differential pairs 0-4, 1-5,
>> 2-6 and 3-7.
>>
>> Use the common ADC channel properties to describe the physical input
>> independently of the logical channel index.
>>
>> Signed-off-by: Chi-Wen Weng <cwweng@nuvoton.com>
>> ---
>>   .../bindings/iio/adc/nuvoton,ma35d1-eadc.yaml | 163 ++++++++++++++++++
>>   1 file changed, 163 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/iio/adc/nuvoton,ma35d1-eadc.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/nuvoton,ma35d1-eadc.yaml b/Documentation/devicetree/bindings/iio/adc/nuvoton,ma35d1-eadc.yaml
>> new file mode 100644
>> index 000000000000..85b0feac0236
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/adc/nuvoton,ma35d1-eadc.yaml
>> @@ -0,0 +1,163 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/iio/adc/nuvoton,ma35d1-eadc.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Nuvoton MA35D1 Enhanced Analog-to-Digital Converter
>> +
>> +maintainers:
>> +  - Chi-Wen Weng <cwweng@nuvoton.com>
>> +
>> +description: |
>> +  The Nuvoton MA35D1 Enhanced Analog-to-Digital Converter (EADC) is a
>> +  12-bit successive approximation converter with eight external analog
>> +  inputs and one internally connected VBAT input.
>> +
>> +  The external inputs can be used as eight single-ended channels or as
>> +  four fixed differential pairs: 0-4, 1-5, 2-6 and 3-7. The internally
>> +  connected VBAT input is not described by a channel child node.
>> +
>> +  The controller provides four interrupt outputs, ADINT0 through ADINT3.
>> +
>> +properties:
>> +  compatible:
>> +    const: nuvoton,ma35d1-eadc
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    items:
>> +      - description: ADINT0
>> +      - description: ADINT1
>> +      - description: ADINT2
>> +      - description: ADINT3
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  resets:
>> +    maxItems: 1
>> +
>> +  vref-supply:
>> +    description:
>> +      Optional external reference voltage connected to the VREF pin. If this
>> +      supply is absent, the controller uses its internal 1.6 V reference.
>> +
>> +  dmas:
>> +    maxItems: 1
>> +
>> +  dma-names:
>> +    const: rx
>> +
>> +  '#io-channel-cells':
>> +    const: 1
>> +    description:
>> +      The cell selects the logical EADC channel identified by the reg value
>> +      of the corresponding channel child node.
>> +
>> +  '#address-cells':
>> +    const: 1
>> +
>> +  '#size-cells':
>> +    const: 0
>> +
>> +patternProperties:
>> +  '^channel@[0-7]$':
>> +    type: object
>> +    $ref: /schemas/iio/adc/adc.yaml#
>> +    description: |
>> +      External EADC channel description. The reg property identifies the
>> +      logical IIO channel index.
>> +
>> +      A single-ended channel may use single-channel to select an external
>> +      analog input independently of reg. If single-channel and diff-channels
>> +      are both absent, the external analog input is selected by reg.
>> +
>> +      A differential channel uses diff-channels to select one of the fixed
>> +      hardware input pairs: 0-4, 1-5, 2-6 or 3-7. Each single-ended input
>> +      and each differential input pair may be described at most once.
>> +
>> +    properties:
>> +      reg:
>> +        maximum: 7
>> +
>> +      single-channel:
>> +        maximum: 7
>> +
>> +      diff-channels:
>> +        oneOf:
>> +          - items:
>> +              - const: 0
>> +              - const: 4
>> +          - items:
>> +              - const: 1
>> +              - const: 5
>> +          - items:
>> +              - const: 2
>> +              - const: 6
>> +          - items:
>> +              - const: 3
>> +              - const: 7
>> +
>> +    allOf:
>> +      - not:
>> +          required:
>> +            - single-channel
>> +            - diff-channels
>> +
>> +    required:
>> +      - reg
> 
> The allOf and required are effectively covered by adc.yaml already.
> 
> Rob

Hi Rob,

 > The allOf and required are effectively covered by adc.yaml already.

The channel-level required list is redundant; I'll remove it.

For the allOf, adc.yaml currently has:

anyOf:
   - oneOf:
       - required:
           - reg
           - diff-channels
       - required:
           - reg
           - single-channel
   - required:
       - reg

When both single-channel and diff-channels are present, the inner
oneOf fails, but the reg-only branch still satisfies the outer anyOf.
Removing the local constraint would therefore allow both properties
together, which the driver rejects.

Should I keep the local check, or move the mutual-exclusion constraint
into adc.yaml?

Thanks,
Chi-Wen



