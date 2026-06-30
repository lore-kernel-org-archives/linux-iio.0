Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA2925B0AD
	for <linux-iio@vger.kernel.org>; Tue, 30 Jun 2026 18:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782844713; cv=none; b=WrJuD0hI7miIyhqNkuVRzigpIWrgCJzhOu1lEZ3RZg9R5GO79NKRN17vN3Kd9IJOz/nWvcneiEM4WriXA7Kl5pXYTSgPHZJqn0AU2uKdLX409FnOSQDrg+TI2PJucVu3ZDxxg0Y68oYpHyMtTaftPjhjxyNBL6xQldaK9Dcusqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782844713; c=relaxed/simple;
	bh=cbvkjGExjYUHL2QoSeT/1yJv2i7vXmEZZ/yTfY2vjE8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nfJueNyknK8llNIxiP3qn9wJkfqoiP9/+eXvFTShSrAY5a5jhCNHT2aK1K6b6ZFzb+HcvyBZW9X7QLIVO6nE2xhFyvO5nrriK2YbZOl592cmiZ0pfps/h4WXAK820gOHroggdMxvVEVNPkiyMISJcyeU5m0AvboTX+WBOdzUga4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=cqee+qsZ; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="cqee+qsZ"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7e93d1dd156so1921203a34.0
        for <linux-iio@vger.kernel.org>; Tue, 30 Jun 2026 11:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782844711; x=1783449511; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9rgrcJFnBRvyDKAXtDJFOwtKqCg4JfQ5wObL2xRUARM=;
        b=cqee+qsZ0+rQIHuUOdzntuJveTo8DKIL7PBX3IwcLMD+WSaTwDB43sangDZPGTU8xi
         cWdg/HWGhBafEHtob/hZqNioCkl5dEsObahHDqGOUqh6gcoB8niVeAasyklLbJsMzkDQ
         zuBC234cxxgFsZE0L/jf5BLRq1BrPOhtjydWAckEpAZhvf9we4Ce2HSjpbxPhRYX/pVk
         ounRMJCbm9lcLDQi6FH/rxZGvD1dlscdPAR1v1GBKXvnEKkEMA3qWqXRhHMSpqNUbGKB
         4JU68NxV8Q/ts3tjH2r6ARE/MR28NsWMKVQxkwq73YEKfbRtv8RIZvqA6uk+5lDNAlsO
         6UMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782844711; x=1783449511;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9rgrcJFnBRvyDKAXtDJFOwtKqCg4JfQ5wObL2xRUARM=;
        b=QZIFNlBBEiSWNiuUYtbafdwoSvm6StKiFKGdbzxX4DO25G5kNV2yxiOkyHMr+KrloN
         vNB/5JFXVjlztD09pxG2/67RXFiXUTyMhVrj9lNokZOo/a0smL1PZHSavo8ZZS/rhxvf
         huGHLe71iNPn73ZWClmHWSQQPSaKu/T2jNaAU0Vg5YN/HflwuJMeSh70T4ifRCzT2EoL
         4Ti/PlM1qBzHIH/PyTKdMgKSBuTQcpZN11XwcSWNyxEEeMIKDFkP7tGthayvcpuKAgWL
         ZHigo8WNNfGQLXLiiovqUdeDVJ5Xcja6/Osdo7z3bIMfMLpj9yhMepkZO0cy+96H5r7W
         5Q3Q==
X-Forwarded-Encrypted: i=1; AFNElJ9IHa0aYTZ5o0gZ2u+4mTUFjbYYKxE0lkTB0SD3ZIt3eEb0sP1yFVKsG0cwdTMHboz0VpqSVSbQgaI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+94AD4DNIdWJbtztCSOAcZQ7SoQG16mCvz6FWRhGYPRjSsLLx
	ZdG0E/mw1iGWtt1Gu/n5OFtd96mgxd/BLedi4UUW5OzPk2ZfgduDQ36wiw6/6/eCx/M=
