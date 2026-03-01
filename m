Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882B2430BB1
	for <linux-iio@vger.kernel.org>; Sun,  1 Mar 2026 22:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772405147; cv=none; b=BK9BvcPRHuj2LZtmIS6vK8SWuxauzWoMoFT6ZDjgxCh2LbEsXRlqb8IHpgEuMmB3HjXhOMsk4EsEn1L01OVugZpCe6UvbutXLN6J89V5TfsYmWTpsYlWiLDIj+LtXd2LaBuAcXU/S8BL7Uy1KEetf+R93vqkLkBnti5VCKub0vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772405147; c=relaxed/simple;
	bh=U2dadGwNNyKxbfW0uoKnd7FppZIXE76Gd3rLzoWBH2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DNQRkgQlmwx0fEq3R2OX71xMd1x1YE1SLUfPP2HmW8y9XadDF8hFkkgumSt0za+bVluCzutJeMDFN2nE+6QMIMuiYhmcgvTYnorexuk98PR/C/CmQEr7ckFKhxXYDngHgrzkbolSyhgMrZwqNXHq5CC4EejWXDPJJPX9UdNQd4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=X8zxNwrd; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="X8zxNwrd"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-4648448e387so2928501b6e.1
        for <linux-iio@vger.kernel.org>; Sun, 01 Mar 2026 14:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772405143; x=1773009943; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xbpVRCXsg6ZLdT2k1ZtnZrOmKeMWW4VR9/roCkWMvqo=;
        b=X8zxNwrdqEBsZR+plVvDl/rMamLpEYndFj0PcWRzYa2wM7fRlpKcxvzf4FjhkD0+0Y
         cpSOtFH/5rnv3Hkl3w0maWjq20dGqhmrTWcjiPirPZhasbn69N4lm6Un1g2BuY+akIYl
         IsP+qkgAzys8TC9i8TKre5d0DSA0MGMNRupFcQYQMFoI4qIzJPUWchkODo7TjOwhAAUV
         8c4E6S7T+jTBgFfuxv4CtP6ixxJ6wSm120mxUN2lDgkCnkH0rMJNbI6wXotFZROAJKpX
         46z5A78szMx6891kExckBxjoJwxURgYbNDQ+EvwfMCzNE76Iio3waRedwLUF+fEkleTZ
         41Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772405143; x=1773009943;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xbpVRCXsg6ZLdT2k1ZtnZrOmKeMWW4VR9/roCkWMvqo=;
        b=Xqhzr/BBNV02FhKcHwI3ITpB5U7uTNSTSd2qIfjDh9pPHr40OcSp+1kaMlS6oE+DY4
         sjU7K3UsSGX6esb3SctwQ1RlDGgI4dt0nvmUC+It0Eq6OiYhXUR2z5qRgZQeeleydN9s
         RdcxskQLE/MplpCT2mZhf3iFQPnkA4nm2oVX4coPHSfyx/1ohCh9bOb7edvYxvciMq2O
         CubSQQqNRcP6uanH8F6GiPm6GTtrKGkGfVb/9EQWp2+G3iwlT/dxmN7TKgo4iUwK8Iyl
         +UQlFbjG5FYfKqvMuhX6sO6yGErWtvCIfPrBcPJTA/NOr5Z/UYVs+36K8oujRlE/q4ae
         ZWqw==
X-Forwarded-Encrypted: i=1; AJvYcCX9pbzYgzW2j+mD7E/tB7UKGwzodbCRpOfBptK7q6hN9cUWKpdF848iAfbsm8nuwMmc6b1zuNI7Z7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfKBuMgjAlAtNu2/Igi0W9/IVu38Ya07l2cmazMJ9pQX9nXZz+
	1eP9InooVkolrBD+h7rEuAv4UiJTILTb7o8R9WZYZWOMK8qj6f1SypVJ8aV3evlP5gU=
