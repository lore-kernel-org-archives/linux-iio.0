Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1643A0EA6
	for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 15:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773675464; cv=none; b=AybdRT1cRvYsPiTTwZSzPnVPTjDmzUtYc9QscJfOvz9ADqgoITcQxQEdKcg/74D9tTwZoVU19KvBx7J9VOhsi51okdVeZoUT72lo4jrSRmqQT6KAS4roPbEe9PDSMA2hH+N5lHu3CdoP0ljUbHBIIA5A/6vwSFpsmcwnoCuHw8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773675464; c=relaxed/simple;
	bh=ZFFqpYZm8iqLOnVuOx7a8iZ1sMD3XmR5DnrngPCaH1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dKwLAaBVEg8D0A6iZFoRoJR3PrDuGY0dtVAANEr54LGmBTmZeG/4+juOF6CyI1R3WM3s6/LH4JbV57wLrFiGqlPfy3v6aLxVgIQBZfva79OBeU2grBXNFZHwQVM0GZ9nHkFhclY+3BYRv/pCVqHOiUjh5AJVyHNXRn9fn09iuJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=1T9Ctlz0; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1T9Ctlz0"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7d73e0e0a36so2062911a34.1
        for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 08:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773675461; x=1774280261; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rZOES8KP7138RCfnWFB8Je+zzCaH1fPa0eOTWPtFvWs=;
        b=1T9Ctlz06E11ixwHcE9deVzEf4l0tIN+z3tBT2wF95e1veWRphknJfGPS8vJ+CF80B
         13hK7UnCAVmHcAiGTvIhbq1aTwg9cl7c3zlYmmmeKSQBBAOBy0Uqj+7ELS+LyJyKnDaV
         pzX0tCl3wCbQV1l1popy6Gu74Vlp+ANxgk2h0LmAZPPffiCVmODSdTAeTwVeDotUf+ps
         n1gzuZJuTs9+YwvBS3L7GVzFEU5emSCrBHoBS+SsaWcmQFjIEP/XdQIGAfcPYWZUX8a3
         b/x9a6pa+6DDLA38jhw1R3T4sNruiey4YAetLJShO4txJeAenxhM71xGnZPwNEOvpF1P
         gDnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773675461; x=1774280261;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rZOES8KP7138RCfnWFB8Je+zzCaH1fPa0eOTWPtFvWs=;
        b=al0sahX23+LxMGA7VK6taPNMEhY4vm2YOCepILw5/tE9eat19u+pLW3Gev4mrt4tzJ
         AQmj51FTQH/+Wwsfn8O1h0npVXspNtBo2QuCLSaOza835n0TGPdUCZPLTfu53S1b2WIv
         vB3jiB/D1Ifik0gMAg4NbiRPPaO+p4vCC2xoUN87XTnj6iDgmzVDWCXT6dLMymFZiPWT
         GGkPU1iwvjju1vFvIYr7TQ2ulHHvhC4nG+YzlIDSVCfZTbs3neNKJygoIZxBeKSt6QAA
         osGTjeERNh026VsWtEmajJeEmAqSs6z6KVgHVRmiKI+Q8li8sVGml7AsddJZFnL1I6tY
         L48Q==
X-Gm-Message-State: AOJu0YxloxIEj9VR/30iH3N3V+tjmum2Ctc5v/vSKcDSD64F9i7Zmpsh
	CylETnpQmQoSAa8/3YnWnfp7JEeG8Hk2ViWdAaum99mG+5+n5CvlA8ddI1ZwFoLYbcY=
X-Gm-Gg: ATEYQzwGigCVMex3XS3FRDvshPO9YOMjLmtCvRp3uwD+4TpV+q/rl6SfQuSs1zAtYGl
	oSVy2/vqfZQKDC7piQR5iy4MHx9Uf6Zb2+qimUaPSB2jF6FRYfa2d9OyQ5OgE77UQqq1goMP2oZ
	GURqa9lC9TSXLeLGfCoASUunDRod0ngrfK/P2n1qN0Rmc90YVQwvKQGJar6HbpFqHCDwoJ/Nnv6
	c0dLkhVqZcutoXi7aVDDNCZKzwYwufSWX5wuycufOshXug97P8v7+yr7Mc/e/MmTEVloK3qz2m1
	XktU4iofdt4ZgOuSVFqJnKTTjj1aJnjXMmLqqYv95bPtZB/hH5YDVCrxawmagx+XTp75B4rj+Ow
	Pfgi8+MKcgObvnIk7T8BLPH3eY5Gw5JaWxDrNPay/r+DodcFrY13U1R9eXsxuuCFVZmRv+PmIRI
	Lh+F+FLIUniZdupdVlJC97sbGem05ixgvYw/+fwaasRkh3MQeZ9VEMqv7v1BGl2I+xxNuWDj3Yb
	WhmRYx0jTrL
