Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB041DFFB
	for <linux-iio@vger.kernel.org>; Sun, 15 Mar 2026 18:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773599658; cv=none; b=NPcIczFnejpYImyAqfGNEo7Cj5Xt0csN/6HCr7/4a0qXXUj9VqFI7JPIh1DvCrg+vfDtXlwlWdgsn9WcWyGVbLY01uz+UGcWAmVoR17U1W/WcPnTsCMD83SjSJ+Vajo8esYQQUL+87JRIA87p/oOUSLyKUHYRBppKXpOt3waPtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773599658; c=relaxed/simple;
	bh=+nVzaB4l5ATfpw/KZCuQiZNsaTYEsAMVGOUzIE2TO9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tBjJaCQGXPp3pSN4zX9fUHImbQyLC/jJknoX0i9btiMzDDUOc6Lzbgjo4baP55uBPW+hevXCqw8B06vANKQMrZatJhhSBzj9z+Phmb3hh8BOlM8B4bVA6V8k1QhIKzSeGKnXvTcfTnHULeBB0gMk4GEvmT1HVdOrtpedNZrvqf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=WRRzMWRl; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="WRRzMWRl"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-40ef10ec84cso2629920fac.2
        for <linux-iio@vger.kernel.org>; Sun, 15 Mar 2026 11:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773599655; x=1774204455; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uK91QSpqD9Q2PuFwHTMi1IMQzYVydKjw9QGkXG8oes8=;
        b=WRRzMWRlNLhhCvXKyB6H9WUG6JmdKsICuyp+BGOWplX8ukstn9+B5KoX+1TfUAqAE2
         P3C0VU8cYMME8o7vJ11NBlVcKFvw7zraSS9OVWXUoeLPw0jKABppOAXyb2TDF0dRTUw1
         8JMka09B0Q4mEXXbnHw7ASZoq/BaaECsG1mtYl1xQuBkf11C+1DWpCVXFafTAo2yJ+F+
         KllKpfTqa5XZVu+TPn7LUQrUolPRlan4RxFNqvoL3A3oO8gOhnoCqGRfAWunHzl2vOO5
         fQI3fsXFLJDlvcjJwJKH8ZibRI0QqPNSAW6HfNpTrL7vgBAIKNDzK+eJozWfd7X6yIGZ
         s+7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773599655; x=1774204455;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uK91QSpqD9Q2PuFwHTMi1IMQzYVydKjw9QGkXG8oes8=;
        b=d03UXAuRG6GBuNANzHsT0Fiu742pEz9W6Bu2oODb/sZgh5gPV6v9+545377N/mLdiL
         CQqZviUniVLz1UuVpbvEO6G51FQGWWjlqke9O0VMsm3uiL0xeMT1FlxRCHEv8fDLuU9X
         v2Awr1Wjostdu1wjp3IJ7OY+8hWJ2438TxaP4xt72wABy8+b7Qoy+YYVP4vVd/m56XWJ
         gjbHuW3pR/IYoSGLLr5opN6c1vCN48xUq4k85La1Ds/ezy5dhco2X0+lfCRF/n0m72a0
         qcKtYvhpxR/0ju0rHggr3srvr4F0ZQnVv+quvi6jSmKbA7rdqdd+t6EHNOf8pfX9iAMb
         XIYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQG8gb8OT3zsOspuq8/3gQN+O6+fyuZzYOpGmROB9m+BTWsbw6uEQvyTIcCCkLkzIpHhxo13gLBug=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDwTiWR7zBPwUaHhznihs8dtPJO9zzBrHn507tIrR4ZAJt0+nC
	vpHRSAf4b+VSLfMplF5aBAUoSl+bQqXU2zxeVa/Bl5rORoN7WeHPp9I4S9ODqspBQvEai9A3LED
	eLnOz
