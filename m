Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795072420;
	b=SjKuWwSj97c5OFkJVOFrvhOU1fd12IRUv4ujHbVK9f4sdntwUAwIY287m3OBGoEH2Ke4
	 HhQBZ2p8MDcx+j9IvwuLNqtx/eEepiHea2uAZG0EE/34Opuwr06pST4IqYHlJ2zUgGXm1
	 XKOmd3ns5IsSIkY+KyT1rAol2v9Gjl+8+TK+iqkq2UFv41lBlBDrEOmh2EdWJC4fugrwD
	 DgXaXjNDTmfoF/apTe8Mu/ABJM5Qojk5ZJTtbJmmKXo2QEWrXDWFX7KrIyTKVL/Zoy66d
	 XXTgXpnoG0etXaFgJUlCaPX6iJf0z5nARd+0IS+IKLLBr70PeHiwMpH5hDEf2nIgx3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795072420;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=GAhJHnaYFc85HnFpE0nbnvNHLyTmKKfUCRaZ6x2kTUg=;
	b=nWWb84P9G2o99WdA2UlKyS76X54p35wCoVTUrWP2ezjLS5eCGYz8endlyliLm5PHvXLI
	 5i7ot1ZiMcjsshhr9ixqlYWteaKT3ALc3g4nQCimG5zFNi81z3wRdJBOLze2in1qLL9I8
	 6Axj4i0RtqgRae8fZAzl7XGeALfK9nTDAg7SStB+EsAlSagUMlpsE4y4ROIvNjNMgeFie
	 +0MuVOQE+aesjARqrVs9FtHnY/uV75jKAV4frCTCu0sTWk/i31A69R2+Q7E9nh/Zy4bEh
	 CU6lRLbi3jemNSOUgccqLiPKF15L7gH1EYkeHN6VbSNM4Y7ARTxI3CsckxrIVa3vL9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XxDBMax9;
	arc=none smtp.remote-ip=209.85.208.173
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18ACF606A324
	for <linux-iio@vger.kernel.org>; Thu, 19 Nov 2026 07:13:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18ACF606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XxDBMax9
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3adfc004920so19403171fa.3
        for <linux-iio@vger.kernel.org>; Wed, 18 Nov 2026 23:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795072418; x=1795677218; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GAhJHnaYFc85HnFpE0nbnvNHLyTmKKfUCRaZ6x2kTUg=;
        b=XxDBMax9D3eru7rJzSMZjZcfwjzq2hKxgpGlNZQ/B+Z+5jX86mK9c1az1b0NTQMFXP
         gcJj+0AsihwUZAT66sR+cu/e8sD+fpiuHzJvFKQYbUa9NClzka2sBdfJT8/gnUqvhtDo
         K/hOfBrb9d2TDEdKXc6P/IUMuFlMkh2+g+iciaUJMSLa6XCTWwbSvfDy9Yzzu7hiFOuI
         a9fjaV/7Y19LaiigPPkPbje7J6JxCUA/4dQSja00EyVgnqFzzF1rE4jRs9ot7llcfoL9
         UU8MDFJ80IqpA0PasojFf44fwIlMa3MY1GQYO/ReVBeTNObiyP/qf25bqe9pbhvDj5Q6
         +8UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795072418; x=1795677218;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GAhJHnaYFc85HnFpE0nbnvNHLyTmKKfUCRaZ6x2kTUg=;
        b=iw0vv4Ry9LAEWfTjTTqhwTTrsMrCRSyQnCvgvlFp4uPU2Z4ExMw7ykjVwVAtMLUDHG
         jugZLZ0HZ9zQMtTdgWvWePoBXbMWNyZYota77RH93LqEetE1FexQTu+hekB2hIRCt0jK
         QM5dlDikIYEax0PZM3rfCqP4uPAbGJYVY1aDRfA4exDDi+sogCbwsnkOh+B1zKIgQF+i
         nTOnsYMAKcZIuBHSSO77s/RaBglVZMwkhvCu/+uI8HYyOs/FIwBqKPGu5U/VIyOMK9aP
         1zCoDrAcHG9J1C8XGXsjb9f8NZIA5VmiislSAUUWo0arS/YZie+FPd8feoEbqgnVDb5m
         Teug==
X-Forwarded-Encrypted: i=1; AL+hErH0WAfAp7+vD2DBSwE0T1zBrnVxEup3Pte/+08Rkec5lUaN8M5HUssybHv/dLNye+5OU/VkDDFmWVY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9F2b/PH8ft2N/Lnj6kliJvTrpg4LsHFO/iDUWuY4y7CXFyeY77
	8FG8D1Jm1G74LBewVP2WuPVIpZx4kPiEWidDQke6kMAXIMHkH5rknALE
X-Gm-Gg: AYBFou1DOcMTYX2CD6NaSYig7p67BJhIe9u4bYo6KkC2ruDlqhrknSkAB3bJkjAzFfu
	/Fm+0b6B7+fAXFBt8hMbUkBJKJisAZhRiKsnXuhSc33QGTPTF14GDzRsQZknsrZqM0utzJyPnXZ
	vhc6XrJOJ/Td4HiEY91/RXNtReLZyD+hof+yNkI2jmAahRTskiB+W2dCd/lO1fKt4WQy2IRrpu8
	FEocg+HlJnuZHPhd5cinmWbSFhPMssDGbhXmlpzxMnNXPollFiU4LGu4ssSuw1YB0nUV1vyGTH/
	fdfUsvN08aQmiu4Qx8nyJQaURd2PB5byJSnh4xYhDdlhdFQp2sacmnAywnZm9hQyxTuDgdGfnX9
	mBBrd18GCKMpKazUQ8lqLaVozbQGOWuoSpzanNUrebvoldsfFuYz6rbzzVIJ3V0PcIYDMn98Idm
	+hbVCTrUR486Dtq8UfaVM4txGKjdrNNWkXwDdRsuRviO+SFXtwaI+CKndKpB9y1lkqOuYX+ySow
	Uc9B58dOX+0AVh6Ejnx1YRGbu5m2TgzQSIRW9cyOy0wEEZ/WkprXMnEyGdiBpjilW2s5sgewmBC
	EJ4SuylXvBpA7d7x1CndGHNupLAnz8RX48itiz8bz9J53Beq/yziNpkMOCc4IvtZ8NEcz1WQ6cu
	ExcQUrrm7Qw==
