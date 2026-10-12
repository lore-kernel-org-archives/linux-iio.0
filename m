Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A41D40B38C
	for <linux-iio@vger.kernel.org>; Mon, 12 Oct 2026 10:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791802627; cv=none; b=Epf76OTBO9YcOLbBwSEp99XrRnevOPH/MHGU9UCNNzRsjelAO9syN4WX58hS4RIh0QmkhCu6EuZZmJwZZ4yUmd+k1c3F3XcBXrXX1DOb1Pm8ZEqqKzA6RxXIegnvhZhcCMJMhwBWrEpozq+MxQ4SgIQ67zGNLvRnNT1yhg+AXNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791802627; c=relaxed/simple;
	bh=+Kwghjf/rv463wQXIoOWBVSA8BUeKd/tVrzPuIvSX0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MEQyAfLSA7ym/6JRez/avukxCD10ixTwvc9v9YE0oGM8af3D5NC4P8ERVQoPSQg645PJ3w+pr35V6MczN6KmEl+sHRoNyjEugqlUSgRQIxWo2nBJ6FHk+abyrBTa2Ay3xjoN6ZQVUceyTC3eGXNV7Pfv6aVC6aBkvSxYzUQm6v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AcklgTZk; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AcklgTZk"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5bc18f54abbso112365e87.1
        for <linux-iio@vger.kernel.org>; Mon, 12 Oct 2026 03:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791802623; x=1792407423; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m5RT28MpT6+q1R2WpqQezI1Rb4fVDyYZaNJF6kqXIHk=;
        b=AcklgTZk5m5BWJYCiPg4Yv1YlmVc31tvB/RIYqNwcRVImfS+cmYKiuV9FIs/EnBMnb
         uu6zKq5ZMyV1U9xAdArWMBv1VtQTB6qy/jma/yRaM8/uYUNEcaz2dImTKQB6PtYEpUSO
         sbAoJ9w2GLbPr4m4332ArE5VGsYVuY5BLqDXcYS7eFBwjK62aaEiRTgf5KEEuU0eUKTS
         h7e1A3hmpu4NDM0z1mo9ar7PtH8+6wdDFnpnCAJcfSGx27tEIAmvYtVI5ItnaqWjMh6I
         +0/rDWdQ69R0pp6GlbTRng5Yg98uvkQIQLVTxgN7wbqYzCI7bOtLUNlYUPytybRQEec1
         Q/2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791802623; x=1792407423;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m5RT28MpT6+q1R2WpqQezI1Rb4fVDyYZaNJF6kqXIHk=;
        b=si4vq7WZ+7OwPJhrxUbNTknefzI4BKzwDfn9SsFr5PpStauLYLXveYb/xQP9ObB+MA
         HnnmQ5SQYl31A1sxgTQM72P4Gm8ROqYKml2BfPB8tBhPsabMEwugkMzKSQrFR/tcZid3
         i77u2oGHiM4GMAdPzOmH3qnbg6XG3D9qG7U85xIPEJq1bUbBSOo1ibf1bYQqMLYxDWF8
         yuFc3QwtCewT2E3qACCVW8spmFRupmUoZjGzuf+4Gi0TKsdsY03m3m7HwAurWQrDqsCr
         s/3NV/XlSIW0TG8M0wQMs81Kiymtv21y3T/tzXWH/f6J+hqJZ5YKRHs11wLod+7a9pbI
         RY5A==
X-Forwarded-Encrypted: i=1; AKwUvBxJNr/5SmLRX5tDetm1clfx+8WwioAiUH94ZtfIjcfkA2oJbE32E2/MNAtyUrJpTZ8mLucMBce+kow=@vger.kernel.org
X-Gm-Message-State: AFq9FYIkwxsV6HA7aBME/KrQqCeEA7foy77LnBhArHFSuFCkzxxWbk+3
	dKFiTRKuDo6ZWqmfgYHTH3lr11LTueuHnU0keUzrjnb9JvyGa77EPPEh
X-Gm-Gg: AYBFou3b6DReMHbpt7XCfufY5JAvEFgc9rbFk01Lqd9laIQqYpNMzRNwthkCNL9sqEb
	c2YS4FtfG2vGW9bk8jvNHaQ+miusANSOhieO551/WJPco0BdI/riA/U5dl/ZabDeM+DIz/uSDQ5
	/cWdkuCIs5mx/Yj/ek8VU/UFZ/lLJx40IGn90Y8jIVRvMNVelRR+j1TwmTL1ZpS1jICmVuR3PdZ
	Yj8NKtVngPGmi2yEY+hdlyjFU3ARpfE/duhc/EO1GajSqZXsu5kvcg7du+5u+vY9+vDkLyal2xN
	rhlzmPFXCpnkrJFT2/+P6vKSL1cZc6UUhp+xcT2iNkINIWGUStUU+qSKEd6Zi6IzdYjS/0+J/yr
	zYEBuTR04LPGVFm53irNvS173bR+7aUmkRx8P27qfnMGvL+L7MUdSpBNdb/tDuZmFc+Ir4kq0En
	pTVk/+Swy/MSu9qsi3dt7nDwKN/VXgqVpETIi18smgJ9cgLiZidxEAy3kdkVmd5sueIxM8F0v/5
	nTinhw=
X-Received: by 2002:a05:6512:2354:b0:5bc:b5f3:4985 with SMTP id 2adb3069b0e04-5bcde8be329mr3270749e87.45.1791802623056;
        Mon, 12 Oct 2026 03:57:03 -0700 (PDT)
