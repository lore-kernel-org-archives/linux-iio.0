Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB461F09A5
	for <linux-iio@vger.kernel.org>; Sun, 12 Jul 2026 16:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783873981; cv=none; b=CgmzX/IT55mxeuXHa7Mmk39xhFLNoIYFdmpsTUzofo7hwD52yF6d0pDwUqj2kc13XkL2wl2LXy9PTFYauUyitSYgqZgekMyvNdKc1BfyDQCtkF0hlEfYs4W3JjpjodRPy497E6C48stXpqyNFhcPY++7KQija29k24/Kr9Zmsno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783873981; c=relaxed/simple;
	bh=+dTi5tf4M1Cu35CMA/uejmB9UH7tBrnqtx64FToKziY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OWhGf/omExDMvF2BgwdiszPCa08TgOvDmrl+KIKJDHmczV1OUYaC+e1pEtKZKRlf32jKwk38Uy4ykaP1R86zjc9AKAfCAEuL22utohLWmq0y1bRsu5BRc8ycoPEnuuK5zuy2FvO2hW8yvA9VFCmfZHn0PCuM/WtkMM0JINqbbFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=U07GY39O; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="U07GY39O"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6a1888969ddso1442163eaf.3
        for <linux-iio@vger.kernel.org>; Sun, 12 Jul 2026 09:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783873978; x=1784478778; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bhv8nBZOSQkij2eTvBP/0gy+hNIJSzm9ajAyaRKMo/s=;
        b=U07GY39OtTx7LRnWyW5F2yktEjKs605PVditFSCiw1xxtG2YCM95pCUEXU8AiAAjjN
         zpFO1R3NdJAHgjIJTQWzzzpf3HHL0SGm0U+5GTFY2T8L/P8Xcn4aoZQ+UQ2YwjVTL5hI
         +2qxe3dLuajgbjSUf1DcrWwSVSG1tEKpJNOpcJixUEQ/eiGorrCFa22utJpKzaFmjz08
         ckl3JsNJAYnIU6Kzab2R0zEGe7ffbLN7t51S4t4tdcG13xq4dTO3kBQ3zxmnQsk7yFVp
         8YyDx60uJfJVVr1bbFolyvURhKhcyzcxgEncsodGdS8sjFVSSy7Q8Jtli0/BXJdxBDet
         HbKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783873978; x=1784478778;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bhv8nBZOSQkij2eTvBP/0gy+hNIJSzm9ajAyaRKMo/s=;
        b=C9VnHvNB7FhL7KHwZslH630m1lxJdSgNYsK19MWfU1H1c8do11lAva+unw2Eyt0VrM
         oUFOjdpsX03gZPRbc+IPo4q3TbcaA7LDEgxyIW9iLhQJFoXHU0miJw1oLSb78bqSnXS3
         Np1DBCvqbk4zxeCyjMhcNNpqJsVSoDLPJ4vMVaSDiHyDtmVwlt+Lx7tw8hx7jJOYA44A
         yYCjowNYYi4HGemYNU2B+Cu823bPNw10AWVtqBpqLv+IwZS8HoT5FlnDk8MCP28jYR3Y
         U8jMKDlkrV+qM8YS/alc8KexIkv25mnqMMk2YwuTte7RffKqau5edkWDLUQ6H6S01tGq
         i+Pw==
X-Gm-Message-State: AOJu0Yy4cxj1gsgKO00g81SUJ0OAVLVgKnml+tpzxiiwDb7TDJME9qIJ
	ar6gZ4A7kgvhi7+Ys/WdI3hlNrE096P8XURXWnfeOxoqPnkWaz2CT46VL7cVzSIGwZc=
X-Gm-Gg: AfdE7cl8mVeA0KT8DvaQn7A2SsfOj8B6NSpM6KYIPM68YOBiHnxBphl+U2r/QBRAkUP
	OQehtdgL3pb8f8qXXAwRmsbsgDVe2EwMxFwSANXdumywkHPjVQYd74ryyTP/YYk4MDv2Me7ej2B
	sGd35GO3C8IYDcw/k5gFSpTOAzlcDqSozslvD8anoUwARUft3LFfBQ8X/O/KR123NkAUASkadhe
	JFuDDCSRY0zHpJYo7PY0AKLPI9t1KSJ2HCbieTNxo0WsWoZGlju+g49Hjq1O9/+otbIGX5iQ+hG
	ZZHRgtU3IlOV8ttEkU88GeUKhfArIsEUQOoaOpq3qr8tBseY+OxZj5TUYJRWFKc2DeihSGW4QDB
	kjb8+qBmj0wQCuPKdtD7F4tQE7gCK4o0v+PnZJuLA+8HG+82/+vf4xIJ/D+MRqczU8wapqvFk3a
	5Nl80Zb0gezUYw/6AFrwTWfPEwPGP1W4Y0IpOt6lhLEjeRPtY7seXoTSPtCA9QEKQ=
