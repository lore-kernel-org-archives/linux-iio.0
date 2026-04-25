Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8602383C8D
	for <linux-iio@vger.kernel.org>; Sat, 25 Apr 2026 23:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777159000; cv=none; b=uJK53LlURz2zRpBvHT1OhIOJTaVnIo/HBs+eBk5x37HizMw+JRhBSHShAMLuKwsTIN4WqrOK6j6nD12pJGw8IkRaOW2vIlo8IRFsec5lYkz1JhJd9+MwBbN30KTk5ukXZQRjDtQSPzLfO79LVUYzQZWV6CJ8LDcqLUZW/K7jwes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777159000; c=relaxed/simple;
	bh=xP7Ns6dk4fQo7Ggpkw/E8cMNYkXHjD23P9eLBVpFFoI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iORyThUAHyMlkngm1V15xDfYj/hYXglRClZUby44bzX90Ast1DEYcAd8PAnhcs5dRcB9zjtwxq+e6JZecoLxCxwDwIu1Kw5JG/OheTgpO/SaWnUR/srfB0GXa3yxPj3QhIX+OwVmOGjTujWrwLJYKgwBm9cF5A3zrecmLjDW+UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=UqtTTv64; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="UqtTTv64"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7de431da8fbso3296883a34.1
        for <linux-iio@vger.kernel.org>; Sat, 25 Apr 2026 16:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777158997; x=1777763797; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VYlUw8CjlWV2yawR9xZsFVoRO8akohuXMo1BK6k/g/c=;
        b=UqtTTv64Rico02Zgw/iMbqhIDj8KC9DkNacQBzdwmBTlJAIJ6IT8HuuU3PZczkMVIv
         sMflK9FsuGUVeuDZu+oNAbrnmOW6WY6o0bJOd5pvGF254UZuQ2kbjqdiZUNTJTMcm/pc
         ZTP5KmSbDMFzDexVg7QkH8uX9TnLAAnnVl4SslUkdcSaVRZ29+Ve6Z1lgFuhdURz6C7I
         xlVMjsEKYn+XtrsVyCX6d4ssI2/N30nMnTTXI2pzvYRpSEfIriolUPySfdberT+86Fdl
         6B8E2j7slUNpwI8SRaWarqhaO8eVvYBzcMdURHYh5pSA58kL7VXCRLuQUzTux3FrWMPh
         8wpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777158997; x=1777763797;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VYlUw8CjlWV2yawR9xZsFVoRO8akohuXMo1BK6k/g/c=;
        b=dTyzeCNjhTAeYhKX0KBKnd/b8DZCRCc+M8mNxApomiUHBYHZ8j0HmyGkNpiSIlkeXA
         GusL3qYvXVIF/qJJOybTe9uNTVepFDkA56jg7H6lqtlEBIXs7p3ivcIy/tJChuWVonNk
         rss6GzNXRmSfJ0Y7/jWGf/HNaQoePM5xUIo0aaTurV6K5jdkGJc0a91yJDkzwHQnGb9Z
         RxXievpnZYMEEgc/GsiP5xjbpKnwFbUybQwOYotZb7B3M+BDkMOOhRye2Jb9uBOxwRiF
         4W51sVrn7wjCpDF7i/BEcYsZMJhQCDSs17ZzTx5CyWUSTT+GfFdEtve2LWQ3NnDRmPRY
         bBTw==
X-Forwarded-Encrypted: i=1; AFNElJ+7WCzodbyyjgZgp6K4zbA1NVqWU//f0Dgl3G5pLR4dgr2yxrW8qXeDfpJ8helLhnG+VfWI/Yax5WE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPghPUrlsFzYR8EzQWNsEGeraex/IhjbJTVXTvYWwPmevE5IR1
	yieiil3vm54bdu1k2xZ7QYWGPnEqwRt+SGctGpWrDKuYcrtjIRWy1XQPJUF8qAj25cpIyGtSglp
	VYWDW
