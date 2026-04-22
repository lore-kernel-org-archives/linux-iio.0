Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B853563EB;
	Wed, 22 Apr 2026 14:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776869185; cv=none; b=H8zvalvHYWxl5kgb5oBUjgOexClds1BUtk4sCRpbxwFSkTQJjPrw8eVMjWrfQI0SETMRYy/bNEMFuGJCCmW14bra2enXnOO25CoKkny3BNscVMyZxggKO+YwGS3HOp6n5aP/FahXU4pNhV1PIebUWVZhRQ+c2PnUxb1BdmF7sqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776869185; c=relaxed/simple;
	bh=FJG8SonoGio8LwT7T00CqDcGH3iQXLHfoc+nen1ZNoI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FeMV/NI/g/4zGm2sSKCJgBBjA+upAVWIfNm1PoM6BNMyQP0qmqRSfavFLo/iaHLWpzEQNInuE1Rsp7Y3gWt+7/wIJEHuWc/ZqNuEyJS6R5Ncyd3JbL8MwC5U/bmaJm2Euwc5IXDC5DPlEWhVkZtNGv4uiMdc57uk2xrKySK7Ji4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=agJb0hBH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="agJb0hBH"
Received: by smtp.kernel.org (Postfix) with ESMTPS id EF471C2BCC9;
	Wed, 22 Apr 2026 14:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776869185;
	bh=FJG8SonoGio8LwT7T00CqDcGH3iQXLHfoc+nen1ZNoI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=agJb0hBHb4yZM6SunUBHX9Siw2o5lKeBUALbfUHtJO2xQsgV+iHqS9MxiwzhBKVBQ
	 WwEoc4DamrQ4hpa7dsuF/XcwDZjoF3Lx51WwnbSLiCjZKvlFmyvlL3ye2zyXSs2G5n
	 FiuiAu3kZdQOFK5moBQm+soenu7s15j0VvP+Ga+JBxLcyDy5fFU1wt+rdLpCnzXZsb
	 XF8opm0B2ZqmLwgSTOGNLAn62iYmjgPEqxUgUuhIKy33/tUb1yK0WhgcYlN2cAGjoQ
	 FffKhsY6fQHyUxwFEK3BbHZRMIgvU5Gpnl0qpaaPD1HUS+1Wry2UpHGy0etklMC6pP
	 le6elE0Zzf3zA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E78BAF9EDF7;
	Wed, 22 Apr 2026 14:46:24 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Wed, 22 Apr 2026 15:45:51 +0100
Subject: [PATCH 17/22] iio: dac: ad5686: update device list description
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-ad5313r-iio-support-v1-17-ed7dca001d1b@analog.com>
References: <20260422-ad5313r-iio-support-v1-0-ed7dca001d1b@analog.com>
In-Reply-To: <20260422-ad5313r-iio-support-v1-0-ed7dca001d1b@analog.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Auchter <michael.auchter@ni.com>, linux-hardening@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776869181; l=4131;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=6Itx5hy1mvB2bOEpnWldN5TFmPMjDDFuSdP09yLPaJw=;
 b=hx77HXvPzwJU7vo8vGaU4D/eefLuopDVNxdnxF3JVkfTFkGsTVywbh8Xp8uYFrTbzaB2/rr7v
 d2Rwkvie3wDCLMi4Nl5mTdltNknMmQ26qLWEGmsIHnjBOZ8nT7U3I1S
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Update device list entries from comment headers for both SPI and I2C
driver files and under Kconfig help text. Adjust comment header for the
core file as supported devices are listed elsewhere. Also update Copyright
notice in comment file headers with the current year.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/dac/Kconfig      | 16 +++++++++-------
 drivers/iio/dac/ad5686-spi.c |  8 ++++----
 drivers/iio/dac/ad5686.c     |  4 ++--
 drivers/iio/dac/ad5696-i2c.c |  7 ++++---
 4 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index cd4870b65415..8ef4a87d6d6a 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -235,9 +235,11 @@ config AD5686_SPI
 	depends on SPI
 	select AD5686
 	help
