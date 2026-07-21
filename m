Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7F433D509
	for <linux-iio@vger.kernel.org>; Tue, 21 Jul 2026 13:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784639256; cv=none; b=Ocy3DyKuw61U9cqthKMvgPk+FuPUocsb2UBP9JWu5m0krpn27D12HTgzOMePXUW1D3OshlqygT5gJUZBnNIz4qnt3EML3yF9q4u3/9KTuAHSbg/U+YqyURC0me7OGtOPRlU7kwtkgV1vtCOL1aw8HBrcKoizYa1ixeeIDFTwPII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784639256; c=relaxed/simple;
	bh=3x3lP7j380kE9CvaSYhuk+2zEHK1fZOBVU1/W0OHSZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SLuTjk6pBrF8Edcihs+4Aev2Lr4on/UxYoW+zBloiV/VtSbNVCAe6XGt1JZGbehI2uQaaI8yQaOuFF+AdTs+pZ45HrbDMgLPXqXQ/Q4ZcVxa4eyss3pRuB7+e8rDRZS4zQNJCTmDfrjIXPNNaWLDvdNi8Y27ICT3IMJNfeFrH60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h175J60H; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h175J60H"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38dd55ad76cso3995817a91.1
        for <linux-iio@vger.kernel.org>; Tue, 21 Jul 2026 06:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784639254; x=1785244054; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8kuHno4FgLnOovX3FCD/y2WILch1zVn2CLj5cIw9pdk=;
        b=h175J60HmLwPBb2GrqVBrqVthyoEIWzfHFsU490pIExvEk9sS0nu3fEQ2ZjfHwRoKC
         s530oZ+7ltWPirDaJJiEQvTaHi2h/ywgXcEtYLru1tpj8zZlBHzGpaVA/mc1C4EuPkKo
         KyQMEWjPnDw6jCuZDFq/itbT+HB8XLK05gHMre6QfbaoImBTk+T/LPC1osgQvi3fp3JZ
         kPF4HyuKpo/PJjej5tZ3o3HA6pmrpP5964IXt0cIEt4v0qBkySicyjN1lK8DVLpl0Mu+
         AMg5sxjXrnEQXJNCK+rfFm9fewaO1zMQbXkV9ZoATuAhKiUmlXJm0S56epOm8WPCWsau
         1QkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784639254; x=1785244054;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8kuHno4FgLnOovX3FCD/y2WILch1zVn2CLj5cIw9pdk=;
        b=NnQlVSS5l9vA74vkxl1TLPMkO4Wx7EfvW9D1eDWXi/e5riynEww7/kgXqRuLIKUZ93
         UjDP96B5r/IeaqtSBhEuA2EarSgEp3rhPwhCijaAeJQ2Daqq3SmHtxPHE54x45LYP3JD
         UmzzEGxjJWktttQAWfiEOVb71gKEoRPBtNqwUjVxg8rhFmhkHkp1sbXqK3f5O2EPioeH
         xpvHUzL3IAW52uPwBta+v794BiuW3/eiGuKDK0TWKBF7B9I6RNI1Y719A3jxWMnMLh4Y
         6MwfDgugWjFNLojxUpowTxCb9b3OvZ/P6feoB9v1hn3R41ZG4LgPU1fhH3UhCeJOTPds
         zK4w==
X-Forwarded-Encrypted: i=1; AHgh+RqL9fBFaJcRgssEOiIHSSX6MlnQ+F8rUIgKOsnzoUPH6hw9ooZ8W250u0+jmT7fFiWFHdCFK0lJDL0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgjUiKiVqPRYOOJ5bM8QxbLxR63QdWUWkr2WxmqqFrfllNx7ht
	DXqvNXEFiTI610TIYlAb78E6PP8cRZhsNmNmMRDpplIuqWbLGn1LlHU=
X-Gm-Gg: AR+sD13aBqApMCoGy2mdV5viqqbJqoYM15RnZDvcO71Bi1dzRLpF7fS/ijZ2cvvqxsI
	KYBJTJyBvEFHylIpd1TbLJXx475x69LI3cWYtpm0caVB5CffKzXBIyGYklnOnOGQxm3Zb7ug2CG
	5MU9w6UgUBOYfhEe7/wBK75DOyN7vli5kTDZtiTiaGHBo2hoJoloyEk7sOeb7kg1wSqCmVI7cre
	0Jk+BocHijmgO4BvQMwoSDQ0r0Py9tUl4k7C6vr2zTyv2/vdvmGrV1Hf4XvUNaTCXLHRsnlxYve
	PcmC7M0rNNNdYdjtTNomzBf+ocsAh9hzyqz9L1nzIdP0X9OpxDLnJwFbgN5/Ceo1G03TOOJWfQj
	046C9jhkwOuovrewjtRncm6BwwvEeUE6VPh7fBFnlRmJA/ZhY8vt0vJi0hXeR17n/F0DFqithKN
	kmUxH9/NnoLcGnSolTFNN4EahP3Lf5x9Q+LGLG3+LltZwwwk0=
X-Received: by 2002:a17:90b:5644:b0:387:d5bd:622e with SMTP id 98e67ed59e1d1-38e4b6828cdmr14956327a91.17.1784639254313;
        Tue, 21 Jul 2026 06:07:34 -0700 (PDT)
Received: from [192.168.1.45] ([101.0.62.129])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e923741fbsm1521109a91.13.2026.07.21.06.07.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2026 06:07:33 -0700 (PDT)
Message-ID: <8db678fd-ba0c-4e1c-a401-205b40f07c4a@gmail.com>
Date: Tue, 21 Jul 2026 18:37:29 +0530
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] iio: light: gp2ap002: Fix unbalanced runtime PM on
 repeated event writes
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260720193911.74919-1-nikhilgtr@gmail.com>
 <20260720193911.74919-2-nikhilgtr@gmail.com>
 <al57yj3AQoHpef6I@ashevche-desk.local>
Content-Language: en-US
From: Nikhil Gautam <nikhilgtr@gmail.com>
In-Reply-To: <al57yj3AQoHpef6I@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 21-07-2026 01:19 am, Andy Shevchenko wrote:
> On Tue, Jul 21, 2026 at 01:09:09AM +0530, Nikhil Gautam wrote:
>> The IIO core does not filter duplicate writes to the event enable
>> attribute, so writing the same value twice invokes
>> write_event_config() twice. Enabling twice leaks a runtime PM
>> reference, preventing the device from ever suspending again;
>> disabling twice underflows the usage count and triggers a
>> "Runtime PM usage count underflow" warning.
>>
>> Bail out early when the requested state matches the current state.
>> While at it, switch to pm_runtime_resume_and_get() so a failed
>> resume is propagated to userspace instead of silently marking the
>> event enabled.
>> Fixes: 97d642e23037c ("iio: light: Add a driver for Sharp GP2AP002x00F")
>>
>> Signed-off-by: Nikhil Gautam <nikhilgtr@gmail.com>
> No blank lines in the tag block.
ACK, Will update in v2
> ...
>
>>   	} else {
>>   		pm_runtime_mark_last_busy(gp2ap002->dev);
> At some point consider dropping this dup call.

ACK, Will update in v2
>>   		pm_runtime_put_autosuspend(gp2ap002->dev);
>> -		gp2ap002->enabled = false;
>>   	}

