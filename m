Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3123BB9F8
	for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 10:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778496241; cv=none; b=a58xMRo5Xm/TQXNsq4n7s+IjOW4WF2fof2mu2ts33hMYMd4SQYpzFyS8ta2OWsOq5WM/Z2daDzqbhTKTE3+4Jni31fFJVWkDabykcpZoTfPUz81BkmJ7ZxKuxkZbM9SPkuc3beR+NjOnQ8iL9uDqgO1rnSlCrNPWViRqYlJm30o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778496241; c=relaxed/simple;
	bh=RhdInbOmWtiuTXxtdNvqUyqvKPi/PSddY1cRe09C2X4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=FllX97VirbE0bWzxHnrDUVwJRAImMcsG657kcbIDb8ZUktwPWJ23NXAFnTP4pdaiajL9Y4FDjtOKgJOFxtKL6TgIUPARHPP7HRujh67leyhfwPvRYqHN0Y4oi7pMtNknoHWc5uRPs6/ijzB3BPFhtY7ZzHon1UzfCLBiw5uGB8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sxS/jSOD; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sxS/jSOD"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-39397d63804so47430271fa.2
        for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 03:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778496238; x=1779101038; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=c9ClfHjcGORkb1ZqNXsd9yYJQtHroStE/CQmUs64xX8=;
        b=sxS/jSOD8iqjjzGYaQwEvTEzsymSTU0UWFZvsd94lecG4qScqOZPcF5XKlMdNgucyh
         S4RT0JBmcVP0Of4qn6bWLScRi4Sv8WEzjymp19uNohdpOq7c94Q7WlIVTDKlUf5Z2MaH
         87/2rbn3ujPKL1aImPpoKe8R6gj6GOr19ieC/yXUruxF8c9o3hiKlp/sKDgc7fhXoOzj
         BIUET1q7oG1owPo+Y8kX7pmCn2ASE19o//24VoOCIpjF42WEoVuorjn5xXINChNcu4aa
         6eo6kd/CApGViG+uEunBuGWUJ2b//6v8XriL6z5/DVp2qCA67hdP7Iv76fZHGpnYl7yp
         nHPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778496238; x=1779101038;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c9ClfHjcGORkb1ZqNXsd9yYJQtHroStE/CQmUs64xX8=;
        b=iS4SPfHS8VKVmY/H6vKGC/fJ5rym/WmRVz8Bn04xDhARrKwreQv5G+Gwfo2UosqRC/
         ykZdEjJhb46GvttMF0R2E5ucsDaw8VYmuly2h1INLKb0Y6tak3KZEigyNU5hK74Nq9QH
         yA8fv1UT8Kgan2B3whO297S5qfOva7+BBVK0UprdL11nRNn7s0fHfMGoyGV/WjUjBgi+
         DXkfGrFg0l2mL8pDyVJtenJs/jnHREXO/88t0DqzkSLiTnn9SlcgqpqptOgkLq1wZ4i0
         Tw5iVBpBQ1wJXGEcj//1/dQNsfTzPzJDwG/Ifn40/Fm4yZN9wdKb6NFEi4qt74zH/kO1
         aVyg==
X-Gm-Message-State: AOJu0Yz4x25bw+8gCkp4VY/gWkfauQq6DS3TqF6DLMFWYq/kAUT+rrRY
	A8gx+j/490f4tp2aLFk46NTe3Fn4MlZQIr73/svkLsVeEBBlz1k4jhJz
