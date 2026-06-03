Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2084346782;
	Wed,  3 Jun 2026 01:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780451494; cv=none; b=X9JdycfZtTcWxEUfL4noLsW5otRXzu8bYbx2N/D/f76TerI87R+jGt00tmH1mOgyN6az3gNOxoS2VRS4niFm79Rg4/IPXrJ18SXkh7fM6GbwBDUwC0vO2U1IHLasehJ2FUuvUCZCoM6mTKxYUx+dsyaflXdDSvfVJOU1OjaIyTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780451494; c=relaxed/simple;
	bh=uImvrP5/K1N6WHmvpq6ORjvl0dIYmyPSsby2mkj90qw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Wg0KDtVXVt6nyg/kgceWVeRrrNLlicgmVMBiCWPDuiSw4hDioyxqoQZ34wwtrjoMiExNjDqU7jJe17Bs/FTHYTavF7myUf6tYG9AJ7Og5TJ61rzeSezpWwCn6+0RErxgtW172QkSnSdbISyIV7VJ3en7UOV1+J6RETyp9oZ/5kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=FHCX+2E5; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="FHCX+2E5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=4s
	q1/FyFsPu+KArVJ01Zv7XO5vNodT8S9+hi9QXV8mg=; b=FHCX+2E5xxgHTO2M3d
	Hhbqho8h3/JUN9gHOxnhg9A4GDkSKS6lYH4foiHomSqPsrPzDfBOo7z9httA7iuY
	d2hon7fBJ72I15wXDvqnydH+W5xagWOUiCRrO5SIUDoBeWLo4y6+i8hGr+qrwMg6
	YNPnJJHaIhz2ilSLqdidhmPTU=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDnjctriB9qZ7iVBA--.50541S2;
	Wed, 03 Jun 2026 09:50:36 +0800 (CST)
From: Miao Li <limiao870622@163.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	bigeasy@linutronix.de,
	waqar.hameed@axis.com,
	marcus.folkesson@gmail.com,
	dixitparmar19@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	limiao@kylinos.cn,
	limiao870622@163.com
Subject: [PATCH] iio: accel: stk8ba50: Update includes to match IWYU
Date: Wed,  3 Jun 2026 09:50:33 +0800
Message-Id: <20260603015033.187735-1-limiao870622@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnjctriB9qZ7iVBA--.50541S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZF13Kr17Cry7ZryrKw1kuFg_yoW8GryrpF
	4qkF4kJrZxZw48A3WxuF1a9Fy5Xan8GF1UJry2ga4qy39xtr1qgws5uFnagr1kArZFgw45
	WFW3Grs8CrW5ZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pi3Ef5UUUUU=
X-CM-SenderInfo: 5olpxtbryxiliss6il2tof0z/xtbC8AyfbWofiGye+gAA37

From: Miao Li <limiao@kylinos.cn>

Update the list of included headers in stk8ba50.c using
Include-What-You-Use (IWYU) tool, mainly to remove kernel.h
and add missing headers such as array_size.h, bits.h,
dev_printk.h, etc.

Signed-off-by: Miao Li <limiao@kylinos.cn>
---
 drivers/iio/accel/stk8ba50.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/stk8ba50.c b/drivers/iio/accel/stk8ba50.c
index a9ff2a273fe1..c40fb2a466fb 100644
--- a/drivers/iio/accel/stk8ba50.c
+++ b/drivers/iio/accel/stk8ba50.c
@@ -7,11 +7,17 @@
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
 #include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
@@ -19,6 +25,7 @@
 #include <linux/iio/trigger.h>
 #include <linux/iio/triggered_buffer.h>
 #include <linux/iio/trigger_consumer.h>
+#include <linux/iio/types.h>
 
 #define STK8BA50_REG_XOUT			0x02
 #define STK8BA50_REG_YOUT			0x04
-- 
2.25.1

