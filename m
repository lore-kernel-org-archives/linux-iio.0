Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1850417D86
	for <linux-iio@vger.kernel.org>; Mon, 12 Oct 2026 11:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791802905; cv=none; b=JT5BhOoDRPuwKpqVlt22yynuHYqeew/FKzfrx88NdPeJVlp2kTN8lPN3NX8Q3wFwbmykgRLh8c5/ZN3E0cSL4IdSY1l/STNBeF3lInKt8enP5m3NtYAvHhCDuywSgbknsu3v8Xiz0ihz9uYtpyymu/LMx9XaLFXBy7NvZ9DPKlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791802905; c=relaxed/simple;
	bh=WjKMHqOPFyZQEx60Uc4WQI2TM0o0g8ojFfUwXif0dzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Od8qpUaoltS2cT7/NTGLMdO39kePO5RcTfVVtBtiiyPYyVAlDOqTY+dRzNPbSlX3+r4BMIWZb7gY6kldwoF2Qe5t0TcFxs1vHXi1JlQEKOhoGn5+bR8Z8GamrDqBufhaqZdCCH5EpuM9iy0l8ovLSeQ+NlywX+LUzctTNw6ZtZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W9/8GdOD; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9/8GdOD"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5ba41ea31ccso1916717e87.0
        for <linux-iio@vger.kernel.org>; Mon, 12 Oct 2026 04:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791802902; x=1792407702; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CEM49n9jNQ/heZjJVbHJseSZWYtO87nODkEzEO1JHt4=;
        b=W9/8GdODhR+tbiIbr1l32+xqV7LMGS1Q+Mw7gVkiBWndBP8uhto/gF3DZnToHJ4ZF3
         osJZnridMYTsulOg3aajOdWB2k//ZOfgY1kPLU+/Cu2QsJSy7tdLwL38xYRtt2tezi6/
         i2kFDUWnPky05QvZgm/I6HZov7dUopRheWqGjCAlCKaJIhvHNY57LMW6ABd3uKbnMDPv
         8p8A9ZKBJGSsS9ny8tdecSfkkv1ZAbLyn6i4s+hLi+Ht4xaYsNi9ZjIDYgmqLF9wi29X
         7n5bwl0pSguRFKtiZGubb/8cy2Cw2f3bcWOhb1ohQ4QzUUGLJKUoMdqLy27+EgCa7lAy
         EGTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791802902; x=1792407702;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CEM49n9jNQ/heZjJVbHJseSZWYtO87nODkEzEO1JHt4=;
        b=1WtsduNEn6u3IJxGbOaSBwULVxkhQgr1W3y086SL8yw9rnIZRRoy4A2o8P96Bhuy1P
         m2rSrldNXRFJdYwl/kYVf/0Dvgn7VfmV1krDWc5Fvj2amFZ/xzlVFGgZzXz9Lyagqs8a
         2KGyjylR2g3GaiJucLzd/fMQDpex6KzEG6WkEUapdXCTngOZKgKp20OttS7diNjmJISW
         eaTnVpQOk78BQjhNE4mKA7lCqYrLaGnE7HfvGxgD+Ey2UoJ9knw628p90VPuSIqBZF++
         14b97w+zpZr7klZSettq7OjaKls+gDgqj7pvEni7rw8nKppJCLChbaQripEauayB/7cg
         bM2Q==
X-Forwarded-Encrypted: i=1; AKwUvBzDMSlIcJfMgJQjjDKAzowqTVD8gjPdS/j4rB+3MENR6muo4VVJNGq6EwMuUshUCGe+c9iqenTEKBo=@vger.kernel.org
X-Gm-Message-State: AFq9FYIpDNNpCTdY992Nrvg/b4luH5//xGaU2eFi7otssf5+1FgLizP5
	b9HFOyixWZo8SaCVbm8MrO352dq7jrAxvMX8b9X9B4AL2KCHsp/Tb2w1