X-Gm-Gg: AeBDietJwLK9RBy6rQwXqfmMbrEaUhP5hisb2+FnntXg1D5HMnaFmrOEzfggNvnuLK4
	sMIV37eCCvDu1nH1QBo52Yd0e+CRwRtqFRouOnE73CwWsk7xJZ/Dm874r8v+nSi4hZun97Js09J
	Ykw/LrR5mfFIHEM8/eLewbYgbdx9Q9UMZ6dBjmco9psyMvfUDQgc08XkbMozono0CJkyellqmOy
	Cm55FrrQLlfS4R2QBFF1M1adj9s4l7+0873+vwBHrM0kQwJpZwGw3J4Eg25rRkpB0ZRneNPZuEu
	lNU4sXRZR7e6q3lVSglj3xvmbtwUd5vbjWWn4pSbKOfTJGrD8orI2Y6nyc3JzGRCgdqrCAVQV9/
	p7PW/p9R9lZqXRfUpdfw4iqoMb4soOHNFDcRXcmce5a40rSBRzGaf7RNMz+bMBq8hmdr8d5ZLtF
	AF+dWGY568pcGp09j12dzYn+OTqXm67moMDBeuZcxTmbmHvbKXKhHJNUg9f83fxWeiIg1DIVz3W
	NEZvy/Nt/7a
X-Received: by 2002:a05:6830:6603:b0:7de:51f3:e7ed with SMTP id 46e09a7af769-7de51f3f011mr7023717a34.26.1777158996875;
        Sat, 25 Apr 2026 16:16:36 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:81f8:ef7d:a711:d99a? ([2600:8803:e7e4:500:81f8:ef7d:a711:d99a])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc97616c11sm22385834a34.25.2026.04.25.16.16.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Apr 2026 16:16:36 -0700 (PDT)
Message-ID: <754b6044-2285-4694-99d4-18d4fd5d8f6d@baylibre.com>
Date: Sat, 25 Apr 2026 18:16:34 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: meson-saradc: fix calibration buffer leak on
 error
To: Jonathan Cameron <jic23@kernel.org>
Cc: Felix Gu <ustc.gu@gmail.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Rosen Penev <rosenp@gmail.com>, linux-iio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260426-meson_saradc-v1-1-6e96b2982c43@gmail.com>
 <84cae83c-2d67-4927-aa40-6c416d4f862d@baylibre.com>
 <20260425194412.1872eff8@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260425194412.1872eff8@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/25/26 1:44 PM, Jonathan Cameron wrote:
> On Sat, 25 Apr 2026 11:17:18 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> On 4/25/26 11:07 AM, Felix Gu wrote:
>>> meson_sar_adc_temp_sensor_init() allocates a buffer with
>>> nvmem_cell_read(), but the old code leaked it if
>>> syscon_regmap_lookup_by_phandle() failed.
>>>
>>> Switch buf to __free(kfree) so all return paths release it.
>>>
>>> Fixes: d6f2eac64403 ("iio: adc: meson: no devm for nvmem_cell_get")
>>> Signed-off-by: Felix Gu <ustc.gu@gmail.com>
>>> ---
>>>  drivers/iio/adc/meson_saradc.c | 10 +++-------
>>>  1 file changed, 3 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
>>> index 23991a3612bd..9708ddcc4919 100644
>>> --- a/drivers/iio/adc/meson_saradc.c
>>> +++ b/drivers/iio/adc/meson_saradc.c
>>> @@ -786,7 +786,7 @@ static int meson_sar_adc_clk_init(struct iio_dev *indio_dev,
>>>  static int meson_sar_adc_temp_sensor_init(struct iio_dev *indio_dev)
>>>  {  
>>
>> Nice to see one of these cleanup.h patches that is actually fixing a bug.
> 
> It's not fixing anything as far as I can see.
> The syscon_regmap_lookup_by_handle() is earlier in the function and
> nvmem_cell_read() isn't called if that fails.
> 
> So this is just a code simplification and so small benefit if anything.
> 
> Maybe there is an old version that does things in a different order?

I just updated iio/testing today and I see return without kfree().

	priv->tsc_regmap = syscon_regmap_lookup_by_phandle(dev->of_node, "amlogic,hhi-sysctrl");
	if (IS_ERR(priv->tsc_regmap))
		return dev_err_probe(dev, PTR_ERR(priv->tsc_regmap),
				     "failed to get amlogic,hhi-sysctrl regmap\n");


> 
> 
>>
>> Should `#include <linux/cleanup.h>` though rather that relying on it being
>> included through another header.
>>
>> With that fixed...
>>
>> Reviewed-by: David Lechner <dlechner@baylibre.com>
>>
> 

