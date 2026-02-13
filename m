Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4E832ABFE
	for <linux-iio@vger.kernel.org>; Fri, 13 Feb 2026 08:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770971352; cv=none; b=Qw/cYegYs2WCBYYaUxN3aLOUZShbtVRj1iosqD6sLH4KeJUBbcllPobrKSUCOaC5KuBgSmBwbCnyjX3Hn+FUGZXtSkvW6vOwMhu92ni0wMpMlNfeID4EJQzm99ePOwiuP2KMWOqfzoFtQEq1Apeo0v2cXW3e88XMOQGaVrzKtHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770971352; c=relaxed/simple;
	bh=zvgY37ZQjsQkz5/m86ybqaE+gQvu4wV1jaVZs1RK1Mg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dtcUymkN6uFd8P8WzOZtfAXlicxVBzkT9KoNi/0i9uNbe1SczGg7zs9dSl2pBOsKTAaFDHDqnuP0CfVPtd4/GYisJjU8vxs5+xwrdK2ptakNh4hBSvUhjhlI30r3pumCxR1fKPbLLM0Bh6V5RfYZqtJ8dl9dalwXnjRSGVMikRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LUH/sthl; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LUH/sthl"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-795176156b1so8433377b3.0
        for <linux-iio@vger.kernel.org>; Fri, 13 Feb 2026 00:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770971348; x=1771576148; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eb9SMDXx3XqEdbaMIOBwU3P2hDpL6y884kxQ2eGE+V0=;
        b=LUH/sthltK7mdMPmTGL23mil49iTOSK39JeJJz0oPrCtjEfHzeuyC3SS2YicDeHoK/
         3lAN4qUDX0eHnWBOJnPbEmQvXn8FymgTb3nDSDqdvQvYBOgR3okiDmzdda4vXOvl00i9
         Q4Ko1cJRYXtANJX34C/HTDbP+t8PrzWnuJKWsSf9xyE0rHcDToOfv6jrQPjAVu3rcWW8
         vaPAQqJ6I/Utr6yTTRHqgg+qNU+D9YiuBgh5f/fO0+2wCJieSUFtrT8sKQLck3u2Xkke
         GI1JJaljMOWtal098eVwPi/e/mUiYZ0CL5w1+I0uNVAeVVK78bAfEuiTaVNoemnIA0x9
         uAqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770971348; x=1771576148;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eb9SMDXx3XqEdbaMIOBwU3P2hDpL6y884kxQ2eGE+V0=;
        b=AW6aj2PMHCAkGHNDElLBKe9ib3rxhl2ysTGh7PA14hAp4Ex+glyWK9wG+rUhVfF13+
         vpZpIT8gRzA91zBY78wxkEHVGxVSC0t9CSU0Nj/EMpL3MVhtx3yVkGwMZwmQXLQkmmi5
         SWzO0mnwzz4c3h/5PQpTacaDu2zTB0txTbeex9ixBtnOUnU986ccIjpZUzdKBe1Jrg9f
         H+u2Z6A0wg31uOTlYmTYp/nkIMyNPX3KCM3LQrkR3CoM4y/jlWUVTXIdlnXadUwKWaAz
         mmN7+iAuy8ugAAX++6kw/Oadrz3NcDyp2ukfFfuhjKsBHjvc2NrFTkmLJIcCH7ubRr5x
         Ikvg==
X-Forwarded-Encrypted: i=1; AJvYcCVZdhkkeuM/ELp8D4+oOdGGq1hwNE9o2HrLCSN98AwmAeVakiuynzMHSEfTYNiZM7YIHoMw86JGZ4M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8Xsuq4KP7F6Jp2tACXhh7f+OG/pn/67RS9LflEoCEgXWipLye
	y/uFJsLzFeWtP38pyW3xMd5UXudzViGxtrsnDGoEFg9wzZ0snXuQ+SJv
