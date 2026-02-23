Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C754313E1D
	for <linux-iio@vger.kernel.org>; Mon, 23 Feb 2026 16:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771864277; cv=none; b=VksnuMzPnGG5M1t7I5KejUvdBTYUUPJFuvmjHsGTHpdu2J3ZS31RFFSJwd7Ai3gSsTM4GYAKdgS7D5ITpIE9WJb22igiLrGF2Bkywh5jYTnddXIwpmLrZXh2gQZ239dXJEtHAEnMo+aJNNIkJ3aHmaBSBnNRU6UyRTP3UJLsauY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771864277; c=relaxed/simple;
	bh=AXKL+fcozxp+GpI8pvxD2aSAWc8U1kpa5P0PeJuGNDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mcXzzdlIMFi4Kp0w2j5mwLtmsrWos4WSbCYnN/SD+m/eI2GzjGP4cfELjito50mQ+e0I+ls/hf35h3FUNhCEJDQem2BphIpwyPsh2uTcN2NBFQIZBIMFnRvgzWhwrR/lVH1v6kDM75ulM6WZUhvGIc7MG828TzQTKUBS1Fx6u/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=smL3rtHA; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="smL3rtHA"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-4639279c7a6so1649543b6e.1
        for <linux-iio@vger.kernel.org>; Mon, 23 Feb 2026 08:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771864274; x=1772469074; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4/WSSubdXWO4v+sW3CLfrhFH7dC9lTt9CrzEJ0rC2GY=;
        b=smL3rtHAqrJv7TMtk70jhHz42Lvg6NPjZxJZN4zyJBM1WdRwBgk/CVoC5uQQZO8/5v
         EuAzZrCGx1sCm/aVaczCjnK/tKZOgFsDJkgiyONQK94B3TjFN743RJaS/ZKaND3pCes7
         /yvNTIgQFAyzmwDpdvB/HK6nim/Bhgl8Qz7V+72PIRsTDBbQSgNNHEadzL8S9r+zfS8u
         Xl7NTzJ5IZopHDUxzUuZpuHTQfSzvWf09283FP3R3w0yPx/v9VCoCt6wxsbboDOfPr6j
         cdrA8tKQzWB9vDZ8spFC7eyFgUP5d3yhx1nGaYQNr8V/8/VnPAv81eMYGCV1EiO9+zkZ
         IATA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771864274; x=1772469074;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4/WSSubdXWO4v+sW3CLfrhFH7dC9lTt9CrzEJ0rC2GY=;
        b=JO8/PP1rhq9y+ilsy5VxaH2kReUCjVUBBdmWZKQdhhJCQa2mKrz6ALEfZXtYKQgupE
         fv62g6+g+IQAunKpr2QsEgnHqF14lpBB+7/EI/MDu/xR8LXGeUsrDc39OMQfA1QFn/d/
         xHAnWRsUFfUa1bq3k2NVfny2NfXTnKRbk2J4e00z8q7t13m5jvTdLPoroHtEezuv9F4P
         5b/hUKzeYGCxSVBl/aA2je8J8qzIMJOO3syn1uGDT4DEH6Dsr9lbUlt/dwJZEEWT5x1B
         tTq2soer29+zeWm4vvGtCVdaFjugMtR1SxKnvJix2naOiOtorbbvRh70L7Y2ITcHLg93
         8rJA==
X-Forwarded-Encrypted: i=1; AJvYcCU6q9oohB5qEorpimIooAp3h+o1DhSzIWBxCZTfjyxh+ky/jXcE34gHWoR6maxlniJKqQYK+pmM648=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuMstnEGZNmTW2IrCEvdNedaBX4qtrUPLT+e+nf2VYzMRcg/Hh
	g5gKRguxa3Le5v/3gAJcZ7upnbHOBiPDsiEf5x2hNrEQZ4qtZ6hKLg6fpIdI/YFAYJQ=
X-Gm-Gg: AZuq6aJrzjFRIBMQ76rINYFHqFLypF7xog9djiN73W3fI0+fJat/fE4fINGqZZEBya5
	ZMP3Vbyghi+d6Ql6MXtfCroz+F1c95SXIAHZFoL6/CBXEJ+DYL7hl52zpjTdpVz/mgzR2Skjusx
	5THbcO91GzOncEt5BqkMyz26RyOMPYG0fjEhdne0lMeQX9EaDsBskj93tlqKTHnp2ir31KaR3j2
	mSflx0FyziWhISDYb8BJ7G5YyQNB6cpiFvHNppNDMYduKZP8kGCZjq3p4Ea2UQq6TVN+kEx3GpX
	N1X51KD10MuZRNt13757luTxXzsq+rHkF5TG8a6v8y3N+edEEXV/KRgoRoKJ7BBWhWETKDCv2g4
	qZJnC6j74blWZ6kS/3B2xEhgfw1Ahzom0CrBbB+Vz0kx5NKYmZuY855e2g0OMX70nzRMaeojwG0
	DFpkpfcQGKTd0IpTAZUepcUg2PkNPFLnZIjlVlupCPkmJKzPClFLZu1BywNxU1oaSctup99z8=
