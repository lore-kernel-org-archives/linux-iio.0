Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795616622;
	b=gAv1DnA2jcHmgoNvBOr3uCqYIc4nXV/EWIw06Cswm26JFpHg2ZEyoAx/DXwAMyBMDhy7
	 SfWEZA9yV98YUWs4S6Vy3J7PPwdmxJAPR/kYIeTtlpejCKwNrqDbDXapOi7enVwdYvFxK
	 AwluInz+9ai/5i41CzR0qC+7SGvb6NotG/IwrWtZCUAzChGC3931WPjgtG01++oTFezDI
	 bojiDE8UMpPSt61QClMPjq3x78CYrTAvVzJXpOD8XeP8eV0Z0yz6pdqLzfxFG3cgnQiDc
	 juL9oxettT+ojSsqCcznr9YSljmmth13fBbGvVnB9Tj2DT8ilpN7SuvdXOVHvdg+pCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795616622;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=50gSt9hp6GSAIpuWnVDuHjwFxVGn5eyqx3CRupQkIy8=;
	b=y0i2joHvvT/B4T4g1LK60oxEIPYl8Jx7XgS0vFgxEU7jlGppolctjqm71tMmGQURruQQ
	 NwslNKuW0L4f/fjXv6yNKqXlod+b6oAYdfDyVOzMh40huGBMGFhBbGsxo+Z0cCp2rYqau
	 J65pN9LNO0K9Z9Lwh9Cs1DcRlqtfmkohRXJs6hrg4c55dDiTxKPVbZv35BVPLKmmm+Doc
	 6HtLHQcy6NVn8wKn04l9UnfunQboohNhhSxwVogbtUrK15ok80x9DBAtHO3t57tSetiHk
	 cS8zOBv//1eqpJH/mPruS1F+2YzUU50AxgqLI0WIbi6/yBsYIifffKT6vRWotm050zA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=L1FwDLp3;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2D3606A331
	for <linux-iio@vger.kernel.org>; Wed, 25 Nov 2026 14:23:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E2D3606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=L1FwDLp3
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4bb6c7b6dbdso54235375e9.0
        for <linux-iio@vger.kernel.org>; Wed, 25 Nov 2026 06:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795616620; x=1796221420; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=50gSt9hp6GSAIpuWnVDuHjwFxVGn5eyqx3CRupQkIy8=;
        b=L1FwDLp3wHHSO7OHNJzAMqbMI3UzxX+e84R2IhF7FhA+JeTZBxBjUpwtiC4W1qd0jQ
         6/P62yQTbdXtRzJ/Chi1+ZzOPqKzPLTswybBmQtyQWMvqZrkX6njoV4qLwo/KuXFaPMV
         YP9bxcFGse8GqHNYMQfFAH8iONsqJ72HnCi9lmW8FWUD+rvAf/X4Kc3irkcnSyY+VfmW
         PCee0ToykhFaayyMrnwgg0VGw/RYfzR0BeM/9aHsX9CpVscUFq3rPcwoMAEjNhOFW8E6
         q793a99AUX52CWkhfNi2ZOiooz4UqjtVZHsdmGkJa72PfIVtOOYl20UWfx1uKGOzOjDL
         XKHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795616620; x=1796221420;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=50gSt9hp6GSAIpuWnVDuHjwFxVGn5eyqx3CRupQkIy8=;
        b=ycWrS9sAnDJw11c6hpho/R650CyUsFLv7ci8DroQlUMx7T1UyUhagAsrJ1P3ZBPii/
         5l32WlFv8bHY9iDd+ihdczp1sNETCeffadhwMnj886EeulwL4W91xxPzTa9dnyettxl0
         Fo5SoOJ51JbnIeYMJHDgqwAgAA0o3ZF6CuWXUhMQym1KkIJPU0VtbZloOB/21wtg/Hu4
         sG+QmRme5/gX1RhgGnsYZ7lfruuzCr661fvPJxFWxK3t65RhHiKTcBcNbkOocIbW/x99
         stfwnVIieOuaOFJ7lTv7MZejkKFlWbwqyigpcaIfxaKA773PwkWKac+dg4vJMg9cCg02
         vwrA==
X-Forwarded-Encrypted: i=1; AL+hErHjEHLp1RcxGrJZefYbs8cpLR4BXrQRydbUx6ivWMCfTXDO17vmf0MXReV6dBEV8KeUcgsGyX+5zmQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9DE3mF1H3AHcOt3vQ2U+OcF56CXpWrfFw7T3+5XT/28NnF2yLp
	KrzZisdUKg9UKaB5dD33zF0pvXslmmQiFS3LmOFZd4BskMQEHYsjymnOEvx3mz4ilro=
