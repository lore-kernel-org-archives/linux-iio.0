Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CB0383984;
	Wed,  3 Jun 2026 01:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780451319; cv=none; b=VEEn6cfLsbpis84+ocmYz+24DNOYCc6HImnGwxYHLdub1AnW2g+XEjSDUqLv1T6POQoe40LJXI/E0B9ajd4LorfrXZCiLK3W8sueAjhxGgQ4txP5QaJkffAM/tv27Hw4g0OgGJ5kZG6aI5FfV5TEwuc9XeJZevTioMpPJ5W3HCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780451319; c=relaxed/simple;
	bh=LgESYxH1HjYOoQ9wXboHEn/IOdY70RMPBDK7jYoNpsI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QrcrGQWJBlUKp3ZhrcWPpX4egMSqoHZweu7eFnRGckIDKuY+m9FF2qbERNSrAldY0NkAh0HPPHzcoJ7KcbRDxSDylzIJOCCJ7Ccd6KUeci9fphTXtO5wq2Osp3LTpHTjUfs8gvP7cJNu7ED9EwYsm4PdHyqrbV6m5QAgRpzCGxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=VjP5vf8i; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="VjP5vf8i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=mq
	mOKWpxcQlke7GHWCURVrQl6LMvaHC8sATTqlQllvQ=; b=VjP5vf8i/7J3rpD74j
	s9Kd+z0ueBHGbx61Aa9JD4I4dtUncfSZynQSg5BjK8v54F2CCErhIudQB096dAqo
	c9QXGHozcXdxKMLmg8LxwaKRmmib/uXsjmnqF3GVczeVhjz0m++rLZ8GCTyT27jM
	WbdFf3sRqwwSFSwxS3Zt6AwAI=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wDHjofNhx9qObYBBA--.147S2;
	Wed, 03 Jun 2026 09:48:00 +0800 (CST)
From: Miao Li <limiao870622@163.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	dixitparmar19@gmail.com,
	waqar.hameed@axis.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	limiao@kylinos.cn,
	limiao870622@163.com
Subject: [PATCH] iio: accel: stk8312: Update includes to match IWYU
Date: Wed,  3 Jun 2026 09:47:54 +0800
Message-Id: <20260603014754.187465-1-limiao870622@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHjofNhx9qObYBBA--.147S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZF17Aw1xCw4kJF15tw15CFg_yoW8Gw15pF
	4qkF4kJrsxAw48GFyxuF129a45Xan8Gr17try2ga4jv3y3tF1qgws5uFnagr1kArZFgw45
	Way3Grs8Cr45ZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piX4SrUUUUU=
X-CM-SenderInfo: 5olpxtbryxiliss6il2tof0z/xtbCzRB4Rmofh9BimgAA35

From: Miao Li <limiao@kylinos.cn>

Update the list of included headers in stk8312.c using
Include-What-You-Use (IWYU) tool, mainly to remove kernel.h
and add missing headers such as array_size.h, bits.h,
dev_printk.h, etc.

Signed-off-by: Miao Li <limiao@kylinos.cn>
---
 drivers/iio/accel/stk8312.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/stk8312.c b/drivers/iio/accel/stk8312.c
index f31c6ab3392d..bcfdc92b7f81 100644
--- a/drivers/iio/accel/stk8312.c
+++ b/drivers/iio/accel/stk8312.c
@@ -7,11 +7,18 @@
  * IIO driver for STK8312; 7-bit I2C address: 0x3D.
  */
 
+#include <linux/array_size.h>
+#include <linux/bits.h>
+#include <linux/delay.h>
+#include <linux/dev_printk.h>
+#include <linux/errno.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
-#include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/delay.h>
+#include <linux/mod_devicetable.h>
+#include <linux/mutex.h>
+#include <linux/pm.h>
+#include <linux/sysfs.h>
 #include <linux/types.h>
 #include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
@@ -19,6 +26,7 @@
 #include <linux/iio/trigger.h>
 #include <linux/iio/triggered_buffer.h>
 #include <linux/iio/trigger_consumer.h>
+#include <linux/iio/types.h>
 
 #define STK8312_REG_XOUT		0x00
 #define STK8312_REG_YOUT		0x01
-- 
2.25.1

