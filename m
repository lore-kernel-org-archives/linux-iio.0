Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D30202F70
	for <linux-iio@vger.kernel.org>; Sat, 20 Jun 2026 15:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781971079; cv=none; b=Q63biMOjta7PqzwCx95ic/+QszUVzEJcVRbpLWiNlmKz/AfdXi6RGNxiDR4t9EO7nLvEzr+R/7pu2RbHcfVDMCMIKV0xb/WGDatS3yeiC6AlLmpHpzFpSkOVkY/VwBNr7uKqeTjimaTIaVQK0vV/Gl+VbBL5+/8SdJJTuvHTLiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781971079; c=relaxed/simple;
	bh=SnUl6nZJxfSQP03DU9uUzt56TPsVlO2EkZ/eB7TD1rk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j1niuOQT3vvc0iXNx1qLP2BOo4qdwk0gkmthEUpTi5kl7LPqkfkhrMBLxH/7OCUzX5OaJFa3EtKPg4yIM9ECA53EaZ4GKaV5TLiFinZe9FbPJKOPUhZl4WZqTsbGMKkCSHrtfQmEsHjjTDm6H2B1POeqFiAmuf4ApvZNXSWZqOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=EV1qdZqj; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="EV1qdZqj"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-44748131f58so136531fac.1
        for <linux-iio@vger.kernel.org>; Sat, 20 Jun 2026 08:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781971076; x=1782575876; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tjiqg9IV/7gI3LqSgJF+5/50ztX9TOXe4tB+YHLxznw=;
        b=EV1qdZqjceHi8BzVLYqSTW5c7YW6nlC8Ppn9znew7q8d4nF2POjyxGRk0EPAe1Bd4g
         PrYslhPW1uArc5HsaUcvI10dZVaTsaUuay/V/tuvL8430emQzAGzx2dgwML/5lQf3fAl
         bmGATZqPrszInlYqTOe4hDCgJGjSqJ8ts8xlHfVrF3gRSY41pUtXO5WzDWCL9mTN1dAo
         UyX56HPUKhULK60B+KI3QTE27H2TcucW1d/dIrTiuBrv/Nyyh9mVBu9LDLkOnRpZXh10
         x9KjtnNn6AgWmNXBDBGIFWxLOX819Jy6q7fuXkLm1rCXfkhzI8vhIRi7PYuO10+r8rvQ
         /HlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781971076; x=1782575876;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tjiqg9IV/7gI3LqSgJF+5/50ztX9TOXe4tB+YHLxznw=;
        b=KRac/lD9M2gC3brl7PHfvvpRbse+5PkJe/HrZyjqQNn2Cv1CNMn75hV7g9XeJS59GV
         SLyE7bGVTgNJrwPG9Grir7El9v3EiYoDqVvD0aNdLrYBx/W8hYDiPY0qp8HZv/Q39/WB
         xY/9tAVkaPF3cWsEcb9+du7MZTPANrCf5Rr/K4HWQbDA314C3Ochg1BDTg0dU7Mk2vW5
         +9c8E0LCVDm7udyOl3xUmgy8Url8kk5Ch/2LiFr2F2zvwqXCH25tDH0p0IDb2pyzYfWf
         O3Pxs7E94w+u58itUQBMSC7FkXtDdNmwkfXK0Vo81I8yjBvrQ7q06sDKjQb2Xa0ApNX5
         VwPw==
X-Forwarded-Encrypted: i=1; AFNElJ91ObjU1sRODdxo6z0VKp3g7ps3KLIHV4g1x/N3OOFieVZTRxoXC2txQnUQDH/jJuWrjxAUqi0tPHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJyXKFMXcpGwEDUmTSSiT8u68m3fAlzRkO1zq6l88vLSYmlo7O
	884CPGnZq0YQ12sJSiMkYL+lXN0KwhjzI9kjRTgAXkdy9YntBL4lD3QWukezG/xazQo=
