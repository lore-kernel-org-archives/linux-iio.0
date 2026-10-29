Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793272828;
	b=K7Y8BHEb1wc4ooC5Vrl8rurNXqz1AVqGafAM9Ws31ArMt9pJ5IMDeCdPv8paqgEN4UHV
	 dXW5mm4P64GMGAJa1eGPNz6LJzRIsPzdtzcBkkkXtRn888wlVq7YmJcfsTiQDB2BiLG0W
	 x2oQXO8fHHg1XaDWZe53FlI0JZjXjRouH/0poL9Fv6VXoeEHZRAjmkm3UPnSLdzloUgg2
	 Ao6IaDb98pPW+uwLNtAcAzlGoPrVkOpWA6OvV8WmVowFMOJHwbbf4AChbjcLLMbfiriCz
	 OCp4d+zle97pyUR6UxNWla1MES4CQSE7mtb0amUvLBjZKNu4JnuIKDvohuj5Y3p3i2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793272828;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=HWr1SxRoSXUpgXKKNJoVMyu+qAI3Q0fzstEAk/1G7Uk=;
	b=lRwM2DUjLBgFRUAzQKEuQP4gm7UwZh39/dLU97BaHeOkZ4Kc3TFq0wgQxD/1jHxf78OI
	 FHSa65oHQd51iOn6SI4/HiwlMRQQfE3V6hA5jq0kay599mb1m/nWCGDl4Bu4ObSNVCxT9
	 XLrwA+2QXoH2sdJkLtY7v7PwPoCWstoUiMy7aYuJSj89QAH16cWW8nfAbNL1J5GaZYJuh
	 jEadrcf74EaPR23AfsrekX15K3NSzxQoIl5s5fuMSoh38hDhZiZ9avXTmpDLC6VcXbHkY
	 V/hm8Zh5kvqQnyxs0BtzO6fxImChOQSbuhmrXg22R3dirYYwVKag3T58AWitUIvhQww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Pf0+jnlU;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BD4606A31C
	for <linux-iio@vger.kernel.org>; Thu, 29 Oct 2026 11:20:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4BD4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Pf0+jnlU
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a9a8d6cea8so8283235e9.1
        for <linux-iio@vger.kernel.org>; Thu, 29 Oct 2026 04:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793272826; x=1793877626; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HWr1SxRoSXUpgXKKNJoVMyu+qAI3Q0fzstEAk/1G7Uk=;
        b=Pf0+jnlUONlj2VAi35lQK+uRzr7kbgX9ldnEV/NSIsg+SKnM5FqDBuIuB6exfW+74k
         vgsUqhpIQNrGDXg8WrHq6j48D750X8T2xOSL/XjZTr4/vK4BHI9DRrf8qHZSNOzPEQg0
         UNqDM0fIHvJxfMzKPG9ol9ZyUr4FvqNkLA+nURZmEju0xBMkz2bKcMRIdzc10y3Owg8q
         20MZ55dtmpbIsO6kqIHqc9jcQ1zP4mqKfI1cI+fzQ/L0yiMD31GPXO/ZXuAoDvt3f9kO
         d0aPAJchToVRAO2hN61RNxAbJg6GO8sMn/wHHpQtstkNaG1RiAvNcRBUeBzMdH1dOweD
         T/6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793272826; x=1793877626;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HWr1SxRoSXUpgXKKNJoVMyu+qAI3Q0fzstEAk/1G7Uk=;
        b=zlgIBqiQd5bl/K7obQavJt0mj6ihxBE1y/Rovp6Au/s0yissT63T3x7Ns5ir0XdUXP
         Vg4BoRC8FVjw27gZBeAqfTYk5El1jv6+Ra5Qw0ecMjATwm8bwxQz537cIqkylVJZcP2H
         +nwJNJlXu3hnYhEa7fvRKG/bbcghuue+A/t/JKn5dgfgECX8zZndct6vhQMwgUPEycZB
         3s6SXaxSn1i1E6seiI3LoJNp8ka96HBSvRXZWawja1YmDIgSpGMuwmj0Fy1DhX6WAjmc
         D7oSghO6RTXbOPDFDB1ZjrnT9cDEkAr1tpUWJiud2y2NrJsUx3qNnSMCcDg7kWPpeMFf
         W1qA==
X-Forwarded-Encrypted: i=1; AKwUvBy/qQ00wIbWLI1cP9+eJVOAFuE1X4rIPKYrbuSoDcTwc18/ewJpNHLfdOzrbSNAvtmEgbM+B9MHotc=@vger.kernel.org
X-Gm-Message-State: AFq9FYIBF9a25s1KvqfFIxttnqN2oiB1baJswFMu6b588+Ruy1mQqO0a
	p3MfKNTyGkAAj9BrjeyZz4l7fxX7o+sPcQ2g+54DRloqJQUXZTHdpuux