X-Received: by 2002:a05:651c:e18:b0:3ac:f164:4449 with SMTP id 38308e7fff4ca-3ae671f7d8bmr15497191fa.29.1795072417877;
        Wed, 18 Nov 2026 23:13:37 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ae6ebc2fd7sm7269571fa.24.2026.11.18.23.13.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 23:13:37 -0800 (PST)
Message-ID: <4dccb83b-a612-4c93-a625-f5881b63410c@gmail.com>
Date: Thu, 19 Nov 2026 09:13:36 +0200
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: adc: rohm-bd79112: Support ROHM BD79111
To: Jonathan Cameron <jic23@kernel.org>,
 Matti Vaittinen <matti.vaittinen@linux.dev>,
 Jakub Szczudlo <jakubszczudlo40@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Joshua Crofts <joshua.crofts1@gmail.com>, Radu Sabau
 <radu.sabau@analog.com>, Janani Sunil <janani.sunil@analog.com>,
 Salih Erim <salih.erim@amd.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1795009599.git.mazziesaccount@gmail.com>
 <ab74e547e892ccabb763a06e8231e8ed44f4fefb.1795009599.git.mazziesaccount@gmail.com>
 <20261119025137.6bfc27c2@jic23-hlaptop>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20261119025137.6bfc27c2@jic23-hlaptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi & Thanks Jonathan!

On 19/11/2026 04:51, Jonathan Cameron wrote:
> On Wed, 18 Nov 2026 16:19:35 +0200
> Matti Vaittinen <matti.vaittinen@linux.dev> wrote:
> 
>> From: Matti Vaittinen <mazziesaccount@gmail.com>
>>
>> ROHM BD79111 is very similar to the BD79112. Both are ADC/GPIO devices,
>> where pins can be configured to be either used as GPIO or ADC inputs.
>> ADCs are 12-bit SAR ADCs and GPIOs support input/output but not being IRQ
>> sources.
>>
>> The main difference is amount of channels/GPIOs. The BD79112 has 32 pins
>> for this use, the BD79111 has 16. Furthermore, the BD79111 data-sheet
>> promises 0.5 MSPS sample rate with maximum of 10 MHz SPI clock,  whereas
>> the BD79112 data-sheet mentioned 1MSPS rate with maximum of 20 MHz SPI
>> clock.
>>
>> NOTE: In order to achieve those speeds one needs to use more optimized
>> protocol compared to the one implemented in this driver. This driver
>> retrieves samples using two 16-bit SPI transactions. The first
>> transaction writes the channel to be sampled, and ignores data on MISO.
>> Then the next 16-bit transaction carries the data.
>>
>> Achieving maximum sample-rate would require the driver to interpret the
>> MISO data of each 16-bit transaction so, that when the
>> channel-to-be-sampled was sent in transaction N, the data is read at
>> transaction N+1 - which also already configures the channel to be
>> sampled for transaction N+2. Supporting this would require the
>> channel-to-be-read for the future read to be known when the current
>> channel data is retrieved. For raw-reads this is not possible and for
>> buffered reads it would make things a bit hairy.
> 
> FWIW there are quite a few drivers implementing that scheme for
> buffered capture.  Look for drivers that preprepare an SPI transfer.
> Absolutely fine to not support that optimization!
> 
> This seems like text that probably applies to both parts rather than

Yes. This applies to both of these ADCs. And thanks for the pointer! 
Once again, I really appreciate your help. I will definitely take a look 
at how this is done by other ADCs. These two aren't the only (ROHM) ICs 
using this type of mechanism, so spending some time is well justified :)

> being directly relevant to what is added here?  If you did add that
> support it would be in a different patch.

Sure.

>  I'd cut most of that info
> to keep the commit message focused.

I kind of agree - while I also believe that noting the performance 
limitation coming from the driver itself makes sense. It does not need 
to be this verbose though. Besides, the verbosity already worked as it 
made you to drop me the above info ;)
//snip

>>   static const struct gpio_chip bd79112_gpio_chip = {
>> -	.label			= "bd79112-gpio",
>>   	.get_direction		= bd79112_gpio_dir_get,
>>   	.direction_input	= bd79112_gpio_input,
>>   	.direction_output	= bd79112_gpio_output,
>> @@ -378,20 +387,20 @@ static const struct gpio_chip bd79112_gpio_chip = {
>>   	.set_multiple		= bd79112_gpio_set_multiple,
>>   	.init_valid_mask	= bd79112_gpio_init_valid_mask,
>>   	.can_sleep		= true,
>> -	.ngpio			= 32,
>>   	.base			= -1,
>>   };
> 
> There are only two parts, maybe it is simpler to have dual gpio_chip
> instances pointed to by your chip_data? Keep the full state of each in
> one place?  I don't mind much either way on this.

I didn't even evaluate such option. I'll try it out and see how it looks 
like.

I agree with all other comments - even though declaring the indexer 
variable in a for-loop requires a bit of learning ;) (Which doesn't mean 
limiting the scope didn't make sense when index is not used outside the 
loop).

Thanks!



-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
