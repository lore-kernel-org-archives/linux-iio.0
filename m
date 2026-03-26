Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A88A23370F
	for <linux-iio@vger.kernel.org>; Thu, 26 Mar 2026 13:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774530862; cv=none; b=G/IfPe73uv/eq5beVTXs+FmNTAMkeggIWu5O4JMVX5qLw1sNR5+VFJ6r//pluReY5i5Qc3BHoQmjrO4xO7FC9hzflN6KLmviqZJm/+Ow5o1K7n6I3l5gdSXCflDvwHsDHzfMAtTX8m55hU7rI+TfzJmyTk9ttmxYG2B6ioY0g5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774530862; c=relaxed/simple;
	bh=+VTp+wU3nXM1OykoWqN8bekqvW3I/jdUVo4B8m9cEP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kWPiziZXeusc6ewK/Ven8k3JqngRyCPQgauH7bsbHkDzlrYsE9IbIZm4HxPTpyRWd0jotOCJgqG1TAIxnZbY4wzXjSHx9fSHXBfnfT1k5azb5qYuH4x1B56mcxxhaDgczJ9jvGa8Ph3aCv5M+bAnO668NOyJ3aLxEgEFcl58J14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E4sNf99e; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E4sNf99e"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso8358265e9.1
        for <linux-iio@vger.kernel.org>; Thu, 26 Mar 2026 06:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774530859; x=1775135659; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QeHlsjOLnLqATT+czVIkNwVWsOUwxNz0XK5WP3S6vZk=;
        b=E4sNf99eX+yWrHd5PlU/0x4BoA8VNVj/SVFiW1XyW4hmhIolxPMwiBdUc//azXDex6
         WSCJkWxYrYCaQN8DJrlS5+Ja8LuI9BCMtWooJM7RUSUnxYKL95KxoTwC0cAbjB6Kl8mv
         m6IfbJNy3vSVvoRp0gTMkU3eyQn+7fmIvbjkG685tr/OIF0cFXweCDHuMn7sUIhjk7Zw
         cnJ7FW9VqB7eORyOKanyTTISsGReJ46/MMzlWFrANfR23yIl1Jpqzho6aaL1OSf7wMtP
         kN0qzDP8cReWtfrr46bK8A7IueLNlULBJrhPo74b2QtHEfY9x6jSIiaAS95dfkIs5gAK
         pYLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774530859; x=1775135659;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QeHlsjOLnLqATT+czVIkNwVWsOUwxNz0XK5WP3S6vZk=;
        b=sjRTMACBEqYLy1sqjSMB9YZdxBpLF/WzWhTRy/mh7wHhahVBsxssAzLabW1jN+jnM5
         Obh/QvBiRvr2ndJPC/WqoV0lMdlIsONqa1pmeI2MgfE4JNkOibm0IDtbMFeoNgho+yDC
         rQeYm1L8DC8vDXyKZCrDcSt0Mcq29UdoV9X0Ko/Nqj0qyH5dQxe4OQiURvcHmvhAfrwO
         6IjQscqTKpQ8jEGpq354J8bMYq9Z0Nh9HP7+OXeqR967EuOjMjtvuwEeXz4vD0K9Uf4/
         Lc1bKnl+apALgcOdeoroNg1UZ5wT5RODxzaGYziKm5jDeb6V9GqNIDzzL2QNiQtsgenk
         U9cQ==
X-Gm-Message-State: AOJu0Yy5oXqnxiJ1GckU/aABNcQmfwcSsN73nHEEB2az/6CdDy2aJu+k
	fOzkJ1sfHDwodUBpHGfxcY6lzZm4WdSn7JiFm9gF3UIFKx3FOrQ0cUUx
X-Gm-Gg: ATEYQzwJXiAzoYx6AJf6QCkEg04cWusc+Aajc22PJ2O1PP8Mis4n2CH4HjgoczutRjr
	4XEpEQM08gQiLlZhux5xRjxmGZgyKjrTzYxzxTarWc60aRMLpvkOHOGXv4PS8rN/syUJgQhtFG4
	wAHnvqhHdLPRvfRSYXXRu2L34xAfGA3ov4EX4HWdpFM5BW451bx+eCqcFO7FtNSB3i798bDqxVL
	GOQHUUofZTIgVoZ1HjRIQZ0NJq8i6LPICcHqycHQ6w3o7BNhzvI820+mnR2QWzSxwG6rEBQDszn
	vYrLp96Va2ozURKvA0i5hHXukuDEgoPHhTpt2FXrRvUX2ZedxZvziItAjYd3C86AQ1O2yOwkIXQ
	TBbPLDhTOf4Huf5yuZBOoR2+0oOSwZNWEWO2WnSUQGp/YGVueduiJOqOpGB7jAffZZ05PX3YC+3
	pvcrPnjEsVwiiV3TEnJ1rLYljNHGoS7g==
X-Received: by 2002:a05:600c:5296:b0:485:364e:934e with SMTP id 5b1f17b1804b1-4871605cec5mr119067215e9.21.1774530859296;
        Thu, 26 Mar 2026 06:14:19 -0700 (PDT)
Received: from [192.168.37.39] ([217.61.173.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722c65989sm57491545e9.2.2026.03.26.06.14.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 06:14:18 -0700 (PDT)
Message-ID: <9f81cdd6-7f20-45fe-a431-78d75016f7a0@gmail.com>
Date: Thu, 26 Mar 2026 14:14:16 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: light: veml6070: fix veml6070_read() return value
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
References: <20260325113216.170357-1-aldocontelk@gmail.com>
 <DHC96AXSNFEZ.121C1XIAZNAMZ@gmail.com>
Content-Language: en-US
From: Aldo Conte <aldocontelk@gmail.com>
In-Reply-To: <DHC96AXSNFEZ.121C1XIAZNAMZ@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/26/26 00:30, Javier Carrasco wrote:
> Hi Aldo,
> 
> On Wed Mar 25, 2026 at 10:32 PM AEDT, Aldo Conte wrote:
>> veml6070_read() computes the sensor value in ret but
>> returns 0 instead of the actual result. This causes
>> veml6070_read_raw() to always report 0.
>>
>> Return the computed value instead of 0.
>>
>> Running make W=1 returns no errors. I was unable
>> to test the patch because I do not have the hardware.
>> Found by code inspection.
>>
> 
> The fix is correct, but not the commit it addresses.
> This bug was introduced when the guard to handle the mutex was added.
> 
> It should be:
> 
> Fixes: fc38525135dd ("iio: light: veml6070: use guard to handle mutex")
> 
>> Fixes: bb18885ed823 ("iio: light: veml6070: add support for integration time")
>> Signed-off-by: Aldo Conte <aldocontelk@gmail.com>
>> ---
>>   drivers/iio/light/veml6070.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/iio/light/veml6070.c b/drivers/iio/light/veml6070.c
>> index 6d4483c85f30..74d7246e5225 100644
>> --- a/drivers/iio/light/veml6070.c
>> +++ b/drivers/iio/light/veml6070.c
>> @@ -134,9 +134,7 @@ static int veml6070_read(struct veml6070_data *data)
>>   	if (ret < 0)
>>   		return ret;
>>
>> -	ret = (msb << 8) | lsb;
>> -
>> -	return 0;
>> +	return (msb << 8) | lsb;
>>   }
>>
>>   static const struct iio_chan_spec veml6070_channels[] = {
> 
> Best regards,
> Javier
Hi Javier,Thank you for your correction.
I got the wrong result from the grep command.
Do I need to do a review, or is Jonathan's correction enough?

Thanks,
Aldo
