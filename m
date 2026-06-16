Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD62546AEFC
	for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2026 18:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781633813; cv=none; b=m9/NrXxMRy8tfdi8Mx7GMFSSZvaoXNgpreeGdkCmiVlEaFOhf06jWTDXXBxM+j1K6FAcZFTAHf/N4MchxfT5w+i+WAHsYKQ2fIQrQob7TEm8OaUVX4QrRGRpvcCkQFn4CrWQ8dVVzJDfRvNjxHLFZbJzT2bYjBctg3romk8Sg34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781633813; c=relaxed/simple;
	bh=HMXSDipecyxoyMLf9IBRX9tSy9InflZQp8u8Vm4182Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GBG3xZtMlUL1TI2d/Q4uL3UfgQVezCN0HEOqed4UjMz7XNw/CDRwSL6a5dMSE1YY3jzGGe9eSyTRM4oamVwCnGtcYlmIuuMe4sXQAh5F9nQRpj8g8D0a94DAc3w/FhftViOxz+Njo7GV0tWQ5YEg+5fzMeKV5h/Uq6Qh+iA9GQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=CTssDelQ; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="CTssDelQ"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7e6cdd78fe6so2762517a34.2
        for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2026 11:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781633808; x=1782238608; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fNH/J02lBrL7hdVnRQ4UVLWbhNp0HeLEy22DRQvVDN8=;
        b=CTssDelQeTtO+25elTtTQHjoAcDKPG/bHuFKV+vi5qf+kPyTFEV0spTbx8gT67ZnX5
         07EhZMJ6JKI/l9nKEcyQf6vxuThE2cL6vbYsIvgMr025V4jKcb2ncLtZKHJ72SOSZMo9
         YNdhbYo1XY9veO3Zjvy8gaXSxHEU9QM3PtYyTx/avdRarrYLaASHNB/rGrCoXbf3x91T
         uwdEoKgGj+kUNrNsSc3pCcfky/CNOqrN94Ol3wDQraquIODmRUCzA4qmvrX+Uk9uYHSN
         E41ENjFwZUFqReIZYciKZPhElmicrfBbJ39hEYdnPWyFy9RZOBVtsvU5agtJOg3jz5cd
         3R0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781633808; x=1782238608;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fNH/J02lBrL7hdVnRQ4UVLWbhNp0HeLEy22DRQvVDN8=;
        b=qZ/SKqOM8/hvd6QWauVwvo+MMLwXej4cvLXI/fZVPjSU8Z7sb73Qbfzn6JiLB6JFdt
         5Kx3/FjtlIdVv3IgCIaAJXv1m2lO92Erq15MIvSUJz3OPs72dkt/Ctkk/0lTxQ7TSleC
         BOB4pnw+QN2RbLzRf1oHjQ4HVKFhHE+MVH9LUlrbIcQ5zGOjHM0HmyhcIu+A1e5c7voK
         oQYEpBl+aBZPVw3ldPFu5pyCo5ryWKKJaYn2GDughaY0flaJ8B3DEMUDyAkvlLmeKhBc
         seNFwEE4nyI0ZKSm5HzRVkhuH7WQ8rqSDs0UK1AZuDgir7kwk7Xrr3hDnhna2G4ov5dA
         n9dA==
X-Forwarded-Encrypted: i=1; AFNElJ8geu/M8iY8ZJZ6IaIiYvA/roIgjYnpaECW0w972gr5wHm1xVIQFAznk0HYeTTbamhCJ52nWLpN+8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsrSPTQJKVX6doBL5NQKk3WzC0raPGFNqZG+CalB3QGDSUo9Fw
	Lx2q02XLrUpOettlRrjX7eLwFR9NSsiIy0NY8cMFch6l2+ckaiAQSUAxndfcmmUsvh8=
X-Gm-Gg: Acq92OGCUZie1C2XPeosH6qYKyAC9N0spZGGqyv7RwV6XjtEMO2LiIY9N/ef/dEbH+A
	UedmdgL1gMtx6WE2GB+vUbspvxlbJzIOT06t4Oosle8q1y1742gUMJRWIaB803BEuqvyi/xNqlP
	aJZsJIxMkdTXHdWtqVp7V28phiSB000vLXgXqF2lh5m3zO0x7v44MPAq3jfhIAVwcm18Xv6ULsA
	tOECsiEaeM9+0xXHFFORUU49PYGs9XnAJuUHh0mmRccBc0MMWTE1kyUlC/K0k7cib6UtjoB4G3H
	7byHenhoBe06FT0xwXKgMwggbW4IkFzdDeLGrZZXtxoQoEBMw4TgkP1Wy2pyEBnm31m+1pM1+Bm
	eGnMiA0sCf1obsqxYBaBZG92otTMGbovV9txufJIvbyYgHurLv3wvwj2jsdW+yHcFzxU3AiixRE
	PH+YCnVxyeREIcxdmG48EeUIT+0W0F7M7tc9KvmDxPE3dTXQG37swjy4L9pVkAHsQm1dT2U8ok4
	w==
X-Received: by 2002:a05:6830:438c:b0:7d7:4fc7:21a with SMTP id 46e09a7af769-7e90b3bdab8mr714067a34.13.1781633808548;
        Tue, 16 Jun 2026 11:16:48 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:16b0:5133:47b1:a939? ([2600:8803:e7e4:500:16b0:5133:47b1:a939])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e79f6df8e1sm7215347a34.20.2026.06.16.11.16.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 11:16:47 -0700 (PDT)
