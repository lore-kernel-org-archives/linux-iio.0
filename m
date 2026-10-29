Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793307572;
	b=L1t3qW5SyYR2gS9d7onpJpvV0xfX51KIvPLjzTFpkXKkmsxBirCEap+z8wSjqBjLzaVP
	 lJ+04GYNme+GFeM5/wOZelKNRaY21IKGacnqjcmHbk4Db0n9+npVKUlvowkmbzMtTnw93
	 QmRLgF4hlFc3bIY2eIDGihQidCLP4VntrtLMcuW+JrHs+jvoeadV4gEe6N2iIIrSXg/7w
	 eeCwPaf/7ktz4XflmTI5lc/M5lMK0DwdeUlnsjc00xeV2+/9BRjOyihOP0MJ4qWMupo5+
	 oA1JceRmopTeVS+muiAgcxYHMo9bxkl5KZ5QIFVogzyQd09MbYf7uGLhJX59O2XJ+nQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793307572;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=hpVaakSFJ8J6aOpJxgRujrYu+K0/hJbr4eZQmRroI9c=;
	b=3HOxQqdF7p5sk7F3b7iHPywJA5rsbmDgsTrCwcMzS4YvKOVPJj+iSurSFfx00WuyCZaJ
	 FikxKIZhzULck/7X3E+2O1R42nUZCISn8niF7FXRbQuNSu1a1Uj+wDstZVQzEBPgB7Krj
	 ZHdes2lTu0yL5H+LlQjCw6iF7tgTvgPIw6WLW5FcKg1dIQFsbNsbCr/y8fVzzMPais195
	 rWfKMbkU0bmAM1x+KZcao13fukhOA11BCL5S1Mc00cq6updl+K2z3arasyGPjsjEqhzzz
	 2T3GcEj7JGaVd9KbjAfAdW0dmxgIVvmd0VNgtDv+q2HkCj2desgpbYmh60IEJQlsKcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GoGN0NSu;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64801606A31A
	for <linux-iio@vger.kernel.org>; Thu, 29 Oct 2026 20:59:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64801606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GoGN0NSu
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48dfaa3fa12so737467f8f.0
        for <linux-iio@vger.kernel.org>; Thu, 29 Oct 2026 13:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793307571; x=1793912371; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hpVaakSFJ8J6aOpJxgRujrYu+K0/hJbr4eZQmRroI9c=;
        b=GoGN0NSuGzvhsqjKjV6E5CoaLk9pA1N/4XXrZ9Cr5cu8nKVZhXSK/n7ffPdoh73w8t
         QkqpgFbbYedLP+PYFJB5dbtvk0YRSoHqThZA2K3YbAoujDMojTOdr2q3V5QeSnwInxhP
         sNgau1sJ31wc4/I/h18T18iLcZvmXGG9wGmy1iefz7jvo4MwrVQEjGIjS+ECxb5+ghWM
         OyRFtwpbD8ocS++S2kWWIzjNj3UnDGGIoQVjvhXGKRjO+Ntmo7YfL8tiklNuhvi/44we
         TcJHFv5lVRzAuqOZBY9/2R7eVNsBudMFy63P9hWHAoUyRiYUznMEydXiwjDHoUgfwM6D
         MLlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793307571; x=1793912371;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hpVaakSFJ8J6aOpJxgRujrYu+K0/hJbr4eZQmRroI9c=;
        b=QIcKI++iyOtCo/VqsiopCUj+k4HODjJc0VJ/1dvOG81Jmcve3nJgrPp7pJ6V3rzIF8
         fqoGPD4nMwL1LePkoQFmZ3PWqRin4wov64KoVg7BimJExTFiP0gLUaeGs8XtKpQ7s3Yn
         WEhGlX3QJav9abkWzJC51YlS4XLSiLPEKSk7XSSkhEoRH3pMzTYzoF3iRUYrfXnJ+2FF
         nij8PazfCQ3WB7cQ9DI2h5INpbAJf6OUURqm0EYfv8eOvVtSQ2+K8jAxpQRgUG4/kyqC
         dlUCytTGETcKIG79QvrGQ+660eoDTlgwzFhlgB8lemwGaSlvQzFtnW/mKwylRFsfWbCH
         XCRw==
X-Forwarded-Encrypted: i=1; AKwUvBwECWSRaBhvXcGlqjhHPLO6/s3GdF2pA1oZDjThP2OUfbC/IaDRERg+Tl0Vydhd01QQ3+yt9jpLbj4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLZ+AkHUDeCFJHZ9UdD2Hs4EZ14+DGCwlbjE31tvetBHnz3eFw2
	2bgKcGuukoLx8FRxUCymzbcggHKdd/Pv7JFcDurkBps/WrH1W+p8gOVU
