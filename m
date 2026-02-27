Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C5D37996D
	for <linux-iio@vger.kernel.org>; Fri, 27 Feb 2026 16:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772208183; cv=none; b=MdgvVJUJhvdfwJRW9uH7C+Ny46EGhO7hcMtX8u0idntLlb80LgpXCON1kxBD60+Gw3CtNR/l5L75VnkzQqJfxkNin7FecVT70zFJeQ6zavVQ0rhc9055vXP+4YxIv7vyBaglFksF/V6DMyItS0Fy2zGsVZtOMbPy+zyCFMwmY10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772208183; c=relaxed/simple;
	bh=lgtXmGFSF9WY/XUFIhf4Vzr/tUP/hhtMLJySoSZVeZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nuCeyifNGkDPVyBfshy+bZRJI7v8dLI3ke+sQje2GnwjLM4oQz7GyYvYgwtNJqU5S2SEe9PyIrh9a/46VnJ+a5hP5nDFUs4i5GTDmhVje4XWM7isiD407RJWwbA8jfsGytFkCZCqcAliySjeaB5vJZlEPJdiO+Fs+ghJed3cCKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lXPb1/AX; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lXPb1/AX"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7d4c4b494fcso1311587a34.3
        for <linux-iio@vger.kernel.org>; Fri, 27 Feb 2026 08:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772208181; x=1772812981; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z/Dmx8lTYztz9z703bG8Wc8eXMBbKmKs50/Oz3D1ABs=;
        b=lXPb1/AXLW+dJ2bDAP8+d+p7kPkS8gSom65u25sefDUfF+GMwCGVaeRAWM+e2zG22Z
         4Gdy30tenkClsg2Tt+I3GZqEMmFF3LYNw2MlBGZtBBo79slNyp2Ts2ERpjwcrlVGNxc0
         WVsN+4p+ZhgC3RbxORHfEeq7M+7H2E74BFjIqCrN/gUPaLzMv48+KSWvNZyLRM/XsOlu
         b70ie/H5u9IJvqrxoHHAsTJr8OYAtAkrKKi3LiSWkqE+q0+mFUKL4UERNsxET18/958l
         QNqY9KSCnr1U/Z+40W53QWIXlnbuBIS61g0beVxEU08AtTzpb3zvXQmbyx2rliIrpkRp
         Y5xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772208181; x=1772812981;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z/Dmx8lTYztz9z703bG8Wc8eXMBbKmKs50/Oz3D1ABs=;
        b=HeFflS/Y51TxkBJtFrTM646l5a3Uyu0kfOCTDqmF5aw0XNmfhFG0F1x0Cj82ciH61U
         ZNMGNbYqnYxl4bpVWnc1FO9pPPt63u4EzFu2ueYWNJ9RhobFR1Mzjrd/RDO6BbWy5u5t
         8JPDG3TsA3DwNmZOwXPnlFIbu3mhHFZQJ4LMWFKFTxS/b3nf0dLDmsTaXWucfVbobgiu
         9QuXkQkOfpAD8UJAPurPlmSf9UT4eOf5ZN3ImjSpyu7fMx8wdgOTxZ4bwEjWxoNQGS9u
         bzybtaefyshuHMBFiqMgR4T+D5ugN/5RE3ilCnXS0m+oiICp0Po/eIJYfEK1eyfNFNyZ
         WLNA==
X-Forwarded-Encrypted: i=1; AJvYcCW1pskjwjYRBIe7z4v5TD4uEz67qIt5WLh6bh/EzO0uDL++D1f/JLkkxKTGGIe/V0C+aolIWdFffWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuCMaYmoGvhcrWj4abUZyL7nNc7RDli+A2dxj/JtWQuNef+0Gu
	mbIKpq24d4rENg9hBXzcM7QY0u6Eta247sVi4CTlKVET7Q/95TjbLxh7jxdNswFHKWY=
