Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400B82DEA64
	for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 13:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778851651; cv=none; b=rgVuT+iQHeBcThqVMmSwg/IgUYqxRXlm+zTdZH/NfarY6wQrK0GwB0oX2DMJ3Y4x6AbpZVr6RIQvDlMpV2mZmP625UbK+SZLyye6X5rZxONbzdZQgUq/xg8ZhK2Obfwdk2in6b7Vch4FVwTRAKtt02ZRpn/o1zutaOJtAPH9+TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778851651; c=relaxed/simple;
	bh=dsBj6e4mpRjfZ9vKYdxVQ6NMr+Ia6+LRhvSK55by1rU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XKVlc4R2UZftgkCykdr/iVW0TVFCskwe0V3nlsckEkqaJMj1SkFyzJkdKYUmDaYB2xyoMx1F32iWcKuX1CluHaTvtIRFJ9ikjZJmaA5Gau+Cy9e6JsVYBP4LKeCWfUmee1fJ8zuoOufT/+AXipmUJyS7k/7lyAhmO5FA+9ZG0f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=B0rjD8CP; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="B0rjD8CP"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-435153d9b68so5902415fac.3
        for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 06:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778851648; x=1779456448; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1T+fF1LSGT29QbQTVrKLQjASXgTTvqvLHzdAkxvN5gs=;
        b=B0rjD8CPT5ZZsS31HPON/PaH2DrNhbCAGiy0w9mWAq+ivBFWoXPCQ/Yt3A/azZt9ua
         FoCOIk+8Xnvy+GDltAENJFmgRnnwLmF1Jq/EU20KMpvunbcX8sfg/Xm7w2Vh6jwyjY5o
         qsFzKcPsBHKHUevyqExEBdkU6k8qJRmDFgGFpuolp+wy/lAPw4deTXOhvQNHgHTW8X3O
         sOwh5lxnMew+6SAHab4sui2b9uwavkRANai0C6Hm1VNtOH8z+qWBlDLQDW47LPeMiJSa
         jcK9Jo+nJL12mlkYcEYqs50wtdDCivu1WnYdNIc21CGRSssvQ0/5gq8vflPkXyFDIQTv
         8Ohg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778851648; x=1779456448;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1T+fF1LSGT29QbQTVrKLQjASXgTTvqvLHzdAkxvN5gs=;
        b=OqkzQxPMVoSxK6Ir9XN252C243FGIsapds1B7Kw6k0QUMF8HTmBqshsauVH2oAZJiY
         LOPbGNWBvXuua7EyN0WaK30c0ZDMNQefnTgsGW4E7Gn3aq7BTT9xjbMTkThuOfUnlKIZ
         K37XXGP5MJQnSVpuPfUDmKFhW1gbEjhjuhGzqiWKRvTIejkPB13k6mXHonajl56gLfGN
         zXrbsB2E/BvOShqzoCI0zKVGq7JdS2XijhCp1v8I1ZaN5jwWsaNsCGyCUjv6LMVAGQrN
         nUC1X5mB/1EN3biRGAmqNhY2A8/qZ6VMt+So6jsrYDpbk/Ct2JHNKpcvzDdANmYDFMuH
         Fwmg==
X-Forwarded-Encrypted: i=1; AFNElJ8d5vsGrIccCr9wnGIwZzWrrC3Z9y3cBZ777HFDGur44A6r0MnpS6t65JH5COhd7p4sb0b1yHAttus=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfDVEHZ/rnc2NikMMbU4sXNgVmJUZu2Z4+pod/OyrsllPxR3mR
	CcnXEwWiclD0zyg3U2hsQZs7PLvVM9S3RlfdVQxOl4T5nc8I7h4zB373e2980NGxd6fWeJcfg5H
	GgbEIp5w=
X-Gm-Gg: Acq92OEJH0pcwWRZkSYRahxd+LhsHpRqXWVyHh0Xbz0ICw/PauNC02nH3X40o6tG4uW
	7QXixdYR5XmmZFhmK84CeAp3rJmrxLpkcK2P1eLqDVkuOL8k1OraVAr3jijQ/0K11QhnPZGoMWz
	6hXT1xE/0oZVsJ4nGqMF7NlEyFtB+slo9q3F9i37vqTXkkIuao8Kt2qxUcEVACFcYuFj3/XgGFP
	PGbiFuSD0/8FrvlMCVA0NiStPtIqf4NfJ+6ikvINnSs5Dw4ATSSadVZrUw7y6aiA8Z8bbjUlN/e
	wZngupOIAGpNGltCK06xnxq8+OktVfm2YpBHtpDQmcjtOgN0t5pOVtoPtUcEAf2jox0EZ6gO1yU
	g4EcZazWZDthvVO+Tost8/O+gjfdbSTyLa8lW5YZuzOxP7VN39hwPcxyiugbNq3CAb+QELT3+xX
	60TIF4SnINCgmj+QOE819a+z7wQnIzAvwMHLwEelOtDcvGF6NfBV4IDlevyuKur5Eb7+PxvukI6
	ATTjopLuZAC
