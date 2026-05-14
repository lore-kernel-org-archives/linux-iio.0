Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB103016F5
	for <linux-iio@vger.kernel.org>; Thu, 14 May 2026 14:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778770606; cv=none; b=CutGwPYjsj4l/CgkVj9q7Ia6yapxJs/RicBJxXSCDr6a8vutT64n4e7DiKQnUymTpTawGF16S6upz8SZz1vmPa5D1yTyLWKUUXT5wbG6pAMYbKExQNgVYiWYotjESGQ8hQ/QOsIuPAhBRyq4fI8DNbyB5WPWtymtqAY1AOvgHug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778770606; c=relaxed/simple;
	bh=qhbbngVERu2Xm8MzB52z0KBJcvNR8s2X07VAdDt3Y9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QOE1j//2r+qVDxR0DzwQFF+qkZGnSxhEAuXwfuBpKKAwaEl72ttBjTS2ZZaLeGmBGsk+qpS0T6vU+r1qsb3QnB8FqIJV7gU6SBpRwkCz1T1iUaSnEX6q5gjGQQ72cU3PP4VgFitpDKOAPoqvfJkqK1V9zQmyYGybwlyBpg9Bdi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=Pe2recLu; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="Pe2recLu"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-479dd56d016so5927956b6e.3
        for <linux-iio@vger.kernel.org>; Thu, 14 May 2026 07:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778770597; x=1779375397; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3ZHQymLBZlLIEoCTHhxJTW0+QbX2UR4RurcTE5hkA3Q=;
        b=Pe2recLuzQeV9B7Iw4OqWfj9dD8+EkiIkCrPFp0sV5kqWERWhgrIyreQRGZx8fJSYU
         zxUVCXvUyeTj5TgueDcc4PIG/P843VZNVLIaGFlGxXhABw80wUa/5Bd0XEsTt/8FWPG4
         QwTwHnjJNUkM5n9zYdM9BaSEQKlDvqM2AyzuGnQwg1AQGOI2lenFBKPW2MWiF6MMRMUx
         8A1pQvfEN9N29Zu6pcoJrFnSOF1ceSpkw01lYBExdS5YHM/39hrkINIhu21XA52FSAIx
         j18QMyrJG1kSUILg9oye3j1ZdUc+d9eBFPocMffzt9uCka/TEkeBvPOs56l3MZ52Jfkm
         l/yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778770597; x=1779375397;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3ZHQymLBZlLIEoCTHhxJTW0+QbX2UR4RurcTE5hkA3Q=;
        b=DGfTdtlrLlCY5J+SQD2ooj1sN5J1Tli6+Lv+I0SYY6mYGWE+zvUzyKbMBTNzfQYVNs
         CoWWQ04ealVHC16E8eOxIxI/vVYE4qpMSMcMDP8Mve1b9WRxBdE5mktSr3ZNH1IwHjmA
         57bK3fAaIhA17hbkGM/XPiOnOVw8xscyFId3M8/IlBDfV0h0q9wNJY92OLWMS3gbMfLl
         lAjjQehLtoRzinBEShDvQ6b8BGuhN9nzHYRmSaC5xk0ySQUv5+09pF7l20ybtsRkLBQZ
         HUFr0tIEa/zNBQ6+BWtCwpHdbhwFa7J+hG3Sh8wjh1cVBgN0JBn12M4BhsxY+vBvYsO3
         QtNw==
X-Forwarded-Encrypted: i=1; AFNElJ/1hrpUhn+xfT84uboK4i8cbrueIC91fGm0z9+2nidAFLViVEAdHj5rdCxEsWYbBfl134DJFB9wkAU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+5OniqIaxlwirzFQcxiTzSsI2K/F8T9M6gDSgzBpjZB917k/W
	sdv+LgR5kCU0H4V6P4QqQ6HO00+yVp+ieEnoiwrghgZysyhVckEkGCmfhbtuFVpkSTE=
X-Gm-Gg: Acq92OGRoqTMa0pE9vDLCBHCjO1tlQ2StkBY5k6D8gDXyrASZjP8fhV/RszzCkTSxDv
	2gzku40XigLpIssF6Et65OgU2OWdDe4KkXyx+RlsHuHmOfalMNmY8cOJDT/saG3F7mEg9jQgUX1
	nmufTU29VhtSBSNbA4v6NC8CVoku+Izm2rAw7GmQSzPN3uOWWNY5oanbavxi90GgVvUm9nelMIc
	owT38BIi+uBaj4GOu6nTkNXJk0TCLr2E3ZYXp3F7AueIdaHva7LksLIfisMev31p6+RLJNUyjko
	tVi/mvLh0O0L29cKFeQf/Gkeu1eaNAwQK5suiBwLMyj0VpKGwfnIg/mJK4jWwqwJA0Xes74nqNG
	sTWqqby2qoYdagLaFGKaDaQimjEpS6MyllpJ7RxvWoxv42Rqmvzl4D1T/ej7EA9P3ATEKj/a3Sk
	EtxgXYhvuBUJDx0GL+bQe6rDy5kiCJYbihWFbnxhD9YpNjWRhnvoOT+a/g/RPhUveNlqq99//E6
	g==
