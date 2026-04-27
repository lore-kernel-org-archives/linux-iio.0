Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6A4306B37;
	Mon, 27 Apr 2026 11:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777289411; cv=none; b=c/JtCCx4udoFfXP6cpp0Npl5o72tfRvwMmsmbtjzYIsC6FIkVP5SArTdJYEtSYkgQzrJoipR0tNpawfeBpnRlJBkFiEQYLRkHfvfClBSFzYcpm0idAIiC/36Ly/45xlXNpHfrvOoo52TurEUqjs1pRWbfYuGicUsXgHbFFvKcbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777289411; c=relaxed/simple;
	bh=to1DlBvvsDfODvKTGcPUX3C16OWZxp1KCwh1nPJ9t1I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FmoXb+z0p/6S1yEwquj3yP/4AtCHLuS/JEcOw9lqnCrBvyC15bD/zfrnPWD2Sim5MwzGmi1vCGTVv+xu6rS1e8cxGZHEVRSJMyT7Q9Ma80AoKdvUP+hbhqwjcM0YUCEZJqQBnxB7D+sWiedym5h67nDXfUgCYqLnwVgsGtDKE0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fsUgDUPs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fsUgDUPs"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3E6BCC2BCF6;
	Mon, 27 Apr 2026 11:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777289411;
	bh=to1DlBvvsDfODvKTGcPUX3C16OWZxp1KCwh1nPJ9t1I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=fsUgDUPsqps4laWhqwcL9g5rPcADhgtivBPDAHh80SbxgVFSW59Jta6adg7ooQ9rB
	 MJ4n10+4CsMZfHBYjNpNBaXzNR7tMxm7QoZm/7hXWJilRGU0oyClhP9/UTd0Lh2gg6
	 vjztD7bhPSR6RdLC3kbrw4EwAGlo8rXi0zNaaBflP1t34M6S3tLchJt8HUHqKyoe+X
	 Mcj5WEesnx+b5sQXaS0Bc26041a1ao05W12YitTORURekH4edjDtvGnakHSF0WkzO2
	 5FhCzDFzmHLgRqEJ7t55Tf5TKgOdDJ2UJm3Bh0k1FuYzpE4smqXsJcmI+N312GdOaX
	 igL317ZiLPSoQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359E5FF8860;
	Mon, 27 Apr 2026 11:30:11 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Mon, 27 Apr 2026 12:30:12 +0100
Subject: [PATCH v2 05/11] iio: dac: ad5686: refactor include headers
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-ad5686-fixes-v2-5-188e05199368@analog.com>
References: <20260427-ad5686-fixes-v2-0-188e05199368@analog.com>
In-Reply-To: <20260427-ad5686-fixes-v2-0-188e05199368@analog.com>
To: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Stefan Popa <stefan.popa@analog.com>, Jonathan Cameron <jic23@cam.ac.uk>, 
 Greg Kroah-Hartman <gregkh@suse.de>, 
 Michael Auchter <michael.auchter@ni.com>, 
 Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777289409; l=2747;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=23N6CMy0ZGzlml35g5mJ5f2Y96WQ2ZUtKNwc+4DLMxE=;
 b=sug1Sc68YYrTulNLjgKeXlu7sVqCuS6Tok+wbtGvrByxSqrYGutuamKFKMPb12Sb0JxUIwO09
 vGXXNenO1MyA8hUAVgu8IDgv3l/158DRX7GX22GqSUXejdiXiifZndh
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Apply IWYU principle, replacing unused/generic headers for
specific/missing headers. The resulting include directive lists are sorted
accordingly.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/dac/ad5686-spi.c |  9 +++++++--
 drivers/iio/dac/ad5686.c     | 11 ++++-------
 drivers/iio/dac/ad5686.h     |  5 ++---
 drivers/iio/dac/ad5696-i2c.c | 10 +++++++---
 4 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/dac/ad5686-spi.c b/drivers/iio/dac/ad5686-spi.c
index df8619e0c092..695125238633 100644
--- a/drivers/iio/dac/ad5686-spi.c
+++ b/drivers/iio/dac/ad5686-spi.c
@@ -8,11 +8,16 @@
  * Copyright 2018 Analog Devices Inc.
  */
 
-#include "ad5686.h"
-
+#include <linux/array_size.h>
+#include <linux/err.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/spi/spi.h>
 
+#include <asm/byteorder.h>
+
+#include "ad5686.h"
+
 static int ad5686_spi_write(struct ad5686_state *st,
 			    u8 cmd, u8 addr, u16 val)
 {
diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index 04a5568f2cbe..2c1692097c0c 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -5,17 +5,14 @@
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
+#include <linux/sysfs.h>
 
 #include <linux/iio/iio.h>
-#include <linux/iio/sysfs.h>
 
 #include "ad5686.h"
 
diff --git a/drivers/iio/dac/ad5686.h b/drivers/iio/dac/ad5686.h
index 36e16c5c4581..d08160e7fad9 100644
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
index d3327bca0e07..e7e1b8a6fc71 100644
--- a/drivers/iio/dac/ad5696-i2c.c
+++ b/drivers/iio/dac/ad5696-i2c.c
@@ -7,10 +7,14 @@
  * Copyright 2018 Analog Devices Inc.
  */
 
-#include "ad5686.h"
-
-#include <linux/module.h>
+#include <linux/err.h>
 #include <linux/i2c.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+
+#include <asm/byteorder.h>
+
+#include "ad5686.h"
 
 static int ad5686_i2c_read(struct ad5686_state *st, u8 addr)
 {

-- 
2.43.0


