Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE57F3769F5
	for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2026 19:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788205469; cv=none; b=s1JjYAs8BU5joS2uIIxf7l267nPHDQ6sDenH3jTjTrhdIWD7Ymp6G3Xqu5U/zXvKFoBqX0R+g/c0Tpx487AgQsRb7Q64YC86lDb9f5sx83T2btKLMBzORbhuHHvnPwIUj2fJptyNSCEHALhQl0P1zkXTVEYOw9v68w9HsGK+vsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788205469; c=relaxed/simple;
	bh=eWpXRhxHS2WF406Ert5+8cxUb29KHQLVMqQPlC+E5vA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oB3mqm9cwmW2IEVk7XAdu9QfNuvAhroa+cLlyQ+/jAe8coIu8P+GMvzD2Xf8e9vYEymuXaHkWyFB+MydCThk2HG58c56e5aVGGp0MGuGBdq3hwQH78rmD4AQuNz1LgX2+opESW56fbuVrNo2KOXDOmV/9v3lKdbTpTdG4wKeB/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=d9fJEm2/; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="d9fJEm2/"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7f4f3683fbcso265762a34.0
        for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2026 12:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1788205465; x=1788810265; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IGP7GGTvrEowNva1rbNoI+VHdtW9WuY11cAsUH1ZGFI=;
        b=d9fJEm2/EoHMYtc3tZWjdZcR21hq8CFqm1RLJkTqk3Y95VoFSTqW593IZ5r2FIYqK2
         jzgP3BAqTfR5LfaUJaaW96Wknlie6LmkDuOKuYRH5VqJXqYGMwWd3GuLXAKuLj16jYIy
         ahywBIPSl/fFsnKUlEX+ahiwE17ijDmXVoUGdmTCgN2IhvthMIefzA3ewh6JIK/bjVar
         PglNOU8MkgfKqWwebFP5/6AguRNODrokx04Edib6BQGg+tR8YRf1vQDgx9Dkwhd70QnH
         2JwyAPX+dJHjgVqv8jFcyuYCTTfXG4lmeRi0wh8JCGCjAVtFIoqG4YcsusG6I0ZZ+dFz
         DfaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788205465; x=1788810265;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IGP7GGTvrEowNva1rbNoI+VHdtW9WuY11cAsUH1ZGFI=;
        b=e37q41nG1Rxvh6rsdF5KH85XPcBBbTrQKfMXFUBOP2cOVICSRdZ2G4iWKErKtPF4Ea
         aQ/B5jQepxK9gvSLKFP10/hFAFV1KouAvRISASHCCeNcBieRLr7gJHAe6gue9L61MTGo
         T3XR3UtzTzgSFkPlayrIkQzR7peTcNe1p2+sVuk35NcH7RFUOslizWOYAV+bDOBS8a6f
         2XO3J1rruFHC9qkFqb51tE2d1fiHIFhpO3yX4BMCrxHbxyeh6yJDHx0GjtJu9UIMLnhj
         B4hymD2KBC146PcYKBRHU+lwL7bbPDsd8qNrts3msqIEOZUKyr9jRC45lMGsddSSMy+n
         890Q==
X-Forwarded-Encrypted: i=1; AHgh+RrQvNDX//Zdcftqa8Cj3iEC8qxyLbY82wGEaqea3UKdWbIRFsiEuNLR8iO82MbNrsmiJslDmvXV/sQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mpMLqC6fFaV7TAZ5aqslYBkB/DAA/9ZHLFhtr3ELjOlDeeOvYo
	t+B2k1UUlVlOXbOc8NWnm/iHptQmtkyefAKKmj99YSRPl4XEwT//cRiGL2SLZMevQBU=
