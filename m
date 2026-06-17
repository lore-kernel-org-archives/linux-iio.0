Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E2A2E7384;
	Wed, 17 Jun 2026 01:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781660377; cv=none; b=Vh+tULYLGjZv9A8Gm4hgwOn44XUShleHDhXj89M69B32wk7pKu88YDaVhYxmbDCd2tki/2v/HgEauPKM+/YNuHC/N5sZ0mjMUdyow9o29jQ5QvCXQ4XVrS+oVJ0E07+swPVqfMbaOBoGuzXmtvK8Skv3QwQwrcFhhYmlZ5+8VPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781660377; c=relaxed/simple;
	bh=/au6Pg/xeEvTwBIrMjSliICkYgiDjNXSuy5vlTSgzzs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M+XruN+prG+DB/xBp1z9benSG91yO18hqLRAHphhHi5Sc51uZH1fpQdldkyhrLcokN/cmLNsNbxKH4Q/r7Vged0Qp9BcALpNhcHQKkhU04tYeOezq5OgGYE3vaysnJC8Lf0o+GNcT5P9LfG+RTPd3j768GcWidhjKi1MWbaUXWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=DN/PbDHf; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="DN/PbDHf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Zj
	OHM/C115qhlt9RvXY/5JvPeHHMNDBANHZ5oNJ3Ptc=; b=DN/PbDHfxyRSyMriqe
	Y8T8K2lDUwigsPDrSSnVFBCc/F58QUeERf/x9ea16EwzyNSw//LCy1jjZ5B1atjc
	+aDUbLLVVi3TmPZP3lUmvJNgdEC5Cb8QmcHwqbLmaYIa3JZkWupEyS9+FqxexWR5
	wgr5WkyQNElgZ17cR8Efnd4LI=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDHkGec+jFqG2+ADw--.45939S2;
	Wed, 17 Jun 2026 09:38:37 +0800 (CST)
From: Miao Li <limiao870622@163.com>
To: jic23@kernel.org
Cc: andy@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	dixitparmar19@gmail.com,
	bigeasy@linutronix.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	limiao870622@163.com,
	Miao Li <limiao@kylinos.cn>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v3] iio: accel: stk8ba50: Update includes to match IWYU
Date: Wed, 17 Jun 2026 09:38:34 +0800
Message-Id: <20260617013834.166337-1-limiao870622@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHkGec+jFqG2+ADw--.45939S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZF13Kr17Cry7Zr13XF1DKFg_yoW8Wr17pF
	4DCF4kGrsxtw18GFnruF1avF98Xan8GF1xtry7Ka4YvrWayryqg39Y9Fnagr1DArZrKay3
	XFW3Kr4qkrW5ZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pisXo7UUUUU=
X-CM-SenderInfo: 5olpxtbryxiliss6il2tof0z/xtbCzR-Mmmox+p9yFAAA3c

From: Miao Li <limiao@kylinos.cn>

Update the list of included headers in stk8ba50.c using
Include-What-You-Use (IWYU) tool, mainly to remove kernel.h
and add missing headers such as array_size.h, bits.h,
dev_printk.h, etc.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Miao Li <limiao@kylinos.cn>
---

Changes in v3:
- Put the changelog after cutter line, no functional changes.
- Link to v2:
  https://lore.kernel.org/all/20260615092116.83850-1-limiao870622@163.com/

Changes in v2:
- Drop linux/iio/types.h as it is already included by linux/iio/iio.h
- Link to v1:
  https://lore.kernel.org/all/20260603015033.187735-1-limiao870622@163.com/

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

