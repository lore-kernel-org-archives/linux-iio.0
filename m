Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124C8342CB2
	for <linux-iio@vger.kernel.org>; Sat,  8 Aug 2026 22:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786228751; cv=none; b=NzrEPv0bpaqDJv1uTMjUz3konpUZAsQ/dwpAScSIQ0woOPJvC9AKRiqLLFjkPx8RxGBfwoYBrtiyxxms1rInGTm1IYjuKhnfaVFGPQXUVRg3E9ltwaxqtMc5T3rzF5iXqtT4BmU0557YXUYt5ZyOAvp+c7cy7vDa11iHp04QPeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786228751; c=relaxed/simple;
	bh=niXm/N5BBBtoVsM6jszdquk/kqKSZ0XTjTTqc2jw024=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KE8yOWL2Ii8kFdRCYypkYIh6X4eODUxa98I7YLBsU74XhXdYUytZHWLB2nU6Vi5+8/hegfp9SOAD2LBBH5yRzI7s6/EMZPZ8r8571aoOh0cvTZvf4prGu0EAf4VW/gKEacxckZF9DBbTJwwxSMRQ+JvDk+EUDg45Lj9FmdvCEco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Oh/Tgfna; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Oh/Tgfna"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6ae6e407bfdso228268eaf.1
        for <linux-iio@vger.kernel.org>; Sat, 08 Aug 2026 15:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1786228749; x=1786833549; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JI1+G+6qkA/DFYJt6nTy2HlA5K1RIKwf70bN14N3C2Y=;
        b=Oh/TgfnagF/GCeKHVj3gjdlNvejOI/5ukn23yMPxGVyPI/08a4La9EJ3mjnv7inS0x
         WYUpm/xr7rLYV7WfPCFLkrFC1wNaIIkcPP3TiZbflbBrRV9YfQQWg1ltcVZEh7ISCbyI
         2TnIy/PX0Jcz91+I+61KmE58ELkqC0FwOAlrcZo+Px8YDJyUUDSGV/P8vWy7k0G2B0q8
         FqLsKfQFgEXvJ0OrpyMTS+OqmJOrCz1AWDT1Y+jE+U9IjElCCPrqF28l04sVWqxR+vTy
         +ApmCrcMqrZ5LC4BVTyTX4Ixbqwqaz0jYWHE5javPvHYwTxZ3cbJbJnAZdPzv7XWjJiH
         FUtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786228749; x=1786833549;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JI1+G+6qkA/DFYJt6nTy2HlA5K1RIKwf70bN14N3C2Y=;
        b=DiaIlUCmxcu5hIO5/l5dF1I+yGEdhxSJHhg7EabovwvZ61Lbxw1fwneQS1xjXp7IHk
         koGi180LUl8kDMp9OnkP9GoVomwk9/O6o7zKiwmPrdRHUhv8FCavCpKCwxeLseAgDiih
         7Bzq+Rb2zgbgbwhSNdWAtYsGfpI8/VzDRLsuEI7ek/VfB/8CplTRH4ck82wj06Jhr7RT
         HPJLWV592vj6hND19JiDNvJN+lYewsP08vh+rhoMMjTNhda8O54NONPSasBtHl8m0Td5
         6k374JogTlbAfZ50rxMhNnPuq3QlFvUBBRlXvLpeQxum3AFhHuaMFXCPO4m0V+sNqnss
         gUUA==
X-Gm-Message-State: AOJu0YzX7KXXK0y9Dgfalbepom6xAyW5Jgu6r9VgYUqmz0nITIzIC5bK
	Kp/VRuw5XSrq8S5oRHNTRm9MaL4BcHCggGc1H2ZAfnzkB3oCV8fki8OxoNVh9uLkiuY=
X-Gm-Gg: AR+sD12AmGsYZcTweQTUmYuI0U2RhS3VCAn8d3s8f1WQfzZX8cHXG3tRTZ4VhwY06jg
	XkH1LCQrCkp0lXhoLU6wvllRFgHUHWY6oL67aSVKSwxrX953AvkACE7GXLTCFDKCEt1+uCs18UG
	G6KdgJlhvG8o/LJiYsssETxckP59npQhfzYGQMHXi3W2jnAg1X1XDnujnSHauXED3LS2B0TaAkX
	oiXO8tjcVdeqhgBj9BjlaIUcI3D4GS3/ciyZgvVfI9wqToUMNON97KSYE/3PqaRYMaavuTcQGOY
	J1izUDKRIHHTEYjloU1tv1FRt1d53Pxd4UMgaTGfbNLDLiGX2LT3MGgtOMxQjC+UBZreFyCHTkp
	RojD8FAAgf5zzJkJ7h1ZBqfvHjqldsuT+3ej5XGLhX5xzgI0F0jvvx2u7CWHODwo9NteJ372mv/
	8jet5WzOOsVIyxb6G1wXtV9JOzhXP+2xcMib8lLjCPgBCE37WNtqWFE/w6XJhM+4EGILiqaCUup
	ZqPa79vlWq9j4gsh6e2vmn0L7z0q4nbmO4nhp/1
