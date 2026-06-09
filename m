Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13834183BC
	for <linux-iio@vger.kernel.org>; Tue,  9 Jun 2026 13:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781012168; cv=none; b=DgQ5z92uXGtLkkTRSuugYULb+N//BDcl1WCKjGqt0GSslpUOkHd0s6Q5IC7vWkbzbQpkP3bbWUjaB72PNLR/Bt8QNozt8rR9OYk3HdaYDAZ2b2ZtiNdCXngqPLNbnSqa+8ApJ8nlY9hIDWyXw4A5eylPwQbtDNG8IclkWuwTyQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781012168; c=relaxed/simple;
	bh=KQ00C/T0PtTvLOkQ9jgo4BMm9vvhzvMku6FHwA90IuY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GCQw2QU/kl3BLa+H2Vg4ZyqWCaUeb4ZWXJnbq9wwOS6tVIXHw+cFFVgcKMpC+1MkrLSvTXCFmCUallV5qYvms6SoFkT2kH4XY2ATBI+WHvAeD2X8thXIegOp2ee6CjWGgJHBRUDc1DVzUjy4LwbVq+iUwt8auIMuNVWVXsBvcBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pwkkD1rB; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pwkkD1rB"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-45ef189aa1cso3956622f8f.0
        for <linux-iio@vger.kernel.org>; Tue, 09 Jun 2026 06:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781012165; x=1781616965; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nko1eeZPe9gacI4aqgmTtbFeb0B90PMqb5fo3nde8io=;
        b=pwkkD1rBGhWhOmU/Rl8oCFZWtA88oaZQ1gktEFtx4n5+tLaO2DGp0HNtqNb1ckXZ7B
         IXCur0HZ7A9we4hKHJMeJfgdmDfEZ093inMd4KyvZx7CFCsggsmb2LlbINzMl18Nw708
         4ggO0HmyH+qrMezaia89+4B4Xdv/rKMqojbDdNmtjRRiol50gIgGvKwbAi66NbgdvXTM
         wqTKPi7v2cUFDQYl/8b+qKcKj6rmwH7o6r43GQQ+tsIOe+dRLxUp6DVhQ9QFFT/Z7lLt
         DwYtIZJX3UgKtbHOOfbA8hAf/Zw1ASeizwgEOKojSxAfd6dN2SNt8VJVVj26j6mVGa5l
         svzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781012165; x=1781616965;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nko1eeZPe9gacI4aqgmTtbFeb0B90PMqb5fo3nde8io=;
        b=QhGP0vD9LsCNPW4PdM4wzpr5/Br7PPO4RsT2/IyHnKENQOJxr2379Xf3o12bMxjLTV
         dLncLjnvKZXoC5gNwKlvQa76cje2+1bfKoBu7SSpC+/s6pJuGxAsv8jvYmNnRY9PbDlp
         uvaV1t8F7VlSh5DopCsv5+mEBVn/rGCnRs2i/coSjf4DBfRmkGG2tgBil0nuMCHC4ro8
         9xZyGbVOdjNUUhXeDlCgOkmXpT2LM9fOcWhf1Q2ba6eod+OsySZZGm5ZIg8P/mAFXwNQ
         2U6QvU4AQZJbnT+t3jIqEj+2vuED3qb5/fj+3bQLLXRqdw3L3oaFYvW1CJ0aM7cYW1h+
         UBXQ==
X-Forwarded-Encrypted: i=1; AFNElJ+cNAlHotnnPmzvbdTgfe1hznJTmsrHmdq9Xa4Hz1b3R02sPQAolE8wLn+mo1TmqYhGQlL9QDQ1LTY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5gQ1hoEpyQYuVi5wQL2HUKJZD8vzZH3Sk9pJ+zOQFjMCfD8JS
	FpQsF5/sH8ai/MxfHwmI2kT/h3zkzQ4lSuNKjqCHZGAjve3C9ZvAY76h
X-Gm-Gg: Acq92OGRha1LPkau9CETVJNbgGgI+EJNVQo6mynmGlcDwwbAH6kSHU/8UG4rnxJKwo0
	exnsXycAemvUOjpntYQ7pxip4M9zXxs4CKKzYAbVE5hmEj24LwQEAe7sBwPstBlpgxxaDfhIYNx
	T2GFvuFTNcPiUbgifBEr9HwKJWIC/alLkfKaKtNEmGgPvPID5a6JygYEMYTkt6/UfAFT7I4gziT
	VqQVn276qg2iMxEvRkrcowx1So4ng31L7F41+8DXDFWexWjSJ4puRo0qM8MpwXWdiqy9shT8sQn
	Xu9p0Y3kzC4edOa3chsR96/r1zg03OFhSe3mweXQcFbE4VcHer/mvcvZuMEPDwafavjhv2AtP4X
	aolb6GWmVa5e+suHw8BHY3DXYEAVSjYUCcyTP7RcMBQsmyIHB4l6QALKiVjAfEtwDCkRXb718GU
	myf6m4ktBsDUbSTwikgk6ptc8VKaj95DykED9r9fwh
