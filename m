Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6656537D130
	for <linux-iio@vger.kernel.org>; Tue, 19 May 2026 07:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779174810; cv=none; b=iJDY4m0v1uF3t6gmdaSO2nh5LawxGpFqojripyTbeA0X8f4Tt3FgiVbUBGfNujPQ7el/hTU2kktTxTuae+cc5YAWgrw5DrH9AWGHpmoWPRlhBs52e8MRwVzXw62BVsIgu2PWCOj9ubLLkHWislNDjB50ySg5oh/3Bc2zHANuktU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779174810; c=relaxed/simple;
	bh=DNa2YgIosKX/M6mszuSfbYa/OvjT8Or2H8POimcsZiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UMZvLzUBEo1tROBxO4mwhWg24lapUGdxldhIrNk+1poEtoNeQri0Q6cutb2j0gNNbzoEufKB5c0w8mh07x0kfwukbkEgUVSj+sR/je98dJZUD/C+2FGGlw/fRY3ExP2fZtPom8PWmgDTb2MkdHtubCYBys6CBtGFMiY74M5EKzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O8iG4DII; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8iG4DII"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-44ce78ab5feso2651132f8f.0
        for <linux-iio@vger.kernel.org>; Tue, 19 May 2026 00:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779174808; x=1779779608; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EyfD1jRHw+lTzdqMpMGCHM2mGtkyELJS7N9dh1Uecmg=;
        b=O8iG4DIIgszzRVDpsrTqnAR9HlG/jyV5jKrJ/HH33/E729InBhC2JeKGHVy/AKCQCw
         eAFlLPBcYre5U6AD43JyFxCS2dWJmiidTWo1susWgT3UpAnymaJrViU9XjQWleW8K1YE
         7Sl9lTG/ESSXpiMPRdJjo5qBKY0/8UOxIPcY9LIfCTkObx+ihUTwuvQm21SkUR4BfMpv
         GHc/3dFPiONvI+PCOH7hZDYFm9baQi350mTo5ryWO2MArNUrwtferN4Bp/vjcf6RLup4
         oMpR85/Njzc606N1MXkSaiS/buFHQJS9zPlBMBPXp84Q5cHeD51BR8eDYRr8N65/DSvH
         0+9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779174808; x=1779779608;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EyfD1jRHw+lTzdqMpMGCHM2mGtkyELJS7N9dh1Uecmg=;
        b=cNBqaTohasB+KkXZ5SBhY0PcXBCMQQvwVOrnaNw242vp7lp3KafF1vHSwGIvyR1tqQ
         0mTcz1pNaSzr32cgBASawbyM5BqL/aky2JJdDEn+NqC2A2Zy0VS0E/V1zj1aXQAj+k3G
         5hc1M61a6yB3hZd34qMD+EPO/oGsdzeNRMC07QZO/KeARDzG4xM9NdTF1rmjiUUAbZms
         dZ4uJuUo7RDEX4GEg1zLrWf/qyh/NgmT5/XGKotJYJbgufLMYbxQ6DR0A8uRXV1lA1Sz
         VI8MsqVngAP9UJ3EakAN5xLcZF5GnvAInn5fUexxJ6zBWtNButfTd0FrFvw+1kpniez+
         K44g==
X-Forwarded-Encrypted: i=1; AFNElJ9yv5TfSXnIX+lTz9zr3tOXzU0TMIS0uep0R5hMXbMcwwOhqtSMVwViDth/5o64zujNQ1vonjVZPlA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCK5KSbxWAn/jDWvPuKtJ96MYyH0yidLmhTCjs30+BrigFD0Yp
	4Td+mbPnkIY4R7YTbUAj/qNvICRYp7QIUAU5HMw3vu7wYFNt6c7xSL9T
