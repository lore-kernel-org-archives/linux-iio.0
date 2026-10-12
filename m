Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF503ACA75
	for <linux-iio@vger.kernel.org>; Mon, 12 Oct 2026 10:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791802783; cv=none; b=nexwNIhZhUFPb2Qp5XH95Xx65RFE9AYhbjX99uBQxduMbR4k6iewXON4apv/20C+cD/4m/jPcWeuYdQMZZZCViOeLq+fCpj+QaapGYrxuCHkl1Gfcu7ark4e6itcraHTAKI/FtQ1GNu+wuBDIkVQQxfcAxzTjtVaNV4tjQys2zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791802783; c=relaxed/simple;
	bh=JNdkwsN9mKG5s80Hayzz3iqHN1gn4QXycCdqtQwzPOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LZSZTy8H0WDMbxGefe0oZV01f7y3Uxi6o1cDBh9+LgT/r90hzGbxhF0M2hpS+V9Di0eexTs451SUVXz5hWH4RlWqFtePMDswAmvwGtUB9JeuSsoNu5dWPdEBiMX2VKr4WYONMPJEwjMZef6CVj5TybDiNXO6ftKSt3YGQ6fx3ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=suadkW7Z; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="suadkW7Z"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5bcdae234ecso1411413e87.3
        for <linux-iio@vger.kernel.org>; Mon, 12 Oct 2026 03:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791802779; x=1792407579; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0qnEU84YF8PSCGZ6iR0YW1qhJf2uOek5OJUUyQ0jzAo=;
        b=suadkW7ZqFJgUBjWysX26gOQLPNGyEZFgfgUW/5g9wnUb/OjznyEyWfiTD8nyTF/29
         vJ5k3Hrltxrz/cwZzwjlxa41/g8Crn5Cak4vusFzdUGjZh64mCuGYxg/b0J/9tvPVKa5
         QLAb0nJ/QsdVmD/xpNCrwVSK1Tl04krw2D5XIjeVEkMlhqhGUZuVXHjaLJtG12htkRtO
         +/oaLH9cIqcChIWsVQeUdYuqAGzY3jtZoXCGXmlrInB9IlbeZ8sLyq1jccHaPsG91s7j
         hOvGVc3x5dMFWYTtBpNf1xpx8AwySlmMHLq7nsOIVT/BUParl3oF9NKXyVh5QrWEsZFK
         oblQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791802779; x=1792407579;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0qnEU84YF8PSCGZ6iR0YW1qhJf2uOek5OJUUyQ0jzAo=;
        b=vy70768A9usZ1T9lPn+viVFMit0feNm/1TT3J/MQ90rLL4xjcD0s+BlU4o0QDgBxWe
         isMaQay1aDIVa1//n4HiraAlKTSEiq0UOzhXhB0PSN1wxeDjVQkRGPC8WzHlImZvp/FY
         njUsZSy4d6jFeWbAR/DJHewRXO/F8YngOsxIpr++2s46ZXQHdRn9ukO8tBjz+LDZo6+8
         UVSusq6nM/IiTw0Hy4eRNXQJzcYWWZ+KHvNkfOmRIoyy8WmXdR4Aaz1xT/mDivVTU10M
         lfwR7EIeWfFA9dTsbZ672JW69u5IuYUhAkOtqRr9XsfdjJbKAYozTA/tRAbuezb+ZYvB
         r6FQ==
X-Forwarded-Encrypted: i=1; AKwUvBxrsT+Ax7/OfD3auF3HwkJrV3h077wEldrhdKOW+oZjZ6jmGJK2FPaelPo2/uwzRHU0c5M5y8d3p1k=@vger.kernel.org
X-Gm-Message-State: AFq9FYLL4ADbKylvqrX8L5Hmz6Rvura8QOlDKp3TefZgxcSATm/0C4uK
	qaw6DZcYdiYg5+YDneUhRNrZ3qEDk7ExPQmzyaVow7RbKZKFdaymBO7J
