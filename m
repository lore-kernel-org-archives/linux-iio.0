Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C5F3B6366
	for <linux-iio@vger.kernel.org>; Tue, 19 May 2026 07:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779174717; cv=none; b=FRkDkeHrn9cXcknHcJImUtLmKrp0qXsqI5KdC5qECj6dHWCpMwEnz4Jb8MQsNq3IFHcurD9UqkQs8fyLyXMGS7nSipmk7UkoAd4Hh4hDXDalaJDvOEYofiHGH+A7mmt6NOM7wyqToXar0SUv7DlbsFhMcxFU4U9fDd4zZmcTPHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779174717; c=relaxed/simple;
	bh=wztDeudGoUAJK/W//ID8zMxaTkHI3uWCRMPOPLm6LPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dDE1aPvV/Uoxws4I8dU5qLJ7/kXgOUl/xAMZxES4lRXDmJ9L+J7GLciP1VE+de9PIDtpwnlpr3KRGp3utn4eNs8IM4if/xvHqKZ3CwpOjFIkY3BmqGAeXy8X4UoJSkeYEFIYMX/orC9kL0O2OQaOBtcoBgN0y3GLIzoHTTaksjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mjUlCDP8; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mjUlCDP8"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43d75312379so2737925f8f.1
        for <linux-iio@vger.kernel.org>; Tue, 19 May 2026 00:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779174712; x=1779779512; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xjjvfitJbUO5+jLc8/tMROrf3YtISQkTQKy+IqYQDo8=;
        b=mjUlCDP8YywlfT2Esou3YpzxuaFoN5/JbU+g+6VrJp+vUJV4lNc4SSvZBElyAQQPVA
         +sAp+/Ad5PTx9ciAtr/H0L5pne24TINvTB6ZoQAkQtHm5yD9bsrJroWRxg4Y1fgIMOKC
         nRZQqc8VifCzIWfFs2ztXStM4SriFAFWXf7TrXJiA5GMq0v9mDiUY+aZHckT0NuK6xbo
         TVZObx2uCcg1c6MajmAsVmmmONfHtWtGOskWf/5o6hsMPFO7SARiCBhqKM6GxpSZ0l+B
         vddLXOPMLVCDVqkzar2xXwehUOzvUXHBGGmKUTFsyJmF8a8iSsbFumCf4qtBwMNHq5rM
         g+cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779174712; x=1779779512;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xjjvfitJbUO5+jLc8/tMROrf3YtISQkTQKy+IqYQDo8=;
        b=cYm1QetmjLtEjl0qo1Nzqj+w6YYkDNuqvr+d+NN9qz4qfoQNIAMw6KwfHN/jwj+aLb
         5uE2tLfCQYa7JKwM/8bFTku3qOei+I8kiwo08x7hhL28z6c/gthFIF4AiVn1YqePyzT9
         uIj5e27HcKb7+1Kj2rD4wUl1iyOn+C1zOwU+7zSf+F3e2gShJQMs9zXanjGTenRBjuGy
         oBnX9QSQhc1eh406EAqaApgd+R2w32WEfqs8y4o8CiMNyj7woWXj0szEjrgZklw5YK69
         vilE1Zz3LqkmR7q1dScSMNAtLiigz0tAVoJj5SYCuo/mYSvXXWPnG1qNrQp16QDLAJ8z
         vsPA==
X-Gm-Message-State: AOJu0Yx2/d9CAlFK1jS93bEzt9mNNrWMrWIQJkXJXep9OgzfTb7rCzLp
	mNnFGPGowbAAwLiRNiCxT4i5g3dtoXG+qn6SPYBdQGkWETN+WkH0iJN9
X-Gm-Gg: Acq92OGq3g2HjyarraYZxhCLYqQp6jzm0lrO9rjU8TfQRwLdYAbtjA+4lhZ/c0ZX+FO
	9VXJ3d+z/yUmormQnSGHm8vR6xQAFsmcwMyVxazple8HJ7Fo1tjmBkFPF/nu6UfB8Qfee+7gElG
	BxgYmJAZ4tMXhEtouzFtWEvRNvPRWHoV7x8hwB/pCKhnWdQTqSsS+fMX1zlOB33pCOtKK73wyr2
	bMy6+VCn6bGXKgR5YhLDZFHYKSoEqgVRQod5QVktOZ5Pbs3RXRnFgMw2/KsYEvcY0GySt9XBXzG
	1xRPap7PkTdSQotSFQAezo5ItBD9tPYNWq4OjB8Vagozr5IgCKs5qkpP6o/ZCdkLaKFYv+eWhlU
	71RmGxPrADo00JsRRYVRTe+PgPHT7RwQjvUApUH7vL6baTotsrqQ0S1Zb2TE4wm8vHwOCoYRvJZ
	Spu+uMCNWn5/ZG0We/f3J12BxvZu9Ck+/GZkm6xYrdtSnLcR5pSEvZAnwNr3HKHbbQZL6U
X-Received: by 2002:a05:600c:a09:b0:485:3cef:d6ea with SMTP id 5b1f17b1804b1-48fe539198fmr259597035e9.13.1779174712366;
        Tue, 19 May 2026 00:11:52 -0700 (PDT)
Received: from ?IPV6:2a02:3033:6d8:15d8:ec15:f5ad:b85f:a3b8? ([2a02:3033:6d8:15d8:ec15:f5ad:b85f:a3b8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe53ab671sm309396375e9.1.2026.05.19.00.11.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 00:11:52 -0700 (PDT)
Message-ID: <739f50f4-b2f5-4e5f-8d1b-d5a6429ece28@gmail.com>
Date: Tue, 19 May 2026 09:11:49 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] iio: dac: Add AD5529R DAC driver support
To: David Lechner <dlechner@baylibre.com>,
 Janani Sunil <janani.sunil@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20260508-ad5529r-driver-v2-0-e315441685d7@analog.com>
 <20260508-ad5529r-driver-v2-2-e315441685d7@analog.com>
 <2f74e76e-b066-40ac-9cb4-c75137c9825d@baylibre.com>
Content-Language: en-US
From: Janani Sunil <jan.sun97@gmail.com>
In-Reply-To: <2f74e76e-b066-40ac-9cb4-c75137c9825d@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 5/16/26 21:35, David Lechner wrote:
> On 5/8/26 6:55 AM, Janani Sunil wrote:
>> Add support for AD5529R 16-channel, 12/16 bit Digital to Analog Converter
>>
> ...
>
>
>> +		.realbits = (bits),				\
>> +		.storagebits = 16,				\
>> +	},							\
>> +}
>> +static struct regmap *ad5529r_get_regmap(struct ad5529r_state *st, unsigned int reg)
>> +{
>> +	if (reg <= AD5529R_8BIT_REG_MAX)
>> +		return st->regmap_8bit;
>> +
>> +	return st->regmap_16bit;
>> +}
> Another way we have done this is make custom read/write functions for the
> regmap itself so that we don't have to have two regmaps.

Dual regmap approach was chosen here because:

1) It leverages regmap's val_bits validation and endianness for 16 bit registers, rather than
implementing them manually.

2) The two distinct register banks- 8 bit and 16 bit map naturally to the separate regmap configs

3) Each regmap has a focused rd_table/wr_table ranges matching the hardware, rather than a complex unified table

The routing overhead is just an address comparison, similar to what custom functions would need, but with automatic validation
and endianness handling

Best Regards,
Janani Sunil