X-Gm-Gg: Acq92OE4InUErQE6BOs4UnsXGmhu/MGUvOYXKvLr6y0EhXBd+DPwWbbM8FYIWHW/N7C
	e7En5eNgVK3eXw/6ouM30/61WNDupQ+J0BOXTaWisiwYpZ2PcmwXuVxYKW+yiMbOvOMvw2IOqpu
	XWxzXi52/yQdJrW7HTwk6QI2LLNh3qM6DEEoE/Tlw4EnJ3OpKc9Wsg8ZDziQh6fhLsiP6jZHcqE
	NwP9bPSYqg7aj2OWOjvJCvnlLw5LTlXe2DQKX49BIH40kqRSqV93IoIj5H7n9k0oZ/UYIZPl4Xm
	+KrISBYwLd3F61aUvm8u2vTn6EAC27xMc9xmdRfAUh3YLr37+5fjnxXdADKRXnwEyYLr62z/Z+v
	J3834BX5qztYc6LDFG0OI04ko3AXN7NGWzOFVVOCC+pCgaJ2eCy/+BnRhSevOVAKNXTjA7PI60P
	TiJXkIoJaJ7PD5G9GAXM4XxC3b4fiqEfgaWHsraln89V17sgdBVCaO9H7rWDHD8tLUw7Cv
X-Received: by 2002:a05:600c:35cc:b0:48f:fe2a:107b with SMTP id 5b1f17b1804b1-48ffe2a1125mr215072135e9.7.1779174807629;
        Tue, 19 May 2026 00:13:27 -0700 (PDT)
Received: from ?IPV6:2a02:3033:6d8:15d8:ec15:f5ad:b85f:a3b8? ([2a02:3033:6d8:15d8:ec15:f5ad:b85f:a3b8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fea52a0bfsm151837045e9.0.2026.05.19.00.13.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 00:13:27 -0700 (PDT)
Message-ID: <e245de68-555a-42c8-900b-a4abbaa4ea3e@gmail.com>
Date: Tue, 19 May 2026 09:13:24 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: iio: dac: Add AD5529R
To: David Lechner <dlechner@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>, Janani Sunil <janani.sunil@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 rodrigo.alencar@analog.com
References: <20260508-ad5529r-driver-v2-0-e315441685d7@analog.com>
 <20260508-ad5529r-driver-v2-1-e315441685d7@analog.com>
 <20260508134843.7646c4f5@jic23-huawei>
 <53d547ee-1ac3-42b9-92a6-e7f48b72fee3@baylibre.com>
Content-Language: en-US
From: Janani Sunil <jan.sun97@gmail.com>
In-Reply-To: <53d547ee-1ac3-42b9-92a6-e7f48b72fee3@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 5/16/26 21:25, David Lechner wrote:
> On 5/8/26 7:48 AM, Jonathan Cameron wrote:
>> On Fri, 8 May 2026 13:55:47 +0200
>> Janani Sunil <janani.sunil@analog.com> wrote:
>>
>>> Devicetree bindings for AD5529R 16 channel 12/16 bit high voltage,
>>> buffered voltage output digital-to-analog converter (DAC) with an
>>> integrated precision reference.
>>>
>>> Signed-off-by: Janani Sunil <janani.sunil@analog.com>
>>> ---
> ...
>
>>> +  * Multiplexer for output voltage, load current sense and die temperature
>>> +
>>> +  Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ad5529r.pdf
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: adi,ad5529r
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  spi-max-frequency:
>>> +    maximum: 50000000
>>> +
>>> +  reset-gpios:
>>> +    maxItems: 1
>>> +    description:
>>> +      GPIO connected to the RESET pin. Active low. When asserted low,
>>> +      performs a power-on reset and initializes the device to its default state.
>>> +
>>> +  vdd-supply:
>>> +    description: Digital power supply (typically 3.3V)
>>> +
>>> +  avdd-supply:
>>> +    description: Analog power supply (typically 5V)
>>> +
>>> +  hvdd-supply:
>>> +    description: High voltage positive supply (up to 40V for output range)
>>> +
>>> +  hvss-supply:
>>> +    description: High voltage negative supply (ground or negative voltage)
>> I don't mind doing it this way but in some similar cases where 0 is something that
>> can be considered the 'default' we've made the supply optional.  What was
>> your reasoning for requiring it in this case?
>>
>> dt-bindings should be as complete as we can make them - with that in mind...
>>
>> There are some more interesting corners on this device the binding doesn't
>> currently cover such as mux_out pin.  We'd normally do that by making the
>> driver potentially a client of an ADC
>>
>> Easier though is !alarm which smells like an interrupt.
>> !clear probably a gpio. TG0-3 also GPIOs.
> also optional vref-supply for external vs internal reference

I will add bindings for optional Vref supply in the next version.

Best Regards,
Janani Sunil

