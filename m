Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE5438F230
	for <linux-iio@vger.kernel.org>; Sat, 25 Apr 2026 23:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777158691; cv=none; b=EikrJjlGVuz7Fp5cdu+I7/8OO6kTPDMgEppuoW1O7SrjQEl0qLLyJ9kkiLFuwwi2wBYc6VVcv3GmxXM3wCd0p0iNFDLdwbmcuzm2ydTbjZw1wq/4Zta7RaK1BTIbtkMRLzXHNpYWbh1/27XtZOof49JP2pyrX+oGQza6nFif5v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777158691; c=relaxed/simple;
	bh=lXssuL8qz8Hz+i5kmh0Ga49CuTfUgFcHpK3Y/EhsG6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cNiymECQPo4A+SjVYqpCj+qP6oqU+6XehqmZOIcC0qppFXo7ce9zxQCKLuueFaBmpRi9sq+LeRGaul0Deo09BA03memPffvTugK9a5647WmVPQEjJiexbV49QSDEmBBWk1sJ8VAtUPmCsQ0Mb7cs9+lxW5U7LkZQR6H3Skvufn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=ix2YRe0z; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="ix2YRe0z"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-679f6ee3fb0so3493962eaf.2
        for <linux-iio@vger.kernel.org>; Sat, 25 Apr 2026 16:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777158687; x=1777763487; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HLoVtfXt1b6hzE4Pd3n4uhiQyu5nmeqninA+RmR05OY=;
        b=ix2YRe0ztpveTCOwNwXvGP3cUXdvJ7UMZLf5x64kNJhDuJAK27bM/7EwMcDTEmvSgI
         y9ai93TtBdaxCWYDAajoMPJgb6llUj0Eh4kVnUxi5KwvPLXjvH5AyzC/CaOVlbgXY1DW
         /z9N1k15ptp6TFgDlybUCysd5QCOkVbMZcFr3sXQfnrH/ZyivdKe2+mOj7Kbn29d6W7n
         XvLY+GePec/ZOQBdKCurQDrXOOsD3uB5Kt/7E4LxaWg0EzirqmV/Tr95diLLR7s/UASY
         fH2mWUxGCTSlFcEs4PmL0hyQ2IpatP09rl+kbuKV4T6f9pJYqqDwK3CbPrghnYh6OnVs
         /joQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777158687; x=1777763487;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HLoVtfXt1b6hzE4Pd3n4uhiQyu5nmeqninA+RmR05OY=;
        b=oF5rJ+oR+6CWbm2Nsj57ewalqxBDiV/1SJiAkg3hgvh/+yr8/9wnV+aB5K+kDZ/Idb
         oBFnXVfXH15LmbusaQ/Vj9VHFnHwS+agtlmY1la9cpcojOpBnE4hQEWkgJg1dSLwUpAj
         AcYfp8HLftSUALDjhLb2DkgW5XMlJGfEXiqkdgEXCITu/1UGa0NyqbjCccrAayT7+Pld
         VRQxg/hBriUyxPJKjOl3FTWye7H3QU/8W2ltPshKGOGfxX20zoNRyoqj8uS/OzDSsnLz
         2KVWSSjFb4Ou7Sxj6Gdn75Q5Fif3jubb1G/CEfgvaNXMOa7CwrpJSSCcWaeZGr0Ytzfc
         Vm4Q==
X-Forwarded-Encrypted: i=1; AFNElJ/JH8Ng35wVtWip8nlZTyc+K3Wbc5KrVX21fGTZedxwn06U33bxmdQ2X7dwiyhHiGhoSTpNm+3USDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkxG+XoE8QRsAFiJA9y9UPpUAJukcO7lc0vfl71awkvvjAjKPQ
	+6O7znRXvBYvWeGeZRq+MA2hYVGGLbuKxyP54VB2MM6cJhTryDueAzwW6Vsja6kQcyA=
X-Gm-Gg: AeBDievMxpydJi6U4aXiX2ShI5NQHTsl2M00fmFuQrd1d187IE1NGk5soSOsu6xL3GZ
	PcgOamdnNFMfxlaZamDbzEQMAj2TzrVBrDyIltdur5lBMZoP01a/W9X+lJd1Y7mgXlFexXPxFYD
	lfZBDm8K7Ft//H0hGlztsK33BPl9K6P0vAsFxnoRNVD12hIpETBxcco4XW9SZeAc2NaCB+RQYgo
	dNr4N9F8QztHAiccDkGMVBKqLM7Frk26cHkcTn3aABKoJbNqj5S0ObO2K0VxN6wGN75XHblvJbr
	cz/M4SWzhmpkSSK6G8Y3GGdELYB87e/m5vCihdfEkdkrGu5QEdOC/SS6f0pwCHRtihezgDnvqpF
	2PVl2eI0H7oQIlPIZNeK+olkVBYVmzUix1/L5udMJYfJ4KW/m7rpO78azmQyKAguR8gd7XZQma2
	WdDZZP+JvokUS1+zFKwyncMHq6vc05zlyL2EVFotFbKdWcAHcAs8Sx52+4iFuuG+CE4Sb8INEEJ
	+AHIztmEFsV
