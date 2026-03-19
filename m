Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA6A3DD514
	for <linux-iio@vger.kernel.org>; Thu, 19 Mar 2026 14:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773932333; cv=none; b=FOX0veT9kv3kJvWA5KSptFLezJmFz57BGKNpQ3a/tfE/B2bXhAs2p0LbXRsISbpSBRQvoLqpQ6Png/xWaayKWwdqkcQnhCEEDgtuB970nX943oHcjBPKUsxrcNXpI396Rp1mxa/++DTsI06ZRJuC0dVjkzYdN1AMRIdxM1GdKD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773932333; c=relaxed/simple;
	bh=mM0Qjq+/PhARnJ1OuOTZXrhsKNJy65FaO78/hLNdAgw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ws7mg52T/yxT1LASh3spGvr1UnyEWTNG6tzf48YCB0QMkH5H8yl9WJa7NLdiQMo7D/4H4DWM29HEhs7ryKGRR1KD99q5GtD1S0Nrzy9cl/pvnoRpC8I5g77ku+PfZvaMs23XyPOGREPdCihUUGjBcR/e67wnI4ery/C3qMX2ZEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ZSOfnffm; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ZSOfnffm"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-467161c4a1cso291325b6e.3
        for <linux-iio@vger.kernel.org>; Thu, 19 Mar 2026 07:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773932329; x=1774537129; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PamUifGDxzKgYduTgi5+Bz1Hbj65Bi8zeh///fvaP8k=;
        b=ZSOfnffmH/dkxGYvWQoDZm6CezWNuce5MrgNhq9DdbZtYOxzl2PiC7WgovRE+RNbPq
         cybRtCbsgDJHUDg1PkmGa9WaWe+CF8KdgCL7qKhkdVlVpt+6vuNjkz6opKLcL9SHxLbN
         0KDcK82KR/pyAMmCQEnEr8EQQHyUZI5qVMK0H4SLXN1STT9uVO6r4C4J8Ce+oyORbEQW
         LbUB0O9wvfMQPnxJzYVRitSK9PLpToAMZm6JpGNkxVNTDbqdCuxJ9Ed3tmpGSxvobMEM
         wMpI6tsBNom6r/mHSvs0oKculL3wbUtssG4tBqxiltvdt7MQfhKOEBX4VYEnmLkBfHO0
         F62g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773932329; x=1774537129;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PamUifGDxzKgYduTgi5+Bz1Hbj65Bi8zeh///fvaP8k=;
        b=sxuhU0lf1QBZiNYD/XKUYDlrZrlhwY8gbSmzfYpX6I635KCTIrWkruP8GZGJoAGG5k
         UYzxVGSFQ9JLWfMxrES5YWvSMjhkUKFsoWDLTxTdpdsMVRXxhsY/jr+nx2pD56LUeubg
         Dyw9zb/KZQZmnKOXjEe/gZsWu/C/xK8m2YFnhZ4/2usMH4/vLwEr7W+7GmTJzk4LD4Sx
         7pUOdMO6j1+9OWOq4OIr4dDP8GN3+BtULfqJUuXjcyawrBGYRuk/dTl5vALXXCdyyTTj
         qPwQTODlphFDiRMK4vmq8MvGpEWbWitpI7APByxlGliun+ivcV5BgkeRM3hegOzdH5AE
         uh5w==
X-Forwarded-Encrypted: i=1; AJvYcCX1U4srYt1KDLv48/qw509uiffK1FrqXnHRp5JP04BvFhcjCPg3aWp5+j08igD3ZyAmZSuDSOVjMd8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOWh4MpnjME50h44RSUndDTSEy6wGMHO9d/L+KgHiPV6BdMSBu
	c4KRkXkWSO1dXfL58PSuNtFQphlluieZdru+71XOFkkKxJLwGge7CVFZh3sFPcpQgcM=
X-Gm-Gg: ATEYQzz1sPz6X8fCe1G6myYmxqhe50Ekyjr6HGc7Mzw7pZvq6lOrp+3tQDrSAA3rDcI
	cXez70Ufyjzq1WrDoCxjRk4Wq2HOYoC2vN8VYtQbvCG7aMndEV8NzWjIP0QRKlloSj2ENQoq9tK
	8tg1BhCDN5AjeVsTBv9Ry1r+bVSgUGGHQYO4dfljXS92qjyzg4Xy194uqRp5xZXAi6qGVnsjmrt
	nSRRojTcFIwid9vI5LZWdpWoFRb7o9RTUNGP9nKym6109O/SGyWAHdEJ1aLNPRBaGZktJZxWY5e
	u9ZhxvaIUkW6hn9InLfb1qkDA1TwVEF/KRcwUBZX+2xRqYZXVAcL2K5t8AHqqIrow67fvFW+X8q
	xfRpN0L8AbQJwXsoZgOsLFwdGgOYOHauvQkRIdrxIU5mqFXYVyOCCkVMu0P5jxilH3jV/MnbBqa
	ikaRuHNIkekUQrxI+HvULPRq48aE6GYPZrUR7lQm3jDNFSNOL6Wo0za0H51cqlZ5HtrSHOjKjF1
	UjkGy9bCGHR
