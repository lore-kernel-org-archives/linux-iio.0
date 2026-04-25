Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DC419ADA4
	for <linux-iio@vger.kernel.org>; Sat, 25 Apr 2026 19:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777143654; cv=none; b=doDlmZkHspx3DIF8j1h47DSaTjwzCQw618uP73d/U/2rdk8dlghm94l0T20y2PdzU5HHxIAAMwENgxO/bPSDYUOyIVbYlNMrbXzLGkPXmVzPgEURkEnCdsyAyFF+xWmyEVO8XRahM5AOw40kc7hXtNhFD7zPSD+nJTkBKpM5M+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777143654; c=relaxed/simple;
	bh=jKRAC0dvOAxQMd8XXDWnCxRhT/FTsUIqku+Xl3HcVFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gEuZ34utFckBBEPehJ1xrRrqtST1uu3OGSyBDBZQtI87PdY2W62yJy8oqankheBIJYCW/0PKmIrPNtCcZODXIhKFNhJLmzhUAKr/w5twYUdRsQx7g4UNde5s5kuxsIhZyWVhDTFMDeINltURJWmAdZBuS7Noq5Kd2dALeTPE5m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ltgUU9C+; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltgUU9C+"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so147797365e9.2
        for <linux-iio@vger.kernel.org>; Sat, 25 Apr 2026 12:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777143651; x=1777748451; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ufRuLrbKWmmAO4hqjvZ+xgyWvj73/w5Ztmfg4lvBqNU=;
        b=ltgUU9C+8bAvZ54FSFo1kanQBMxsoIlkQN83N9b5J1DmLvK0CgvkzE6hWYKA40MP5J
         YOdJ6INQ2rSP1B7vB10gDMqsc7UqYSsIamhb7VndB+LxeIv7K57/jUtGmAa70j3zD6SR
         qayochfAAIDX+YRV8Qw7ibQ3NXs2zcVeTq1t/6kM081kKoeuV8EzC92hD25k0TLfN0B2
         uTp2gDVXNtzZeoVqRyw+Qej/HGyR4AcmWfzb274OTWqtBKGD1F6Z8wlODjiEhOKJKGpf
         5GOti5JSO6ozrHIv57ay08lZi6lZ62PuxnDUIqIewvIOSxvEDrRUGjP5oPBhPLe/XPxP
         9DNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777143651; x=1777748451;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ufRuLrbKWmmAO4hqjvZ+xgyWvj73/w5Ztmfg4lvBqNU=;
        b=IEe1xPhaxwsURhkgHAM2QJuQGjjz4NnJEYgRRyaznIWHB0Unxjm2M8YdH+NV9E5aCS
         n7KDcCVhF+KLB39nTrgdxR22hmMqhhruTCWJU5oYPIxFxxo5j30sSA2iNpQcykZARMSa
         oQtknPNM7HS4rM+q34H2exBeOgMcvfTSLVg3LTqHv7XVBAtwSY/tQjDTOupKwSOu7DuR
         sOXKuORo4OT5xZLLr5xAq+j2E3/LKUtOdQ/M4HKha0XWafjZ5vaJxKLJewpltd7/8UB/
         FBktgHV0LeFgqCqOTv71JvC+z5uMbdBazvg0VXwETFQLSt3kDKjuzmf//gG7veaAHKvd
         ssLg==
X-Forwarded-Encrypted: i=1; AFNElJ+cQD0majD/ebPeGrkCIfidaC2LUdTQQlTjx7RMRbbJtCaeg/zxb2wOOQSnueSHoms2Mo4Kcvnk/P4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN5TyTY7JSXAeRkIvhG/ZuIKc6Y5OgoV3Fhi/0Lr5SqKJ57g2S
	Pjr32ptDXDJAopnCKJ5VYzxHVc0pfz8O2vwdugCM9h2IcVmrUFKQZjgA
X-Gm-Gg: AeBDievoBtsZNgTLOL/ato5OoQpS6wbq6A1+GTRvF5+D2at5nQSRQvHodyiwcdC63BJ
	x4wu4BFaNgBPVyov17hYEwLNnZnWiYp22aDqTijWwEZRKxGiIxowWhdQ+CjVLY/rg/NhjKrQg5K
	Hz59vn8MbdkF3vXNOlNI6Plt9tjiqdJT13++do4nsJrtlEuvX+O5gNW4eQraUyEXvcmKRgIcbNV
	uGR622Z39ULdbDMTMgLAbCYhCM2+q/UhWgRA4ePD4xlC1QI8N8mHgVjRsoGZ+wQTtUy2TLLfl8I
	rt2fQhEyfN/+Pyg826b9fJ6s7OqVLp3EokpyLmTzb84fmKWTRc4p//JhW5mem/rHMXq8QPUttiG
	olXavTxwVBorqJUUDmdsubd8Qs7IAl6ZE9vDzLEwGqLFwLZhtwHEKp5687XmQ5T5TgVJek+KZ1b
	oKTW7PH7YA4lywXUNhMi/gS1KsrZDHhQaqaZmL/ybUU4x49elOdkBf8aivMZZaU5pOOkFmfz/d5
	xULpeokYw==