X-Gm-Gg: AYBFou12vdTnLsBHjZ7d3wyuuTOT0EXuECqOLCUgly6rlIrw7KBtB6cI8j3ga3CJT+e
	urjMsHbY9ilf7wgMddxcqzfu6hCeRK45loxkvhPNo7bQL5dSyJKk3W/sBKzX34GAmesxOS6OVQz
	AC0AvDeVq/x1xJZFYHiHo3+kQXxydzIEfIyoxhqFMigNm9SnWcsFsragUGQYdiBGGj/ASzB+l9i
	nY08B9xm7XqZ1jfMCqsxzqx/2K8z3p6idItklLkhZHMY4wHNAEAPW/v7WGEo8dcX9XAvF/4U1D4
	TGqaQgTs/BzEpQvBWT1/soKuUII7WN1yBYmDwL43j5TX78D9a//CWsoM1pECqUMRJwApjbp5jUi
	8+nDw1CjYHIKVlWFBGx6PEfz6qYqFJfl3YJLKtJAS8jgs9Qon/e+VN4iacrCWxIfj8NPwRbOxJa
	z3x4Ht27PmnLxkV1YnWsux5vf4dSxT8SUfW6/HPhBEUwjFMjgPbc4557dP4cRxndwGGEfz9zB4h
	RC2j5s8r65hKLx7DlvB48xfJmOvSo+H0Y7lmQ1PVN3wkf9ayAS3fdNQsmdzgwlf9Wlb4X6nEuxp
	VgPLHUpXFgJzBvE4W75irffHOrrEI1QbIHTdIRMDL9Foda0=
X-Received: by 2002:a05:600c:3144:b0:4a0:20b4:ba93 with SMTP id 5b1f17b1804b1-4aa8823df43mr54740705e9.16.1793272826044;
        Thu, 29 Oct 2026 04:20:26 -0700 (PDT)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ab61d8b9f4sm15790305e9.12.2026.10.29.04.20.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 04:20:25 -0700 (PDT)
Message-ID: <533bca43-8de5-4295-b226-5ea3742871de@gmail.com>
Date: Thu, 29 Oct 2026 12:20:24 +0100
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] iio: light: add AS7343 multi-spectral sensor
 driver
To: Chang Yu <marcus.yu.56@gmail.com>, Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Joshua Crofts
 <joshua.crofts1@gmail.com>, Shi Hao <i.shihao.999@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@intel.com>
References: <20261029074851.216029-1-marcus.yu.56@gmail.com>
 <20261029074851.216029-3-marcus.yu.56@gmail.com>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <20261029074851.216029-3-marcus.yu.56@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/29/26 8:48 AM, Chang Yu wrote:
> Add a driver for the AMS AS7343 14-channel multi-spectral sensor.
> 
> The AS7343 is a 14-channel spectral sensor featuring 11 visible
> channels, 1 near-infrared channel, 1 clear channel (VIS), and 1
> flicker detection channel.
> 
> The driver exposes 12 spectral channels (11 visible light and 1
> near-infrared) via sysfs. Runtime PM is implemented to stop
> measurements and enter SLEEP state when the device is suspended
> or torn down.
> 
> Future patches will add configurable gain and integration time,
> interrupt support, buffered reads, VIS channel, and flicker
> detection.
> 
> Datasheet: https://look.ams-osram.com/m/5f2d27fff9a874d2/original/AS7343-14-Channel-Multi-Spectral-Sensor.pdf
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>


[snip]

> +		/* Check for digital saturation. */
> +		if (status & AS7343_ASTATUS_ASAT_STATUS) {
> +			/*
> +			 * Per the datasheet, ASTATUS is self-clearing: writing
> +			 * the value back clears the entire register.
> +			 */
> +			ret = regmap_write(map, AS7343_ASTATUS_REG, status);


isn't that the STATUS (0x93) text? the datasheet says ASTATUS is read
only and ASAT_STATUS clears on access, so the write shouldn't be needed.
it also covers analog saturation, not only digital

> +			return ret ? ret : -EIO;

-EIO reads like a bus error. as73211 returns -EOVERFLOW for this,
wouldn't that fit better?

		if (status & AS7343_ASTATUS_ASAT_STATUS)
			return -EOVERFLOW;

-- 
cheers,
jose a. p-a
