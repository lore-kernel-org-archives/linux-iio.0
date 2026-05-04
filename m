Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3F538838B;
	Mon,  4 May 2026 09:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777888115; cv=none; b=JhnIokUTPGiZHDXpOaM0yqL2Oj5kug/LII23udWZCfVyFvMbGmnEBo/Vr/RZ4KIkYVOjG1P2M+nOVfeixx4hZiDAX2Ywry0p9HJNAHjRtPAHhqL2yu2sKmZGBYT2Yen3QAVlES1vDxJUUbeDEfktmLneDkK21zcKG3J0kU2R8LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777888115; c=relaxed/simple;
	bh=IUZnifWjWiVaH9oOBO9Q0EXpmXHpyJvQ2zdlulvn7eM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZIWInyh5lUe1PcyvOzGGBSgmA89o+gDU6SP1VIN07b9yB8lJZYr/qIEfcPUxAy1kzwvu4CJgIEORV/+8/yfWBDl/7kTZq6b4Ynz+ch0siTLQeVlsoSC2Ns2CLJtGA9HGvAD8aDD1VnDNDoDII+z9fp1cRUE4ejy02D3lmsBJyF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DBYo3nX1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DBYo3nX1"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B14C5C2BCB9;
	Mon,  4 May 2026 09:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777888114;
	bh=IUZnifWjWiVaH9oOBO9Q0EXpmXHpyJvQ2zdlulvn7eM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=DBYo3nX1GSfuaWTiQ2jefdLdsxkp5uCDT9fF6WYWKexLFWyViFbL81Labs9f/Vj4U
	 zD0aUG2Noz4loHQx1pZ2G9ygmCdFMqibs7gd6mlJOj0WrdZDvNyImsUZO4qZewJ5io
	 Wy4JGPy7c0UeqYmFH2/9HTl03cg3VeVR8qN4KZVHkS1RLOwIcy2fskIoJEkByZBRn2
	 jQcIwsGpLB5XZImJUHautzhSBEytZDxHdYQo1dCgEeD7q3vdtq++JNHtTfhxEbP4W9
	 5+iR3aoJJn3Q4STrfxfG66Q5DQFyZI7FpZQv9/zGMm0VtNPMDou+JewcP77wV/lG2N
	 YZpX7z4PXCSQw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A407AFF885A;
	Mon,  4 May 2026 09:48:34 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Mon, 04 May 2026 11:48:14 +0200
Subject: [PATCH v4 02/17] iio: magnetometer: ak8975: update headers per
 IWYU principle
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-magnetometer-fixes-v4-2-a291c2a7c71a@gmail.com>
References: <20260504-magnetometer-fixes-v4-0-a291c2a7c71a@gmail.com>
In-Reply-To: <20260504-magnetometer-fixes-v4-0-a291c2a7c71a@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777888111; l=1776;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=BdAwGxFbW7o2amP8FH9H+4YQxsDM8p5KHZL35H1tc4w=;
 b=gCXO8QDFJElmD8P9ntRVSiZLMIYN8dNWWacyJf210PxdmVwIlpTOt5TFyWw8chMlsh2RThDb4
 0rWRC8dyGPyDT0iEprTHYtWmrh/+xPmkbg8KKB2YFLNm16I0+5+iDrr
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=Xd+UVoRPiiI0K3LHQ2XIcXmO0jvVuFTv9eTx3lgBphI=
X-Endpoint-Received: by B4 Relay for joshua.crofts1@gmail.com/20260422 with
 auth_id=746
X-Original-From: Joshua Crofts <joshua.crofts1@gmail.com>
Reply-To: joshua.crofts1@gmail.com

From: Joshua Crofts <joshua.crofts1@gmail.com>

Remove kernel.h proxy header and unused headers (slab.h, iio/sysfs.h,
iio/trigger.h). Add missing headers to ensure atomicity (array_size.h,
dev_printk.h, asm/byteorder.h, irqreturn.h, minmax.h, property.h,
types.h, wait.h).

Audited using the include-what-you-use tool.

Co-developed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/magnetometer/ak8975.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 569cd6fa839aec6ee8758a261d0e659fc20131c6..dac0a90c33eebd43f8aeed846c9cbf5fd1a6ab91 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -7,24 +7,29 @@
  * Copyright (c) 2010, NVIDIA Corporation.
  */
 
+#include <linux/array_size.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
+#include <linux/dev_printk.h>
 #include <linux/err.h>
 #include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
-#include <linux/kernel.h>
+#include <linux/iopoll.h>
+#include <linux/minmax.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/pm_runtime.h>
+#include <linux/property.h>
 #include <linux/regulator/consumer.h>
-#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/wait.h>
+
+#include <asm/byteorder.h>
 
 #include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
-#include <linux/iio/sysfs.h>
-#include <linux/iio/trigger.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
 

-- 
2.47.3


