Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5B0405845
	for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 11:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786966646; cv=none; b=hzF3U0PvEXbjs9Np/wBQ17kZxD+A53pP7E0WD9MFK77emDeUfgKbkxA1tn8lk6cWMj0NNhi86y3AA1u7Qm5w5ARzE5D+g36J8Fl6f0kIMTRLcGe2BBJWP4qslMuCsLA3Ji9k5R2k6SB95+SIu0VHBCNEL4lDCWINKa9lz1Fgcl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786966646; c=relaxed/simple;
	bh=Y1uNjHFFLZoi4x2clT8lqTvcIRFqybCxrGvUfITph7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=INzdJ4oMVX9LNLl+BW7wvpwG1JjJ+51En2uatuXiAU0nCDy7KwotU+NLNPX5r2BCqmyeWFDoxBgGA/n/znqKzQvk0FjIvXAvUXDwENqvaICHiYw7cxJCftP0Lr/5NIBJosAaDPqfRtDuXqvE6g+sQ0tBMGknAbNJhSWWUqiLGIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gtdNbw/c; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gtdNbw/c"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5b013084dc2so2435248e87.0
        for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 04:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786966643; x=1787571443; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C5hxX8xiT0jXe6Ggo36/hfIdImjuZM69X1aiRLfMznU=;
        b=gtdNbw/cmB0WLnjbUeUP7JZc7yxQ/6ZSQ9ar7avageRsxOw/O/7VZdGd3lZ1U2DDY+
         HO2gRfJWDZvVDTZNIsSVtDw5pyZ31sGkYt992qIOprKsjpM8ljvpRm1l1capoN3iVYfq
         ZaqsvoCeRPzHjyd7uqwhyw1Zo9EUQj21/Bxf8HQ2bnk55u2zdCfUxk4EfI39INPec/F/
         k1Dnq2dvoye4a0Vm6zrnDtwGGVmFO2CkE2afsj2kx79irwWISZaz8zRuh68p7aCK7Sm/
         47QQc0a5LqWUHNS+ZSkjnKLWuRUMy2cas0dgFH1Lo1OsHvJC4gg48StxJG/MwHerlFll
         opbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786966643; x=1787571443;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C5hxX8xiT0jXe6Ggo36/hfIdImjuZM69X1aiRLfMznU=;
        b=tBReHg0XYE05UTq5CWiiBMRUhmLbthDk4af3ga8ekoSfaGv+zJ4N/eviCXS//2+zqc
         FQACYx8MKXZEAMS/u/+BBPaGQBz9+QLcIFYD8NtiJO/HO018qAfoasIKCswhagxKiNtN
         zQMeAd9gxTFJRnpkugs9FDwSJMNnMGjgBNN3sWpYg6aIPyfslNlye17oAg0gvZIu1C2l
         FxpuNOtOR0UZmzK6a80iUb8dOCWrs6jt4SnClm3qVGFgLrEPyOyQ9vtyBkkHtwYGrSpL
         zmN7FM2Ai6/ANyOR2vWaLioo8+jXpyGkiTHd9XI35+WLYRpH6nv7jnsh/JFMKshs2/ky
         viaA==
X-Forwarded-Encrypted: i=1; AHgh+RqG9ESxg2appVqgASXztZ6JQBZZiDkpw4Dr98hUhjCuQaKbzT2K//3Ip/gloe/WdUGRhtEColEXGug=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv+ulD1FcBk+3Wpq5iHdrwN4vBdr2K+ydjD0W9pBtX9BjkAcro
	y8tFlGDDFdp47WwOYr69XcjVmbmhi6kZwZYi0Px4L4+6YralvgVrnuAJ
X-Gm-Gg: AR+sD10BFHz4g0UaHrc6UF/9cxBV52nd4veTn3nkWryirs/0jyRSXAN5BGgSEeeQc3y
	CCINfPDZH825FEUbHWKfm7+hV3KPsi5vIrgse78Y96E3dLUCQvXDsWQEJoBfuJrWuf8M4MAqepg
	LvFQbQMYGboAIkPAYpfVfy5RdZJGbgDV0oR3GSbzz1Fj1Yb9bDzxiWT2pQVn9TtQ6mVx7QG4WOx
	1CgDSdGfr9E3BGLLQBOxCFboMUL4UI3mKH9nyP4ltwP3zSi3ruKyRyQJU0PTuvUYpXDVYSjwT6W
	Xf+gmJ1g55gUYzALPm6ODQB9Npi0yR1eo+lIpAUHIwhw3dDpab+XFFqjXvCJAjhb6b4VMeQZwvY
	/cxv12HRw1yvPS5Hs9rf41joQHnDaZt4e48qkSmIBlxMomlE1HvFbavFa9DShfEg27d5GV80BJM
	HraGuTeMQ8eYBUGgKA+qCtdeum+a6p9zCpis+6RBobEQJXKVhsj+Hj/N4Sp7z0ltudl+/LYxxgt
	PqJ9mYYJX1c81zCLnIjxRKfxCMih4tPHDtWQ/SIQNW1
