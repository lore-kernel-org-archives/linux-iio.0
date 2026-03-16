Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AE43CCFCE
	for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 16:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773679489; cv=none; b=t2q8lgXg9KnXQImaRAUwCw4IDwuXMWbFQEUft8vNo8VhYTyVJFKWTZPQRpqzr1HQU/QFlnvBUYWQXMx8ZBcfTX+W/nO2f5BAZ/SSEFIOEwIoTE7awIx1Q0/m4yKQetrHuyC2DZ3oKrO4yTTov/MvAMm6pe1sLtYbLPWKpee6Jvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773679489; c=relaxed/simple;
	bh=Tkdt6e6cnfyPY0SugtxYloHST0stO69sHMglYRTuOi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C9QTNWhgoT7W+AFUPqXNP/RRQ9edu8/htee5vrU/VmiDiMRoNcc8473tER88JAnzAtYRhS19rS3pduzd2kylgDv5OqZe19BIagDMWfAU79M77STNDaseya18E+DfNoXgSWBmUJiwP4tg7CeVMzXGvpkKfTBh0bBY3quE/3kTelg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=iTFuv01s; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="iTFuv01s"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-40ea36b56b7so3246288fac.3
        for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 09:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773679486; x=1774284286; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4AJTku3OJZDZ6/Kpiw5pDXaqosol7el2TXJoCn2CGLI=;
        b=iTFuv01sWYT+Kv5MkQyWtJ5hj1yeq4H2sWPcTmnOjZwRc+VRQZ7HLoo2fAUEjJa8a/
         I4yhutovyrIh0Dog60nItEsnan7+/ELbTB6P39HRFPutA0L8dFvynDwjMhb62zXzDEWD
         BS4lYWyhk7AGsCOkEZPwBzG6N0PAyGTe2N60Vb/vbyecUzjYi/+48yd82Alg4IMdw4pm
         0OLfZMCubL00ZTG7wVAhIEOHX1R0WqCIlOedtQw6oebgcXqKQvlviYMZoxB39oC3D/ox
         KDa2sDZ7yrwt5sfO5JWymdSFM6P1uAGIkFlVoawdP+6UG49eY58kesVfjfH41MBQTljF
         GreA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773679486; x=1774284286;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4AJTku3OJZDZ6/Kpiw5pDXaqosol7el2TXJoCn2CGLI=;
        b=BW0ydoeXs+OWpe4Jikyu2VsnSoDX2YUVJ5xMbshtr1v8n6It8CdRmHaYXsXV1jOm4p
         5u5/YgjBnucF3vU3+JfxU83PKhFz3iA38pFxItWkvZkmblm2XBgr2T4ch7t7wbAET8LO
         F4cLEP3wx3e+l0jYC0Bxb31JYS6gf1K6Xk6iqyRQhfI2vViAZDRNRQyRNJfM7mqCYC12
         l2/boKOmQ+6X+Q9J6eFoz4CBMHlpAxPq6pXUbSsDxPu0oZC6jQMTxYQDg0xE6bA2mKFD
         jlwwsKRDg+6qLm3sOQihsKCAOEziCfkjSU+M/iur9hjvIte7bSwIWcKF/htOwB0oNqWg
         fpTQ==
X-Gm-Message-State: AOJu0YzY2VDNs05vYRI0Kd0JRNI67epEKqTJesEBou3p+BHWfOtWuCNC
	5Y4MPZtxgT4P4ekIE6fQ8Jy6coN0ntsiCqcXuLAy7UGa+gWrF3a9+PZdvsf8Q1TzZ+M=
X-Gm-Gg: ATEYQzzApQ+4nbA4kg0+430JhjSwXeObtMKUlhw4+mBxAaGcB0174/9SMkCfAht8XfA
	SRt9hRKvEwefqaIG7q0o5iXURClLqVhHRCDoygln4xsvK14xdQeXE1M11aH/ohkQt5u6xZzv3nB
	03Irb728FM4j9SlM8S2ciJuqoLBq57b8lyM6vXE8KGr9/ttWmL44iTTr2FxHGq7ZuEYSWGRr0zk
	ZG3f9gn7rUvjeltYgBfLdNPwYbUgc1Jy/41FofYBxi35f7zkdufVNVQDHOXfist6sbRapX26Ih9
	V4AERCbokxPzT2o5ZAxVVqUAbr77Ig7Z6xx0pna0e7cP/Oq48cTxKuFZLJGU4Crb/N5HhohnI+Q
	iyJ+PPUB/cHDOwGstis87M7rkRrqM0xUvvozioaUQLv9xDgCK0m2LrpwpXvmIu4SzEnQQ0GzwUv
	0coe4pV7QrYhFl7H/lNHaRSlnEVfbyWZTYShWBe1cz/H/gb3ddBnlp1VdnGunRCTrs8g4c85agD
	A==
X-Received: by 2002:a05:6870:3b8e:b0:417:22c9:a311 with SMTP id 586e51a60fabf-417b902ecbcmr8375036fac.6.1773679486349;
        Mon, 16 Mar 2026 09:44:46 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:e504:a034:1152:a664? ([2600:8803:e7e4:500:e504:a034:1152:a664])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e69c79dsm15440675fac.15.2026.03.16.09.44.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 09:44:45 -0700 (PDT)
Message-ID: <06b48810-f997-40a4-86db-d3b7db9dfc18@baylibre.com>
Date: Mon, 16 Mar 2026 11:44:44 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] iio: adc: ad4691: add triggered buffer support
To: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 "Hennerich, Michael" <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, "Sa, Nuno" <Nuno.Sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
 "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
