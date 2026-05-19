Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B373ACA72
	for <linux-iio@vger.kernel.org>; Tue, 19 May 2026 06:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779173974; cv=none; b=gpHy7BsW8p9rPGZwGAdfVlVOGa1mU97ap//O41aPoEP92fc3DX4WxPxB1T/7mqt+j3+OK9GZ620X8Qn+qIdmQm9H7av+PvUq/UHo96+NqGbwORJXr1Kpa2PdxlvJYj09PluQri4MgAcUksGTJAVJxRTwz89ISWKk2BE1ICBrZ98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779173974; c=relaxed/simple;
	bh=0BUhj6j3hrklauwfy+i/h/s8xlX/MYhRh465WVn2hLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NvAnog7TyyuzkS1T6iBAVEWe52tRsHg/ODdkF3+gxtsOiaJ8HSbsny55Ejt0xnYGYcXXfNGzNBzXJUkNzjezXL758rFaa3MN00EZj0Gd0l8X586IDcJgVn54MmigIhwiwTSlpxAZgO1+AjrT3cLaKB8eK5ldinnEyRLEGqSS+5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MAk4FSBV; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAk4FSBV"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48e82c23840so24330265e9.3
        for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 23:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779173972; x=1779778772; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gF5Z1qKa3/ePayEWJpcu7Cbt4cEhhoyI3/LeiuP7Ies=;
        b=MAk4FSBVZdYEtSXDCJVHAy6HwIuYO1y7zU9AaEJ23cjjxSOJioRz1BBlFKSs2ns/gB
         v3iWIZwcegLaqF4IeppnCt7DzcSLc2MresRoCAzV0pKasLnHkys0MihfsEVWVBKOT5ZK
         +ug0dqRuAmaPBtg8GhJmR7YleUwAvwewy65+l72mU+9/MBjwHk7lR46KafUCsBZTehSm
         v0SRbEYT5ECZDjIsmqXGw/LiRFHqMQ0aHfFcOIGicUoR2hwFxMuMrmbv+DvjdWNriDOy
         jQ5mICK1BT3VOGcwqFzJcou47u26sST8mL9k7gSFcry6jMTdcEmiT7mDitDH9+JYDNNB
         YvNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779173972; x=1779778772;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gF5Z1qKa3/ePayEWJpcu7Cbt4cEhhoyI3/LeiuP7Ies=;
        b=oakLTMZr6+Zbn5+P5dQzICFnMFEH0mEhRgy683LGeduSKZEKKWo4fDkCuk1U+DeQQ4
         ZzujhPMz+0lsFXn6eSc4tc2DgavlBFN/UmT1Ze0B4Y32M5QHiAYS+P2+BJ2ItILzeBSm
         GBT00798EVogisd63VpauaKv20guiiHf6B0CLmZnB3exY36CspwRoAJpS8/evEnjAY4n
         4ndJBXJlu9a+wyHBI++3wM5YXCPfI7eTxBgAAcAlkV2fgWaoT1Tl51uv6IemwWv8XB9C
         oXtt1R9ejeKrToW6NYSueRW0R2WtSsBzJa8TT9QBQaTSpYvS4f+ZmgdlJmB0LB7Q3zTp
         WgyA==
X-Forwarded-Encrypted: i=1; AFNElJ+aDajbkGOJ70VUxpVrQG6qn2wdlxG2JsXUzKj2pU9QD6HgwjNPKKWJQOxfvjPSpj5/FgJu5qXcuJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRxEuVmO0JwbC9Bh3zE5bnZVcE/+49nJZxdj0X/dG5EoDLanhy
	wtbJ+GSpyNMKGPjvW/NboR7egM/bTppXai29NUXJdFVFKPjvbkwaYM18
