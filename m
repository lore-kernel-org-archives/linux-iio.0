Received: from mail-lr2-f41.google.com (mail-lr2-f41.google.com [74.125.230.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B039D19005E
	for <linux-iio@vger.kernel.org>; Wed, 23 Sep 2026 04:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790139216; cv=none; b=BEq3oZn3Upqs+CuJ7DbxTh1NnMCBO9vSv8vGWLQFDvGRNOPbh/xTEWlrcG/EDul+HVVHStrfWNERrqtiRm/18cQjYYw5zUIXol3rPFfkQyQGIh+6lXJj7Fp5c0bbRmv8BJ5M9SRYLCY6W5zpH6p/oBbNp8mOVE3F9/UCQSp4Dyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790139216; c=relaxed/simple;
	bh=SrOtEX/ghHHp/7OJ1oFoNqlawokWvnWr4PS8cN8dABU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GR0R896+XJofBXJyJFGCEWTfCapo8NmAYmPqdbrSzwp2//NVgbIDMBMrZNVw/7ESbYLZ9n18O3UujkKK8thS8F0ukoUYgwJEKctbrIAz7ZwL+AmimbVWoptoaVZOF9cmmOpqQQKzhkA36O4YHHKhWhjGJ4ULqX6W3JPOOrdQMYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nqOqehCp; arc=none smtp.client-ip=74.125.230.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqOqehCp"
Received: by mail-lr2-f41.google.com with SMTP id 38308e7fff4ca-3a6287d59b2so3718101fa.2
        for <linux-iio@vger.kernel.org>; Tue, 22 Sep 2026 21:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790139212; x=1790744012; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AylAKepIyU+pHcAiXkxcY1iALnL/FJ5BBVyeQ6kjQtY=;
        b=nqOqehCpC91FGfrfMkgvcifeVHX7COAgRZPt0vgV7ZZCzWzLOQLd4WLVLMaQ3uab0g
         HF0qCY1WyfOSE4RnbEqY8mLh6O+C9V+Ucf2/skSVC61/aw/tjtckkF8tAXC+mi+nvmRq
         rFf+rT/Q71oCNbgWVnodt7QJTSuhy39ZDdDO57HBpqdFHPOWcxjYKkVrHBYgY69sga54
         18eQTQjaw6SuSybo7uBsEaExlHKBMALjOj64HD5FHua2kukA3YefOkwVJYBYoOUD60AF
         6XAUxBzLQFisq7C30vuTw8B1qRqhpxZdkLSVOwhVphtXIm7mOCiObE/ap2dm8jfKld22
         PuRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790139212; x=1790744012;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AylAKepIyU+pHcAiXkxcY1iALnL/FJ5BBVyeQ6kjQtY=;
        b=VJeOtcJcDMMH95hyO0KaGLdRVgo4+9jZt16p6n6YidEIgNvz+gyNZSFQyA6xtc/ZvU
         nVGksF/kPkgiQK2Dvjh9qa+o3ZIooDQkhMK9Dm1HK4/d1LCCHvSdkfFkb89BDhkiJOHw
         acnjoxF5klSaIMzdDIynOZqwy0ATSm1PoBiFi8Gf0TguCblsbfgU6nn4qeYwe4LB2+e0
         pm9YPM2UNOUG5+Sa2KyhoSusINIHI7W3EORqlpdN2a6N68ge8DEXqgmBk6boGxRpvSO3
         ZUbyxlnpQ/g0zrnrdJ32SDuTIICalbE51GrbOs1hdNmMggLDErolzwg8CfjtkDWxp2F9
         2CKQ==
X-Forwarded-Encrypted: i=1; AKwUvBxoVtz6QU17Fadhbjng5h06cgvvaMjMRwlr7uZ2bFb7GmCahPgJj3q9iriov4wzZVPhd5a29+Sjbjg=@vger.kernel.org
X-Gm-Message-State: AFuF++kFBSlvKPG7xaEO2nVwnlYufDLsJAV8IzXAujszxLvHZALso+3w
	mPRZp0uF8q5C18Ac4Dle87tg4GmFXFK34UeX+FDaVmcFjq+gLtOWtb+K7WHvAkxH
X-Gm-Gg: AYBFou2rrNxw59VwYQejGLjrOjm+vO7y4oDw8/w6I4Gi/NAEThcmBT93FeM3wQOioli
	FXPgXPpQZDdqyCEjZWX3uz5SPadn22baiBMvVmfyHxZImaJyuTgQAx6doRnRP0xqb7LA4sfXoMn
	X7uQNOS40xq65qTqTNvs7zhSjzjNOoZuxx/PfvE2wyXF3Ia6426cME+/alZ0r85sWextxvrWrzB
	VvkzXPEA2kLwRfsgXKV9ejtxA7AH4RAEBzaNKVIMH6ya4Ur492oqlTLf7lhg3SskcbbQWO4EPBN
	VWRYa8hdjr6Dy9xy2NL3HwXBVUEmd9Qa9KQw7MiajfjDuES+O8D0fKRjHsE+aG3yEOkMTCnM66L
	cmiufLpm43ElqoIO/RkSSvY2k+LhF2mejlv/Qs+/pp4lyLBwW6XjaRi6ZdVMhN0SJPOWFYHjjew
	Yb+TnBLjlS9FJMbiRY57uFRBHHe25VbJnZOG7WxWaYoXq/Hocqm/9BJ8pdv7raSbqy7FQdLIKXJ
	DQ7lWN8zQ28ofwkJytOU6p9gX7GyCmdD2m9BMcPXdtxNaLdPx+zTK4=
X-Received: by 2002:a05:651c:a20c:10b0:3a5:da9c:4659 with SMTP id 38308e7fff4ca-3a63068020emr1910501fa.27.1790139212242;
        Tue, 22 Sep 2026 21:53:32 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8d85893cbsm327531e87.47.2026.09.22.21.53.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 21:53:30 -0700 (PDT)
Message-ID: <a71d93ad-815d-4f6b-8046-e331d165a1d2@gmail.com>
Date: Wed, 23 Sep 2026 07:53:28 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: gts-helper: add __counted_by_ptr to struct iio_gts
To: Bill Wendling <morbo@google.com>, Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, codemender-patching+linux@google.com
References: <20260923041630.2553973-1-morbo@google.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20260923041630.2553973-1-morbo@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/09/2026 07:16, Bill Wendling wrote:
> The compiler attribute __counted_by_ptr can be used by KASAN and UBSAN
> to detect out-of-bounds accesses to pointer fields in structs where a
> corresponding element count field is available.
> 
> In "struct iio_gts", there are multiple pointer fields associated with
> an element count. This patch annotates these pointer fields with
> "__counted_by_ptr" to improve runtime safety:
> 
> - 'hwgain_table': counted by 'num_hwgain'
> - 'itime_table': counted by 'num_itime'
> - 'per_time_avail_scale_tables': counted by 'num_itime'
> - 'avail_all_scales_table': counted by 'num_avail_all_scales'
> - 'avail_time_tables': counted by 'num_avail_time_tables'
> 
> To ensure that the count is set correctly before any pointer is
> accessed or assigned, we update "iio_init_iio_gts()" to set the counts
> prior to assigning the pointers.
> 
> Cc: codemender-patching+linux@google.com
> Assisted-by: LLM
> Signed-off-by: Bill Wendling <morbo@google.com>

I like this! Thanks!

Acked-by: Matti Vaittinen <mazziesaccount@gmail.com>

> ---
>   drivers/iio/industrialio-gts-helper.c |  4 ++--
>   include/linux/iio/iio-gts-helper.h    | 10 +++++-----
>   2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-gts-helper.c b/drivers/iio/industrialio-gts-helper.c
> index 4f52dc373abf..4de6324fd923 100644
> --- a/drivers/iio/industrialio-gts-helper.c
> +++ b/drivers/iio/industrialio-gts-helper.c
> @@ -652,10 +652,10 @@ static int iio_init_iio_gts(int max_scale_int, int max_scale_nano,
>   	if (ret)
>   		return ret;
>   
> -	gts->hwgain_table = gain_tbl;
>   	gts->num_hwgain = num_gain;
> -	gts->itime_table = tim_tbl;
> +	gts->hwgain_table = gain_tbl;
>   	gts->num_itime = num_times;
> +	gts->itime_table = tim_tbl;
>   
>   	return iio_gts_sanity_check(gts);
>   }
> diff --git a/include/linux/iio/iio-gts-helper.h b/include/linux/iio/iio-gts-helper.h
> index 66f830ab9b49..7e7d3396ff1a 100644
> --- a/include/linux/iio/iio-gts-helper.h
> +++ b/include/linux/iio/iio-gts-helper.h
> @@ -58,14 +58,14 @@ struct iio_itime_sel_mul {
>   
>   struct iio_gts {
>   	u64 max_scale;
> -	const struct iio_gain_sel_pair *hwgain_table;
> +	const struct iio_gain_sel_pair *hwgain_table __counted_by_ptr(num_hwgain);
>   	int num_hwgain;
> -	const struct iio_itime_sel_mul *itime_table;
> +	const struct iio_itime_sel_mul *itime_table __counted_by_ptr(num_itime);
>   	int num_itime;
> -	int **per_time_avail_scale_tables;
> -	int *avail_all_scales_table;
> +	int **per_time_avail_scale_tables __counted_by_ptr(num_itime);
> +	int *avail_all_scales_table __counted_by_ptr(num_avail_all_scales);
>   	int num_avail_all_scales;
> -	int *avail_time_tables;
> +	int *avail_time_tables __counted_by_ptr(num_avail_time_tables);
>   	int num_avail_time_tables;
>   };
>   


-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
