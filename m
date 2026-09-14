Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467E949EC68
	for <linux-iio@vger.kernel.org>; Mon, 14 Sep 2026 12:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789390236; cv=none; b=G56xb4kGDMp7REkd6ggSNT52p46s7Wq7SbaFmkZhIZhHLi7YLwj9K28NBtqO4jYY1y6syNrtjj9BXaUWRDhKT8tbLUXeIxXPCs9OPxJsx1HUs3toNOXJ8lXsHpRJNmwKWHnfkim5blomOyduQ+KJRtE3iwNASv9PvplqyhR7Bz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789390236; c=relaxed/simple;
	bh=CMYe6CzVR1lQ4POVMp/udjPhXuoEKJUqjohFpdJjIHw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MZlDvPtUFr2boLRpE4/qdyK1iXFB2FRKuov0vduV+nfkyoicQDYw7ZkBmFWMP2E7LGwHpCA2K8XabR4RLWCbQHqhx4RZ8gu/7RJWIydgd2tlO2w1HgMIYVHFjZ9hZkeMYI8BwpQr6w+1Mht2Lr2O8yufAWC6Oj3urvYEdrvQVzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qwftJ+Wm; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qwftJ+Wm"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-485850cbac3so1742492f8f.3
        for <linux-iio@vger.kernel.org>; Mon, 14 Sep 2026 05:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789390232; x=1789995032; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oFP+vIzlMYUkbBxuUWjprqiU9MvG3SgKEPUqZyew3x0=;
        b=qwftJ+Wm2ptD7ylDhNOtdkE1Uj2os+7n04pLouNVH7M5f5Av1/kAkU2U4iYYkSeuM0
         5/mCUGu/t++YubOarRkrTE19zplY89GpR8ngwIAWuQfJ+BIa54UI0uR8rmYiQVtgr7Tn
         8EKmW4Fp0+VdNlxTtykwMY1tYDTEoUhbh+/nDO8LelGcz17nJlxowD72zYeUdIY5olmf
         veHorqOWjPWNQ5DQGqvhPiimJsqCqz1YiKRaF0VriUfDhwT9iL8DQy/KymliF9GL0k1Z
         MrN4Gvl0oyBd8O2qJK1h7J2xYLeUt+c0iAa5TU/RBhFNzn54gAn6fe/YkSEvoTtpZXs/
         7Xlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789390232; x=1789995032;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oFP+vIzlMYUkbBxuUWjprqiU9MvG3SgKEPUqZyew3x0=;
        b=quRibZ2j3CqY5dqSgCqY9aE2Bn/o8JuV9DYyItQ5RraGeAKCSTK70BfwVgNxyCsnMS
         SCriMd1h6hnCIQFTafxZIIlhUFzHUWPSXTzrUwrP3PmH4IpcxSJ951tF3RhOs8QfHIBc
         +7Uu6KuMr4LUq2PD4f5vEQISHAtAgntm4R531rhJtq496XZ+iRAhQa2wEUInEVJIN2rC
         DIRufaIvwtqGczo/Z7ccXSY6tZrIlPXlvNoKMyj6jv0/zaKgkGLYMXYJfJJdgGjKOz63
         fqagQsYhsjRG7y6jXT241VjLoSQZYfwyK22lMFmPvNzSYsm/ASB8H4q2wO5jXdlxI0kt
         oGtA==
X-Forwarded-Encrypted: i=1; AKwUvBweNQzx+RFZtD25a3VN1UqtAWIz4rTxIv/2CBxIXnFqLyY06q38zgatJw1tuRI/KKTDOSpoYsvDhYc=@vger.kernel.org
X-Gm-Message-State: AFuF++kMNPrRs9iN2x0ORlvrlDnOmb/0HTMXDu8tKCizwdD4eaDDxfsQ
	vfyJK9vB9nv2O9fcawOggVbDov2Oli/fVeHwadcFfC2E+7dnl1HxJ5uy
X-Gm-Gg: AYBFou1ypjndBA7MKaiFaoMybNLrKngR2WHubhamvoXVYHzRIuZv7gWIks/ccuWIYvB
	/BoksdG/j5U5yhZr7ctR99EPLI6MUyAau6Mr294YlJ+jPSFiHH/1deNBxtrrXHhS1LmGaxH0LJ3
	olsOrgjkXF49q5Dg3waOxAKC4MtnYN3Ptey8O0ejhm+iKVyxuXBs8P0ury6sjjLcc8RmdsSJTQp
	/2p1q47Jb5E+S2i8EohfXtvMSGlzdpGVgbA53v0eoUKyEjyNFPkOIEOiUIl8/Jm93iEuEg1Txy6
	8HLSp28YvYNdIw1yZ/TbzETNug9MODs0HaRrWeloUzqaUBr3oeM7nc1EYZOprJ0VYiVLuvk2IfG
	XEINPNLJMB0IgZJf3Ulo+CuBk1lOSzAipMRAqEuScA4jJZ2TPe/iZLYBoECZUwCJnAOVyHLxEG3
	3MFzxTWJN6JQAZKjFHP3doi+9kFnCr55TApv2LYKQBsLaeWpym3VL4Nv+uvX5okUGx62oTt+Vs/
	wIDI6rmXmBAqP2Rp2Mr97UMU+3I2MZjjsq1jnoHu8U7K2hZccT3wNP5Ik7sPZcKDS6Uybvcn4Mr
	PBTZ/jNSnKt7KvD7WPQ1S27Vxpe3uhpnpSnmwVqs12NQMLqB4W8BiuWK4uwWNpPfqUp6LI/dnwC
	123aNMz/fxOsgOJMz1P5NY1clzMYd1OLAwIHn1t0HIdKhn1gVM1hfB2HqnqozRAxXQhWn5gnJ6b
	o/sWJn
X-Received: by 2002:a05:6000:220e:b0:485:8c16:a357 with SMTP id ffacd0b85a97d-48702b2ed22mr2693304f8f.47.1789390231445;
        Mon, 14 Sep 2026 05:50:31 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb33ea4fsm28119004f8f.21.2026.09.14.05.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 05:50:31 -0700 (PDT)
Date: Mon, 14 Sep 2026 14:50:21 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, "Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
 (The Capable Hub)" <u.kleine-koenig@baylibre.com>, Siratul Islam
 <email@sirat.me>, Pan Chuang <panchuang@vivo.com>, Irina Tirdea
 <irina.tirdea@intel.com>, Vlad Dogaru <ddvlad@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] iio: accel: mma9551: disable autosuspend on remove
Message-ID: <20260914145021.00006863@gmail.com>
In-Reply-To: <20260914112447.1686972-1-lgs201920130244@gmail.com>
References: <20260914112447.1686972-1-lgs201920130244@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Sep 2026 19:24:47 +0800
Guangshuo Li <lgs201920130244@gmail.com> wrote:

> mma9551_probe() enables runtime PM autosuspend with
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
> Fixes: 6da93a6710a3 ("iio: accel: mma9551: Add runtime pm support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/iio/accel/mma9551.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/accel/mma9551.c b/drivers/iio/accel/mma9551.c
> index 7e01427fd9c4..182f488edab1 100644
> --- a/drivers/iio/accel/mma9551.c
> +++ b/drivers/iio/accel/mma9551.c
> @@ -500,6 +500,7 @@ static void mma9551_remove(struct i2c_client *client)
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