X-Received: by 2002:a5d:544d:0:b0:460:1643:caf7 with SMTP id ffacd0b85a97d-460306467aemr22662161f8f.27.1781012164957;
        Tue, 09 Jun 2026 06:36:04 -0700 (PDT)
Received: from [192.168.37.44] ([217.61.173.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f351ac0sm110805558f8f.27.2026.06.09.06.36.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 06:36:04 -0700 (PDT)
Message-ID: <dd8129c5-fe15-465e-8203-103be3d0c9c0@gmail.com>
Date: Tue, 9 Jun 2026 15:36:03 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] iio: tcs3472: implement wait time and sampling
 frequency
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, shuah@kernel.org, joshua.crofts1@gmail.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev
References: <20260607112713.299968-1-aldocontelk@gmail.com>
 <aie2Y96Oylb5EEtM@ashevche-desk.local>
 <55020e69-ffe2-4d40-bdac-e6649693ebb7@gmail.com>
 <aigD0vmVJvKbtONg@ashevche-desk.local>
Content-Language: en-US
From: Aldo Conte <aldocontelk@gmail.com>
In-Reply-To: <aigD0vmVJvKbtONg@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09/06/26 14:15, Andy Shevchenko wrote:
> On Tue, Jun 09, 2026 at 12:27:52PM +0200, Aldo Conte wrote:
> 
> ...
> 
>>>> +	cycle_us = div64_u64(PSEC_PER_SEC,
>>>> +			     (u64)val * USEC_PER_SEC + val2);
>>>
>>> I'm a bit puzzled why cycle has "us" suffix. We divide seconds by seconds...
>> Could it be ok if i place a comment here like:
>>
>> 	/*
>> 	 * cycle_us = 1 / freq, expressed in microseconds.
>> 	 * Numerator: 1 [s] = PSEC_PER_SEC [ps]
>> 	 * Denominator: freq [Hz] * USEC_PER_SEC + val2 [µHz] = freq in [µHz]
>> 	 * Result: ps / µHz = µs
>> 	 */
> 
> Yes, and replacing the USEC_PER_SEC by MICROHZ_PER_HZ.

ok!

> 
> ...
> 
>> 	/*
>> 	 * If the requested wait is so long that even WLONG cannot
>> 	 * cover it, wtime may still be negative. Saturate to 0,
>> 	 * which is the largest possible wait (256 * 28.8 ms = 7.37 s).
>> 	 */
> 
> This and other comments make total sense, with them it's much easier to read
> the code, thanks!

to you!
> 
> ...
> 
>> Moreover, I would like to take this opportunity to address the comments
>> raised on Sashiko:
>>
>> https://sashiko.dev/#/patchset/20260607112713.299968-1-aldocontelk%40gmail.com
>>
>> I propose the following changes.
>>
>> For the read and write event functions:
>>
>> The read path would become:
>>
>> case IIO_EV_INFO_PERIOD:
>> 		period = tcs3472_cycle_time_us(data) *
>> 			tcs3472_intr_pers[data->apers];
>> 		*val = period / USEC_PER_SEC;
>> 		*val2 = period % USEC_PER_SEC;
> 
> Again, use HZ-based multiplier, see above.

Here i do not understand why MICROHZ_PER_HZ is better.
In the previous case, we were indeed referring to the denominator of the 
calculation, which was actually a frequency, so MICROHZ_PER_HZ is indeed correct.
But in this case, we are calculating the integer and fractional parts of a 
period, so I think this would be fine.
Tell me where I’m going wrong.
> 
>> 		return IIO_VAL_INT_PLUS_MICRO;
>>
>> write becomes:
>>
>> case IIO_EV_INFO_PERIOD:{
>> 		unsigned int cycle_us;
>>
>> 		period = val * USEC_PER_SEC + val2;
> 
> And again, use HZ-based multiplier, see above.

as above...
> 
>> 		cycle_us = tcs3472_cycle_time_us(data);
> 
>> 		for (i = 1; i < ARRAY_SIZE(tcs3472_intr_pers) - 1; i++) {
>> 			if (period <= cycle_us * tcs3472_intr_pers[i])
>> 				break;
>> 		}
> 
> do {} while () seems better choice here (and do it in reverse order?).

Could you suggest the do {} while {} form, which seems better? Because I think 
it is already comprehensible.

> 
>> 		ret = i2c_smbus_write_byte_data(data->client, TCS3472_PERS, i);
>> 		if (ret)
>> 			return ret;
>>
>> 		data->apers = i;
>>
>> 		return 0;
>> 	}
>>
>> Regarding the oscillator tolerance, I suggest using:
>>
>> tries = 500
>>
>> Currently, it is set to 400, based on an 8-second interval divided into 20
>> ms steps. Considering a 20% margin, the total duration becomes approximately
>> 9.8 seconds, which corresponds to about 480 steps. Therefore, setting it to
>> 500 appears to be a reasonable and safe trade-off.
> 
> Agree.
> 

