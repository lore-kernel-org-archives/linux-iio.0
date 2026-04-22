Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7860D32C924;
	Wed, 22 Apr 2026 14:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776869184; cv=none; b=GHl1/IIoD6XVhbccXOZnkdDvRvsdJAiMnKxAPmajm40k9AlC/kciV43mU0ZaYm9e0Vlz+YKT2PSLrx2ge4xS7GZWiRg5bjZbiH9ovZyd+Uxu0GO8Y3dMSjnhoHIdymSBU2qa1yfprGtEygwis+OWfXgDHX6oFf5drUH7MG7xENk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776869184; c=relaxed/simple;
	bh=l+N2eTpdCf7SDD+ccsaQ4RMwN1LY4hOleoPt5R0zvgM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NmEJ6vipMo50TLp4C5exC6dz3Vj3v/fsdsrGqJH6OY/64uYlhQJ8vtU0VkUy9wXWWQrmGMsm6QCgtb+ezdO/XUvGlUESgNc2fCDgOl3ZgXpua4x3/o8fhaQLuN/Uq5C/VJLAQCra+d++o8XqB/0yMxdD8+4X6rTE7FXuL4aPMHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cPctFswy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cPctFswy"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3D810C2BCFA;
	Wed, 22 Apr 2026 14:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776869184;
	bh=l+N2eTpdCf7SDD+ccsaQ4RMwN1LY4hOleoPt5R0zvgM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=cPctFswya3Op/IZD7IAmz9WIGDkgsI9sYsbmcSppfgRucoYVGLJqrpkTlqHwoE7om
	 rdlzSiRsZG6BU6RAXtrY68xz1HYXtltQD2QFzLY/l6Di5egJ2Tfneg8NDXnnEgioIO
	 ZccikrhILe194ELbu3Rji/MIAr35AMPrT/BcH/GcY9Z3SXGE9FzUea2ypmuwVlbayG
	 U+um1habYfIX+bJkHt7e/fEZSUktY5GqGOT7C8uV42K5HcUs4PsdUNlBa8qf6RCAiK
	 7mfHfzmPxoyIkiBdFdcTFEvsDnPZrX3GvMy+wSh05u0Y0paIuO8px+IFYxW2jeSAb8
	 n3WKBq2R729Jg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3497CF9EDEB;
	Wed, 22 Apr 2026 14:46:24 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Wed, 22 Apr 2026 15:45:41 +0100
Subject: [PATCH 07/22] iio: dac: ad5686: refactor include headers
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-ad5313r-iio-support-v1-7-ed7dca001d1b@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776869181; l=2739;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=6tt5M1kuQh7zLk0nCE7kXKPrQzBvjK2aZ4Ndo8TiE2w=;
 b=Du8u4IVD/tTMb/rLnXhyQEMXCVQy6QWhra+qgP4VdWZW/2KoscdYbVaYt+bNLzhpFVcYZL0jI
 8xPhOzMl9R7Bf3qxi4jxXrJAqCu1keF/YgBQSmxTFnYcCyiecRJCECO
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Apply IWYU principle, replacing unused/generic headers for
specific/missing headers. The resulting include directive list is sorted
accordingly.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/dac/ad5686-spi.c |  8 ++++++--
 drivers/iio/dac/ad5686.c     | 13 ++++---------
 drivers/iio/dac/ad5686.h     |  5 ++---
 drivers/iio/dac/ad5696-i2c.c |  9 ++++++---
 4 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/dac/ad5686-spi.c b/drivers/iio/dac/ad5686-spi.c
index df8619e0c092..b4df06f6bf02 100644
--- a/drivers/iio/dac/ad5686-spi.c
+++ b/drivers/iio/dac/ad5686-spi.c
@@ -8,11 +8,15 @@
  * Copyright 2018 Analog Devices Inc.
  */
 
-#include "ad5686.h"
-
+#include <asm/byteorder.h>
+#include <linux/array_size.h>
+#include <linux/err.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/spi/spi.h>
 
+#include "ad5686.h"
+
 static int ad5686_spi_write(struct ad5686_state *st,
 			    u8 cmd, u8 addr, u16 val)
 {
diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index 9a384c50929b..1a6eb3832f22 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -5,17 +5,12 @@
  * Copyright 2011 Analog Devices Inc.
  */
 
-#include <linux/interrupt.h>
-#include <linux/fs.h>
-#include <linux/device.h>
+#include <linux/array_size.h>
+#include <linux/err.h>
+#include <linux/export.h>
 #include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/sysfs.h>
 #include <linux/regulator/consumer.h>
-
-#include <linux/iio/iio.h>
-#include <linux/iio/sysfs.h>
+#include <linux/sysfs.h>
 
 #include "ad5686.h"
 
diff --git a/drivers/iio/dac/ad5686.h b/drivers/iio/dac/ad5686.h
index e7d36bae3e59..3fcc792ea656 100644
--- a/drivers/iio/dac/ad5686.h
+++ b/drivers/iio/dac/ad5686.h
@@ -8,10 +8,9 @@
 #ifndef __DRIVERS_IIO_DAC_AD5686_H__
 #define __DRIVERS_IIO_DAC_AD5686_H__
 
-#include <linux/types.h>
-#include <linux/cache.h>
+#include <linux/bits.h>
 #include <linux/mutex.h>
-#include <linux/kernel.h>
+#include <linux/types.h>
 
 #include <linux/iio/iio.h>
 
diff --git a/drivers/iio/dac/ad5696-i2c.c b/drivers/iio/dac/ad5696-i2c.c
index d3327bca0e07..587f53228bae 100644
--- a/drivers/iio/dac/ad5696-i2c.c
+++ b/drivers/iio/dac/ad5696-i2c.c
@@ -7,10 +7,13 @@
  * Copyright 2018 Analog Devices Inc.
  */
 
-#include "ad5686.h"
-
-#include <linux/module.h>
+#include <asm/byteorder.h>
+#include <linux/err.h>
 #include <linux/i2c.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+
+#include "ad5686.h"
 
 static int ad5686_i2c_read(struct ad5686_state *st, u8 addr)
 {

-- 
2.43.0


