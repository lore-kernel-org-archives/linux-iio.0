Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7932571D7
	for <linux-iio@vger.kernel.org>; Sat, 14 Mar 2026 18:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773512323; cv=none; b=fx6UCWJz+0d2u0CpI+vq2jJbWftUmbtV10/e4+pAUYMUhsfaoLyHu4BITmasoU8zca5XH2s39tg0IdTxFHAdQ3olZs6VmLGoST58LkSfZc+DZr8JAL69uRIORA0psghLilv/8Fm7uKDQBfq5f6ikueQVg6C91YzDbHLfVp01xfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773512323; c=relaxed/simple;
	bh=i+hiSWMpKcrgrezSSwiwAM2zE/+XHI5eQEa9uY5l89Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BXLFUy/PF3qLDTDzSHzTLeIWay40t3N1VgTwdThv52QeS957rHnS/HERXBdFhj007zG2/brXrRgcNMdUkllQA64HiOEXkMnuKGQcoTKW74iF/gpucmVrb5TQW0uV4s9VHI9a3u4boK5cZ4fUD6ZSIthtfyJptIMo0sjR1M82Bj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=13TG+A8D; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="13TG+A8D"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-66f747175d8so1745578eaf.0
        for <linux-iio@vger.kernel.org>; Sat, 14 Mar 2026 11:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773512320; x=1774117120; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SK/kmh7PEw2pLUP6UdfntY8BFkF+lE9LaAHgnikGaa8=;
        b=13TG+A8DXRwVx/TolYvZ/3shHW0vM1uWKCuKoYT5iavumvHU5QXWmJ0PIJfnXI0ZB9
         K6IklLcN8oPGe8jnFsqFFzyGvSjG9MYOkBLLC6Hubl1Q7OcdN2+ondJ0BCMBLdnTIDP4
         0KzKcCmFNTpfnW0SB2D2LeUaAlurMbrfAY9GXfxtJJfhRIrh1I3Dv4ep8ah32DPeVoRP
         VB4fyTD8iHTYJkw78H8zcrABmw+UxiLPcntuX0d38E8ZO0K6jLtusWk/1VvVONipaEHU
         jw5Z7gXjkId5nWsYh58gtjWsLOy71RxDfAHwc8SboCK/B7j6hDNaePuxLYep/toNNr6v
         ICLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773512320; x=1774117120;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SK/kmh7PEw2pLUP6UdfntY8BFkF+lE9LaAHgnikGaa8=;
        b=gv1OHK1S6qWAZSBfWI/RIaFMo0igVpVeXCbEv9Buab93WjK+j+fPntmyviJepQlSyj
         6UQRr4RL1xdWo+lGhshQcuRNtrnuqBvl1X2OXfQyVDZQS7dyPL02O3hq+K3XCYKrWb0U
         a4nIDDSNVECQ8FG+EswPhbnd/ZV2HatLG1vYZdkwt5lvecVJw23Q7a2YLMcQWxVdYbti
         D4ocjGFVilrGPtm1wSyymkGb93nKvtrCm30g5MGe8Wgr+692KdH2Y+EH8J0s+2jMWymz
         GMeWmpfWHu/o3S9V5aEAV9t7CufewsniPRq6CrrqZDu5vMZHAA2ME9DTRFYhzHZfYj6v
         QBrg==
X-Gm-Message-State: AOJu0YwQJp11Tz49bWTnu6ib/t76vDWm1oJxC/hkgPeQ2VF2s+YiPaYR
	6837fiBxv6Plvc2pFjIxnDBRC0g3IPgfwXR9oCsbu/uRKgNGGMkP5lH4X/qQrPb9dys=
X-Gm-Gg: ATEYQzztx81+O64+0tKP2uJVwJPe7xziarwYeg8io0M1luyyoFfNqXo9KtxdHT7WfLK
	u3GE3uPbNMnGGD4jQtI3MB9z6LUu4bBzzuVXgk9uvyIqJihYB0EI0UE5izHhGzklYh+7SRGE/Iv
	brhw9KDc6+6nzQQwNCa18OoGCPxH7WGkotOR784vrYIy7+oeMqs1iv66vvWfMtJHcJ0rlFbAPLg
	/DjF2KgpR6yDl6Dea9HBmYhlhAvDmCu2XUSRRiClt73eoT6Wp3/ro/duaZG+1fVHPADphxHYlZc
	nk9Rm6VxjGwK1ndVN+qVcCMKWJzHzEq/vTCNb1E7UwJ1x+IjAoXqsW60Gq9yw/NyVB12ylL93ZI
	nMTS306jDuXaR6SbIRbDlmrgIPE8Nr5/8WKA1WfiC39enLcjBj57iux5MB0Qkah/jVSRNlcSdC4
	UpYdClMI1CV6YloRadQ9/NHJ6NvSyBbDDsyhncnRs1yC+HWdEYzUC0FbLpcZoezMcg8MmleLlQI
	ZEhp81azcP1
X-Received: by 2002:a4a:ec44:0:b0:679:dcdf:1a0f with SMTP id 006d021491bc7-67bdaa92ce2mr4314343eaf.72.1773512320145;
        Sat, 14 Mar 2026 11:18:40 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:14a9:db6c:e65a:4287? ([2600:8803:e7e4:500:14a9:db6c:e65a:4287])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67bc9342ad0sm6716591eaf.15.2026.03.14.11.18.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Mar 2026 11:18:38 -0700 (PDT)
Message-ID: <e8b34b7c-456c-49cc-9da5-83ccbd11c09a@baylibre.com>
Date: Sat, 14 Mar 2026 13:18:37 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] dt-bindings: iio: adc: add bindings for AD4691
 family
To: radu.sabau@analog.com, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-gpio@vger.kernel.org
References: <20260313-ad4692-multichannel-sar-adc-driver-v3-0-b4d14d81a181@analog.com>
 <20260313-ad4692-multichannel-sar-adc-driver-v3-1-b4d14d81a181@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260313-ad4692-multichannel-sar-adc-driver-v3-1-b4d14d81a181@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/13/26 5:07 AM, Radu Sabau via B4 Relay wrote:
> From: Radu Sabau <radu.sabau@analog.com>
> 
> Add DT bindings for the Analog Devices AD4691 family of multichannel
> SAR ADCs (AD4691, AD4692, AD4693, AD4694).
> 

...

> +  interrupts:
> +    description:
> +      Interrupt line connected to the ADC GP0 pin. GP0 must be physically
> +      wired to an interrupt-capable input on the SoC. The ADC asserts GP0 as
> +      DATA_READY at end of conversion, used both for non-offload CNV Clock Mode
> +      operation and for SPI Engine offload triggering via '#trigger-source-cells'.
> +      Not used in Manual Mode, where CNV is tied to SPI CS and no DATA_READY
> +      signal is generated.
> +    maxItems: 1
> +
Some chips have 4 GP pins, so there can be up to 4 interrupts.

Also, the DT bindings should not specify which event this is - it is
programmable. We should just say which pin is physically wired. So
interrupt-names should be "gp0", "gp1", "gp2", "gp3".

It will be up to the driver to decide how it wants to use these.