X-Gm-Gg: AfdE7ckxRD4dHRtHpWz6ONgItgeChShRrxgo5UWA9dqDE2CELwaOg2zOoYvvA2osQnd
	vH+bf9AwzCVFjt23jHwDZQvIL5NXI+wrAreNMnTiKlUmIn39mNE0Hff1D9Z5vEKCBSKAe2JnMII
	ZDSaTVf6gos5u1oWeFoXz8IQcYoeeF3GuzjS2yH7eTX0qth7sbxDqFGySjcxXGxUtROI6M6SB/G
	uBuQmv+HBF6Z7/RlzdMHODmXt85XXrTNJxmPL2EokdD8Q8wROpGocyUhU4LuN2Pau9Ezkrz0jv7
	RLYLXHMZ8H/9pKjvLJKDvJ/s7Dc6RZIU8bhMHj3uxA5IpY1U9AUV5BmBbLyiccptltWvmQ8hsNg
	LahWZSZtA5dThPcZKXNqnxrdSKCqCmoLiElYK1LSsGzGHTUb6V6bI5R+scCxq1CObc1q+mXRxV3
	yU2lBQoWasGkpFGnY2cuH1phZi5D7ukquC6qHF0aWI304NPkmhz2boN1BU4Sayzhw=
X-Received: by 2002:a05:6830:7306:b0:7e9:e860:6e7 with SMTP id 46e09a7af769-7e9fc2a622fmr888833a34.30.1782844710983;
        Tue, 30 Jun 2026 11:38:30 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:e190:78b2:dd4e:ba94? ([2600:8803:e7e4:500:e190:78b2:dd4e:ba94])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e9ec2e353fsm2942446a34.20.2026.06.30.11.38.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 11:38:30 -0700 (PDT)
Message-ID: <2a0a9fe9-b3b5-49a0-bf58-5035655fc16d@baylibre.com>
Date: Tue, 30 Jun 2026 13:38:30 -0500
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
 <22e1e1c2-659c-4991-857c-b38d66769c7e@baylibre.com>
 <DJMJX5FGSZ9X.1GQK24K6CI60X@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <DJMJX5FGSZ9X.1GQK24K6CI60X@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/30/26 12:14 PM, Kurt Borja wrote:
> On Mon Jun 29, 2026 at 11:43 AM -05, David Lechner wrote:
>> On 6/29/26 11:27 AM, Kurt Borja wrote:
>>> On Mon Jun 29, 2026 at 9:21 AM -05, David Lechner wrote:
>>>> On 6/28/26 2:12 PM, Kurt Borja wrote:
>>>>> On Sun Jun 28, 2026 at 10:45 AM -05, David Lechner wrote:
>>>>>> On 6/28/26 12:36 AM, Kurt Borja wrote:
>>>>>>> The ADS1262 and ADS1263 are 32-bit, 38.4-kSPS delta-sigma ADCs with an
>>>>>>> integrated PGA, internal reference, excitation and burn-out current
>>>>>>> sources for sensor biasing and diagnostics. The ADS1263 adds a second,
>>>>>>> 24-bit delta-sigma ADC (ADC2) for background measurements.
>>>>>>>
>>>>
>>>> ...
>>>>
>>>>>>> +
>>>>>>> +patternProperties:
>>>>>>> +  "^channel@[0-9]+$":
>>>>>>> +    $ref: /schemas/iio/adc/adc.yaml#
>>>>>>> +    unevaluatedProperties: false
>>>>>>> +
>>>>>>> +    properties:
>>>>>>> +      reg:
>>>>>>> +        maxItems: 1
>>>>>>> +
>>>>>>
>>>>>> If we want to allow single-ended/pseudo-differential inputs, then we should
>>>>>> also allow single-channel (positive pin) and common-mode-channel (negative
>>>>>> pin) properties.
>>>>>>
>>>>>> This will also require additional common-mode-<N>-supply properties to allow
>>>>>> for the negative pin connected to something other than GND.
>>>>>
>>>>> Ah interesting. Why the N though? wouldn't a single supply connected to
>>>>> AINCOM be enough here?
>>>>
>>>> In theory, any AINx could be a common mode input by connecting it to
>>>> a constant voltage supply.
>>>
>>> Technically yes, but there is a pin named AINCOM intended for this
>>> purpose. Can we do a simplification here? I propose having
>>>
>>>   common-mode-channel:
>>>     /* AINCOM pin */
>>>     const: 10
>>>
>>> That way we would only need one common-mode-supply. Would that be okay?
>>>
>>
>> Ideally, we shouldn't limit how the chip can be wired up in the devicetree
>> bindings. It doesn't mean that we have to implement everything in the driver
>> though.
> 
> Makes sense.
> 
> I just have a doubt: In the ADS112c14 bindings, is there a specific
> reason why you didn't describe common-mode-<N>-supply?
> 

For singled-ended inputs on ADS112c14, there is an internal
connection to GND, so it isn't possible to have a pseudo-
differential input like that. I guess technically, it could
still be possible, but wasn't a typical wiring described in
the datasheet like it is on ADS1263.

