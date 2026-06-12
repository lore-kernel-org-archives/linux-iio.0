Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F6D374E66
	for <linux-iio@vger.kernel.org>; Fri, 12 Jun 2026 17:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781284045; cv=none; b=oj9ClWXHViYQekzzg79X8mJSF3Tc8M+ELHZbcuT3nJFOH06mPo3s66zT1INWOz158VCXyUMi950NzrwhFSM9qlwmAnwSqo/gWjlgPsD9mElhXG2lWw3TNrOSKD6xXajNN9h7WRoKbhUVGGM2nq5rwxBeH3UlNNebwmjQSbc981w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781284045; c=relaxed/simple;
	bh=s8kIyI8Kg8mw2/G73/sI5WPB5OMwNe7xM80CIqvV0jA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=GwFb+eEUxeRvCKXCB9MrjScmfZxq26BpTu2ukO2loWRsgAf3jAOudOvP+iLbFBQEw6Ko6Rlv9/j1ii5P5douTRwrns+Tu3O3Z2D7sp+8kWzWAQSWnzpIO0CIf7NyZsPyeMVSV9cb7QgU3WTzkF6YfODD1+cK62CNLHksgbCtal4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=YGEDnQQU; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="YGEDnQQU"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-4871618372cso903257b6e.3
        for <linux-iio@vger.kernel.org>; Fri, 12 Jun 2026 10:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781284042; x=1781888842; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xKBQNOcRDd3e+ERR3iAVHd2ZwLSI7ZZFaqAB8m1VpdM=;
        b=YGEDnQQU0Z8Dh39IITsQxB7QhrG51FX9zkqfdX0w0wXn69gdNM9U0SI7SkAkKafdwm
         4YXkvTCg/LbbGl+/ljjB7d+LQrdvumzaEx+HkaRiu/HAsiUERgQpHED5a6fvr50V8vm6
         Be9fv2Pn+ZyyDCsE1fHMb/RK13f6g9GkgBvfaFmYxIasBLI4T6rXDHnXnrs6v8c2+kri
         QIlV52kcKtqa5FRMvDcaIIdTS6VeTNu81dUhyi9P00isWYsvoCKR8RgHPZAz/BDomHlB
         +ISRJo1hKO6VV2/DWhYf5puP6qt0WUP7bZgdLwOYULhs9lYxLRlTj+M5/7rz8tyIjAA+
         mJ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781284042; x=1781888842;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xKBQNOcRDd3e+ERR3iAVHd2ZwLSI7ZZFaqAB8m1VpdM=;
        b=shQ/ETofM9ozft9IuGqQ16X3CO8FHf79P9NQxRXMHaK8wi7Ahco6ZzRcmC+93Tc0h+
         yd82OhgIhrpl/H6g5OwLgeyjcGqJqLPI/5jFDCJFByNYeOOJ+BrfG/cu/bUswVKeocyK
         Q+IDpASHzBaYx3F6kj8G25H9i36cmbTqnoHYuE8+RNWQZjOaN726QL2jvIIPPCS/7t6H
         Rv2Gd2oIkbULVkyhJ9Qd4anMihwU4WRDlZYkSjSUEfk6AYKoEGVtXIfdxv5D4iMs9fY3
         5vHeWHbmuNRE4XWVqkYWKt5TVvcIwmPY7o3qFXCqQa0F9D6gduvTvifV3DJ2AD1t9L3U
         veig==
X-Gm-Message-State: AOJu0YxiAk7wmas21wQ419PXsDJaBHh8k7739+2TD9dMXFu2abIkSOLT
	ENHguaieUI3KkNYQdq5jrN3T4EHZNdkqI/5p6ZbI9Ei8RaikEqvGR5J9ASUipiVd8+8=
