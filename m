Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6363F3FBB4E
	for <linux-iio@vger.kernel.org>; Thu, 17 Sep 2026 05:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789621464; cv=none; b=XRBaBKidBjPAwFlg82FFK2BnOcmsofWQFcFaZL7q0nosOs2+Xjbx5kHijCDyGAFlw4zG32J8LCIzlzMr75GErNNEM4Tulm2nRQnG7/PsR3iPWWjbrjjyyCMZweJ65tv4GcqUUB01Mcb2BUhiwuK2RjTdsTexHkVzYCoCgB0tC0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789621464; c=relaxed/simple;
	bh=Fo+sfbiaynX50FZ3e2l/qI3EVG40HYWAxAwO9e8v/T8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y7hh6r/Y8R3K3eZLzZPJRtVJMCMvuNaNIJlvGajpNOt7VeeRHyas+/8VHz17ZHyRGqY0S5qEtUMlILhc6K8r+HeobBgmBIQNSy8zo2GBX/hGNVcICoYGkUnk5ESPEhzWAju3doID0+43tBjFhuKoTXoEFd7H3aZJkDGgt9Q3pT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e+tDtQCF; arc=none smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+tDtQCF"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a2ff16dd47so4143521fa.3
        for <linux-iio@vger.kernel.org>; Wed, 16 Sep 2026 22:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789621454; x=1790226254; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xVRhUpNhNdTq48LbqzJgmbnOl6QrDZN44ur0P2rl/Qc=;
        b=e+tDtQCFYPyrul2pdnN0dWvTSAizO7lMjAxSytz2iWGgJ50yzuwebCk4uSPWjDilVl
         4QFuyavDqYP8KuybB64wytjVG6iUvCaw9WIERplGTAXf2AKUMZ6Q4H9XH3cJLaqrdunl
         uItqQmge6r0AT4yx8MU5U30WGbbEDrO04mHD7HAcEDBd1Zn808eHTtkPjgZ9/ie2rLnt
         m+nHSXDYsL6gsuYn+6R95ZZq1TG3nHhmx300UqA1UaKykrHl/iWXpfdLO2zUpevcgSGO
         dq+uMoAcVnOoJIZ8z1KjJJ25PHnQd6gIuhwyva7pw1dkXHD7Inukc2kNdzLn7VfCHtJY
         C7Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789621454; x=1790226254;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xVRhUpNhNdTq48LbqzJgmbnOl6QrDZN44ur0P2rl/Qc=;
        b=tl9dNJ121hvE4ngLiCaXHF68AB1Ca1QQx7K51e0x3LdcAcKuIsfJ8dLcicYms3F5tm
         A6nFzKuz/nCVbXF/5JmnS5hdZyVGBbYLhf4E62l6Z8V897Aszx58yuG7kBb9tbOL+gQd
         Rk2/gLXoUeIZ4gisuqVIkQV09UwiHHTsLyraUCZpV9tzrdMPWsHNuiammUuCLWqNgnaZ
         CMTfJ5t23oJ+Sk6dGE4arAVZktTFQ2bCDn1Ukd5EeogEG+PXGfreoHkjZ5VzopRePTys
         FHLW+lseExOzPvZTEQktJyL3vWrXXep3Ir70X1uIFcRTJ22cvtNre20vfUbu4ucqEgQB
         Ylkw==
X-Forwarded-Encrypted: i=1; AKwUvBztERbLYQQdRpdMVDoGYa0++O+BXPo1ARGvdmyjBQXmYrgWlCjG/kl9IeoAJ8nmYEIIEakPMi4syhI=@vger.kernel.org
X-Gm-Message-State: AFuF++kzSAL626JQs4wWT5BpYLifUJ+sfdb7//MppwgB6f03Xg0W9Y9W
	NA1yz7FQQ2AkGC73X5yqqA9XVvnjPikN5we4h8c5NB7Yr9xhf7PDO6Xj4mC76Ayj