Message-ID: <9b8d5cfc-e392-45aa-9adc-867c364dd36e@baylibre.com>
Date: Tue, 16 Jun 2026 13:16:46 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] iio: adc: new ti-ads112c14 driver
To: Kurt Borja <kuurtb@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Nguyen Minh Tien <zizuzacker@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260615-iio-adc-ti-ads122c14-v1-0-e6bdadf7cb2b@baylibre.com>
 <DJA1J8D91ESA.2XU7OCVKN7LXU@gmail.com>
 <d3270250-ae18-4c0f-a0fe-e0fdabfce046@baylibre.com>
 <DJANEYYA4QTA.1JBN2L78PNXDD@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <DJANEYYA4QTA.1JBN2L78PNXDD@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/16/26 12:26 PM, Kurt Borja wrote:
> On Tue Jun 16, 2026 at 10:21 AM -05, David Lechner wrote:
>> On 6/15/26 7:18 PM, Kurt Borja wrote:
>>> On Mon Jun 15, 2026 at 4:59 PM -05, David Lechner (TI) wrote:

...

>>>> All of these chips have in common that they are designed for use with
>>>> RTDs and thermocouples and so they look very similar to each other in
>>>> terms of wiring and feature set, even if the register maps are
>>>> different. They are in the gray area where we could either keep them
>>>> separate because they are just different enough, or we could do like
>>>> we've done before with ad_sigma_delta and have a bit of an abstraction
>>>> layer for the register differences and otherwise try to share as much
>>>> code as possible. Normally, I would lean towards keeping them separate,
>>>> but in this case, I'm considering trying to share code because the
>>>> devicetree bindings for the inputs is complex and is going to be mostly
>>>> the same across all of these chips.
>>>
>>> The channel configuration is indeed very similar for the three chips.
>>> All three have IDAC, BOC and VREF configurations.
>>
>> Hmm... I forgot to include the burnout current in the DT bindings. Following
>> the channel = "conditions for measurement" pattern that I have set out here
>> I guess that would mean that we would need to have the same inputs twice
>> when using the burnout. One "channel" would be the one used to do a "precision"
>> measurement and the other would be the one to do open/short circuit detection.
>>
>>
>>     i2c {
>>         #address-cells = <1>;
>>         #size-cells = <0>;
>>
>>         adc@40 {
>>             compatible = "ti,ads112c14";
>>             reg = <0x40>;
>>
>>             avdd-supply = <&avdd>;
>>             dvdd-supply = <&dvdd>;
>>
>>             refp-supply = <&avdd>;
>>
>>             #address-cells = <1>;
>>             #size-cells = <0>;
>>
>>             channel@0 {
>>                 reg = <0>;
>>                 diff-channels = <1>, <2>;
>>                 excitation-channels = <0>, <3>;
>>                 excitation-current-microamp = <500>;
>>                 current-chopping;
>>                 ti,vref-source = <ADS112C14_VREF_SOURCE_EXTERNAL>;
>>                 label = "rtd-precision";
>>             };
>>
>>             channel@1 {
>>                 reg = <0>;
>>                 diff-channels = <1>, <2>;
>>                 excitation-channels = <0>, <3>;
>>                 excitation-current-microamp = <500>;
>>                 burnout-current-nanoamp = <1000>;
>>                 ti,vref-source = <ADS112C14_VREF_SOURCE_EXTERNAL>;
>>                 label = "rtd-diagnostic";
>>             };
> 
> This would mean we wouldn't be able to use iio_chan_spec .channel and
> .channel2 to describe inputs because of duplicate sysfs attributes, no?
> 

Yes, that is a bit unfortunate. At least there the labels to tell them
apart. I guess we would just need to use consecutive channel and channel2
when dynamically allocating the channels to avoid conflict. 

>>>> This makes things more flexible, but does make the driver a bit more
>>>> complex. For example, knowing when the current output needs to be
>>>> enabled or disabled. For now, I have chosen a lazy-enable where they
>>>> are not turned on until the first measurement is taken that requires
>>>> them, but then they stay on until another measurement is taken that
>>>> doesn't require them. This can lead to some oddness with the diagnostic
>>>> channels that may be measuring something that indirectly requires the
>>>> current output (i.e. the external reference voltage when it is connected
>>>> to a resistor rather than a power supply). This means you need to take
>>>> a measurement that requires the current output to be enabled before the
>>>> diagnostic channels will give accurate readings.
>>>
>>> This is the same approach I took around the BOC, it feels kinda hacky
>>> but it makes sense. Just an idea I thought about just now: What if we
>>> have an additional write-only "_enable" sysfs attribute for these
>>> channels?
>>
>> I would not want to make a write-only attribute, we always want to be
>> able to read back what the current state is.
> 
> Yeah, I don't know why I said WO. Reading would be fine too.
> 
>>
>> Do you mean an _enable for just the BOC? I think I would do it like I
>> suggested above instead.
> 
> No, no just the BOC. The BOC, IDAC and rest of side effects. Thinking
> about it some more, it would be a bit redundant but clearer if proper
> documentation is provided.
> 
I would be interested to see what Jonathan has to say about this too.
Generally, his advice has been to avoid attributes that power things
on and off if we can help it.