X-Gm-Gg: Acq92OGSsrv0FqqNpyMAbF5f/E+iPvw/WRVy2+I1ziT4N1bXQnqEsXADV5GsLkyA99d
	ab4D+nTTQabvSkTJ1Vz+UN9FVmlzw4/SQH9iOavDobyqKshobBFcdtncvsfimtss843bmwZV/fV
	Za9d9jf4Sj0RbQjtFuu5GpV0/j/lRkAo3YL16NZF9NuvFwPxzPIPzY9MPorSCl9HYc6hfKONWlP
	PPHTlxDhXskGKeHOlARteJNYIlQAUIYLihWTkCvjhgkh/NCr31J+hZZMEAYzWOeljl4PpOhK+hG
	AqpXOtbP4d8jDuCFsbAAoJv8bUL7X3q5VGoWGJWXKfCy2BhkaKiJ60QuhnoOZtAkZSGDBsTaOif
	tUB4BxgFtTwNDRsk9b/4SawtMECCp97oZBJFe3oGu8vepd9oeWLrS9BkSSM27P0LC/Pb3nhonZs
	uQAc+RVXaEdc3UO/hzhjRvxlpdS5khG1rE9bDgFV1rBb9B3Yv6MtZSe/i870sdiZwpvCx8R2rV+
	ujGwqM2Tg==
X-Received: by 2002:a05:6808:6f8e:b0:486:4f16:796c with SMTP id 5614622812f47-4872f55c651mr2546586b6e.33.1781284042259;
        Fri, 12 Jun 2026 10:07:22 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:cba0:23d4:353:6048? ([2600:8803:e7e4:500:cba0:23d4:353:6048])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4873158579csm1336573b6e.14.2026.06.12.10.07.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2026 10:07:21 -0700 (PDT)
Message-ID: <fd8d485c-8251-40cf-925a-5425fdd8b98a@baylibre.com>
Date: Fri, 12 Jun 2026 12:07:20 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: Add TI ADS1220
From: David Lechner <dlechner@baylibre.com>
To: Nguyen Minh Tien <zizuzacker@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20260610151342.44274-1-zizuzacker@gmail.com>
 <20260610151342.44274-2-zizuzacker@gmail.com>
 <788b7c6f-fae8-47cd-b78a-33f2803d8c88@baylibre.com>
Content-Language: en-US
In-Reply-To: <788b7c6f-fae8-47cd-b78a-33f2803d8c88@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/12/26 11:10 AM, David Lechner wrote:
> On 6/10/26 10:13 AM, Nguyen Minh Tien wrote:
>> The ADS1220 is a 24-bit, 2-kSPS, 4-channel delta-sigma ADC from Texas
>> Instruments with an SPI (mode 1) interface, a programmable gain amplifier,
>> an internal 2.048V reference and a dedicated DRDY data-ready output.
>>

...

>> +patternProperties:
>> +  "^channel@[0-6]$":
>> +    $ref: adc.yaml
>> +    type: object
>> +    description: Represents one ADC input configuration (channel).
>> +
>> +    properties:
>> +      reg:
>> +        minimum: 0
>> +        maximum: 6
> 
> I would add a comment explaining that the limit here is arbitrary. Also wouldn't
> hurt to make it a bit bigger. Technically, someone could have every possible
> combination of all inputs (16 differential + 4 single-ended).

From the dataheet, it looks like there are 12 possible valid
channel settings rather than 7.

> 
>> +
>> +      diff-channels:
>> +        description:
>> +          Differential input pair routable by the ADS1220 multiplexer.
>> +        oneOf:
>> +          - items: [const: 0, const: 1]
>> +          - items: [const: 0, const: 2]
>> +          - items: [const: 0, const: 3]
>> +          - items: [const: 1, const: 2]
>> +          - items: [const: 1, const: 3]
>> +          - items: [const: 2, const: 3]
>> +          - items: [const: 1, const: 0]
>> +          - items: [const: 3, const: 2]
> 
> Sometimes, the same channel may be used as both positive and negative
> for a diagnostic, so I would just allow any combination instead of
> listing specific combinations.
> 
And now that I read the datasheet better, I guess this is fine.


