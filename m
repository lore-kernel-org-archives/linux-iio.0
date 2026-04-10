Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADD1150997
	for <linux-iio@vger.kernel.org>; Fri, 10 Apr 2026 19:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775849526; cv=none; b=RWcw4GIcYTY6l5TZr4MwOGVCvwnEbEop/3/7SkaLGimBx0dcxmDrmj00L+GgpjSiPzZkP5B2U3NwuLtg7HGfyn91HZAKda3imIMB4UN5tk/6NFHytcISZ0mSQ8uCMuMHohKbdbS7S5b+KsKgE9FaogmnFXq1vHdgihX976YjkaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775849526; c=relaxed/simple;
	bh=4aNMebw4ACxsWJKNNvkW1wZZlAGBiQcTpUbCeZqns+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ItZiV5tNiL1k4OuCaoE9kEChWjURP4WFHoLULFz9/YpGiAM1ZAz2eqgRZfoh1NEqC+AdFjoQHScTOeKJAoFv3peJwauTZ7sTXUXAf7yk3v59ArwZ8/yn5R3Apkkt0EL4pPFK6j6DmiTgoVU1Tu41GWVIYCIppb+paiRuHUS3/k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=q+RSi9PH; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="q+RSi9PH"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-466ec4c6846so875238b6e.3
        for <linux-iio@vger.kernel.org>; Fri, 10 Apr 2026 12:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775849523; x=1776454323; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VBCELTROl5Mnj4WGXA1yUGtxFKCFwOhFgSR2ya34Ti4=;
        b=q+RSi9PHyFrMSMrPO+05CpvGczM4yyr4UIZJrdPu3nVdTYzSEyKbC5p7N9Kn/3yS6x
         VV8c8ptbPrUPoGDzAie2Kd5mzfIYv7WtWS6LbdO/fcRTNLKQnu3hcN02SxYx3EHFceeF
         yEiSavpAsH+WqBYFGrHA/heSsYGCQZ1D8L/BUZR3+a0WIzbDNIeeRyfiQGdN/FqdWAxV
         6zm5yu4adBRMmRMr6afUsmCQN/6WY3iomfzP5DBpM9At1dDPMVE4wZ7Nk/lIkbqMG1kP
         oVI5a4uh4BRsu7xQofJ0xhAFadJvTPHF/8dsgJAVSEOxeWJjHqJ65ziXGfRj9js/1di2
         YwDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775849523; x=1776454323;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VBCELTROl5Mnj4WGXA1yUGtxFKCFwOhFgSR2ya34Ti4=;
        b=Hz+NsuHJy9RUxwbAZjj2AzKeAw+TviTF9Dt6mAN/ZCiYxu7c7oGTGqBgLDbHUcTlCe
         FvWgKg7YCAXE0tZItE/6PsQyZiMkvzsbYTm39zec8D6R5cR93y3vqlEgxjxsBbYHrjgf
         sQYoITNFQH7On0S+y7SOQl9vnYebUx7mimNqphS7+7t/rMFTom9yrJIlEu/hEgBtb4rp
         hVFm8t+hgxu3axSDMXs4rAp3ur68kACvm+scdSIrolhh1qzexVscLIE0YcDPwpMJhRP6
         rWxjIx1iKKEgMg3rBads2ENZ4wRIJLozU3F+UgYvf/P96z1nX5Ai92uzjmZjh3Ec0ExQ
         NuWw==
X-Forwarded-Encrypted: i=1; AJvYcCVVNNEsaZSbBegvfRIr2zaXexjg61APKWTBwHKSndfzQ3zxq2IiHtlp+oP9wnYNjNhlIuY5SIgjglQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4eTbnlTqz/Xm6Oi6FKVvMP1rYLWxFIQBUG22JAicpj5PKQ0Qg
	P0cAqbwwM5fo7pgOP+RHJlCh36dSaZoPT6WyC/EAqyRL5mtg48xI63rRU+PE1UB8pkvRgYTem21
	1jrck
X-Gm-Gg: AeBDietBzKjgwtTQV5DlNAn/H6FE1SN/2dyGcUi62fZaVr0i2wMjBoxjGT99KdWgEB3
	d58OfOktKSfi0P9Myd29+vk/PIP/F/8aZcV7JFtGrCFduyA7zQcp340N+B+MDzK7qIlOk6BLjys
	38q3+Xy621uWHkNmj+YhTUea+OaGgHWgM7mPVtwSdHyCkhGwfn9bb//1qcDXc07ujTeEZiy4ks1
	XVWATvFL/63JUvBCAZ/tcIfaJr/C5RnDbPrUNWatAI7QH8qdk4GVQvwrBvcY03ys2v3pL0CZmAB
	4nbgxWRUVaCYh88mwOnbW3VQFu9hw6iwVcMkgKqbQ9xfkmT5w8qYZTnQfkck/SyevuOxrNJYHMx
	qZITjjW3HEOsGwHej0nHwApfKjvh9cE0fhcVNcn7xbYpw67soDxoQ0aa7jl0roD73X8c2IRPvaW
	8GXYotaDUnUeA7QnEM/LBllmqcbdBgsFZPN7JC5rVKORbmcny/U0YP8dctzM1cDEW7ldp6FTZRy
	g==
X-Received: by 2002:a05:6808:17aa:b0:474:b050:bf5d with SMTP id 5614622812f47-478a141398fmr2178834b6e.43.1775849523024;
        Fri, 10 Apr 2026 12:32:03 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:b75d:2440:dc10:808b? ([2600:8803:e7e4:500:b75d:2440:dc10:808b])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-478a131c049sm2060468b6e.8.2026.04.10.12.32.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2026 12:32:02 -0700 (PDT)
Message-ID: <0fd8a01c-0ca9-4caf-946b-5e0e756e4cab@baylibre.com>
Date: Fri, 10 Apr 2026 14:32:01 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] MAINTAINERS: Add entry for QST QMC5883P
 magnetometer driver
To: Hardik Phalet <hardik.phalet@pm.me>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Brigham Campbell
 <me@brighamcampbell.com>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
References: <20260409210639.3197576-1-hardik.phalet@pm.me>
 <20260409210639.3197576-5-hardik.phalet@pm.me>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260409210639.3197576-5-hardik.phalet@pm.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/9/26 4:07 PM, Hardik Phalet wrote:
> Add a MAINTAINERS entry for the QST QMC5883P staging IIO driver,
> covering the driver source and its device tree binding.
> 
> Signed-off-by: Hardik Phalet <hardik.phalet@pm.me>
> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a92290fffa16..d0b9bfceb283 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20274,6 +20274,13 @@ F:	Documentation/networking/device_drivers/ethernet/freescale/dpaa2/overview.rst
>  F:	drivers/bus/fsl-mc/
>  F:	include/uapi/linux/fsl_mc.h
>  
> +QST QMC5883P MAGNETOMETER DRIVER
> +M:	Hardik Phalet <hardik.phalet@pm.me>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/magnetometer/qst,qmc5883p.yaml
> +F:	drivers/staging/iio/magnetometer/
> +
>  QT1010 MEDIA DRIVER
>  L:	linux-media@vger.kernel.org
>  S:	Orphan

This should be split up and added in the patches that actually
add the F: files. Most of it will go with the dt-bingings patch
and the one line added later with the driver.
