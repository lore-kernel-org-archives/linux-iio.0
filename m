Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E950A3BD65D
	for <linux-iio@vger.kernel.org>; Thu, 26 Mar 2026 09:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774518743; cv=none; b=R4CHlohBT6BLUQ0sc+kLevGeH3LOL52lETBzsY1u8jQ6C2uROaaWPQhPwaHMYi5qFBJzc/z9xJZ5QZhcYTkL2NNxBh9RXMbyvzxPXbI0etBgrpu157lxLIAyB0E8WAACYDx3ZQT1JqI7Eoto9hwAxfVGW/jGPL5tVZhdkJlri1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774518743; c=relaxed/simple;
	bh=/Wx4/th9eroI+5T/avmA0O0Rzzr3gFsAtiNU6dF+G0A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E+pedFNkurUHStJUh9OWhFE9GtOjCA8B1QcsOdRMTAYDNG6oBrAUFl0W5hFITaBLP2UlfKMLD3xC19scdGFGyLPwqkh+0Qph9iIqzVj/QKVJjiSWhh8c5oSzFwFTp2aDYWtZW34Fb7dfrqceYzyy+C7XtX3E4C4SmAX6GUYp6hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mNJGoJJU; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mNJGoJJU"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-439cd6b09f8so448935f8f.3
        for <linux-iio@vger.kernel.org>; Thu, 26 Mar 2026 02:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774518736; x=1775123536; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jXIrK0lncZRt+rDfxL6N5gVrlkeKZ+ri6Im1Y+U/Z6w=;
        b=mNJGoJJUIYlNqGWWJzul8LlXHhLfkhtvUStdwgu9yzhym2B/NAtcUJciU1L/4rD5Lq
         orG7/fR89QsSPlLkTMcZ/EsNDu+41LyMZGlC46tVw4K9C00Fv1IraUrVc5mJpmM8AQhK
         bevYbSqN9x7+MYY8rkSeDJhBiBUgfxQKaCWu+z/ijvfvE5zVdRAMx5yDqpi62RZmjCG2
         Bp2PkZK342CcKZRSJMUzUjd2AH5XIBTOoWWZej8VlWhRHQOAnxRK4nle1ArGALg9XR2w
         8g5ugIPCdECrI86uSB+1HktycsVMNFMjOLcXAa0FZOvMZbpMhAHgWJ1Ii5Gt0ugZfuwr
         qXAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774518736; x=1775123536;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jXIrK0lncZRt+rDfxL6N5gVrlkeKZ+ri6Im1Y+U/Z6w=;
        b=g8lbu2K6GXRuRSzdiBJvhKNwKNBNNwP1E/Dsre5GZFDmYoUNnkkfvd8A6RlPmDoMNk
         JKLAc8UA11WXd+L5ODcMHZB1I25RsmT4KCygFoScIj/iN6jmczDkEIwrE2djmnrqAJbB
         05VMFrMy2ztZNE01GgeOKRVruBohUb/gccknyTNCzZC+nnnE5c4eHdnRnQQHzv8+XW0U
         Hr/0VxFEEJIusWHur+XLfJaP20heM5cZ+e3ERRJi8ucW0hOU5aBiTAybiosakjCKdlDR
         8QbDuow5rer2yqHOim7txmKImESyuGnYYbmEnQJDr73cNCOUiHK8Y/C7CadXAmdRkkqg
         hbXQ==
X-Gm-Message-State: AOJu0YxT2m1YrTNXSm6KK+nervxO1juF9Ycfij4Hwdwtgk+sk80oNvsO
	TfoE7vEMbUx7kPN00ok8V77QLaAMSQcuJMw0EWF9HiGaKKZyjjdcfFne
X-Gm-Gg: ATEYQzy0OyXxU58g/3C27Dr2+YYw72b2zlChdXunJhE05N6vMp9+hDaIo48o6GEZApq
	3jLu2DWcIWUvZmzzdrnpRZdoviiN/vAjsRXqhJjsEBASv0T80WDkuyj89LKuZwQ1Vs7OVicmH2E
	lMKLjJ4XWrWlMyJVoxMdRpiZcXMR8foNA0qXIg+hQtYsOcxHRyg30D8h3LCU0CaQwj4PJMA0hVM
	XZUf5GU4KSgUUK0+RCUVNoNX90xJXYv0gvDyLm//9vkUSPt6OFdjmt5kW4dCaD9/ZbqKgo8Rfg6
	OQmTHZIPBbZ9/sR+rl4DsFV+5Z8sQF0FHBpmc6X9wzn9iewUE544g3La12duJ1VnXQeVJ5c0IMs
	Ih1zv4KMA8Q30jfa66ilrs+z/l9jl57pvCOluNuGPmeCuu3iM4L1x5mJwvH3svtqvTdbcZ8caRb
	yhPEHSabWRXNJtEeKdoqEpVhOk6Y3YITx6NEgp48GAavgy5cT+HG7x77fxGY2EJBc=
X-Received: by 2002:a05:600d:d:b0:485:3f72:3230 with SMTP id 5b1f17b1804b1-48715ff7846mr81652435e9.15.1774518736093;
        Thu, 26 Mar 2026 02:52:16 -0700 (PDT)
Received: from ?IPV6:2a00:10:8f5a:ad01:f856:f975:7cf:79d7? ([2a00:10:8f5a:ad01:f856:f975:7cf:79d7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722c9f0afsm33818925e9.10.2026.03.26.02.52.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 02:52:15 -0700 (PDT)
Message-ID: <30b6349b-5d30-4a39-b67c-b19a915fdffa@gmail.com>
Date: Thu, 26 Mar 2026 10:52:14 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: Add ACPI ID for SHIFT13mi gyroscope
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 lorenzo@kernel.org, jic23@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org
References: <20260324193626.77231-1-twoexem@gmail.com>
 <acPNhGlmTJk4pfRG@ashevche-desk.local>
 <2ac6cca6-a7c5-4892-93d9-49f850953511@gmail.com>
 <acPU86AwRJPUb22L@ashevche-desk.local>
 <71a591fa-d103-4043-a313-e796483e8709@gmail.com>
 <acPsxval-nfltuVP@ashevche-desk.local>
 <891e9fa4-3a84-4a26-80f0-8503e71aee5c@gmail.com>
 <acTu5PEOCSpMU1wz@ashevche-desk.local>
Content-Language: de-DE, en-US
From: =?UTF-8?B?TWlsYW4gTWnFoWnEhw==?= <twoexem@gmail.com>
In-Reply-To: <acTu5PEOCSpMU1wz@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/26/26 09:31, Andy Shevchenko wrote:
>> the LSM6DSO is a combined unit that only has one hardware ID. The DSDT only
>> has the GYRO node, there is no separate node for the accelerometer. The only
>> other node besides GYRO in that DSDT section is for the ambient light
>> sensor.
> 
> Ah, right, the third one there is probably touchscreen or touchpad wit
> the HID CPLM3218.

Hi Andy,
The CPLM3218 corresponds to the device's Capella Micro CM3218x ambient 
light sensor. It is fully functional.

Best regards,
Milan Misic
