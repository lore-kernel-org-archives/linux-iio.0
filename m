Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D34025C818
	for <linux-iio@vger.kernel.org>; Sun, 30 Aug 2026 09:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788082340; cv=none; b=Y+KzKBC27Nmp/T7t5gZn1Rv7oLOhAZP2/5vI3DSssyn92JrZRtMMOwHSOtJseV+PEqX0ck3LK/wkqtnZWYfiI65feo2JYADbcNSRAju7jCm1U7ZPaVshGcRRhza/hRaeokRQisgNBeH1znBjEoPdSWrATjxZthiNomIJpk+nnnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788082340; c=relaxed/simple;
	bh=dLTflUZhWO3k4/Rm9ZG0yWNmYzlAYv2sf6OvtYCp+v4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hTegTSXfjIcSaSOb56ZaRRSXzoFuB3Wmo/s/6ozvBspyRUrHrCxjrqSd7nI2YjbyzQ3cuFRHfEaSDel5Q5pyG/kzPs6cLjz/RDdcVcyfzXJQX9bNEVAMXHePTifWM6iNonJYuKipTIiUYYQiGsCJ92aQqhh1rrjDRKRIq/k/wzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q6jjHk5t; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q6jjHk5t"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5b5e18f0439so1971058e87.2
        for <linux-iio@vger.kernel.org>; Sun, 30 Aug 2026 02:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788082337; x=1788687137; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+ZJhRwyLAW0jsfUB61doEJc+nQrzQWlaMJNzh2taQBY=;
        b=q6jjHk5tjBi2KfNZiphxGu4V+MHzvp2OA4cMZPn6mxe9NHLhBuXIAVPrY3wOoY2BGj
         Eno+5z0BTjnkl+oNx5IWzzpUccjOqQT9VLDraWFwDxDv3JWoWsyLva7RYaMhNkazunWC
         SnO3x+Gt9HbaYgg+UQTjkUYfSmriXvli0alVElQcmzXfKarStxL1/Dx5W7JdbCqbb0li
         Lbwv7HYkWWFBgDxcGfyKcfPr0ftM5nvDyRpnHWcffPmM7T4RVC6EOX0yM0bHLAbRe8Tk
         Bu+TfZ8sAlRGV3uLT9ZrKViTmRD3ise4UqTSfq3q1dPu+fxYRBaZ3T1HHpI/pKM5TngZ
         2jrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788082337; x=1788687137;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+ZJhRwyLAW0jsfUB61doEJc+nQrzQWlaMJNzh2taQBY=;
        b=QK/tTrc/a1Pr8PZSIsWSw8rVP1Hx/j9y7EnHgvHIIio/i4ykW+ZXjylFU8Byruf1lJ
         78XRnT8yu8y13NJtHb8pv480J0vIJyt/yFDbo092LX8AsVvvRhfWV8wJt3FEqdTeZz/m
         NjpSjbO0YT9uPpB47XYTTATgBgcUbr/fF9lWubsAJjDk8ow7m/dhezh+ZrP+F1IkcFv2
         v06Hudjpa2NxhLLFoG+fAFhJLQ4sMmUp4aeUkBtx8z7pyU9NP2umfBxVXjYVbGRSfoni
         A++9fjah3sO7ynaawxZMdMsRjw/7IvY648KenGeIIArlMEaimnqWvyYjGUlOLtrM9RfA
         WWTg==
X-Forwarded-Encrypted: i=1; AKwUvBxSrIsnwd2Dtjs3wnoICQEPf/8VksZBoFfa332KJkxgT+VsL3ut4W2TO12VMgglJMTVSRhMDtl3eRQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kDo8VLTUTM1hxQjXu/MWq9VX0+ChZKtBOj+PuUXshn/qacrdwP
	jjdjzkvi/CehyNMzLYD4NSmDRK3davUQciQKWoDwH+hKFL179ijE8Oi7SzCPaow9
X-Gm-Gg: AYBFou0ldUHj4vm5iZQUXbTpFNO4wFEE4Hc2DAQVnDTt5vfdYxuGBb/wDOBz0FSZDId
	Y4ne4mkKvCErEEoJTt7w2VLWy3rOEhd/8LhBAbRmLvhQNp+eUTbVOQLtBFHiDz5xMM7SRyUppX2
	cmNPlSa7EvExMEu7KmvXSuESCCduy7NEQuBrR5FPQrPyJFeZbi06lkRMOSXGHLqS9Lpcvnlgi5F
	raurdfxyGvL5QV9aeLrkStTiPiQXaha601lieZoYXJ/Cm8N/VBlGDl2uA+gsWpeIjT+C2ruvEpk
	ye2nJVVmXd1xKWiovo18GKa1iFeKI8NT7GMngzGChEyHk5xxFDlvwqA45arKMp9PnnYFvv2xp88
	HfMxHAvpvapGzA9L5RGKKSCHolAyIwkh/38nwUu5XL2aEia1N6IqijNbZbLvRSwqAxm1GqETrqU
	X2Uxftg1T2iM1XGSIF6Hia5Yrpwf9todJWqf9JSO8a6dZHBs+y8FMn2kIDkCo9uODGSitgJg7L6
	oWgf+QMelbBY+3WdlmiM6XmewKr4+A9iYlbhD6+KL6s
