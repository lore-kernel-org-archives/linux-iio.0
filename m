Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C956833A717
	for <linux-iio@vger.kernel.org>; Mon, 26 Jan 2026 16:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769445299; cv=none; b=budWD2tAxdnnSPGO6ByNC8w5RtT4DDtsZ17VA/VOc05Fu+vWYE1RR0LMKxFCSWlypoNmDfeciMeU351+drDp0AnKm6bWoMYiFSm9PstMV2tpIBM2+SZi7yAgEy8tqmM14Q5hBvUAiPB/hv0ZzKsIb26ozZLKjYUDX25hV556taE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769445299; c=relaxed/simple;
	bh=ZyeCEnRJjBRKG7NXS66982Tk6HBV6hiwXRGWLHqwKpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HAuxgeZ0tBKFHJ3t3YuLTMQnfhlw1kw3smz/iOTqYPN7W3p/fPYlrvjqpnjDk3xbC1s3yQ6JpwDRq3y7xgEVjT9SpUwd3+PIeiGsY6/FcGZVuXF7gbQp5PEm9i/10G0OLNny0OE0STYgG1BG0sMnsXIawmC4gh/l5MwCCdJbmtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=E66wUZxi; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="E66wUZxi"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7cfe2a6bf81so1455334a34.0
        for <linux-iio@vger.kernel.org>; Mon, 26 Jan 2026 08:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769445296; x=1770050096; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BNGg+szk5GN7k1/fr737eGbbjOqTigabkUA45rZV/8A=;
        b=E66wUZxiiAgfz7m+tVuJA/9izTvlkE0JDzwabHNfuRRm//F8f76q8eU478427/R0Mb
         uunZ/rOLSAUhd2TTEhpVLooA0ZWqq/xaQqwb+b3r7frW9uJyCe/ql28+avjFEooFwEt5
         KY1o/JlvQKZwvdwj+cla93FRXMEMy38tG+1lnbeshBB4kfhLM6n4DoqTMZ9FCe/eM1Mg
         xfm66UzeldhXntYUR2hoOcU34g3YfpYyISxa9vk9xQqais5p2/kbF3g55F0wb66riGa1
         ZMY14tA0gpX5d0H7QyJMU7GYvNJiHO+TCeVRsTnYQP/IaxxAsKsBH8aLjOiAfwOXifAD
         vAKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769445296; x=1770050096;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BNGg+szk5GN7k1/fr737eGbbjOqTigabkUA45rZV/8A=;
        b=XOB2h6rXMdywGkbpw9kWmi/6mK00gsQKC6ylCdecWPJ55i+lyEdP68PQphZpTfnJc7
         j3JWaiRM5QKiWUGsxxmjjfolID3XtxtzO1M2b0ekBYoI3zZBJ/CnBhEiqkU9njAFAzBl
         Eu1tcq/APEVWe/HHKVIuGLUDjMVLjnx3eUPyq+nMcQfYXiH6EiMSWXoom2o0aa30F7V5
         v9bs4sBrArstP3d9ayu2e+oAQvAr8U6U1PF3YinS4SBwYPlNKOxca19JT6cpJhzsWHoq
         7J5rkcpvRxnyuohyt8ApNIZ2/hve76AR8Da3wxvZ4zOu11fmj1TyZdKdCf1tRHVK337d
         vvhQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7VpILDs0YCzjMtfo3CB4KLqrsQ7BXej6z0wapxj9EMvu20B7yg50jQTryDis5+enzaJW8DbQbRpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YybhMv44CjQ60+eHocEahF1D92kz/sfRV2Ih6kh1GO4kDpWDzRQ
	a9HePcvW673dTlI+wQxsyQZ2zJS2eTqdo86u8zk3WUqEPI8Cvg6s8jVwncLS0MvBKOo=
X-Gm-Gg: AZuq6aLOI3FDnSANvUHZ2O31/hVknTq7wCu3C9yLvys0CyEKiM5fADfvpCOfCzlmgEA
	ST63mSCfJU5WZjLdv/fQsB0w39ziaWg7MYOPdeJ7Fd8HzZx998iU+40JW77uoHsdpUjeUv7NRIC
	QtwuISJOYd93xlCxY8I6zvZ72i0/0HQoc2i9lejcxqlJfycw3kF/mSQtUEQ+y/lBn64I3gt6TQc
	9qpACHgjqtTZhanhdk7DPoHVCkjVOL06CH8butchqeJ+7q4mrpQJTgsL8MJl926w1AdkwUNqM9p
	DuEe8bfhqtP8/wuuGbEuWV3MCtsuWZ9BsEbrWY0vMiTl9HCD9rY0PXkLuPySdhO0F9dzOnw4Vwh
	YLZLI386qOR9HlHMxPkACql2TMrJbXfBHC4ph/4mZj+H4wdqY/yoy6lNInM2w5m5kkJDW6s2hVl
	Cr5Gtv4Gf5m7YGAprLjzdCHijPsScSrj7q4rI0JKS0IAKq83jRrYCBqci02UKu
X-Received: by 2002:a05:6830:2810:b0:7c7:6063:8e0f with SMTP id 46e09a7af769-7d17021ec7cmr2337382a34.15.1769445295763;
        Mon, 26 Jan 2026 08:34:55 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:37c6:d863:90ba:c4c5? ([2600:8803:e7e4:500:37c6:d863:90ba:c4c5])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d15b36db91sm7936018a34.13.2026.01.26.08.34.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jan 2026 08:34:55 -0800 (PST)
Message-ID: <8e560227-3596-4bf8-9fd8-b843a4738940@baylibre.com>
Date: Mon, 26 Jan 2026 10:34:54 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/21] iio: Use IRQF_NO_THREAD
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 Thomas Gleixner <tglx@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org
References: <20260123113708.416727-1-bigeasy@linutronix.de>
 <20260123113708.416727-20-bigeasy@linutronix.de>
 <ac45bbeb-7a76-42f0-88d8-35dbf9742a0c@baylibre.com>
 <20260126080903.B0_vWRKy@linutronix.de>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260126080903.B0_vWRKy@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/26/26 2:09 AM, Sebastian Andrzej Siewior wrote:
> On 2026-01-23 14:56:32 [-0600], David Lechner wrote:
>>> -static irqreturn_t ad7766_irq(int irq, void *private)
>>> -{
>>> -	iio_trigger_poll(private);
>>> -	return IRQ_HANDLED;
>>> -}
>>> -
>>
>> Replacing this with iio_trigger_generic_data_rdy_poll() seems like a
>> separate improvement that should be in a separate patch.
>>
>> At a minimum, the commit message should explain this change. But I expect
>> the reason will make it obvious it should be a separate patch.
> 
> The other use iio_trigger_generic_data_rdy_poll() as the handler except
> this one. Which uses a wrapper around it. It looked to easier to add
> this hunk.
> What do you want (split or keep)?
> 
I would still expect a separate patch to replace the duplicate
function with iio_trigger_generic_data_rdy_poll(). That change
stands on it's own, so deserves a separate patch.