X-Gm-Gg: AfdE7cnMuQQZ4/V+BW4ihVLytCuRUoxEzNnQJ8foNBfGIM9WEf2dw2R5jNdRUArvbqp
	Tl+ZXA0bfzhaoC1Vomu+QthObMimJ2DKtJtINnEK2GxYoYvfCQrwaBqz1Kajsm3vK8nyq4WjiX4
	kDJfTAbACP5RqKKQ30bcSjk0mF+V3ALoIta1906A0zWAY44LETLYz+PEOLcHvYwCT/IuX7iINbT
	kS8iRg6q9xf1Yi2R1zVDroUzAiSWqL9aLqidvyV6YIHOOtYeV9JBWE7aLjQ1kn3ivhfFFJHbVLy
	7srOU+G/8K8k8EY6Rk1Hz67s8IQjK7pJE1pLIandCBuOmSdTWIl1HthjV6sLfJ2JM2N6N7zccq6
	NKaKx0EuitHyloy8yFt9b/D2GRjUiKEOULGzOPWshkbFEAjPS8tZWWGQVTCsktGJ+YwFIl4juFH
	QQcs2xsfuyZEqSCbqx+U1s+YKeTKO8/Rtiq7X8BErdRUPHALDlmQYw4rfAciRmfGQ=
X-Received: by 2002:a05:6820:2011:b0:69e:a233:6154 with SMTP id 006d021491bc7-6a0d9fb7e9emr5016081eaf.8.1781971076292;
        Sat, 20 Jun 2026 08:57:56 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:3ad0:4082:8242:2d72? ([2600:8803:e7e4:500:3ad0:4082:8242:2d72])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4472ec5fd4csm2267384fac.2.2026.06.20.08.57.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Jun 2026 08:57:56 -0700 (PDT)
Message-ID: <38c5e5eb-2113-4a5c-ad14-348dc7966a1c@baylibre.com>
Date: Sat, 20 Jun 2026 10:57:55 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 3/3] dt-bindings: iio: adc: Add burn-out current
 properties
To: Kurt Borja <kuurtb@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260618-new-channel-props-v1-0-963c1b5cf40a@gmail.com>
 <20260618-new-channel-props-v1-3-963c1b5cf40a@gmail.com>
 <0831356f-76ff-4eed-befa-7a35ffce921d@baylibre.com>
 <DJD6FJQUX2V7.SZWF8VSKBCPX@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <DJD6FJQUX2V7.SZWF8VSKBCPX@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/19/26 11:46 AM, Kurt Borja wrote:
> On Fri Jun 19, 2026 at 9:28 AM -05, David Lechner wrote:
>> On 6/18/26 7:33 PM, Kurt Borja wrote:
>>> Some ADCs incorporate burn-out current sources that provide current to
>>> the channel's input pins for open-circuit or short-circuit detection.
>>>
>>> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
>>> ---
>>>  Documentation/devicetree/bindings/iio/adc/adc.yaml | 14 ++++++++++++++
>>>  1 file changed, 14 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/iio/adc/adc.yaml b/Documentation/devicetree/bindings/iio/adc/adc.yaml
>>> index 106b1e317411d5..6b63aac9ac04dd 100644
>>> --- a/Documentation/devicetree/bindings/iio/adc/adc.yaml
>>> +++ b/Documentation/devicetree/bindings/iio/adc/adc.yaml
>>> @@ -106,6 +106,20 @@ properties:
>>>        This array describes the current configuration of the excitation current
>>>        sources or the single matched current for all sources.
>>>  
>>> +  burn-out-current-microamp:
>>> +    description:
>>> +      Burn-out current sources provide current to the channel's input pins for
>>> +      open-circuit or short-circuit detection.
>>> +
>>> +  burn-out-current-polarity:
>>> +    $ref: /schemas/types.yaml#/definitions/string
>>> +    description:
>>> +      Burn-out current sources provide current to the channel's input pins for
>>> +      open-circuit or short-circuit detection.
>>> +    enum:
>>> +      - pull-up
>>> +      - pull-down
>>> +
>>>  anyOf:
>>>    - oneOf:
>>>        - required:
>>>
>>
>> This doesn't really work with chips that just have and enable bit to
>> enable or disable the feature.
> 
> Maybe those devices can use burn-out-current-microamp with a const
> value? Is that okay or should another approach be taken?
> 

Maybe better to just leave this one out of the common file?

