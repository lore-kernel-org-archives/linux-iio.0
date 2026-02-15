Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B4F21638D
	for <linux-iio@vger.kernel.org>; Sun, 15 Feb 2026 16:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771172214; cv=none; b=XVXbsdreGhhVm5RlrtHEwlVF6zWfVvmMQWHrx2N1trkF1tW0D//OhWRE9vdEHDp7SutX4IBZHL8ovtjB3EGH8WDxyONbmZrRhtaxnq57lDpmJkthf/qmI1z5lP8vTKKIDwC1SKODDY1Q7ymSWqfyimYO3luGEb420t/ccFyqYaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771172214; c=relaxed/simple;
	bh=QkftsrPYieFk9d+UCflvzlWm6/5nK+3y4WbIIuVt1C0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CJ1fami2irU/51ve1SWy1/z1blPf05ed7yL5TUtZZRhOty6eHLhCi+JtetrXgKcmjMx1qvFuMnqwBECWCn/N1cpV81NrIshk2XndJrEqO5kP8pQzaYjabe4gr3l1EX0y+JAQLGMpsnq332nrSLfMFuHa9VyklcdEhY18g9YcDaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ODlXG0Ad; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODlXG0Ad"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-79430ef54c3so20399907b3.2
        for <linux-iio@vger.kernel.org>; Sun, 15 Feb 2026 08:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771172212; x=1771777012; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0MzbHaBcl2BA9jnP7VQLQ7usDren2db0/Uzo8UfIv1Y=;
        b=ODlXG0AdjtizbMudBbgltHy8QNPfO4yVR4s3wvfqsVfqK1KIEoakV9yihdFrSx7Cf3
         92woa7QdDoAQz6qzpZDs10fTP7hIIMG/eBZXZuTO5xb0HD/YIG8JkEdZWuPfvPILOVSz
         4h8CLwpqjWyKH12PsqGcDQIs+/+uwMmKSa4IDwPlZIoTxQSBmnbFtJZCwz+ZEXgxvZuh
         WdgxsTl4KmvJP7ygFO3p8j64Pf09gFNqFiaxC22iBAvEWihNVbB2A+vZv9WP1c6tiqbD
         hwtF0IZi+9+HZXMmAUS47LLIZxzTZ8yh7tP1KIZmbg+D0qVV8gXbya9StW4VO3pCoSUR
         Kbqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771172212; x=1771777012;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0MzbHaBcl2BA9jnP7VQLQ7usDren2db0/Uzo8UfIv1Y=;
        b=XlLV1PA2gBTtTzUgIHh703l9Md22EzBQKUIDI8hnGdAwedHNXulamC4Qnpd4+A5vmX
         I03uXQV/zNYy4Atlc8ApI+a0Do9cRUdzJ7Cz1DA8f2kIIfKSei7d369x9aykCKxZFwWw
         FJNsmTurA2LI6iQyDosaSVTMaSzSraqLELQy29kfetGeT2nF6TZKaR2B49WMLhWOHlG6
         ANwGFhqvzB5s387hnoOmviNI6/Kv1UViLuO01RP4OG+CbK1gFwomfVnkDcUg3zPdUHk7
         KKvJw3Do52xVduKdgFeVs7XPUqjY4vM8KXKPDtyvcpvBTBJPzYpbLW2oVsnGEdhPwL6V
         aMFw==
X-Forwarded-Encrypted: i=1; AJvYcCVrGep2Igy84yAvpHIstVnYUFCBkLtvaNeEZLyIYaY3yXFFXdw3pIN2Ghba8sb606rje7FCsdrXgvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdQbZQYLwBk+vQ4NB/HBilGOChIB89cSxhYOwD6tt4YVlHwYbo
	LFBFCHHlG2J3tvYcNgT78d6sq//TKmW7PBQ1Jvp5cmYgrKkSoSThC1su
X-Gm-Gg: AZuq6aKW7fkNNPjzTJcZcArkwZnsHffxijHlJB/+aueQIw9AVe/Kt6It2PF0PiELwXu
	YAv48oxmA9heAe4wUoCIik9vK4YKZc2XWMoOrKqzcyrLG8PX57mW9G2wqiWPebuQ7b1k2yCzdnZ
	gc37k4Fa2WuO70y0huupmmy1IL6djNqdZCDCC30LJvVU1Q52BVR6BIVnRoV34Zo6Tamy4YV3VWY
	HLS7Y13egUewhAj/EbN99tZpPVjy5ZYfn875UjwEA7Kd1s4hIR3mNxstxnd+4ZjgzeukRNEqa/J
	ehEUKLEkcHuiWGDU4h7OFOLwQUgM/yPuDO3vSjAJnAtPOJk2eTDxe8Hwyo4RuZnK6VgRVcH9XZ9
	qSrS4MVyV6vucgVhPl8iuPNdIk+2W3U31UKP2W2mfsA2htAXVrP0JxAVH25UEDh8NVSs5TKpS98
	a9hOwUrXBcobencUCvVUxonHWf5Q==