X-Gm-Gg: AR+sD11Yttcu4OreZLFimYyRHpN+GgF7xa8S/DtH9WiECKIuuMBb2hHsu7WABptOjAH
	L78L+yn1VK990WU8/cdQ1efhcMA2qEW8acJlAUue/jeFULLWabRhu3f+pGua3lAe1BSvVCTU4My
	0eIW+8GLbvB6SdTiSL8aoAQBdxIuWJ/nxEe25nPuYkUGzU7Qh9sa5Jf0yULDcqzjjOL/NwzYHzv
	A/0g5ijb2NLVGYX5NZKNR/isy3vGjcKEmzJU+0oxCyMYEQ+FB0+40K8aDtTov9tGpgM25Nx0vV/
	R2AdJNumBy7U1JSc4Z6jdyLESTmtNB5Pj9Z/RoJ2tj4tO8Ajaqe+vsMimJ6UnMItlSOAGudtRBy
	hm0h9PPBHsxs5EEgkcmoyFijTQbtybQY6rhwO2FGBpVCVgy9fWoQf8iNxjXK4/P6ZZkCsE6xBVG
	9NK/DnZzhz8VIRZ69TR8mwBtblkX2HaChZXNas4TITnnTYYR8z9MmVYXWTdeZ4opOl9biVw8Kl3
	xX4ZhPhAOPmlkVfftGOKJAXMNecrvblOLvg
X-Received: by 2002:a05:6830:8545:20b0:7e9:ca12:37bf with SMTP id 46e09a7af769-7f68f5d5015mr470147a34.7.1788205464675;
        Mon, 31 Aug 2026 12:44:24 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:778b:da9:a8a1:bc78? ([2600:8803:e7e4:500:778b:da9:a8a1:bc78])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f4fa7e92c1sm8939784a34.8.2026.08.31.12.44.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 12:44:24 -0700 (PDT)
Message-ID: <aae42329-f531-41fc-80df-2cb5e445f1db@baylibre.com>
Date: Mon, 31 Aug 2026 14:44:23 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/10] dt-bindings: iio: adc: support the TI ADS126x
 ADC family
To: Kurt Borja <kuurtb@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260828-ads126x-v4-0-1dc27e9c0260@gmail.com>
 <20260828-ads126x-v4-2-1dc27e9c0260@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260828-ads126x-v4-2-1dc27e9c0260@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/28/26 1:38 AM, Kurt Borja wrote:
> The ADS1262 and ADS1263 are 32-bit, 38.4-kSPS delta-sigma ADCs with an
> integrated PGA, internal reference, excitation and burn-out current
> sources for sensor biasing and diagnostics. The ADS1263 is compatible
> with ADS1262, but includes a second auxiliary ADC (ADC2) to perform main
> channel (ADC1) cross-checking measurements, system background
> measurements, or temperature compensation of the primary sensor.
> 

...

> +  '#io-channel-cells':
> +    minimum: 1
> +    maximum: 2
> +    description: |
> +      The first cell selects the channel by its reg. The second cell selects
> +      between the main ADC (ADC1) and the auxiliary ADC (ADC2) as follows:
> +        0: ADC1
> +        1: ADC2
> +

I like the suggestion to make this always 2 cells. Makes it simpler. And
to put ADC first.

And maybe make the first cell take 1, 2 so we don't have to make the
translation?


> +  "^channel@[0-9a-f]+$":
> +    $ref: /schemas/iio/adc/adc.yaml#
> +    unevaluatedProperties: false
> +

...

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
> +          minimum: 1
> +          maximum: 2
> +      patternProperties:
> +        "^channel@[0-9]+$":

These don't match the pattern above (missing a-f).

> +          properties:
> +            reference-sources:
> +              minItems: 3
> +              maxItems: 3
> +              default: [internal-p, internal-n, internal]
> +    else:
> +      properties:
> +        '#io-channel-cells':
> +          const: 1
> +      patternProperties:
> +        "^channel@[0-9]+$":
> +          properties:
> +            reference-sources:
> +              minItems: 2
> +              maxItems: 2
> +              default: [internal-p, internal-n]
> +
With those fixed...

Reviewed-by: David Lechner <dlechner@baylibre.com>