X-Gm-Gg: ATEYQzxnFwvl3GI1wBzjc7gq6pMKW/iV8YyxkSy5xWe9e4wG/OS1KIcyYN3P1KOrcL5
	y4A7WGNs8B1kQBIhQ0EgD1l46EGphlcfEUUK+talAU7XscwPbOywiP4cOr3nuHpq9AtL84Dc0r0
	Fp3xa45yX8DCH6KU80A/LhiKpu7S1JhGUMg09yG/nptllFzetN6R3fbY8ypj973OAMM+F3+4pTS
	UdiP0Y9kQ22puanBTkBBpPsxaKiJeJt5U4gVeIB9TryBJFfGi/pF8Zm/qWoqx/UOali34OxaY1i
	FEbDn2XK/Hn8IdZ+j1Mr6tqHTW8lwGj5BEjERxDtQizstPUHvTfBF3aqkB6mbXoBjxre2EksGhd
	+Y1NkYvUvLB9vQj25W9aOl3W9u2oZ48/9+cyP7TyZF4ZdnCtDyzCv8V+6ZaV8A9iI3X5puNEoqu
	ZJuP0RmFyUVN187Weawh4U7qF5jZ5I/Mfjo6GJGTq6q0w/tO0tIlh5L42YKY5duQu+6CfipZvUy
	A==
X-Received: by 2002:a05:6830:2647:b0:7cf:d30d:b12d with SMTP id 46e09a7af769-7d591c17be9mr2536685a34.32.1772208180907;
        Fri, 27 Feb 2026 08:03:00 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:876a:e36c:76c7:e6d4? ([2600:8803:e7e4:500:876a:e36c:76c7:e6d4])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d5998bc31asm483170a34.23.2026.02.27.08.02.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Feb 2026 08:02:59 -0800 (PST)
Message-ID: <d635d7fe-3e33-4437-ab52-b308064f71a6@baylibre.com>
Date: Fri, 27 Feb 2026 10:02:59 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] iio: filter: admv8818: Add missing error code
To: Ethan Tidmore <ethantidmore06@gmail.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260227061424.1135505-1-ethantidmore06@gmail.com>
 <20260227061424.1135505-2-ethantidmore06@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260227061424.1135505-2-ethantidmore06@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/27/26 12:14 AM, Ethan Tidmore wrote:
> If the macro FIELD_GET() returns an error code the function returns
> with 0 because ret was just confirmed to be 0 a few lines above.
> 
> Add error code.
> 
> Detected by Smatch:
> drivers/iio/filter/admv8818.c:335 __admv8818_read_hpf_freq() warn:
> missing error code? 'ret'
> 
> drivers/iio/filter/admv8818.c:376 __admv8818_read_lpf_freq()
> warn: missing error code? 'ret'
> 
> Fixes: f34fe888ad054 ("iio:filter:admv8818: add support for ADMV8818")
> Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
> ---
>  drivers/iio/filter/admv8818.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/filter/admv8818.c b/drivers/iio/filter/admv8818.c
> index e494fd33911b..4d5e7a9d806a 100644
> --- a/drivers/iio/filter/admv8818.c
> +++ b/drivers/iio/filter/admv8818.c
> @@ -332,7 +332,7 @@ static int __admv8818_read_hpf_freq(struct admv8818_state *st, u64 *hpf_freq)
>  	hpf_band = FIELD_GET(ADMV8818_SW_IN_WR0_MSK, data);
>  	if (!hpf_band || hpf_band > 4) {
>  		*hpf_freq = 0;
> -		return ret;
> +		return -EINVAL;
>  	}
>  
>  	ret = regmap_read(st->regmap, ADMV8818_REG_WR0_FILTER, &data);
> @@ -373,7 +373,7 @@ static int __admv8818_read_lpf_freq(struct admv8818_state *st, u64 *lpf_freq)
>  	lpf_band = FIELD_GET(ADMV8818_SW_OUT_WR0_MSK, data);
>  	if (!lpf_band || lpf_band > 4) {
>  		*lpf_freq = 0;
> -		return ret;
> +		return -EINVAL;
>  	}
>  
>  	ret = regmap_read(st->regmap, ADMV8818_REG_WR0_FILTER, &data);

Probably for a separate patch since this is considered a fix...

The returns at the end of these functions should be changed to
return 0. It is the only possible value ret can have at that point.
