Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D163411667
	for <linux-iio@vger.kernel.org>; Mon, 29 Jun 2026 16:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782751417; cv=none; b=eA277LDGU9Q1thVxTT9QatSWLd/cD7ZaHtTnaai9Ny9JmK4aV91sTQ+tB/GiVleLZhfcwGff355bR9V79e0Z8uFJNPk7JX5YieSExQDI/9L/KqSEtxSLXFma4WvH63a/DUUlwlizlcgU2mgwiwlfZLzZ5ADZYBFwje67wnAVUjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782751417; c=relaxed/simple;
	bh=vxgWNm6c6XS24fJJWzeNDYRc/XdpjG0nw4Melt6OckA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QiTqGcWABs4Y/uvnvqHAEj/1Xj9KEBOzoN70Ysv9TyAKy3mIiby3eW6aUgxVcrw1JxBfiI8DcUtuIUT1rZ9AT4ZDJoCuqs0YYSLajIeRnXqvkAW/Ma1jF2Au2lNZKzPqmHCzsCoRemDqtcnvOO9izC+JCvozVHzQYndR1o9gJrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=gsPtN8LV; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="gsPtN8LV"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-69e1f777bcaso2173385eaf.1
        for <linux-iio@vger.kernel.org>; Mon, 29 Jun 2026 09:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782751415; x=1783356215; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fhp4Ri8f/aMz4xwN6jjmZnklR0XbVRr7EzMCjQfIbrA=;
        b=gsPtN8LVU0pAa7xs/1cr1qEh7sAgH7CNRUfMvZuHDO1hIietX8GEKxhdB7IJgKy4Oy
         MZXPrsP+73ByPMUyeIgCSQQNaDhNHW9uGIAmwBsSVV8vQUv0vvDBAH/s16KOJomu4p8S
         sMSPwT2YB+zFIkxTO/V0mKcqIGh/X5nMgyZb/SkIiRWcBHvk6AVcodolapG/ZYcp+RsC
         Fvo0mvQtNw5KhlQOaVcNO5SpXPHzQsPtihhIJyZR5Y1n+3a7EHInmtVjcsBIFIo2o5o4
         Z4YK/exra/vVMacNyX+CZiuhCfq3bSdkOCxaMxHCet5aXBqyEXrbZNzNDUHp3uK7ciH9
         xobA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782751415; x=1783356215;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fhp4Ri8f/aMz4xwN6jjmZnklR0XbVRr7EzMCjQfIbrA=;
        b=LH0KszVl+qWJKaxn5KiKPEiAZbFEQ8khopMd+YyfqFr8javSdchGOZjVUTNVcFsGew
         AHc4Wd6WIEs09jLOCz3ofVnSs8VxbsGTgr9V97Guy/AavZYIQsNm/AW8LdRZJ6gwIwRm
         QacnBetZmCYsgrZaLo7kEyqZ2uq7m/EC9BHxlbExRrCuYU0NZT9bQDETYeOSFHZYu3iZ
         pfh5V1f97yZGL/Ee8IBiIo6XEpHyLEo79nIi6c+QBLw/puf5BncYFAFkjvIpzTtzep+s
         PwzYjpwKgkeQRgSAsGwggPSV3n59m+1KCjeM/QpCj2lMpUwYZGh1wrJSJGVbb50dilIY
         8Ygg==
X-Forwarded-Encrypted: i=1; AFNElJ8YPJY97UPv15KcKWYppJRFI5XNolRBuTu5yjIkW89H/ZtZUrEfTeLan0JOEhdIdEW5lKhWtZhIKak=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2nqAKTvnaTfQNA6ubsusQH2Wbf2rRTGOsrTkMRmNxPt19SsEX
	ASyPx61a3MHsB9wPP3d5YjWOibhEUHxUdJk5ME0/DYuCp8Gg6OW0t2MgQe5ghjitrHA=
