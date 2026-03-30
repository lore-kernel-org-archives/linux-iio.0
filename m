Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68C43C278B
	for <linux-iio@vger.kernel.org>; Mon, 30 Mar 2026 16:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774889157; cv=none; b=loafXMOySx2NT0wL7Lv6WOcHsAGua3SknxiX0klNFuVo2k4kooCHt2nR5ckQih/VEgcIzlYtjynHCm3tfqxG3SEj3SstgWCJYaIkxl49n8Bq4GkP8osPNMISgHo/u/N0vt1+RnJm5c1cPdwsVPUaPVHTSYfshqWvi7mkkZqqUAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774889157; c=relaxed/simple;
	bh=iVc+nwzeJK2O9HDZyDVMoLikBa3zmNpdGAiqudnX+Y4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mZ7r2meQNBYcVjJ2o3xQvzr8GulF3FRqCCWQnAGM2PfG/Elt/y/sLoeGORs1V5VQ6wLNDOhbMURr7ph9FrYVv9O8/JCtg58YcjZDmYK3NX6mj2Zsf354FSw/6ntG9ahR91cNKve2xHzawoRyBDfG+7BmDwmkhw7kA0W9CpxQcMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=a09RFMgX; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="a09RFMgX"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-4043b909ed4so2870101fac.3
        for <linux-iio@vger.kernel.org>; Mon, 30 Mar 2026 09:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774889151; x=1775493951; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lCIkeFg+7k71htisHedAK8gYyac1zTYYS5iRSjWlqe0=;
        b=a09RFMgXtWStMdgEHvUS2v2gtwIfXdQVMtitJh6tCCGBiLDvJ/0QeCUGVD0qz5zbHe
         7opVY6BuGofBoyeEaFT01fMmCq+VFk1DN529Zg7YykKvLRcv00waGuNjaEl66vWPSKWn
         DFLZaFY86G662vE5/HpP5pAbU58w30Fwz0yacd/5T5Jf9iN6tphU4fh8rp8azkYi7Ip6
         zBZJKVW4ncKxStkqXe6rOTbNMli5mbi5sA39fAkShtdCnPEaM/4Mcy5aBHMZn1X55YtP
         fNOe6FWpusfKshBOf2RHemsnzrFnAZjpfSeOXm/EkPx8iZFF0MmxQ2lXktwEVkMvgy2a
         L/9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774889151; x=1775493951;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lCIkeFg+7k71htisHedAK8gYyac1zTYYS5iRSjWlqe0=;
        b=WjMsDguQ+GYbLC/g5Zuc7oPVa1UZ4lutvpPqE/bOjhhExXFQ3DFLYHy1z0Us32HXL1
         0cPOMJADhhrPs/m0mGKHZtZ/NX7/ksuM9a9Bw8K9ISSTscPS4r4jzlEnuoM1CE3gipDQ
         ZmOqhmXj4IQwjOBCvbthW2hgozcdbtkYLaTgQiHOmVn5+wae+G01AkMk0YJh7C4rbB+x
         I6jH3jLwohYo3fI/dFuITuUJ9Wzoz8GPYZZucxEcpca4KWGcv5o9kpe9thPjg78D0/ub
         D/DqNRXftyzUJor2nN0ejp1ob69vJMePW0Q2zi80polB1qwbSAPW1ajMx5Hpt5U2CL1o
         ShGg==
X-Gm-Message-State: AOJu0YzXwhVyHvRiW2jKT7q2I4scFZvSxSJe538t/XLtNVaeGy6cE7Ul
	Gsf+NFKp4BitaQQ6sqOdUmOsltdaobQykFpxJFYr2qhWwKmLjeMYviqbucsliawLeD4=
X-Gm-Gg: ATEYQzxa68UAZUcISngy1m9pqHh/TM0tnJ070IMUtCfVNZsWbXPxdt3LxoUjs9LMWZ9
	+FaxzbvwwiRAAkbxsnX25Oy4jMjSp8G2Sw0JzduCkSTPAXamiv3hmgTDinxb7V/s+tw3hSPcqQF
	FhtSnxN5D9HQXesb7/huePmlkbOCcamuZm14ZK33fbRwxsqLWTJcm1pFSUcv/RysWnWrveXRRHK
	6cj/CwlDlmPOgpLK7Uv3QlP5E/8Xy+0szfkmsiY85fSf4nrgBQhO5qLmtRkshOqpS3tSGzsR2vn
	mydlWRoLFlLIG2Zh6G8k94x9lmZLKi0Jx2cb08H5xPvZgFVzglt5GmN/TbLSptKY8KDumdn8Zon
	anqkTzAInP3vkhkoCIhAlB0snIGkyszQK6Llq+ZJ41PR+fN8Q+WuXkHPxm0YE4OlgOTW+mxXIn0
	5/Wp1OFKOP+e7XR8XA41MSMr4cdgFmSPZau4qhsMSUAkWYYMlEnTl4u4HV6F+FSAGGcZBETWFEA
	Q==
X-Received: by 2002:a05:6871:eb02:b0:417:70d2:f991 with SMTP id 586e51a60fabf-41cec09effbmr6735209fac.8.1774889151045;
        Mon, 30 Mar 2026 09:45:51 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:a67f:a092:38d7:379e? ([2600:8803:e7e4:500:a67f:a092:38d7:379e])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41d04958090sm5896554fac.7.2026.03.30.09.45.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2026 09:45:50 -0700 (PDT)
Message-ID: <ede20708-2575-4761-9876-80df5574cb2f@baylibre.com>
Date: Mon, 30 Mar 2026 11:45:49 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: ad4695: Fix call ordering in offload buffer
 postenable