X-Received: by 2002:a05:6512:684:b0:5b0:cce:d9e9 with SMTP id 2adb3069b0e04-5b45915d47fmr4348494e87.19.1786966642980;
        Mon, 17 Aug 2026 04:37:22 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b46cfa1298sm327939e87.26.2026.08.17.04.37.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 04:37:22 -0700 (PDT)
Message-ID: <8e3449fa-83aa-4674-945b-cfa1a5f09f16@gmail.com>
Date: Mon, 17 Aug 2026 14:37:21 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/12] iio: accel: kionix-kx022a: Prevent memory leak and
 fix state
To: Jonathan Cameron <jic23@kernel.org>,
 Matti Vaittinen <matti.vaittinen@linux.dev>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Mehdi Djait <mehdi.djait.k@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kalle Niemi <kaleposti@gmail.com>,
 =?UTF-8?Q?Topi_Sonkaj=C3=A4rvi?= <sonkajarvi@hotmail.com>
References: <cover.1786347811.git.mazziesaccount@gmail.com>
 <85e6bd3998863e0247c52dcf0c1486b2cddff567.1786347811.git.mazziesaccount@gmail.com>
 <20260817024513.0c2adab7@jic23-huawei>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20260817024513.0c2adab7@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/08/2026 04:45, Jonathan Cameron wrote:
> On Mon, 10 Aug 2026 10:55:03 +0300
> Matti Vaittinen <matti.vaittinen@linux.dev> wrote:
> 
>> From: Matti Vaittinen <mazziesaccount@gmail.com>
>>
>> The driver allocates memory for samples at buffer enable path. If regmap
>> operation fails in the kx022a_fifo_enable() at the buffer enable path, the
>> allocated memory is never freed. Furthermore, the state information and
>> previous hardware configuration(s) aren't undone, potentially leaving
>> WMI interrupts and buffers enabled, or driver state flags wrong.
>>
>> Free the memory and revert the hardware configuration and state flags on
>> error path.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>> Fixes: e7123a4dfcd7 ("iio: accel: kionix-kx022a: Refactor driver and add chip_info structure")
>> ---
>>   drivers/iio/accel/kionix-kx022a.c | 27 ++++++++++++++++++++++-----
>>   1 file changed, 22 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
>> index 8a13f78aeab0..49e8b4b943da 100644
>> --- a/drivers/iio/accel/kionix-kx022a.c
>> +++ b/drivers/iio/accel/kionix-kx022a.c
>> @@ -980,26 +980,43 @@ static int kx022a_fifo_enable(struct kx022a_data *data)
>>   	guard(mutex)(&data->mutex);
>>   	ret = __kx022a_turn_on_off(data, false);
>>   	if (ret)
>> -		return ret;
>> +		goto err_free_out;
> 
> If we follow this path we are assuming that turn_on_off hasn't
> had any side effects in failing...
> 
> 
>>   
>>   	/* Update watermark to HW */
>>   	ret = kx022a_fifo_set_wmi(data);
>>   	if (ret)
>> -		return ret;
>> +		goto err_free_out;
>>   
>>   	/* Enable buffer */
>>   	ret = regmap_set_bits(data->regmap, data->chip_info->buf_cntl2,
>>   			      KX022A_MASK_BUF_EN);
>>   	if (ret)
>> -		return ret;
>> +		goto err_free_out;
>>   
>>   	data->state |= KX022A_STATE_FIFO;
>>   	ret = regmap_set_bits(data->regmap, data->ien_reg,
>>   			      KX022A_MASK_WMI);
>>   	if (ret)
>> -		return ret;
>> +		goto err_wmi_out;
>>   
>> -	return __kx022a_turn_on_off(data, true);
>> +	ret = __kx022a_turn_on_off(data, true);
>> +	if (ret)
>> +		goto err_on_out;
> 
> 
>> +
>> +	return ret;
>> +
>> +err_on_out:
>> +	regmap_clear_bits(data->regmap, data->ien_reg,
>> +			  KX022A_MASK_WMI);
>> +err_wmi_out:
>> +	regmap_clear_bits(data->regmap, data->chip_info->buf_cntl2,
>> +			  KX022A_MASK_BUF_EN);
>> +err_free_out:
>> +	kfree(data->fifo_buffer);
> 
> This thing is fine here.
> 
>> +	data->state &= ~KX022A_STATE_FIFO;
> 
> This should also only occur when we have set it in the first place -
> so under err_wmi_out:
> 
> 
>> +	__kx022a_turn_on_off(data, true);
> 
> So following path above we should not be calling this.  It might
> be safe to do so but it isn't logically correct.  It should be a few
> lines earlier.
> 
>> +
>> +	return ret;
>>   }
>>   
>>   static int kx022a_buffer_postenable(struct iio_dev *idev)
> 

Thanks Jonathan. I think you're right. I've no idea what I was thinking 
when writing this fix...

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
