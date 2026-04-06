Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738B42EA48F
	for <linux-iio@vger.kernel.org>; Mon,  6 Apr 2026 13:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775482769; cv=none; b=R8YzXghee+elNoudpP5wtHZU93Xh2jl32IHmu3lVytCFFUBv1GDFAcT8NDs9ZGjkZ+xmf9I5l6OYh7xtjah9h12FuyHBvdtjX6TZjpd5l3pDLLrZ8/cOtzhavYueda+70JQbc2zy6ANvr++40U3kMQUoab3dwfRCwxav9/X6IKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775482769; c=relaxed/simple;
	bh=wkrJeNFWF2uMlRZnWrjqBwY2c14k9cP+d6D7rKAU8LI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pzLYKg+IlTdVEfUBerpDrmGRCXpfMWYExO6zYf3aWPwymC894+QhJJjEz3uz0PSCELDNZbG3yej4r0DnQWFINyEfgs8sYc4xCSx/A/r0eDeoidF9TB0F9pc6/+xEl9V6UKmIZcFpWV5sX25PccIGT3OH921kCJP5lax0Vdjgkww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=aD3K9pC7; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="aD3K9pC7"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7dbcf927395so868843a34.0
        for <linux-iio@vger.kernel.org>; Mon, 06 Apr 2026 06:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775482766; x=1776087566; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1lorUh8imlkbzF1MrlVYRw6zvFFtCWMp5F11QdFDe9Y=;
        b=aD3K9pC7+rTAKV/iXTsVgBDse/4vpMthyb/KDFQgV63WpPiEnmyCldJO5vJ628jicF
         3WKrk3tArUltkrCCMjwlyCILDZxdyRHEIJ1T2R28pEXs6+LTU/GnaJELtrizwWZZlU9Q
         SPjLyu7ddgigIsKfds4wcIwDshAvMZFoXlB9Urc3Qk2y4frxfSFyr92qGtcLVNP6wys8
         WV2s5v29oBCfykNFmTDjLmofeNxwjXw2EXyIgbdndHEJEGyi09kbjg3YJIFqvHmjQVMM
         n1zRdgVrZ+OfNAUsCIOpTnHDzH0oFKV7rNwnicJ4rqISh3FcUtjWRPRy3u+meSjWUQeI
         Mstg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775482766; x=1776087566;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1lorUh8imlkbzF1MrlVYRw6zvFFtCWMp5F11QdFDe9Y=;
        b=j0wn704NfdcZp333t1wc2rfqklDXHlkMIPJhQyvyhhO0OpznZtSBztLuY5JKdjIg9i
         wxlm2SoK17pCd/HE8eFSYMDjjgoFFp5TqVk/n92987GhVVb+ttQxV5nMsz+prep6gkCZ
         lAJwThtk9u/h+eQNvmXpLbgcg5cFjS2cA8cyQ16MbpiwyA/cxWzfIGza1iaqZqRZZNFU
         eomRoSrCUhcIa5HpEM5TSMj6uJ0J4sfs6Rdi0vZFhjzoNhzIXsh75Oc113d676YxH7Gp
         SH2Jd1f+DysZbK0lHczTXUAq1urG2Tut4dnJ9JKRy32S24lqZVK6OIglnb87eM9jRrH1
         TKog==
X-Gm-Message-State: AOJu0YxPAfhgsy2uU5Q6PIidEehMRB174tTD3KUTt3kn9tsgdOlFkOh/
	EakkymCSDMZ+IYCamwTXtSOzTldjIq+Eh9UicWDjz9BuCHLTsX7IM8i4Moas6UJHFmA=
X-Gm-Gg: AeBDietKJ7vvUrEzwmsk+muxD1184TCODCHU5UDFVhngKBhZnfuAxuNU1uQux7IzWaL
	S8bX39ecsQYjz/wexu0CUilFx/VCeEZMIDTN63EUxUDL2dj3NBu/Xv9WwA3Jjhso3v/x+oHHMz4
	M5UPQ2be5cRccIeU+iCIvR5vlthn1ELfiYz8UoqoV+g50OmhMVaNfsTvJNVzrjmEqSUqQWAnOKg
	flP0O+KxNmyyC1ZGefN/4rKlklvelRhD2aJxgNttUX7o19RqyCQ/Bsm1wlVtPicXZMgL3ysUI/0
	AkrKeDUC1Ml58NpQltedEvfhD4PoKEpTheCm6f5e8PB97sQ/OxwMiAV2tKOXlMwV9uTE/gNRgiT
	Hgz0AV91WOkXkPUAU/xqs3CYXdtWztbTiA65sPumdacq7ap0+yNkzpRzvGfazqJy6eJl+PNkD5l
	7IE1i4+RWgNNyic2NUVADzaW+UE924jSMnwdv10uZfTI8ZeOSkyzniMlK9OGNfVtGWieCmhWM=
X-Received: by 2002:a05:6830:3783:b0:7d7:b6b2:6352 with SMTP id 46e09a7af769-7dbb6f961eamr7766540a34.13.1775482766251;
        Mon, 06 Apr 2026 06:39:26 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:90d7:b13f:c53:8ca3? ([2600:8803:e7e4:500:90d7:b13f:c53:8ca3])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dbb7c3a0c8sm7531599a34.12.2026.04.06.06.39.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2026 06:39:25 -0700 (PDT)
Message-ID: <18f79a5d-2f64-4984-9df0-40234f72646d@baylibre.com>
Date: Mon, 6 Apr 2026 08:39:24 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/4] iio: adc: ad4691: add triggered buffer support
To: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 "Hennerich, Michael" <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, "Sa, Nuno" <Nuno.Sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, Philipp Zabel
 <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
 "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
References: <20260403-ad4692-multichannel-sar-adc-driver-v6-0-fa2a01a57c4e@analog.com>
 <20260403-ad4692-multichannel-sar-adc-driver-v6-3-fa2a01a57c4e@analog.com>
 <e38e5b97-e90f-4613-a15e-6c3d08cd77f7@baylibre.com>
 <LV9PR03MB84143905DD2E10BAC2151EEFF75DA@LV9PR03MB8414.namprd03.prod.outlook.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <LV9PR03MB84143905DD2E10BAC2151EEFF75DA@LV9PR03MB8414.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/6/26 4:22 AM, Sabau, Radu bogdan wrote:
>> -----Original Message-----
>> From: David Lechner <dlechner@baylibre.com>
>> Sent: Saturday, April 4, 2026 6:12 PM
> 
> ...
> 
>>> +
>>> +/*
>>> + * Valid ACC_DEPTH values where the effective divisor equals the count.
>>> + * From Table 13: ACC_DEPTH = 2^N yields right-shift = N, divisor = 2^N.
>>> + */
>>> +static const int ad4691_oversampling_ratios[] = { 1, 2, 4, 8, 16, 32 };
>>
>> It would be nice to add oversampling in a separate commit as that is a
>> separate feature.
> 
> Do you think this would be suitable after the offload commit?
> 
Yes, I think that would be OK.