X-Gm-Gg: AYBFou1tqSU7HmVWkEnmdmZeILwCcV5SCFlsk1OOud8pcaYJGhMCKzgLbayvOAwbE0B
	1RUMXduUP1QL3geKIdSz3MtMqK8bI6gUECKv9IYMnk1/tMZgmTzG0R+16mdJGifsk5Mghfpv0DP
	1yqa6GPEYqBmgJL/WVVkLKRrFOwnEomEUl1mJ8lz2+tg8p5RcyDGCSFGpR5YP3ML2JICy2fhwhe
	AeMg8+4mzJoTU4uszLyQRNc0Vi7uvwHZntSx0c6Os5h1vZGpfrZbArf7u38FBKsKzb9eKgZBeoM
	npjGFnZ1NtpTgOokqWll8BG4LrnGNLkthvhBWrOVTgYuTqks0P2qU7z9X8QUSI1GAE61/K40xt4
	PlxtoxbEckslvF69DJaMLxVgrkY/nFB4d9ZrCF+esBq+J1TFmOdGHfqB8XTSLIrVK5JNXl9nZUS
	LJKconJrRtE0LtQehYvmSR9LLLquohqDJRQPCUakLn1OKE166DDiPtPGUvsr7+hpAqMOg2uu3Hu
	TKDimQQviJVZlrXnQ==
X-Received: by 2002:a05:6512:10c1:b0:5bc:b8f0:7a0d with SMTP id 2adb3069b0e04-5bcde6ad47cmr2964752e87.47.1791802901463;
        Mon, 12 Oct 2026 04:01:41 -0700 (PDT)
Received: from [10.38.18.54] ([213.255.186.37])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bcdde9a79fsm2779809e87.30.2026.10.12.04.01.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2026 04:01:40 -0700 (PDT)
Message-ID: <5b8b9ffc-253f-442f-8f16-88ab712bd442@gmail.com>
Date: Mon, 12 Oct 2026 14:01:38 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/12] iio: light: use named initializers for
 acpi_device_id
To: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Andy Shevchenko <andy@kernel.org>, Petre Rodan
 <petre.rodan@subdimension.ro>, Matteo Martelli <matteomartelli3@gmail.com>,
 Marius Cristea <marius.cristea@microchip.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Alex Lanzano
 <lanzano.alex@gmail.com>, Jagath Jog J <jagathjog1996@gmail.com>,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
 Kevin Tsai <ktsai@capellamicro.com>, Eddie James <eajames@linux.ibm.com>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux@analog.com, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261005-acpi-iio-v1-0-2796f713945a@thegoodpenguin.co.uk>
 <20261005-acpi-iio-v1-7-2796f713945a@thegoodpenguin.co.uk>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20261005-acpi-iio-v1-7-2796f713945a@thegoodpenguin.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/10/2026 17:02, Pawel Zalewski wrote:
> Use a designated initializer for the acpi_device_id fields which makes the
> code more readable and consistent with how lists are initialized in the
> rest of the kernel code base. Also drop explicitly setting fields to 0
> where it is redundant.
> 
> Signed-off-by: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

