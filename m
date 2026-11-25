Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795635090;
	b=mSAOvwNshzh05PmuA4OAM83VkveqItwNGHazWb1hAFNkSQNzCgDLEAjpkOnDlcOThKlV
	 a/VYws6aq6g2S3atuUfLr65/LGmXXSwAhB2R7gicirGsPvlPEcDK5xmEw45cRKkR/F50P
	 QtF3Q2nvm37WG5teEd9ztnnz3mmQPzPZWSPmXzUGVjt8RK554W1wZkdeWjTjsL8qPyB7r
	 8JLJLa1dcnkxRzSerH4J2jZfDhW6psHNLNZ9FVSP/MU58GhMu9mCU16W2bc34LLStJ8Hx
	 HOMi2psRlH+T61Qar0GO6iwgfrpTaBmiMP0gl/F6ksipoI+XqOCgtiOpZPwyryg2MPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795635090;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=U1oBw4U+gjNk3iM5j42wuAngnRMfL1HrI9OahKdf/KQ=;
	b=Fs3xlBE1Xn3UDwwb2mlhzZROXV2GIBA0mzpQrnRvppw2G6ysNwF2NHBhsk6Dr3iNZGQs
	 iBc+TuAiXx4451EHnlAv2grT9KOsmlDtzx+sytcWGH7+udm5OYQwKSkk2QU6pkg8xwh5W
	 ZmekXp7Gb/mbWwXh+aSNJ4nIcn1e59afWkblwVfGF1oBEX+ZRtc2+MQuovFZXBME+uIfb
	 K/GcPdVDMwVOj9aSVU4oDUQbcBUMVkB3gfxqu5EmAMJb+66jIV5vWNvPHlG+hipBPujy+
	 NhgopM/KVwFRrj7vvm0MTZE1z4qzDQiMp892rct4sr/jzfnhj8nu6tOaLDxild/6+Ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0nHMyVEo;
	arc=none smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEF0606A321
	for <linux-iio@vger.kernel.org>; Wed, 25 Nov 2026 19:31:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDEF0606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0nHMyVEo
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b8b20b2538so7183143a12.3
        for <linux-iio@vger.kernel.org>; Wed, 25 Nov 2026 11:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795635088; x=1796239888; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U1oBw4U+gjNk3iM5j42wuAngnRMfL1HrI9OahKdf/KQ=;
        b=0nHMyVEo+cHSBg/yZjo07YS7lm0nSu5aapXced69byeyWvlod6eZOHh3vHqbFwviLr
         fXpsJZQXB8MYqRvheUfHH+u50BUewnvIXigX2sGoh1oBv0F9raAp1hdMWLRSKGQZGQI1
         SQQk+CCM8hEOeYgk00xfrypTvmXRqtcUioIBzk0/arl1DHjQmysx9hYsi5u3I063SrFG
         +8kYHx4giGHRVBYzeGw5tjEcknNPOtd1dXh2UMhaEQzFdLNIZyhcgBRDqr05SI1pzSPq
         E5lNpN7bzrTvZr0k975+r8Blji+jn/Y2ahr5ord2EOCxrBjaO2ytOiaWdGmorD2eF3Mx
         PhJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795635088; x=1796239888;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U1oBw4U+gjNk3iM5j42wuAngnRMfL1HrI9OahKdf/KQ=;
        b=w4bs38aBfz+NN1KmoMIfQFZCp6WrMFkqxwrTiop7UwiMyNhK6GW94mo3sZlmQpeKkP
         uLX0N/Q4rsKmBClPviV4SEsNzif1Y9l8zW86jBTf1Rs78XREZmXLnmIXjpVF5ccI5pGe
         y5YMpbXCuoe64XDrHgC2o0AJRE60Q5qRvanms5fgAyLLibJJAYVsglgqtXNTHRckUJ6i
         8VcThR6cYsBHjW3RItRHZGhXMgsyQf8bo7wqL5pxxnbckxi/Fz4jBkynKjrkpn602jzC
         mjb+whADJIsKgrBEFZ1H1dUrMsXhhnFj4ONtZi5lTIFeNnXS/ADGaAYLNtLBpFSDB7x/
         l7Zg==
