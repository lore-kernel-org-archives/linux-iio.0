Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B60364E96
	for <linux-iio@vger.kernel.org>; Sun, 26 Apr 2026 14:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777214266; cv=none; b=JA38JnuvIY6OHMJ0uUjO4xIoKgc2tTkM6ttUT0Bdwxf5G1EBw146agfKB12bX/5sNJPvRW3OlXIuFLqvqDjhVrWDxwsbXnd/kbtT1bYR2DPM/NZpASaGW1knnesqchUy2W2xCLyyJpW99rKsDd5zhHAkl4x0fNUwcVFpYD+sVZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777214266; c=relaxed/simple;
	bh=4SUHLOtLO3FU/TApyKWgmUzf04ijl1i5YWlnjxuN61g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DrIHuQklG92dTRtLhuSVYegBI7iX/X56zi/45CHzaZMcriIPtVIMvr8fUwRpPhqzUQladH9xSeqwgapXgFU1T2CUIVLq+GABr1mWniMhMMzUiyUltCxDbVvbpLJ0Qd8qJ7QrzBcQ5hxdC/5Vw31OvKTLDQF+xz10HOqXz2Fe5SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lZVq+HPq; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZVq+HPq"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43d6fbd0954so7276342f8f.1
        for <linux-iio@vger.kernel.org>; Sun, 26 Apr 2026 07:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777214263; x=1777819063; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P9AOkePbvjOV6bnIfPMABieZpHFoIVb5/KQNtDS2ZBo=;
        b=lZVq+HPqdOn+HmBCI/BpxpiXK7aqwoKD58ssJMeAXnqFSvFUp2Obe6lwXPk3Cl3Kgy
         vbmr64T60kUvjAOkjhAcFv3c3wzC+rODDYWNsyzkJtPx/B0zRKf9kvw3BAnXwdY6OEwG
         j1OxsrPWasjU2UmA8x6OFmbZ2ZaovemwxpwdAyIJrEBVPROFUqLTnCWpddG02reSJDpz
         JnXGB5Xq7Kz8yX0CN6SYJPC61RPZNHB0E5uzb52ztn1UMFGSK7IVcljrinRWtFICbKLo
         FkW7WxWx7aApzYVO17J6GeA8vDn8+yw163yHEJ700xVCOnBE9umFr9A2CHwmrQsMWdJB
         NO+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777214263; x=1777819063;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P9AOkePbvjOV6bnIfPMABieZpHFoIVb5/KQNtDS2ZBo=;
        b=oF1r4y7ureL1fKQfExf3eXsLJ+6MtdIjA+U3MSUQOBhO7lXKChqLLLeynlcBZDISKB
         9/45g6hCIDiabNLiOAIKqpILPQDVfTJKXdfZbDQXo5O8iZUwoxB9KhRO/Y/ASpxKfuYu
         auT1MgTTYBT9a/AbSMHJZ3UV1qqVvCrY7Ej19YgBZvlRp8JtT0rVH9eNt2CEJBsUuolS
         0WuWh8OHlwHLY+aW8O53X7RJ+fiCJmXeVnHyxVZxM78e2VHJ41x6hD/Iphx66vbnpffr
         KMQvRDJAP1647eHr7kQjtAoCE0W/etykuaFf6tJPoM8xC/CmTEZTclYEACv6sQybRibA
         DqRg==
X-Gm-Message-State: AOJu0YzW0O2hgsN3/A53kBJe06MnJCS9Xwi8Bk8qTgj8pLMGGrwLZfds
	XnzD+Mch/4K0d9URD0FMrJuvEfV1C0FKxqUVxJVnxxQEvhUWVjCZ9cvs
