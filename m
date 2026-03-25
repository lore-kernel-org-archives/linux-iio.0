Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA1318C933
	for <linux-iio@vger.kernel.org>; Wed, 25 Mar 2026 12:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774442387; cv=none; b=cF1bbWvOBs3HVlREh45XQ9DZ+s0ZiR46m7OM/9EsBBR84mB2ouM3ZWLjKsXpzJB0Bzbm+SGPAv3onbMes7BsfC50FIpCwd9IO7Y5EMY7oA1Ny/m0pVBgLBn4CR0C4LO9RV0hfWsyMuVZy4KVR8JtQcTZ0U61hm8xFuXexe9bJK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774442387; c=relaxed/simple;
	bh=LL+RpZvN5aIZuMMfWu6fIx5AX+0hj8PRMxFjqNRV0iE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bPEr/bQRvbR74q5t8TNDbXlF9JpPcElxmf/aYWx5Z6CLKt7rI7qjZlnSH0BCd7vthgANKEFsr7icU4ilCAzm+aWc869e4wkntLLNWL6VXC0s1FgC3eFzwTv3C94isESLCrK/jeNrIH9IcnUA9IPsPW2hkF1MhLADsPUJTwnYTL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r8LdRDXS; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r8LdRDXS"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-486ff201041so44770135e9.1
        for <linux-iio@vger.kernel.org>; Wed, 25 Mar 2026 05:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774442384; x=1775047184; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xtuXp+6WgHbRT0cszKDOE39oBvxZ938mbsv9Ak13mSI=;
        b=r8LdRDXSkPFV3f/ybLzqWpTwH9+BN0dK50qgZluS5s2xQB8VFoGMB8TQiUZcmCzVWP
         L+fZyp1JxteW1iZL9vsrwE/Yb01E8E1LFpS/LnYx3C0gMU6yoaaBctxkgFndezRREXeQ
         VvoYg/aFcDodkLGC2iivMnvgrTd46vXtA2p2eTAk6fxRuLjkJAGui4jmRcbVPkghBiqD
         JzjiuYaxklYH4iWHiLXbaECmCZLRLMjl0c2kO8lxjFlsugz0jVCyj9WdPcrXs1IyR0K2
         qYA6lg9tMfN6iX1ie54jr9oL3ofjBvf7QPQF+qU/Xbf9aPIQQ7AjBL6e81B8j7VyqDkH
         lhTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774442384; x=1775047184;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xtuXp+6WgHbRT0cszKDOE39oBvxZ938mbsv9Ak13mSI=;
        b=jrgfWjOfHyzCPVZnu7sGfyy+wY0hkvjd3mQA8fJwS7nZRe2E41XSjgotCFuYXGk4St
         xJvpr9Ajih5dNvkbJ1v/NOOTH1sbL8tCyY/BNg+Z0pDtbEHwNrrsim9AG4EK9bGdih0j
         f0mexzOJjmbwl9XLdSwo9EzpXfXdP1GXOUbG7rio3g0Fvqb8nlIBnr+dn0i4T7dwmGTQ
         dD0LsA+fEmWBahX0kZI4nACWHvo6SNQzqkqVX8A0p7GcbtOERpObNirSvmA4ZhUCnXNc
         +fRxVWnVUblfjhJjKlHSWz0zNZ2gPLWlyFp5jZZMDOuRHmM6vOIASkh6iRFoWn5Cfp5p
         KRig==
X-Gm-Message-State: AOJu0YwJ7yZ8rJa6tJDVN+DMjhW0g6e1QEbta1+0jNf7XiWYcqkx9Ywn
	IWsvGH6xK3SNz+tzsr6dYsCscFB7QUe1YoWC8Gy4YROrtF8LiWwdQ16v
X-Gm-Gg: ATEYQzwpvxSSSJRfOzNCAOqu9ORHFJ9kBLx1VrU4pEg6j2PW0nbDxvaym32IO0X9XzC
	oIwAjJ941xitu/f0KmWhU5VI7kg7+vvmGIo6tFbXnw4DIxPjzLhr8fqxE7VAX3iR5z3S0m6nxd5
	2MnCZlu4n+UaZy0qZDcP6deugMRir24ClJuiJAkL2ndC9zcHVllFj8qlxT6DRt2rWIRrzQYt+aQ
	8jO0ahnIUJdKcL4NMPtfqdIW6r3bB3RfvSzNW7Gl2bRF21ZHnSYMF48/JkdCmEPQb+WNtiJJDVH
	nnithxCm03ZOU12zlNUt7DotGYYd3DnTcp1Iw0ZR1LXpNNnxf85/mPqxiqcxYULguWNa2Vx21eL
	gzKlfn/oBskEsIQNToQe+CaVdds3kFgXOI+McqE11gJPG9PW6GA+N3fWE6ERWR3kdA7ygp574WT
	yspNhGFe8ChJFYqL0jWxYIC7jmsxISdKyUrTWzG35kHYXBnSwzeMuR8msx2o0yS5I=
X-Received: by 2002:a05:600c:1f12:b0:487:338:b4eb with SMTP id 5b1f17b1804b1-487160564f9mr48382215e9.28.1774442383796;
        Wed, 25 Mar 2026 05:39:43 -0700 (PDT)
Received: from ?IPV6:2a00:10:8f5a:ad01:f856:f975:7cf:79d7? ([2a00:10:8f5a:ad01:f856:f975:7cf:79d7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4871728a19dsm43893515e9.1.2026.03.25.05.39.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2026 05:39:43 -0700 (PDT)
Message-ID: <71a591fa-d103-4043-a313-e796483e8709@gmail.com>
Date: Wed, 25 Mar 2026 13:39:42 +0100
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
Content-Language: de-DE, en-US
From: =?UTF-8?B?TWlsYW4gTWnFoWnEhw==?= <twoexem@gmail.com>
In-Reply-To: <acPU86AwRJPUb22L@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/25/26 13:28, Andy Shevchenko wrote:
> Interestingly it has accelerometer and gyroscope described there.
> Is the other part already supported?

Hi Andy,
The accelerometer is supported. Checking iio devices:

$ cat /sys/bus/iio/devices/iio:device*/name 
  

i2c-CPLM3218:00
lsm6dso_gyro
lsm6dso_accel

Both the gyroscope and accelerometer are shown and recognised.

Best regards,
Milan Misic