X-Gm-Gg: AfdE7ckX2hTjpeFJwQ0qxvOup9cqRbtXC1//S4tScMHQveG8wgZTRVi40W/du4aSj23
	KCzEr0csyRa9r9I6NcUm7AvdSsgFdIuIaLTgKgAkNguBORL3Aswq9S9MixitQz6RgmzynrqiLkg
	5DiTUkxpzztl/D41TNxD9lGi+GqxtdQI0cNjIo37VgpJ+PVsdh3+mYLoLtHMAivSBycaPjc2RBM
	UvSV8aOB9/XoeHek/vA+qQwRvwxS+9ZOPFEYBLTXZeMkGaGCltRC/u7J95SMl9/r3mtKcVdZ/O4
	x6IbDkKeJD3jinrOo3B0RAKnLitP6gWimw5/pjFvzpa2fHQBO3xFLn/9/NRQO421Wu95/ErhTpI
	B0prJap0ay5StR5k5sBpeOUXs0mceH96s3cn3NLBbF91cEJ05k4IYjAGLLvlB0+qcpo+btQ4lpM
	BSqobIZRKmb+UJj5b2QcjGQrWVHmI85NRtuv8FxDgkH6LMs11ag7jiKQs5OnYveHw=
X-Received: by 2002:a05:6820:c0cf:20b0:694:8cf6:5d44 with SMTP id 006d021491bc7-6a189c4f0dbmr93402eaf.0.1782751414866;
        Mon, 29 Jun 2026 09:43:34 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:3533:aa22:9a69:df1c? ([2600:8803:e7e4:500:3533:aa22:9a69:df1c])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-448db93e2a4sm230186fac.3.2026.06.29.09.43.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 09:43:34 -0700 (PDT)
Message-ID: <22e1e1c2-659c-4991-857c-b38d66769c7e@baylibre.com>
Date: Mon, 29 Jun 2026 11:43:33 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] dt-bindings: iio: adc: Add TI ADS126x ADC family
To: Kurt Borja <kuurtb@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260628-ads126x-v2-0-4b1b231325ba@gmail.com>
 <20260628-ads126x-v2-1-4b1b231325ba@gmail.com>
 <946a30c9-01e9-42f1-bd2b-b7934fda85cf@baylibre.com>
 <DJKX600ONL4O.1YUTCD1L9FU8F@gmail.com>
 <a16f61fb-4e98-4c30-8d4f-da084e27ebeb@baylibre.com>
 <DJLOAISPZLG7.VZYX8B16QU4K@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <DJLOAISPZLG7.VZYX8B16QU4K@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/29/26 11:27 AM, Kurt Borja wrote:
> On Mon Jun 29, 2026 at 9:21 AM -05, David Lechner wrote:
>> On 6/28/26 2:12 PM, Kurt Borja wrote:
>>> On Sun Jun 28, 2026 at 10:45 AM -05, David Lechner wrote:
>>>> On 6/28/26 12:36 AM, Kurt Borja wrote:
>>>>> The ADS1262 and ADS1263 are 32-bit, 38.4-kSPS delta-sigma ADCs with an
>>>>> integrated PGA, internal reference, excitation and burn-out current
>>>>> sources for sensor biasing and diagnostics. The ADS1263 adds a second,
>>>>> 24-bit delta-sigma ADC (ADC2) for background measurements.
>>>>>
>>
>> ...
>>
>>>>> +
>>>>> +patternProperties:
>>>>> +  "^channel@[0-9]+$":
>>>>> +    $ref: /schemas/iio/adc/adc.yaml#
>>>>> +    unevaluatedProperties: false
>>>>> +
>>>>> +    properties:
>>>>> +      reg:
>>>>> +        maxItems: 1
>>>>> +
>>>>
>>>> If we want to allow single-ended/pseudo-differential inputs, then we should
>>>> also allow single-channel (positive pin) and common-mode-channel (negative
>>>> pin) properties.
>>>>
>>>> This will also require additional common-mode-<N>-supply properties to allow
>>>> for the negative pin connected to something other than GND.
>>>
>>> Ah interesting. Why the N though? wouldn't a single supply connected to
>>> AINCOM be enough here?
>>
>> In theory, any AINx could be a common mode input by connecting it to
>> a constant voltage supply.
> 
> Technically yes, but there is a pin named AINCOM intended for this
> purpose. Can we do a simplification here? I propose having
> 
>   common-mode-channel:
>     /* AINCOM pin */
>     const: 10
> 
> That way we would only need one common-mode-supply. Would that be okay?
> 

Ideally, we shouldn't limit how the chip can be wired up in the devicetree
bindings. It doesn't mean that we have to implement everything in the driver
though.