X-Gm-Gg: AeBDievq8qcKufMPrudKIDDYBmjpALv3V+sX/WAxLv8nFYRn6C1HpuDzZDiwIsyVcye
	HmrM8jL+IGcVLIGEAkiz5po0j1BHAYQlw6ThFJQYv+OXPrarS4144zHvVXve06di5X1T7gUPV9U
	zW7Hz985UyhGxQF9Jw6gGM76J3Y7mjMpWY8qpQ92O/0DG5P1HfMOl6wWO2FyW1OKX2p3oW+sa6d
	UwvqnDm/l99orbh+dg0v66CpAlzxiygxCDTwtmmgBeXf0dPypuLNY+5d+dRGDX1Kn3R6oAhPpfF
	GDSAmLmjb48w2s4dhQuyROjWwBLzpBbuGwQRi6ad4j/gv+MMAHTdnzhs5OsFJIPWClUQts91b9t
	xkj8C3uYm3zO8ciYxa7Nmo4tKDXAjJtWswP7VxDAXh9xDWWk6kEDa0+4szfIrqzpuW9c+ZGuVgq
	CgQK3TdEj5BHatqEeHHCkcygfuLM91Ec/iZUlBNlrwNyZ9+X/jF5W3g3C8aqI0j/GBO/O3M8HNB
	lbklENlv7/kwUFcxRA9
X-Received: by 2002:a05:6000:2dc4:b0:441:37b5:fc04 with SMTP id ffacd0b85a97d-44137b5fc4amr10274895f8f.14.1777214262741;
        Sun, 26 Apr 2026 07:37:42 -0700 (PDT)
