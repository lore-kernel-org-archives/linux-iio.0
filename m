Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68B939B951
	for <linux-iio@vger.kernel.org>; Tue,  9 Jun 2026 10:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781000877; cv=none; b=C6dHRdv6LCt4qLmVVj/yYhNnzAn4qAji3fPq8uJYmt74pchMFtJGl4hmvYMO5mWWeFBBRTM77l+V/zWVH3+aZXYi548Ub3CZd6w1IfRTyB7y5xnOQ1OzszLCrs3v6Cf2As7exOUhH51IaqTBI3OEK0satJuFhYupNHdCWQlaB1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781000877; c=relaxed/simple;
	bh=qqIJGaelpjCjAoGfpKtBIlbZrM/CcXnrhKiMbcgVp6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RxUDpw8Ev4/MEOSRmID6bpcRNHTrDbZPabzl4h+JNV73I8ZBcnLzRC6ZBirE2vhw06lggv2OT8NJhif0eDJoeZ1Yogg6B7Vvvawcx/Bd9t7Ct/vN9blYp6TRCAzQkA34Hh7YerI+Qadj6xtYDvAKBQdekBcr2G/OsquzOiaxAo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UCK3a2d4; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCK3a2d4"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490be29c1c5so68578195e9.2
        for <linux-iio@vger.kernel.org>; Tue, 09 Jun 2026 03:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781000874; x=1781605674; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zYkVB+VTXksJERZstjatMjWyHHCh3+OMcrv2hxaXb3w=;
        b=UCK3a2d45BEiUHWiBs0pToK0+MX3iqdWMs6gJUbeWPvakazzyrIoFGuIZKq+UXRh9M
         HSBMqHiUb37Ck14lxr6aEbWUunG4fz42FE2fZ5H8Tm5d4Kx1vFRlczYg7OE1dScOg0mJ
         UgJlGFUHRquk/VCxby3EG93PPjLl/66VqKtl/Vr9RZYcxeuUfWvoTBEuqM9XMjm6lEWr
         YT1z9fQ087hBmaD4ek3UNWJUYp4NaA64nZZEgdP3fJvdToY4rzV3q8XRctZFPnSRYlRB
         Fs/yBcXJYLlFothHMbhtLFXwpteU+tMbeTKmDfTBXEfKtHDU9LADUla6QXMMrIJcTEin
         hdZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781000874; x=1781605674;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zYkVB+VTXksJERZstjatMjWyHHCh3+OMcrv2hxaXb3w=;
        b=hi48e9i1An/m5CFpCblYbfGiGE6Ees9d+LBST1UU15HR5dZZlucQb2fUZuXf9Eqq3C
         aZminUhiy4FxrhhDy4KvDHnLbBnnAKN8RR2pcFXg1wQrHR2pdZG/eMLBFE+JUT8SWTRR
         dAOFdi4I1co8cTS1iZqw4YYYpzNymjL+dDadlAOqPLoA4a82lF+Xfssq6M/gkCu9nmFK
         N+SSHbsv1LOvYbvMTYxhEWhJtCkQMIArmhLaYt+55m6pt1iJd3m5XUTXLKb4AJndXmhv
         aL0L/LEmue/2G3ub2FVC3Jo56nfXYbOCr4G2smzSTpoTLZDZFgUwo3QxktWiLiPRYGlZ
         bx5g==
X-Forwarded-Encrypted: i=1; AFNElJ/8XyGN/9IrhHtLiUUqhtBJ3+TMWOMV8KbzMF5Dt87m/gfuc5tVB8Qy0cy4cCPRqmvp+rHozkmxgVo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpsA7oMdg1XaGgnDqzaXmIz+ApyhnBlQrOVthoeY2x6rNEOfh+
	B9txZg6VLmoGcRvYE8wH1362rPqitOfqkQjZz7lFnkZsiu19VEA+PFUd