X-Gm-Gg: AZFdTZdkTitymxb8miDxCQhGYopskCWRp7xdP8Uidn8fHhFxwT6D6QH1eKKL2lE4UZh
	kXVs+uA2giFLS6TAJOQjhd3g12cx9sWpo636G2s2ja2jvFIfyUQ0GktI9fqma8l43cvnzsx/c7T
	g/ezitKkW4aXcRx947+yD1KlWolrsaN9kIaR6/7eK/zXPbSNcEnm4H/upI52uRScRTj+K0/VkVk
	bXM1k+UEFkyO01i4SQwFtStwcavfsSVOugU2zLtA+rGR3rxmtrdl5DjRDOxzEhnMCuq7t8axcrI
	PDGkc4SbHJAzGOQpU9rKLHuvZU894sknpx61ycPrXLSiQh/wZLTZfYDcNeEhTYeVZfeMr2SyvO5
	ofdO5PVuABr+2g5eYiLzWeaxmvAooK1MxR5Pt/bXfnA2h5auvXlT7zii8zXSd/qzsL/hOcDxN1P
	/YlzG/PRA5v2AXfPVESqz5RTb3vlgVZzGBY0teMPXuAwwmsXVptVhi1uv/lUMI+a3s6JqRI86II
	Chk8yepvopAA4H+TYUOgrBjXqIogJqd4gyETu7yOCHx1CaOEOuK0pmYQuVmfED2A2zPl8b9GS0O
	06XZak9Ke6ksnnT86ZaRacWPFfV7jEWnx6EM+evn4Hk+Bv0wiP8ZC3asGv6IgpQAPHcpntT1/eQ
	4sUz9jhY0xB2o6+fDgxR9unCaSrNQehNGKApN4DiynY4=
X-Received: by 2002:a05:600c:848a:b0:4bb:6626:5a25 with SMTP id 5b1f17b1804b1-4bb88813462mr315204935e9.20.1795616619785;
        Wed, 25 Nov 2026 06:23:39 -0800 (PST)
Received: from [127.0.1.1] ([2a02:c7c:5e34:8000:720:5dc9:500c:65bb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6bc8ce06sm33638667f8f.47.2026.11.25.06.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 06:23:39 -0800 (PST)
From: Alexey Klimov <alexey.klimov@linaro.org>
Subject: [PATCH v2 0/5] Exynos850 ADC support and soc thermistor
Date: Wed, 25 Nov 2026 14:23:32 +0000
Message-Id: <20261125-exynos850_adc-v2-0-26de1c6f1717@linaro.org>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/13MQQqDMBCF4avIrJuSscSarnqPIiUmow6URJIii
 uTuTe2uy//B+3ZIFJkS3KodIi2cOPgS9akCOxk/kmBXGmpZN4jYClo3H1Kr5NM4K7QdSDXaWNc
 aKJ850sDr4T260hOnd4jbwS/4XX+SlPgnLSikuGrsLwqbvtfu/mJvYjiHOEKXc/4AEKyE9qsAA
 AA=
X-Change-ID: 20261118-exynos850_adc-9cfe569acd8a
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: Sam Protsenko <semen.protsenko@linaro.org>, 
 Sam Protsenko <joe.skb7@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.3

Hi all,

This small series adds support for the ADC block found in the Samsung
Exynos850 SoC and enables the Murata NTC thermistor on the WinLink E850-96
development board.

Exynos850 ADC is also called ADC v3 in downstream but my understanding is
that SoC names are more prefered.
It also relies on PMIC 1.8v regulator which currently represented as a
dummy one.

First commit adds compatible for device tree bindings, the next two add
the ->read_value() callback and Exynos850 support in the driver, and the
last two place things in device tree files for WinLink E850-96 board.

This was tested on mentioned above devboard by reading reported
temperatures from thermistor.

If dts patches should be split out as a separate series and should go
separately please let me know.

Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---
Changes in v2:
- split the Exynos850 support patch into two patches: the first one adds
  the ->read_value() callback and the second one adds Exynos850 support;
- added an empty line in adc node before status = "disabled";
- Link to v1: https://lore.kernel.org/r/20261001-exynos850_adc-v1-0-791b3516bb9d@linaro.org

---
Alexey Klimov (5):
      dt-bindings: iio: adc: samsung,exynos: Add Exynos850 compatible
      iio: adc: exynos_adc: add ->read_value() callback
      iio: adc: exynos_adc: add Exynos850 support
      arm64: dts: exynos850: add ADC node
      arm64: dts: exynos850-e850-96: add soc thermistor node

 .../bindings/iio/adc/samsung,exynos-adc.yaml       |  1 +
 arch/arm64/boot/dts/exynos/exynos850-e850-96.dts   | 22 ++++++++
 arch/arm64/boot/dts/exynos/exynos850.dtsi          | 11 ++++
 drivers/iio/adc/exynos_adc.c                       | 66 +++++++++++++++++++++-
 4 files changed, 98 insertions(+), 2 deletions(-)
---
base-commit: 7cfbf79c66c63e807ea452abf0546e6f6d6833a6
change-id: 20261118-exynos850_adc-9cfe569acd8a

Best regards,
-- 
Alexey Klimov <alexey.klimov@linaro.org>

