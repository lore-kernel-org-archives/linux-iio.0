Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322AB2DAFD7
	for <linux-iio@vger.kernel.org>; Sat,  7 Feb 2026 18:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770487779; cv=none; b=ctyOkcgWIQGCJKHsQnt3MNByu/JUqbE8soEfeKapkOyrHaLpyYxqou3XT4x2FMgagmEXmND5n/kwyIdV/uTk0RkkWLI99X1//tpgW4hszqBFMvKqBuchEEi74JSeE4j4H2f2ss/zr5w4nBlEiBSsz0LnJ+9lKAFPix302wdzK9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770487779; c=relaxed/simple;
	bh=Z1RlCkvjAKV6GMKhbwoWjgZvhZGNQ0TOlPqMxvRH9eY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NxjnGiGVo+TZNZUnz1u/9w3055IPnRibGoRzDsWn+hdyojSCvKWW6M2I1ieyqubZf4trD31stvicUZnejHXEJtqwr6Wex3bmPMZ1KTNsoxeBVOMzR8hqW6Tgk1bn8IN0Xnt6Gxjkpesk2UwgPdjjAXlzv67JEOkbBOpRAIid9zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=YasdDXT+; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YasdDXT+"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-4086661715cso2346123fac.2
        for <linux-iio@vger.kernel.org>; Sat, 07 Feb 2026 10:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770487778; x=1771092578; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=doeEscZbmqUzRLkmGbD2wulpXvhEwLpY3gZ7s/QLWDw=;
        b=YasdDXT+PSQGxVL4yqiV6baqDWcuTn+aeYlC+08D6q3bByU6qswlUJW1KJvBtFfb8G
         ddtfvmCXJoFMI8tHG61s7X+7EFfJD0mgiXEPxghWHI5g42E2/crplxnXzmXurq/drRAA
         zek9l3gXbx1r0F8SPaEbUxDTGs/75oBfhJgLq8degjPmTGBWglKMfvPvQ9ZHA2UQsavj
         yk9Hhw8lwi4K31syJ7STbd1o57+POIfmgrJfgYaSywTWdi4UVmeg7jgR+e1Oi/JkrSa0
         /CikZAy0wJzfW6f/2MZ8A6EZvnzrahxEvfj/7YHUIHbATVWzqD0oBLLLwAkUnaUNF4Pb
         WM/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770487778; x=1771092578;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=doeEscZbmqUzRLkmGbD2wulpXvhEwLpY3gZ7s/QLWDw=;
        b=hYaYGD0BxEHDBNN1zWKXRaZ8vjEQ2mkLbw8EVY9EjOvdNL6bbhVhS6NUVahwlrF2dy
         SWEvChOoOAyfoRNkz7BjSO1JUDFgDSvMXlFeb6B9y777WaHHom/oUa8k/nKHKl5UASjn
         b1UlkoCto5jBT/9CsihooLAYOw/4cmwdb5eJcyf+7EzwYhIEpYeK8x7wBsUYxpdeoxsL
         Lr5QwoiHZuOHwrYARv1l8w7f5iNcU/q96y8QGq/qZNFHPQpHhJlQp/RL3fE5V7O8SLOl
         byYDnufsJyVntDnCCeOiRYwYoSQYQJ+Ug3dMtTZ5KZ3uIIIt1L7KCF4jnm/AIExdieRE
         lTzw==
X-Forwarded-Encrypted: i=1; AJvYcCXYfEGqQlnmwbQ5iRP8hYgiIdOJ8suV28WOZIa9vR/V5RmhIIgOecYyfqt1H7lU5WoTR0pDbpZG/ic=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYSsbWLtKO2/TK4BxF2cG5pWOwyhzrS0RsLczp9k9fYfDb1U2e
	ZFbx/udnmfgmKUGHwqq3FkMcf4soVBfvSqsYfiDogUUx64WRSFbHksulYhsou8Yt6QS0lyFJJwp
	szpay
X-Gm-Gg: AZuq6aKpFF0uqNsIyniM8reocLUSxxfMwjo0eXIqpUi86fnrqyAgPC7t0Vt4IxJOmgt
	kFpjyP0PBpTc02VJH5KWln+f2CYqA0BF3s2HNNOansvS9wx4ysbgpOLQBSKJIL0XMhOD73ZbEjR
	aPp+KICxrMDT6wa+CUAP+pAI61slE19yl6MPK0O5b08O8OhRTt2i8FHyPQRQp36QeeIEGI9f9LM
	INHsD6zkAwSPnrU1r2C/ZjBAmM0eT+Ei6q3xtz7WJf13g4rJEmyEpjFkywSVx/RSQxzlG+iH8NW
	76syMDoRqHLx02TH2vKQ3RU0Sq2ur8Kopdhp0clCN0m1r7NlGjhoCDVqc6mwj80LmKbFcC4I0Ng
	OiG1GCoLt8Klora3HPRp3Bpg+qTK311nDG24J5TSj0VisACNT+P5uTRvrxi1hq7Nh85LBsoixaF
	lrRCIMEKBvNSZQz4djKEqj763AbX3CiCAlEdxpMcu0yrNKjQp62Y0xSya8IgGUVlPgGkKe
X-Received: by 2002:a05:6870:799a:b0:3ec:321c:b2ac with SMTP id 586e51a60fabf-40a9777b8c4mr3621662fac.37.1770487778043;
        Sat, 07 Feb 2026 10:09:38 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:74a6:843b:f33:21ae? ([2600:8803:e7e4:500:74a6:843b:f33:21ae])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-40a99787738sm4509503fac.15.2026.02.07.10.09.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Feb 2026 10:09:36 -0800 (PST)
Message-ID: <8fbfcf7c-4acd-4a7f-a5a5-34baad84e1b2@baylibre.com>
Date: Sat, 7 Feb 2026 12:09:34 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] spi: allow ancillary devices to share parent's
 chip selects
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>, Mark Brown
 <broonie@kernel.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
References: <cover.1770393792.git.antoniu.miclaus@analog.com>
 <bcb1eb34fc5e86fd5dbb4472ad1d3ea3cf3e9779.1770393792.git.antoniu.miclaus@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <bcb1eb34fc5e86fd5dbb4472ad1d3ea3cf3e9779.1770393792.git.antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/6/26 10:07 AM, Antoniu Miclaus wrote:
> When registering an ancillary SPI device, the current code flags a chip
> select conflict with the parent device. This happens because the
> ancillary device intentionally uses one of the parent's chip selects,
> but __spi_add_device() checks against all existing devices including
> the parent.
> 
> Allow this by passing the parent device pointer to __spi_add_device()
> and skipping the conflict check when the existing device is the parent.
> 

...

>  static int spi_dev_check(struct device *dev, void *data)
>  {
>  	struct spi_device *spi = to_spi_device(dev);
> -	struct spi_device *new_spi = data;
> +	struct spi_dev_check_info *info = data;
> +	struct spi_device *new_spi = info->new_spi;
>  	int status, idx;
>  
> +	/*
> +	 * When registering an ancillary device, skip checking against the
> +	 * parent device since the ancillary is intentionally using one of
> +	 * the parent's chip selects.
> +	 */
> +	if (info->parent && spi == info->parent)

spi should never be NULL (or we would get a segfault later), so
if `(spi == info->parent)` should be enough.

> +		return 0;
> +
Reviewed-by: David Lechner <dlechner@baylibre.com>

