Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B211227B94
	for <linux-iio@vger.kernel.org>; Sat, 11 Apr 2026 21:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775943592; cv=none; b=ZzlR8xpoAAnrKo+8J95P34b/9C4LEij144e+KyBxwNU+eWaR1sCACIoy1woLaUo8taN4uDfiTiTvhSeQgsZK0zisWOpyQz4k1lTfZxmKMeNl39zi2sMOYMXYzNr9I70i56yDINcOcUz9zFjb2lPq+OykPbgFwi3EDWrOblI4yYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775943592; c=relaxed/simple;
	bh=NWOEM6UHmzuwqOGsN6bDxg/kFoRuDDnEOho0JxD7gj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=en4UBl7JNdmAfz78zgZZPenTZBNxAOtMTHDL+QZinrMQv/JvAIn0hiepCWSxHE+LRjvic8UWSnQjhnE2TZeo0ii2VT+QketiPgPA4aQ/7+YXwmPEpFy9Sl9mKeMrunuX6kY2XTpJfK6OCg+lZ8Ln0WRW9ZzOFYqSRubMMOgu+50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=QefMkVdR; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="QefMkVdR"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7dbd23bc684so1836097a34.2
        for <linux-iio@vger.kernel.org>; Sat, 11 Apr 2026 14:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775943589; x=1776548389; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9K+MshAqvxCaSofC9uMUIkg4klLczZe1OyL9MVsBvF0=;
        b=QefMkVdRtoanbAxbw9zGPQXgPNXJItSf/ZA2+rEaW7TP/hMcYLW4ACFknlnGQxfwnB
         VjQAnutuAS8X6olZ8Nb4mSvjonNhyx1zqwOlq7fgLCgjxDtuAxo79+MTWP+sDHLhhTyA
         mQ9/wBynW0mZ1eFbYFesKrzfFPuQ4llvsJwy7Zpu9rNlijnwFVChhas/80p8qs+fh7Uu
         /QLn5qA0b0A8DMEsFLD3SjAGlTJhEZNGSbxzGXiNNsCBAUsRJNnz/s+ix2r8aiLdmE2X
         m1QVJmqnBWkaEaprHctxsp6ItGpRAnrUjCO7QE+HgxLEE0oujGq/LGCkOkuwYwuNRPP7
         tEbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775943589; x=1776548389;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9K+MshAqvxCaSofC9uMUIkg4klLczZe1OyL9MVsBvF0=;
        b=B+ptSYREeaNw6sFXJRg0nRj5sTEwM1cK2TpUac7Zv8K4xX52SsR7TZOEPgYcKXCmv0
         8LoF9Q4OoMZk2hiOv1kOqFm6QhZlqFPxnjqXcyrTZPURuFY8OC/S9R1KnVL/+qetom/c
         MzoPd5S5or+rJs96pUHWPS56FtNl859iJT2lYKRimLins9DGR/XTCnGNoqYpE35otCTP
         RbdY7PhLfUOEOEFWZPgQs1PPl1ByAKcqDCAaRWzn9dymRyKjHwHjo+nN/8MXaKGGGcwr
         xKmTpOfeJZ+Cam6oEQr4XyYyEEj/5n4BY0c9rkBDSMXxrs1jz93RHyAXU4s2p2nBc6dS
         UDJw==
X-Forwarded-Encrypted: i=1; AJvYcCXAtVtjF4aNDWRn92o2o+1saHNC/7VtTd5eYhHXCIeo3M46a59vGeljUPcsqxK+86oSWU+n+7Nkpfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoMFNsfwvSXpLV846vId1WWzrNYxEOkyX4pI2CfF0jif+LZSy8
	BIMbNcIA6uLzyzltc5jrN79Plap32BcUsUySqRPnh7wE7yNnP1c+dImHzQGaC7L2mRo=
X-Gm-Gg: AeBDievt0ZZeveFN4G/6xyQUXMqg2qmJssnS1Y9qf6VSNFWpUb0khdxrCDrxmx47Y3Y
	vbvcya9btmUz4ICDEAnTeLe51fpDSTjPPAuXwir1UWQpE6QhXqqUW0euq6J5bYAkhI9Qa3t81De
	RpLlUwLysReFrv+HKsraUGQu81mRCMpoS3QQNBU2WhZHJOd9EDy7mQlZ5rr1eBXSZ8fxSvu6ANo
	wKevjW5zXf2HqqLB35lLEdLkUqJl1AGNOzWFsT/wyZmQzME/yyvkMYob7jtqurUwDulc90FP4bM
	dG/RB3J2qNRGmNLMMN0PvbMLnFPI6PctSGfHgoNtIdWFesna/4yhTCd+DUoImpPfA6wefI2Hb7A
	nCcf11q/O3jIYRH9vKufzNvELJ616M7SIewvKY7tuAozQvP6r8UFjk7qxHnp2/Ra47N5V7aK66S
	GVkm13VwLYOCv5JoQa2h8bOndyTlBHTLGeRqyqEI3LOWSVyMpP4oLwC4iNOZ6N2lmWGSFytt1YV
	g==
X-Received: by 2002:a05:6830:6504:b0:7d7:dfc6:e1d1 with SMTP id 46e09a7af769-7dc27d87a0cmr4926413a34.3.1775943589245;
        Sat, 11 Apr 2026 14:39:49 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:d2e5:c81c:5b23:fe55? ([2600:8803:e7e4:500:d2e5:c81c:5b23:fe55])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc269402b9sm4706635a34.20.2026.04.11.14.39.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Apr 2026 14:39:48 -0700 (PDT)
Message-ID: <347859e1-fd6a-4b4b-a1d1-3e29a46be49e@baylibre.com>
Date: Sat, 11 Apr 2026 16:39:47 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/4] ti-ads7950: fix gpio handling and facelift
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
References: <20260405-ti-ads7950-facelift-v5-0-1f980ed3cf9e@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260405-ti-ads7950-facelift-v5-0-1f980ed3cf9e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/5/26 11:39 PM, Dmitry Torokhov wrote:
> The original reason for this series is to make sure ti_ads7950_get()
> returns result in range [0, 1] or a negative error code to comply with
> gpiolib requirement.
> 
> During review David noticed the fact that the function also clobbers
> gpio state. Fixing that lead to adding cleanups using guard() and devm.
> 
Tested-by: David Lechner <dlechner@baylibre.com>