Received: from ?IPV6:2a01:e11:5402:d840:f1ee:c5d:74e4:6e19? ([2a01:e11:5402:d840:f1ee:c5d:74e4:6e19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e4eec9sm69583072f8f.34.2026.04.26.07.37.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Apr 2026 07:37:42 -0700 (PDT)
Message-ID: <6604fd99-342f-4b3a-bf05-69ae425b4e4b@gmail.com>
Date: Sun, 26 Apr 2026 16:37:41 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] iio: light: tcs3472: implementing wait time TODO
To: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org
References: <73d2183e-dffe-4ae4-9312-c544e0079f3a@gmail.com>
 <46fd475f-8d54-4419-a195-d66c947fcc1b@baylibre.com>
 <3d4a4dbd-6618-4b63-ade1-d68155bac3ac@gmail.com>
 <4bff0c2c-f054-4098-a299-8030078f9b2c@baylibre.com>
 <20260426114823.2badc4ed@jic23-huawei>
Content-Language: en-US
From: Aldo Conte <aldocontelk@gmail.com>
In-Reply-To: <20260426114823.2badc4ed@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/26/26 12:48, Jonathan Cameron wrote:
> On Sat, 25 Apr 2026 18:11:23 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> On 4/25/26 2:00 PM, Aldo Conte wrote:
>>> On 4/25/26 18:49, David Lechner wrote:
>>>> On 4/25/26 11:28 AM, Aldo Conte wrote:
>>>>> Hi all,
>>>>>
>>>>> I'd like to resolve the wait time TODO in tcs3472.c.
>>>>
>>>> Do you actually have this hardware to test it?
>>>>
>>>> What is the application that needs to make use of this feature?
>>>>   
>>> I'm currently participating in the 2026 linux kernel mentorship program. I don't really have an application that would use this feature, but in any case, I have the hardware (Adafruit TCS34725 breakout board to test with a Raspberry Pi 3B) to test everything out.
>>
>> Do you have a logic analyzer or oscilloscope too? Having a tool like that
>> is important to be able to see that the timing of the signals on the hardware
>> are matching what we have requested.
On the logic analyzer: I do have one, so I can monitor the I2C
bus directly.
>>
>> I guess if not, there is the gpio-sloppy-logic-analyzer in the kernel. :-)
>> Real tools are of course much nicer.
>>
>>>
>>> As part of this experience, I'm focusing on “light” and, while looking through the TODO, i noticed this and wanted to explore it further.
>>>
>>>    
>>>>>
>>>>> The TCS3472 has a WTIME register and WEN bit that insert a low-power
>>>>
>>>> What about WLONG?
>>>>   
>>>>> wait state between RGBC cycles. The register is already defined in the driver but never used.
>>>>> I noticed that tsl2772.c enables wait with a fixed default and no
>>>>> userspace control. However, I think exposing the wait time to
>>>>> userspace would be more useful to tune the power/responsiveness tradeoff.
>>>>
>>>> I assume this would affect the effective sample rate?
>>> yes
>>>>   
>>>>>
>>>>> My plan would be to expose it via an ext_info attribute in
>>>>> microseconds, following the same convention as integration_time.
>>>>> Does that sound acceptable, or would you prefer a simpler approach
>>>>> with just a fixed default like tsl2772?
>>>>
>>>> So perhaps we could just use the standard sampling_frequency attribute?
>>>
>>> Just want to make sure I understand the sampling_frequency approach
>>> correctly before implementing.
>>>
>>> The total cycle time of the chip is:
>>>
>>>    cycle = wait_time + rgbc_init + integration_time
>>>          = (256 - WTIME) * 2.4ms + 2.4ms + (256 - ATIME) * 2.4ms
>>>
>>> So sampling_frequency = 1 / cycle.
>>>
>>> On a write, the driver would keep ATIME fixed (since the user
>>> controls it independently via integration_time) and solve for WTIME:
>>>
>>>    wait_time = (1 / requested_freq) - 2.4ms - atime_duration
>>>    WTIME = 256 - (wait_time / 2.4ms)
>>>
>>> For very low frequencies where the wait exceeds 614 ms, the driver
>>> would automatically enable WLONG in the CONFIG register to extend
>>> the step from 2.4 ms to 28.8 ms.
>>>
>>> But i wanto to clear my self this: changing integration_time would implicitly change
>>> the effective sampling_frequency since both contribute to the cycle
>>> time. Is that acceptable, or should the driver recalculate WTIME
>>> when ATIME changes to maintain the current sampling_frequency?
>>
>> This sounds like the right way to do it. It is normal for changing one
>> attribute to affect another attribute like this, so that is not a problem.
>>
>> Either way of handling WTIME is acceptable, but I think that recalculating
>> WTIME to keep as close as possible to requested_freq when ATIME changes is
>> more user-friendly.
> 
> Agreed - given it is fairly easy in this case the user friendly route is
> the way to go even though the approach of one ABI element modifying the
> value of another is allowed we don't need to use that flexibility much
> here except at the boundaries where say increasing integration time
> means we can't meet a previous sampling_frequency target and hence have
> to increase it.
okay, then I'll proceed this way
> 
>>
>>>    
>>>>>
>>>>> I also plan a following patch converting the driver to devm.
>>>>
>>>> Would be better to do this first before adding new features.
>>>>   
>>> ok i could bring it up in the series assuming instead that the WTIME new feature is actually wanted, since I don't have a real-world application.
>>
>> If it would require a custom attribute, I would say wait until we really
>> need it. But this sounds fairly straight-forward, so I would say go for it.
>> You never know who might want to make use of that feature. :-)
> 
> So if I follow this correctly it is only useful if some sort of continuous sampling
> is going on. E.g. events?  If so that's fine as I assume it trades off
> power usage against responsiveness to light level changes and that's a reasonable
> thing to want to control.
> 
On continuous sampling: yes, the driver currently operates in
continuous mode (PON=1, AEN=1) and the chip cycles autonomously
through RGBC conversions back-to-back. The wait state inserts a
low-power pause between cycles, trading responsiveness for power
savings. This is relevant both for polled reads and for threshold
event monitoring.

I can verify the effect with the logic analyzer by capturing the
I2C traffic during triggered buffer reads


I'll start with the devm conversion and follow up with the
sampling_frequency implementation.

Is it ok to make a patch series?
>>
>>>>>
>>>>> Thanks,
>>>>> Aldo
>>>>>   
>>>>   
>>>    
>>
> 