X-Gm-Gg: AYBFou2UjEoKjBUAcyghMdulLxYZ7BK2OEO3+Zi17Z4Logcu6JDnxMuI4ojpGYRA8Ng
	TTTT2cDNlu5wsJpGsB5P3yiiFRDm4QGr20lfXWy/Z97W1cbElEeEAtllQzu31Q5tbPJkYCYzlOc
	jKgqXGcl+2rKtYm33keGYMQMgSlvgf2KP/yyhaUJHlzAwMDHKjBO1IMCAHN+iRAKRIzH471Wntx
	0b/8TJWW+ISnaeH9pO138PxZCCUb59J1kSuZLxkbAgxLtRh/1Yzm2OqNJuXkbNKqsEfnxnphDxu
	4ZLQoGegTwskWdWHlJbiUehcL0BATEakRjBZ4q84sn35+CW9N97Z/gajhJCi30QVb2TBeFLAvzD
	qdDNSMs+PYO0VffhDpebeG7QhPOJv0L7bjrinZjEN4+cKjRhTw3cPbSzTECFDg4uzvpRs3EvAjn
	6gzT5+jyr2DsnrVDalDNdFmWcOvJIWYkHgGg5rXT84P1B2AWodP2yCE+dGxDmcwfgQ2K/FrLBHp
	QOxWgGU2LTgztNDoM9ZVj4s4k6WqqKhVGN4wnSkEMT0Z21GPhH3yDY=
X-Received: by 2002:a05:6512:31ca:b0:5b5:e0dd:1c6c with SMTP id 2adb3069b0e04-5b8b66123bbmr1555083e87.4.1789621453651;
        Wed, 16 Sep 2026 22:04:13 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8b57e7e3esm1452052e87.75.2026.09.16.22.04.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2026 22:04:13 -0700 (PDT)
Message-ID: <43bdf1d5-bd82-496b-8408-871646fe59d4@gmail.com>
Date: Thu, 17 Sep 2026 08:04:12 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: accel: kxcjk-1013: disable autosuspend on remove
To: Guangshuo Li <lgs201920130244@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>, Siratul Islam <email@sirat.me>,
 Danilo Krummrich <dakr@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20260914112053.1686061-1-lgs201920130244@gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20260914112053.1686061-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/09/2026 14:20, Guangshuo Li wrote:
> kxcjk1013_probe() enables runtime PM autosuspend with
> pm_runtime_use_autosuspend(). The probe error path correctly undoes
> this setting with pm_runtime_dont_use_autosuspend(), but the normal
> remove path only disables runtime PM.
> 
> The runtime PM API requires pm_runtime_use_autosuspend() to be undone
> with pm_runtime_dont_use_autosuspend() at driver exit unless runtime PM
> was enabled with devm_pm_runtime_enable(). Leaving the autosuspend flag
> set therefore leaves the runtime PM state incompletely cleaned up after
> the driver is unbound.
> 
> Add the missing pm_runtime_dont_use_autosuspend() call to the remove
> path.
> 
> This issue was found by manual code inspection.
> 
> Fixes: 124e1b1d0924 ("iio: accel: kxcjk-1013: support runtime pm")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>   drivers/iio/accel/kxcjk-1013.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> index 166fb786425f..c6b030f64be1 100644
> --- a/drivers/iio/accel/kxcjk-1013.c
> +++ b/drivers/iio/accel/kxcjk-1013.c
> @@ -1547,6 +1547,7 @@ static void kxcjk1013_remove(struct i2c_client *client)
>   
>   	iio_device_unregister(indio_dev);
>   
> +	pm_runtime_dont_use_autosuspend(&client->dev);
>   	pm_runtime_disable(&client->dev);
>   	pm_runtime_set_suspended(&client->dev);
>   

I am not sure if it matters, but it bugs me a bit to see that the 
clean-up path for PM here, and clean-up path at probe error, do still 
not have same steps. As far as I see the probe error path omits the 
pm_runtime_set_suspended(). Do you think this should/could be fixed?

Oh, and if it is fine as it is - I would really appreciate education as 
to why :)

Other than that:

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

(I know I am late with the tag as Jonathan applied this already - I 
suppose it's still Ok to say I am "Ok" with the fix :] )

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
