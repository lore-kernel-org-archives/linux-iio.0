Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514AD3AB496
	for <linux-iio@vger.kernel.org>; Sat, 29 Aug 2026 16:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788021288; cv=none; b=G5NNWm+46QKZpC6TC0vOSPVcAzvnRewlfTE81TemT6/DcDYfVZQkSbxMBOsx0ridZns2B+0a+rBdkekA93sd25gUNBHk0+2SmliS7B05t30KlOBsHzRaf1wbI8cwB+fW9hz0+QKJ1xT9D/F4wuConVbGMV84y596tQzv1/ZpCGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788021288; c=relaxed/simple;
	bh=hVExYRrLgPRcRJFEdHlm/lR6vy7PMGHxSW/wkJhOTjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=okrsE9CMelu6iXS+qRHZCD1gyEm3EVnROs0M5YKBPKigWYWk3x8bZrBjUEM+nmzbdnLe44JzsDMpr058XPqH/hQamnWFmATalYWfksPngxexYhHooidWr/NFBMd1CMrxcRaqONuKettxoAWKeZgf7VuY47ulDheJ31zkS+yCsPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uu5klKV5; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uu5klKV5"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49554ebb87dso25845275e9.3
        for <linux-iio@vger.kernel.org>; Sat, 29 Aug 2026 09:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788021285; x=1788626085; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nZEugiUgDUntzd2j7JleFMnc4ZUpEg9vc3iXITyX7q0=;
        b=Uu5klKV5qRiu0hAyYLvZsWq0BQJXiyHuZ2mECKoz9frWtMCj2jJX3CpZbUi73pgaEr
         bhYsYciWlfDjYc+qqJwBt1sAD9dMnXXEahIlMcW6aNgwZW/dSJF38YapjvHM/ba1vQRN
         rTdGPyfgh8sV3tjPDRYSuZphr43YiM/0mkmBQqRLMPFVJftosQGM5SCzECaI9q/pJpX0
         t5ymyLIu10geK7rW3k1QgDT0iyastsz7TrXymwtwlrr0MtZkE6zBUB/ZuS0DqQtypE/A
         MWyLnapuY2rh+MI9UPH+uUEJmwWfGBFC9NjBD735wT+8UySN2LDGNNE7Ch31BK3XhAJo
         pK2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788021285; x=1788626085;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nZEugiUgDUntzd2j7JleFMnc4ZUpEg9vc3iXITyX7q0=;
        b=J/TLKJM8tNbHYUr/K8SO9TY/ARjARc1HBTxQV54GVKgX2/YWmyQUHYZK0F9C1bwORD
         BVCOyvGI2nsKwLdeNytOFGV/0/xSGP+K5zxx0ijL8QrU/2hweh9oPrf68D1xv1z4c/AS
         VDtsQXWRe/+swjg2IR+0191cbw0g9KqBajvrkVAm6OmNHhYqEr98qJJd8FZBiYi+bUyx
         oZ0jufeZItbQo1u6mMRhniZlYlw4gcqHVW5Gpiq578PuKYSXmiPlpxwNdoHYPT2bDjru
         sOpoBDKy2NnfuddO7prCKzpZ6MTYerIUfFLIVxyeYb4BkT+zNAHzpHmZPPvXLfNbU1n/
         qYEw==
X-Forwarded-Encrypted: i=1; AHgh+Rra1iUCe/2fcA08C8fm0bZTO5jVNuBc3v+E+xjFa5X5K6UpGzmMzKLmufTzoYB6OHsh1piJsg9PqsU=@vger.kernel.org
X-Gm-Message-State: AFuF++mmEAvlgpwktK6WvYDxQk8lgX57QpfM+95u1eT/CERKuRsXKXsj
	Ozosi78KHLdyAaF9QEk66oaVXSzzmAsX+a2mSTp9qLdWn/8XIRnMHePd
