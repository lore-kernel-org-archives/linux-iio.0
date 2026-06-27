Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936153101B2
	for <linux-iio@vger.kernel.org>; Sat, 27 Jun 2026 23:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782601674; cv=none; b=MnoHI0GEM01PsHVCbnAhVFAxEXHHue4Vcl1zJsFMAhjSSXkDojVNDUBGHR9sj4DCbPvY01G/hH5cKVdEeCKjGDOhpTt5kW18CoMglV/n28vkDEGc6mZWjf+53HqpRNtsoLIohttT7QvIa986nSQZlhdozDICQpfCIJzMvr64aEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782601674; c=relaxed/simple;
	bh=VQ44ILHIV2O85VTtEGTGB7wZvz2epBn0TnEyzRRxmQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KcOUUpXR45dwbKpfYWT91X3DsHYl+b99twGXc6M8y549TnH7k1Ht9+a8j2zyeJubnSiQGae8cZKigU2Q0mGctvAGErP8X2fFj+tX8miIIItLl3AcgmNw6TIAyIX3lvkiHdqFcNgTKDmNL1X+wbvpsDSZbAQ8BAOtDlyo3PQFHJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=LzCivVRc; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="LzCivVRc"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7e93cd4e64bso1684361a34.2
        for <linux-iio@vger.kernel.org>; Sat, 27 Jun 2026 16:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782601671; x=1783206471; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sc0LVF54eIDE0MT2UAxiqee+b3f/jtlBzR5Bzv0cEZU=;
        b=LzCivVRc+N/RTK7U5Hnt/1q8otnrXAcPDZZwYQjOVs2F7xHIje97lyjvvavT5czD8Z
         omgFpwF8kxgUYKqMB4wyZaTJdI8aqeGMrvVUipysLVTThe6NTE5j8qyLy1R/QtLh5jCF
         4uYUkY5XvsfQFCI1NIY67OzlAT3X/UaI3K2O8fn/4q3ia4vvHfqjqevL9GpNyMz03srS
         kfsnjr9HJhTaAjlCAQF/tTFaGk0tN5RvAP7HIC7pkGEsz1MrK9G2Z04p4Bvok0bZh5tG
         uAyC+pot8Fy+8cugOMcBUqTbmWuem7vkqB3kejXdgnGklaR+ofCTsCt5Uz9MV4t/MUAz
         oWlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782601671; x=1783206471;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sc0LVF54eIDE0MT2UAxiqee+b3f/jtlBzR5Bzv0cEZU=;
        b=ZG9OvxElNUBaOzJQpVQ971ytbeZqRoREv+no5LrayRIYGuTRCQv84tN7eR16IxwyWo
         cZomoKJ/jZ6YPSev/RX3lZuzT6rLc3325eSzSaiG8vWM+FHQGiHOCzYBkIX7bW5h/4Dl
         TjCdVQtFkZGr5i8td/YJXA18CKsIMmj8i5IlUVU6wYO4GV+qAbFlfB3uDoF65Cod4akI
         9ZYjkdB+yrLAwDA99VSyIDzPYitEirWkbOAl0U4LJe964UVQaF1NOF46tOg4xQVdfzxO
         5vFft6aPtj9UoVJFtvzl5KhIO/XrzR+iJDUj//Q80w44JEC6jTs+YCWjpjo7zXPxqR9n
         4ddQ==
X-Gm-Message-State: AOJu0YxtFlrtQ/1vuDM+2N0VMmcrThJusX3bBy6T7hMjFW8I37FwrmSa
	0p+d65N45ONVWHLyG83M/fEKb2/dE6dvENa9I5zULZ2JKaabvp22UIPPnLdMceON+no=
