Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E8E3DB65F
	for <linux-iio@vger.kernel.org>; Fri, 10 Apr 2026 21:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775857134; cv=none; b=IhHwuRuRXGrMTP9MntldXdoXxRwgwHlrP1QfZtq6n1wFx/QBSL40dVlGXl7K+7buXhsmit/WjkOhnHJ8XJR+mUMmTmLgC+IaOuDNfze51UBbs0X2ZrYLvr/bIYtiMa/Rlz8giHvHcpTtFzLbUPKkLmG6IdW/vf5x0FgbEKAYVng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775857134; c=relaxed/simple;
	bh=AfxJCGuDwawedT7P4I/1sW7q39LqQw75gWL8s0+dAh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uyYI6N+UsdIenoWFCanvxPPYyfk3d7O4AFx+O+2vutaidtY60hrfWrceNr6nwIHrbOox9OxsLYacKurKt7+ZhoPbeEnBUxWbnT1kIm1ZK5loCrs2CfhpCswH5ZEx/KfbxaALKL1p6eMBfBUgDuCKMJYsNpTXJy+4ZMGEqlqPphU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=rowVptpZ; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="rowVptpZ"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7dbb6c072f1so2363926a34.2
        for <linux-iio@vger.kernel.org>; Fri, 10 Apr 2026 14:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775857130; x=1776461930; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eaFyqgC3R1GXm84D3GWzj8iqNT7a1oUcf/2QMWQlMeg=;
        b=rowVptpZ9UsLOgQik7lVyrdF6+0eY2gPqRnhkmcgu/6QsD99GYfkanNJsi2AKSIXD7
         88VqicmttTOrzlAWUidS213yc6pY8yVX8IksXXJQ3MYkEiGEiZxWpWQQecHNXXjq9/8C
         XZBGam90Cs62hlon1Ih5+sHpbdvigOtZMFLQXkSKX5xAlW7TuzoCZrozGYqMXrQCviuS
         79MPxY9ZkNpiu+PCEM6l4cEMO7buD0M6ZhQAqacUbbm57Nm5P50QuZBouVuGBMjAthKW
         eXNJ8GQEDbGefxYshH/1nBwLSFEoxuM+api7VjUBUmFZOgZdYjmBL9UPCFLvTpfkGy6T
         ctRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775857130; x=1776461930;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eaFyqgC3R1GXm84D3GWzj8iqNT7a1oUcf/2QMWQlMeg=;
        b=qYGEJyqYaF7OaTdCBX2OqsmhjqweGUYRyqRdo0MutWbXLTBlHzcwQfSOoxAqGNeiyq
         S8jIY9xmHWZA9pJsWy8fI8oOwy7PQWtq8UEUg0fH7srqV28JASJwID6zaCZ5sK0zofr9
         vlo7ubF4PS2l0KIquNsC16tc45U1CD5sw+VaCaqyT4XhExexrkBIrba3WiDAolEkbqnk
         gaEKAJQwZh3evGmIiveiuiJEqNnONDpaNkSLVfiKhQKzPwsbFbfZyoh5Of1vNOnr3Ue+
         mxkLF4qfA5LAzD4bV8V5NY2grD/6npf8qnpGvSNVOBMIuAv6GHWE5Nkfuequ/rC1jpqm
         uwnw==
X-Gm-Message-State: AOJu0Yx383+hA4qLIc8yfP5SPdHaTBjRZI9KT4gIJi94YyGPRjL06j1c
	zuqfe1ayvVu0uNrfsFsmDXLP8HMSnsHiSFfnLctsgWn4aY/3XPIx7/NOjm9MhqfjOe8=