X-Gm-Gg: AYBFou36C77chqz9LqCLnLn+UDUZxnhz7Ldc/t+efxIhLw4QOS+NyxrhWhYLe7Fu2tp
	IMCDq2nl6cWlVV/8Uf6R0wPPWxcP6dou8WoYJzYKsOtBrXG2pmEEEgcitV2+JUF9EZtxM96ECPo
	0xfkH5Ekh63gW4UR97wOehVwASUV0T+nq3cp2RtZRXDxhMGZtHgkC8mVTwH6tyCvI5iS9sAwg2Z
	YRkAdidxs7rECrwsZOaaR30qoCN6FvZC7BtNDYxX5KUyC/G1xy2PoZB+kDqRcvn8Bal4sneZVpT
	UrsdT4zqTGZ2kLKVAY9NnToNvc0eufi8IBKxgul17yK31vP2TTQgvMeUjs+oUcM+luJ/Rike8Um
	GZKhdDf7GNoTbTi1F5qcrmjNkuzkp7wregT113EAw4x5+wQDin7VYHK7Bfr9zz4kx6VkAiM7IuV
	5ebm8QNW8HpzmP10kiVrYX9e19Pnv/P152Cj39VS2Gboo3eT6ELu7szc9TYixe11DSgeu4vOhhI
	5M1ejYu
X-Received: by 2002:a05:6512:3e13:b0:5bc:ec69:5f9d with SMTP id 2adb3069b0e04-5bcec696144mr1852966e87.33.1791802779170;
        Mon, 12 Oct 2026 03:59:39 -0700 (PDT)
Received: from [10.38.18.54] ([213.255.186.37])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bce8aecad1sm2030317e87.8.2026.10.12.03.59.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2026 03:59:38 -0700 (PDT)
Message-ID: <67b5d1a0-23fd-4da8-bc7f-53acaaa6460c@gmail.com>
Date: Mon, 12 Oct 2026 13:59:37 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] iio: accel: use named initializers for
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
 <20261005-acpi-iio-v1-1-2796f713945a@thegoodpenguin.co.uk>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20261005-acpi-iio-v1-1-2796f713945a@thegoodpenguin.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/10/2026 17:01, Pawel Zalewski wrote:
> Use a designated initializer for the acpi_device_id fields which makes the
> code more readable and consistent with how lists are initialized in the
> rest of the kernel code base. Also drop explicitly setting fields to 0
> where it is redundant.
> 
> Signed-off-by: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