X-Gm-Gg: Acq92OGBncSiF5LnReNBj3LQBqq7nj+EBWB+m/G51OwBNL/e5YEcSehv4YfiR4rCZvo
	Y3MgOXRe5BXwwrzcyrwvT0zOzFMJ+wYRNLmAm40WaiHXt1B8ewrAlQ051tyiwXj3ObVpOvDD/GU
	jLDB4xhkNLuCKbfu2ZT5WyMCThXEnVfUHav3STZ5jc0nb9+HLqXj9Y5v0gi3qnA8aRZOV69Yu9F
	I91x1jZP3HO+TtsS+Te7cEv/pO5ppc/792TGFbLa20pswEWozZo4UUu+84bwwDXZqDhQHVfQhXT
	Bk+9YjayUFSVP4o8WlRP+dKjLBq4+/rD6nF2zLn1FwAubHTMX4Mxp2DoJt6XT1SVc45gIoRg6VX
	SaD7bkLb7ct7r5o+huKDc7eJR3Gc0yVhEI5TASqqVk6lIcVlxaUfb4R2RfO/q394BJfB67eBMDP
	oMTjsF5ifEaJnDqYeEixRyXmHX9Xphq1ESMzIYV1gj
X-Received: by 2002:a05:600c:5248:b0:48f:d612:3c4a with SMTP id 5b1f17b1804b1-490c25604demr318499125e9.1.1781000873937;
        Tue, 09 Jun 2026 03:27:53 -0700 (PDT)