X-Received: by 2002:a05:600c:3053:b0:48a:53ea:140b with SMTP id 5b1f17b1804b1-48a53ea1526mr197230245e9.28.1777143650714;
        Sat, 25 Apr 2026 12:00:50 -0700 (PDT)
Received: from ?IPV6:2a01:e11:5402:d840:f1ee:c5d:74e4:6e19? ([2a01:e11:5402:d840:f1ee:c5d:74e4:6e19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891cc84a1bsm176239435e9.0.2026.04.25.12.00.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Apr 2026 12:00:50 -0700 (PDT)
Message-ID: <3d4a4dbd-6618-4b63-ade1-d68155bac3ac@gmail.com>
Date: Sat, 25 Apr 2026 21:00:49 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] iio: light: tcs3472: implementing wait time TODO
To: David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-kernel@vger.kernel.org
References: <73d2183e-dffe-4ae4-9312-c544e0079f3a@gmail.com>
 <46fd475f-8d54-4419-a195-d66c947fcc1b@baylibre.com>
Content-Language: en-US
From: Aldo Conte <aldocontelk@gmail.com>
In-Reply-To: <46fd475f-8d54-4419-a195-d66c947fcc1b@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/25/26 18:49, David Lechner wrote:
> On 4/25/26 11:28 AM, Aldo Conte wrote:
>> Hi all,
>>
>> I'd like to resolve the wait time TODO in tcs3472.c.
> 
> Do you actually have this hardware to test it?
> 
> What is the application that needs to make use of this feature?
> 
I'm currently participating in the 2026 linux kernel mentorship program. 
I don't really have an application that would use this feature, but in 
any case, I have the hardware (Adafruit TCS34725 breakout board to test 
with a Raspberry Pi 3B) to test everything out.

As part of this experience, I'm focusing on “light” and, while looking 
through the TODO, i noticed this and wanted to explore it further.


>>
>> The TCS3472 has a WTIME register and WEN bit that insert a low-power
> 
> What about WLONG?
> 
>> wait state between RGBC cycles. The register is already defined in the driver but never used.
>> I noticed that tsl2772.c enables wait with a fixed default and no
>> userspace control. However, I think exposing the wait time to
>> userspace would be more useful to tune the power/responsiveness tradeoff.
> 
> I assume this would affect the effective sample rate?
yes
> 
>>
>> My plan would be to expose it via an ext_info attribute in
>> microseconds, following the same convention as integration_time.
>> Does that sound acceptable, or would you prefer a simpler approach
>> with just a fixed default like tsl2772?
> 
> So perhaps we could just use the standard sampling_frequency attribute?

Just want to make sure I understand the sampling_frequency approach
correctly before implementing.

The total cycle time of the chip is:

   cycle = wait_time + rgbc_init + integration_time
         = (256 - WTIME) * 2.4ms + 2.4ms + (256 - ATIME) * 2.4ms

So sampling_frequency = 1 / cycle.

On a write, the driver would keep ATIME fixed (since the user
controls it independently via integration_time) and solve for WTIME:

   wait_time = (1 / requested_freq) - 2.4ms - atime_duration
   WTIME = 256 - (wait_time / 2.4ms)

For very low frequencies where the wait exceeds 614 ms, the driver
would automatically enable WLONG in the CONFIG register to extend
the step from 2.4 ms to 28.8 ms.

But i wanto to clear my self this: changing integration_time would 
implicitly change
the effective sampling_frequency since both contribute to the cycle
time. Is that acceptable, or should the driver recalculate WTIME
when ATIME changes to maintain the current sampling_frequency?

>>
>> I also plan a following patch converting the driver to devm.
> 
> Would be better to do this first before adding new features.
> 
ok i could bring it up in the series assuming instead that the WTIME new 
feature is actually wanted, since I don't have a real-world application.
>>
>> Thanks,
>> Aldo
>>
> 