X-Gm-Gg: ATEYQzzJSm1XxFXJDhoqpvSI3GowoKL1H5zaRRxQ5PITUMX+4tBdegT0DUQAGsOph3L
	Upl+SOK/W3AvHAqukA3Qmn0s7CTlDt8XeJlHFaX2XiFB9cntCoIK7z3T1X0UYQm4y2+kwd1A/+K
	x/AzWTPTMt3Uk4NdngLl+Cvhu/7Q5n70V7qEWLcaGvZk6PkUzNZ6dt6wKe6KyRrqIVpYMQSFPDc
	N9g8nyuyZ1eSvnAZuyS1wTwP5zkKeHxy1pJckRUi5C7wsYyPVkB4J9DP2bHZ/1anLXb47UXB2I+
	jF5cwrqA/fRmwXpQZyrZ1xHSXYinTXY7JhvciUsuS2BtwgqGopsjIyQpNZAUrG8xIJn6WOSaMw4
	p2+JF5Xp5NqKnhmHtUiNT5PqqJyL20JrholwSn5Q+EmNnkOUZgMTtqmNPevqNf2oZpfWIlUN4rZ
	WivwAjlGe+8Nrp01OFkBYAg0K0wqIAYUMDbbocw4Rivxw9akyw2R9p5bht3IQLdTWT3JmR5bwGs
	Q==
X-Received: by 2002:a05:6808:1b11:b0:45a:4189:d2cf with SMTP id 5614622812f47-464be947b0dmr4790015b6e.8.1772405143483;
        Sun, 01 Mar 2026 14:45:43 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:8b9c:d657:204d:5a5f? ([2600:8803:e7e4:500:8b9c:d657:204d:5a5f])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-464bb5e417fsm6298197b6e.16.2026.03.01.14.45.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Mar 2026 14:45:42 -0800 (PST)
Message-ID: <53448364-5d86-43ab-a585-202891eef320@baylibre.com>
Date: Sun, 1 Mar 2026 16:45:40 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [tip: irq/core] genirq: Warn about using IRQF_ONESHOT without a
 threaded handler
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Bert Karwatzki <spasswolf@web.de>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Thomas Gleixner <tglx@kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <20260113120541.YVf2vRA3@linutronix.de>
 <20260202232741.13380-1-spasswolf@web.de>
 <20260203083826.1gOzxrwt@linutronix.de>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260203083826.1gOzxrwt@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/3/26 2:38 AM, Sebastian Andrzej Siewior wrote:
> On 2026-02-03 00:27:40 [+0100], Bert Karwatzki wrote:
>>
>> The warning appears because iio_triggered_buffer_setup_ext() (in 
>> drivers/iio/buffer/industrialio-triggered-buffer.c) is called with thread = NULL
>> during the probe of the iio device and calls iio_alloc_pollfunc()
>> (in drivers/iio/industrialio-trigger.c) with thread = NULL and type = IRQF_ONESHOT.
>>
>> A simple fix could be this:
>>
>> diff --git a/drivers/iio/buffer/industrialio-triggered-buffer.c b/drivers/iio/buffer/industrialio-triggered-buffer.c
>> index 9bf75dee7ff8..40eea3a44724 100644
>> --- a/drivers/iio/buffer/industrialio-triggered-buffer.c
>> +++ b/drivers/iio/buffer/industrialio-triggered-buffer.c
>> @@ -64,7 +64,7 @@ int iio_triggered_buffer_setup_ext(struct iio_dev *indio_dev,
>>  
>>         indio_dev->pollfunc = iio_alloc_pollfunc(h,
>>                                                  thread,
>> -                                                IRQF_ONESHOT,
>> +                                                thread ? IRQF_ONESHOT : 0,
>>                                                  indio_dev,
>>                                                  "%s_consumer%d",
>>                                                  indio_dev->name,
>>
>>
>> Are there any problems with this?
> 
> Urgh. Haven't seen those.
> 
> Looking at all the users of of *iio_triggered_buffer_setup*() the
> primary handler is either NULL or iio_pollfunc_store_time(). 
> So IRQF_ONESHOST should work all the time.
> 
> Then there is 
> - drivers/iio/adc/vf610_adc.c 
> - drivers/iio/common/hid-sensors/hid-sensor-trigger.c

I think we also have in the list:

- drivers/iio/adc/stm32-dfsdm-adc.c

> 
> They use iio_pollfunc_store_time() as primary and have no secondary.
> This would trigger the warning but not having a secondary handler while
> returning IRQF_WAKE_THREAD should create a warning of its own.
> What did I miss?
> 
>> Bert Karwatzki
> 
> Sebastian
> 

