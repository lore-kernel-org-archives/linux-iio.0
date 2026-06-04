Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9353DD85A;
	Thu,  4 Jun 2026 07:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780556505; cv=none; b=gjutFoiBZZOJRrgBtuX2cuyIC4yy9W3AZ7T+ZL0HVeIJlWObbsFDblqtS0CMbLR8OSCz5oVCVZam2A06I9QSVC9fjlcumAL3t+57ifcyLI1EDuwcPxOEObAYTLKxj6quSbRuZEpbVM6ehOROQTMD92bOb1A8zxVLX9m8ZEnXdKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780556505; c=relaxed/simple;
	bh=GSt/0YVMLmFuHtooMM9OGBGZr4c9aTbjatyjDOM4FwM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SfDfmBR64A3z1aUsI8GzpXifhH40oRX0MKGBJEnH77UnHwo+bzX3IzfkRWbTl00lE7++D5UyLzScLi22bUtMc3fbSGxUruILuuY3lWPVE3iNQxg0appAnSvsgISIadvx/lHAJHHQ73zf6EUGHoTPtsGc9MqPMJifu2fa0kpy8yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=beI4gYm0; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="beI4gYm0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=gX
	oGcviAjO4XOHdXiKgBGqrvnnYzq9t5lrJ6fj8+MJc=; b=beI4gYm0Q9c7XO+vPt
	eywmYsls4x18z882bXtdwWR4NwIQ0XDbCYEZ34uKE6cQ3AFjnRdVSePgamhvgHkq
	+oGSUljLaSg5TNBa8wUAkfF0KtSQxpu3bNv6TSjZ8o/bbWP+6YqQU7XNaO9GEa2e
	0xNIjWX/T461Kl2yfUkqW2cuw=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgC3nv2mIiFqEZqvAQ--.52337S2;
	Thu, 04 Jun 2026 15:00:56 +0800 (CST)
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
Subject: [PATCH v2] iio: accel: stk8312: Update includes to match IWYU
Date: Thu,  4 Jun 2026 15:00:53 +0800
Message-Id: <20260604070053.299221-1-limiao870622@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgC3nv2mIiFqEZqvAQ--.52337S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZF17Aw1xCw4kJw1ktr45Awb_yoW8JF4xpF
	4qkF4kGrsrAw18GFy7uF129Fy5Xan8Gr17try2ga4jv343tF1qgwsY9FnagrykCrZFga15
	Way3Grs8Cr45ZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piJGYdUUUUU=
X-CM-SenderInfo: 5olpxtbryxiliss6il2tof0z/xtbCzQiVY2ohIqjeXQAA3x

From: Miao Li <limiao@kylinos.cn>

Update the list of included headers in stk8312.c using
Include-What-You-Use (IWYU) tool, mainly to remove kernel.h
and add missing headers such as array_size.h, bits.h,
dev_printk.h, etc.

Meanwhile, sort these headers in alphabetical order.

Signed-off-by: Miao Li <limiao@kylinos.cn>
---
 drivers/iio/accel/stk8312.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/stk8312.c b/drivers/iio/accel/stk8312.c
index f31c6ab3392d..959dfdf61db4 100644
--- a/drivers/iio/accel/stk8312.c
+++ b/drivers/iio/accel/stk8312.c
@@ -7,12 +7,20 @@
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
+
 #include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
-- 
2.25.1

