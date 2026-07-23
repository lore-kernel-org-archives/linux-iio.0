Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D544331BCAE;
	Thu, 23 Jul 2026 13:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784814214; cv=none; b=CWB7nvaz0z3DclTz8s2eSxMLaFhLnG8nSAhyImG2yq2RGRaaWlRNyBld/e9Rj4X0XVuFIhAmzqKWsfzEgM+HNNa2Z/2RjfKwbkmc3c+f8hTcYYFOUalMREdf96I3b6bHZ5u/EQn1aUmblNvG1irSqIq5o+jQYVrN78OaFJI1hB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784814214; c=relaxed/simple;
	bh=pRiFsjgl+9IjYcAApCKzY3sYh6DSc8+q0kdaRt3M0rw=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=Oczo/hAphsZDKwpFxgHp8N/pT7Gb5Oe6xUCsCPBKL6zpzGJQyq4jAkvKSIvVrEue0mICpXrhCAt2BfqEKO4BjDL/Q725/TgpWMUA7DeAB7l8Rvzfu7lpSK6DuJ0ZdlYzxIlMwQQEdfmS4G5yZJuZfmbxPmSjP07IzOWxqBgsw9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=W+OufMrO; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="W+OufMrO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1784814213; x=1816350213;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=pRiFsjgl+9IjYcAApCKzY3sYh6DSc8+q0kdaRt3M0rw=;
  b=W+OufMrOLAdJvUxF7BbK4J5PMRYBUcW9IdaXW1qnK39WXrrYlQyXDYwu
   iNimLqDyduYgAcSNlerqdl4FyATaAWJ0LWE8kjIbwXbHIzB2rn2E6KKAI
   3n2A2dqx2mYAbfwUMvJ3IwqHNfNQti4PYIu04zxgjMH0aHj+p3JP8SUDo
   RVsqXSmALqxLqLHR1Vekat7C1Cm8smbV10xifJGLAWc2L8vpU8tzyh+13
   /Xe1vN4uLQYPRSrH3pueObMzm1zm32I/CoRpyxnw+i7rLBdyTBDGYDmgP
   c4WGgNHy7lkLBm8R5sjUEmqWBY/9PcB76V52LvLf3FPqIY1MfgZMTNCVb
   g==;
X-CSE-ConnectionGUID: 24N+Dl64Swqx6stchVBlxQ==
X-CSE-MsgGUID: ZIgOZz2oQLaoh8j0DhsmaA==
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; 
   d="scan'208";a="228212209"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 06:43:25 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.43; Thu, 23 Jul 2026 06:43:16 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Thu, 23 Jul 2026 06:43:14 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Subject: [PATCH 0/3] Refactor Microchip MCP47FEB02 I2C driver in separate
 modules to add support for MCP48FEB02 SPI driver
Date: Thu, 23 Jul 2026 16:43:09 +0300
Message-ID: <20260723-mcp47feb02_refactor-v1-0-ee59e63672bc@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG0aYmoC/x2MQQqAIBAAvxJ7TrCtTPpKRJittYcsNCKQ/p50H
 IaZBJECU4S+SBDo5siHz1CVBdjN+JUEL5kBJSqpsBW7PZvO0SxxCuSMvY4gnNENSkM1aoRcntn
 w81+H8X0/7kCo5GUAAAA=
X-Change-ID: 20260625-mcp47feb02_refactor-fa8420ae3282
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Ariana Lazar <ariana.lazar@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784814192; l=1290;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=pRiFsjgl+9IjYcAApCKzY3sYh6DSc8+q0kdaRt3M0rw=;
 b=z005zfroKNfFpemk0xG/keHXBEsKXd6Tv17Qt1zOmg7dSJmDBCWodLM/1D4jc/2aUvilyQMCF
 GLVm8MIPg6vB8PIHD6jw0/GFX5kMfIE0PWF/n2Kjmhf4Ps4NWmYYSLb
X-Developer-Key: i=ariana.lazar@microchip.com; a=ed25519;
 pk=jmvf1fSxcnzZmXfITM3L94IwutM+wqA1POQHiYyD6Dk=

Refactor I2C driver implementation into separate modules in order to add
support for SPI MCP48FxBy1/2/4/8 DAC family on top of the I2C implementation.
The I2C and SPI devices have the same memory map and supported
functionalities.

Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
---
Ariana Lazar (3):
      iio: dac: mcp47feb02: refactor MCP47FEB02 I2C driver into two modules
      dt-bindings: iio: dac: add support for MCP48FEB02 SPI
      iio: dac: add support for Microchip MCP48FEB02

 .../bindings/iio/dac/microchip,mcp47feb02.yaml     | 244 +++++++++---
 MAINTAINERS                                        |   5 +-
 drivers/iio/dac/Kconfig                            |  33 +-
 drivers/iio/dac/Makefile                           |   4 +-
 .../iio/dac/{mcp47feb02.c => mcp47feb02-core.c}    | 414 +--------------------
 drivers/iio/dac/mcp47feb02-i2c.c                   | 145 ++++++++
 drivers/iio/dac/mcp47feb02-spi.c                   | 146 ++++++++
 drivers/iio/dac/mcp47feb02.h                       | 153 ++++++++
 8 files changed, 693 insertions(+), 451 deletions(-)
---
base-commit: 9c6acc6e6555d34198e45cb0d309569dfbadf929
change-id: 20260625-mcp47feb02_refactor-fa8420ae3282

Best regards,
-- 
Ariana Lazar <ariana.lazar@microchip.com>

