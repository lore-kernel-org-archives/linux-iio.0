Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F5744DB7F
	for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2026 15:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781625339; cv=none; b=CWfqiwPqFSGkUUAo/OVif/bN4bLW9pKMGwAn+pHXd0Jh2cFd9DTSt9xH8AUgl9xhfr9aO3tWbZM6KbqiY+nMfkC7AcNqyy7bzaZ0xtSvsD2REY3FKLKomW8w3vRlAI46qKVAQDTUTFRrmmCwgNGCs8IcZLNu+84fnkNrODY4hiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781625339; c=relaxed/simple;
	bh=fx2MvxDOp+zgfbQanHVlBFA2C9ssVsnmseycDuhq1VU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bMKCtqlTIfwW3FznMUDrfRYOpDdeOqPgllnaOWNvBI4SmfA36fte8Zbizuogc3PGsknsLqEDfssygLW5KethJJzIAYz6FB03AeYePcrWWYbUH340eHhw1+aNaSwTduXLYyhPFBdqpie135WvYXcfXuJrHmmOGxYzZwQ9I4fSdQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=OZMSo3xP; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="OZMSo3xP"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-43d34292872so2312603fac.0
        for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2026 08:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781625336; x=1782230136; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PswXrphDi92EK2opFWAkaWgKVXNG2RJTsAlsaI0Q2zQ=;
        b=OZMSo3xPFLfzq0JWfXEou+WzsYOYM3kkYQrU8TPnYjCy48K3IV/jcL5GIGVcEDPdyZ
         Usm/Pk44RLdmS+TJwL0iu5JGU1NGg0LP188mVH3bPQIKcSDUyRaYqOOYQDXyZsl+Wqki
         t4ZUOSfJmj8pjm/ItfO2kPoi5kf7U5t4tXpQtE6S5V++cgOVAJT+CctkMAR1AaTTbSYT
         mz52MyHS1lPd54LYvVY++GW3S19awXZq6lwneaDOZQjV7ITMLh+RpMmRE6Ocn8CNi11H
         t45+cmgs15YsiENf8GODPl3iVPGEs+7gQJWiSfsPRXturcAMCId930/8Pzb/2zhjY/TD
         hveA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781625336; x=1782230136;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PswXrphDi92EK2opFWAkaWgKVXNG2RJTsAlsaI0Q2zQ=;
        b=I0JVK07mVhnw+oQ/lQucziQmTIHloCmBDlt35rGK+0tYT9YJV6tb2SKytsQgwrCTtW
         Bq71DqZoSCf4DHcrYaCyGGJR2KMC+9biLEELdMZo6aKtxVAVgp/Sd8VTtXVqeW/DXUZ0
         fp8lahz848QlN4dGwFQhN+c+J8imBs1q9qARj3TdMXKUnfkSL8IMhF9eHqv5KTdCLioS
         TnnO4Fh6JW7ljGpsj0uMNpIee8oHbv63GQPRZrzDF5Gi1O454SZOi2Qo49hYzOgKsJO2
         bEfQkYfdHTNTRvTI2lB6iSYM4rSqJXrNmIaG0rSdsLJrTCMC9NZDtbqEAydWw+cg1x48
         NWew==
X-Forwarded-Encrypted: i=1; AFNElJ/uHQxSStEOHBSLL8UOoNi0lbt8MLRrYKCpZpIIItA2sJRyVOed1zD/U7LFjSNVnvr01XX9oVlefds=@vger.kernel.org
X-Gm-Message-State: AOJu0YysinAwUWcVDJkFwp4t7aLX5TI+eDOA4Kr2SPi9CVFqhZH2v48L
	9R2N376OMN3sM0dWxV7KFAFKBx9Zd6M+m96iZN93lHH763woF2FVnn0tY6tLyeqvsXo=
X-Gm-Gg: Acq92OFxNtpaZKswaebnWPBQ3Y7lEeGoMeF0VCmRTXnk7UXdUfHhB3/Lu9lkdEBnaxM
	vhmjEyQ+XskDTHIWf3fio7vweyvJ5YCgzxusg2EtRh0ALLIWoW15/L5WtEHuo13hhEBmyIIePvp
	mANjRguksZFvYzJIPQU1ZYVhA8ZzTaeXwCTyBTBa9Iefl0MvJcO4u8VYpP/zwqfsOGr7Upze1XA
	bV0QWd4VKjLLwIguFxAvPrRU4h5tKFOPEadW9oi9whk6ssUGtZyO1YoqTWyA3QBZ+t43GnI0Rm6
	59LsOy0f1RRVXZraff3BPhSFmVDehhCfeqmKR79zjVrdv1NPdaJl5XBg24Z78R/7/M8S+0+sdzo
	oif+xxeGHi8j5tm6bO4D4/v2XlFh0eiMmEuuqbVvCHZMCm6vVievv01MbjLrGl8X89nfJMqZU+t
	+cHGE35Cp0OFpYQ7n6mYnvPIUYMHDJ4R14uS7YETXSRsZ+bZfTwENRbaZzNi/QaQJIl/IYi4Ax3
	A==