X-Gm-Gg: Acq92OHCCYFR3Iyxsz8Uot2e7xqHdhH52yyXWVmjBvQrEqRR6y9qny5Kl7xFPHUsocl
	Q3q4brhmFh3JVQJd7EhsfWQfVIzEdsW6Unf2pdIY0WkOdC9+zhRP6pxeYctIHLEiyYR1qbb5f02
	mIzFyadTM0BKqpGMlS7d8uKBSL7tbAlH5Gbp8BANljqi+lDk5RqdTshx2YfkvaT2D1Ii8juMptl
	E+tMVQh2JLrmgLT2yj/R9D1JykdkJ07/kemZf0NE+Jpl1uOpz4w+bQ5fN2TxfomJXF8IhyFhG3m
	dOcWg1bdd1gNOTSmjrDCF6AQzQYJCL3d+0YflwuBJk5A2Fp/fk79SSJKr1y33utVyUL7GvvnlbU
	5Quq+xkb+hmi3vya+TIpijCGF4SejsWwjtWUXyw6Mp84kOrNlaZnFt+AaUrG+5LGSN7v4LlUWc5
	Cx7XlnZFM0VYo/IWwyIL983Vfw9FziKWyrwtfsVOUFFwRQyCJeepo+eYGiX6xcrlCZbXIj
X-Received: by 2002:a05:600c:8189:b0:488:ac01:72b6 with SMTP id 5b1f17b1804b1-48fe6323addmr275170575e9.21.1779173971682;
        Mon, 18 May 2026 23:59:31 -0700 (PDT)
Received: from ?IPV6:2a02:3033:6c2:b9c5:ec15:f5ad:b85f:a3b8? ([2a02:3033:6c2:b9c5:ec15:f5ad:b85f:a3b8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4900c16c744sm126227455e9.3.2026.05.18.23.59.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 23:59:31 -0700 (PDT)
Message-ID: <3932472e-91aa-400b-a1a4-03f520706890@gmail.com>
Date: Tue, 19 May 2026 08:59:19 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: iio: dac: Add AD5529R
To: Jonathan Cameron <jic23@kernel.org>,
 Janani Sunil <janani.sunil@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 rodrigo.alencar@analog.com
References: <20260508-ad5529r-driver-v2-0-e315441685d7@analog.com>
 <20260508-ad5529r-driver-v2-1-e315441685d7@analog.com>
 <20260508134843.7646c4f5@jic23-huawei> <20260508140814.67800e4a@jic23-huawei>
Content-Language: en-US
From: Janani Sunil <jan.sun97@gmail.com>
In-Reply-To: <20260508140814.67800e4a@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 5/8/26 15:08, Jonathan Cameron wrote:
> On Fri, 8 May 2026 13:48:43 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
>
>> On Fri, 8 May 2026 13:55:47 +0200
>> Janani Sunil <janani.sunil@analog.com> wrote:
>>
>>> Devicetree bindings for AD5529R 16 channel 12/16 bit high voltage,
>>> buffered voltage output digital-to-analog converter (DAC) with an
>>> integrated precision reference.
>>>
>>> Signed-off-by: Janani Sunil <janani.sunil@analog.com>
>>> ---
>>>   .../devicetree/bindings/iio/dac/adi,ad5529r.yaml   | 96 ++++++++++++++++++++++
>>>   MAINTAINERS                                        |  7 ++
>>>   2 files changed, 103 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5529r.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5529r.yaml
>>> new file mode 100644
>>> index 000000000000..f531b4865b01
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5529r.yaml
>>> @@ -0,0 +1,96 @@
>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/iio/dac/adi,ad5529r.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Analog Devices AD5529R 16-Channel 12/16-bit High Voltage DAC
>> How is one device bother 12 and 16-bit? That sometimes happens for
>> ADCs where it is really reflecting oversampling or for device with hardware
>> FIFOs where storage space is saved by using lower bit rate. I'm not sure either
>> applies here.
> Having read the driver I now understand. This is supporting two parts and
> doing device ID based detection.  In an unusual step for Analog they have
> the same base part number with a post fix.  Whilst this approach works today
> it fundamentally breaks fallback dt-compatibles being used in future (the
> driver fails for any non match of WHOAMI value as it needs them to look
> up device specific data)  As such I think you need to have separate
> compatibles for the 12 and 16 bit versions.

AD5529R supports two variants- AD5529R-12 bit and AD5529R-16 bit. They share the same register interface and pin configuration
but differ in DAC resolution. I will add separate compatibles for this case.

Best Regards,
Janani Sunil