References: <20260313-ad4692-multichannel-sar-adc-driver-v3-0-b4d14d81a181@analog.com>
 <20260313-ad4692-multichannel-sar-adc-driver-v3-3-b4d14d81a181@analog.com>
 <0bca5313-a968-48a1-9245-aeae25ab4187@baylibre.com>
 <LV9PR03MB8414E82D015E615DD64ADEFAF740A@LV9PR03MB8414.namprd03.prod.outlook.com>
 <7251a53a-100c-4867-ab4e-b7d2d019b26b@baylibre.com>
 <LV9PR03MB84146ADC269645000849795AF740A@LV9PR03MB8414.namprd03.prod.outlook.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <LV9PR03MB84146ADC269645000849795AF740A@LV9PR03MB8414.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/16/26 10:56 AM, Sabau, Radu bogdan wrote:
> 
> 
>> -----Original Message-----
>> From: David Lechner <dlechner@baylibre.com>
>> Sent: Monday, March 16, 2026 5:38 PM
>> To: Sabau, Radu bogdan <Radu.Sabau@analog.com>; Lars-Peter Clausen
>> <lars@metafoo.de>; Hennerich, Michael <Michael.Hennerich@analog.com>;
>> Jonathan Cameron <jic23@kernel.org>; Sa, Nuno <Nuno.Sa@analog.com>;
>> Andy Shevchenko <andy@kernel.org>; Rob Herring <robh@kernel.org>;
>> Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley
>> <conor+dt@kernel.org>; Uwe Kleine-König <ukleinek@kernel.org>; Liam
>> Girdwood <lgirdwood@gmail.com>; Mark Brown <broonie@kernel.org>; Linus
>> Walleij <linusw@kernel.org>; Bartosz Golaszewski <brgl@kernel.org>; Philipp
>> Zabel <p.zabel@pengutronix.de>
>> Cc: linux-iio@vger.kernel.org; devicetree@vger.kernel.org; linux-
>> kernel@vger.kernel.org; linux-pwm@vger.kernel.org; linux-
>> gpio@vger.kernel.org
>> Subject: Re: [PATCH v3 3/4] iio: adc: ad4691: add triggered buffer support
>>
>> [External]
>>
>> On 3/16/26 8:22 AM, Sabau, Radu bogdan wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: David Lechner <dlechner@baylibre.com>
>>>> Sent: Saturday, March 14, 2026 8:38 PM
>>>
>>> ...
>>>
>>>>> Both operating modes share a single IIO trigger and trigger handler.
>>>>> The handler builds a complete scan — one u32 slot per channel at its
>>>>> scan_index position, followed by a timestamp — and pushes it to the
>>>>> IIO buffer in a single iio_push_to_buffers_with_ts() call.
>>>>
>>>> It would really help here to see some timing diagrams to know if we
>>>> are implementing this right.
>>>>
>>>> For example, it isn't clear that in clocked mode if CNV triggers a
>>>> single conversion in the sequencer (i.e. IIO_SAMP_FREQ should be
>>>> info_mask_separate) or if it triggers the sequence (i.e. IIO_SAMP_FREQ
>>>> should be info_mask_shared_by_all).
>>>>
>>>
>>> The CNV triggers the sequence and IIO_SAMP_FREQ is
>> info_mask_shared_by_all.
>>>
>>> As per datasheet page 31 (Accumulator Section), when each accumulator
>>> receives a sample, the ACC_COUNT is increased. In clocked mode we
>>> are setting the ACC_COUNT limit to 1, therefore having one sample per
>>> channel (no oversampling as discussed in previous versions). So each
>>> period of the CNV PWM is respective to one sample of a channel.
>>
>> Assuming that "a" channel means "one" channel...
>>
>> In this case then sampling_frequency should be per channel (separate).
>>
>> A sampling_frequency that is shared_by_all means that each period of
>> CNV should trigger one sample each for _all_ channels. In other words,
>> the sampling frequency gives one complete set of samples for all enabled
>> channels pushed to the buffer.
>>
> 
> Oh, ok then, will have them separate. I assumed that since the PWM period
> is constant with each pulse, then the sampling rate will be the same for
> each channel, thus having them as shared_by_all, but I assume you are
> right about this in this case, I will have them as separate in this case, the
> update will happen in the previous patch upon next version.
> 
Does the sampling stop after one "burst" (reading each enabled channel once)?

If yes, then what controls when the next set of samples starts?

Looking at Figure 63 in the datasheet for CNV Clock mode, it looks like it
depends entirely on how long the SPI message takes. So the actual sample rate
is going to be quite random instead of the sum of each channel as the IIO ABI
says it should. It seems a waste of the PWM to do it this way since we end
up with a random sample rate.

It seems to me like the CNV Burst mode would actually be better suited to
how IIO usually does things. In this case, the PWM frequency would control
the effective sample rate (one PWM pulse triggers one complete set of
samples) and the internal oscillator controls triggering each individual
conversion.

In this setup, we would still have the info_mask_separate IIO_SAMP_FREQ,
but it would control the internal oscillator. Then we would have a separate
buffer0/sampling_frequency attribute that controlled the PWM frequency.

Then, as long as the PWM frequency was slow enough that the SPI message
can be done, it can make samples with almost no jitter. This is why I would
expect PWM to almost always be used with SPI offload though, otherwise
it has to be quite slow compared to what the chip is capable of.

I suppose the CNV Clock mode could also be made to work with the typical
IIO trigger so that we could control the actual sample rate. It just
wouldn't be as precise.



If you have some examples of how this chip should actually be used in the
real world, that could help pick what is the right thing to do here.