X-Received: by 2002:a05:6808:1451:b0:467:1cf5:7684 with SMTP id 5614622812f47-467ba15eaddmr4227888b6e.6.1773932328449;
        Thu, 19 Mar 2026 07:58:48 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:244c:fc8c:8216:1344? ([2600:8803:e7e4:500:244c:fc8c:8216:1344])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41bd22dee78sm6087744fac.0.2026.03.19.07.58.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2026 07:58:47 -0700 (PDT)
Message-ID: <f1706ec0-3995-4fdf-a9fb-8e1e688438a7@baylibre.com>
Date: Thu, 19 Mar 2026 09:58:46 -0500
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
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <e4c9729f-1785-4d10-a337-37b0d26fe30b@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/19/26 9:49 AM, Sai Krishna Potthuri wrote:
> Hi David Lechner,
> 
> On 3/19/2026 7:53 PM, David Lechner wrote:
>> On 3/19/26 8:52 AM, Sai Krishna Potthuri wrote:
>>> Hi Krzysztof,
>>>
>>> On 2/21/2026 4:08 PM, Krzysztof Kozlowski wrote:
>>>> On Fri, Feb 20, 2026 at 11:09:41AM +0530, Sai Krishna Potthuri wrote:
>>>>> Convert the xilinx-xadc.txt Devicetree binding to a YAML schema format
>>>>> and remove the old text binding.
>>>>>
>>>>> +
>>>>> +  xlnx,channels:
>>>>> +    $ref: '#/$defs/channels'
>>>>> +
>>>>> +allOf:
>>>>
>>>> Missing ref since you use unevaluatedProperties...
>>>>
>>>>> +  - if:
>>>>> +      required:
>>>>> +        - xlnx,external-mux
>>>>> +      properties:
>>>>> +        xlnx,external-mux:
>>>>> +          enum:
>>>>> +            - single
>>>>> +            - dual
>>>>> +    then:
>>>>> +      required:
>>>>> +        - xlnx,external-mux-channel
>>>>> +
>>>>> +required:
>>>>> +  - compatible
>>>>> +  - reg
>>>>> +
>>>>> +unevaluatedProperties: false
>>>>
>>>> or you meant additionalProperties?
>>>>
>>>>> +
>>>>> +$defs:
>>>>
>>>> Why this is a def, not used directly? I see only one usage of this def.
>>>
>>> I am getting the below error if i define the patternProperties directly.
>>> Seems like complex vendor peroperties should be referenced via $ref.
>>> Please suggest if there is any better way to deal this.
>>
>> It is hard to say without seeing the new version of what you wrote.
> 
> In v1 series, i created $def and referenced this in xlnx,channels to avoid the error that i mentioned.

Is the code below the code that causes the error?

> 
> v1 code:
>   xlnx,channels:
>     $ref: '#/$defs/channels'
> 
>   $defs:
>   channels:

Is this indent bug just from copying to email or does it exist in
the source that is causing the error?

>     type: object
>     description: List of external channels that are connected to the ADC
>     properties:
>       '#address-cells':
>         const: 1
>       '#size-cells':
>         const: 0
> 
>     patternProperties:
>       "^channel@([0-9]|1[0-6])$":
>         type: object
>         properties:
>           reg:
>             minimum: 0
>             maximum: 16
>             description: |
>               Pair of pins the channel is connected to:
>                 0: VP/VN
>                 1-16: VAUXP[0-15]/VAUXN[0-15]
>               Note each channel number should only be used at most once.
> 
>           xlnx,bipolar:
>             type: boolean
>             description: If set, the channel is used in bipolar mode
> 
>         required:
>           - reg
> 
>         unevaluatedProperties: false
> 
>     required:
>       - '#address-cells'
>       - '#size-cells'
> 
>     unevaluatedProperties: false
> 
> 
> Regards
> Sai krishna
> 
> 
>>
>>
>>
>>>
>>> linux-xlnx/Documentation/devicetree/bindings/iio/adc/xilinx-xadc.yaml: properties:xlnx,channels:type: 'boolean' was expected
>>>      hint: A vendor boolean property can use "type: boolean"
>>>      from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
>>>    LINT    ../Documentation/devicetree/bindings
>>>    DTEX    Documentation/devicetree/bindings/iio/adc/xilinx-xadc.example.dts
>>>    DTC [C] Documentation/devicetree/bindings/iio/adc/xilinx-xadc.example.dtb
>>>
>>>
>>> Regards
>>> Sai Krishna
>>>
>>>>
>>>>> +  channels:
>>>>> +    type: object
>>>>> +    description: List of external channels that are connected to the ADC
>>>>> +    properties:
>>>>> +      '#address-cells':
>>>>> +        const: 1
>>>>> +      '#size-cells':
>>>>> +        const: 0
>>>>> +
>>>>> +    patternProperties:
>>>>> +      "^channel@([0-9]|1[0-6])$":
>>>>> +        type: object
>>>>> +        properties:
>>>>> +          reg:
>>>>> +            minimum: 0
>>>>> +            maximum: 16
>>>>> +            description: |
>>>>> +              Pair of pins the channel is connected to:
>>>>> +                0: VP/VN
>>>>> +                1-16: VAUXP[0-15]/VAUXN[0-15]
>>>>> +              Note each channel number should only be used at most once.
>>>>> +
>>>>> +          xlnx,bipolar:
>>>>> +            type: boolean
>>>>> +            description: If set, the channel is used in bipolar mode
>>>>> +
>>>>> +        required:
>>>>> +          - reg
>>>>> +
>>>>> +        unevaluatedProperties: false
>>>>
> 