X-Received: by 2002:a05:6820:992:b0:6ae:9815:7c8e with SMTP id 006d021491bc7-6b04213b973mr5509347eaf.21.1786228748829;
        Sat, 08 Aug 2026 15:39:08 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:99c2:f16e:201c:3bb5? ([2600:8803:e7e4:500:99c2:f16e:201c:3bb5])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-459f1a0224bsm4901696fac.3.2026.08.08.15.39.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Aug 2026 15:39:07 -0700 (PDT)
Message-ID: <f35f30e7-15c4-46f5-8aca-8a4a79c740ab@baylibre.com>
Date: Sat, 8 Aug 2026 17:39:05 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2] iio: accel: fxls8962af: clamp FIFO sample count
To: Shengzhuo Wei <me@cherr.cc>, Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Sean Nyekjaer <sean@geanix.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Joshua Crofts <joshua.crofts1@gmail.com>
References: <20260809-fxls8962af-fifo-v2-1-80ff1be1f1f2@cherr.cc>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260809-fxls8962af-fifo-v2-1-80ff1be1f1f2@cherr.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/8/26 4:04 PM, Shengzhuo Wei wrote:
> fxls8962af_fifo_flush() copies the number of samples the device reports
> in its FIFO status register into an on-stack buffer
> 
> 	u16 buffer[FXLS8962AF_FIFO_LENGTH * 3];
> 
> which is sized for at most FXLS8962AF_FIFO_LENGTH (32) samples. The
> sample count is read from the BUF_STATUS register and only masked to its
> 6 valid bits (0..63), with no clamp to the buffer size. The watermark
> path caps the count on the write side (fxls8962af_set_watermark) but
> the read path does not, so a malfunctioning or malicious device
> reporting BUF_CNT > 32 overflows the buffer.
> 
> Clamp count to FXLS8962AF_FIFO_LENGTH, mirroring the watermark clamp.
> 
> Fixes: 79e3a5bdd9ef ("iio: accel: fxls8962af: add hw buffered sampling")
> Cc: stable@vger.kernel.org
> Assisted-by: GLM:5.2
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> Signed-off-by: Shengzhuo Wei <me@cherr.cc>
> ---
> The transfer reads count * 6 bytes through regmap, so a device reporting
> up to 63 samples writes up to 378 bytes into the 192-byte buffer,
> clobbering the stack canary, saved registers and the return address.
> This mirrors the bmc150 fix (ce0e1cae2609). A well-formed flush reports
> at most FXLS8962AF_FIFO_LENGTH samples, so legitimate devices are
> unaffected.
> ---

When you do a RESEND, please say here why, otherwise we don't know.
Did something change?

> Changes in v2:
> - Use min() instead of min_t() as suggested by Andy Shevchenko.
> - Link to v1: https://lore.kernel.org/r/20260806-fxls8962af-fifo-v1-1-bd9d27047fee@cherr.cc
> ---
>  drivers/iio/accel/fxls8962af-core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
> index d0c2a8daef0db964134ad10b25782b9f5752613d..18d7b09bddd2b4f506c3348bf4e8cf94ce1c554a 100644
> --- a/drivers/iio/accel/fxls8962af-core.c
> +++ b/drivers/iio/accel/fxls8962af-core.c
> @@ -969,6 +969,8 @@ static int fxls8962af_fifo_flush(struct iio_dev *indio_dev)
>  	if (!count)
>  		return 0;
>  
> +	count = min(count, FXLS8962AF_FIFO_LENGTH);
> +
>  	data->old_timestamp = data->timestamp;
>  	data->timestamp = iio_get_time_ns(indio_dev);
>  
> 
> ---
> base-commit: 848acc8ffe1b7cd5f1bf427b93069becfebc2c9d
> change-id: 20260806-fxls8962af-fifo-c3812fd02eeb
> 
> Best regards,

