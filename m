Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40C430DD0A
	for <linux-iio@vger.kernel.org>; Sat, 18 Apr 2026 16:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776529606; cv=none; b=CJcEP7VucQiDoebLC1pG1fH96n8JoxO/sAsFhx5UlJBP8oMglVGI4oZcO2hveSGxIiRPDwA2XjNf/F1cTjUd1R9JsQisoL7lyGKJ/bwHvzK2/afYQpontNqdyxQkLOq0J3K4Fn2FxgqqUu36A72GU0VrU4LsLapwmGf8clRmCRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776529606; c=relaxed/simple;
	bh=VOB12WVhZJg2+i6UEsQWEkgkfSWAJy+jGXJUlTnGf1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ra33z8nAQ/C67lV5hYQPaPc/xFW+EZoJYheoV6Fc5iQwxWNqaVZpRP/Smc7R38fsTjlnDz9CWQb4SNjxQfb+OzpVwj3GvYnip/GV+gImtRxa2wAyVazBtd/7nLofqGxRe6ObMe7r1nD0oXouCxlK7A0grR004daV9AYllThUoPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=VNsKNkZd; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="VNsKNkZd"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7dca00c1591so328593a34.3
        for <linux-iio@vger.kernel.org>; Sat, 18 Apr 2026 09:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776529602; x=1777134402; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R7psx20x6H5IJ3mwZWh097xH6g/uc9O0Fam8QsfEyeY=;
        b=VNsKNkZdd9f1wSSW3j9NhqZAIKgzY3X/9Yy5oC/pbEVAVQk4OsmMQQHP4gLrjyr2R3
         EdsvQ12+U/i0SKIU79MF/65mufiITuPOG/Q4XTZokskcjn7ccExRwUyp4iPYMrxWNK6/
         UICgI+6Sizlzwm7/ySfcoBxEQraRcmhzQ5+CGGaqgnPkNQtczKIGHK2il3TucSCq+QFL
         ErNsqQdQ4DTe9IglBPQjr09uYC+ek3bCStV1R6OhnTqn2yY/i3TFV1/8RcIMYs2tw3Uk
         y7D1Oj4c9qcvElhqA1WDBbk2a6eCY1fET9qqaqwLEYKN15VLxyXxUswzc4NTNv9mdivN
         z3Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776529602; x=1777134402;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R7psx20x6H5IJ3mwZWh097xH6g/uc9O0Fam8QsfEyeY=;
        b=nMaeUQ+oAfK2EFFTYAMe1WsIosFK1zopzZ5Wbi4pNXfPIXy6yso/Ql3tZWgJxIxQq0
         xK4a7JjUzISvNUPvEGUQI/rHVSS5grF6aRPam9DsaptKVPqdFH07KSBtmWAOtQREAqFU
         9QWFL3pCUjnO3QG//YWkiYD5a43UN1ohgrQtDUlx9XvPt1OTUanL4lncwfoFUtzMfwyx
         HMz2KpMMwZaNYf0YC2hxJfXzuz1KTvhmSVhGhMwV/QU901Vyd/fTawN/F95FKOeZZI7w
         uCIDJXmcLHpEQJslIHBmlazJXqGNq/W8ubNKyW6fuWCrup9aqkIUJa1g6ZGoem7m3MGU
         OCZw==
X-Forwarded-Encrypted: i=1; AFNElJ91UZ6+18NvLtMX6cDn7MyquXKANWN0VqQ/XDkRmSISPDJ+dYUxYtcFHdPj/DBLE6jhsWgTIU0utnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoJZ0NbYZ63NokE4NfA80p7eSsrvO0qY++otvMla6HdQJT9jpL
	L5xIDjoiIhwMy6SVCg+McKNj8Bg2EHpY5idhGk1gBagXanG+CaL/NlHBCv4rJiqMJO0=
