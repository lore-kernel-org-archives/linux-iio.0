Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB1942123E
	for <linux-iio@vger.kernel.org>; Tue, 25 Aug 2026 13:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787663855; cv=none; b=T3jvgdN1ZsSgDJv3tnELGXJJYApRfV9BQes1PmE/eKiU+USUBWE61ra4zp6UPHIm7iGAVh8tHWOH7ZKhqrHDdUDrxLkWpfGQ0o9xsYjYm8rD66vjE7V7aePfcspKABvwYTazECf3S21DJOey+rUkJ0o4ktvtBtGVgtha2lWI2Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787663855; c=relaxed/simple;
	bh=pt9eezPeCUT7V+HzJqfo0KBN0/mjD+4aoP/HdGr69OY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cB/KJgqtLY0BX4lLzIQM6jz3ZH68m/qdaawy08Ewla6xnYVBaCIAJfcaQ++EENy6Yi6OPwIDRVB81LuupkFIy0YtbNAqGu91lZEZZ405Pxk8cTaPHTWu+DGA+vSwySrQBUZhWiZ2dFtr/uYXlFVMlvn29Yqkldzy0Axf00uGQ6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B+9zZUpR; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+9zZUpR"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49954b88fffso37736405e9.0
        for <linux-iio@vger.kernel.org>; Tue, 25 Aug 2026 06:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787663852; x=1788268652; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=py3ROtb3vVj5APnhYCyw+k54KDsBa1cNIVxX44uQqJI=;
        b=B+9zZUpR3Zb/yz7F/XWKWBZtBgL6JzX5Givc21cs4Up+fFxlb8U5Q5QANZAu1k1qt7
         d61UH4CzBQ+r71aPtnq4+97krk8SPK+/YgiRiHb15ZV/G4Bke5s7OYutnw1yw6RTNfy9
         Rt5srqaP+9EXv7zbMoAQTcTFYnlAlH02qokI4xo4bGmVMyRES6y9pBeJ67nuOvq75byE
         pzvG/uNOqv3u2wFxDoQmLcjwK4hpEMSZR2cvekRuLEaG3Y4Yvkcg5QY4vcUwWofpBVCe
         94uZihdjF1/ix97ht17quY3uqeL5I/7Nm213Rty8ioY6arxDir/QqLH3wXKEvsv71XFq
         jObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787663852; x=1788268652;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=py3ROtb3vVj5APnhYCyw+k54KDsBa1cNIVxX44uQqJI=;
        b=TGhEqChLeDkK4Gys65uZq0yqSgzHpvOrfDBFoSKCUOUxX539e6E8CSQG2/L3W+X8aI
         up/uFWnlSpdK5gaCL7tOPjzsdMJ9tBOTWFYMBD2M257+lb3eEFmSoTllc7E20DalXrDy
         o6FgakX9scFK5Y2Ow7q3RhQ+ZdUYyNIB6ACCUnQkAzDTvkk0yKbJYxD3RBgMoYFLBUrT
         aaYZ5ZiZXjYpngTOWONrjl7iEusgmvW8atCxu5ekDsm8kMV5P54uLgFSt1rv78LNqjrs
         l0M4AN199IXrpxLH9Y7miNaEQjHOhTwJMpiriyFwx8E/IYIezdynJzz2Criaa+E1WkHo
         nLMA==
X-Forwarded-Encrypted: i=1; AHgh+RoZBNi6X9/XzV3Kbt0E1Akw0ZCDhI8Zc/zoSr/NqiUE9sd7FbZlnJvMcfaPPRzaWARfvmXSm23yqFQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lxUow5M93cGZIpbhqkf0+9XZDs9ZEZj1IX+wXvS1Hae1KQTy+v
	/hrs79ZFRtry/jZuXI9SJIyrtkFHXx0qhMyAjcP1ZMfSS56RqhwS0yYq
X-Gm-Gg: AR+sD12vJM0wuiWfppYLFbDg+XekquHzfcelq1w7AlirwDVC1JamGi4TBAokyRXtIDa
	QCefnvIKy8VyVOLgXvS1JoD1ruRAZawsX88pb9rqiF8k+dpUYYx98V6OwgqYCTcZfoFdAvHXgsh
	UOWluQxeI2NtJijSQP4apzcTxoB+01jdeU1w5IHczgiefLs/qcrxMBNroiukY2JBoSsfJrb+gx1
	Vhm5ZaoNezncNsqtCU3yEf/iQ/hYAb7lxx9KM0tgwaENPBgrN81EzCyH30GgBMULuLQBvz6zpaB
	q/fUSMEizfvrVwoR70NQ+iDZxWLLOLEJBfZnhtA1ekmuD0FxUK2MOzoKCZKw2Z+fo3c2Otc+xSO
	7nGlrX3eAn9KWnUCEVdHcuY4+RrDzPGeTZl8RhaYUmuxT6hv5aj8Ign7wguKvb2nElOYBt36OPm
	d9HyTe2AQzhQ63I9tlFcrfDz8xT6qkDTiEAO0XyFsdeMKFnMTDWlQTtcAZQSWf5/im51wfG1ZQ4
	pFSs+10xkNao4VTQe/RiWcvgihD94zld5AeAzyJHSoTOS1kXn8h6du4