X-Gm-Gg: AR+sD105CiTaquzoQz7IukWlyO45ep+dA614cnMWx5g4s96ZKrbMrL2/fTHTMOMGGz9
	ZhgY1vZgxoTcKrwnY0ZJkTGKskj6SGP/vBsxT1lXMdXAHSHu8VCQA2LTreeTOoYFRefBWXBiSfO
	VoqK9Moee2KpuY1AlZRKFoVA/tTEIXmHFiu1OTO4VBxs4p86EXtjY6h1BXO8FOQI+nPbgiTONZC
	ik/071Wh1AoM/Il8V2sojWToX+mOZp/jhCCLuF/6g09TOv4t9u2cI2vReaiekuc5DOnDdN0pTDK
	MXfbPlDb6GwtfYd/aG+Bphw4dRvMnHD1af2vDciWRNjTNBd3ja8CYG9ep6oIWfakNO2x65E9tkS
	8C6GR/icTtgdUA2lucv03ifmsioOyo8vc8cNVJXOnoyXozfHS6K5JZ8PB2qrJiAza2cX4gFQK2m
	rvqlURu6t+7avQaWouzesPmcI3qTC40Wl3QysIzQCd7O+6vJxY5ER9zdoZCDcdBcpEZsfMmfMMD
	UR4FCK90wIUgOAU4v24Vggj8A7xrPyxfZ6mW59psVef1E9lNagdQxmkwC60Did9rGU3/rKeHqqA
	1BpFmhIdYkc//1pL8PBjGZx/VMLmGq6tYOP4Kpquq3PnGLsXq5yc5WQqMsFPSsIBUalNVof4mfu
	WEn8hcgZ0dBj3f5n47lLR
X-Received: by 2002:a05:600c:c08b:b0:49b:9202:6f80 with SMTP id 5b1f17b1804b1-49b92027118mr191962305e9.6.1788021285069;
        Sat, 29 Aug 2026 09:34:45 -0700 (PDT)
Received: from systembl0wer ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b4e2c1af7sm233169495e9.15.2026.08.29.09.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 09:34:44 -0700 (PDT)
Date: Sat, 29 Aug 2026 18:34:43 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Cong Nguyen <congnt264@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Matt Ranostay
 <mranostay@gmail.com>, Andy Shevchenko <andy@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: proximity: pulsedlight: fix iio_device left
 registered on PM setup failure
Message-ID: <20260829183443.3b5ac19f@systembl0wer>
In-Reply-To: <20260828105909.2425439-1-congnt264@gmail.com>
References: <20260828105909.2425439-1-congnt264@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Aug 2026 17:59:09 +0700
Cong Nguyen <congnt264@gmail.com> wrote:

> pm_runtime_set_active() failing in probe() jumps to error_unreg_buffer,
> which only calls iio_triggered_buffer_cleanup() -- it does not undo the
> iio_device_register() that already succeeded a few lines above. probe()
> then returns the error, the devm-managed indio_dev is freed, but the
> iio core still has it registered: the sysfs/chardev nodes stay live and
> point at freed memory.
> 
> Add an error_unreg_dev label that unregisters the iio device before
> falling through to the existing buffer cleanup, mirroring the teardown
> order already used in lidar_remove().
> 
> Fixes: 4ac4e086fd8c ("iio: pulsedlight-lidar-lite: add runtime PM")
> Assisted-by: Claude:claude-opus-4
> Signed-off-by: Cong Nguyen <congnt264@gmail.com>
> ---
>  drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> index 400477b4c740..8a9ee21f2bf6 100644
> --- a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> +++ b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> @@ -294,12 +294,14 @@ static int lidar_probe(struct i2c_client *client)
>  
>  	ret = pm_runtime_set_active(&client->dev);
>  	if (ret)
> -		goto error_unreg_buffer;
> +		goto error_unreg_dev;
>  	pm_runtime_enable(&client->dev);
>  	pm_runtime_idle(&client->dev);
>  
>  	return 0;

Hmm, you should just return iio_device_register() here instead of 0,
as that should always be the last function called in any *_probe()
function.

No need to add a new label then.

> +error_unreg_dev:
> +	iio_device_unregister(indio_dev);
>  error_unreg_buffer:
>  	iio_triggered_buffer_cleanup(indio_dev);
>  

-- 
Kind regards,
Joshua Crofts
