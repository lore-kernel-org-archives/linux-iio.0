Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE96C2DF15C
	for <linux-iio@vger.kernel.org>; Tue, 23 Jun 2026 18:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782240631; cv=none; b=THEqpBlKf0mqgBUPjg14QmfuloK+7AbfE77X/KXTpbr+RJ+Y4I+xf9xXFcjHeIQpSwv42s84t4QlXLIVbUZ2WSFCGVPiznKMOina4hmhGvmZuUvdHX2wTMMVZYv799udGWzRgUR5gAlGhpPcqXJVz1naeuJub9zW0Lli5qNEr34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782240631; c=relaxed/simple;
	bh=1rFeGZLMRF4uhofmy4rmZ53fsMAcxqbCvTCESZgKhBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F/F4g5k98dSbMmD8RhtW6ZpBeGq+fZuVrFTME4t/cvv9DsdUAX0WLA9w84V13ralFqCITRM5Fe8HXl7AxZL3thgMYeU6ASwVkbz4Gou9ewPqm12DUx6y6NQfjV6rowHk7v6usomKFuDu2K5Q0rMZxlIavutaZC+voKIrsqFI+As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Ja9wLjns; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Ja9wLjns"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6a0a38a013eso195142eaf.0
        for <linux-iio@vger.kernel.org>; Tue, 23 Jun 2026 11:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782240628; x=1782845428; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dGGwDozo6LCKJ+eeIvqhcdcUX54ken2/fK76AsNNZTI=;
        b=Ja9wLjnsJggcaFcgxVsUnek2ro2trhAM36yZDxMxEjhvhuJ7HRCOHo4xQwCsL9X8Wt
         WnpMpO7ZsNdVBeuRlSO6ZA8T0QK8rxhR+YtCAQkV0G3E853iM+vmFdNE3vAUZhVeSHZ3
         5HfNgzIKCdrLgIarG/LcqXdhGSUzRGLofJ6pvFQXNe+xOSpOUqC6nctaI3/Lj5VyevOA
         wV197ThCAxcbeUiciYCwFUD/VcP5Bs54JZmmrvStlAo4zr7Tf6Xxv2rtytBJow2ZdIRy
         KNXdEzaRrCh4R1KwKvHmhycLKTRuS4FvocOtyskpn9AnImwvrgs4ShKRDXwogK+yaWr0
         Lv6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782240628; x=1782845428;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dGGwDozo6LCKJ+eeIvqhcdcUX54ken2/fK76AsNNZTI=;
        b=XRNznrgGnW8nA77Gs52yfYeuUpiXjyRTSYob3j1ntUy7xD/4tdgbP+TmKnVtJcqeEh
         rbYhCidOtddRefeZEBQf7PI8ICIrycBPUjRVG8XTTntA/dHa/ehGviinxsK0W97lnYCI
         uF6tVYbNaWT4Zor8Y1f2ea4JlAbygoqyNOlVzC5xzm1IipCF4tojV0LjKeNB/aPiE5xh
         DlKq0SY3Z7BRcIz+HFSbIJIttsTcCopxKRU3ZEM/v+S9eynOFhBkgNM5tB5VbzXiqvCP
         3ljGOQjmDaiaIlEPA0hfZMpmecgi/lghujBd68UeIGrlHNF9nihj7Fd28RKelX4H+5tp
         C62w==
X-Forwarded-Encrypted: i=1; AFNElJ9MzxfkaMqXmRNZ07TBQ9JrurP7+dkytFwgP1jFrw8QcqrAlpGwLOrWXjzhhzZxMzENbn13qu7K7Hs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdHz81LHBCc68uge4XwFS7pchwvWD10HVSOznwg4eJJ1gFaDKK
	KMrbhR9rrxo75cmbvlZyplLdan0miSFb+MeR2WCfOoRk0xzmcKg/vS7vUmmyfzht34Y=
