Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E2C3BBFC1
	for <linux-iio@vger.kernel.org>; Wed, 24 Jun 2026 14:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782310488; cv=none; b=NIpGE8eJtkzrExdrW6LbUgWRCbZvvjFPvmKtv1ZYQd+kGTaf5Ioyl2Qrmhh3h9nCoLeQr/KIDJXLCAHDPSr8xpz7q6uj2Vq6A0+r59/F41zPrBEX8qSY33VKjfNn8WHUS4M/kknNnQhb+sqkNv7097U38adnoy8UygSSWv4RGdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782310488; c=relaxed/simple;
	bh=VElC9oMArW8E5DVw0C3OZ8uCAD3W1Xad/JX5R0ZfH4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YDErJmhjQY+Z40lodXGCSS1n2rcaA4R++BFyQH8gEV4PyNGc2RN/MYkpCrY+k2PojgnRC2+57MKApUcR069PArLCqfhLaCOsBnQrT2WpUj8bMWPuBQpRI/+7MBcygfQHvMQ22mlZ7hifF5OUhjIDSadZmsPW0V82jGxrb5kHoOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Astq86Lv; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Astq86Lv"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-59c2a81ca92so697026e0c.0
        for <linux-iio@vger.kernel.org>; Wed, 24 Jun 2026 07:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782310486; x=1782915286; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EKXkM/V9V+5iFe2v+ihivIbTjpQHj54cW+T1VhjBSuY=;
        b=Astq86LvePsh3PutKYaFFizihoqbeHKR/2P4MhRLIDcTqIZgPpYkQeo32E08fGgmsN
         oBR2hZvC3k3kwQJjIBdFcOcx6KybePc+fDET1E8XAhUcoM/XrAxgkYPj5Ef/RGSKzucW
         Ojg6QaMSK2QYO3FqEP4gO2H3Vp2isrXEDS+httJNBesTPX2EJ7YPmxwWp/WDe400s7t8
         3hynz5BjwJiQACYezdZ+esMl2GifDQA8v6hmgXlC3KGrnyvHPXQN1R0KmHefvBcow6Yp
         3AAr1RVD09NgjBvpjnxmIhzoUO05x08xwCnL5w2b16d9C/eDLXcBCA3rxgXzlQV7EBIj
         pi/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782310486; x=1782915286;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EKXkM/V9V+5iFe2v+ihivIbTjpQHj54cW+T1VhjBSuY=;
        b=prhChMp3+9pGxtKULIc0IzAluLEzirmyyjFazOPc/Xc5Gsvw5FmNhk6MkDUzFSG6/g
         buGavSbMeGYaWa3UkwmzdYzsphtfH71u8dsctsWMqJ/lF5/IKGE/Pm49Bh6dxNateYcu
         U+fdgGfCA6hjuYH0b7XgJQW27633/hb1wxgMOd8BPMqPbjKIssCxvkK9mpZbCG0Dz74E
         CiXErQwfmCT0Ug50yRW0grKvaJH9kIpXkL3Y/Pzmx4BFp40voOiSo9SDvEkvDBhFXHRs
         Aj5C4HE1u94LhVXV2IJOh2Q3MQCAwXJeOBlzDiJMToBu9VPdj1Np4XQR7SDF78XA0o8q
         fxdw==
X-Forwarded-Encrypted: i=1; AHgh+RpKLWCg6Xkt+h/Qu5u5HhArLQuwUwuepT5jismWKwidKEsSjf8jI33pmMhdEgLE7UnTyUMt63+k0gA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdAQQJG0Qb+J3OXNjxTFrFdAvq9IeJYnd5PkDwONsqAskXmExm
	56EF9eslXb1ln2jRa8zmggzJZ9tCAFbZQJTPz+Nhn5cl3oeJw0rWhBOEf/Kr79GG+ts=
X-Gm-Gg: AfdE7cniHrQ3/X6v3kwJXRAvTV1Q2Gs7aOwZpHGz2fOGi3uTaOf1j1t3i37Cp9lkAoH
	Tiup0akZJlHCuH+ypWMJX1wj3OaYLGDst9Nj1G8WE/ylzjm+6R9maOum32JkDYryUgPm2UmiB20
	+Pkdc8RLfnG0sej1wGBxnaYIIvnQszYsMgWZCO04SijI0jEuQrIwFrgLU9oF6xogESCnwSt6C0E
	FGxar7qsAMZLVgUoWTqXqzGOh7iUsPZaV7+i4WDFvWTTWmFvBjr21GSWNvLAtnKb3tb9jgO52Y/
	cgxmJB/Ro/B61UbP2jQJsPkaEnf60TodW1E6KvsRfEo3b20QP6qDdsDXHTxw+8j5+30bUCCYs1/
	XeMEdpSuWGYG5dHAkiJH3Z4i9a80Yn2MP6jlvgpUKkVbGRJElZFUN8VUN6CxAfUCo0PmvgDKqiS
	zU9FNYvd3aPHGhCxSdK7x4ezm1twuwWAEeeUDFxUfPsgywmYdEhGAnY6orp9qreUU=
