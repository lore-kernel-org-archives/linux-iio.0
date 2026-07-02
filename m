Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43AED390204
	for <linux-iio@vger.kernel.org>; Thu,  2 Jul 2026 19:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783020927; cv=none; b=ldR9MH10ZJtx3lapp2knv8RwcwaamimnmyPrUw+eXrN4v1EaZOjhg8EzKHnxHZOVXsFgnNEKOhvui3B/5mOUYkhIWhqB/GvbBPEGYUqSEQuGfA0whtc8GoYy9z1sP+hbL3eYLj3Xy31mlmk12R9UtQARUCK+kM5c9jVFyubBh6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783020927; c=relaxed/simple;
	bh=I/ZM2OkT/dPa1GEft4QF0DUM5VH45Fd00jGx8xU90Tk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UH40ywp+a1kxp84WjtzWzokXHrolq1mg8zloPWX4tpk47AhPIh5LWYKQvmSEYg3A6rbyHYePlgYhF5idn2BJuEcStyHCdue5Z/jQaFDl3u2KYr2vDZv9wFwvbNTCPWudH0JKs0k+EUzsOpBvxauYKfJTalXx0jP8NeDo+SkeJbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=kD2FPudj; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="kD2FPudj"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-6a183eb9689so1416619eaf.1
        for <linux-iio@vger.kernel.org>; Thu, 02 Jul 2026 12:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783020921; x=1783625721; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I0Nc5U/TyB5elCjL6iCrBR8Ha+/073W6VQJdxK5d5a4=;
        b=kD2FPudjT55QuiJCXrPLRpbZ3HmHvNnvpuqzlsxJ3phuElCTdL+DxrJtVCvayT/4Tw
         Gjn2d8i6wHNMfX0uvmB10lLdsybBDReVP6fCCavrv2Dn676o9J+KPVc47HcZrswuxqvp
         teVl/fYWiqpJkCpoCggjrLoN75XYPcKTxNbQCHUXgiJGjM1YFZh679TY2lHc57iSgqiT
         oaNV9ESfCVvbL5hFPvs2H0IMFT8ORxsuwt0e7SmpVU3llLFcJRdA2XALXDqGHa4UgdrS
         GpyznobkdZW4HJ825qRyxCvUKuxUzakMKu+0D8vtVIZ/qTWQGfYt+SL+yoSQIWT/y3Ju
         vsAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783020921; x=1783625721;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I0Nc5U/TyB5elCjL6iCrBR8Ha+/073W6VQJdxK5d5a4=;
        b=NHKV5QhZh1uW7ajoRzQEJvp6gswrQgyVLbgSXMEJ5Wbg5G3aBcHibpJSdBdcW7+iFJ
         4DPJ2qG74YsnfiDWQdEJYS1V/bKC1hH3ysgUMglCFZ7cb11jTHTGyRNgJvNKRPLgZSLn
         xe8avHj/fSZk7g5Lpj41vMP6FAWNN3ISEg6uTEC9VDU9IgiBCY2D5kjSflyP8J2qHzTq
         DD8Iv2OmRcR1I5cqknv8Yn3sTx25mNUgCbzTxT98B2xhFJIVrB3iuvB8rN6ZVWVGhwit
         3CX+8K+dUrM/fAC1Z+y6SjWBA7svpI7i6jZV3uCdUUgWSo6GCmQu8YQytv6nFpKm8ARZ
         zFlg==
X-Forwarded-Encrypted: i=1; AFNElJ+Gc1oj+1JYlkDiF7fzdRf06LItUVre1oymB+MzKtsfwzdMP5M8o3EYP6YvQKdrFh9JpYRYVrdae0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLfnfbxWwcMCRtWhk9RTTsG9QmW5T4qRjECgDswm/Z2WdUVCnC
	5SaESygOa+r94MTnze2Gy7h6EkrWjf7cGf5K3hyX/wyPH2TZQ2m2/7dOeo/DMZwFnFo=
