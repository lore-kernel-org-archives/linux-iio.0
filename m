Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3750477E40
	for <linux-iio@vger.kernel.org>; Wed,  1 Apr 2026 16:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775060759; cv=none; b=M4VAgBUbPKKpYiKLQ9Bb64qwJyYfjyqzul60MOuzGlk/xKA/wvYN7N+xlrq/CeGHy1JK8RMHnxpi5AUojHqFFHx40SKTtBX4B2tpqSq3WfzCoz8NNL1n4WfOUlqDiwh1Vzj7tc1Vc9Ye3avXaDFBJPGkvs50LNTSz1EyVDqJIH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775060759; c=relaxed/simple;
	bh=/qWO8KI3tIBC0cjksLyab/irCOuK5UlJOac1HvRs0AA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lEfpUsNP/1VRjOe0AGCgtf4pC6hlgB1Vvpy4rw/m/LEjNqdn3GW+N+hn9SRR7FuyJO+LPnvvDTLtBz/8HZzv2tG2HOzsgB2jdbOODyBzl0q8FE7hzTSsNeVTTtR/r9qsQNiHtTKFIN9oTulepqERhf9ofHv8K3bS3zxRcYskieY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mirrorstack.ai; spf=none smtp.mailfrom=mirrorstack.ai; dkim=pass (2048-bit key) header.d=mirrorstack-ai.20230601.gappssmtp.com header.i=@mirrorstack-ai.20230601.gappssmtp.com header.b=ATBneXj3; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mirrorstack.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mirrorstack.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mirrorstack-ai.20230601.gappssmtp.com header.i=@mirrorstack-ai.20230601.gappssmtp.com header.b="ATBneXj3"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-35dac556bb2so2238405a91.1
        for <linux-iio@vger.kernel.org>; Wed, 01 Apr 2026 09:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mirrorstack-ai.20230601.gappssmtp.com; s=20230601; t=1775060749; x=1775665549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SmuFDt4ssXwo5Kn+8E+MCnCyQLezwxIlCE02tQ8Pv3k=;
        b=ATBneXj3E3SGVicK5Q1/mXuKr3nxxMbcAUDFKV3l2XAw09+MfkQ08kdCr6S0XkWPN1
         YJMyWq/P73TKvyq7o0qfwKkr7bQbF0FfpfJpU7u/jC7Wa5yXrQPSnNq3xsXMdRkuyYPj
         xR2b+zDfkbFlhtZPf0sPTVS5oL/PWAWTX6rOWkNJ8ZgTtWiEy90IJz/SZczCV6whgWbV
         CNeO/3ZbyZKzUQzbvxrSbxl0JgbAoVxMEeh8AKYbylSvR8pUDa4+JSuR2gohK2aF7wLn
         D050nUCLjJjz+ufi+uGXYKdUn9AJ/FNjlrXFxcbgRQwtTGdxcjJj69+iSWT16Io+GnGC
         WUUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775060749; x=1775665549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SmuFDt4ssXwo5Kn+8E+MCnCyQLezwxIlCE02tQ8Pv3k=;
        b=kkVFYDtBwV2rNKbrR0OVqQZoYU9rs5JEr/QeXDeQR9coCdNq8tZDgvAzl0VWgHEwaH
         jexXTfg6fdl1g29gHfY9TuX+dVDV8EAtqu4nb8sKTyfU/6zV+w73W8quvV7FnFdmKUfi
         GZSuDkXQgCwZQAmrUzUzSVmki2tf9auEEM2NCq0D2BfwuRGQla3B+Duy4fCapuYp1jZn
         A/nX8O9i8WRN3sOTlgF1wXug4O02rTHyhU9dtFymc6o6NdBINKd/n695yJ+0V1MzmDF0
         qWItCCHmmpLiycuHOZCnhojvNkgf8hFvV5QTVYiO38Z+4YiJyWoiXCAH0I6Np6UJPqNl
         //Yw==