To: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 "Hennerich, Michael" <Michael.Hennerich@analog.com>,
 "Sa, Nuno" <Nuno.Sa@analog.com>, Jonathan Cameron <jic23@kernel.org>,
 Andy Shevchenko <andy@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260330-ad4696-fix-v1-1-e841e96451b2@analog.com>
 <cfe07818-e040-4ce8-9407-d951df637af1@baylibre.com>
 <LV9PR03MB84144580E5523DC01542E56FF752A@LV9PR03MB8414.namprd03.prod.outlook.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <LV9PR03MB84144580E5523DC01542E56FF752A@LV9PR03MB8414.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/30/26 9:31 AM, Sabau, Radu bogdan wrote:
> 
> 
>> -----Original Message-----
>> From: David Lechner <dlechner@baylibre.com>
>> Sent: Monday, March 30, 2026 5:11 PM
>> To: Sabau, Radu bogdan <Radu.Sabau@analog.com>; Lars-Peter Clausen
>> <lars@metafoo.de>; Hennerich, Michael <Michael.Hennerich@analog.com>;
>> Sa, Nuno <Nuno.Sa@analog.com>; Jonathan Cameron <jic23@kernel.org>;
>> Andy Shevchenko <andy@kernel.org>
>> Cc: linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH] iio: adc: ad4695: Fix call ordering in offload buffer
>> postenable
>>
>> [External]
>>
>> On 3/30/26 8:34 AM, Radu Sabau via B4 Relay wrote:
>>> From: Radu Sabau <radu.sabau@analog.com>
>>>
>>> ad4695_enter_advanced_sequencer_mode() was called after
>>> spi_offload_trigger_enable(), meaning a regular SPI transfer could be in
>>> flight while the offload was already active. When the offload fires its
>>> completion interrupt concurrently with the regular transfer, the SPI
>>> engine interrupt handler is not designed to handle both at once, leading
>>> to a kernel panic.
>>>
>>> Fix this by calling ad4695_enter_advanced_sequencer_mode() before
>>> spi_offload_trigger_enable(), ensuring all SPI bus accesses are complete
>>> before the offload becomes active. This is consistent with the same
>>> constraint that already applies to the BUSY_GP_EN write above it.
>>>
>>> Update the error unwind labels accordingly: add err_exit_conversion_mode
>>> so that a failure of spi_offload_trigger_enable() correctly exits
>>> conversion mode before clearing BUSY_GP_EN.
>>>
>>> Fixes: f09f140e3ea8 ("iio: adc: ad4695: Add support for SPI offload")
>>> Signed-off-by: Radu Sabau <radu.sabau@analog.com>
>>> ---
>>> When enabling the IIO buffer for SPI offload operation on AD4695/AD4696,
>>> ad4695_enter_advanced_sequencer_mode() was called after
>>> spi_offload_trigger_enable(), resulting in a regular SPI transfer being
>>> in flight while the offload was already active. This caused a kernel
>>> panic in the SPI engine interrupt handler.
>>
>> This used to work (I spend many hours testing it to arrive at the current
>> state). Are we sure there hasn't been a bug introduced in the AXI SPI Engine
>> instead?
>>
> 
> Hi David,
> 
> I also tried looking in the AXI SPI Engine and find something related first
> but couldn't find anything, though I am happy to be corrected.
> 

Which commit is the HDL being built from? It could be that something
changed in the FPGA implementation rather than the driver.

Sending a regular SPI message while offload is enabled should still
work. If there was a design decision that changed that, then we should
also fix the AXI SPI Engine driver to return an error instead of crashing
in this case. (I hope we can avoid this though.)

Even if this one particular case can be worked around, I expect the same
race condition could be a problem on other chips (or this chip in a
different configuration). So it would be best if we could restore the
AXI SPI Engine to the way it was working before.

>>>
>>> This series fixes the call ordering so all SPI bus accesses complete
>>> before the offload becomes active, consistent with the constraint that
>>> was already documented for the BUSY_GP_EN write in the same function.
> 
> ...
> 
>>> -	ret = spi_offload_trigger_enable(st->offload, st->offload_trigger,
>>> -					 &config);
>>> +	ret = ad4695_enter_advanced_sequencer_mode(st, num_slots);
>>>  	if (ret)
>>>  		goto err_disable_busy_output;
>>>
>>> -	ret = ad4695_enter_advanced_sequencer_mode(st, num_slots);
>>> +	ret = spi_offload_trigger_enable(st->offload, st->offload_trigger,
>>> +					 &config);
>>
>> Swapping the order here introduces a race condition.
>>
>> ad4695_enter_advanced_sequencer_mode() starts sampling (triggered from
>> the
>> internal clock in the ADC) and the first sample could be completed before
>> the SPI offload is enabled. If the first sample is missed, then all of the
>> data will be off by one index on the buffer.
>>
> 
> I thought this too at the first glance, but couldn’t be sure so I tried testing it
> anyway using the FMCZ evaluation board and a Zedboard, and everything
> worked as expected.
> I have plotted buffered data and it showed exactly what the Signal Generator
> was outputting and on the right channel, so no index was off, if that's what
> you meant.
> 
> Best Regards,
> Radu
> 

Does it still work correctly if you add a msleep(100); after enabling the
sequencer and before enabling the SPI offload? (to simulate a slow/busy
machine).

It would also help to look at the SPI signals with a logic analyzer to see
what the timing is.

I guess it could still be OK since we currently only support the case of
the PWM acting as the CNV source.