X-Received: by 2002:a05:6820:81d3:b0:6a1:18f3:ed40 with SMTP id 006d021491bc7-6a39a6cee93mr3262976eaf.44.1783873978654;
        Sun, 12 Jul 2026 09:32:58 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:3af7:75b0:bf02:8cf8? ([2600:8803:e7e4:500:3af7:75b0:bf02:8cf8])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a38e9bc8casm5178034eaf.2.2026.07.12.09.32.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jul 2026 09:32:58 -0700 (PDT)
Message-ID: <08e3f5de-3dd7-4578-8036-f3c14a77b537@baylibre.com>
Date: Sun, 12 Jul 2026 11:32:56 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/3] iio: adc: Add ti-ads1110 support to ti-ads1100
 driver
To: =?UTF-8?Q?Jakub_Szczud=C5=82o?= <jakubszczudlo40@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, antoniu.miclaus@analog.com,
 conor+dt@kernel.org, devicetree@vger.kernel.org, duje@dujemihanovic.xyz,
 Jonathan Cameron <jic23@kernel.org>, jishnu.prakash@oss.qualcomm.com,
 jorge.marques@analog.com, joshua.crofts1@gmail.com, krzk+dt@kernel.org,
 linusw@kernel.org, marcelo.schmitt@analog.com,
 Matti Vaittinen <mazziesaccount@gmail.com>, mike.looijmans@topic.nl,
 nuno.sa@analog.com, robh@kernel.org, sakari.ailus@linux.intel.com,
 wens@kernel.org
References: <20260711184414.1013686-1-jakubszczudlo40@gmail.com>
 <20260711184414.1013686-4-jakubszczudlo40@gmail.com>
 <35c47ff5-0a8b-4c99-8e5b-d86c04039e17@baylibre.com>
 <CA+gq5JjrNzZHFhPeSM=AEpevHgStV2T6dEGHTUpnvzAbSeO1FQ@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CA+gq5JjrNzZHFhPeSM=AEpevHgStV2T6dEGHTUpnvzAbSeO1FQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/12/26 5:16 AM, Jakub Szczudło wrote:
> sob., 11 lip 2026, 22:01 użytkownik David Lechner
> <dlechner@baylibre.com> napisał:
>>
>> On 7/11/26 1:44 PM, Jakub Szczudlo wrote:
>>> Add ADS1110 support that have faster datarate than ADS1100, it also uses
>>> internal voltage reference of 2.048V for measurement.
>>>
>>
>> ...
>>
>>> +static int ads1100_get_vref_milivolts(struct ads1100_data *data)
>>> +{
>>> +     int voltage_uV;
>>> +
>>> +     if (data->ads_config->has_internal_vref_only)
>>> +             return ADS1110_INTERNAL_REF_mV;
>>> +
>>> +     voltage_uV = regulator_get_voltage(data->reg_vdd);
>>> +     if (voltage_uV < 0)
>>> +             return voltage_uV;
>>> +
>>> +     return voltage_uV / (MICRO / MILLI);
>>> +}
>>> +
>>
>> ...
>>
>> T;
>>> @@ -276,6 +310,7 @@ static int ads1100_read_raw(struct iio_dev *indio_dev,
>>>                           int *val2, long mask)
>>>  {
>>>       int ret;
>>> +     int data_rate_index;
>>>       struct ads1100_data *data = iio_priv(indio_dev);
>>>
>>>       guard(mutex)(&data->lock);
>>> @@ -292,12 +327,12 @@ static int ads1100_read_raw(struct iio_dev *indio_dev,
>>>               return IIO_VAL_INT;
>>>       case IIO_CHAN_INFO_SCALE:
>>>               /* full-scale is the supply voltage in millivolts */
>>> -             *val = ads1100_get_vdd_millivolts(data);
>>> +             *val = ads1100_get_vref_milivolts(data);
>>
>> Obviously, the existing code was getting away without checking for
>> error here. Since the ads1100_get_vref_milivolts() function handles
>> the error case now, seems like we should be checking the return value
>> here as well.
>>
>>>               *val2 = 15 + FIELD_GET(ADS1100_PGA_MASK, data->config);
>>>               return IIO_VAL_FRACTIONAL_LOG2;
>>>       case IIO_CHAN_INFO_SAMP_FREQ:
>>> -             *val = ads1100_data_rate[FIELD_GET(ADS1100_DR_MASK,
>>> -                                                data->config)];
>>> +             data_rate_index = FIELD_GET(ADS1100_DR_MASK, data->config);
>>> +             *val = data->ads_config->available_data_rate_hz[data_rate_index];
>>>               return IIO_VAL_INT;
>>>       default:
>>>               return -EINVAL;
> 
> 
> I'm thinking about next patchset where I will address voltage
> regulator stuff, adding it to struct and taking it voltage just once
> in probe. Can we leave it as it is for now?

Sure. Just mention that again in the cover letter if you
do a v7 to remind us.

> 
> Best regards,
> Jakub Szczudlo

