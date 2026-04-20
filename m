Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273F8374E76
	for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 14:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776694377; cv=none; b=b0NY9vzwLWdWFKjZBZqLvPjdjbuqbEie4Q7DZmTA7bltV7fJmkWZo8oYkHZXhTOBwiniMUHSSeCTbZ9NM6v3SD5n2/lcBmzOcEBZngkxFO5vBxSlrrDBXoizmYsXrzodEOgvvHq5G/EsqnMb7wG/oeA0UcXIwD/SiFH4V/ZQXWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776694377; c=relaxed/simple;
	bh=gyioDOi/MGs7/MZDz6sB63fpTbPx4GQ1agJPTCyc9Oc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MgLKU0vbcWO+mh5aoiw8AXq5+O6fRr8Mavm4zpM5bFkKmRthr6M0YL3OkioXDfgBBi5/WlciPwHl9EnKZBKNMfdFivuxwh95qNYt6v1Gn/ZTLvIsNeH3yykIGjObmBIzEOc61+7xjJfFFZrMi+EI3XhhNFFAxuhmmaKzEd8cD1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=UX8grf6U; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="UX8grf6U"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2b6b0500e06so5301078eec.1
        for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 07:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776694374; x=1777299174; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VnLZqK7T0GhUQj12DuUAyNp6Ho+q8j+w1O6bIDzPUYY=;
        b=UX8grf6Ua4lM1XPJGkE71ks6t8UcoK8A1D8FGBMXEJu7I5tBjvCKSjXhtApv9FU6zJ
         lmBf77Z7OwugvlaGTNYSjT36nxFIiSGKSUs6HvHynCqRdnoRXG178xEW5TrnBTATOCw6
         klGj4Of/wudq+lhjv+5TwmGnQDeMrytICk5Fk4JveF/c/dqvEIWC00eob+YqbBRdIhmB
         o38ynYOzO1ZIFOVUYrjmbiqY8KXQ1P/yUeCjbt34Hk+l5yelmUo3yTtCKnu6n9mK7S0o
         R9XSS4A3o/QwujN8wVHRnRjn/eNoksvqSDpETF/SVrK4EeADcCQCu2atIPtRemJCEoSt
         9NCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776694374; x=1777299174;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VnLZqK7T0GhUQj12DuUAyNp6Ho+q8j+w1O6bIDzPUYY=;
        b=AyJQRJk/qzRsU8GtgwnuHHJjgl0BMxR5eY6Nb4AHumFIpSQaIJTylYRmLEwwQCj/6P
         weaAQOTOOEwObCzIKvdoCFPT+HqpHQi4vKwgGy1dTil5YTIvP3d+UQ1wkNAniZH/H6Xc
         WgdlA8Tj9fou/aXImAUbioNeLHnbM7rh5BZXnMCK6Pko9qp29bXCVwlVWv7RfgSw2D86
         izBU2qpdw/fFXekCCWZt1yGr5hnHe+AxMxV0qvPUNGAJPnn17irS0hNLivnKhXFPSKx7
         Ohjl9vxFT3kqnE7ELGCkPvQhkmKUWLSC+/CUM5JLxgRyefW8Fc3YqmI2mAg8mUF0x10l
         yMgQ==
X-Forwarded-Encrypted: i=1; AFNElJ954ooPZbgZL/6RwRF384P/qk3EQK/EEl/4tT/OSKruRHZzOrtPQXm05oWvjT2nnZfNCBADiXZ1pok=@vger.kernel.org
X-Gm-Message-State: AOJu0YxycsMR1wM8dkpBuo7LrWgFKa5L6hFmEbt0fnhLrEGJziVdye91
	Xp8//TfQAnAPGrCDFYCMnLG9onmvHwrYrYCaqM3tZ4lZGG8rdNMuOrIM7PUees55uzw=