X-Received: by 2002:a05:6830:44ac:b0:7d7:3c44:c6e with SMTP id 46e09a7af769-7d782577164mr9906238a34.32.1773675461141;
        Mon, 16 Mar 2026 08:37:41 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:e504:a034:1152:a664? ([2600:8803:e7e4:500:e504:a034:1152:a664])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d76ac30bbasm12273543a34.3.2026.03.16.08.37.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 08:37:39 -0700 (PDT)
Message-ID: <7251a53a-100c-4867-ab4e-b7d2d019b26b@baylibre.com>
Date: Mon, 16 Mar 2026 10:37:37 -0500
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
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <LV9PR03MB8414E82D015E615DD64ADEFAF740A@LV9PR03MB8414.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/16/26 8:22 AM, Sabau, Radu bogdan wrote:
> 
> 
>> -----Original Message-----
>> From: David Lechner <dlechner@baylibre.com>
>> Sent: Saturday, March 14, 2026 8:38 PM
> 
> ...
> 
>>> Both operating modes share a single IIO trigger and trigger handler.
>>> The handler builds a complete scan — one u32 slot per channel at its
>>> scan_index position, followed by a timestamp — and pushes it to the
>>> IIO buffer in a single iio_push_to_buffers_with_ts() call.
>>
>> It would really help here to see some timing diagrams to know if we
>> are implementing this right.
>>
>> For example, it isn't clear that in clocked mode if CNV triggers a
>> single conversion in the sequencer (i.e. IIO_SAMP_FREQ should be
>> info_mask_separate) or if it triggers the sequence (i.e. IIO_SAMP_FREQ
>> should be info_mask_shared_by_all).
>>
> 
> The CNV triggers the sequence and IIO_SAMP_FREQ is info_mask_shared_by_all.
> 
> As per datasheet page 31 (Accumulator Section), when each accumulator
> receives a sample, the ACC_COUNT is increased. In clocked mode we
> are setting the ACC_COUNT limit to 1, therefore having one sample per
> channel (no oversampling as discussed in previous versions). So each
> period of the CNV PWM is respective to one sample of a channel.

Assuming that "a" channel means "one" channel...

In this case then sampling_frequency should be per channel (separate).

A sampling_frequency that is shared_by_all means that each period of
CNV should trigger one sample each for _all_ channels. In other words,
the sampling frequency gives one complete set of samples for all enabled
channels pushed to the buffer.

> 
>>>
>>> For CNV Clock Mode the GP0 pin is configured as DATA_READY output. The
>>> IRQ handler stops conversions and fires the IIO trigger; the trigger
>>> handler reads accumulated results from the AVG_IN registers via regmap
>>> and restarts conversions for the next cycle.
>>
>> This seems OK, but I would kind of would expect that PWM as CNV to
>> only be used for SPI offloading and not without SPI offloading.
>>
>> The ADC also has an internal oscillator, so it seems like it would
>> be more useful to use that as a conversion trigger rather than
>> requiring external hardware.
>>
> 
> This CNV is used in triggered buffer mode as well, not only in offload.
> In this mode, CNV replaces the internal oscillator so CNV is the
> conversion trigger (offload or not), which also introduces the advantage
> of having a more flexible sampling rate.

Yes, I understand that. We just never did that for any other chip yet.
Usually, we would just use the internal oscillator on the chip instead
for this sort of thing. But if you have applications engineers telling
you that this is a setup they want to support, then we can do it.

>>>
>>> Manual mode channels use storagebits=32 (shift=8, realbits=16) so all
>>> channel slots in the scan buffer are uniformly sized regardless of the
>>> SPI wire format (24-bit transfer, 16-bit ADC data in bits[23:8]).
>>
>> I also don't understand why we are including the status bits in manual
>> mode but not in CNV clock mode.
>>
> 
> In Manual Mode, status bits are received through SPI, because that's how
> the hardware works. However, they are masked by the driver and thus not used.

Usually there are registers to turn status on and off independently. If
there isn't it could be helpful to add some comments in the code to
remind us.

