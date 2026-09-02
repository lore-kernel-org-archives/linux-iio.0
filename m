Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399454052DC
	for <linux-iio@vger.kernel.org>; Wed,  2 Sep 2026 08:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788338945; cv=none; b=DGDDmssw/SBc1KwGu1YJchQdvWgy2zoLqVZtYdmtrbimXxcz4raGQmJmOeHdv8ttZDQHUVYUPVbl1eAvFmbpueH4+tHmZspzn0eMJ6qdurYAUhC3gkJ7ri8VeosaC8wfQ+QAIq46C5/rlif0hBVYgMlqcC5oojm1TT6KcquJJBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788338945; c=relaxed/simple;
	bh=ss5xROj8OM3lYj+pqG6TTIF5SBt62U9/oUBoQLswgBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DJcLdouSrLZX8/r0GKTwvGCSoHCSS13quafEaWTGEGhS+YtYygeP1tAnnsGnDVadkhsLlVCz0si+xYRjaE5j3BbEer5E/bJZJHb15OlsA9B+UiArhZLj936sGHyC1zhXomuvpr+VvOoyFbroKF1JJu78uvo1pztbvGvUTj0C+CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FRGhUyVe; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FRGhUyVe"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6a0794669a6so1456418a12.2
        for <linux-iio@vger.kernel.org>; Wed, 02 Sep 2026 01:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788338942; x=1788943742; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f7aqc1YiIFFi2S/7+a4K7uWSUn18PjZkaszy4zjXDoY=;
        b=FRGhUyVeZHhqIQy7V+2OH9vwODwXTRs47UnHugrTgp+LSOzcThFqsRm2bSfBJMwhBk
         199eI9nSLNaLiHNvQEMwpmT0gpKbAzwHhN7wqzLBlykqSHwCMXCrF6cXhYR3fiC0tX72
         2J9XYkRWq68ZDFW4+MxdKrdDPS2FRzLnZuskT7IirKoyI8ysnZNo46D72xxdOyz5EDnD
         0H3JcRfYn/vmWl59ZTXEHfOeLzzb4ELjTwLPeyyKnk7w8uBlCJtOSvytm6rAy+1f6Xe7
         VxRrKYJrF4GcM2ZVCIp+gNMeEUCF4h7Wpu5MCZhU6mYcXgR5UdXplfMT1J+mZOP9DuVa
         AjSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788338942; x=1788943742;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f7aqc1YiIFFi2S/7+a4K7uWSUn18PjZkaszy4zjXDoY=;
        b=XYMVPEtrtbEHhvltu0/MIdmmfaohuvU5tMX1UpRY3WDNnhpPt20QRrDEx+amK5jhxT
         jXjUZJfBCwTqpSGNgG7Mb7y/3F4Tlc54MpwSWwhXT6Z+pyALRDiEe5Cjc0FgE/IlFGgS
         yHVL99OPEUdpdHf/EKLE0IPTjxuRnyLWTQjPgvMG1DYeniYYBBc0GXQ5T3e+khNJSLHD
         wm0zo5n/Ao+ih1JgdlbUuv2nQAj7ESjBTXHexMTZuJIK50Vbp5hcbeFzSpV6K8Pap3uD
         J/NGTs9tWnxDdJlEKpG+q41m7XjtaXpUoBcxs4zkn+NDv0jmpXtTPLdZOh8a3PJBoJu+
         xxHw==
X-Forwarded-Encrypted: i=1; AKwUvBxEGRR4fk6pfi0Fh6J8/I7zpZEZviKWhAeCkb3yXqqmDH+T/E0rGL3U0PmAgNSNn7xpMLqmcPZVfMk=@vger.kernel.org
X-Gm-Message-State: AFuF++kVNUhShbI1Evj9kV2SVRMJ4r7VVJpQ+zTu46YRtacQchJJTGwY
	/Tsjd78d0CWqSiNypDHwK2QxRmx87AU73X4nAq//fIoVecOypk3INa1z