X-Gm-Gg: AfdE7clbRiGHW3conNago5O8Wy1C0BbPSM/eNNpU4cKUUnkfchs+rRTmyJRe3DvcxAF
	nmx8gWojmoclX4PyFBHvlog3QOChyZrW2djD22wVSdcgWTSnpPh0i2eTfCo/MNl9AXJxPWlm008
	ieaSzzevy+1Fx7oOzUMbL3DUVgEtWJhGZDqcoUCryld6pPxoMyocaYpTf+iKxY85RAiJWdrfJsd
	RClVKnJO3fEAObCPERJool9hFs0QYirLwab5NOPoBhPgoIrrWMfPg2RndD5kF07TiIsJWb7hCGb
	ZWtNgL5uWek7rqY5Ivf89Xe6aCNe0fCYwQbMF3EQY3cMWhiUmgmC17eIJOYVZEqZTRUCefB5j98
	zvy94xsNjDURksLYavIhfs0KMmsQy6F4RqWrl998O67TJfKWo3IQ2wosAxqq0vFMY4gvcQOvfjp
	mB7CY/z5OwUyy/B6tqgNkAQ0Q9TpdNz5I4lOBjFxG+zcvuAUtCCp87SHQCD6BRO5LSwP3FgUKRr
	A==
X-Received: by 2002:a05:6820:1888:b0:6a1:50ec:4401 with SMTP id 006d021491bc7-6a30d8fbd90mr4195250eaf.62.1783020921061;
        Thu, 02 Jul 2026 12:35:21 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:6a9f:626e:95c4:2a80? ([2600:8803:e7e4:500:6a9f:626e:95c4:2a80])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44cbec93a70sm3938090fac.11.2026.07.02.12.35.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 12:35:20 -0700 (PDT)
Message-ID: <dff9273f-f958-48a0-883b-a52fcc5a6b21@baylibre.com>
Date: Thu, 2 Jul 2026 14:35:20 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 1/3] dt-bindings: iio: adc: Add reference-source
 property
To: Jonathan Cameron <jic23@kernel.org>
Cc: Kurt Borja <kuurtb@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260622-new-channel-props-v2-0-aafd5369f253@gmail.com>
 <20260622-new-channel-props-v2-1-aafd5369f253@gmail.com>
 <baeb24dd-214f-4dc8-a300-22b932c4b4ae@baylibre.com>
 <20260702202002.79c1be1b@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260702202002.79c1be1b@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/2/26 2:20 PM, Jonathan Cameron wrote:
> On Mon, 22 Jun 2026 14:40:10 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> On 6/22/26 2:30 PM, Kurt Borja wrote:
>>> Some ADCs have configurable voltage reference sources for each channel.
>>>
>>> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
>>> ---
>>>  Documentation/devicetree/bindings/iio/adc/adc.yaml | 13 +++++++++++++
>>>  1 file changed, 13 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/iio/adc/adc.yaml b/Documentation/devicetree/bindings/iio/adc/adc.yaml
>>> index b9bc02b5b07a4c7..fdad6b8276c934c 100644
>>> --- a/Documentation/devicetree/bindings/iio/adc/adc.yaml
>>> +++ b/Documentation/devicetree/bindings/iio/adc/adc.yaml
>>> @@ -73,6 +73,19 @@ properties:
>>>        device design and can interact with other characteristics such as
>>>        settling time.
>>>  
>>> +  reference-source:  
>>
>> Since this is an array, the name should be `reference-sources`.
>>
>>> +    $ref: /schemas/types.yaml#/definitions/string-array
>>> +    maxItems: 2
>>> +    minItems: 1  
>>
>> Maybe minItems here is OK, but I don't think we should put maxItems here.
>> This way, it stays more flexible for other use cases.
> 
> I'm curious. What other usecases did you have in mind?

I didn't have something specific in mind, but in Kurt's ADS1263 series, we
actually have a case with 3 values for this property already, ADC1 positive,
ADC1 negative and ADC2.

> 
>>
>>> +    description:
>>> +      Indicates the voltage reference source or sources for this channel. Some
>>> +      ADCs usually allow choosing between internal reference sources or a pair
>>> +      of external pins.
>>> +
>>> +      If a single value is provided, it represents a single voltage reference
>>> +      source. If two values are provided, the first one corresponds to the
>>> +      positive source and the second to the negative source.
>>> +
>>>  anyOf:
>>>    - oneOf:
>>>        - required:
>>>   
>>
> 