X-Gm-Gg: Acq92OGMgEzxtNUTIdYVKHYJr2mjRm+ndJm8ec+HU2L+9qNvsh2QFnscQIi7veV/Lz5
	wc/+WMe9pxGYzT+ostISKqLM51A9cPlfJJhQq/ndJdVVCCm5NhddWOPHuXsiLa/bClQNnAn1ex8
	El4SpCV9VNfX+f5FmgXrOgG8EySQrC/RHTIribN+r77xX92cOda90WngTMjzCwhQpHQFTwd2T9Z
	nmPDFEjuk2dfqYHjAH3tJ7Loz3+E+B25NG7zNTmw97So4bNqHisMqv64WBbaDmyoikEL7kH5txB
	WvGEd8ypiI+D59gMrzmgKl2Rprg9+ZR1o3apKmbSPay6Jsz4lgErwYRb8X2Ay9F4dJfIdUxZ30w
	suuukRZWRU7oHnHzUW4CFHuBgrASgKLrHP3Bup7QZ8RRhEh8ULYX9OqdB7SQINOz+kJI9MXOzc5
	MoalaqqPZ3oRT+jvKpTCuDBlB9FEgQbbmtaJK2XznA4KcwMznqgmCb1MpNENOeh4waCZZe4jveR
	PrCM8psa/0L0fJCa6Q=
X-Received: by 2002:a05:6512:15a0:b0:5a3:d375:f587 with SMTP id 2adb3069b0e04-5a8a94c8226mr4904025e87.35.1778496237829;
        Mon, 11 May 2026 03:43:57 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a8a951cfb4sm2546655e87.20.2026.05.11.03.43.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 03:43:57 -0700 (PDT)
Message-ID: <00855a46-20f9-4b4c-8bec-bb64d9d8efe6@gmail.com>
Date: Mon, 11 May 2026 13:43:56 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: iio: light: Add ROHM BH1730FVC binding
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Alexandre Hamamdjian <azkali.limited@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, CTCaer <ctcaer@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260511-bh1730-v1-0-e0df1f499135@gmail.com>
 <20260511-bh1730-v1-1-e0df1f499135@gmail.com>
 <92e2d1ab-c973-45a2-b0c4-d7c672c610e0@gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
In-Reply-To: <92e2d1ab-c973-45a2-b0c4-d7c672c610e0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/05/2026 11:22, Matti Vaittinen wrote:
> Thanks for patches Alexandre!
> 
> It's nice to see these upstreamed :)
> 
> On 10/05/2026 21:09, Alexandre Hamamdjian wrote:
>> From: CTCaer <ctcaer@gmail.com>
>>
>> Add a YAML binding for the ROHM BH1730FVC ambient light sensor.
>> Documents the required compatible string, the als-vdd/als-vid
>> regulators, and the rohm,integration-cycle, rohm,lux-multiplier,
>> rohm,opt-win-coeff and rohm,gain-coeff calibration properties
>> consumed by the driver.

// snip

>> +  rohm,opt-win-coeff:
>> +    description:
>> +      Optical-window calibration coefficients. Specified as a flat 
>> list of
>> +      triplets <rc cv ci>, one triplet per window region, where rc is 
>> the
>> +      visible/IR ratio cutoff and cv/ci are the visible and IR weighting
>> +      factors used in that region.
>> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
>> +    items:
>> +      minItems: 3
>> +      maxItems: 3
> 
> I am not sure if I read the driver patch (2/2) correctly, but if I did, 
> then these coefficients are used to compute Luxes out of the raw sensor 
> data. I believe it would help anyone integrating (or investigating) this 
> sensor, if you added the actual formula here as a comment. If I read 
> this right, the formula is _somehting_ like:
> 
> 
> Lx = (cv[win] * ch0_data - ci[win] * ch1_data) / gain / int_time
> 
> Here the cv[win] and ci[win] are selected from the opt-win-coeff -table, 
> depending on the measured ch1_data/ch0_data ratio, right?

One thing came to my mind. This 'window' -approach for lux calculation 
is not too unique. For example the rohm-bu27034.c uses similar approach.

The thing is that some of the sensors have more than 2 channels. (For 
example, the first version of BU27034 did. [That was BU27034NUC, which 
got cancelled when BU27034_A_NUC emerged]). These ICs may still may use 
similar approach of having light regions, determined by ratio of (2) 
channels. BUT, they may then have more than 2 coefficients / window.

So, maybe this could be made generic enough so it could be re-used for 
such devices if needed? I am not sure if other manufacturers but ROHM 
does this in Lux computations - if yes, then it might be worth making 
this more generic and not just a ROHM property? Maybe Jonathan has some 
insight on other Lux computations.

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
