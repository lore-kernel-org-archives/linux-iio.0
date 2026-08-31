Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607C4392807
	for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2026 21:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788210893; cv=none; b=ls7Yu9IaHigjpUnfMRoYh0lBbOfxTdN6rRrvqgTJl4iZLpQeTPUbxjUkaYAoqcKAQjmeecOXINrN2+kNKdLqBO2VoL2Z1rZHTY6eo+loIEKGGF9QUxSHW609FxKp5ARdjopMP2Jhw9GshNRAv3TbfpON5cY5d8Sgb/3k/DlOutE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788210893; c=relaxed/simple;
	bh=YzpKoQW99G68H0qcC40y9puYmjvhf3vzMtbUcTFF8i0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X3DxMkLkD2kkuL3PNoxF0XjAAFOJilrUJMpOcdsCEkDDXcjn0BdXslROGNlJ1QPZed4jOeqHmYiwVgVlvULAiZhwg1taJNiCMRxBCS6bfIKhsd0xpK78KqAmbTXwig+WvbPLlyIUpH1ZLnHKjUXo9b+C6qWbRcfu+jhUzm4amhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=UmXPdJqN; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="UmXPdJqN"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6b1b766bf01so889731eaf.0
        for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2026 14:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1788210890; x=1788815690; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jV0sv79eNbFApaShsO+PeFVHf+MED7vCaTLK1pA5Lk8=;
        b=UmXPdJqNK3Dqm2ZUemu8Badl+D2F8Kbo28L7VPYLYzwfC7GgFjFg7PaNaYlHrmuQmS
         UZkBipQJpXR3Fo8SIlvrgg4JTKzVvWAf2Gick/SnX6Z5nha6j1obedzOl7YJ10VD9j+O
         4FIlz+XzWxfN/4v2v7D+ASfrIXwz4jIC7BJyItxH8jvAet/yVvu0DYL7R+1x3fzQNIJ6
         dvreFSRszxcbG2tQCxAidWmUPScCV7VmhTAoZS0BMqWvfvV0c+v/0+x3paI0wlhMldZ8
         jC0qeMXt//0PCWx08j8W6pkiro7amPe3Im6FGY4b2EE8SE6jl11cUjKtutJlJM9qW7Zu
         gc4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788210890; x=1788815690;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jV0sv79eNbFApaShsO+PeFVHf+MED7vCaTLK1pA5Lk8=;
        b=CUd4nroGGjN0bVu5nBcrSsX9vgi+bxJtVTO9uuhGp5IK97/I9//o+s8k4U0UjTxHS2
         9wjljtqeSwCbaPyMwjiGn+dCgw+UktPKL4nXbKH2fwRbY+WcKCmtcmjCBKkTNpKfxm0v
         rRUCPo+HhOH2DYysBAfiRJenhtByPoCy+BDOXupnpfSpD7j0isodhzOEI+AiBKiEPC4h
         UXjdqJhvKCzRkViYLCQqKs79Cn8rVByPRVo30NQ1scQFh6j1ctSrzywnVOdnIpznAUn8
         XWDHd3jwvDAP47/whnxo9it1dbEKFWCZeIJXvtqxJn3VzFATAffWFii8c1uKM3oA7K9J
         918g==
X-Forwarded-Encrypted: i=1; AHgh+RqAnzpmfOFOyqnO7+uz25T5y/W47o1aqPPFSjkfUXiOPEpL8DPLcP9PEdJv8r2GHCTTY3ofD4vrWoM=@vger.kernel.org
X-Gm-Message-State: AFuF++mwshjJxXAMu0wnrTIW6cl5Ql80RO27wWaTAEjKdi5GU8hSvSMq
	8TDklQp5Kz7Zj4lFX1jS5ZHy0g/gKe/rT+Gw/HdeCI30SvnFnVJpidqOI/sxMh6fO5s=
X-Gm-Gg: AR+sD13uojHaeMPY6lm/OXoW3B2vw/6oNqNaClGCvz6hn/k3xBna7GOAsUxRHV9oQEk
	dpbHVxmMjf59JRmaa4ydcSG1FJ+LNBMsz/EasO8Awz8PpA6iQue7UNdD1SGba20eXwpqohBbelo
	1GpsofrPGAaQstUqqmcnkksahOgfykDkWAOHxmVqu1Rj28OVqXhDyHdReIaBhzlVVY/jUvLctB9
	MMAwIyLyTkot7ZxwjDDaATNV+4sJQ/0Yv0F7SWh1GEj17CQ9VZPx6jLRPFiP8kdTtpJcs+xKO7M
	kHHsyERr212EqujV2rvsTCCF+8l3XXhll5G+66HNtxL3c+l2sWTvD1Nr6qNnNe6WSgU6b4xo581
	94CSFvb3LJhAu/vWRGgkyvJZ8hGG5duJRaU36YeXJmHJAVcVXa7ih08jPqH31sZj4O46OiWDALA
	dtcvIa3eK0Ml9buE4IX3BibDTsz1Gq+evgGpq8Mv4LBW7nL9Y3cL8DOt5ygOyce//Ek6ajbTNXv
	1xgHg0lxBumnXuyO3jYBfLqAttb9cUaliQuvg==
