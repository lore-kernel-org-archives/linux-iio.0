Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2DB155C97
	for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 04:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784349767; cv=none; b=c2+wbZhMWgkGWUIektUZpyXoTTR1TQT0Eb9ZpcHOIiGF8yxW45C3KZ883EgJ2iJ/DP1y0HKl7EPyq+FVk03Wd+H1RSOEC4qnBD1YMWPbclrw2ELZDPahaguDmB+PuHvhEzkv6qSuuF7bBdZiIePJdxI5ss9rVeFv4Npxi1g9/bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784349767; c=relaxed/simple;
	bh=cKYqxL3jzR8vFba6Cp693tIu/kqmUejaU+VCmSdFwrY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SjcsjbXZ/sq+ehu5tQ/oSMIZLDy/lwTATb7LK5KUkhS3nov0N2OiO+Ee61CWsvsjpNVLtYqZ2SXrELMoziA9dXT2XFnS2O52l5peojLEPMx1Pe/44gSgH69B6sFnXBzuEu9p0691Ys1p7TSw+ADvMdF1Q3ahLGjzeM0uYqeEui0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b3J/lRDX; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3J/lRDX"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cc7ef7ec27so95999005ad.1
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2026 21:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784349765; x=1784954565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7yaLxWejf29cL56OietuZ2+Mlao1Prg9ji1ZVxHMa+U=;
        b=b3J/lRDXKcBcnX+kHMRTXCd28y6WXl0E3qPmra82ik3wDUS4yxahcv1spmvgItiEE7
         k23hPb81FzWonk0vU3khVtpLYCldBNYmV3LSIiRzhNJ9WkI2PKZkXvLfbkzvdYpXdVAS
         PYH62Gr8TocMglqeql3fzeCcIFmckhsw24jH/P+LwlfSABakmf5K4J7O41jyJ/csQ6i5
         xIf27D0Tj4gRXWtUMyUIT18/yJS+cO+R7f1gYW3fMKxnbQc8tVzAyv8jGTctonZuL9+5
         SUrdfGv2cBZwBBgdpADJsqkWNbJGfYA/7O+jGU1Qq+b3VXUyADYJQA6duo4tzlliavLF
         JOlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784349765; x=1784954565;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7yaLxWejf29cL56OietuZ2+Mlao1Prg9ji1ZVxHMa+U=;
        b=aQSfDmDWXC2im6rdpXXYI+tdm4b5LafHKuMfgdTM9g5frEEpZStx1j84crsIv50UIi
         6mL3jpzTZZC6OYflNd9OauhRFBEeK1GanY3vUdxeD53cRXXeksNkGjMzUcwyoWl7JSzF
         VEXDSBJVwipyh3m2/0Sj31qrATSbYZY/sIUaHSKjaiq41nV3DEsA3Rdl+vqCynKLl82p
         Bo6bVLvwY/0ecmdXz2OT5KqWWQTq9m0yvYHD6CNobkXjlD3uJAqjFVDhMirnH02vnabZ
         mVa8MCB+b0TygaPAUDFj3/ryHowBRGoj5KExjy2Cd/WWTlFmWRKoLj6Q4NA5JST3Jrwz
         AMEA==
X-Forwarded-Encrypted: i=1; AHgh+RpTAsw8Jlw+JMxNpjkyi4FpZiogxpMpY8rcVUV3zhSw6ucX3+lHtLg/4LgwqCO8zdT1ylongbIGHzU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/2l3NnQrGyvPlXQ/Z8jusjSliLxGcrMZQHR3goEgghFcDIstI
	i7Abx5SSuEsGqyQgM+wyk8oz7JRDz59VQeZbzUJluxi5qbvjzXlacE7n
X-Gm-Gg: AfdE7cnTF+GesgCqPj0njLsd8JNw7ZiRJ7Hhd8LUrtTUEvCUZy5/8pCeWhH4aKJaCaq
	jnDUaBVzzILMktu8mdSShP19soM5DsIyiGWC9YBgziQG8H3vl03UEr7soMiAMqNqgy422PWjf08
	RubtuOV7nZill3BLZiaEhYlVf9odUf8QHdTJ45I3+UBW9ER+H74J/sQxx8YMkxpLa6BZxeadFHT
	3ODsmsTAdycng8p0jfqZkwHd6p1MEW2P2uZXaZNW05hyWGvjTPDwmCQeHPDV18wrdtEEhzMJr/t
	hiw/PpQEI72OiYtV1377sy2dSQpPQ8mf6NvtjemHXNpmEiQKFNnNfUX5F9Lc/WLWmuPQUT7x29y
	msTLu6H6k9BRl16faVZ4VVtWKkZQTbmBICwyj1fHyCTTR7SWYVjHBjeRpZXnVMtf8BK++a9X9dW
	k7bA==