X-Gm-Gg: AfdE7cngLkXimFp8f505ISskLqwxzhffIFh33/K9G97iW0mApbZEgv6cczpEw+PJQGI
	LGZgcX9989aGzCM7ZuOvTJfDs26PI/1f002K2KVOdsLCPA4ZNM3UYH1v1S8X8c1WjsCZEMUZ9jm
	Cw5rJgVoNW+yVTdiSiIzlTPzXGsV1Cj5tsfZ/AjhfK6cEfbf7UeubkjjTn3USmaojzu0ompLLRu
	hIY8WFkK8508ZVGtrnj3loiGgbqZkHgyJtn3nsVYTbpuorh8mmxeUI5BWNeljX88Kh6ZgMBYdYl
	y0FnFOf3KMynQnAKncJGqDa/49tUF+g0+VAgVljxvPoqBssfzyLnRYOdOY5iGuGajYl0o+jGC5B
	RRGsB2YxLpojpu3HZwOg6ylCziQZIwVDGeute7kJaf/2tuwgrJTZwTI0iejDKMwGBgnkx1QV8c2
	MY7UvHaXpaCzST6995YfjDLb3nbK9JMsh51gN0BR27qZU5dceUKaLhNLjAcyWPyIw=
X-Received: by 2002:a05:6830:349f:b0:7e5:f957:a61f with SMTP id 46e09a7af769-7e99c268898mr11379368a34.18.1782601671671;
        Sat, 27 Jun 2026 16:07:51 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:f242:ecd6:f61e:d764? ([2600:8803:e7e4:500:f242:ecd6:f61e:d764])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e9b292029dsm3861948a34.22.2026.06.27.16.07.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Jun 2026 16:07:50 -0700 (PDT)
Message-ID: <6770a7af-06cc-4240-9b20-c299e7080ab1@baylibre.com>
Date: Sat, 27 Jun 2026 18:07:49 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] iio: adc: add Axiado SARADC driver
To: Petar Stepanovic <pstepanovic@axiado.com>, Akhila Kavi
 <akavi@axiado.com>, Prasad Bolisetty <pbolisetty@axiado.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260622-axiado-ax3000-ax3005-saradc-v3-0-e57c7c7ae675@axiado.com>
 <20260622-axiado-ax3000-ax3005-saradc-v3-2-e57c7c7ae675@axiado.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260622-axiado-ax3000-ax3005-saradc-v3-2-e57c7c7ae675@axiado.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/22/26 2:47 AM, Petar Stepanovic wrote:
> Add support for the SARADC controller found on Axiado AX3000 and
> AX3005 SoCs.
> 

...

> +#define AX_SARADC_CH(_index, _id)                                       \
> +	{                                                               \
> +		.type = IIO_VOLTAGE,                                    \
> +		.indexed = 1,                                           \
> +		.channel = (_index),                                    \
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),           \
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),   \
> +		.datasheet_name = (_id),                                \

This could probably be:

		.datasheet_name = "adc" #_index,

and avoid the need for _id.

> +	}
> +
> +static const struct iio_chan_spec axiado_saradc_iio_channels[] = {
> +	AX_SARADC_CH(0, "adc0"),   AX_SARADC_CH(1, "adc1"),
> +	AX_SARADC_CH(2, "adc2"),   AX_SARADC_CH(3, "adc3"),
> +	AX_SARADC_CH(4, "adc4"),   AX_SARADC_CH(5, "adc5"),
> +	AX_SARADC_CH(6, "adc6"),   AX_SARADC_CH(7, "adc7"),
> +	AX_SARADC_CH(8, "adc8"),   AX_SARADC_CH(9, "adc9"),
> +	AX_SARADC_CH(10, "adc10"), AX_SARADC_CH(11, "adc11"),
> +	AX_SARADC_CH(12, "adc12"), AX_SARADC_CH(13, "adc13"),
> +	AX_SARADC_CH(14, "adc14"), AX_SARADC_CH(15, "adc15"),

Two columns looks a bit odd.

> +};
> +
> +static void axiado_saradc_disable(void *data)
> +{
> +	struct axiado_saradc *info = data;
> +
> +	writel(AX_SARADC_GLOBAL_CTRL_PD, info->regs + AX_SARADC_GLOBAL_CTRL_REG);

People usual make read and write wrappers or use regmap to avoid having
to write `info->regs + AX_SARADC_GLOBAL_CTRL_REG` so many times.

> +}
