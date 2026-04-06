Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333542EA172
	for <linux-iio@vger.kernel.org>; Mon,  6 Apr 2026 13:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775483050; cv=none; b=ZWx5/Vyp7av0FtK0XubBXOjLbN5fjTNiQpFKHPXbNJlsBDgd3zY7SJVgsnJieaAFi64YJX9T10DElD9e94BeUvSC+gZnnfbehHrgdW61GAdJwA/fNBLTGKqemQFVMZ8Uik21rTQ4RzgpxEKEO9Vw+sBZYCfajyWJ/FFGzzt/Hpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775483050; c=relaxed/simple;
	bh=hkcM1Omm9OFY6W+niG6QwONEFgv1cJEAMBmp9sPIB5U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o1keErvBfhjSJs9kqtVL6g9eBALDHn694HrtowhdaSJEdYpBGnd47xcabZy5dd8F7n/J9R4WpSJ6upzB6swaFaDQO4ROuDV7OqcNSv+rsFGva7QhXY6gOsJUwBfGXuzuMN6Q7Djc0oma5hF/shXUSBou8KqZjVIvnZjCpXAPNL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=EpI3IggI; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="EpI3IggI"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7d8b2703f37so3691539a34.1
        for <linux-iio@vger.kernel.org>; Mon, 06 Apr 2026 06:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775483048; x=1776087848; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7rlQVLfivynUuzRB6dYfCNFOl6c9Ld5CNamz7tvg5f4=;
        b=EpI3IggIGZVVD0vjKmwWONi0EPPwXX3XN7NAEM9b4wDVT6nbv96/CKQ60b7F58WQAa
         +7cCka65EOM8/GcT/IZIf51QBwwSxlDeehg9HV5DuOvkIQ+W3W8Q5FNrxi561AdSyEht
         SLeupVKDHBuRR6zZ0NFzqD+K+ItF0RmdMl3X9Uh7mJo5quxtNlTvQOLYLWtmQ1rr0lgV
         DlZZzrBmKqJQMsXVrAPFBaBXYraeCuZK7J4CBMW4o1Lhx145kILQJn4wOfgSUbcdVm86
         fn1PTaZHfIQxgwUsH8BhHiOYtQrGPphLmdolEW0/05WCbsRUXdrPaVmEdAzTTu+qYzjy
         BxUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775483048; x=1776087848;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7rlQVLfivynUuzRB6dYfCNFOl6c9Ld5CNamz7tvg5f4=;
        b=q2EtV/i8idJcAvJTs+6Pzdhp/XzkDfAEmSag1NpVPNOBuvaV38M5rMG0ZTHwWi4gU2
         S6qArqUZkUZhCgu5Xy4InTUHHMdWfCTxyJzxa9VVxgdRjXW8jCSJSuiwMD881zUsAsxb
         aOCB3TUO8NsfN0+vAkXtlZSkQw+AOIb5j0E4/3o7sQe2K/OSEWrPsb5lKNShHAXBUGSr
         tNDlK57M1YCj87tFPjOl99Ot0XX++R2FdpOGvH7aB6vDy8WS+J3wf6X9Yi6TDsbsA+Qj
         MB7+MHHxoTsXZAxq3JmDJQp6xlFwvZYFzFTGF2r87/NvIv5ylybEiyFY0o0bHk/hHKBx
         Ub3Q==
X-Gm-Message-State: AOJu0YwbNShoH1hKusmIuyaOF6XSOJZgXmkGJLh7qFWqeQahUDw44ZTE
	sG/W/FI/7P9XVDWaDYaDU89GYZigya29QQm80ipQsICJ0nboexGAWeZwupLxmMTP3Qg=