X-Received: by 2002:a05:600c:3111:b0:495:7888:281c with SMTP id 5b1f17b1804b1-499c1772dd5mr302953505e9.0.1787663851572;
        Tue, 25 Aug 2026 06:17:31 -0700 (PDT)
Received: from [172.24.138.145] (dynamic-176-007-058-112.176.7.pool.telefonica.de. [176.7.58.112])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499d5d72d36sm23411535e9.3.2026.08.25.06.17.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 06:17:31 -0700 (PDT)
Message-ID: <9e7edec5-578d-48e0-b253-e50cf848236e@gmail.com>
Date: Tue, 25 Aug 2026 15:17:14 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/14] iio: adc: ad7768: Add per-channel conversion
 delay
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
 Janani Sunil <janani.sunil@analog.com>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Michael Walle <mwalle@kernel.org>,
 linux@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-doc@vger.kernel.org, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>
References: <20260821-ad7768-driver-v4-0-bb8fbd06d4eb@analog.com>
 <20260821-ad7768-driver-v4-8-bb8fbd06d4eb@analog.com>
 <aovua1sy4sm6RmSt@ashevche-desk.local>
Content-Language: en-US
From: Janani Sunil <jananisunil.dev@gmail.com>
In-Reply-To: <aovua1sy4sm6RmSt@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/24/26 09:10, Andy Shevchenko wrote:
> On Fri, Aug 21, 2026 at 04:07:01PM +0200, Janani Sunil wrote:
>> Expose the per-channel synchronization phase offset through the IIO
>> conversion-delay attribute.
>>
>> Derive the delay resolution from MCLK, power mode and decimation rate.
>> Validate the requested delay and program the corresponding phase
>> register when applying the active channel configuration.
> ...
>
>> +static int ad7768_get_convdelay_params(struct ad7768_state *st, unsigned int ch,
>> +				       struct ad7768_convdelay_params *params)
>> +{
>> +	struct ad7768_freq_config f_cfg;
>> +	unsigned int dec_rate;
>> +	unsigned int mclk_div;
>> +	unsigned int mult;
>> +	u64 mclk;
>> +	int ret;
>> +
>> +	ret = ad7768_get_freq_cfg(st, st->ch_freq[ch], &f_cfg);
>> +	if (ret)
>> +		return ret;
>> +
>> +	dec_rate = ad7768_dec_rate[f_cfg.dec_rate];
>> +	switch (dec_rate) {
>> +	case 32:
>> +		params->shift = 3;
>> +		params->max_raw = 31;
>> +		mult = 1;
>> +		break;
>> +	case 64:
>> +		params->shift = 2;
>> +		params->max_raw = 63;
>> +		mult = 1;
>> +		break;
>> +	case 128:
>> +		params->shift = 1;
>> +		params->max_raw = 127;
>> +		mult = 1;
>> +		break;
>> +	case 256:
>> +		params->shift = 0;
>> +		params->max_raw = 255;
>> +		mult = 1;
>> +		break;
>> +	case 512:
>> +		params->shift = 0;
>> +		params->max_raw = 255;
>> +		mult = 2;
>> +		break;
>> +	case 1024:
>> +		params->shift = 0;
>> +		params->max_raw = 255;
>> +		mult = 4;
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
> So, this is just a bit twiddling of the dec_rate.
>
> Can be written like
>
> 	/* Optional, perhaps shouldn't appear */
> 	if (!dec_rate)
> 		return -EINVAL;
>
> 	/* Same? What does table allow to have? */
> 	if (!is_power_of_two(dec_rate))
> 		return -EINVAL;
>
> 	mult = ilog2(dec_rate);
> 	if (mult > 10) {
> 		return -EINVAL;
> 	} else if (mult > 8) {
> 		params->shift = 0;
> 		params->max_raw = 255;
> 		mult = BIT(mult - 8);
> 	} else if (mult > 5) {
> 		params->shift = 8 - mult;
> 		params->max_raw = dec_rate - 1;
> 		mult = 1;
> 	} else {
> 		return -EINVAL;
> 	}
>
> TBH, I don't know which looks easier to read. It all depends on what datasheet
> says about these parameters and multiplier and what the table allows to have.
>
I kept the explicit switch case because it the device supports only the 6 discrete decimation ratios listed in the table 32.
The switch directly mirrors the phase resolution, number of steps and register bit mappings from that table, which I find easier to verify against the datasheet.

The arithmetic version is more compact, but the proposed conditions would reject the valid x32 case because ilog2(32) is 5. A corrected arithmetic version would be functionally equivalent, but I do not think it improves the readability here.

Regards,
Jan

