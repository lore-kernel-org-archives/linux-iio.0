Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E791B36AB7C;
	Mon, 15 Jun 2026 09:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781515339; cv=none; b=LgooIAj6Ww1WVW7MdtxYzWs8V2blqf3Fy1TaN1W48L+ZUGchJNeMSa1BGjlQro1V0Aa56+/uLSnT1z9LeF4ni6+5KPo1qTlyirXhOQBZtA42/cmmrNxy9lpuLWVB8hCrF9ca67RuWT6J6D1v1uX86CThWE0Ur29LjGZqPJtWvAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781515339; c=relaxed/simple;
	bh=2B+f/otx+dF724Cm0W3m3qHgqodJciFDXkzHJbQH4AI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KscEDdvGpCOZpQSOrAdVGe854thQtmiAPT1dn0jdeVec8DhB1phiA69ihGDlgyiLKQZktNam7xcgnf7dMKMwp/lSbwfUITciZ/25BhxhzitBzFmZUOtVUmlQu69LzpGTP2czSMrt8x52K4S6VLMiCB2gaSQsvZ2rDz1ruUQZwX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=dYRtCbSf; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="dYRtCbSf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=T4
	Sg98Uq7LX9gU82QE2rAw62hWaPbz/t3iE3+6piGcE=; b=dYRtCbSfq/+By8G56t
	SDGOW5Hd4fXg/dxX/h6Ce5V7hxKLRTYH50KgiiKqV7+Ow4DWZpMp4vERkQ4R36jU
	5IxKcWpgF3r+YQY7n5d1QU09s1n5XrPT3d5mG2dqLSXA1qAsApOqlaPnLPiyL4Az
	anT8u5Ks9vQ/VnOEBn/h5f0G0=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wAH9nIOxC9qK8oVDg--.37443S2;
	Mon, 15 Jun 2026 17:21:20 +0800 (CST)
From: Miao Li <limiao870622@163.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	bigeasy@linutronix.de,
	dixitparmar19@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	limiao870622@163.com,
	Miao Li <limiao@kylinos.cn>
Subject: [PATCH v2] iio: accel: stk8ba50: Update includes to match IWYU
Date: Mon, 15 Jun 2026 17:21:16 +0800
Message-Id: <20260615092116.83850-1-limiao870622@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAH9nIOxC9qK8oVDg--.37443S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZF13Kr17Cry7CFWfuryxAFb_yoW8Gr1rpF
	4DCF4kGrsrtw18GFn7uF1avFy5Xan8Gr17Jry2ga4jyrZxtr1qg39Y9Fnaqr1DArZrKay5
	WFy3Krs8urW5ZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pisqXdUUUUU=
X-CM-SenderInfo: 5olpxtbryxiliss6il2tof0z/xtbC8BGbaWovxBGdOAAA3m

From: Miao Li <limiao@kylinos.cn>

Update the list of included headers in stk8ba50.c using
Include-What-You-Use (IWYU) tool, mainly to remove kernel.h
and add missing headers such as array_size.h, bits.h,
dev_printk.h, etc.

Changes in v2:
- Drop linux/iio/types.h as it is already included by linux/iio/iio.h
- Link to v1: 
  https://lore.kernel.org/all/20260603015033.187735-1-limiao870622@163.com/

Signed-off-by: Miao Li <limiao@kylinos.cn>
---
 drivers/iio/accel/stk8ba50.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/stk8ba50.c b/drivers/iio/accel/stk8ba50.c
index a9ff2a273fe1..6a60c0fcebe9 100644
--- a/drivers/iio/accel/stk8ba50.c
+++ b/drivers/iio/accel/stk8ba50.c
@@ -7,12 +7,19 @@
  * STK8BA50 7-bit I2C address: 0x18.
  */
 
+#include <linux/array_size.h>
+#include <linux/bits.h>
+#include <linux/dev_printk.h>
+#include <linux/errno.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
-#include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
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