Received: from [192.168.37.44] ([217.61.173.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3cc140sm560788485e9.9.2026.06.09.03.27.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 03:27:53 -0700 (PDT)
Message-ID: <55020e69-ffe2-4d40-bdac-e6649693ebb7@gmail.com>
Date: Tue, 9 Jun 2026 12:27:52 +0200
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
Content-Language: en-US
From: Aldo Conte <aldocontelk@gmail.com>
In-Reply-To: <aie2Y96Oylb5EEtM@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

>> +static int __tcs3472_set_sampling_freq(struct tcs3472_data *data,
>> +				       int val, int val2)
>> +{
>> +	unsigned int atime_us;
>> +	unsigned int init_us = 2400;
>> +	u64 cycle_us;
>> +	s64 wait_us;
>> +	int wtime;
>> +	bool wlong = false;
>> +	u8 config;
>> +	int ret;
>> +
>> +	if (val < 0 || val2 < 0 || (val == 0 && val2 == 0))
>> +		return -EINVAL;
>> +
>> +	atime_us = (256 - data->atime) * 2400;
>> +	cycle_us = div64_u64(PSEC_PER_SEC,
>> +			     (u64)val * USEC_PER_SEC + val2);
> 
> I'm a bit puzzled why cycle has "us" suffix. We divide seconds by seconds...
Could it be ok if i place a comment here like:

	/*
	 * cycle_us = 1 / freq, expressed in microseconds.
	 * Numerator: 1 [s] = PSEC_PER_SEC [ps]
	 * Denominator: freq [Hz] * USEC_PER_SEC + val2 [µHz] = freq in [µHz]
	 * Result: ps / µHz = µs
	 */

> 
>> +
> 
> Unneeded blank line.

ok i will fix it.
>> +	/*
>> +	 * Wait state is needed: make sure WEN is active before programming
>> +	 * WTIME (and possibly WLONG).
>> +	 */
>> +	if (!(data->enable & TCS3472_ENABLE_WEN)) {
>> +		u8 enable = data->enable | TCS3472_ENABLE_WEN;
>> +
>> +		ret = i2c_smbus_write_byte_data(data->client, TCS3472_ENABLE,
>> +						enable);
>> +		if (ret)
>> +			return ret;
>> +
>> +		data->enable = enable;
>> +	}
>> +
>> +	wtime = 256 - DIV_ROUND_CLOSEST_ULL(wait_us, 2400);
>> +	if (wtime < 0) {
ok here i can write a comment:
		/*
		 * If wait_us is too high (so the requested frequency is too
		 * low), the resulting wait exceeds what WTIME can represent
		 * (max 614 ms without WLONG). Enable WLONG, whose step is 12x
		 * longer (28.8 ms instead of 2.4 ms), and recompute.
		 */

>> +		wlong = true;
>> +		wtime = 256 - DIV_ROUND_CLOSEST_ULL(wait_us, 28800);
>> +	}
>> +	wtime = clamp(wtime, 0, 255);
> 
> Seems like wtime calculation is not used in the below conditional.
> 
>> +	if (wlong != data->wlong) {
>> +		ret = i2c_smbus_read_byte_data(data->client, TCS3472_CONFIG);
>> +		if (ret < 0)
>> +			return ret;
>> +
>> +		config = ret;
>> +		if (wlong)
>> +			config |= TCS3472_CONFIG_WLONG;
>> +		else
>> +			config &= ~TCS3472_CONFIG_WLONG;
>> +
>> +		ret = i2c_smbus_write_byte_data(data->client, TCS3472_CONFIG,
>> +						config);
>> +		if (ret)
>> +			return ret;
>> +
>> +		data->wlong = wlong;
>> +	}
> 
> Not sure, but we can move the
> 
> 	wtime = clamp(wtime, 0, 255);
> 
> from the above to be here. It might also need a comment why wtime can be
> negative and why we move that to 0.

Ok for me to move clamp here. I would write another comment here to justify the 
clamp

	/*
	 * If the requested wait is so long that even WLONG cannot
	 * cover it, wtime may still be negative. Saturate to 0,
	 * which is the largest possible wait (256 * 28.8 ms = 7.37 s).
	 */
	wtime = clamp(wtime, 0, 255);
	ret = i2c_smbus_write_byte_data(data->client, TCS3472_WTIME, wtime);
	if (ret)
		return ret;

> 
>> +	ret = i2c_smbus_write_byte_data(data->client, TCS3472_WTIME, wtime);
>> +	if (ret)
>> +		return ret;
>> +
>> +	data->wtime = wtime;
>> +	data->target_freq_hz = val;
>> +	data->target_freq_uhz = val2;
>> +
>> +	return 0;
>> +}
> 
> ...
> 
>> +			if (val2 != (256 - i) * 2400)
> 
> The same is used to calculate atime_us above. Can this be a helper
> with a good name?

ok i could use
#define TCS3472_ATIME_TO_US(atime) (((256) - (atime)) * 2400)


>> +				continue;
> 


Moreover, I would like to take this opportunity to address the comments raised 
on Sashiko:

https://sashiko.dev/#/patchset/20260607112713.299968-1-aldocontelk%40gmail.com

I propose the following changes.

For the read and write event functions:

The read path would become:

case IIO_EV_INFO_PERIOD:
		period = tcs3472_cycle_time_us(data) *
			tcs3472_intr_pers[data->apers];
		*val = period / USEC_PER_SEC;
		*val2 = period % USEC_PER_SEC;
		return IIO_VAL_INT_PLUS_MICRO;

write becomes:

case IIO_EV_INFO_PERIOD:{
		unsigned int cycle_us;

		period = val * USEC_PER_SEC + val2;
		cycle_us = tcs3472_cycle_time_us(data);
		for (i = 1; i < ARRAY_SIZE(tcs3472_intr_pers) - 1; i++) {
			if (period <= cycle_us * tcs3472_intr_pers[i])
				break;
		}
		ret = i2c_smbus_write_byte_data(data->client, TCS3472_PERS, i);
		if (ret)
			return ret;

		data->apers = i;

		return 0;
	}


Regarding the oscillator tolerance, I suggest using:

tries = 500

Currently, it is set to 400, based on an 8-second interval divided into 20 ms 
steps. Considering a 20% margin, the total duration becomes approximately 9.8 
seconds, which corresponds to about 480 steps. Therefore, setting it to 500 
appears to be a reasonable and safe trade-off.
