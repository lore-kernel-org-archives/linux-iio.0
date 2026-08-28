Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D693F86F2
	for <linux-iio@vger.kernel.org>; Fri, 28 Aug 2026 09:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787910688; cv=none; b=O9DiauJURdRQfqjVbIobRROcDikAvQ7xI/i+iDM2RYQNh0pYOnz+ilzk9lAwcihUGzHpdLu2+eAmmrM+zziEhx/P9ECr6RTJippeYQG+Pms2ID/R2I70eV8YBh0RaIB9o6HkO44WGtvhFYnZ2Oap5V4uTVVo6cKaDRZumFAuYk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787910688; c=relaxed/simple;
	bh=YgKf8rPNlAy6eEsUqC5wwHsyqREJn1lfAA/Svf3ion4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kAXJrYsN9z37lbwZsBCLqy9YMhTikVil3FAToPY8+d1PonYYpAKEMyGxcjlAdqv4FnHGEZ+u3a+pNNGOTeYW6ecZPq4hTh+5JMvsNeKVVhEqdfqyqNkbqijHBbZrwZyPLDLG+0Lbic7+/DDAn3q7Z4c4meIUaxGT6YlyE6Q+9BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i3g6+0hr; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i3g6+0hr"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5b568dae0e8so1012545e87.0
        for <linux-iio@vger.kernel.org>; Fri, 28 Aug 2026 02:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787910680; x=1788515480; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jfr71wsqB8wCC6pMhB0diEVUU4Ylze5fQF263Bs69OM=;
        b=i3g6+0hr1EvHYn5xNRb02X9IuQLnRQbUnycJ+NxR8CsB9xSLQp4Q78Sj+2FspFVgtJ
         XfrkgI+5WuzPeNKO7k+SEY93yVELXV3kiPyvwsnUXssidCBq4x1Oa1RHCMJ5/21zhK+e
         Tx3PYg59YbKT/84naDZmDPKPmVdCsNueI6Gr1z/bFvuNelh0M8TZSYLGKEOEmSyI8FGE
         HoFeFg26oecP632Uc4bvWqBvCUFeCNV5AJ5H/VhH4XASJpmcXnQ6p8wurGar7ectiMoN
         rQZHcSxfOetnrTxCloD91WQU2sC8lYUKI8ZAZOkD7qM2rn007xsSEHNjacv/rH5OXRbp
         Ec1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787910680; x=1788515480;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jfr71wsqB8wCC6pMhB0diEVUU4Ylze5fQF263Bs69OM=;
        b=XFqlGgulMAWK/I/WxbcBvis6xCZRpvYSSHB/mgJPL2CNrvEXfmzqzMg5YMJY/hZFW2
         n5n929BRk4kuYp6Q6nlmmfSApjM0oX1SZnZOT9txfOTKw9tZxYW1VQeHA4hG05LhYpXf
         tTQgLTQjq7zpNHtn/80EpmlyBmaEe5sPxZ1Es5SQXSnkTDF6EKqjRlAGbScUh7aJPbZ1
         pQf1QSYgcs4mCj1PetsUcCSvhxoOGjUnP9c4wIbgbqZF+camJDCIUIl79QRgvGqOL8Xs
         Twq4T7Mx83/J2QU5a0j1gS9/U2lJtGj6nafz0Zg7+VNPQkdf9MwfrfERq///zUbbYiTY
         b2Ig==
X-Forwarded-Encrypted: i=1; AHgh+RqwQFFEYDSqPq7ye72wJRPlehT/qbrO96ioAknCgM5Ga9h9BL99kc103RFC6pBfuDbouOJIJemQTV0=@vger.kernel.org
X-Gm-Message-State: AFuF++mlh3QyXKmX7sTL9EpZclZuKt20/4Duvn8POfDw2jsbCXdEZrmx
	Dp2H0O7aT1VWAm8YSoB0oIod6iDVzAxE1wZh+marlSlskhqnABiTbRoL
X-Gm-Gg: AR+sD12ZNx5p7PAXLjrs2qQjet3Mb+TQ5ZcQp5RkjhPkmp12aeJYIw7KmZZOwOl1YjP
	jAiKZ25DTFIYa5Batp9YMCXwGpfn/IumMNq0F/Ol3JmoHGmj54LUhDtR9bONGVA9sRQg3U0h824
	7CfR9j19+paY1GShUm/J0fCjOM3xhma8Za2IHlIAjQ+5KGyR0si1zdhvuZDScv0UEPjzaov825e
	hNAsk8wQ+Cuj029jFoJK3jUXFNK7j9avo2WMQ1KtGaCXZjhynHknZPWtqkfNgwvb7ztQOPGR4mD
	dpn6f6297yarg92WWTsb9Yt04vqq6w88MUtmOmP7U/dInkrcWGItTpN4DYQEtr5pFvMqvLI4dqr
	k68GF7F2Vz2l7usTzvaSS9IM1oZZlRtEiBNXM0juXurePank03rrCsGJe7ziH26HZAQH0IM222g
	ev0QwO518VhOnpFiPkObNNimfsrsxRMxbbe6tfuCvlGD8sUvxgMpMhOac13vhT2v5UIWgw65uL8
	mEKPmijPm/MqjaUkskW55hInwPQ4Qq/TYKBnEksFHJr