X-Gm-Gg: ATEYQzx6kfyVzhkv7MPHa0jb5+aJFxuQjLTffj8JzPZLCfaHJqa2wAMVect6EA/HHUg
	hHM3gJgSJhYBJHTllTGvuaR2bZJkHWbxdFSsVYLOIQwuc9wDvvh84EUUV5cfLT7gVv1lkJePkz4
	/6uZ857ghGArSHVAGkIhlLczd6YL0PqiPSUbH0oi+7r/gR4MTRTjwyUYjzy6Ty2ntuigcC1z3EJ
	4Z/eB80lFXpUwXeVLOjw690JUKwCW37Gw9htADkZyK0MbcD1makdtk/Gl+1X6RfTjp3IhRVK89O
	AZPVmtjVWe85DvgvduQUO2ovoPZh6mId4vDSQNJD1Dm/h1yDG4rNOPISBFf1zJyzyk1hcEyk/4w
	TAGStgEo6ZiyNaVcDDCH3MBZjkJ0Gq0YL0O/eeSLb7xjjP8tHjNUcs3hjht3NnxUvxV0z1HqbTR
	mfkUexySzIEGK++uuItGFlM8ke84uZNbkXGJXUFqqRjn4Lm6AOgiGayIkeLA1Qlg14RgL2mZyu7
	Q==
X-Received: by 2002:a05:6870:ac08:b0:417:54ec:6a5 with SMTP id 586e51a60fabf-417b906a32bmr5839741fac.4.1773599654950;
        Sun, 15 Mar 2026 11:34:14 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:f27f:adf2:8637:6bb9? ([2600:8803:e7e4:500:f27f:adf2:8637:6bb9])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e1fb6efsm15181796fac.3.2026.03.15.11.34.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Mar 2026 11:34:14 -0700 (PDT)
Message-ID: <05eaccd7-b5b1-470a-abd1-2c2fc4b47e90@baylibre.com>
Date: Sun, 15 Mar 2026 13:34:12 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] GSoC 2026: Transitioning IIO to guard() and scoped_guard()
To: Ethan Tidmore <ethantidmore06@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>,
 Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: andy@kernel.org, linux-iio@vger.kernel.org
References: <20260311194624.1521-1-ethantidmore06@gmail.com>
 <CAHp75VeZb0pSiAkHo9QUeS+2L-qP_83-dKKRSp7-1VfZrtr1bw@mail.gmail.com>
 <20260314110758.2fc20704@jic23-huawei> <DH2PF86XN60W.2MVDUHLKPR7LH@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <DH2PF86XN60W.2MVDUHLKPR7LH@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/14/26 1:08 PM, Ethan Tidmore wrote:
> On Sat Mar 14, 2026 at 6:07 AM CDT, Jonathan Cameron wrote:
>> On Wed, 11 Mar 2026 22:18:07 +0200
> 
> ...
> 
>>
>> Hi Ethan
>>
>> I'm not keen on a mass cleanup like this without taking a closer look at
>> the drivers. I would say (based on gut feeling rather than actually
>> having checked the stats) that perhaps 25% of these patches result in
>> feedback on the surrounding code or follow on improvements that are
>> enabled. 
> 
> That makes sense. That would be a ton of time spent on reviewing this.
> 
> ...
> 
>> As to the your question on how this 'might' be done, it would need to be
>> 1 patch per driver because this will cause chaos for backports of later
>> fixes due to significant churn.
> 
> Yeah, that kills the idea entirely. I was hoping it could be done per
> vendor per dir but, I understand why that wouldn't work.
> 
>>
>> There are ABI changes that we want to push through the tree such
>> as iio_push_to_buffers_with_ts() but that's because the new ABI
>> is inherently safer and I want to get rid of the old one.
>> Some of those cases are easy, others much less so.
> 
> If a tree wide conversion to iio_push_to_buffers_with_ts() would be
> wanted I'd be glad to do that. There is much less volume for this
> project and if completed then a deprecated function could be removed.
> 
> $ grep -rn "iio_push_to_buffers_with_timestamp" drivers/iio/ | wc -l
> 73
> 
> And this would be much more manageable to review. Would this be a viable
> proposal for GsoC?
> 
> Thanks,
> 
> ET
> 

I think most of the same advice still applies. It would still take
significant review time because there are usually other issues lurking
under the surface. We could probably handle 3 drivers a week or so.

Getting them all done would be difficult, but not impossible. :-)