Received: from [10.38.18.54] ([213.255.186.37])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bcdde3655bsm2732370e87.6.2026.10.12.03.57.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2026 03:57:02 -0700 (PDT)
Message-ID: <930d92e6-dee8-468f-8b54-bcc0bf41ae28@gmail.com>
Date: Mon, 12 Oct 2026 13:57:01 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/12] iio: adc: use named initializers for acpi_device_id
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
 <20261005-acpi-iio-v1-2-2796f713945a@thegoodpenguin.co.uk>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20261005-acpi-iio-v1-2-2796f713945a@thegoodpenguin.co.uk>
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
>   drivers/iio/adc/ad7298.c        | 2 +-
>   drivers/iio/adc/pac1921.c       | 2 +-
>   drivers/iio/adc/pac1934.c       | 2 +-
>   drivers/iio/adc/ti-adc081c.c    | 2 +-
>   drivers/iio/adc/ti-adc108s102.c | 2 +-
>   drivers/iio/adc/ti-adc128s052.c | 2 +-
>   6 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7298.c b/drivers/iio/adc/ad7298.c
> index c669022b5dec..66b8ca4e3132 100644
> --- a/drivers/iio/adc/ad7298.c
> +++ b/drivers/iio/adc/ad7298.c
> @@ -347,7 +347,7 @@ static int ad7298_probe(struct spi_device *spi)
>   }
>   
>   static const struct acpi_device_id ad7298_acpi_ids[] = {
> -	{ "INT3494", 0 },
> +	{ .id = "INT3494" },
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(acpi, ad7298_acpi_ids);
> diff --git a/drivers/iio/adc/pac1921.c b/drivers/iio/adc/pac1921.c
> index f0bab94462f4..730416ba147b 100644
> --- a/drivers/iio/adc/pac1921.c
> +++ b/drivers/iio/adc/pac1921.c
> @@ -1322,7 +1322,7 @@ static const struct of_device_id pac1921_of_match[] = {
>   MODULE_DEVICE_TABLE(of, pac1921_of_match);
>   
>   static const struct acpi_device_id pac1921_acpi_match[] = {
> -	{ "MCHP1921" },
> +	{ .id = "MCHP1921" },
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(acpi, pac1921_acpi_match);
> diff --git a/drivers/iio/adc/pac1934.c b/drivers/iio/adc/pac1934.c
> index de59dc27c440..7e18a8728bd8 100644
> --- a/drivers/iio/adc/pac1934.c
> +++ b/drivers/iio/adc/pac1934.c
> @@ -1612,7 +1612,7 @@ MODULE_DEVICE_TABLE(of, pac1934_of_match);
>    * https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ApplicationNotes/ApplicationNotes/PAC1934-Integration-Notes-for-Microsoft-Windows-10-and-Windows-11-Driver-Support-DS00002534.pdf
>    */
>   static const struct acpi_device_id pac1934_acpi_match[] = {
> -	{ "MCHP1930", .driver_data = (kernel_ulong_t)&pac1934_chip_config[PAC1934] },
> +	{ .id = "MCHP1930", .driver_data = (kernel_ulong_t)&pac1934_chip_config[PAC1934] },
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(acpi, pac1934_acpi_match);
> diff --git a/drivers/iio/adc/ti-adc081c.c b/drivers/iio/adc/ti-adc081c.c
> index 2df8f1c21c2a..d222c5637a71 100644
> --- a/drivers/iio/adc/ti-adc081c.c
> +++ b/drivers/iio/adc/ti-adc081c.c
> @@ -205,7 +205,7 @@ MODULE_DEVICE_TABLE(i2c, adc081c_id);
>   
>   static const struct acpi_device_id adc081c_acpi_match[] = {
>   	/* Used on some AAEON boards */
> -	{ "ADC081C", (kernel_ulong_t)&adc081c_model },
> +	{ .id = "ADC081C", .driver_data = (kernel_ulong_t)&adc081c_model },
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(acpi, adc081c_acpi_match);
> diff --git a/drivers/iio/adc/ti-adc108s102.c b/drivers/iio/adc/ti-adc108s102.c
> index 10959e835cb8..316d2eb16991 100644
> --- a/drivers/iio/adc/ti-adc108s102.c
> +++ b/drivers/iio/adc/ti-adc108s102.c
> @@ -270,7 +270,7 @@ static const struct of_device_id adc108s102_of_match[] = {
>   MODULE_DEVICE_TABLE(of, adc108s102_of_match);
>   
>   static const struct acpi_device_id adc108s102_acpi_ids[] = {
> -	{ "INT3495", 0 },
> +	{ .id = "INT3495" },
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(acpi, adc108s102_acpi_ids);
> diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
> index 1899813c1aee..381e2121a2b7 100644
> --- a/drivers/iio/adc/ti-adc128s052.c
> +++ b/drivers/iio/adc/ti-adc128s052.c
> @@ -264,7 +264,7 @@ static const struct spi_device_id adc128_id[] = {
>   MODULE_DEVICE_TABLE(spi, adc128_id);
>   
>   static const struct acpi_device_id adc128_acpi_match[] = {
> -	{ "AANT1280", (kernel_ulong_t)&adc124s_config },
> +	{ .id = "AANT1280", .driver_data = (kernel_ulong_t)&adc124s_config },
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(acpi, adc128_acpi_match);
> 


-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