X-Gm-Gg: AeBDiev3Qvm+yWF3Xi9mYNOpKISisuMqZRGUMSD5YXmJtL3uJSUPyVLydIMU9NxKy3K
	VVkpl6nYlHBZ2473Ctj10bMRXCKSLS9wbwP8LF8ZTIF4Y3rDVFlLX0hLH+rU9CBqqb43ptecvWY
	YE8/tujtEfPStrWnvGHt5zWsCl2VgLExYr1cg4rUBFZntY5y1RN7nlkKTg31pTJhjR6baUrm7Gj
	peU+PtKQNlCH3iWh73TEoothA+OYrHd19xuGFhFjarOZmxIQq9lJYsVGyxvbcgtDDgAjHdsvoGl
	AA2UM3fwBToKP1/+D5U0np4VHm0pVid5RAB6iQV8UjD1HANxWntCsg8WY5iE6p79FmzIqWRfU3M
	4YvtTFqtB7HeEtQCRNLkUaB/d5cTv1DTkIsD9sJA08oZGlnhbJuNjC/BM9EekPH3ZGUmn5wVnS/
	VvTC81AeTgS4hLoFhNoBJan09A61RRe9IG8rkLxizhMMMj4HDYwOxFXQvpC1CVqUTcheJ9pVeJK
	APpDNqAY2H3UsVA/WaI/QTfZVs2dDG6J1gB
X-Received: by 2002:a05:693c:2b08:b0:2d3:2983:c87c with SMTP id 5a478bee46e88-2e464ea4f80mr7305990eec.1.1776694374038;
        Mon, 20 Apr 2026 07:12:54 -0700 (PDT)
Received: from ?IPV6:2804:14c:4c:af50:c408:26e5:33b0:662b? ([2804:14c:4c:af50:c408:26e5:33b0:662b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e536e54562sm14379391eec.0.2026.04.20.07.12.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 07:12:53 -0700 (PDT)
Message-ID: <6141931d-c805-4f3b-9c3e-117457d7157e@usp.br>
Date: Mon, 20 Apr 2026 11:12:49 -0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: temperature: mlx90614: use guard(mutex) for EEPROM
 access locking
Content-Language: en-US
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: cmo@melexis.com, jic23@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org
References: <20260418205151.172046-1-luizmugnaini@usp.br>
 <aeXc8o94OiDRFy0b@ashevche-desk.local>
From: Luiz Mugnaini <luizmugnaini@usp.br>
In-Reply-To: <aeXc8o94OiDRFy0b@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andy,

Thanks for the feedback.

Addressing your points, the extended scope only adds mlx90614_power_put(),
which calls pm_runtime_put_autosuspend() - a non-blocking and non-locking
operation, posing no dead-lock risks. However, I do understand the raised
concerns and I think it would be better to use a scoped_guard() to preserve
the semantics of the original code. I'll be changing that soon in a v2.

Best Regards,
Luiz

On 20/04/2026 04:59, Andy Shevchenko wrote:
> On Sat, Apr 18, 2026 at 05:51:36PM -0300, Luiz Mugnaini wrote:
>
>> Replace mutex_lock()/mutex_unlock() pairs with guard(mutex) from
>> cleanup.h for cleaner and safer mutex handling. The lock protects
>> EEPROM access across five call sites in mlx90614_read_raw(),
>> mlx90614_write_raw(), and mlx90614_sleep().
>>
>> In all cases, the code between mutex_unlock() and the end of scope
>> is either trivial computation, a return statement, or a call to
>> mlx90614_power_put() (which only schedules a deferred autosuspend
>> via pm_runtime_put_autosuspend()). The slightly extended lock scope
>> is negligible compared to the existing hold times, which include
>> EEPROM write cycles with 40ms sleeps.
> ...
>
>> -		mutex_lock(&data->lock);
>> +		guard(mutex)(&data->lock);
>>   		ret = i2c_smbus_read_word_data(data->client,
>>   					       chip_info->op_eeprom_emissivity);
>> -		mutex_unlock(&data->lock);
>>   		mlx90614_power_put(data);
> How do you sure that the code:
> - is not slowed down due to unneeded things in the critical section
> - doesn't introduce no deadlocks
> ?
>
> How did you test this, please?
>
