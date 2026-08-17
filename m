Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5F6390218
	for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 05:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786945414; cv=none; b=nOCl1TlVo7MbM/nyPbsgQFzF0MCroWl1tuErPkKb+6rxt0+s5pvm0pe9z+aBksbq69PwQ2j0FZsDFJbYBww2HsI7N6dwlthmxm4NTYKxj07+1uBZMo7JqkpPYP/mEdHyW9IMR5P8o0AHJzjaO7CGMss/6QvfLGrLoGIfu0thgLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786945414; c=relaxed/simple;
	bh=S0vULB/n8LrPfA0V+9fCSczc7AQqoE1uGQwDUukYiuc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XlmxMS0RB+F861gnubb6Cx3TiEqvIHxoNK9pSU1LAZgulZXIAerlQ3XItALtN2wyYgxpvjIaVGZqZ/DXu2WPFstFX5mU7im1VyZp177ur25mDqtcaMmBnQicrHDJ6yOxrALM9m/yT3XXxBOb79YvwCusJ3njkVBr1VjnbrFoKvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tJ5eOrhL; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tJ5eOrhL"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5aeb59d54b1so2980205e87.1
        for <linux-iio@vger.kernel.org>; Sun, 16 Aug 2026 22:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786945411; x=1787550211; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cdb74kLqBcByO9Fg+2Eip0JuCZMog70GR7qcAVirj2o=;
        b=tJ5eOrhLQuBPFC0MDvxhd4OouHGJ+0MSpi9HJ+jXC1Lkt5NZ8oF9zubXcsidz1uWbP
         QUMMZmtSm/XOnI2c5MJCrLgyQNHTFHSnaJROZYL3Wzxlph5fzdYPnxQ9NHsR4pX2yBgE
         SPg6duo8qrRzf9BGlrdO2fLr4RePZj78/tPeNok6QZxLEY4pbryq93pcN9taKc5EVMS9
         92l+httVmaR37DF3iOyiuhhjGadxKvMSgagNe92O7iwXuY3rk63WAu9Dgdg3nto70P4R
         AtDCFEB8AsYSGNZOHwulC5chqYqilbeqXV7waxOzIKrJ4X9/4H3TW+LZJuCFbBbtdZeF
         mQGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786945411; x=1787550211;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Cdb74kLqBcByO9Fg+2Eip0JuCZMog70GR7qcAVirj2o=;
        b=kYrBIuAFrxDWDdHBgDh4qIDN2pZeOIDUww8Qk4V9/0s4EB9NtBv0KqkAWyKapiVacl
         Rm4KWL6ZMG17YtU2kRxz81F4/PCxEog7XYNlM/NtR/AyUlGnSD1Y3V+52YIYpVZo2zsE
         bEa8OoCopI4AIsCys9B9YYItvGh2iRkpuL5QzbVWh8VWFl0XCLAkjdPlaEr0XknYxs1h
         rNFPQ2YqCyZtUqcm0gwHKWXFpbXaOB0qsphnARAxskuqRpRfpW79FzqC8Wn2gmYOOStU
         e25V+pnvBweKNBS1HlFylY6yqgWdaxqfJs2+b8zP/e33jxv3g5rmyuNa4iSmItuMNSIS
         1eyA==
X-Forwarded-Encrypted: i=1; AHgh+RqYui7RG6ccdpcpUeoinRqzxOrUNoFnqriy1liShciqsKpK6yoQH5gg2L4l9MYWpixxEJtGgf8UWCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYAhpFkznMsCIrdN0P5GC8XvjVx8y4j3UsLzbAoalDFBzxLWa5
	buGJc9D2hLexekkkEnz/IIwq44otB3X4wv5rAd7kDh5/GWLiQjp6HNmv