X-Gm-Gg: AfdE7clq4HAdndrSxkviDeeNPFlq+QtgaOsU3H8uOp5Ix3Qyeoy3Ml3l9bIktuqG+VF
	5wMSo8YvcIOChno1FLGHTy/HE4SYAQBSsXS9ZjM3nGrjuPU9WWgHEuBCmtwDDEdRGhnBbgh7M+t
	wYxmmv7e7Uvl+RyJ3Anet8MhEcdxNl3OMWzVpy62xDMIkBixccRoQaX7ElxVEfX8ihdBbCPnNnT
	W/gT5/6XXsH6OO47vSNIe+y6z/eh96sYz3nMWS6zKfIl3YxTpaZvzR2OuKq6O2vOzPsUyPrWNah
	EDo6FhJKzs0ZdRRSzS+0wz0O37muwXk1FOu19lL4hVeKc1BjxSrAUqtFGBM7A8+/zKG6Chbm45/
	bN3vJ6Z3mpqIyEGrzTd/sucszeMUpXuS+UwpxUMOm58h4Qn3yoraS/rvUGtMHNJ5wMLQsW7Jvvn
	QCEt48lIzTFczPQUmW00O2A6Gsn1NdFjQP9Q7dBeNhcY3yovN7PScHKEN62LJvYMY=
X-Received: by 2002:a05:6820:c447:20b0:6a1:1978:59f9 with SMTP id 006d021491bc7-6a119785bffmr1010376eaf.3.1782240628415;
        Tue, 23 Jun 2026 11:50:28 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:6526:8577:6be9:cb7b? ([2600:8803:e7e4:500:6526:8577:6be9:cb7b])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a0e9fae72csm7734482eaf.7.2026.06.23.11.50.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 11:50:28 -0700 (PDT)
Message-ID: <9176e97e-c92c-4d9a-a0b3-da2e7983d9e1@baylibre.com>
Date: Tue, 23 Jun 2026 13:50:27 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Add driver for DAC8163:
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
 Lukas Metz <lukas.metz@gmx.net>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
References: <20260623-dac8163-work-v1-0-5b508158faa0@gmx.net>
 <ajrR1jlkggGq_rrj@ashevche-desk.local>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <ajrR1jlkggGq_rrj@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/23/26 1:35 PM, Andy Shevchenko wrote:
> On Tue, Jun 23, 2026 at 06:07:26PM +0200, Lukas Metz wrote:
>> This series adds an IIO driver for the Texas Instruments DAC7562, DAC7563,
>> DAC8162, DAC8163, DAC8562, and DAC8563 dual-channel voltage-output DACs.
>>
>> These devices are pin-compatible 12-, 14-, and 16-bit variants sharing the
>> same 24-bit SPI command interface. Each device provides two independently
>> addressable output channels and includes a 2.5 V, 4 ppm/°C internal
>> reference that can be enabled via device tree, or an external reference
>> supplied through a regulator. The register and command structure differs
>> from already existing drivers which makes adding a new driver a
>> reasonable choice in my opinion.
>>
>> The driver supports:
>>  - All six device variants via a shared chip info table
>>  - DAC updates in synchronous mode
>>  - Configurable internal or external voltage reference
>>  - Optional LDAC GPIO which has to be asserted permanently when using
>>    synchronous updates.
>>  - IIO_CHAN_INFO_RAW and IIO_CHAN_INFO_SCALE attributes per channel
>>
>> Datasheet (DAC8163):
>>   https://www.ti.com/lit/gpn/dac8163
> 
> Why do we need a brand new driver? Do we have an existing one that may be
> expanded to support this HW? (Note, not all existing drivers are under IIO
> folder, some of them might be found in hwmon, input, or drivers/misc.)

I thought the statement above is clear that there are not any compatible
drivers already. And I would not expect a DAC to have a driver in hwmon
or input since it is an output device.

> 
>> The driver was tested with a DAC8163 on a custom STM32MP157F board with
>> external reference enabled.
> 

