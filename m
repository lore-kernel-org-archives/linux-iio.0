Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A6039DBD1
	for <linux-iio@vger.kernel.org>; Thu, 19 Mar 2026 15:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773934548; cv=none; b=kffdGfxQYMPlMF6EcV0oo9/wJEZHPK9NzFyH2SqW/cNBHCZAHDw8ChMYmJMYTHXEV4mRtIFEz8zqgi4tQTdadRrCVas2t1tFdtUrNm/CdasVv5d53bz2wqguJLfaTpCYrZRC1BmiW0bQSathddssND2NOth+kCS41AlyHowreAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773934548; c=relaxed/simple;
	bh=DP1n5jEgeDsd1U6DJZVTA0i7g5bI0fS21/JAj+I+l4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TJ+AjPobw/nHs15dC2xCx52LZrmoN76pI0QUIQd1+qJmv/vJKztYFvYfVKYaOfor3Nu9tKKkxvCWIMFGyKDuLF/4KT38UIgSYcFKTq52UTvJdn8o0MiTMSxIfWXpSvXR8SDd6oWHMFqkKHiZPPX/bizlymbHWWbqsqSyCkTg6d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qE8icw7I; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qE8icw7I"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7d1872504cbso894674a34.0
        for <linux-iio@vger.kernel.org>; Thu, 19 Mar 2026 08:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773934543; x=1774539343; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Eg6/k+hv0RLNPOr6IdZwf3a02afm+3/zRNxt2fKLYZg=;
        b=qE8icw7I21u0+kYLTE8AVT3YGp61nvo3jp+ksQr0GeERTIHyBSLbFPflOL4Lbd2MQO
         DOfMoIQrgJ+YIBNJQ8JP1ekUZETM/8HdKhUg/xDuwHLUoU0Ybf4Fh/gpaH/c9iRH4zr9
         b4khVdzqeuHQJTGVeb88fsZ2KQc5ivse/9KF3xIzPxlS+cwGvYT3AYcnAGMBlWj+YC7i
         J5FDEGMeiXLSe97WEPAZhs/EhXrSbGG/1ebiU/inuRkWK5gWipNY21Czz2cD1ASGFj6B
         XcHF6aGLgq/tQG8zPnnaBFPMMiRg6BcgD5ls7/ZC7DfPROIp79BCOzOW++ONXSSK93jF
         vspg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773934543; x=1774539343;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Eg6/k+hv0RLNPOr6IdZwf3a02afm+3/zRNxt2fKLYZg=;
        b=Bc5y4eByQH/IGKJ4uEwnHe1nYAaKhVg/2ZSnzohfq2pulxWb+1fNUfQuNdgr3u2+ED
         5l1erLDjoIT1UJttfrYWBCCx42lAjXZDDdPHqY20M4wTT7nYg6WMt0VX8keiSn4uPonp
         oavwefefSITNZDtHh4DA9uL81Ch4jTSvkv3TJqOoHDxhZLuuY0HEAEOXbm4RsnQvKDML
         4XY+TM2dJxyAoa9Wxqhx8ey4/rlePqA/KM2xvZ4Nv1ORDSx0nLhajXwvK21WtZbnsahu
         SuPwZtV+bP4colChjzt4ncjoNRTRI0wKsUgtk459Mb8RpefRMJ7Xm2T0/mJy3yFaxOja
         mGDw==
X-Forwarded-Encrypted: i=1; AJvYcCXvef7K4tjJbDbjbiglf4rk+opMnBIqHKypbeSMD5DMniTd1b7u1p7o2ikuc7Wcyn89BOycDQwNcnE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+aC/RdlO7fZC8qwPT1VDTsl+zMebT/VS+2ZQ6MD+D0a4PXQU5
	HtcWxK3/o66iugsIZXnZNPmT3yTNTaoielkr40QI3MpsDZ57YC48MXk0ZvUD7iNKhbQ=