X-Gm-Gg: AR+sD117l/Cma++p723DNDPQg0F6er6mJcThLtIYskdg0DZi38ZAKXgVVTN41VsPLZV
	pitBWwQ4HmL0Oonab4EpChFmEAYS6ccjVY/jgsZMosa/eEkQ2GvFYCT518ynjmaRpVd1MAYJPB+
	sOyEhAea2D8SxO5+W/7NcBDTq+xNu0TIJRqw1Tq7hv97G3LU88p6MQYj9iCbl8AHmZoUoaclXKM
	yk9wjv+SPL7x+iRsRgadj1UTX7n/lU3e5UtmdZQ8BK3z58lb5AG4WuYCo96qxl1Wsrrsra1tPAu
	i06U0CrfgA+DHPSTPTA7TeQEkpBO5J/It7fBBOh/dtPTesfk+8+59R/OaH5vWDDn+Y6Ir6Pxq9c
	PVYGPsqSuTZr0rchRE5L3ip5CqG/uyAaD6WXe5cCvn57ZamofE3LobzWhDa6V20RdlmsJxRSQ4P
	VtI62v6os1JvrdxSoF9l29eOjSU2FKEhIR7b8qGlabz09cbCQMF61mRdzIQuRdxXwEGxfJCenPI
	G9nEJfH2zTzLLuj9yW40E4r8j7iPFNV6RzQNsECCvrh
X-Received: by 2002:a05:6512:3f0a:b0:5b1:55a0:f7e0 with SMTP id 2adb3069b0e04-5b4596d95f2mr3094316e87.44.1786945410460;
        Sun, 16 Aug 2026 22:43:30 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b46cfa12ccsm90599e87.27.2026.08.16.22.43.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Aug 2026 22:43:29 -0700 (PDT)
Message-ID: <339dbb07-1dc3-4cf6-8be2-ae8b84bde233@gmail.com>
Date: Mon, 17 Aug 2026 08:43:26 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/12] iio: pressure: rohm-bm1390: Fix AVE_NUM
 initialization
To: Jonathan Cameron <jic23@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Matti Vaittinen <matti.vaittinen@linux.dev>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Mehdi Djait <mehdi.djait.k@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kalle Niemi <kaleposti@gmail.com>,
 =?UTF-8?Q?Topi_Sonkaj=C3=A4rvi?= <sonkajarvi@hotmail.com>
References: <cover.1786347811.git.mazziesaccount@gmail.com>
 <7784e12793187a75dc10b0e84471f0cefe4d28b9.1786347811.git.mazziesaccount@gmail.com>
 <anovRGxtsyJZ8cO9@ashevche-desk.local>
 <247b0e35-f49e-4bec-abd4-4a2c3dd49a2d@gmail.com>
 <anr0jtvYorFKaEXY@ashevche-desk.local> <20260817021927.142ebca9@jic23-huawei>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20260817021927.142ebca9@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/08/2026 04:19, Jonathan Cameron wrote:
> On Tue, 11 Aug 2026 13:08:14 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> 
>> On Tue, Aug 11, 2026 at 12:05:47PM +0300, Matti Vaittinen wrote:
>>> On 10/08/2026 23:06, Andy Shevchenko wrote:
>>>> On Mon, Aug 10, 2026 at 10:53:07AM +0300, Matti Vaittinen wrote:
>>
>> ...
>>
>>>>> Use FIELD_PREP() to shift the intended AVE_NUM value to correct field.
>>>>
>>>> Can it be FIELD_PREP_CONST()?
>>>
>>> Can you please elaborate why it should in this case?
>>
>> I'm not sure why it's not obvious, but the parameters are constants, why would
>> we need an additional check or even checks?
>>
> I'm not sure it is as obvious as the name would suggest.
> FIELD_PREP() has a whole bunch of stuff that runs if it happens
> to have a build time constant value +  FIELD_PREP_CONST() is
> documented as primarily being there when the code requires a constant
> to be correct.

This is what I read. My first thought was that FIELD_PREP_CONST() is 
useful when constant initializer is needed. So no, not obvious for me.

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