X-Received: by 2002:a05:6820:2015:b0:69e:3960:b5b4 with SMTP id 006d021491bc7-69edc73ac67mr12760353eaf.40.1781625335733;
        Tue, 16 Jun 2026 08:55:35 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:16b0:5133:47b1:a939? ([2600:8803:e7e4:500:16b0:5133:47b1:a939])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69f00d609e9sm4851306eaf.7.2026.06.16.08.55.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 08:55:35 -0700 (PDT)
Message-ID: <e1e6a5f3-4cf3-4454-ab73-a45ae7b77116@baylibre.com>
Date: Tue, 16 Jun 2026 10:55:34 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] iio: adc: ti-ads112c14: add measurement channel
 support
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kurt Borja <kuurtb@gmail.com>,
 Nguyen Minh Tien <zizuzacker@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260615-iio-adc-ti-ads122c14-v1-0-e6bdadf7cb2b@baylibre.com>
 <20260615-iio-adc-ti-ads122c14-v1-4-e6bdadf7cb2b@baylibre.com>
 <ajELGxonxsQp-Ut2@ashevche-desk.local>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <ajELGxonxsQp-Ut2@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/16/26 3:36 AM, Andy Shevchenko wrote:
> On Mon, Jun 15, 2026 at 05:00:02PM -0500, David Lechner (TI) wrote:
>> Add support for parsing devicetree properties for measurement channels
>> and doing direct reads on these.
>>
>> There are quite a lot of conditions that have to be met for each
>> measurement to be made, so quite a bit of state and algorithms are
>> required to handle it.
>>
>> Channels are created dynamically since the number of possibilities is
>> unreasonably large.
> 


>> +	/* measurement channels */
>> +	if (chan->channel < 100) {
>> +		struct ads112c14_measurement *measurement =
>> +			&data->measurements[chan->scan_index];
> 
>> +		if (!measurement->label)
>> +			return -EINVAL;
> 
> Hmm... Can it be true?

Yes. For some channels, label comes from the devicetree, which
may not have provided a label.

> 
>> +		return sysfs_emit(label, "%s\n", measurement->label);
>> +	}
> 

...

>> +		if (fwnode_property_present(child, "single-channel")) {
>> +			ret = fwnode_property_read_u32(child, "single-channel", &spec->channel);
>> +			if (ret)
>> +				return dev_err_probe(dev, ret,
>> +						     "failed to read single-channel property\n");
>> +
>> +			if (spec->channel >= 8)
>> +				return dev_err_probe(dev, -EINVAL,
>> +						     "single-channel value must be between 0 and 7\n");
>> +		} else if (fwnode_property_present(child, "diff-channels")) {
>> +			ret = fwnode_property_read_u32_array(child, "diff-channels", pair, ARRAY_SIZE(pair));
>> +			if (ret)
>> +				return dev_err_probe(dev, ret,
>> +						     "failed to read diff-channels property\n");
>> +
>> +			if (pair[0] >= 8 || pair[1] >= 8)
>> +				return dev_err_probe(dev, -EINVAL,
>> +						     "diff-channels values must be between 0 and 7\n");
>> +
>> +			spec->channel = pair[0];
>> +			spec->channel2 = pair[1];
>> +			spec->differential = 1;
>> +		} else {
>> +			return dev_err_probe(dev, -EINVAL,
>> +					     "channel node missing channel type property\n");
>> +		}
> 
> Looking how it's going to spread (I mean the above pattern), perhaps it's a time to introduce bunch of
> 
> 	fwnode_property_read_*_optional()
> 
> and the respective device_property_read_*_optional()?
> 
> Let's start from u32 case only, as it will be most used anyway.

I don't think that would be really any different from device_property_read_*
and checking for -EINVAL or ignoring the error completely. TBH, I really like
it this way with fwnode_property_present().