X-Received: by 2002:a17:903:b08:b0:2c6:90ec:f601 with SMTP id d9443c01a7336-2cf34835859mr63305995ad.8.1784349765450;
        Fri, 17 Jul 2026 21:42:45 -0700 (PDT)
Received: from kdev.. ([108.180.130.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf344bd3aesm21644465ad.26.2026.07.17.21.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 21:42:44 -0700 (PDT)
From: Babanpreet Singh <bbnpreetsingh@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Angelo Dureghello <adureghello@baylibre.com>,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Babanpreet Singh <bbnpreetsingh@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v2] iio: dac: ad3552r-hs: use sysfs_emit_at() in data source avail show
Date: Sat, 18 Jul 2026 04:42:44 +0000
Message-ID: <20260718044244.7-1-bbnpreetsingh@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ad3552r_hs_show_data_source_avail() formats the available data source
names into a 128-byte stack buffer, but bounds each scnprintf() with
PAGE_SIZE instead of the buffer size, so the bound does not protect
the destination at all.

This cannot overflow today - dbgfs_attr_source[] has two entries,
"normal" and "ramp-16bit", 18 bytes formatted - but the bound stops
protecting the stack the day the table grows.

Found by smatch:

  drivers/iio/dac/ad3552r-hs.c:593 ad3552r_hs_show_data_source_avail()
  error: scnprintf() 'buf[len]' too small (128 vs 4096)

Instead of shrinking the scnprintf() bound to the buffer size, switch
to sysfs_emit_at(), which enforces the PAGE_SIZE bound internally and
is the preferred helper for formatting attribute-style output; the IIO
core formats its own avail lists the same way in iio_format_list().
sysfs_emit_at() refuses buffers that are not page-aligned, so replace
the stack buffer with a kzalloc()'d page - power-of-two kmalloc()
allocations are naturally aligned, see
Documentation/core-api/memory-allocation.rst.

Fixes: b1c5d68ea66e ("iio: dac: ad3552r-hs: add support for internal ramp")
Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Assisted-by: claude-sonnet-5
Signed-off-by: Babanpreet Singh <bbnpreetsingh@gmail.com>
---
v2:
 - Switch to sysfs_emit_at() with a kzalloc()'d page instead of
   bounding scnprintf() with sizeof(buf), as suggested by Andy
   Shevchenko. sysfs_emit_at() requires a page-aligned buffer, so
   the 128-byte stack buffer cannot stay; add the cleanup.h, slab.h
   and sysfs.h includes the new code needs.
 - Retitled; v1 was "iio: dac: ad3552r-hs: fix scnprintf() buffer
   bound in data source show".

v1: https://lore.kernel.org/r/20260717040024.7-1-bbnpreetsingh@gmail.com

 drivers/iio/dac/ad3552r-hs.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
index 02a124ac4855..c561fed2ef1a 100644
--- a/drivers/iio/dac/ad3552r-hs.c
+++ b/drivers/iio/dac/ad3552r-hs.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/cleanup.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
@@ -14,6 +15,8 @@
 #include <linux/iio/buffer.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
 #include <linux/units.h>
 
 #include "ad3552r.h"
@@ -585,14 +588,15 @@ static ssize_t ad3552r_hs_show_data_source_avail(struct file *f,
 						 char __user *userbuf,
 						 size_t count, loff_t *ppos)
 {
-	ssize_t len = 0;
-	char buf[128];
+	char *buf __free(kfree) = kzalloc(PAGE_SIZE, GFP_KERNEL);
+	int len = 0;
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(dbgfs_attr_source); i++) {
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%s ",
-				 dbgfs_attr_source[i]);
-	}
+	if (!buf)
+		return -ENOMEM;
+
+	for (i = 0; i < ARRAY_SIZE(dbgfs_attr_source); i++)
+		len += sysfs_emit_at(buf, len, "%s ", dbgfs_attr_source[i]);
 	buf[len - 1] = '\n';
 
 	return simple_read_from_buffer(userbuf, count, ppos, buf, len);

base-commit: fce2dfa773ced15f27dd27cd0b482a7473cdcf2a
-- 
2.43.0

