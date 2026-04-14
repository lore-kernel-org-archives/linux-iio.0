Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0293D9DCD
	for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 13:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776173373; cv=none; b=M9yPoUYD2AK9qKCsMxbL1mRqz9wwnH/DYTaKHIWYv5Z3HDZMhIBRybqQ51Bf4xwdAA0r3cVrwhVN/Flp0Dz9ecej23YtNXbVhZlbD/VmZcVvzx7C/H7Nxo+91+HRp/j7adzXosAEsXoM4G07WwyjNmEhw2bayvehUgMcyFSX+ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776173373; c=relaxed/simple;
	bh=k/zOuY30RNZr0YbjvGcrxGgRUgTIN7ZoknxfX5JPDqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XAVZMci8OfWmg5YipxE6PeBnLcvQc7f/96xlzrjJQHebaWPqKGYfOUKrg3UjhcQq4BWJXq+vI0D1SWPlZ5DZkqgSoTFWtBdL2PlQQVsB4tzZYHRrpyHFvSOHVO5/15gsmUrbXCnw02LEU1ufCXl8ALfaib4LeJXSGLBgykaYJ6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=ako3t7ey; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="ako3t7ey"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7dbdcb85067so4709844a34.1
        for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 06:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776173371; x=1776778171; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=buTfI+KLeDeg8uKm1bRoRg/Dor/qBDBfQYYxVgfbj80=;
        b=ako3t7eykb7nWHR1drxfB1+oWz5O4exDrK/55H2xpnEG7lzBW1g0l/47HZOU4MzprQ
         2rz2gzqQ4+WxsTs/JeOhHnsn2N8afKzUPS1N74dDOzEmdQTpgg5w5e/hbrU+YFt0u7p4
         ftcIxFHBaWnZcS4xRa0OsMwlgj2xFubAVQrF9B82RpcY6fCVviidMXB2OwbQL1k2+2CA
         b2HdEMgwQn+h3OEVeC7RiF1C6QJpnE8AMfOUGtdrE6XQYs9Y+mCxbcJunX+M55fMTjTL
         /Td0cywUsmBoHKhBiUNynk3ExwOG0vS/2roRj2mSyeZq72ux2MXkejs1heLQAQ4r/eNq
         i8Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776173371; x=1776778171;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=buTfI+KLeDeg8uKm1bRoRg/Dor/qBDBfQYYxVgfbj80=;
        b=nFbYA/+1M4x3qSoHBNe3wGyAMGONHP/HyBR586rDKjF6tAVBjIUenSSFkGgtBd3KFD
         bsImt4EQQXLbQ1XmoY+40wXKbz7wXAQvkyZkE58u3lmcCul1BD0MtmxnGRrU8B6/kVL3
         Tz3Grqa4HYgan+4Hc0E0tLLBbdKfFIzx84l9JjyZpdNKiFcOOyJvZZd2H6joO5P7si0F
         8YskgAMC82ddCnfteRK4nKATQEEuxv00pCVjE9G9sXnGorDMkeKzLjZ2a9hHSdUWUvSd
         wgXkRPnEW2oNewRr8W2QIWAdbIttuf2vW7sJffXEesUfyjtdGmG2C8Ghl4Jf7u/mptLr
         WwmA==
X-Forwarded-Encrypted: i=1; AFNElJ/ESh5Nocl1Go723k1Q6aypt8MC/ayhvV/MOPJITCUDzN2hsfGVcqnLs5cxdIqfUwUSlfX3qgnkPFU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4Qz790VBNQPS3KRuXX9mWBOO5FePlc63v40ddyOHm7oU+qTSa
	IO7LcaqAo+WkgRmMWGrG+Ou/jlz3tCA8WMGUpJlKXA1uYLSBug72uzSXsMuISMr7U2Q=
X-Gm-Gg: AeBDiesqgMHRXBCfAbW38JVPCy0ZYUzauQUehZGimT9dphw9aL922as5tAKmtASmlCQ
	bSIpttCVtSIS2hhBvEbu6WlqVr2YYef4OGXGmD1z24cXtnc4LctUULOltZrzD8Oe+cRxviIcCYZ
	3z47HoMOFOiOsrA+Bd1bW1afRJ0uZx2a6+x/3ITGEbEbF6Wolv32xyUo/avGlHgE9nuc5499irX
	vm5KIxa7HzT3OjPf5goGF8GwFI4Ck5TJd5v2qXJP9azRSTyYecF1tLC0ltDt2GCw9owawWgJDJa
	VKD2WlATA+oKztirdYP43A4X5iGYpqEWwXOyMFP+FaE3KFjKUkXSYYA6VSWM/EKcIajp9JqEaaA
	+poNrvdfT0aj3OKbM/lftM3mVS/TKkBHacmVfTI0BneWBXkIxSfwlVia+8gXkHHAuKCsS/Bgn91
	ZXaNbrshlZl/5n4p2DPT/Rqyb32fg4UDK1VZ6c6hKHfEgtLD9n0txiOWhAl/mr127arNizSyshI
	g==
X-Received: by 2002:a05:6820:98b:b0:681:aa84:a8ff with SMTP id 006d021491bc7-68be5c5f183mr9275886eaf.12.1776173371135;
        Tue, 14 Apr 2026 06:29:31 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:5bfd:a817:5527:c417? ([2600:8803:e7e4:500:5bfd:a817:5527:c417])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-68bcacc9931sm7466199eaf.11.2026.04.14.06.29.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 06:29:30 -0700 (PDT)
Message-ID: <d14d23df-0fad-4b87-8e57-67241b29fc30@baylibre.com>
Date: Tue, 14 Apr 2026 08:29:29 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: ti-ads7950: use spi_optimize_message()
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260411-iio-adc-ti-ads7950-spi-optimize-msg-v1-1-617766ef2e38@baylibre.com>
 <ad4OywqHDC7aYapD@ashevche-desk.local>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <ad4OywqHDC7aYapD@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/14/26 4:54 AM, Andy Shevchenko wrote:
> On Sat, Apr 11, 2026 at 05:13:33PM -0500, David Lechner wrote:
>> Use spi_optimize_message() to reduce CPU usage during buffered reads.
>>
>> On hardware with support for SPI_CS_WORD, this reduced the CPU usage
>> of the threaded interrupt by about 5%. On hardware without support, this
>> should reduce CPU usage even more since it won't have to split the SPI
>> transfers each time the interrupt handler is called.
>>
>> The update_scan_mode callback hand to be moved to the buffer preenable

s/hand/had/

>> callback since the SPI transfer mode can't be changed after
>> spi_optimize_message() has been called. (The buffer postenable callback
>> can't be used because it happens after the trigger is enabled, so the
>> SPI message needs to be optimized before that.)
>>
>> The indent of ti_ads7950_read_raw is changed since there is no longer
>> anything else in the struct to align with since we removed
>> ti_ads7950_update_scan_mode.
> 
> Some of the func() are mentioned w/o parentheses and I got lost which one is
> which. Also callbacks usually mentioned as .callback() (with a leading dot).

I didn't put () in the last paragraph because I was talking about the function
pointer, not the function. I guess I missed update_scan_mode() though.

> 
> The second paragraph doesn't tell me clearly if there is a behaviour change
> from user perspective.
> 

It is not clear that the difference the user can notice is that there are
some CPU cycles freed up for other tasks?
