Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B04D4A33FA
	for <linux-iio@vger.kernel.org>; Mon, 14 Sep 2026 12:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789390284; cv=none; b=YBhcqY6vd0/wi68jniGQhsjPQkjz9ouvQg7n4JSzF5+zMvyB4sUuv9d2d27W3E8C/tO7sKq36aAYC8OwX1Po3EiUFctHiEj1ave6W60bjPTNx/di9gXFQuEMVtfTD1obSsM+yjiPq6kIovXoRJX0SqdiZHI2f3c7LetHr+w+DQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789390284; c=relaxed/simple;
	bh=RUOT7D+R6XRFK6ZDB58sR8ABaVNr55aigsppqxnh9T4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D2UFJyubZ8LhkOeVcGrXScPvvdsYh82dvepJZ3d5eLvPlK/cgBdiMFXPfGdZ3k92s6OCqTHg3B1vNV6v5FAX9QgYaW5WXj0qyllDe1i/iFHqKrI9q2e61pBezNcKUfV0XtUrv3zftvSYhr5oD/waL0nY+oLqfWd7n/WdGpcH3vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y00wAIrj; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y00wAIrj"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-482dd6ee390so2595589f8f.3
        for <linux-iio@vger.kernel.org>; Mon, 14 Sep 2026 05:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789390281; x=1789995081; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rgQC1Yl5RhRkFvfEBoKl0QIvsiqz4jd8a1ncnGvXLCI=;
        b=Y00wAIrjzP5NyVDNPzPu1Kf6i+gtyWosj4TxHuzUwqGnwuw/GoY8Lt15Wggpq2lCd4
         /dtmKKIWNehNh7YOCucMxSGDXYisJh8JX/CTnG8AhfzCsP621g2bprgA+zWSLsURJui5
         iWiEavIHoudV16OSUufIfmaBxNEFrMVm4lDN6jrg4GPiyFsEdP2k3eg3vEUnKssV1K34
         Fu3ZzFw7Ttd7qz21XjYJACIbCxgJvPW0d1Dr3+ZdSnL0Cdqc8yDwC04qGeXy1iDTm9Bm
         EyoYljHIDK/8Aa44P6j387hELQEoHCm30v+IdsUIRAHFOF2Oe3p8v74MTQtYi5qi8Y4g
         ETPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789390281; x=1789995081;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rgQC1Yl5RhRkFvfEBoKl0QIvsiqz4jd8a1ncnGvXLCI=;
        b=XQ9AGFjDP1rb3hHKFUpGomHcIAz4omAYVVwFSxqOlqYS1jMi3r3RREkf+p1Vh0dIhN
         s8aaHSdBAGc6UT4DclP5ypg8uwnxvMxlwqXeWpLZ+iml6J30w3CmU3QIimEFZRxX3DD3
         PdDnnoqKajkG/0pdKbjRiDX6KiiLo6Sruc9L7o4Pbw0iys7CMvziF1XmM5juMAPv54xy
         et3Q9UZUBBAoffBT5s80lHOSBCoHn0GzEqiUaAd4LMmt+FaGDKw5jZocRp3v8Hcr9E5A
         wiw2Frh+HeI2/zETBGbtg4k4/F0pYVhKBGfSJ460BCtwDbWhh2PEx0pUeEhrRtbg1JGq
         x+SQ==
X-Forwarded-Encrypted: i=1; AKwUvBzh8tQA82o5eV/zFN/+2y2NjedXv19qSJGunMhiubtALpGjd7zk5SqDZ2lRzPsDWhZYYYyXrHQ4Lxk=@vger.kernel.org
X-Gm-Message-State: AFuF++nHrtIdsGvse7LbAQmNpqH5Wb8lnDlv+S/59/Axtz0+U3B4D/1d
	JbEnMvdBEnETxIxJlzFfcKkwX8M1VUQU7qrQdIO8GmW3Br262NwijCEO
X-Gm-Gg: AYBFou0fN2EKKJpBhe+Y4HRq7fgKCN9qMO/Fs9Go3UJ+4WQAf/tghJGH+WwQy5yeJDy
	P8SOAXGXcaSkXvX0ARUCScUOzpqiz86j0VRU87mrso4u7gIKeC1HcSx9EowugWK2yMxZ+718y5J
	uFEQBp9UwC3MdgDMZcuPPwPkt2PJNpRtNNt5RQbfrEeFAdjoYHyRIsl/4Xx5oJHCiXyD5wikAjt
	KT9FqysEBqdUA0sZXnenXqxyU7qxr5zPCtgf8HrcuJWJiI5QygSz+39d2COIpAgAx6WvVShwtxA
	U7CwLfxOaaEe0rUflIc4EXj6HUEtMne0ccSOiY0G+nPTuJeZaRe3CRZ7CdxWYXFHxaDwzJy0+rf
	RD/5vJYbsOz+nUaspSze6A7qK+uRuAZP5EuLoHUAT1gfAoK2nKNX3/S+QQnRr8d+SZE9WsnOv+8
	AKbGk3S/Q2UrK9WD8JbugJr48OkAWtMcVyEtfWOHR4BT4MSFA3kljmErMCNwVHeWwoJcYDqkCNu
	DyH45GQJhD6ATEfbGtxC0ksYDUsnm/kncwqswWQyXfhbOkKB7v2QvRxPrM4LaLoCIXnXxlFXbmN
	H++zIdkkqZinl4wZ8vdWA03hgyuNCkVunAzE835WXcJjw+9zoC0nBgNis2/RKennx5fV01kqrmU
	LKkltLyli4uy1MeGBGp+7cppjErN2izupFfzaabaWNOaQHDtTvcltcZkNU5vSsSTk0sZF8pnte0
	lsF9Kc
X-Received: by 2002:a05:600c:4f41:b0:49c:cedc:3c36 with SMTP id 5b1f17b1804b1-49e7a685a1amr32353785e9.16.1789390280541;
        Mon, 14 Sep 2026 05:51:20 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26c1bc5fsm378995405e9.3.2026.09.14.05.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 05:51:20 -0700 (PDT)
Date: Mon, 14 Sep 2026 14:51:18 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, "Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
 (The Capable Hub)" <u.kleine-koenig@baylibre.com>, Danilo Krummrich
 <dakr@kernel.org>, Matti Vaittinen <mazziesaccount@gmail.com>, Pan Chuang
 <panchuang@vivo.com>, Irina Tirdea <irina.tirdea@intel.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] iio: accel: mma9553: disable autosuspend on remove
Message-ID: <20260914145118.00007445@gmail.com>
In-Reply-To: <20260914113012.1688043-1-lgs201920130244@gmail.com>
References: <20260914113012.1688043-1-lgs201920130244@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Sep 2026 19:30:12 +0800
Guangshuo Li <lgs201920130244@gmail.com> wrote:

> mma9553_probe() enables runtime PM autosuspend with
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
> Fixes: 40cb761306d6 ("iio: add driver for Freescale MMA9553")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/iio/accel/mma9553.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
> index 8e7aaac89d47..5a36d415a837 100644
> --- a/drivers/iio/accel/mma9553.c
> +++ b/drivers/iio/accel/mma9553.c
> @@ -1136,6 +1136,7 @@ static void mma9553_remove(struct i2c_client *client)
>  
>  	iio_device_unregister(indio_dev);
>  
> +	pm_runtime_dont_use_autosuspend(&client->dev);
>  	pm_runtime_disable(&client->dev);
>  	pm_runtime_set_suspended(&client->dev);
>  

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards,
Joshua Crofts