X-Received: by 2002:a05:6512:224a:b0:5ae:befc:97a7 with SMTP id 2adb3069b0e04-5b5e68ec53amr1749105e87.13.1787910679358;
        Fri, 28 Aug 2026 02:51:19 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b5e89c5e2dsm290343e87.1.2026.08.28.02.51.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Aug 2026 02:51:18 -0700 (PDT)
Message-ID: <1dd22b2e-80d5-40aa-b275-e8089601e093@gmail.com>
Date: Fri, 28 Aug 2026 12:51:17 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] iio: accel: kionix-kx022a: Prevent memory leak and
 fix state
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Matti Vaittinen <matti.vaittinen@linux.dev>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Mehdi Djait <mehdi.djait.k@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1787901813.git.mazziesaccount@gmail.com>
 <9e4453fcc00df6ec988207df8916226d18aecb20.1787901813.git.mazziesaccount@gmail.com>
 <apE_RZJu37iMuWnJ@ashevche-desk.local>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <apE_RZJu37iMuWnJ@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/08/2026 10:56, Andy Shevchenko wrote:
> On Fri, Aug 28, 2026 at 10:40:51AM +0300, Matti Vaittinen wrote:
> 
>> The driver allocates memory for samples at buffer enable path. If regmap
>> operation fails in the kx022a_fifo_enable() at the buffer enable path, the
>> allocated memory is never freed. Furthermore, the state information and
>> previous hardware configuration(s) aren't undone, potentially leaving
>> WMI interrupts and buffers enabled, or driver state flags wrong.
>>
>> Free the memory and revert the hardware configuration and state flags on
>> error path.
> 
> ...
> 
>> static int kx022a_fifo_enable(struct kx022a_data *data)
> 
> With
> 
> 	struct regmap *map = data->regmap;
> 
>>   	guard(mutex)(&data->mutex);
>>   	ret = __kx022a_turn_on_off(data, false);
>>   	if (ret)
>> -		return ret;
>> +		goto err_free_out;
>>   
>>   	/* Update watermark to HW */
>>   	ret = kx022a_fifo_set_wmi(data);
>>   	if (ret)
>> -		return ret;
>> +		goto err_wmi_out;
>>   
>>   	/* Enable buffer */
>>   	ret = regmap_set_bits(data->regmap, data->chip_info->buf_cntl2,
>>   			      KX022A_MASK_BUF_EN);
>>   	if (ret)
>> -		return ret;
>> +		goto err_wmi_out;
>>   
>>   	data->state |= KX022A_STATE_FIFO;
>>   	ret = regmap_set_bits(data->regmap, data->ien_reg,
>>   			      KX022A_MASK_WMI);
>>   	if (ret)
>> -		return ret;
>> +		goto err_buf_en_out;
>>   
>> -	return __kx022a_turn_on_off(data, true);
>> +	ret = __kx022a_turn_on_off(data, true);
>> +	if (ret)
>> +		goto err_on_out;
>> +
>> +	return ret;
>> +
>> +err_on_out:
>> +	regmap_clear_bits(data->regmap, data->ien_reg,
>> +			  KX022A_MASK_WMI);
> 
> in particular this will be
> 
> 	regmap_clear_bits(map, data->ien_reg, KX022A_MASK_WMI);
> 
>> +err_buf_en_out:
>> +	regmap_clear_bits(data->regmap, data->chip_info->buf_cntl2,
>> +			  KX022A_MASK_BUF_EN);
> 
> 	regmap_clear_bits(map, data->chip_info->buf_cntl2, KX022A_MASK_BUF_EN);
> 
> Which saves a single line, and the followup may shorten the existing code even
> more.

As far as I can see, the driver is consistently using the 'data->regmap' 
everywhere. Using 'map' just in one function would raise question if it 
is different regmap from every other place.

I am 100% Ok with anyone changing the data->regmap to 'map' throughout 
the whole driver in order to cut the amount of lines - but it is not 
something to be done in a bugfix commit.

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
