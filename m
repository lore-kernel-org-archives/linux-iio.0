Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDE843B6E1
	for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 14:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783951390; cv=none; b=mRheo/p5F4NayONEEJsWjsnDAMoWFgZlcjnj5eZt54sTgo/sXubMIEgMbBGyQe2tDNQnS8RAk3MUGjPskYLvx/ASkFmD/tVjjhe/3djVMdh/4GzPkqwXxKRc+e3Qcc/Winu95PLLudRqenYnyuj1nEGG5Xw4S8V057fb5sdDt4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783951390; c=relaxed/simple;
	bh=B6WjnvCrK6/g7JAvoKzBLs20OUCfFEZT7MWjp6RCyAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ae/+eFKtiq+tFZz3bZnWRGK34J9PiuMIrEGGrLTwfEseMkK0n5n9iECE9EqpmUVp9SMA/0Y9gNztiE51c1vN5tMp4Yt1TO65PJhmicYC7vFrwsPc/zSV+BZSV6TrAuw8gdHNlHOa2lvB4mddmFxFyde8wUld6mkcXP8+qp7xk68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=LN+T1r+o; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="LN+T1r+o"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6a324d200c2so1699682eaf.3
        for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 07:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783951387; x=1784556187; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=USI3SP6Q69jN7B9GXwZfFvnMWl9QRJgz2pabjPWKcBc=;
        b=LN+T1r+omTIpn7xf2i+DYXtf41Q0FA3YL/uXvHuFav9hytNuEbDXwIVOr0PDa2a3fV
         UWCgbcR7UXsyMPEMPwW3O9NvvFo52qKjkf4FZe2+GzRXfUE1grHTDG4YipfN5bexc0iL
         19MG4Z2YQ+syo6CoAqloQK02+5KziDYeDR0tRZrNppdtqLcM4m6kxyrT34ynQOaYttkk
         /+msMOUy0YuwV9oVrmIZe5F3JQRDEfzAB8ijRBWcFhzeuq8uVVio8Uud5NFxtwAS7kie
         WI3Enks6sZghkiodRuklJdNqCHEeu+KKYJewZhP0tFJzdqJDOa2U00/QbCjFud3bvu2j
         ipqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783951387; x=1784556187;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=USI3SP6Q69jN7B9GXwZfFvnMWl9QRJgz2pabjPWKcBc=;
        b=Kz45Aw2pnHvaXHIe+LV5hhZrcZ6TkvNbrUhpOY8hTyX5Vvfy8jKGCAo6xSb1J1mUGM
         T8vQC+2XbjsB8NcKvF9j0UpixOt2Yznqxx1zJusL25arFw7Mt2QJuu7l3199H1CF2FvE
         mmSMh+A1H4gaOYwSuMXQzfyJOhIsfm4ozTVSIASf+wZfFlpW96Kj4r5vXL0A9YuW5AoE
         7TpSTJN8HzyuuMZSyWDDhQM39LD6WWESM0dwg7WRqQeCoZW9UXy9kRb9mUvGCIpIM4hm
         SsyzJWl5SieyAFoPm27y9UytH/FxRQ1hZPIVOwyIzBIGhYz42T6uS46Bq7Vmjn1K7x2C
         mz5g==
X-Forwarded-Encrypted: i=1; AFNElJ/xvigqnQoqEjRlv0qovuDM6z6oaMgyMgVWH5C5kIf86H7WKDggc1GYiCBjqXABXEq5M7ls8gMqhJE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk8KLvwPFtDmXbW+3RfIGxVKuQXP2YiufZuQjLXkR986YpaAO5
	jU0AZ8CnuY/mHFFb2g0DPIkGxfbPCZdJMZAGy4+MQv4AI5pJVVW6gjG/fJ98GQHc5AQ=
X-Gm-Gg: AfdE7cl/KhBTvIWgQptNSQDOlvJ10hKKCMEhzS3PAFwmgeLEARzENHGNaNGNi6vFE5L
	N7SOVCjUOWVRS71WpZUvXfmNXc+pQOYtFs0SjIpM/dKCmPcE+i0lYou2emrKO+I6fJf1y0iWb+C
	Cte5um3TbFB+5ICaB3grBoJAxWtZ5HOBfcE3Pv8zR/y6wGmgnIpdP5bhKpDs1B8/Ydqu4h4npsa
	712WLslh98Q9rwcm9FuJFTIB9hg7fAqIYmc4CNa5Fl+Ru1o3BkUOyZ+1tOh6sP9UW4u0yGTRK+X
	0D9Sqz3xMUNDXV01VRPhQIv0LwEp2PUlSxBVFG3VTde1afewA95doMPH0suTDLdhFNJF2c9ofq/
	G/Jnh62QIlopGm7NRWTwqI6VARO4UzPQqN/tJ6eRki/z7/8ydE5JrZA2MfIGVaBE14fte775GaQ
	QeNBdTCpUAy9FxipIsz996YdKo/rD9qTRRPwS1nH3XDdT6AYXze/49Z51LFLQFvZw=
X-Received: by 2002:a05:6820:3107:b0:6a3:90c1:c81f with SMTP id 006d021491bc7-6a39a6e8567mr5519131eaf.45.1783951386802;
        Mon, 13 Jul 2026 07:03:06 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:610b:e45c:5e0c:e14b? ([2600:8803:e7e4:500:610b:e45c:5e0c:e14b])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a384e0eb80sm7042114eaf.12.2026.07.13.07.03.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 07:03:05 -0700 (PDT)
Message-ID: <7d01660f-2b42-4602-97fd-29a80cb2ac45@baylibre.com>
Date: Mon, 13 Jul 2026 09:03:04 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/8] iio: adc: add ti-ads112c14 driver
To: Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chris Hall <c-hall@ti.com>,
 Patrick Edwards <pedwards@ti.com>, Kurt Borja <kuurtb@gmail.com>,
 Nguyen Minh Tien <zizuzacker@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260710-iio-adc-ti-ads122c14-v3-0-746d52cbf1d0@baylibre.com>
 <20260710-iio-adc-ti-ads122c14-v3-6-746d52cbf1d0@baylibre.com>
 <20260713031110.55ab2764@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260713031110.55ab2764@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/12/26 9:11 PM, Jonathan Cameron wrote:
> On Fri, 10 Jul 2026 17:50:39 -0500
> "David Lechner (TI)" <dlechner@baylibre.com> wrote:
> 
>> Add a new driver for the TI ADS112C14/ADS122C14 ADC chips.
>>

...

>> +			 info->device_id,
>> +			 FIELD_GET(ADS112C14_DEVICE_ID_BITS, reg_val));
>> +
>> +	/* Place in single-shot conversion mode to make ready for raw read. */
> Writing a bit called conv mode puts it in single-shot?  (sashiko) 

Sashiko didn't read the datasheet. The options are continuous conversion
mode (0) or single-shot conversion mode (1).

It isn't obvious from the bit name which one is active when the bit
is set, hence the comment.

> 
>> +	ret = regmap_set_bits(data->regmap, ADS112C14_REG_DEVICE_CFG,
>> +			      ADS112C14_DEVICE_CFG_CONV_MODE);
> 
> Thanks,
> 
> Jonathan
> 
> 