X-Received: by 2002:a05:6870:2e89:b0:422:ff63:9a6 with SMTP id 586e51a60fabf-43a2de0786amr2788795fac.34.1778851648025;
        Fri, 15 May 2026 06:27:28 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:7217:ac62:908d:d3a2? ([2600:8803:e7e4:500:7217:ac62:908d:d3a2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-439fc4d8027sm4233175fac.10.2026.05.15.06.27.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 06:27:26 -0700 (PDT)
Message-ID: <4b9fbf8d-6dec-4e18-a3c5-a4b87d34af08@baylibre.com>
Date: Fri, 15 May 2026 08:27:25 -0500
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
 <e17532c6-3568-4c9a-9d6f-64af7e4736ba@baylibre.com>
 <LV9PR03MB8414852B21F8B66AF821055CF7042@LV9PR03MB8414.namprd03.prod.outlook.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <LV9PR03MB8414852B21F8B66AF821055CF7042@LV9PR03MB8414.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/15/26 4:20 AM, Sabau, Radu bogdan wrote:
>> -----Original Message-----
>> From: David Lechner <dlechner@baylibre.com>
>> Sent: Thursday, May 14, 2026 5:57 PM
> 
> ...
> 
>>>> I'm struggling a bit on how the max11205 works at all as there seems
>>>> to be a status register read on a device which claims to have no registers.
>>>> ad_sigma_delta_clear_pending_event() as the binding suggests this device
>>>> doesn't have a drdy_gpio
>>>>
>>>> Anyhow, please take a look at the feedback and if it's wrong please provide
>>>> an explanation of why in this thread.
>>>>
>>>
>>> Hi Jonathan,
>>>
>>> First of all sorry for forgetting about Sashiko. I had a look at max11205 and it
>>> seems like the device doesn't have a CS so therefore the concern Sashiko
>>> raises regarding CS may not be valid, I will make sure to mention
>>> that in the commit message.
>>>
>>> On the other hand, I see the IC has a shared pin for DRDY and DOUT and
>>> the bindings specify some interrupt though no specific rdy-gpios are
>>> mentioned there. The device reads a register that doesn't exist which
>>> in this case means it blindly clocks out whatever comes on MISO...
>>>
>>> However I may have a fix for this and would appear in a second commit.
>>> In clear_pending_event where rdy_gpiod is checked there could be yet
>>> another else branch that could simply return 0 and here is why I think this
>> would work:
>>>
>>> Since the IRQ is requested with IRQF_NO_AUTOEN and IRQ_DISABLE_UNLAZY,
>> the latter
>>> keeps the IRQ hardware-unmasked even while software-disabled, so any
>> falling edge
>>
>> This should depend on the IRQ controller. There are some past discussions
>> on this on the mailing list. The ideal behavior should be that if the
>> IRQ controller can fully disable the interrupt so that we don't get the
>> spurious interrupt on enable (from the normal SPI data, not DRDY). If
>> the interrupt controller can't do this, then it requires the rdy-gpios
>> to be able to distinguish DRDY from SPI data.
>>
> 
> rdy-gpios added to yaml of devices that don’t have them and also don't have
> registers is a solution too. Though I think what you mean by this is that the
> rdy-gpios should be something optional to be added by the user depending
> on his IRQ controller capabilities, right? Perhaps this is the case here already.
> 
>> I have used this on ad7173 on a ZedBoard without rdy-gpios and the
>> interrupt was working correctly. So unless something changed with
>> the interrupt config in this code since the last time I was using,
>> I would not expect to see this problem on _all_ interrupt controllers.
>>
> 
> Yes but ad7173 has registers, max11205 and few others don't.
> In the cases where no rdy-gpios, although registers are present or not,
> it "reads" the status register which in these cases means clocking 1 byte

There is already sigma_delta->info->has_registers. Why is this not
used to prevent reading the status register when there are no
registers?

> from the DOUT line, and here 2 cases appear:
> 
> 1. DOUT/RDY is still high which means DOUT reads 0xFF
> 
> - "status reg" = 0xFF
> - pending_event = !(0xFF & 0x80) = !(0x80) = false
> - returns 0, nothing bad happens -> Works by accident
> 
> 2. DOUT reads 0x00 (line LOW) , perhaps RDY dropped already.
> 
> - The 1 byte read already consumed 8 bits of the actual conversion result and
> data stream is already corrupted.
> - "status reg" = 0x00
> - pending_event = !(0x00 & 0x80) = !(0) = true
> - Continues into the drain path
> - kzalloc(0 + 1) -> allocates 1 byte
> - memset(data + 2, 0xff, 0 - 1) -> data_read_len is unsigned int, so 0 - 1 = SIZE_MAX
> - memeset of SIZE_MAX bytes -> heap corruption, kernel crash -> Worst case, but
> still possible
> 
> I would then say that the solutions are 1 of :
> - add rdy-gpios as well where has_registers are false.
> - add another else with return 0, since if the DRDY is not low, it will be after enable_irq,
> and if it is low, it will be triggered afterwards and clock data correctly. For these devices
> as far as I can tell, there should be no spurious signals, only the DRDY interrupt unless
> clocking data. I may be wrong though, and perhaps the rdy-gpios is the safer move,
> though this would mean less churn.

I would expect the need for rdy-gpios to be the same whether not not
the chip has registers (only depends on the interrupt controller).

> 
> What do you guys think?
> 
> Thanks,
> Radu
> 