X-Gm-Gg: AZuq6aJI+BXgAUDugzuPpxXpCxdsyGhDfd6ltKzavgLF6NQ7sNMJDMagbd+pUVN4N8i
	VNjSjDiVA62PF4/Z+0ODesfFAvZZ0YMCXChm/wLrx21L30L1WTG8WqVHALhxv/Qh+HN+FIHqjfS
	jkFOZBLxYjwGG0PcQmnj9A1+yplhkfY7DU8U7wH34MJjuflTV+tD1CIrQO2LWPxzHcn0cD1Ql6o
	+ayb688nFXT+8xMyAtV8VfT8bNJPh0cI4iW1VtBstv2X/030naDl47Ajw6Chqx2+68QMHovqpmH
	8LdchUfXeoDOKtScOiEh4aqRIy2WqsO5QRrJPTI8yVFT3GRViGE/zpFwODRnR7195Nm105f+cqD
	6WfL/36acKqAS0l2Ta0TDJXUVGmCaMiG/hSJGr05D3ObbwezAgFfy6x4x4FBXUnn8uTIRUxCx7/
	alEcpdBkzPQH6CRmkGJrrpZQ/YMQ==
X-Received: by 2002:a05:690c:6306:b0:78a:859c:63b2 with SMTP id 00721157ae682-797a0c22868mr8571517b3.30.1770971348077;
        Fri, 13 Feb 2026 00:29:08 -0800 (PST)
Received: from [192.168.0.40] ([79.133.247.80])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7966c254d1esm64369077b3.41.2026.02.13.00.29.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Feb 2026 00:29:07 -0800 (PST)
Message-ID: <3a20c906-647c-458f-a118-c7927495e7ef@gmail.com>
Date: Fri, 13 Feb 2026 10:29:02 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: light: vcnl4000: add Capella
 CM36686 and CM36672P
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Peter Meerwald <pmeerw@pmeerw.net>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org
References: <20260212-cm36686-v4-0-8f587d4a72bf@gmail.com>
 <20260212-cm36686-v4-1-8f587d4a72bf@gmail.com>
 <20260213-unyielding-pistachio-ape-deda74@quoll>
From: Erikas Bitovtas <xerikasxx@gmail.com>
Content-Language: en-US
In-Reply-To: <20260213-unyielding-pistachio-ape-deda74@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/13/26 9:54 AM, Krzysztof Kozlowski wrote:
> On Thu, Feb 12, 2026 at 04:42:47PM +0200, Erikas Bitovtas wrote:
>> Capella CM36686 is an ambient light and proximity sensor developed by
>> Capella Microsystems, now a subsidiary of Vishay Intertechnology Inc. It
>> has an I2C address of 0x60 and is fully compatible with an existing
>> driver for VCNL4040.
> 
> I wonder why and how...

VCNL4040 shares the same digital interface as CM36686. All the registers
and their fields are the same. It is most likely Vishay just reused the
CM36686 design for VCNL4040.
> 
>> Capella CM36672P is a proximity-only sensor that
>> is fully compatible with CM36686, and therefore with VCNL4040. Add
>> compatibles for cm36672p and cm36686, with a fallback for cm36686 of
>> vcnl4040.
>>
>> Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
>> ---
>>  .../devicetree/bindings/iio/light/vishay,vcnl4000.yaml  | 17 +++++++++++------
>>  1 file changed, 11 insertions(+), 6 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml b/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
>> index 4d1a225e8868..2ba4d5de4ec4 100644
>> --- a/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
>> +++ b/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
>> @@ -18,12 +18,17 @@ allOf:
>>  
>>  properties:
>>    compatible:
>> -    enum:
>> -      - vishay,vcnl4000
>> -      - vishay,vcnl4010
>> -      - vishay,vcnl4020
>> -      - vishay,vcnl4040
>> -      - vishay,vcnl4200
>> +    oneOf:
>> +      - enum:
>> +          - capella,cm36672p
> 
> CM36672P is compatible with CM36686, but this is not expressed.
> Confusing commit msg and code. 

For CM36672P we create a dedicated compatible because it is a
proximity-only sensor which has the same proximity sensor configuration,
but ambient light sensor registers are missing (reserved).
>> +          - vishay,vcnl4000
>> +          - vishay,vcnl4010
>> +          - vishay,vcnl4020
>> +          - vishay,vcnl4040
> 
> Best regards,
> Krzysztof
> 