-	  Say yes here to build support for Analog Devices AD5672R, AD5674R,
-	  AD5676, AD5676R, AD5679R, AD5684, AD5684R, AD5684R, AD5685R, AD5686,
-	  AD5686R Voltage Output Digital to Analog Converter.
+	  Say yes here to build support for Analog Devices AD5310R, AD5313R,
+	  AD5317R, AD5672R, AD5674, AD5674R, AD5676, AD5676R, AD5679, AD5679R,
+	  AD5681R, AD5682R, AD5683, AD5683R, AD5684, AD5684R, AD5685R, AD5686,
+	  AD5686R, AD5687, AD5687R, AD5689, AD5689R Voltage Output
+	  Digital to Analog Converter.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad5686.
@@ -247,10 +249,10 @@ config AD5696_I2C
 	depends on I2C
 	select AD5686
 	help
-	  Say yes here to build support for Analog Devices AD5311R, AD5337,
-	  AD5338R, AD5671R, AD5673R, AD5675R, AD5677R, AD5691R, AD5692R, AD5693,
-	  AD5693R, AD5694, AD5694R, AD5695R, AD5696, and AD5696R Digital to
-	  Analog converters.
+	  Say yes here to build support for Analog Devices AD5311R, AD5316R,
+	  AD5338R, AD5671R, AD5673R, AD5675, AD5675R, AD5677R, AD5691R, AD5692R,
+	  AD5693, AD5693R, AD5694, AD5694R, AD5695R, AD5696, AD5696R, AD5697R
+	  Digital to Analog converters.
 
 	  To compile this driver as a module, choose M here: the module will be
 	  called ad5696.
diff --git a/drivers/iio/dac/ad5686-spi.c b/drivers/iio/dac/ad5686-spi.c
index b57dc88eb953..ebfc40efa679 100644
--- a/drivers/iio/dac/ad5686-spi.c
+++ b/drivers/iio/dac/ad5686-spi.c
@@ -1,11 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * AD5672R, AD5674R, AD5676, AD5676R, AD5679R,
- * AD5681R, AD5682R, AD5683, AD5683R, AD5684,
- * AD5684R, AD5685R, AD5686, AD5686R
+ * AD5310R, AD5313R, AD5317R, AD5672R, AD5674, AD5674R, AD5676, AD5676R,
+ * AD5679, AD5679R, AD5681R, AD5682R, AD5683, AD5683R, AD5684, AD5684R,
+ * AD5685R, AD5686, AD5686R, AD5687, AD5687R, AD5689, AD5689R
  * Digital to analog converters driver
  *
- * Copyright 2018 Analog Devices Inc.
+ * Copyright 2018-2026 Analog Devices Inc.
  */
 
 #include <asm/byteorder.h>
diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index bb661d985626..cfbc1624e01c 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * AD5686R, AD5685R, AD5684R Digital to analog converters  driver
+ * Core driver for AD5686R and similar Digital to analog converters
  *
- * Copyright 2011 Analog Devices Inc.
+ * Copyright 2011-2026 Analog Devices Inc.
  */
 
 #include <linux/array_size.h>
diff --git a/drivers/iio/dac/ad5696-i2c.c b/drivers/iio/dac/ad5696-i2c.c
index 8fb9da7fde1f..e75c5f8c65aa 100644
--- a/drivers/iio/dac/ad5696-i2c.c
+++ b/drivers/iio/dac/ad5696-i2c.c
@@ -1,10 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * AD5338R, AD5671R, AD5673R, AD5675R, AD5677R, AD5691R, AD5692R, AD5693,
- * AD5693R, AD5694, AD5694R, AD5695R, AD5696, AD5696R
+ * AD5311R, AD5316R, AD5338R, AD5671R, AD5673R, AD5675, AD5675R, AD5677R,
+ * AD5691R, AD5692R, AD5693, AD5693R, AD5694, AD5694R, AD5695R, AD5696,
+ * AD5696R, AD5697R
  * Digital to analog converters driver
  *
- * Copyright 2018 Analog Devices Inc.
+ * Copyright 2018-2026 Analog Devices Inc.
  */
 
 #include <asm/byteorder.h>

-- 
2.43.0