X-Gm-Gg: AeBDievCi7axkQy4+xsqWaBq8ADwh+ZKeGm2FSMIR963jzPZrLT+vyCb7z7k9+tyFFC
	MrPusqgSJmfcajc+h8I6x0owPKU1VWJxuGXlBxx5eVFdv3k9/aNnnL7pUpKfEOvmHx/iCTItqeN
	482h8TtQG5GJ6CCcZrps1FBZtVaGHx5GDgOEqg9RMui46S761dkqJWPRLYGZww/l+Aev35aTOPK
	zGa6JeIgwixrW6/aBZXwj6cAfJnGZ11k4UAxukK6fH0HnsWJsSgoShVhI3J50YSLbl+0x95EPTW
	bWaA5Sb1h0ilbPLbRDWAavnNX2FaBI8dhqW2AF5W/pTikKBZRPxT55mqYNNBjQ/iPdNE+SubVgF
	csrY32YFE+NX+9nAVXXhBjKzUVtTNRLzK9hZmsI6pgQkd5kVvAC8eEfQIft4P4AUb6s2XPbUy/a
	uUCVBU8JAyfHJeV5vC27qCYo6qZBv1tzBRP+BCXVujVNvef+skTNV909OKcR5+yBcDic8WvxU=
X-Received: by 2002:a05:6820:81c5:b0:685:d2b6:6df7 with SMTP id 006d021491bc7-685d2c5b87emr2235876eaf.9.1775483048117;
        Mon, 06 Apr 2026 06:44:08 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:90d7:b13f:c53:8ca3? ([2600:8803:e7e4:500:90d7:b13f:c53:8ca3])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-422eb42db1bsm12915687fac.17.2026.04.06.06.44.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2026 06:44:06 -0700 (PDT)
Message-ID: <420dba4a-0c31-47bc-b84a-5d29702b115e@baylibre.com>
Date: Mon, 6 Apr 2026 08:44:05 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/4] iio: adc: ad4691: add SPI offload support
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
 <20260403-ad4692-multichannel-sar-adc-driver-v6-4-fa2a01a57c4e@analog.com>
 <1d0d41c8-7867-4459-a91a-a2c6774b1885@baylibre.com>
 <LV9PR03MB84145906CC191F6AB8D2D3DAF75DA@LV9PR03MB8414.namprd03.prod.outlook.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <LV9PR03MB84145906CC191F6AB8D2D3DAF75DA@LV9PR03MB8414.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/6/26 4:34 AM, Sabau, Radu bogdan wrote:
>> -----Original Message-----
>> From: David Lechner <dlechner@baylibre.com>
>> Sent: Saturday, April 4, 2026 6:34 PM
> 

> ...
> 
>>> +Selected when a ``pwms`` property is present in the device tree. The PWM
>> drives
>>> +the CNV pin independently of SPI at the configured conversion rate, and a
>> GP
>>> +pin (identified by ``interrupt-names``) asserts DATA_READY at end-of-burst
>> to
>>> +signal that the AVG_IN result registers are ready to be read.
>>> +
>>> +The IRQ handler stops the PWM, fires the IIO trigger, and the trigger
>> handler
>>
>> If we stop the PWM after an IRQ, then we don't get a consistent sample rate.
>> Ideally, we would leave the PWM running and just pick a rate slow enough
>> that
>> there is plenty of time to read the data. Otherwise, this mode doesn't seem
>> particularly useful.
> 
> Should there also be a condition when setting the sampling frequency, that will
> protect from setting too fast sample rates?

I haven't figured out a good way to do this since the real max rate
depends on a lot of different things and when not using offloading,
the time it takes to do SPI xfers is non-deterministic.


>>> +IIO DMA buffer:
>>> +
>>> +* **CNV Burst offload**: the SPI engine reads AVG_IN registers with a 2-
>> byte
>>> +  address phase followed by a 2-byte data phase; the 16-bit result lands in
>>> +  the lower half of the 32-bit word (``shift=0``).
>>> +* **Manual offload**: each 32-bit SPI word carries the channel byte in the
>>> +  first byte; the 16-bit result is returned in the upper half of the 32-bit
>>
>> I would expect the "first" byte to be in the "upper half" of the 32-bits as
>> well. This layout could be explained better.
>>
>> Also, since extra data has to be read in this mode, does this affect the max
>> conversion rate?
> 
> This is bad documentation on my part. "channel byte" isn't used anymore,
> this is previous version behaviour. Right now, only 16-bits worth of actual
> channel data are used.
> 
Then why do we need the shift if there is no other data? Can't we rework
the SPI message so that there is no shift?