X-Gm-Gg: AeBDievpa6g46/iGJ/L8eNbsi0Pg+hG+QPSKaIKNxa2USDwQpmTjyKD/v5spjcf/WJ3
	iABooOsZuxFlcIEOn1fNIMrfDAvIwTuuYYCLlZOu2FT4dOc90dMDM0uJhZ9VDTTRpFMNd9WO97k
	mfIljRM/eW/NCbIPhf8lx0GsEKO6I7WHEmR8EaFx/JEvkxA/IkaUvbgO+hJ/Bd13ilp55f98DFv
	WkEner6GntafqxYbs5UjHzuJR41OEqM1iZ0auknWIU4XzQlrWAd/aSow5ERc3YV8Dy49dCFJaqN
	zWnoOajEtQy0EC3pSMCQBwb1tKH1ORG92evA/+gMdwD0fl4ryBD4UWYd5QQ1XWBq/I0Rvj70rTr
	KrPxIbYpsCN26+QSNrtXcOT8knSeJWskSt2rDs1KIGB5pG/RVwVaVr94vEKaiL9aBh8D+NaCLm/
	/NGzbyfvoj5DEzm1QDgUM0RuwjTzk6R9ANm1eDtPgGBQSSA9CG4EQvRuEF5fRI66I0cO8NlOpme
	HZBtHfvvJQy
X-Received: by 2002:a05:6830:3688:b0:7d7:c96c:c5d6 with SMTP id 46e09a7af769-7dc94d9c785mr4633545a34.1.1776529602300;
        Sat, 18 Apr 2026 09:26:42 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:b1f8:aabe:74d7:21ba? ([2600:8803:e7e4:500:b1f8:aabe:74d7:21ba])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc9f062a71sm2809062a34.10.2026.04.18.09.26.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Apr 2026 09:26:41 -0700 (PDT)
Message-ID: <e75d7791-7a60-4c4f-b81a-7013fd0068c6@baylibre.com>
Date: Sat, 18 Apr 2026 11:26:40 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] iio: adc: mcp3422: rewrite mask macros using
 bitfield macros
To: Marcelo Machado Lage <marcelomlage@usp.br>, andy@kernel.org,
 jic23@kernel.org, nuno.sa@analog.com
Cc: Vinicius Lira <vinilira@usp.br>, linux-iio@vger.kernel.org
References: <20260417165747.507487-1-marcelomlage@usp.br>
 <20260417165747.507487-2-marcelomlage@usp.br>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260417165747.507487-2-marcelomlage@usp.br>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/17/26 11:57 AM, Marcelo Machado Lage wrote:
> Rewrite MCP3422_CHANNEL_MASK, MCP3422_PGA_MASK, MCP3422_PGA_MASK
> and MCP3422_CONT_SAMPLING using GENMASK() and BIT() macros from
> bitfield.h.
> 
> The other macros MCP3422_SRATE_{240, 60, 15, 3} were not changed
> because they are also used as array indices.
> 
> Signed-off-by: Marcelo Machado Lage <marcelomlage@usp.br>
> Co-developed-by: Vinicius Lira <vinilira@usp.br>
> Signed-off-by: Vinicius Lira <vinilira@usp.br>
> ---
>  drivers/iio/adc/mcp3422.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
> index 50834fdcf738..59bf73304588 100644
> --- a/drivers/iio/adc/mcp3422.c
> +++ b/drivers/iio/adc/mcp3422.c
> @@ -13,6 +13,7 @@
>   * voltage unit is nV.
>   */
>  
> +#include <linux/bits.h>
>  #include <linux/err.h>
>  #include <linux/i2c.h>
>  #include <linux/module.h>
> @@ -25,9 +26,9 @@
>  #include <linux/iio/sysfs.h>
>  
>  /* Masks */
> -#define MCP3422_CHANNEL_MASK	0x60
> -#define MCP3422_PGA_MASK	0x03
> -#define MCP3422_SRATE_MASK	0x0C
> +#define MCP3422_CHANNEL_MASK	GENMASK(6, 5)
> +#define MCP3422_PGA_MASK	GENMASK(1, 0)
> +#define MCP3422_SRATE_MASK	GENMASK(3, 2)

Would be nice to sort these in logical order (highest to lowest)
while we are touching this.

>  #define MCP3422_SRATE_240	0x0
>  #define MCP3422_SRATE_60	0x1
>  #define MCP3422_SRATE_15	0x2
> @@ -36,7 +37,7 @@
>  #define MCP3422_PGA_2	1
>  #define MCP3422_PGA_4	2
>  #define MCP3422_PGA_8	3
> -#define MCP3422_CONT_SAMPLING	0x10
> +#define MCP3422_CONT_SAMPLING	BIT(4)
>  
>  #define MCP3422_CHANNEL(config)	(((config) & MCP3422_CHANNEL_MASK) >> 5)
>  #define MCP3422_PGA(config)	((config) & MCP3422_PGA_MASK)