X-Forwarded-Encrypted: i=1; AL+hErF7KqEXRrBf1OiitdoBi6GIwtGMxuGIO8uhrL+luVtDnoR4lb9sgsOwF8+4W6PG3xtGmXHUG6HYFeY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+6CL23rgPsF258sKTGxhHNrgmc0yqqqhJplFnZoBrSSXUfC2fD
	M6M9AeSxjKVC4w8dwDXLNMIrD6XWJqfb0h7Vs4ZkxsOJV3iiUqLS9sEA
X-Gm-Gg: AZFdTZf0djH/cbNJ5sokuQrmLEiYt0saavPHNDqv74kvmux//W9wwXoZFpW4k0Z8mmv
	c37lsBH8yTOBj7XaOQ60iEU8EQ/CCxOdFyZNemXCiY2m6DqoJ3ZUXstddY4UKvCKt9h9pF1smn5
	7+VLznYLglpXcNqm3GLwHYoOP5DAj0IW7ETjWdTl6TLlQ1LWL1nlaUmai1puRbKhx4WPFA2Pokv
	HpEQI6Fjx/8OA0eHltGPRhwd4ncXCwqtV7l72k0Qh02u5lgXjARUahFWdPNQVPw7je4wEJdz9l/
	lKJqFwUyhVaTu2do4NHaI8m52J8h1cKYxKelYzI2g5m0XsbKAnNTv2JUzAwuKnaYtBNOVh7B95/
	WrpyC420QrUpAMU/xTw7QzuXGxlFSxxOqTry7whSE/IGYPGIPJMGjiMvo8FLvAG1yXDynfRtKe5
	L12rz90L3pBsM750EPivCIPAVQszn8CNrkjg7+GqSC4d1+3hxBACoNFr3d5ELpEVzFWCE09V1TR
	GTk0VK3CeKjSRSyOIRZSw5grO3fWLwkFzShdR2C+6DkUbHJbfRIhikTpkVbfrRy7UzIJXdwEZAh
	9Y4nnR+KAg+TJ4IZrsoHxNXDgmsSpc9S8llGfpVbPziQfxo=
X-Received: by 2002:a05:6402:1f4b:b0:6bb:1203:487e with SMTP id 4fb4d7f45d1cf-6bb12034b21mr4236672a12.6.1795635087911;
        Wed, 25 Nov 2026 11:31:27 -0800 (PST)
Received: from localhost.localdomain ([195.155.168.135])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba371072f6sm8924419a12.28.2026.11.25.11.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 11:31:26 -0800 (PST)
From: =?UTF-8?q?Adil=20H=C3=BCsrev=20Tepe?= <tadilhusrev@gmail.com>
To: Alexey Klimov <alexey.klimov@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Sam Protsenko <semen.protsenko@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Exynos850 ADC support and soc thermistor
Date: Wed, 25 Nov 2026 22:31:23 +0300
Message-ID: <20261125193122.747908-2-tadilhusrev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125-exynos850_adc-v2-0-26de1c6f1717@linaro.org>
References: <20261125-exynos850_adc-v2-0-26de1c6f1717@linaro.org>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, Nov 25, 2026 at 02:23:32PM +0000, Alexey Klimov wrote:
> This small series adds support for the ADC block found in the Samsung
> Exynos850 SoC and enables the Murata NTC thermistor on the WinLink E850-96
> development board.

I tested patches 1-3 on a Samsung Galaxy XCover5 (SM-G525F, Exynos850),
with an ADC node equivalent to patch 4 (same reg, interrupt and clock)
and the board's three NTC channels.
Readings match what I get with the vendor-style sequence (re-init around
every conversion, SOFT_NON_RESET after reset) to 1-2 LSB on the static
channels, the NTC channels follow the temperature, and 200 back-to-back
reads per channel show no stale values. So initialising once at probe
works fine here.

One small thing: channels 8 and 9 always read 0. The downstream driver
uses 8 channels for this SoC, so MAX_ADC_V2_CHANNELS (10) may expose two
channels that don't exist.

For patches 1-3:
Tested-by: Adil Hüsrev Tepe <tadilhusrev@gmail.com>

Adil