X-Received: by 2002:a05:6820:1888:b0:6b3:5c73:2188 with SMTP id 006d021491bc7-6b35c732bfbmr10920197eaf.5.1788210889646;
        Mon, 31 Aug 2026 14:14:49 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:778b:da9:a8a1:bc78? ([2600:8803:e7e4:500:778b:da9:a8a1:bc78])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-468a2fedbcasm11113514fac.2.2026.08.31.14.14.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 14:14:48 -0700 (PDT)
Message-ID: <70c2d36d-b079-411f-a454-a62061e395cf@baylibre.com>
Date: Mon, 31 Aug 2026 16:14:47 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] iio: adc: ti-ads112c14: add burnout current
 support
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Chris Hall <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>,
 Kurt Borja <kuurtb@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260827-iio-adc-ti-ads112c14-burnout-v2-0-00a1fab9e2d1@baylibre.com>
 <20260827-iio-adc-ti-ads112c14-burnout-v2-1-00a1fab9e2d1@baylibre.com>
 <apE7BEGrIzJd1_zx@ashevche-desk.local>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <apE7BEGrIzJd1_zx@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/28/26 2:38 AM, Andy Shevchenko wrote:
> On Thu, Aug 27, 2026 at 05:27:02PM -0500, David Lechner (TI) wrote:
>> Add a custom attribute via ext_info when a channel has a burnout current
>> specified in the devicetree. This adds an in_{voltageY,resistanceY,
>> voltageY-voltageX}_burnoutraw sysfs attribute for the channel that
>> performs a single conversion (same as _raw attribute) except that it
>> enables the burnout current. The chip also has a restriction that input
>> chopping cannot be enabled when burnout current is enabled, so we also
>> disable input chopping when burnout current is active.
> 

...

>> +	if (!measurement->burnout)
>> +		return -EINVAL;
>> +
>> +	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
>> +	if (IIO_DEV_ACQUIRE_FAILED(claim))
>> +		return -EBUSY;
>> +
>> +	ret = regmap_update_bits(data->regmap, ADS112C14_REG_DEVICE_CFG,
>> +				 ADS112C14_DEVICE_CFG_BOCS,
>> +				 FIELD_PREP(ADS112C14_DEVICE_CFG_BOCS,
>> +					    measurement->burnout));
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = ads112c14_single_conversion(data, chan, raw_buf, true, false);
>> +
>> +	/*
>> +	 * Important to always turn off burnout current even if the conversion
>> +	 * fails so that it does not affect subsequent measurements. This error
>> +	 * also takes precedence over the conversion error since the device may
>> +	 * be left in a bad state.
>> +	 */
>> +	ret2 = regmap_update_bits(data->regmap, ADS112C14_REG_DEVICE_CFG,
>> +				  ADS112C14_DEVICE_CFG_BOCS,
>> +				  FIELD_PREP(ADS112C14_DEVICE_CFG_BOCS,
>> +					     ADS112C14_DEVICE_CFG_BOCS_DISABLED));
>> +	if (ret2)
>> +		return ret2;
> 
> What we will get of sharing this error code instead of 'ret' in case of single
> conversion failure? I think there is no recovery mechanism involved, right?

I think returning ret here is better.

> 
>> +	if (ret < 0)
>> +		return ret;
> 
>> +	switch (data->chip_info->resolution_bits) {
>> +	case 16:
>> +		val = get_unaligned_be16(raw_buf);
>> +		break;
>> +	case 24:
>> +		val = get_unaligned_be24(raw_buf);
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (measurement->bipolar)
>> +		val = sign_extend32(val, data->chip_info->resolution_bits - 1);
>> +
>> +	return sysfs_emit(buf, "%d\n", val);
>> +}
> 
> And this is after all a user space interaction, so whatever error code is
> returned, user space will know it. I assume you are telling that the restoring
> the "burnout current" setting is important, but how will user space distinguish
> that case from the single conversion failure?
> 

This is not expected to ever fail, so any error just tells userspace that
hardware is broken. Any error here is not really recoverable without
resetting the hardware.

>> +			switch (burnout_nA) {
>> +			case 200:
>> +				measurement->burnout = ADS112C14_DEVICE_CFG_BOCS_200_nA;
>> +				break;
>> +			case 1000:
>> +				measurement->burnout = ADS112C14_DEVICE_CFG_BOCS_1_uA;
>> +				break;
>> +			case 10000:
>> +				measurement->burnout = ADS112C14_DEVICE_CFG_BOCS_10_uA;
>> +				break;
>> +			default:
>> +				return dev_err_probe(dev, -EINVAL,
> 
> I would use different error code, EINVAL is abused and overloaded a lot in the
> kernel, and basically errors like ENODEV and EINVAL are synonyms to "*an* error"
> happened. Unfortunately, reading the errno*.h I haven't found anything better.

There is an error message to disambiguate.
> 
>> +						     "invalid burn-out-current-nanoamp value\n");
>> +			}
>> +
>> +			if (measurement->burnout)
>> +				spec->ext_info = ads112c14_ext_info_burnout;
>> +		}
> 