X-Gm-Gg: AYBFou0T/QsN+WO5qVczJQ5LOwTiW1+PWqfXx8/DEEXhWtMZVfoeZowLwfXFst0U712
	K5ATAq1Dw9L+F1bGWRFPg80Oj1urs2+2btH7SBfORDQExvqN5OAnzl28um8cQGLtAsq80JD/JQN
	FNfrpbHWagkx1139Wif3AvUUCBLCvDmKCoDguubsO5Gg0CiegFHdypWbr1nUCVevINuqgJ+rihY
	58Ce6/d/jPSOh2d/fUFXp5GzFiQh7sOfZH/bDTG6zU9LbBdCysGTdK03EBvFRUnI1VtDrmT3XBa
	QRln0ja3hjwCVRg0Km01oHPdmJTO+mVr06ZOrsyd82+qDKgxdoHyrbH0Ai50GtCGRZsoOqTG1Xl
	G/1PAfSGf2fadnYXdLXdA+xkCnaXhudCG680LzD6CSEBosxtf+V1Kj6BBrnSc2xDKz1BvhnWWbp
	4FbAfu17y9+z5V7xHf9ATVm8/Wa8FX/pvrijAu8AT+OR8OCGYYy9qk6HdsjnUx/CSI4QhkQKhiB
	jjApQEy4KbBy9Jj4ONnF8XNMyNEtKnK4625YqqUbD9Qh0mOW93uXcCYANr4U6u67t7GEGNE328n
	+VTZVaJ4LJTwYKbXhmhjeSX4uV40utMsGu5A8BmzRO6P+A==
X-Received: by 2002:a05:6000:4a19:b0:48e:55c3:efe8 with SMTP id ffacd0b85a97d-48e649ad4cfmr9818193f8f.8.1793307570500;
        Thu, 29 Oct 2026 13:59:30 -0700 (PDT)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e6eb9774dsm730998f8f.44.2026.10.29.13.59.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 13:59:30 -0700 (PDT)
Message-ID: <102aa257-9816-4e56-ab90-f3edc2a725c5@gmail.com>
Date: Thu, 29 Oct 2026 21:59:28 +0100
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
Subject: Re: [PATCH v7 2/2] iio: light: add AS7343 multi-spectral sensor
 driver
To: Chang Yu <marcus.yu.56@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Joshua Crofts <joshua.crofts1@gmail.com>,
 Shi Hao <i.shihao.999@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@intel.com>
References: <20261029074851.216029-1-marcus.yu.56@gmail.com>
 <20261029074851.216029-3-marcus.yu.56@gmail.com>
 <533bca43-8de5-4295-b226-5ea3742871de@gmail.com>
 <auN2jwQVr-GSnZvF@zephyrus-g14.localdomain>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <auN2jwQVr-GSnZvF@zephyrus-g14.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/29/26 5:38 PM, Chang Yu wrote:
> On Thu, Oct 29, 2026 at 12:20:24PM +0100, Jose A. Perez de Azpillaga wrote:
>> On 10/29/26 8:48 AM, Chang Yu wrote:
>>> Add a driver for the AMS AS7343 14-channel multi-spectral sensor.
>>>
>>> The AS7343 is a 14-channel spectral sensor featuring 11 visible
>>> channels, 1 near-infrared channel, 1 clear channel (VIS), and 1
>>> flicker detection channel.
>>>
>>> The driver exposes 12 spectral channels (11 visible light and 1
>>> near-infrared) via sysfs. Runtime PM is implemented to stop
>>> measurements and enter SLEEP state when the device is suspended
>>> or torn down.
>>>
>>> Future patches will add configurable gain and integration time,
>>> interrupt support, buffered reads, VIS channel, and flicker
>>> detection.
>>>
>>> Datasheet: https://look.ams-osram.com/m/5f2d27fff9a874d2/original/AS7343-14-Channel-Multi-Spectral-Sensor.pdf
>>> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
>>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
>>> Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>
>>
>>
>> [snip]
>>
>>> +		/* Check for digital saturation. */
>>> +		if (status & AS7343_ASTATUS_ASAT_STATUS) {
>>> +			/*
>>> +			 * Per the datasheet, ASTATUS is self-clearing: writing
>>> +			 * the value back clears the entire register.
>>> +			 */
>>> +			ret = regmap_write(map, AS7343_ASTATUS_REG, status);
>>
>>
>> isn't that the STATUS (0x93) text? the datasheet says ASTATUS is read
>> only and ASAT_STATUS clears on access, so the write shouldn't be needed.
>> it also covers analog saturation, not only digital
>>
> Aw man, how did I not notice that?

easy to mix up, STATUS and ASTATUS are one letter apart :)

> 
>>> +			return ret ? ret : -EIO;
>>
>> -EIO reads like a bus error. as73211 returns -EOVERFLOW for this,
>> wouldn't that fit better?
> 
> Sounds good to me. Jonathan, if v7 goes in, can you replace this if
> block with:
> 
> 		/* Check for saturation. */
> 		if (status & AS7343_ASTATUS_ASAT_STATUS)
> 			return -EOVERFLOW;
> 
> I've tested the change on hardware and everything works fine. Or do you
> prefer me sending over a v8 instead?

with that fixup, LGTM so:

Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

-- 
cheers,
jose a. p-a