X-Received: by 2002:a05:690c:ed6:b0:796:37bb:9eaf with SMTP id 00721157ae682-797ac4ddaa0mr37247267b3.7.1771172211823;
        Sun, 15 Feb 2026 08:16:51 -0800 (PST)
Received: from [192.168.0.40] ([79.133.247.80])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7966c267f40sm90580437b3.52.2026.02.15.08.16.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Feb 2026 08:16:51 -0800 (PST)
Message-ID: <eea4cf8c-4126-49a8-ada8-1b1893a406c2@gmail.com>
Date: Sun, 15 Feb 2026 18:16:45 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: light: vcnl4000: add Capella
 CM36686 and CM36672P
To: David Lechner <dlechner@baylibre.com>,
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Peter Meerwald <pmeerw@pmeerw.net>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org
References: <20260212-cm36686-v4-0-8f587d4a72bf@gmail.com>
 <20260212-cm36686-v4-1-8f587d4a72bf@gmail.com>
 <20260213-unyielding-pistachio-ape-deda74@quoll>
 <3a20c906-647c-458f-a118-c7927495e7ef@gmail.com>
 <8fb27a7a-82dc-443b-bcc4-21007783fc54@kernel.org>
 <f014078c-6e4d-48b0-a814-45898b005c44@gmail.com>
 <880ddcad-a92e-43bb-ad5c-d6f2f353d182@baylibre.com>
From: Erikas Bitovtas <xerikasxx@gmail.com>
Content-Language: en-US
In-Reply-To: <880ddcad-a92e-43bb-ad5c-d6f2f353d182@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/14/26 6:44 PM, David Lechner wrote:
> On 2/13/26 2:56 AM, Erikas Bitovtas wrote:
>>
>>
>> On 2/13/26 10:51 AM, Krzysztof Kozlowski wrote:
>>> On 13/02/2026 09:29, Erikas Bitovtas wrote:
>>>>>> Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
>>>>>> ---
>>>>>>  .../devicetree/bindings/iio/light/vishay,vcnl4000.yaml  | 17 +++++++++++------
>>>>>>  1 file changed, 11 insertions(+), 6 deletions(-)
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml b/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
>>>>>> index 4d1a225e8868..2ba4d5de4ec4 100644
>>>>>> --- a/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
>>>>>> +++ b/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
>>>>>> @@ -18,12 +18,17 @@ allOf:
>>>>>>  
>>>>>>  properties:
>>>>>>    compatible:
>>>>>> -    enum:
>>>>>> -      - vishay,vcnl4000
>>>>>> -      - vishay,vcnl4010
>>>>>> -      - vishay,vcnl4020
>>>>>> -      - vishay,vcnl4040
>>>>>> -      - vishay,vcnl4200
>>>>>> +    oneOf:
>>>>>> +      - enum:
>>>>>> +          - capella,cm36672p
>>>>>
>>>>> CM36672P is compatible with CM36686, but this is not expressed.
>>>>> Confusing commit msg and code. 
>>>>
>>>> For CM36672P we create a dedicated compatible because it is a
>>>> proximity-only sensor which has the same proximity sensor configuration,
>>>> but ambient light sensor registers are missing (reserved).
>>>
>>> I don't understand this. You just wrote "fully compatible with CM36686"
>>> and now you imply that not.
>>>
>>> Decide.
>>>
>> It is not. CM36672P supports only a subset of CM36686 features, in
>> particular the proximity sensor. That is what I meant initially.
>> I am sorry if the previous phrasing caused any confusion.
> 
> But CM36686 is fully compatible with CM36672P, right?
> 
> So this would make sense?
> 
>       - items:
>           - const: capella,cm36686
>           - const: vishay,vcnl4040
>           - const: capella,cm36686p
> 
> 
If you try to use CM36686 compatible for CM36672P, proximity channels
will work, but in_illuminance_raw will return 0 and changing illuminance
parameters will have no effect. That is because CM36672P is a proximity
sensor only and the register fields for ambient light are reserved.
And if you try to use CM36672P compatible with CM36686, it will work,
but only proximity channel will be available, even though CM36686 also
can sense light.

