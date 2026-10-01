Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AB638D6B8
	for <linux-iio@vger.kernel.org>; Thu,  1 Oct 2026 03:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790824157; cv=none; b=LomVM+jEEGktKhhQ3BhBsPt3j0doHGAD5H2hKkHSEojWFGirftGEl16a7oQ0CTW75WDq0/2Y/AlXU+wLD+OJnIRiAe88c/tobWR+I7zWZa2FQuzjgYaGZF6QL4fHMlMGk2FNtS0eW79766KUR0I/uFk9WYS3oMdhkdGM6+q50qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790824157; c=relaxed/simple;
	bh=KdbLuJASOqevLxdks+lbqwjMq97p66unyiVIod1bv5k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=A/WPDFTX2oZ446hb3rSSFWURptdhPVGQcJoXVY85DDc+IXZsAcVcXDNGQDkYAw1Kog9KIhY/yonDsf1Ddp1tccsNo+KrkJsiK6Bbny4MVaJruDr17ayajlrsZdGRu+gHSSEn93mUpeBLX/WTU+NOiOe1QVxPPbkvVyQ6RdYZod0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b79Jeha/; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b79Jeha/"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b912d37b6so33391395e9.0
        for <linux-iio@vger.kernel.org>; Wed, 30 Sep 2026 20:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790824154; x=1791428954; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=d6XLJYbI7HUMV7gx7S4Fj3cUrwWbeBAJ9EUdAHuqM6E=;
        b=b79Jeha/QTbOVruwzc8D0ukHx9EcrvVF3mxLtJvTTCzGIWe0hhZB/sGyR5gBIW0d8a
         9fqrOmFiO1X4uygll4NhQ8THELudQaGyYdiKET6UbFud0oDrFZXOEkOCtq2xeSBWtE7i
         fqZRbOXTgsQ3ugyk+5rCjHwYyie1IfL72cXBArKS4QyY1ajuHd97rQJU+5SHkw2NL/6o
         w0WzGkffxnKgUPxMawgM70JVqThYMU0i9tx8vWJgEDxeHbUdOrEinrojI7MYALX0dLDC
         HtsiYMJqVcQYtPJthoQu90Qg6QrYDLaSp3YizyKLZm+yJiLfW1vFpQyopKDU/zzhKL0A
         T3jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790824154; x=1791428954;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=d6XLJYbI7HUMV7gx7S4Fj3cUrwWbeBAJ9EUdAHuqM6E=;
        b=yvksHJaKbSbPgn4nxQnrHF0pAMuiXjIEzUPafuiDpQfH6Uc2wMKF2so2c1TyEhz3mE
         ky5ViTHk4MfLgX+3YTIT544/vKR/dgMDgabxOhkhCygwSN94mDvZnAhpshOLa205C5Rc
         xp9gEep7Y2VSJeaiQqjZdaDqeJSsrsJMOwKhmuk+C8LYLhogvxnwR8WZ7fSXy2x5bYxw
         QWBJ45Aco7scRvpOXSzcctRj4HeNBuammrGQe/L+1gZM6C3X3g/sUxkx4LIiBACG5uMl
         1CtbQWz09fprz2jlDghTqgsNj2nznkZyN3LaaURsa3eyHV+DLLHrl3bZ4BSACu5BkYvg
         VUPw==
X-Gm-Message-State: AFuF++lMnpqnoJgI7owOOyeHR+wiX8PsPFJUZN9ZvcAnV8wBnH/yKB3Y
	hItqxJrdkW6EkjID0pupLrw0wAVNrXCqforehRSwal9ZGrcX70x/eBrUHoqvttzp3x8=
X-Gm-Gg: AYBFou2gxTsslFGEb8AWP6fxz+W1yHS7KRb6XO6Hrodlqo7x7ndFORr4lahe6kKCp9w
	kj7ZgZPpkFwmze707b4Cin5kYR/M4nYAuzSKA4vPBFHa0fddX43u4eiOU4fepavSsuihFJeuYPQ
	nx01mvao+gPcAzz5B48y+tOeDKFEVSwaEsqu5gSxvz3ihAPtq2cDY1AxwXaFARPHpK3Acn+/THg
	0hlnYf62IcDKBO3NxOTsC6AIFoeH03IdbVu8M1j6Q/SlJQR01HmcwpLWHqToHXgC9wgvDaw3Vu1
	fx9ij42Ias++WA6mtg+94mD2mwK2cq1o0hsWYX7k4tMxlCbvv7ZtmnTQORjMrNNbBcmbqRECVDK
	snx27ADVlxDP00J5VtQisqlz7cL7DaegaaPPqz7MrGRB3mYDsK/fdQ+7AzVsdu6PNqhcv0RZTFt
	F1mMHSkOWyCoHR4sj7OtbATf4zwSmlGPjdpT4CXR/0g1Yl0j11C7TzVDwiCN7uU1M29jhDfUnQR
	pFocssPutEAPBILrpUs+dN5KvQAeEiBwj84PnTR7o6JFvWo+ek2BykgaK/TFw==
X-Received: by 2002:a05:600d:4448:10b0:49f:ce78:3564 with SMTP id 5b1f17b1804b1-4a01b11bedcmr39473525e9.21.1790824154410;
        Wed, 30 Sep 2026 20:09:14 -0700 (PDT)
Received: from [127.0.1.1] ([94.4.85.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f9145e6sm27091885e9.5.2026.09.30.20.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 20:09:13 -0700 (PDT)
From: Alexey Klimov <alexey.klimov@linaro.org>
Subject: [PATCH 0/4] Exynos850 ADC support and soc thermistor
Date: Thu, 01 Oct 2026 04:09:11 +0100
Message-Id: <20261001-exynos850_adc-v1-0-791b3516bb9d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANfOvWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDAwND3dSKyrz8YgtTg/jElGTdJBNjI0NLS1NjC8skJaCegqLUtMwKsHn
 RsbW1AF3fQIBfAAAA
X-Change-ID: 20261001-exynos850_adc-b4321995389b
To: Sam Protsenko <semen.protsenko@linaro.org>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3

Hi all,

This small series adds support for the ADC block found in the Samsung
Exynos850 SoC and enables the Murata NTC thermistor on the WinLink E850-96
development board.

Exynos850 ADC is also called ADC v3 in downstream but my understanding is
that SoC names are more prefered.

It also relies on PMIC 1.8v regulator which currently represented as a
dummy one.

First commit adds compatible for device tree bindings, second one adds
support in the driver and last two place things in device tree files for
E850-96 board.

This was tested on mentioned above WinLink E850-96 by reading reported
temperatures from thermistor.

Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---
Alexey Klimov (4):
      dt-bindings: iio: adc: samsung,exynos: Add Exynos850 compatible
      iio: adc: exynos_adc: add Exynos850 support
      arm64: dts: exynos850: add ADC node
      arm64: dts: exynos850-e850-96: add soc thermistor node

 .../bindings/iio/adc/samsung,exynos-adc.yaml       |  1 +
 arch/arm64/boot/dts/exynos/exynos850-e850-96.dts   | 22 ++++++++
 arch/arm64/boot/dts/exynos/exynos850.dtsi          | 10 ++++
 drivers/iio/adc/exynos_adc.c                       | 66 +++++++++++++++++++++-
 4 files changed, 97 insertions(+), 2 deletions(-)
---
base-commit: 6375e61c01e93e35ee7acd336a689ac1fae4b509
change-id: 20261001-exynos850_adc-b4321995389b

Best regards,
-- 
Alexey Klimov <alexey.klimov@linaro.org>