X-Gm-Gg: ATEYQzwIrDkeK5xn4RpJj5ReaTvOgbMWjqQQhDBYWJBydXGdi3yAr83z8l+EtfR5mZc
	EAM56o9U052lQnCRK9c2Q2jkCqyBTNE5cQ0Nb7olHjYVSN/MdnRA3JqZ2AtpHnpkT+n67qCC2Qq
	hEqJlH/P8VzNQEIt7rYQczpgSsKgyhLfSrni90Odw4rZN2Pt5UM4xf7sRHBomQZeKFhTY8yf2jj
	LsVv5dbbIhNVpz9FgOAStMb0a5K2b/3dkhaG4nIc4MuXjj5OVeWQI0Spsd0AlFiv5A1ssioUzwe
	CU6XOvVSrI9NBjbYk+6QJHPEQWEbS7jre2kHD8X3PAqJotRDnvIv3gmNSDZtzNY4d2Js080c4wh
	gYiGuyFweaTVfqfqcuXqrlf87aWUo3gZyPUfVlzGYO4qOZ5arkURW2PF34tXabjMG8NnMny3fT3
	pr1JKsgCUdAMgQKpjErz4g9kNft2xOTfZgu2XEF4Du0MOY7dDMJiiTlGjp3POzzPwdmdyyQuPpM
	A==
X-Received: by 2002:a05:6830:270a:b0:7d7:cc47:9623 with SMTP id 46e09a7af769-7d7da6a6b2cmr2306179a34.10.1773934543473;
        Thu, 19 Mar 2026 08:35:43 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:244c:fc8c:8216:1344? ([2600:8803:e7e4:500:244c:fc8c:8216:1344])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d7c9bbf132sm4630615a34.25.2026.03.19.08.35.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2026 08:35:42 -0700 (PDT)
Message-ID: <cf749e8c-f141-4367-81ad-827e02273ec5@baylibre.com>
Date: Thu, 19 Mar 2026 10:35:41 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] dt-bindings: iio: adc: xilinx-xadc: convert to YAML
 format
To: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, saikrishna12468@gmail.com, git@amd.com
References: <20260220053941.611415-1-sai.krishna.potthuri@amd.com>
 <20260220053941.611415-6-sai.krishna.potthuri@amd.com>
 <20260221-dancing-papaya-wolverine-db8afd@quoll>
 <b89933a3-5f25-466c-a2f5-6e231aa12749@amd.com>
 <21d425bc-9406-401b-9817-7255ba3d31fc@baylibre.com>
 <e4c9729f-1785-4d10-a337-37b0d26fe30b@amd.com>
 <f1706ec0-3995-4fdf-a9fb-8e1e688438a7@baylibre.com>
 <05bcc5b7-b3e8-40fb-be70-413c74afcfb1@amd.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <05bcc5b7-b3e8-40fb-be70-413c74afcfb1@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/19/26 10:10 AM, Sai Krishna Potthuri wrote:
> Hi David Lechner,
> 
> On 3/19/2026 8:28 PM, David Lechner wrote:
>> On 3/19/26 9:49 AM, Sai Krishna Potthuri wrote:
>>> Hi David Lechner,
>>>
>>> On 3/19/2026 7:53 PM, David Lechner wrote:
>>>> On 3/19/26 8:52 AM, Sai Krishna Potthuri wrote:
>>>>> Hi Krzysztof,
>>>>>
>>>>> On 2/21/2026 4:08 PM, Krzysztof Kozlowski wrote:
>>>>>> On Fri, Feb 20, 2026 at 11:09:41AM +0530, Sai Krishna Potthuri wrote:
>>>>>>> Convert the xilinx-xadc.txt Devicetree binding to a YAML schema format
>>>>>>> and remove the old text binding.
>>>>>>>
>>>>>>> +
>>>>>>> +  xlnx,channels:
>>>>>>> +    $ref: '#/$defs/channels'
>>>>>>> +
>>>>>>> +allOf:
>>>>>>
>>>>>> Missing ref since you use unevaluatedProperties...
>>>>>>
>>>>>>> +  - if:
>>>>>>> +      required:
>>>>>>> +        - xlnx,external-mux
>>>>>>> +      properties:
>>>>>>> +        xlnx,external-mux:
>>>>>>> +          enum:
>>>>>>> +            - single
>>>>>>> +            - dual
>>>>>>> +    then:
>>>>>>> +      required:
>>>>>>> +        - xlnx,external-mux-channel
>>>>>>> +
>>>>>>> +required:
>>>>>>> +  - compatible
>>>>>>> +  - reg
>>>>>>> +
>>>>>>> +unevaluatedProperties: false
>>>>>>
>>>>>> or you meant additionalProperties?
>>>>>>
>>>>>>> +
>>>>>>> +$defs:
>>>>>>
>>>>>> Why this is a def, not used directly? I see only one usage of this def.
>>>>>
>>>>> I am getting the below error if i define the patternProperties directly.
>>>>> Seems like complex vendor peroperties should be referenced via $ref.
>>>>> Please suggest if there is any better way to deal this.
>>>>
>>>> It is hard to say without seeing the new version of what you wrote.
>>>
>>> In v1 series, i created $def and referenced this in xlnx,channels to avoid the error that i mentioned.
>>
>> Is the code below the code that causes the error?
> 
> No, the below code is not creating the error but Krzysztof asked the question on this code,
> "Why this is a def, not used directly? I see only one usage of this def."
> 
> I am saying if i don't use the def and use it directly i am seeing the error that i mentioned. So, asking is there any better way to handle this case other than using def.