X-Received: by 2002:a05:6808:c16d:b0:467:23e2:5097 with SMTP id 5614622812f47-482b622c8cfmr4401033b6e.37.1778770597198;
        Thu, 14 May 2026 07:56:37 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:649d:d320:df1b:143d? ([2600:8803:e7e4:500:649d:d320:df1b:143d])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-482d3d48667sm1398493b6e.13.2026.05.14.07.56.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2026 07:56:36 -0700 (PDT)
Message-ID: <e17532c6-3568-4c9a-9d6f-64af7e4736ba@baylibre.com>
Date: Thu, 14 May 2026 09:56:34 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: adc: ad_sigma_delta: fix CS held asserted after
 single conversion
To: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>,
 Jonathan Cameron <jic23@kernel.org>,
 Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 "Hennerich, Michael" <Michael.Hennerich@analog.com>,
 "Sa, Nuno" <Nuno.Sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine_K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260507-ad_sigma_delta-fix-v2-1-ec86eb0463bd@analog.com>
 <20260512121326.189817b8@jic23-huawei>
 <LV9PR03MB84148EC966F80CB723325B46F7072@LV9PR03MB8414.namprd03.prod.outlook.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <LV9PR03MB84148EC966F80CB723325B46F7072@LV9PR03MB8414.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/14/26 5:07 AM, Sabau, Radu bogdan wrote:
>> -----Original Message-----
>> From: Jonathan Cameron <jic23@kernel.org>
>> Sent: Tuesday, May 12, 2026 2:13 PM
> 
> ...
> 
>>> Fixes: 132d44dc6966 ("iio: adc: ad_sigma_delta: Check for previous ready
>> signals")
>>> Acked-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
>>> Signed-off-by: Radu Sabau <radu.sabau@analog.com>
>>
>> Actually - dropped again. I forgot to check Sashiko.
>> (Note please do this yourself in future and reply to the patch if changes are
>> needed).  It raises some concerns about devices that don't provide
>> the callbacks and hence won't ever use that keep_cs_asserted = false callback.
>>
>> I'm struggling a bit on how the max11205 works at all as there seems
>> to be a status register read on a device which claims to have no registers.
>> ad_sigma_delta_clear_pending_event() as the binding suggests this device
>> doesn't have a drdy_gpio
>>
>> Anyhow, please take a look at the feedback and if it's wrong please provide
>> an explanation of why in this thread.
>>
> 
> Hi Jonathan,
> 
> First of all sorry for forgetting about Sashiko. I had a look at max11205 and it
> seems like the device doesn't have a CS so therefore the concern Sashiko
> raises regarding CS may not be valid, I will make sure to mention
> that in the commit message.
> 
> On the other hand, I see the IC has a shared pin for DRDY and DOUT and
> the bindings specify some interrupt though no specific rdy-gpios are
> mentioned there. The device reads a register that doesn't exist which
> in this case means it blindly clocks out whatever comes on MISO...
> 
> However I may have a fix for this and would appear in a second commit.
> In clear_pending_event where rdy_gpiod is checked there could be yet
> another else branch that could simply return 0 and here is why I think this would work:
> 
> Since the IRQ is requested with IRQF_NO_AUTOEN and IRQ_DISABLE_UNLAZY, the latter
> keeps the IRQ hardware-unmasked even while software-disabled, so any falling edge

This should depend on the IRQ controller. There are some past discussions
on this on the mailing list. The ideal behavior should be that if the
IRQ controller can fully disable the interrupt so that we don't get the
spurious interrupt on enable (from the normal SPI data, not DRDY). If
the interrupt controller can't do this, then it requires the rdy-gpios
to be able to distinguish DRDY from SPI data.

I have used this on ad7173 on a ZedBoard without rdy-gpios and the
interrupt was working correctly. So unless something changed with
the interrupt config in this code since the last time I was using,
I would not expect to see this problem on _all_ interrupt controllers.

> from a completed conversion is latched by the IRQ controller. When ad_sd_enable_irq()
> is subsequently called, the latched edge fires immediately, and ad_sd_read_reg() reads
> the complete stale result without any prior partial clock corruption, so the result is not
> read by mistake as it could currently happen.
> 
> Let me know your thoughts on this,
> Radu
> 