X-Gm-Gg: AeBDievDDY49Cxh586SVAT+l8/Aa2BCSp59mULbHTdBWnsp+KJWlZ1wpJW3ensOImw5
	p0M/zIGRmbOgTlVjT/9MmhNT+SPq1LBzEC9l1hHzIt68sRN1K9L/36qfxJ1s8XUHbZixhmMw18Y
	SqCeAUjWvWbfY+I0NFkbHK/X8o6UyPBNhPRsMA5Cm1IuqxL4Z3Q8Z2EsOY9Fl4x9dzVnYDT5Xm6
	02SGOYLp/1RVxZmfwQNHTYixNXa8zUdkDfbcLM8EOQzWL0jfxEmCOk6XG0FM2NxbgkclPmaGbet
	sIGTX5DblK/W8ZLxHaRl8HsJs5LqF9NIrg1bhAKg/KGhhIVvWzx9Zrkj9qzZZq7+lm29/BTLcq0
	wdu7AythQ0Kra8WweiD/S8KAcatKWuJa8y1w2AAQ/rsCesX5qKqoeJifYb7tT/13CzQzZT5GWvV
	tbUyG9G6PvL83Yuf7ifSbDQK/DoyAb5t9FNAF8/Q7UQQT0gRred0FSTpvCLhi33H/Xpe4NaBcUy
	A==
X-Received: by 2002:a05:6830:498b:b0:7d7:f617:3573 with SMTP id 46e09a7af769-7dc27cbf49bmr3103286a34.10.1775857130046;
        Fri, 10 Apr 2026 14:38:50 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:b75d:2440:dc10:808b? ([2600:8803:e7e4:500:b75d:2440:dc10:808b])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc26941b7esm2736484a34.19.2026.04.10.14.38.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2026 14:38:49 -0700 (PDT)
Message-ID: <9c36ee85-12da-41e8-b9ab-e32b7ec29e75@baylibre.com>
Date: Fri, 10 Apr 2026 16:38:48 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 6/6] docs: iio: adc: ad4691: add driver documentation
To: radu.sabau@analog.com, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, Philipp Zabel
 <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org
References: <20260409-ad4692-multichannel-sar-adc-driver-v7-0-be375d4df2c5@analog.com>
 <20260409-ad4692-multichannel-sar-adc-driver-v7-6-be375d4df2c5@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260409-ad4692-multichannel-sar-adc-driver-v7-6-be375d4df2c5@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/9/26 10:28 AM, Radu Sabau via B4 Relay wrote:
> From: Radu Sabau <radu.sabau@analog.com>
> 
> Add RST documentation for the AD4691 family ADC driver covering
> supported devices, IIO channels, operating modes, oversampling,
> reference voltage, LDO supply, reset, GP pins, SPI offload support,
> and buffer data format.
> 
> Signed-off-by: Radu Sabau <radu.sabau@analog.com>
> ---
>  Documentation/iio/ad4691.rst | 283 +++++++++++++++++++++++++++++++++++++++++++
>  Documentation/iio/index.rst  |   1 +
>  MAINTAINERS                  |   1 +
>  3 files changed, 285 insertions(+)
> 
> diff --git a/Documentation/iio/ad4691.rst b/Documentation/iio/ad4691.rst
> new file mode 100644
> index 000000000000..a1012c8b78a3
> --- /dev/null
> +++ b/Documentation/iio/ad4691.rst
> @@ -0,0 +1,283 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +
> +=============
> +AD4691 driver
> +=============


One overall comment. This goes into driver implementation details quite a bit.
I think that is really better done as comments in the driver itself. And this
document should just focus on how to use the driver from the userspace point
of view.


> +Buffer data format
> +==================
> +
> +The IIO buffer data format (``in_voltageN_type``) is the same across all
> +paths: 16-bit unsigned big-endian samples with no shift.
> +
> ++-------------------------+-------------+----------+-------+
> +| Path                    | storagebits | realbits | shift |
> ++=========================+=============+==========+=======+
> +| Triggered buffer        | 16          | 16       | 0     |
> ++-------------------------+-------------+----------+-------+
> +| CNV Burst offload (DMA) | 16          | 16       | 0     |
> ++-------------------------+-------------+----------+-------+
> +| Manual offload (DMA)    | 16          | 16       | 0     |
> ++-------------------------+-------------+----------+-------+

Not sure this table is helpful since all values are the same everywhere.

Also, doesn't SPI offload have storagebits == 32?

> +
> +In the triggered-buffer path the SPI rx_buf for each transfer points directly
> +into the scan buffer, so the 16-bit big-endian result is written in place with
> +no additional copying.
> +