> ---
>   drivers/iio/light/acpi-als.c   | 2 +-
>   drivers/iio/light/al3320a.c    | 2 +-
>   drivers/iio/light/apds9960.c   | 2 +-
>   drivers/iio/light/cm32181.c    | 2 +-
>   drivers/iio/light/isl29018.c   | 6 +++---
>   drivers/iio/light/jsa1212.c    | 2 +-
>   drivers/iio/light/ltr501.c     | 4 ++--
>   drivers/iio/light/max44000.c   | 2 +-
>   drivers/iio/light/pa12203001.c | 2 +-
>   drivers/iio/light/rpr0521.c    | 2 +-
>   drivers/iio/light/stk3310.c    | 6 +++---
>   drivers/iio/light/us5182d.c    | 2 +-
>   12 files changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iio/light/acpi-als.c b/drivers/iio/light/acpi-als.c
> index 1983a7f17aa9..9faaffb94b8f 100644
> --- a/drivers/iio/light/acpi-als.c
> +++ b/drivers/iio/light/acpi-als.c
> @@ -238,7 +238,7 @@ static void acpi_als_remove(struct platform_device *pdev)
>   }
>   
>   static const struct acpi_device_id acpi_als_device_ids[] = {
> -	{"ACPI0008", 0},
> +	{ .id = "ACPI0008" },
>   	{ }
>   };
>   
> diff --git a/drivers/iio/light/al3320a.c b/drivers/iio/light/al3320a.c
> index 8bb7f7e878c2..1610a09ee204 100644
> --- a/drivers/iio/light/al3320a.c
> +++ b/drivers/iio/light/al3320a.c
> @@ -259,7 +259,7 @@ static const struct of_device_id al3320a_of_match[] = {
>   MODULE_DEVICE_TABLE(of, al3320a_of_match);
>   
>   static const struct acpi_device_id al3320a_acpi_match[] = {
> -	{"CALS0001"},
> +	{ .id = "CALS0001" },
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(acpi, al3320a_acpi_match);
> diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
> index afe520de60e2..996ab9a9ee27 100644
> --- a/drivers/iio/light/apds9960.c
> +++ b/drivers/iio/light/apds9960.c
> @@ -1158,7 +1158,7 @@ static const struct i2c_device_id apds9960_id[] = {
>   MODULE_DEVICE_TABLE(i2c, apds9960_id);
>   
>   static const struct acpi_device_id apds9960_acpi_match[] = {
> -	{ "MSHW0184" },
> +	{ .id = "MSHW0184" },
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(acpi, apds9960_acpi_match);
> diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
> index b32a94028f09..8b376e5a9f08 100644
> --- a/drivers/iio/light/cm32181.c
> +++ b/drivers/iio/light/cm32181.c
> @@ -527,7 +527,7 @@ MODULE_DEVICE_TABLE(of, cm32181_of_match);
>   
>   #ifdef CONFIG_ACPI
>   static const struct acpi_device_id cm32181_acpi_match[] = {
> -	{ "CPLM3218", 0 },
> +	{ .id = "CPLM3218" },
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(acpi, cm32181_acpi_match);
> diff --git a/drivers/iio/light/isl29018.c b/drivers/iio/light/isl29018.c
> index 759cb71ed1c5..3463da0f7a98 100644
> --- a/drivers/iio/light/isl29018.c
> +++ b/drivers/iio/light/isl29018.c
> @@ -820,9 +820,9 @@ static DEFINE_SIMPLE_DEV_PM_OPS(isl29018_pm_ops, isl29018_suspend,
>   				isl29018_resume);
>   
>   static const struct acpi_device_id isl29018_acpi_match[] = {
> -	{"ISL29018", isl29018},
> -	{"ISL29023", isl29023},
> -	{"ISL29035", isl29035},
> +	{ .id = "ISL29018", .driver_data = isl29018 },
> +	{ .id = "ISL29023", .driver_data = isl29023 },
> +	{ .id = "ISL29035", .driver_data = isl29035 },
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(acpi, isl29018_acpi_match);
> diff --git a/drivers/iio/light/jsa1212.c b/drivers/iio/light/jsa1212.c
> index 038ee49723ae..8a08cc468872 100644
> --- a/drivers/iio/light/jsa1212.c
> +++ b/drivers/iio/light/jsa1212.c
> @@ -421,7 +421,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(jsa1212_pm_ops, jsa1212_suspend,
>   				jsa1212_resume);
>   
>   static const struct acpi_device_id jsa1212_acpi_match[] = {
> -	{"JSA1212", 0},
> +	{ .id = "JSA1212" },
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(acpi, jsa1212_acpi_match);
> diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
> index fa0d16890c8b..5d2d020ddbc0 100644
> --- a/drivers/iio/light/ltr501.c
> +++ b/drivers/iio/light/ltr501.c
> @@ -1589,9 +1589,9 @@ static int ltr501_resume(struct device *dev)
>   static DEFINE_SIMPLE_DEV_PM_OPS(ltr501_pm_ops, ltr501_suspend, ltr501_resume);
>   
>   static const struct acpi_device_id ltr_acpi_match[] = {
> -	{ "LTER0301", ltr301 },
> +	{ .id = "LTER0301", .driver_data = ltr301 },
>   	/* https://www.catalog.update.microsoft.com/Search.aspx?q=lter0303 */
> -	{ "LTER0303", ltr303 },
> +	{ .id = "LTER0303", .driver_data = ltr303 },
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(acpi, ltr_acpi_match);
> diff --git a/drivers/iio/light/max44000.c b/drivers/iio/light/max44000.c
> index 8c344f1b3fe2..2d25bdcfe5ae 100644
> --- a/drivers/iio/light/max44000.c
> +++ b/drivers/iio/light/max44000.c
> @@ -603,7 +603,7 @@ static const struct i2c_device_id max44000_id[] = {
>   MODULE_DEVICE_TABLE(i2c, max44000_id);
>   
>   static const struct acpi_device_id max44000_acpi_match[] = {
> -	{"MAX44000", 0},
> +	{ .id = "MAX44000" },
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(acpi, max44000_acpi_match);
> diff --git a/drivers/iio/light/pa12203001.c b/drivers/iio/light/pa12203001.c
> index c0f4db8d95f7..657ba24def38 100644
> --- a/drivers/iio/light/pa12203001.c
> +++ b/drivers/iio/light/pa12203001.c
> @@ -450,7 +450,7 @@ static const struct dev_pm_ops pa12203001_pm_ops = {
>   };
>   
>   static const struct acpi_device_id pa12203001_acpi_match[] = {
> -	{ "TXCPA122", 0 },
> +	{ .id = "TXCPA122" },
>   	{ }
>   };
>   
> diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
> index 7d82efc31f3a..b429c7b8b0fb 100644
> --- a/drivers/iio/light/rpr0521.c
> +++ b/drivers/iio/light/rpr0521.c
> @@ -1095,7 +1095,7 @@ static const struct dev_pm_ops rpr0521_pm_ops = {
>   };
>   
>   static const struct acpi_device_id rpr0521_acpi_match[] = {
> -	{"RPR0521", 0},
> +	{ .id = "RPR0521" },
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(acpi, rpr0521_acpi_match);
> diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
> index 7c8a1d2b2ed0..37ae90c84779 100644
> --- a/drivers/iio/light/stk3310.c
> +++ b/drivers/iio/light/stk3310.c
> @@ -775,9 +775,9 @@ static const struct i2c_device_id stk3310_i2c_id[] = {
>   MODULE_DEVICE_TABLE(i2c, stk3310_i2c_id);
>   
>   static const struct acpi_device_id stk3310_acpi_id[] = {
> -	{"STK3013", 0},
> -	{"STK3310", 0},
> -	{"STK3311", 0},
> +	{ .id = "STK3013" },
> +	{ .id = "STK3310" },
> +	{ .id = "STK3311" },
>   	{ }
>   };
>   
> diff --git a/drivers/iio/light/us5182d.c b/drivers/iio/light/us5182d.c
> index ab518311fd79..5d05c751e13f 100644
> --- a/drivers/iio/light/us5182d.c
> +++ b/drivers/iio/light/us5182d.c
> @@ -941,7 +941,7 @@ static const struct dev_pm_ops us5182d_pm_ops = {
>   };
>   
>   static const struct acpi_device_id us5182d_acpi_match[] = {
> -	{ "USD5182", 0 },
> +	{ .id = "USD5182" },
>   	{ }
>   };
>   
> 


-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