X-Received: by 2002:a05:6122:6c02:b0:5bc:42be:f7c4 with SMTP id 71dfb90a1353d-5bc42bf0a82mr1061612e0c.3.1782310485652;
        Wed, 24 Jun 2026 07:14:45 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:68dc:b788:b3ac:e34e? ([2600:8803:e7e4:500:68dc:b788:b3ac:e34e])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bbfb878c91sm10694600e0c.6.2026.06.24.07.14.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 07:14:44 -0700 (PDT)
Message-ID: <f57e9c71-189e-4316-aec4-5779d6211db7@baylibre.com>
Date: Wed, 24 Jun 2026 09:14:43 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dt-bindings: iio: dac: Add DAC8163
To: Lukas Metz <lukas.metz@gmx.net>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
References: <20260623-dac8163-work-v1-0-5b508158faa0@gmx.net>
 <20260623-dac8163-work-v1-2-5b508158faa0@gmx.net>
 <5a19c272-e8fc-4fa9-b137-842b6ed6649b@baylibre.com>
 <ajt0vibLhh6Mmhoc@berta-MS-7693>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <ajt0vibLhh6Mmhoc@berta-MS-7693>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/24/26 1:25 AM, Lukas Metz wrote:
> Thanks a lot for the review. This is my first time submitting a
> patch so im grateful for the detailed comments and suggestions.
> 
> On Tue, Jun 23, 2026 at 02:17:04PM -0500, David Lechner wrote:
>> It is more logical to put the dt-bindings patch first in the series
>> before the driver that makes use of it.
> 
> I will reorder the commits in v2.

For future reference, you don't need to respond to comments that you
agree with (save us time reading).

> 
>> There are a couple of more SPI properties needed since this is not a "normal"
>> SPI device. We can only write and not read because there is no D_OUT pin. So
>>
>> spi-rx-bus-width:
>>   items:
>>     - const: 0
>>
>> will describe this. 
> 
> I will the add the suggested changes to v2. Are there any other poperties 
> i have missed? Same for the other comments regarding vendor-prefix, 
> spi-max-frequency, avdd-supply and vref supply name.
> 
>> We also want the binding to be complete even if the driver doesn't all of it, so
>> `clear-gpios` and `sync-gpios` probably make sense too.
> 
> SYNC pin is the chip select pin of the device as described below. In
> that case i dont need to add it here right?

Ah, OK. It is probably worth mentioning that in the top-level description
here in the bindings.

> 
>> Usually, we don't bother with a property like this since it is redundant.
>> If an external reference supply is given, then it gets used, otherwise
>> the internal reference is used.
> 
> That sounds logical. I will remove the property completly.
> 
>> These chips don't appear to have a chip select pin, so this comment
>> doesn't make sense to me. More logical would be to just use dac@0
>> and reg = <0>; since it should just be ignored.
> 
> The SYNC pin on the device acts like a chip select pin.
> According to the datasheet: when the pin goes low it enables the input shift
> register. At least that was my understanding. On my board i have tested the 
> driver with the chip select signal connected to the SYNC pin. The
> example comes straight from my own device tree where i have two devices
> on the bus. Thats why i used reg<1> here but i can change it to 0 and
> remove the comment.>  
>> The pin is marked active low in the datasheet, so I would expect
>> this to be GPIO_ACTIVE_LOW.
> 
> I wasnt sure about that. The pin needs to be held low continuously. I
> thought when the pin is marked active low and i initialize the pin with
> GPIOD_OUT_LOW the result will be that the pin is held high. To match the
> datasheet description seems logical though.
> 

The GPIOD_OUT_LOW and GPIOD_OUT_HIGH names in the kernel are not ideal.
Think of them as "deasserted" and "asserted". If the devicetree has
GPIO_ACTIVE_LOW, then GPIOD_OUT_HIGH will "assert" the pin by pulling
the voltage low (because it is active low).