> 
>> +		if (fwnode_property_present(child, "excitation-channels")) {
>> +			ret = fwnode_property_count_u32(child, "excitation-channels");
>> +			if (ret < 0)
>> +				return dev_err_probe(dev, ret,
>> +						     "failed to read excitation-channels property\n");
>> +
>> +			if (ret < 1 || ret > 2)
>> +				return dev_err_probe(dev, -EINVAL,
>> +						     "excitation-channels property must have 1 or 2 values\n");
>> +
>> +			measurement->iadc_count = ret;
>> +			pair[1] = 0;
>> +
>> +			ret = fwnode_property_read_u32_array(child, "excitation-channels", pair, measurement->iadc_count);
>> +			if (ret)
>> +				return dev_err_probe(dev, ret,
>> +						     "failed to read excitation-channels property\n");
>> +
>> +			if (pair[0] >= 8 || pair[1] >= 8)
>> +				return dev_err_probe(dev, -EINVAL,
>> +						     "excitation-channels values must be between 0 and 7\n");
>> +
>> +			measurement->idac1_mux = pair[0];
>> +			measurement->idac2_mux = measurement->iadc_count > 1 ? pair[1] : 0;
>> +
>> +			ret = fwnode_property_read_u32(child, "excitation-current-microamp",
>> +						       &measurement->idac_current_uA);
>> +			if (ret)
>> +				return dev_err_probe(dev, ret,
>> +						     "failed to read excitation-current-microamp property\n");
>> +
>> +			measurement->current_chop = fwnode_property_read_bool(child, "current-chopping");
>> +		}
>> +
>> +		measurement->bipolar = fwnode_property_read_bool(child, "bipolar");
>> +
>> +		fwnode_property_read_u32(child, "ti,vref-source", &measurement->vref_source);
>> +		if (measurement->vref_source > ADS112C14_VREF_SOURCE_AVDD)
>> +			return dev_err_probe(dev, -EINVAL,
>> +					     "invalid vref-source value\n");
>> +
>> +		if (measurement->vref_source == ADS112C14_VREF_SOURCE_AVDD)
>> +			*need_avdd_ref = true;
>> +		if (measurement->vref_source == ADS112C14_VREF_SOURCE_EXTERNAL)
>> +			*need_ext_ref = true;
>> +
>> +		spec->info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE);
>> +		spec->info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE);
>> +
>> +		i++;
>> +	}
>> +
>> +	memcpy(channels + i, ads112c14_sys_mon_channels, sizeof(ads112c14_sys_mon_channels));
>> +
>> +	indio_dev->channels = channels;
>> +	indio_dev->num_channels = i + ARRAY_SIZE(ads112c14_sys_mon_channels);
>> +
>> +	return 0;
>> +}
> 
> ...
> 
>> +static void ads112c14_populate_scale_available(int scale_avail[][2],
>> +					       u32 vref_uV, u32 fsr_bits)
>> +{
>> +	for (u32 i = 0; i < ARRAY_SIZE(ads112c14_pga_gains_x10); i++) {
>> +		int *entry = scale_avail[i];
>> +		u32 gain_x10 = ads112c14_pga_gains_x10[i];
>> +
>> +		entry[0] = div_u64_rem(div64_u64((u64)(NANO * 10 /
>> +						       (MICRO / MILLI)) * vref_uV,
>> +						 (u64)gain_x10 * BIT(fsr_bits)),
> 
> Hmm... This differs from the previous implementation. Why?

Probably fixed it during testing and missed that I needed to fix
the original patch too.

> 
>> +				       NANO, &entry[1]);
>> +	}
>> +}
> 
> ...
> 
>> +	if (device_property_present(dev, "refp-refn-resistor-ohms")) {
>> +		if (refp_uV != 0 || refn_uV != 0)
>> +			return dev_err_probe(dev, -EINVAL,
>> +					     "refp-refn-resistor-ohms property should not be present when refp-supply or refn-supply is present\n");
>> +
>> +		ret = device_property_read_u32(dev, "refp-refn-resistor-ohms",
>> +					       &data->ext_ref_ohms);
>> +		if (ret)
>> +			return dev_err_probe(dev, ret,
>> +					     "failed to read refp-refn-resistor-ohms property\n");
> 
> Using
> 
> 	const char *propname;
> 	...
> 	propname = "refp-refn-resistor-ohms";
> 
> makes this
> 
> 	if (device_property_present(dev, propname)) {
> 		if (refp_uV != 0 || refn_uV != 0)
> 			return dev_err_probe(dev, -EINVAL,
> 					     "%s property should not be present when refp-supply or refn-supply is present\n",
> 					     propname);
> 
> 		ret = device_property_read_u32(dev, propname, &data->ext_ref_ohms);
> 		if (ret)
> 			return dev_err_probe(dev, ret, "failed to read %s property\n", propname);
> 
> Also the rest can be improved in the similar way.

Hmm... maybe less error prone, but makes the code harder to read IMHO.
Will think about it.

> 
>> +	} else {
>> +		if (need_ext_ref && data->ext_ref_uV == 0)
>> +			return dev_err_probe(dev, -EINVAL,
>> +					     "external reference measurements require either refp-supply or refp-refn-resistor-ohms property\n");
>> +	}
> 