X-Received: by 2002:a05:6820:3089:b0:696:1ef9:e08d with SMTP id 006d021491bc7-6961ef9e4d0mr6674776eaf.25.1777158686798;
        Sat, 25 Apr 2026 16:11:26 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:81f8:ef7d:a711:d99a? ([2600:8803:e7e4:500:81f8:ef7d:a711:d99a])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-42fae7ee3a5sm14640500fac.7.2026.04.25.16.11.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Apr 2026 16:11:25 -0700 (PDT)
Message-ID: <4bff0c2c-f054-4098-a299-8030078f9b2c@baylibre.com>
Date: Sat, 25 Apr 2026 18:11:23 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] iio: light: tcs3472: implementing wait time TODO
To: Aldo Conte <aldocontelk@gmail.com>, linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-kernel@vger.kernel.org
References: <73d2183e-dffe-4ae4-9312-c544e0079f3a@gmail.com>
 <46fd475f-8d54-4419-a195-d66c947fcc1b@baylibre.com>
 <3d4a4dbd-6618-4b63-ade1-d68155bac3ac@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <3d4a4dbd-6618-4b63-ade1-d68155bac3ac@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/25/26 2:00 PM, Aldo Conte wrote:
> On 4/25/26 18:49, David Lechner wrote:
>> On 4/25/26 11:28 AM, Aldo Conte wrote:
>>> Hi all,
>>>
>>> I'd like to resolve the wait time TODO in tcs3472.c.
>>
>> Do you actually have this hardware to test it?
>>
>> What is the application that needs to make use of this feature?
>>
> I'm currently participating in the 2026 linux kernel mentorship program. I don't really have an application that would use this feature, but in any case, I have the hardware (Adafruit TCS34725 breakout board to test with a Raspberry Pi 3B) to test everything out.

Do you have a logic analyzer or oscilloscope too? Having a tool like that
is important to be able to see that the timing of the signals on the hardware
are matching what we have requested.

I guess if not, there is the gpio-sloppy-logic-analyzer in the kernel. :-)
Real tools are of course much nicer.

> 
> As part of this experience, I'm focusing on “light” and, while looking through the TODO, i noticed this and wanted to explore it further.
> 
> 
>>>
>>> The TCS3472 has a WTIME register and WEN bit that insert a low-power
>>
>> What about WLONG?
>>
>>> wait state between RGBC cycles. The register is already defined in the driver but never used.
>>> I noticed that tsl2772.c enables wait with a fixed default and no
>>> userspace control. However, I think exposing the wait time to
>>> userspace would be more useful to tune the power/responsiveness tradeoff.
>>
>> I assume this would affect the effective sample rate?
> yes
>>
>>>
>>> My plan would be to expose it via an ext_info attribute in
>>> microseconds, following the same convention as integration_time.
>>> Does that sound acceptable, or would you prefer a simpler approach
>>> with just a fixed default like tsl2772?
>>
>> So perhaps we could just use the standard sampling_frequency attribute?
> 
> Just want to make sure I understand the sampling_frequency approach
> correctly before implementing.
> 
> The total cycle time of the chip is:
> 
>   cycle = wait_time + rgbc_init + integration_time
>         = (256 - WTIME) * 2.4ms + 2.4ms + (256 - ATIME) * 2.4ms
> 
> So sampling_frequency = 1 / cycle.
> 
> On a write, the driver would keep ATIME fixed (since the user
> controls it independently via integration_time) and solve for WTIME:
> 
>   wait_time = (1 / requested_freq) - 2.4ms - atime_duration
>   WTIME = 256 - (wait_time / 2.4ms)
> 
> For very low frequencies where the wait exceeds 614 ms, the driver
> would automatically enable WLONG in the CONFIG register to extend
> the step from 2.4 ms to 28.8 ms.
> 
> But i wanto to clear my self this: changing integration_time would implicitly change
> the effective sampling_frequency since both contribute to the cycle
> time. Is that acceptable, or should the driver recalculate WTIME
> when ATIME changes to maintain the current sampling_frequency?

This sounds like the right way to do it. It is normal for changing one
attribute to affect another attribute like this, so that is not a problem.

Either way of handling WTIME is acceptable, but I think that recalculating
WTIME to keep as close as possible to requested_freq when ATIME changes is
more user-friendly.

> 
>>>
>>> I also plan a following patch converting the driver to devm.
>>
>> Would be better to do this first before adding new features.
>>
> ok i could bring it up in the series assuming instead that the WTIME new feature is actually wanted, since I don't have a real-world application.

If it would require a custom attribute, I would say wait until we really
need it. But this sounds fairly straight-forward, so I would say go for it.
You never know who might want to make use of that feature. :-)

>>>
>>> Thanks,
>>> Aldo
>>>
>>
> 