X-Received: by 2002:a05:6512:3d8e:b0:5b2:9f7a:29aa with SMTP id 2adb3069b0e04-5b5e68489ffmr5726157e87.0.1788082336658;
        Sun, 30 Aug 2026 02:32:16 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b5e89d60ddsm1513610e87.31.2026.08.30.02.32.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Aug 2026 02:32:16 -0700 (PDT)
Message-ID: <0d808de2-090b-4a7a-8f72-2cb657406ee3@gmail.com>
Date: Sun, 30 Aug 2026 12:32:13 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] iio: light: rohm-bu27034: Fix infinite delay on
 error
To: Jonathan Cameron <jic23@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Matti Vaittinen <matti.vaittinen@linux.dev>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Mehdi Djait <mehdi.djait.k@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1787901813.git.mazziesaccount@gmail.com>
 <7f0d8efb3578cd4f23a7c70fa4a8f7a967c9df8e.1787901813.git.mazziesaccount@gmail.com>
 <apE-gauHWlJO8-5X@ashevche-desk.local>
 <5d274bfb-2570-4336-af16-60640550e6c9@gmail.com>
 <apFqmjGZKQ-qW7L7@ashevche-desk.local> <20260830021626.025397c8@jic23-huawei>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20260830021626.025397c8@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/08/2026 04:16, Jonathan Cameron wrote:
> On Fri, 28 Aug 2026 14:01:46 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> 
>> On Fri, Aug 28, 2026 at 12:46:24PM +0300, Matti Vaittinen wrote:
>>> On 28/08/2026 10:53, Andy Shevchenko wrote:
>>>> On Fri, Aug 28, 2026 at 10:40:36AM +0300, Matti Vaittinen wrote:
>>
>>
>> ...
>>
>>>>>    	wait_ms = bu27034_get_int_time(data);
>>>>> +
>>>>> +	/*
>>>>> +	 * If reading the integration time fails, default to the minimum so we
>>>>> +	 * don't lose samples. This may waste CPU cycles, but as a hardening
>>>>> +	 * against theoretical, once-in-a-blue-moon error, this should be Ok.
>>>>> +	 */
>>>>> +	if (wait_ms < 0)
>>>>> +		wait_ms = BU27034_INT_TIME_US_MIN;
>>>>> +
>>>>>    	wait_ms /= 1000;
>>>>
>>>> With the above being open coded the _ms feels not right.
>>>> I would expect the TIME_MIN to be in MS from the start
>>>> (and for the consistency's sake with the below) and having
>>>> all this to be written like
>>>>
>>>> 	ret = bu27034_get_int_time(data);
>>>> 	if (ret < 0)
>>>> 		wait_ms = _MS_MIN;
>>>> 	else
>>>> 		wait_ms = ret / USEC_PER_MSEC;
>>>>    
>>>>>    	wait_ms -= BU27034_MEAS_WAIT_PREMATURE_MS;
>>>
>>> I don't like using 'ret' there.
>>>
>>> At first glance, the
>>> ret = bu27034_get_int_time(data);
>>>
>>> looks like ret is containing just the success status. Furthermore,
>>>> 		wait_ms = ret / USEC_PER_MSEC;
>>>
>>> forces one to go back and see WTF the 'ret' is (even if just couple of lines
>>> - but this is not an improvement, using ret is obfuscation).
>>>
>>> I could change this to:
>>
>> I suggested without knowing the possible ranges of the returned value.
>>
>>> wait_ms = bu27034_get_int_time(data) / USEC_PER_MSEC;
>>> if (wait_ms < BU27034_INT_TIME_MIN_MS)
>>>                  wait_ms = BU27034_INT_TIME_MIN_MS;
>>
>> This looks sane to me and  removes the confusion I was talking about.
> 
> Except that wait_ms can be negative due to a read error and that is obscure
> by what now looks like
> 	wait_ms = max(wait_ms, BU27034_INT_TIME_MIN_MS);
> so ensuring we clamp an out of range value.

Which, in this case, is perfectly fine because it does not matter what 
the cause of the failure is. There is no need to distinguish between 
read error and 'returned value is below the minimum time' - in both 
cases we just use the minimum time.

> I'd just go a touch further and split return value and parameter
> + provide a default.
> 
> wait_us = BU27034_INT_TIME_US;
> ret = bu27034_get_int_time(data, &wait_us);
> if (ret)
> 	dev_warn(dev, "Failed to read int time, muddling on\n");
I do both agree and disagree. This is not the first time when I am 
pondering if a "getter API" should only return an error, and fill the 
desired output in location pointed by a parameter (your suggestion here).

In many cases it is simpler in the calling site to just use the return 
value, and error handling can still be reliably done when all legitimate 
values are positive (in this case, also greater than minimum). Using the 
pointer argument for value retrieval typically brings potential issues 
with value initialization if call is unsuccessful.

Hence, I am often using this "dual meaning" for return value (negative 
error code or positive valid value) in cases, where all successful 
values are guaranteed to be positive.

I would definitely favour your suggested signature if retrieved value 
could be negative, or was a pointer. I have never liked the IS_ERR() and 
others - but check:
if "value < allowed minimum" and decision "then, something is wrong - 
use default" is really quite clear to me.

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