X-Forwarded-Encrypted: i=1; AJvYcCVz7URBWMTkHcLQHIzn+ykcbI2czTLXlI5TEotBxelltBlBU5Pmawq9A03PedLmwR+gA1f1ZEUO2vA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTOYcjRucw0KPm8kWTU3PbclmgMCnDNcK0E7dmXRSh22bmT5bs
	H/8i6pjO89l9P3fBZz1jc9xxS2sW02kWeIBpFtw8NpSQl+TaUsfRU5ggDBeh4T3tPog4
X-Gm-Gg: ATEYQzwXap8QwZU41N1Ae0iz6Nn4+Oouf7tJAC/hrFTJMNlz4Z1DtZ6dWQoHCweXpPc
	h5oOBYcmhTTVe00xfG+O7cTjzszpfdOh0icNFE1pe1gzLvMIkeW2I76UmFrJ+7s90HOFFyvG1aX
	XKetL2fCHRd9U6JiBE2sXeGVm92MwmDQ5wkHw4le2A1ESkJyZgZn3BlFcMpgVEPXa9NKa1C1XNJ
	kIgHOrW6G5uhTkUEL9vzJ59l34LP2Ykhr4FKog+elwDpirKl/h1okPjL9OS/nHh9496K4L/xuM2
	oMfHhHMgRu5nwBweZEgMOBkQTARs7Vqxgpug8OkPKu2ylkciNQmLbf1ZU/cdhPUT9gekLxlITD9
	gJqvBv/xPidUMFz8DfZdCwkRoc7RWLSQ4So0SJmXxOyi51Yi6kq50BsTINE+YqTE7DNwICmJPFQ
	Rxax9O6wQx9mBIOd5a5QtYZxwBNgTClG7mBsef3tLHu2VbYQzm7/bUpLfdsoEsUDUowH8uENP6F
	/dYticrXU7QmzuPoyWtMvLX5fbIizk0KjAJVE7ajw==
X-Received: by 2002:a17:90b:3f44:b0:354:a57c:65db with SMTP id 98e67ed59e1d1-35dc6f0128amr3633041a91.20.1775060749484;
        Wed, 01 Apr 2026 09:25:49 -0700 (PDT)
Received: from ip-172-26-8-186.ap-northeast-1.compute.internal ([2406:da14:e8:bc00:e546:17ee:7142:6d05])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dd35e34eesm281813a91.2.2026.04.01.09.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 09:25:48 -0700 (PDT)
From: Sheng Kun Chang <nothingchang@mirrorstack.ai>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	gregkh@linuxfoundation.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sheng Kun Chang <nothingchang@mirrorstack.ai>
Subject: [PATCH 3/3] iio: accel: move adis16203 out of staging
Date: Wed,  1 Apr 2026 16:24:57 +0000
Message-ID: <20260401162458.88110-4-nothingchang@mirrorstack.ai>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260401162458.88110-1-nothingchang@mirrorstack.ai>
References: <20260401162458.88110-1-nothingchang@mirrorstack.ai>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The adis16203 driver uses standard IIO channel interfaces, devm
managed APIs, and has no remaining code quality issues. Move it
from drivers/staging/iio/accel/ to drivers/iio/accel/ and remove
the now-empty staging accel directory.

Signed-off-by: Sheng Kun Chang <nothingchang@mirrorstack.ai>
---
 drivers/iio/accel/Kconfig                   | 12 ++++++++++++
 drivers/iio/accel/Makefile                  |  1 +
 drivers/{staging => }/iio/accel/adis16203.c |  0
 drivers/staging/iio/Kconfig                 |  1 -
 drivers/staging/iio/Makefile                |  1 -
 drivers/staging/iio/accel/Kconfig           | 19 -------------------
 drivers/staging/iio/accel/Makefile          |  6 ------
 7 files changed, 13 insertions(+), 27 deletions(-)
 rename drivers/{staging => }/iio/accel/adis16203.c (100%)
 delete mode 100644 drivers/staging/iio/accel/Kconfig
 delete mode 100644 drivers/staging/iio/accel/Makefile

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index 3d3f8d867..2d8abec49 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -18,6 +18,18 @@ config ADIS16201
 	  To compile this driver as a module, say M here: the module will
 	  be called adis16201.
 