> ---
>   drivers/iio/accel/adxl345_i2c.c      |  2 +-
>   drivers/iio/accel/adxl345_spi.c      |  2 +-
>   drivers/iio/accel/bma220_spi.c       |  2 +-
>   drivers/iio/accel/bmc150-accel-i2c.c | 24 ++++++++++++------------
>   drivers/iio/accel/bmc150-accel-spi.c | 16 ++++++++--------
>   drivers/iio/accel/da280.c            |  4 ++--
>   drivers/iio/accel/kxcjk-1013.c       | 22 +++++++++++-----------
>   drivers/iio/accel/mma7660.c          |  2 +-
>   drivers/iio/accel/mma9551.c          |  2 +-
>   drivers/iio/accel/mma9553.c          |  2 +-
>   drivers/iio/accel/mxc4005.c          |  6 +++---
>   drivers/iio/accel/mxc6255.c          |  4 ++--
>   drivers/iio/accel/st_accel_i2c.c     |  4 ++--
>   drivers/iio/accel/stk8ba50.c         |  2 +-
>   14 files changed, 47 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl345_i2c.c b/drivers/iio/accel/adxl345_i2c.c
> index 511fb610436c..609b5d881097 100644
> --- a/drivers/iio/accel/adxl345_i2c.c
> +++ b/drivers/iio/accel/adxl345_i2c.c
> @@ -57,7 +57,7 @@ static const struct of_device_id adxl345_of_match[] = {
>   MODULE_DEVICE_TABLE(of, adxl345_of_match);
>   
>   static const struct acpi_device_id adxl345_acpi_match[] = {
> -	{ "ADS0345", (kernel_ulong_t)&adxl345_i2c_info },
> +	{ .id = "ADS0345", .driver_data = (kernel_ulong_t)&adxl345_i2c_info },
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(acpi, adxl345_acpi_match);
> diff --git a/drivers/iio/accel/adxl345_spi.c b/drivers/iio/accel/adxl345_spi.c
> index 4fa1b04f75b6..e916ca9cc854 100644
> --- a/drivers/iio/accel/adxl345_spi.c
> +++ b/drivers/iio/accel/adxl345_spi.c
> @@ -74,7 +74,7 @@ static const struct of_device_id adxl345_of_match[] = {
>   MODULE_DEVICE_TABLE(of, adxl345_of_match);
>   
>   static const struct acpi_device_id adxl345_acpi_match[] = {
> -	{ "ADS0345", (kernel_ulong_t)&adxl345_spi_info },
> +	{ .id = "ADS0345", .driver_data = (kernel_ulong_t)&adxl345_spi_info },
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(acpi, adxl345_acpi_match);
> diff --git a/drivers/iio/accel/bma220_spi.c b/drivers/iio/accel/bma220_spi.c
> index d6c1087cc3c0..5c4de5af69ac 100644
> --- a/drivers/iio/accel/bma220_spi.c
> +++ b/drivers/iio/accel/bma220_spi.c
> @@ -30,7 +30,7 @@ static const struct spi_device_id bma220_spi_id[] = {
>   };
>   
>   static const struct acpi_device_id bma220_acpi_id[] = {
> -	{ "BMA0220", 0 },
> +	{ .id = "BMA0220" },
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(spi, bma220_spi_id);
> diff --git a/drivers/iio/accel/bmc150-accel-i2c.c b/drivers/iio/accel/bmc150-accel-i2c.c
> index 336866aad20c..4041825c068d 100644
> --- a/drivers/iio/accel/bmc150-accel-i2c.c
> +++ b/drivers/iio/accel/bmc150-accel-i2c.c
> @@ -14,8 +14,8 @@
>   
>   #ifdef CONFIG_ACPI
>   static const struct acpi_device_id bmc150_acpi_dual_accel_ids[] = {
> -	{"BOSC0200"},
> -	{"DUAL250E"},
> +	{ .id = "BOSC0200" },
> +	{ .id = "DUAL250E" },
>   	{ }
>   };
>   
> @@ -216,13 +216,13 @@ static void bmc150_accel_remove(struct i2c_client *client)
>   }
>   
>   static const struct acpi_device_id bmc150_accel_acpi_match[] = {
> -	{"BMA0255"},
> -	{"BMA0280"},
> -	{"BMA222"},
> -	{"BMA222E"},
> -	{"BMA250E"},
> -	{"BMC150A"},
> -	{"BMI055A"},
> +	{ .id = "BMA0255" },
> +	{ .id = "BMA0280" },
> +	{ .id = "BMA222" },
> +	{ .id = "BMA222E" },
> +	{ .id = "BMA250E" },
> +	{ .id = "BMC150A" },
> +	{ .id = "BMI055A" },
>   	/*
>   	 * The "BOSC0200" identifier used here is not unique to devices using
>   	 * bmc150. The same "BOSC0200" identifier is found in the ACPI tables
> @@ -236,9 +236,9 @@ static const struct acpi_device_id bmc150_accel_acpi_match[] = {
>   	 * seen. This allows the bmi323 driver to take over for ASUS ROG ALLY,
>   	 * and other devices using the bmi323 chip.
>   	 */
> -	{"BOSC0200"},
> -	{"BSBA0150"},
> -	{"DUAL250E"},
> +	{ .id = "BOSC0200" },
> +	{ .id = "BSBA0150" },
> +	{ .id = "DUAL250E" },
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(acpi, bmc150_accel_acpi_match);
> diff --git a/drivers/iio/accel/bmc150-accel-spi.c b/drivers/iio/accel/bmc150-accel-spi.c
> index 405bd7b2d199..8014d8caa4a4 100644
> --- a/drivers/iio/accel/bmc150-accel-spi.c
> +++ b/drivers/iio/accel/bmc150-accel-spi.c
> @@ -39,14 +39,14 @@ static void bmc150_accel_remove(struct spi_device *spi)
>   }
>   
>   static const struct acpi_device_id bmc150_accel_acpi_match[] = {
> -	{"BMA0255"},
> -	{"BMA0280"},
> -	{"BMA222"},
> -	{"BMA222E"},
> -	{"BMA250E"},
> -	{"BMC150A"},
> -	{"BMI055A"},
> -	{"BSBA0150"},
> +	{ .id = "BMA0255" },
> +	{ .id = "BMA0280" },
> +	{ .id = "BMA222" },
> +	{ .id = "BMA222E" },
> +	{ .id = "BMA250E" },
> +	{ .id = "BMC150A" },
> +	{ .id = "BMI055A" },
> +	{ .id = "BSBA0150" },
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(acpi, bmc150_accel_acpi_match);
> diff --git a/drivers/iio/accel/da280.c b/drivers/iio/accel/da280.c
> index 15acbe1c2cbd..d5ad981cfbc0 100644
> --- a/drivers/iio/accel/da280.c
> +++ b/drivers/iio/accel/da280.c
> @@ -155,8 +155,8 @@ static const struct da280_match_data da226_match_data = { "da226", 2 };
>   static const struct da280_match_data da280_match_data = { "da280", 3 };
>   
>   static const struct acpi_device_id da280_acpi_match[] = {
> -	{ "NSA2513", (kernel_ulong_t)&da217_match_data },
> -	{ "MIRAACC", (kernel_ulong_t)&da280_match_data },
> +	{ .id = "NSA2513", .driver_data = (kernel_ulong_t)&da217_match_data },
> +	{ .id = "MIRAACC", .driver_data = (kernel_ulong_t)&da280_match_data },
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(acpi, da280_acpi_match);
> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> index 8994c9e8e048..73d23d36cc11 100644
> --- a/drivers/iio/accel/kxcjk-1013.c
> +++ b/drivers/iio/accel/kxcjk-1013.c
> @@ -1649,19 +1649,19 @@ static const struct of_device_id kxcjk1013_of_match[] = {
>   MODULE_DEVICE_TABLE(of, kxcjk1013_of_match);
>   
>   static const struct acpi_device_id kx_acpi_match[] = {
> -	{ "KIOX0008", (kernel_ulong_t)&kxcj91008_info },
> -	{ "KIOX0009", (kernel_ulong_t)&kxtj21009_info },
> -	{ "KIOX000A", (kernel_ulong_t)&kxcj91008_info },
> +	{ .id = "KIOX0008", .driver_data = (kernel_ulong_t)&kxcj91008_info },
> +	{ .id = "KIOX0009", .driver_data = (kernel_ulong_t)&kxtj21009_info },
> +	{ .id = "KIOX000A", .driver_data = (kernel_ulong_t)&kxcj91008_info },
>   	/* KXCJ91008 in the display of a yoga 2-in-1 */
> -	{ "KIOX010A", (kernel_ulong_t)&kxcj91008_kiox010a_info },
> +	{ .id = "KIOX010A", .driver_data = (kernel_ulong_t)&kxcj91008_kiox010a_info },
>   	/* KXCJ91008 in the base of a yoga 2-in-1 */
> -	{ "KIOX020A", (kernel_ulong_t)&kxcj91008_kiox020a_info },
> -	{ "KXCJ1008", (kernel_ulong_t)&kxcj91008_info },
> -	{ "KXCJ1013", (kernel_ulong_t)&kxcjk1013_info },
> -	{ "KXCJ9000", (kernel_ulong_t)&kxcj91008_info },
> -	{ "KXJ2109",  (kernel_ulong_t)&kxtj21009_info },
> -	{ "KXTJ1009", (kernel_ulong_t)&kxtj21009_info },
> -	{ "SMO8500",  (kernel_ulong_t)&kxcj91008_smo8500_info },
> +	{ .id = "KIOX020A", .driver_data = (kernel_ulong_t)&kxcj91008_kiox020a_info },
> +	{ .id = "KXCJ1008", .driver_data = (kernel_ulong_t)&kxcj91008_info },
> +	{ .id = "KXCJ1013", .driver_data = (kernel_ulong_t)&kxcjk1013_info },
> +	{ .id = "KXCJ9000", .driver_data = (kernel_ulong_t)&kxcj91008_info },
> +	{ .id = "KXJ2109", .driver_data = (kernel_ulong_t)&kxtj21009_info },
> +	{ .id = "KXTJ1009", .driver_data = (kernel_ulong_t)&kxtj21009_info },
> +	{ .id = "SMO8500", .driver_data = (kernel_ulong_t)&kxcj91008_smo8500_info },
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(acpi, kx_acpi_match);
> diff --git a/drivers/iio/accel/mma7660.c b/drivers/iio/accel/mma7660.c
> index 38b4df76cff3..1ad7b2206e33 100644
> --- a/drivers/iio/accel/mma7660.c
> +++ b/drivers/iio/accel/mma7660.c
> @@ -270,7 +270,7 @@ static const struct of_device_id mma7660_of_match[] = {
>   MODULE_DEVICE_TABLE(of, mma7660_of_match);
>   
>   static const struct acpi_device_id mma7660_acpi_id[] = {
> -	{"MMA7660", 0},
> +	{ .id = "MMA7660" },
>   	{ }
>   };
>   
> diff --git a/drivers/iio/accel/mma9551.c b/drivers/iio/accel/mma9551.c
> index 7e01427fd9c4..bb74dfa538b8 100644
> --- a/drivers/iio/accel/mma9551.c
> +++ b/drivers/iio/accel/mma9551.c
> @@ -572,7 +572,7 @@ static const struct dev_pm_ops mma9551_pm_ops = {
>   };
>   
>   static const struct acpi_device_id mma9551_acpi_match[] = {
> -	{"MMA9551", 0},
> +	{ .id = "MMA9551" },
>   	{ }
>   };
>   
> diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
> index 8e7aaac89d47..202aa91518b5 100644
> --- a/drivers/iio/accel/mma9553.c
> +++ b/drivers/iio/accel/mma9553.c
> @@ -1208,7 +1208,7 @@ static const struct dev_pm_ops mma9553_pm_ops = {
>   };
>   
>   static const struct acpi_device_id mma9553_acpi_match[] = {
> -	{"MMA9553", 0},
> +	{ .id = "MMA9553" },
>   	{ }
>   };
>   
> diff --git a/drivers/iio/accel/mxc4005.c b/drivers/iio/accel/mxc4005.c
> index a66fee828ec1..1559888e0995 100644
> --- a/drivers/iio/accel/mxc4005.c
> +++ b/drivers/iio/accel/mxc4005.c
> @@ -561,9 +561,9 @@ static int mxc4005_resume(struct device *dev)
>   static DEFINE_SIMPLE_DEV_PM_OPS(mxc4005_pm_ops, mxc4005_suspend, mxc4005_resume);
>   
>   static const struct acpi_device_id mxc4005_acpi_match[] = {
> -	{"MXC4005",	0},
> -	{"MXC6655",	0},
> -	{"MDA6655",	0},
> +	{ .id = "MXC4005" },
> +	{ .id = "MXC6655" },
> +	{ .id = "MDA6655" },
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(acpi, mxc4005_acpi_match);
> diff --git a/drivers/iio/accel/mxc6255.c b/drivers/iio/accel/mxc6255.c
> index a9f41cf27ad9..7b4d63a8bde1 100644
> --- a/drivers/iio/accel/mxc6255.c
> +++ b/drivers/iio/accel/mxc6255.c
> @@ -163,8 +163,8 @@ static int mxc6255_probe(struct i2c_client *client)
>   }
>   
>   static const struct acpi_device_id mxc6255_acpi_match[] = {
> -	{"MXC6225",	0},
> -	{"MXC6255",	0},
> +	{ .id = "MXC6225" },
> +	{ .id = "MXC6255" },
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(acpi, mxc6255_acpi_match);
> diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
> index 99522a885d71..6d4b7d46869d 100644
> --- a/drivers/iio/accel/st_accel_i2c.c
> +++ b/drivers/iio/accel/st_accel_i2c.c
> @@ -130,8 +130,8 @@ static const struct of_device_id st_accel_of_match[] = {
>   MODULE_DEVICE_TABLE(of, st_accel_of_match);
>   
>   static const struct acpi_device_id st_accel_acpi_match[] = {
> -	{"SMO8840", (kernel_ulong_t)LIS2DH12_ACCEL_DEV_NAME},
> -	{"SMO8A90", (kernel_ulong_t)LNG2DM_ACCEL_DEV_NAME},
> +	{ .id = "SMO8840", .driver_data = (kernel_ulong_t)LIS2DH12_ACCEL_DEV_NAME },
> +	{ .id = "SMO8A90", .driver_data = (kernel_ulong_t)LNG2DM_ACCEL_DEV_NAME },
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(acpi, st_accel_acpi_match);
> diff --git a/drivers/iio/accel/stk8ba50.c b/drivers/iio/accel/stk8ba50.c
> index 6c1e286c0a1d..2ae9a97524cc 100644
> --- a/drivers/iio/accel/stk8ba50.c
> +++ b/drivers/iio/accel/stk8ba50.c
> @@ -528,7 +528,7 @@ static const struct i2c_device_id stk8ba50_i2c_id[] = {
>   MODULE_DEVICE_TABLE(i2c, stk8ba50_i2c_id);
>   
>   static const struct acpi_device_id stk8ba50_acpi_id[] = {
> -	{"STK8BA50", 0},
> +	{ .id = "STK8BA50" },
>   	{ }
>   };
>   
> 


-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
