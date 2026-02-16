Received: from mail-oa1-f67.google.com (mail-oa1-f67.google.com [209.85.160.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370162DAFDA
	for <linux-iio@vger.kernel.org>; Mon, 16 Feb 2026 19:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771268534; cv=none; b=H5085/qbxYYRkOCvNJOvp4WncFOpqnJeEE3a0clYjZs0Ny3A7h9h9f/jE0PGxX3quqOvrQNniIfe/+198D6aqXhnVXwsMHSF2lgMG0QLXJ5poOVQsrnjHYMUlc+1GXXDCIeCbucyVXfvFEf3gcYRpZdSHURqNXDLQv8JDTFnaHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771268534; c=relaxed/simple;
	bh=dPSKZWl7sBfP2MfxJjzmPQmCiILPmFkv6c8hC7edRmE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fMQcAeu4+WZl93VDA3iYQEYg7lVsjI391vigU/QAA4OPlDQitPPjFASaEZfjtAjr+zL4r3b9WBnGt64vcy1m9CUwQkwytPC0qLKUX+A1Ghf+Y680RN7IfWe+IHlHb9EADq8JWww+65q4esG3hEdLfKhkvwq+64oNy2AbxdiE20o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=M/NoZuOV; arc=none smtp.client-ip=209.85.160.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="M/NoZuOV"
Received: by mail-oa1-f67.google.com with SMTP id 586e51a60fabf-40f1ffba6a0so1091813fac.0
        for <linux-iio@vger.kernel.org>; Mon, 16 Feb 2026 11:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771268532; x=1771873332; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nc6fdFi3PpOoNTYHhslWaUJsykC31/8ZFpVvbIhED1E=;
        b=M/NoZuOVDQ6zAUlsFXJHEYSbZJyYp63dSnjG+feHs0bcKtPRtlWbbE+dO3Fb2UNwqH
         mhcR6oimKE2uhFrcdJX1oW/F3WQ5Su2HAAnSNvG4FIW46HRW72x41lgZAjv8LqilcizS
         LGw5e0Ym4il5S4wnLwbWNgK7LWh2iwTtVEhoCTzHmZXQ8pdW+u1x0e7ITTGt6PcKuZeR
         lgxX17e9OnMjNEWGJVZslOVNoXXs2ykJZLTxQALE5f/nscFhKk56/AWeY5dPmyCz/4iy
         YBgPn7gWxt/mJvnZ/rZEkTsT8xuJ9tzSsiPr3FpVnB1dNs63M1d0eWWIW12eMphGV+Lm
         kkCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771268532; x=1771873332;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nc6fdFi3PpOoNTYHhslWaUJsykC31/8ZFpVvbIhED1E=;
        b=gDCfIB1Uqs57ngWmRPFZYYDPVIh3f5ekuW+vRWO4Yc+ou0E0xb9vqs41BhyBoDnzmD
         95qlE3KU3bGdhl5ucJZvUS9AT+PLnZUYkEmh4bdCK9Z/qsjMeX5HayLVoLKyecV66r/L
         bFQyMZppKr4K9mGQ8CWKKVOSgP4jf+slggrRM7jXj6CCB56LK4+nWrJrw7+mTWkyi8MH
         RIeOBEXHySRQLNc0m78YxZW71ka/2otISfahF5PUj1+uGMOtEDYY/EzM/MXGGYKPGEL1
         mPQchbD40IcFdMIr/BeIcGLL2jJc4RdK0hEd3QbLCw5kmU+ArYOle5FNWPwB7pQJJw7x
         1k8g==
X-Forwarded-Encrypted: i=1; AJvYcCUOGOXpF9WWkUQ+wqebbJo945Y15ATECPD8lMhZU4KQURx+XJ2lAjYih1MpgI14gAuGDVHk/LroQMg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIL9RiFhEeKizmPvfJz6hyjPW5utFxAuZ/yyBEjjYLZ2aTFgPd
	rkGi4Pu9fd+dFZOCM8kzHj7I/ZiR0xVdICbcQNOqkAu7M8Y5jlOEJpUd4Fn6lZk/jWM=
X-Gm-Gg: AZuq6aICsX+6evky0bIKz563xIt3nzPiVLAx71nKi+KBIuGGZHHe7GHwKKkcfwMNdAA
	dsBZhQK7Ru2DZZGAoXA17AsGkG2MopUFwFjlJbUsEsPjclqYVofDYS7ACQew02VE1VXfJ7sWeTT
	59QkzcqrO9hdv0W0qiKCkyIEcoLqmbpc7fJpw73+dcn7tx6Es2/bKpogxMkdI0IffvwW/280xjp
	0QowfF3VetPWxO5BctSTOWnfx61fa4/ww5eiZTgsJ/IGDSSWBqc1xb6jWEYL1CkqL6rhlhIZRUc
	Lwin++YOOaRBry2KUCpZwV4chrnGG+MoAOEkNh4xbQAuJbiJm17lo6LsJlZAnD/xMSRYrYUqaap
	gr6LI1k0DB48YsYn69CbuCA+D4qpBcewj7EBu2I8ues11KipqqVfdJwYjxAHraeUarBN03USQ/Y
	19nF9LTAFqLpSqOMaDGVIXDYuMbB9igHUlLJrvjwyg/38MzXIormpdM48hhHe1rjkokxDvbP3O
X-Received: by 2002:a05:6820:610:b0:679:9353:1211 with SMTP id 006d021491bc7-6799353141bmr1339818eaf.78.1771268528343;
        Mon, 16 Feb 2026 11:02:08 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:2d75:8cf2:6289:6a96? ([2600:8803:e7e4:500:2d75:8cf2:6289:6a96])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-678b13aec01sm4984097eaf.8.2026.02.16.11.02.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Feb 2026 11:02:07 -0800 (PST)
Message-ID: <b27c638e-f0fb-42af-978f-89e38dea2b23@baylibre.com>
Date: Mon, 16 Feb 2026 13:02:07 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: iio: impedance-analyzer: ad5933: use div64_ul()
 instead of do_div()
To: Archit Anant <architanant5@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
 gregkh@linuxfoundation.org, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260122145633.14938-1-architanant5@gmail.com>
 <aXI-ZV4uAd5GyFLz@smile.fi.intel.com> <aXI_HnvDNbX68-lq@smile.fi.intel.com>
 <CADJHxWB3b+bH2+HBP+SG0jxhGNcozstBeWeDH_3dgS-4c2G-6g@mail.gmail.com>
 <aXJmYAZ-8KkXCFI9@smile.fi.intel.com>
 <CADJHxWDCer97pMNHV-69B9AEVY0NfimTcxo8k8yFBbstg0wMQw@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CADJHxWDCer97pMNHV-69B9AEVY0NfimTcxo8k8yFBbstg0wMQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/16/26 9:52 AM, Archit Anant wrote:
> 
> On Thu, Jan 22, 2026 at 11:33 PM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
>>
>> On Thu, Jan 22, 2026 at 10:27:52PM +0530, Archit Anant wrote:
>>> (Resending to the list, apologies for the private reply earlier.)
>>
>> First of all, do no top post!
>>
>>> Thanks for the review and the detailed math breakdown.
>>>
>>> I agree that `(freq * BIT_ULL(29)) / mclk` is algebraically superior and
>>> improves precision.
>>>
>>> However, regarding your concern about the original code:
>>>> "why the original code drops precision, was it deliberate?"
>>>
>>> Since I do not have the AD5933 hardware to test if the register expects the
>>> truncated value from `(mclk / 4)`, I am hesitant to change the logic in
>>> this patch.
>>>
>>> Would you prefer I:
>>> 1. Stick to a purely mechanical change (keep the logic equivalent, just use
>>> `div64_ul` and `BIT_ULL(27)` for readability)?
>>> 2. Or proceed with the `BIT_ULL(29)` simplification assuming the precision
>>> loss was unintentional?
>>
>> I definitely prefer #2. That's why I plead to AD people to confirm.
>>
>>> I'm leaning towards #1 for safety, but happy to do #2 if the maintainers
>>> (Lars/Michael) think it's safe.

> Gentle ping on this.


As Andy said, please don't top-post. Put the reply in context to make it easy
to see what "this" is referring to.

I moved your reply to show what we mean.

> 
> Has anyone from AD had a chance to confirm whether the original
> truncation via (mclk / 4) was intentional?
> 
> If there are no objections, I can prepare a v2 using the BIT_ULL(29)
> form as suggested.
> 
> Thanks,
> Archit


Given how old this driver is, I would not expect an reply as the
author has likely long forgotten what they were thinking at the
time.

I would keep the (mclk / 4) as it is to be safe as you suggest. There
could be userspace depending on exact values currently being returned.

>>
>>> On Thu, Jan 22, 2026 at 8:45 PM Andy Shevchenko <andriy.shevchenko@intel.com>
>>> wrote:
>>>
>>>> On Thu, Jan 22, 2026 at 05:12:42PM +0200, Andy Shevchenko wrote:
>>>>> On Thu, Jan 22, 2026 at 08:26:33PM +0530, Archit Anant wrote:
>>>>
>>>> ...
>>>>
>>>>>> -   freqreg = (u64)freq * (u64)(1 << 27);
>>>>>> -   do_div(freqreg, st->mclk_hz / 4);
>>>>>> +   freqreg = div64_ul((u64)freq * (u64)(1 << 27),
>>>>>> +                      st->mclk_hz / 4);
>>>>>
>>>>> It can be one line to begin with.
>>>>> Then drop that ugly castings and explicit big shifts.
>>>>>
>>>>>       freqreg = div64_ul(BIT_ULL(27) * freq, st->mclk_hz / 4);
>>>>>
>>>>> Now you can see That 4 is only 2 bits, so this can be written in
>>>>> simpler way:
>>>>>
>>>>>       freqreg = div64_ul(BIT_ULL(29) * freq, st->mclk_hz);
>>>>>
>>>>> which may give a better precision at the end of the day.
>>>>
>>>> It also might be worth to add a comment on top to explain (with given
>>>> context
>>>> I don't know if there is already one on top of the function, though).
>>>>
>>>> And I think we want AD people to comment on this and maybe explain better
>>>> the calculations done (and why the original code drops precision, was it
>>>> deliberate?).
>>
>> --
>> With Best Regards,
>> Andy Shevchenko
>>
>>
> 
> 

