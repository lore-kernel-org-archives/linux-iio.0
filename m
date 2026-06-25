Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFED3921C0
	for <linux-iio@vger.kernel.org>; Thu, 25 Jun 2026 11:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782385608; cv=none; b=Rb9MkrhCpn2v9tCbRp2mTnk1XpZ8PAd2tKmZLLFSfc7C2yd2JQYG02J8QM91e2f9DyMlG++j+RVRhGbs2LXdFf8oddxm3o4iiUiJDHzXxC91+7+eXCtEWKnxdsVABLilnpzZ1uA2j7ybtoug+a+e9EqpOGdzwn3CGLJGGqMtWHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782385608; c=relaxed/simple;
	bh=PskyIyU5foutgsBFT2ikyuI1KvX/bVIqqYVLK42DVOo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eMRLGqiVhi5RY+DX3/Nj1Lq7gTX4RJtZwXE0VP50uUObYBTZjSKydGhd7MNSMZ5+j7JWy8F1yUbPEfek1uS0wlu/GbVvHMjfC5FifgFPu+nKOCGJxL5blepkZlFKDt6ROFx+diJtA6C+rEBy6LUev8DkrMACcDrRiWP4N8CzFvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LOAe5PnD; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOAe5PnD"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-84538597e1fso1476723b3a.1
        for <linux-iio@vger.kernel.org>; Thu, 25 Jun 2026 04:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782385606; x=1782990406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IQDJv9UMQlWEKvIidyyhqiruXHUjg+2ZPsabXlVxUVo=;
        b=LOAe5PnDjCPCs6Kf2lOwkmHM/Qiak1vWGMt5RnuZKQHYGgTt2Agg+f8JFQGaT3tZNp
         54+KxVfS7cYnKvkg+sbXEO0tC57Cwhawy3w7YutsP8FAlWl8RNr3TzsOT9DLZwigXGWY
         eBpIw1okQ/FVORMhvnhYf8q2tmFGtI7vRoIBvLU3IivDRIOZd9akGkRb9X7qB6KHrlCk
         +cIeznbkf0S81kOfdWDes95ZbGrlm4EVfZbfIwD8C6rtMM4q3c8havb8iNmxZj3uDEpG
         /nGH8KGCXBfRA8zdOGWCvSJjqeYxk+sshosWwHc88fqmXYe99QufMr4Zki5wEa8ZxoE1
         ie1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782385606; x=1782990406;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQDJv9UMQlWEKvIidyyhqiruXHUjg+2ZPsabXlVxUVo=;
        b=CcJFPz42czhQw0+JjAT/BM2PJJF/SQr8marniRAIkY0gGgNjLlBe3QNiDJoqf2DxTr
         J/kXlqy1EdR50Bbk8cVNmbP7qt7tie2AEUi1Z/p7NDe1Z1aeLQ6Ipp0vNONb9HPq+qij
         hQFYPL2qFIx6SgsHhxtdsVZFquzwOFdvtaZxLpb4+jphzVbA1OOU4+yLERq/fjiZZxob
         OGoBJf2A98WkmaJoBmHxtE2Tm3TEti1/eAY8Xf2GsIUqzm3PyVXSzgLx8tzvC1g534Ei
         3rKuCkdnUS5gX8d3nSPBU76s4dJ0/BNRvSjvcSTvtCfruDY0zVCNqWSuQzasy9KHHkBv
         yzAQ==
X-Forwarded-Encrypted: i=1; AFNElJ/etDhZJN+Z7f0UJgLMw2qxoqml4CpDYOg3c1wrdXGQnKThKXWYE6gU1w6EyWoLiKjMSggsi0CrtXg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl2OnEkSWW4Hy6iKe+13pCgItF7UN8eMBdrLIGeKCb1TK9dDPU
	DhaS8vnPBZDhwGAE2i0EYK3mgOjb0Pv2b06rfGI+ExrW7sts6bzUg0c/
X-Gm-Gg: AfdE7clX/f6e7G0UmeDl7DHg4uPMOiyOGlyN0Z3gjTaktlgMRUMfcLH9ivGc1hinpVG
	3oMxa7Crx/9PJ/FvH+xDdono12HazOZtos9/zGOV9HBA+g9gyP4jy1W8iQ3ywUu/tDDBZOGKtNP
	g3WhBU9Eot71wPTDPpSfEG4Q3MEKFND5uSIisl9Kk6tLdcF2p3mg7OtQGrc1cYow25wGsTVC3xG
	pprsYvCYwl2Kk+svgiyBMlpc8waxPuC0rrlaTm+VERL82uZ71zbTkyoB/0JatBkbMPHO26meFDT
	9rnrkCo1V/6dwzfAh/A7RJWA6784Eco/uDwU3nv6WgNkshcBFnsPfgE2baVcNicCLpYTIX8pbff
	ROloZz0LCNeSym6vKPYFrgbabhHcWePpAgjixCqkuK5F3oqwBrDM0g9ZrPdRqBQwRwNTT2YKdRc
	enCusflyLM876uZtFNP3h2NVLOouT+ad6NzrUTrZtoBheAOGQGTqG6+1R83IJXxln/a8hQvPTcJ
	fI=
X-Received: by 2002:a05:6a00:2917:b0:845:4126:222b with SMTP id d2e1a72fcca58-845b3ab542cmr2566928b3a.28.1782385606359;
        Thu, 25 Jun 2026 04:06:46 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845a3fec0f7sm4412759b3a.22.2026.06.25.04.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 04:06:45 -0700 (PDT)
From: Chi-Wen Weng <cwweng.linux@gmail.com>
To: jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cwweng@nuvoton.com,
	cwweng.linux@gmail.com
Subject: [PATCH 0/2] iio: adc: Add Nuvoton MA35D1 EADC support
Date: Thu, 25 Jun 2026 19:06:36 +0800
Message-Id: <20260625110638.38438-1-cwweng.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chi-Wen Weng <cwweng@nuvoton.com>

This series adds devicetree binding and IIO driver support for the
Nuvoton MA35D1 Enhanced ADC controller.

The MA35D1 EADC controller supports multiple ADC input channels. This
initial upstream driver supports direct raw reads and triggered buffered
capture using the controller end-of-conversion interrupt as the IIO
device trigger.

ADC channels are described using standard firmware child nodes. Both
single-ended and differential channels are supported. Since the
differential enable bit is global in the controller, mixed single-ended
and differential buffered scans are rejected.

DMA support is intentionally not included in this initial version. The
driver uses the interrupt-driven conversion path to keep the first
upstream submission small and easier to review.

Patch 1 adds the devicetree binding.
Patch 2 adds the MA35D1 EADC IIO driver.

Chi-Wen Weng (2):
  dt-bindings: iio: adc: Add Nuvoton MA35D1 EADC
  iio: adc: Add Nuvoton MA35D1 EADC driver

 .../bindings/iio/adc/nuvoton,ma35d1-eadc.yaml | 100 +++
 drivers/iio/adc/Kconfig                       |  10 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/ma35d1_eadc.c                 | 636 ++++++++++++++++++
 4 files changed, 747 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/nuvoton,ma35d1-eadc.yaml
 create mode 100644 drivers/iio/adc/ma35d1_eadc.c

-- 
2.25.1