+config ADIS16203
+	tristate "Analog Devices ADIS16203 Programmable 360 Degrees Inclinometer"
+	depends on SPI
+	select IIO_ADIS_LIB
+	select IIO_ADIS_LIB_BUFFER if IIO_BUFFER
+	help
+	  Say Y here to build support for Analog Devices adis16203 Programmable
+	  360 Degrees Inclinometer.
+
+	  To compile this driver as a module, say M here: the module will
+	  be called adis16203.
+
 config ADIS16209
 	tristate "Analog Devices ADIS16209 Dual-Axis Digital Inclinometer and Accelerometer"
 	depends on SPI
diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
index fa440a859..eaf8ce443 100644
--- a/drivers/iio/accel/Makefile
+++ b/drivers/iio/accel/Makefile
@@ -5,6 +5,7 @@
 
 # When adding new entries keep the list in alphabetical order
 obj-$(CONFIG_ADIS16201) += adis16201.o
+obj-$(CONFIG_ADIS16203) += adis16203.o
 obj-$(CONFIG_ADIS16209) += adis16209.o
 obj-$(CONFIG_ADXL313) += adxl313_core.o
 obj-$(CONFIG_ADXL313_I2C) += adxl313_i2c.o
diff --git a/drivers/staging/iio/accel/adis16203.c b/drivers/iio/accel/adis16203.c
similarity index 100%
rename from drivers/staging/iio/accel/adis16203.c
rename to drivers/iio/accel/adis16203.c
diff --git a/drivers/staging/iio/Kconfig b/drivers/staging/iio/Kconfig
index a60631c1f..bf6addf29 100644
--- a/drivers/staging/iio/Kconfig
+++ b/drivers/staging/iio/Kconfig
@@ -5,7 +5,6 @@
 menu "IIO staging drivers"
 	depends on IIO
 
-source "drivers/staging/iio/accel/Kconfig"
 source "drivers/staging/iio/adc/Kconfig"
 source "drivers/staging/iio/addac/Kconfig"
 source "drivers/staging/iio/frequency/Kconfig"
diff --git a/drivers/staging/iio/Makefile b/drivers/staging/iio/Makefile
index 628583535..739e4cbf9 100644
--- a/drivers/staging/iio/Makefile
+++ b/drivers/staging/iio/Makefile
@@ -3,7 +3,6 @@
 # Makefile for the industrial I/O core.
 #
 
-obj-y += accel/
 obj-y += adc/
 obj-y += addac/
 obj-y += frequency/
diff --git a/drivers/staging/iio/accel/Kconfig b/drivers/staging/iio/accel/Kconfig
deleted file mode 100644
index cee51f64b..000000000
--- a/drivers/staging/iio/accel/Kconfig
+++ /dev/null
@@ -1,19 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-#
-# Accelerometer drivers
-#
-menu "Accelerometers"
-
-config ADIS16203
-	tristate "Analog Devices ADIS16203 Programmable 360 Degrees Inclinometer"
-	depends on SPI
-	select IIO_ADIS_LIB
-	select IIO_ADIS_LIB_BUFFER if IIO_BUFFER
-	help
-	  Say Y here to build support for Analog Devices adis16203 Programmable
-	  360 Degrees Inclinometer.
-
-	  To compile this driver as a module, say M here: the module will be
-	  called adis16203.
-
-endmenu
diff --git a/drivers/staging/iio/accel/Makefile b/drivers/staging/iio/accel/Makefile
deleted file mode 100644
index acac7bc9b..000000000
--- a/drivers/staging/iio/accel/Makefile
+++ /dev/null
@@ -1,6 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-#
-# Makefile for industrial I/O accelerometer drivers
-#
-
-obj-$(CONFIG_ADIS16203) += adis16203.o
-- 
2.43.0

