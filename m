Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFCE33F394;
	Tue, 28 Apr 2026 17:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777395739; cv=none; b=FWEJ3mc8f8oPP/RBVAG7iSsMKj+IUly0tiN+v2VJgG/iBctBNqsomLThZCIPJEkfwf6OpJ4P5aqR/IcN7TGT2HbFPcUXUX4g3OIUj28nyk95QHAM4WvPL9eET9NK6S1VpHe8QgeCJF/s3nd1oai/fNYMVvD/8arlOA/W16gzW4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777395739; c=relaxed/simple;
	bh=Di0rbJjBZ7+zxgWtmdtHMDMcDJL6I9cq5JtCT0X0Y2w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O7hUBaSdlZ6PePnhLOzXVofNWDtozN3s9vEcfQBYBiPlvfwk3usoUfuZ/3F4gIci8dmTwtL3vKkQbrtuSMYEYX9VVBFcTfp3qaYtCWvbmELoV0HD6QAAANJwjsOYo/vdtPIfoDpRMfNlFlsyfWaSJXdYyquc/1xpFp7rbM26lSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k+S3tcQs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k+S3tcQs"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 18215C2BCF5;
	Tue, 28 Apr 2026 17:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777395739;
	bh=Di0rbJjBZ7+zxgWtmdtHMDMcDJL6I9cq5JtCT0X0Y2w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=k+S3tcQsYdTOnB3jXhGQaxqjZE621cDa3xloWqpznF9kOX45usJZZXbgoxPa8aVQ9
	 tjV5YJgCqQvr+X6FurWXpuaWtc7pxrbYQAP8YrYzFYbgsehgM93RKkpJl8MmUbBPbA
	 nC2fz+99G5IhkDoE1oikqYEzQ+pfIxUrfTMP6rLyXargcgY6xOK33vScoJjWgf3k/3
	 UQkyLaMOWqkNH/POiPJbdGZJ4xt1BPr+twBYpeitTXRmntQ7MXI8iTp4w9D+pGLsGC
	 Xmxwy4euVPZzhjTtpjPkgkxOfj6O/XE1yiSxpl13+WMyqiD2NiEefHWnTYyvE5/uyJ
	 o9djRCg+O5ivQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E5FEFF886F;
	Tue, 28 Apr 2026 17:02:19 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Tue, 28 Apr 2026 18:02:20 +0100
Subject: [PATCH v3 05/11] iio: dac: ad5686: refactor include headers
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-ad5686-fixes-v3-5-9cff7bd67a15@analog.com>
References: <20260428-ad5686-fixes-v3-0-9cff7bd67a15@analog.com>
In-Reply-To: <20260428-ad5686-fixes-v3-0-9cff7bd67a15@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777395737; l=2747;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=/NgJQWWQpqiJn15++sviD7O4LcVLZHbwU27WAPG7JPY=;
 b=emxNeb+hCenwPsJSuNPqLVudkqZppR+16jo6SgXqy9uV7Kvl1Xp0Gss6n/XiwQZy9gKXcfvhw
 EoXNZLg6hh7BTwI6TDEi7HOiQpEzYeksUIulUwFCYxj07QZ7EAwTn9X
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
index b31d0ec5415c..70d61ed29aa8 100644
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


