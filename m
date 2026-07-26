Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D461175A83
	for <linux-iio@vger.kernel.org>; Sun, 26 Jul 2026 13:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785073588; cv=none; b=pMnDGpcLYrFDow3QOVyy4n68k1nVYIaUKWVllRnRSlNOwEAD2p+2+ewcw7QwVOcqNl1jxshMpq6JTo3iXq74baKz46lqu3jGYu42vRitUpt7aFNCdvJERhhRrqJNXvAt/Z/67uaQx89DgA3a6yie8Uv9icc7S66KZ7U+W3iUthY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785073588; c=relaxed/simple;
	bh=R7N7U3YdIPPLN/FJDOS/LQg+HJMKie0W3IPr39edPc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VizOF5dcMHGTp/lnLYpPjjSY9ByQ1SnN6YY3UOguCV6+qjnQhl5YKoxozzH+SsHJbZezpp02/87QdfxhTb3ElzAWhkRvAYm7sCvy5B5DKm+n2S19c7e4Z5STZh6nkls86UmYp/n6su7hlzjOLRh+PZkTqSzrgxg3QmyJdNyLkZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bDA9si1I; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bDA9si1I"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38e07ebd263so1248970a91.1
        for <linux-iio@vger.kernel.org>; Sun, 26 Jul 2026 06:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785073586; x=1785678386; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3GlYt82Udc/E8ne84+NQ36Q+2wgUeOfgJEOTwOxxqCw=;
        b=bDA9si1II6nhwnGMyXz1Pm/4i/2rP1lCA9zju+m7fejKenyVZWhRhUQ88vQo61ArFY
         HLlsLCfUikqCtQmAOq9cn/SYqoqF/BpmsWinT/yXWgXjb6nriUuB267wk+wS8Yofp+DV
         j3tDotRtGvb+WvYHFSKkPIvagDJBkaezaWGLd6hoWVbIgdE1Ukwz4VLu72B26iXLiNo+
         H11t9pmUcCdWMPwf2SeG43HMyXJ54wHGd9jc3kw3OCOuq90UPu9kFmlY84vZs/Hl7jDQ
         fK1StFXX/+CTTh7tmAfXvWpSw000xD7VFBFGaRH4q76tK8oMKkYa0Bw/1x+0omXQWdG3
         AvuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785073586; x=1785678386;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3GlYt82Udc/E8ne84+NQ36Q+2wgUeOfgJEOTwOxxqCw=;
        b=dW8EF+Ni4QiBpXq4C+3R0iIqdDOEn5hq+d1k72yKxq41k7thG2kaxi1332I8znZwT9
         +2YSL41zjOsCsSagzqszBDGs4vYZck9YgPAGDCLHdIXRy3xpIbu3p7BDr8Q519w32w1q
         d1ZwOgfaB0QvagR/j8c0xdOtwEd7mogd4k1jQpQPaMQh+JL2JNYDacRpkjOMhg1lXcf6
         /7v4zMA1SpEC628vVOC19jlO0J/phmEWx8SlcMAQgMFKSXEaxQoksdTMI861NXvxAU0Q
         Ifx4S3J5VC+FTTuPKBN5T9btfa0sdhIQr4q1usLz956wNN/qogZVehJUj24A8gRMF6u5
         E0Gw==
X-Forwarded-Encrypted: i=1; AHgh+Rr8selx40Lc9YH/GH9bitfHnN7M0JHJeYj17QTAbmu+lmAnEqijRy5ksWbOPIumv5CMnLfAOOIDi3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhhcnYoePHNzIdB25KAWa3hVkZ+ktMevpil3y1O48lWoB/bQfr
	xjGM2H4wjp4S/Gb1k0Oftm6A46oVcvbklaUPJs68JvcYwqlLdiaFLAF5