X-Gm-Gg: AYBFou1e2vqxHl41AYfkMCh5PDzsc3eLkG0XZnp8EZK7FDSE+We6THkY24ou59AMrPz
	EliK35h5V+0N7J1+r5RRPqMagynAbe2qZYnLQFC9+VyII8wVxT0+dLawj/gy2ztz4g/70G8/dKK
	a/ouORWN/UDuVB8/X+CuU/6eUDxjIFKWsLPpASf/lXkmFw1XeqWksoffkW1t73nsDHG1kMZXfYB
	+6/51I12r3Wd+Zrir3v2etWNG7aCnyUXQJwBKB228SUAzLJspzgGiDGLCI1P7UePsTbYt2M4+MA
	6jW0fAp40VBei0g2iKWClHoJlMK3/QmpDmxTFvjf9Jx0ztmhMl4pqA8a++bDzTb3uv4c/NKXvtF
	AeaK9cl7VE1kPEv+0aAqwRRWw9f17kglV/dXUY1qzyu2W+ZQTtwOELIxB/zvLFe2QrKSPbf3pYE
	cLR03GWvV8Lfsv2VV2FVRMKT42OF7bZJAnSQPZfhrLkhw//VvNO0zVUrOhFdYjw/nVqyS0wrn4i
	KkIKFX5b/23mbFROlhedIfl3w==
X-Received: by 2002:a05:6402:21d4:b0:6a3:f63a:4997 with SMTP id 4fb4d7f45d1cf-6a682567131mr2048216a12.3.1788338942157;
        Wed, 02 Sep 2026 01:49:02 -0700 (PDT)
Received: from [172.24.138.145] ([137.71.226.102])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a67f895f29sm764636a12.2.2026.09.02.01.48.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 01:49:01 -0700 (PDT)
Message-ID: <0c5a657d-e134-49a7-b2cd-82f293685cb7@gmail.com>
Date: Wed, 2 Sep 2026 10:48:58 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 3/3] iio: dac: Add AD5529R DAC driver support
To: Jonathan Cameron <jic23@kernel.org>,
 Janani Sunil <janani.sunil@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Mark Brown <broonie@kernel.org>,
 Marius Cristea <marius.cristea@microchip.com>,
 Marcus Folkesson <marcus.folkesson@gmail.com>,
 Kent Gustavsson <kent@minoris.se>, Conor Dooley
 <conor.dooley@microchip.com>, Daire McNamara <daire.mcnamara@microchip.com>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-spi@vger.kernel.org, Kent Gustavsson <nedo80@gmail.com>,
 linux-riscv@lists.infradead.org
References: <20260827-ad5529r-driver-v10-0-38f2be07b824@analog.com>
 <20260827-ad5529r-driver-v10-3-38f2be07b824@analog.com>
 <178813261957.2788519.4929586195765891569.b4-review@b4>
Content-Language: en-US
From: Janani Sunil <jan.sun97@gmail.com>
In-Reply-To: <178813261957.2788519.4929586195765891569.b4-review@b4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/31/26 01:30, Jonathan Cameron wrote:
>>   
>> diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
>> index 992f8930f95c..8dc644522b1e 100644
>> --- a/drivers/iio/dac/Makefile
>> +++ b/drivers/iio/dac/Makefile
>> @@ -18,6 +18,7 @@ obj-$(CONFIG_AD5446) += ad5446.o
>>   obj-$(CONFIG_AD5446_SPI) += ad5446-spi.o
>>   obj-$(CONFIG_AD5446_I2C) += ad5446-i2c.o
>>   obj-$(CONFIG_AD5449) += ad5449.o
>> +obj-$(CONFIG_AD5529R) += ad5529r.o
>>   obj-$(CONFIG_AD5592R_BASE) += ad5592r-base.o
>>   obj-$(CONFIG_AD5592R) += ad5592r.o
>>   obj-$(CONFIG_AD5593R) += ad5593r.o
>> diff --git a/drivers/iio/dac/ad5529r.c b/drivers/iio/dac/ad5529r.c
>> new file mode 100644
>> index 000000000000..52601cbf28d5
>> --- /dev/null
>> +++ b/drivers/iio/dac/ad5529r.c
>> @@ -0,0 +1,536 @@
> Why do we need those outer () ?
>
> ...

The outer parenthesis are required by checkpatch for macros with complex values. The same pattern is also used by AD3552R_CH_DAC() in drivers/iio/dac/ad3552r.c

-Jan