If you could show us the actual code that is causing the error, then
we could perhaps spot a mistake or suggest an alternative.

> 
> Regards
> Sai Krishna
> 
>>
>>>
>>> v1 code:
>>>    xlnx,channels:
>>>      $ref: '#/$defs/channels'
>>>
>>>    $defs:
>>>    channels:
>>
>> Is this indent bug just from copying to email or does it exist in
>> the source that is causing the error?
>>
>>>      type: object
>>>      description: List of external channels that are connected to the ADC
>>>      properties:
>>>        '#address-cells':
>>>          const: 1
>>>        '#size-cells':
>>>          const: 0
>>>
>>>      patternProperties:
>>>        "^channel@([0-9]|1[0-6])$":
>>>          type: object
>>>          properties:
>>>            reg:
>>>              minimum: 0
>>>              maximum: 16
>>>              description: |
>>>                Pair of pins the channel is connected to:
>>>                  0: VP/VN
>>>                  1-16: VAUXP[0-15]/VAUXN[0-15]
>>>                Note each channel number should only be used at most once.
>>>
>>>            xlnx,bipolar:
>>>              type: boolean
>>>              description: If set, the channel is used in bipolar mode
>>>
>>>          required:
>>>            - reg
>>>
>>>          unevaluatedProperties: false
>>>
>>>      required:
>>>        - '#address-cells'
>>>        - '#size-cells'
>>>
>>>      unevaluatedProperties: false
>>>
>>>
>>> Regards
>>> Sai krishna
>>>
>>>
>>>>
>>>>
>>>>
>>>>>
>>>>> linux-xlnx/Documentation/devicetree/bindings/iio/adc/xilinx-xadc.yaml: properties:xlnx,channels:type: 'boolean' was expected
>>>>>       hint: A vendor boolean property can use "type: boolean"
>>>>>       from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
>>>>>     LINT    ../Documentation/devicetree/bindings
>>>>>     DTEX    Documentation/devicetree/bindings/iio/adc/xilinx-xadc.example.dts
>>>>>     DTC [C] Documentation/devicetree/bindings/iio/adc/xilinx-xadc.example.dtb
>>>>>
>>>>>
>>>>> Regards
>>>>> Sai Krishna
>>>>>
>>>>>>
>>>>>>> +  channels:
>>>>>>> +    type: object
>>>>>>> +    description: List of external channels that are connected to the ADC
>>>>>>> +    properties:
>>>>>>> +      '#address-cells':
>>>>>>> +        const: 1
>>>>>>> +      '#size-cells':
>>>>>>> +        const: 0
>>>>>>> +
>>>>>>> +    patternProperties:
>>>>>>> +      "^channel@([0-9]|1[0-6])$":
>>>>>>> +        type: object
>>>>>>> +        properties:
>>>>>>> +          reg:
>>>>>>> +            minimum: 0
>>>>>>> +            maximum: 16
>>>>>>> +            description: |
>>>>>>> +              Pair of pins the channel is connected to:
>>>>>>> +                0: VP/VN
>>>>>>> +                1-16: VAUXP[0-15]/VAUXN[0-15]
>>>>>>> +              Note each channel number should only be used at most once.
>>>>>>> +
>>>>>>> +          xlnx,bipolar:
>>>>>>> +            type: boolean
>>>>>>> +            description: If set, the channel is used in bipolar mode
>>>>>>> +
>>>>>>> +        required:
>>>>>>> +          - reg
>>>>>>> +
>>>>>>> +        unevaluatedProperties: false
>>>>>>
>>>
>>
> 

