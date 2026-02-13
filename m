Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C6634A793
	for <linux-iio@vger.kernel.org>; Fri, 13 Feb 2026 08:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770973020; cv=none; b=fOhW/2GFTzAlu0MCOTTXMS3VLl+0TJ4dvCbeXPQaYNyJI+jBvvjjWo5xMYc3GZoYyFbNuiZTUjarH4gi206lTxVj00TYKMmKEK5EvM0/YxYrgd75TETYTvmPoy+AcFu5h+Hg6UPc0BhS/EI5yfo1c/O32sQUNZkea8WXjqYWNlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770973020; c=relaxed/simple;
	bh=Usvq3+GYA4VQwXiEk4EQAYwzenht0eLbQUxTReVkrXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RIWIzMVXFgx/9RshaqkArhpswOnOIwsexhyUiEADGe7i4xuj/d25haMRrjS6jE3bOeoP9KslXqHOSvtutY0ZWWR9vpqbUemtUU4LNe6Nfg/1jEwESzEvlrqbduW+7+RE1P4FSVED6675NaT2Od8xd9HmQAyLQrFO/vlyXoCImkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GI1eSFhC; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GI1eSFhC"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7974d908318so8963397b3.1
        for <linux-iio@vger.kernel.org>; Fri, 13 Feb 2026 00:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770973018; x=1771577818; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fS+ISWa72W+g6JkqlchkqQ6Ii61m95nh1ydzb82hfZg=;
        b=GI1eSFhCDTfNO3ptIdDOiXWxDZlevyXw0ejtCxvgCmWswn6fmCmVYBPPm55NfjNYrL
         LsweHu6/VhSkRISEjNPgvH3f81R89vR0DQHkYM+tEaUR5X/sb8gBQDyBJCIoPpGBrIIs
         hooBvF+uzvgK2kpGjlDRTp0+nFw0zeQu5O3gim7ChivK5u/5M1TzWU0mKSwAf1s9medo
         pVxOaxZVXJBfEdArRHV9kE73w5XM4slcns172NmfXsgUCY5xaD5HwRGG/ENsCr7P1YrP
         HleJYAqQmUW0/qp++OCL3Mw2YHVOtomicKUi3dD3GYNgFZtawr6FSTvQqEO/Wp+fZySU
         nSsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770973018; x=1771577818;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fS+ISWa72W+g6JkqlchkqQ6Ii61m95nh1ydzb82hfZg=;
        b=poBtNZaQCrQNBmzJEtKb095Uy6QS80KXPlw1TxrF9yNOinO5Thuok0wWddrxQuw14H
         v+MSidhJni9wgeqrCAiEw/+xTM3O9lxdsHTKeGxHnA2ElUbalhKQOxGgZUQGJdgB9m2y
         LNZoMTFL0e1TNUcqp68QGzKEFZehk+IFCTHF7eDFyWTC3NlGfQerhLLO5j9y/RhNSOcF
         DTpKc1xZBNpznPGTC2Gu5AJJCJX0E02rXKcOXkYw0kLX/43cBi5Idc6PaKuosu3CwL0T
         8PXM7xTBn37r2/PfIniLeIY+Jn+y5vGj09Y+k40hZPxwSOjBjtzMuQSCj0YvrEhpCs1N
         twhA==
X-Forwarded-Encrypted: i=1; AJvYcCVS54q2hYQtPzLwX3tKGGIM84Kn/jrJ55aqjTtA+zvSzmeSpEd09xLmpa/Q/2R4ZR6NmfclldB7KVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYMaxJGtfH8cWggM1v2fJng14QfLDkUWw9vQvCtAw2dYQWnN14
	JD4yoD72DHcC/4/anmcMoYTLzSgJ7m/SuQyGl6xPrXv6uLmra6kOVjs7
X-Gm-Gg: AZuq6aJgp6ZG3TRl/xyWipM5Y5q3ZLZ6RPOPhXLmHj13+tyT4KoFnXDvfK8RCjl8pmQ
	w7wUdYLefD8+37Qh4Z/DJtUrczEPIE9AtM7YH44ighEBUNTF919y92s9cYh2TFrVlLMSX3qBTSB
	T70yz8RcX/u4ejbva43SLmTahL2+6hLwT3Ibsxo+dRxq85BMLA1nnRXr3rb60msj3ku9+wLAfqU
	Gp0r9tHcIWyYWi2xhBaQFrZDhKhbqgpx1zT4r48OPTeD8OxHw/Kbi1Di/BN/lSEMkDi9eX12z/b
	H3XPU9RcltSgvZRAsc/pe4olyefhQrAMLRLcQLcEcuQ3gjgjOkaH9zjbNUM5M/ItYS2QIgFhU9P
	UcJzypgf72ZCBGQJ/u9EkyjR77XkODC1diH8/8rCHufPnkdUdLU3UBaGyhvqknEfhToaHkPiOa4
	bvzdtmYa3D01hti49B5V+02YBPOg==
X-Received: by 2002:a53:d014:0:b0:64a:dcb3:732 with SMTP id 956f58d0204a3-64c19b2ec54mr554017d50.60.1770973017911;
        Fri, 13 Feb 2026 00:56:57 -0800 (PST)
Received: from [192.168.0.40] ([79.133.247.80])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64afc83fa7esm6670723d50.1.2026.02.13.00.56.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Feb 2026 00:56:57 -0800 (PST)
Message-ID: <f014078c-6e4d-48b0-a814-45898b005c44@gmail.com>
Date: Fri, 13 Feb 2026 10:56:52 +0200
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
 <3a20c906-647c-458f-a118-c7927495e7ef@gmail.com>
 <8fb27a7a-82dc-443b-bcc4-21007783fc54@kernel.org>
From: Erikas Bitovtas <xerikasxx@gmail.com>
Content-Language: en-US
In-Reply-To: <8fb27a7a-82dc-443b-bcc4-21007783fc54@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/13/26 10:51 AM, Krzysztof Kozlowski wrote:
> On 13/02/2026 09:29, Erikas Bitovtas wrote:
>>>> Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
>>>> ---
>>>>  .../devicetree/bindings/iio/light/vishay,vcnl4000.yaml  | 17 +++++++++++------
>>>>  1 file changed, 11 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml b/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
>>>> index 4d1a225e8868..2ba4d5de4ec4 100644
>>>> --- a/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
>>>> +++ b/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
>>>> @@ -18,12 +18,17 @@ allOf:
>>>>  
>>>>  properties:
>>>>    compatible:
>>>> -    enum:
>>>> -      - vishay,vcnl4000
>>>> -      - vishay,vcnl4010
>>>> -      - vishay,vcnl4020
>>>> -      - vishay,vcnl4040
>>>> -      - vishay,vcnl4200
>>>> +    oneOf:
>>>> +      - enum:
>>>> +          - capella,cm36672p
>>>
>>> CM36672P is compatible with CM36686, but this is not expressed.
>>> Confusing commit msg and code. 
>>
>> For CM36672P we create a dedicated compatible because it is a
>> proximity-only sensor which has the same proximity sensor configuration,
>> but ambient light sensor registers are missing (reserved).
> 
> I don't understand this. You just wrote "fully compatible with CM36686"
> and now you imply that not.
> 
> Decide.
> 
It is not. CM36672P supports only a subset of CM36686 features, in
particular the proximity sensor. That is what I meant initially.
I am sorry if the previous phrasing caused any confusion.
> Best regards,
> Krzysztof