X-Received: by 2002:a05:6808:bd0:b0:45e:e21f:bbaa with SMTP id 5614622812f47-46446341019mr3593036b6e.33.1771864273966;
        Mon, 23 Feb 2026 08:31:13 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:e37:2309:3937:4469? ([2600:8803:e7e4:500:e37:2309:3937:4469])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d52d0725c4sm8168079a34.25.2026.02.23.08.31.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Feb 2026 08:31:13 -0800 (PST)
Message-ID: <022c6472-0f7f-4c56-8ba7-7f9690e8a625@baylibre.com>
Date: Mon, 23 Feb 2026 10:31:12 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] iio: adc: ti-ads7950: switch to using guard()
 notation
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org
References: <20260219022929.3558081-1-dmitry.torokhov@gmail.com>
 <20260219022929.3558081-4-dmitry.torokhov@gmail.com>
 <0b9e1c9d-9bee-4fc3-ac19-28d969f65ef2@baylibre.com>
 <aZt1ypf6msZxc2U1@google.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aZt1ypf6msZxc2U1@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/22/26 3:37 PM, Dmitry Torokhov wrote:
> On Sat, Feb 21, 2026 at 11:34:33AM -0600, David Lechner wrote:
>> On 2/18/26 8:29 PM, Dmitry Torokhov wrote:
>>> +	scoped_guard(mutex, &st->slock) {
>>> +		error = spi_sync(st->spi, &st->ring_msg);
>>> +		if (error)
>>> +			break;
>>
>> I'm not a fan of scoped_guard() because of the hidden for loop in it.
>> It hides the fact that the break; is breaking out of that for loop.
>>
>> It would be more clear/obvious written as:
>>
>> 	do {
>> 		guard(mutex)(&st->slock);
>>
>> 		ret = spi_sync(st->spi, &st->ring_msg);
>> 		if (ret)
>> 			break;
>>
>> 		iio_push_to_buffers_with_timestamp(indio_dev, &st->rx_buf[2],
>> 						   iio_get_time_ns(indio_dev));
>> 	} while (0);
> 
> OK.
> 
> I could also make it
> 
> 	scoped_guard(mutex, &st->slock) {
> 		ret = spi_sync(st->spi, &st->ring_msg);
> 		if (!ret)
> 			iio_push_to_buffers_with_timestamp(indio_dev, &st->rx_buf[2],
> 							   iio_get_time_ns(indio_dev));
> 	}

This is OK.

> 
> to avoid using "break".
> 
> I think you will find that scoped_guard() will gain the foothold in the
> kernel so having implementation that does not follow common pattern
> might not be the best option.

In general, I agree with this idea.

In this case, the common pattern unfortunately leads to common bugs.
Since we were discussing this, I audited the kernel and found and 
reported 3 unintentional mistakes with break/continue when scoped_guard()
was introduced. And I have caught more in reviews before they made it
into the kernel.

So I make an exception here to thinking that the common pattern is best.

> 
>>>  
>>>  	/* If set as output, return the output */
>>>  	if (st->gpio_cmd_settings_bitmask & BIT(offset)) {
>>>  		state = st->cmd_settings_bitmask & BIT(offset);
>>> -		goto out;
>>> +		return state;
>>
>> This can return directly instead of using local variable.
> 
> This will require the explicitly normalizing, which we avoided by
> introducing "bool state" to begin with...
> 
>>>  
>>>  	st->single_tx = TI_ADS7950_GPIO_CMD_SETTINGS(st);
>>> -	ret = spi_sync(st->spi, &st->scan_single_msg);
>>> +	error = spi_sync(st->spi, &st->scan_single_msg);
>>
>> Can just return directly here now.
> 
> I think there is benefit in explicitly calling out the error paths and
> explicitly return 0 on success. It removes the doubt whether a function
> can return positive value on success.

In the IIO subsystem, the direct return is preferred (maintainer and
other reviewers frequently request this).

> 
> Thanks.
> 