X-Gm-Gg: AR+sD12cUUuciS3nem/dVsOdGP7xFHO6cfycUXf9VLSoR1kWJfIyoeWSICB5w/8gRrd
	kFFcmcb7ZKJ8VsY2vI4R6bT+TSMoEMkjaf055Uq7Pgu+iZAle1fsjtZAjx5l51MAv04rCQuyuri
	tfJsNj7g6MqHO9VAiaLpXnzjsR10iydp0snWnTcfq7/eAE98rWnoZql8X2XAAU8YDywcnuFBn5R
	QS9feFdbaAgyIMH7ovAf7Dmg81E1dhJchdM5tP9GSQV9zaXjAUk7TAge9R37dzxBt2rPxH2IvYC
	Hh8AvxQrknEcAJ+/tsGuw4oHU4tIV5iyoCWcLjuXyhNvP0mk3diWu+04eDFBNDPQJUd+KYzs2ig
	dT7JA4pzqtC0e8yY8M8ZA8nn8Mg7B3P2cPcjBhg1lmtD67wWz4FeHhCY53LPFYmDBeYUb5QuO9c
	MMKGXvLh5sMmtRGrW94DDFJU8orjbHGOYLmES6CUn7SqXdLcHzlEU=
X-Received: by 2002:a17:90b:57e5:b0:380:f389:447b with SMTP id 98e67ed59e1d1-38f294e9635mr5106177a91.11.1785073585944;
        Sun, 26 Jul 2026 06:46:25 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d2eb01aa0sm30683807c88.3.2026.07.26.06.46.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jul 2026 06:46:25 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <2388e6b3-4ae2-485b-b276-5d787bc5c7e9@roeck-us.net>
Date: Sun, 26 Jul 2026 06:46:23 -0700
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] dt-bindings: iio: adc: add maxim,max40080
To: Siratul Islam <siratul.islam@linux.dev>,
 Jonathan Cameron <jic23@kernel.org>
Cc: Stefan Popa <stefan.popa@analog.com>, linux-iio@vger.kernel.org,
 linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 dlechner@baylibre.com, ciprian.hegbeli@analog.com,
 u.kleine-koenig@baylibre.com
References: <20260723065036.2683075-1-stefan.popa@analog.com>
 <20260723065036.2683075-2-stefan.popa@analog.com>
 <a79b2fd8d08d4594bbb472b005534d7c91d86e49.camel@linux.dev>
 <20260726003152.1d9f36d5@jic23-huawei>
 <196a781d5ff487fb890abc8c3ed2ae07f8614b38.camel@linux.dev>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <196a781d5ff487fb890abc8c3ed2ae07f8614b38.camel@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/26/26 02:59, Siratul Islam wrote:
> On Sun, 2026-07-26 at 00:31 +0100, Jonathan Cameron wrote:
>> On Thu, 23 Jul 2026 22:23:39 +0600
>> Siratul Islam <siratul.islam@linux.dev> wrote:
>>
>>> On Thu, 2026-07-23 at 09:50 +0300, Stefan Popa wrote:
>>>> Add device tree bindings for the Maxim MAX40080 bidirectional
>>>> current-sense amplifier with a 12-bit ADC and an I2C/SMBus interface.
>>>>
>>>> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
>>>> ---
>>>>    
>>> ...
>>>> +
>>>> +title: Maxim MAX40080 bidirectional current-sense amplifier
>>>> +
>>>> +maintainers:
>>>> +  - Ciprian Hegbeli <ciprian.hegbeli@analog.com>
>>>> +  - Stefan Popa <stefan.popa@analog.com>
>>>> +
>>>> +description: |
>>>> +  The MAX40080 is a high-precision, bidirectional current-sense amplifier with
>>>> +  an integrated 12-bit ADC and an I2C/SMBus interface. It measures the voltage
>>>> +  across an external shunt resistor and the input bus voltage, and stores the
>>>> +  results in an internal FIFO.
>>>> +
>>>> +  Datasheet:
>>>> +    https://www.analog.com/en/products/max40080.html
>>> This URL links to a product page rather than a datasheet as the tag suggests.
>>> Would be difficult to fetch using CLI tools.
>>> Were you supposed to use something like
>>> "https://www.analog.com/media/en/technical-documentation/data-sheets/MAX40080.pdf"?
>>
>> I think the argument for using product pages is that they are stable and datasheet
>> paths sometimes change.
>>
>> For ADI there is a neater form as well that is supposed to be stable (and
>> has been for last few years at least)
>> https://www.analog.com/max40080
>> Works for any product and takes you to the equilvalent product page to the
>> link above.
>>
>> So whilst you make a good point I think we will have to let Analog decide
>> on a standard way to link to their product info / datasheets.  That is
>> on the perhaps optimistic basis they have more insight into stable choices
>> than we do!
>>
> I was just nitpicking because it said "Datasheet" to point to a link which was not a
> datasheet.
> 

FWIW, it points to a link which points to the datasheet.

Guenter

