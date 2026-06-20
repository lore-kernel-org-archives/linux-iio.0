Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AE019049B;
	Sat, 20 Jun 2026 02:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781920851; cv=none; b=TGbQk5FTpNBXTyssM1kTKjllgUAYNYrBvDB+ZaZ7HiKTV4NL4vG4w57vzNT6Tf+l1gCtrl5l9BArVgiZQkWpYMvAQ7a4dOc2tyZxFRIkWgmCzDdycqds7USkfAzFHZtPQ7JeG0lPtRa+IhqWQ1K7F/T2qkCgPm1gL7B1cff7RoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781920851; c=relaxed/simple;
	bh=xtWjOdgCp3FN89YLZDCtT8to/x8Eh2n70HkKCaO3DB0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Exianww1n5PG/8AKu1d3cv/Nujuno3NkYj2qhkVufpRFBMkN/HiDHn5Ra57VNxL6d0lL2R9tMPjq4CZDie0ZuZANKc2AcJ0RrF1MZ2MeSWrU1TZW6uNxY1tEnplF7XKsWSx7AkrMISy5IvBnNalylgO4h7vGpKqa/f3XTcbVkgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=mLrTG3+S; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="mLrTG3+S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=HH
	H/hNqZJfu42lNfdMTFkIyIJ4GZm5HASePR17DO5gs=; b=mLrTG3+SY63bSeJ/jb
	YRwPpbGEDYJa2HoLq2fLyxEIE40XqztSgMw+uVqe0q1pLD/KYkjWfgaiFJVFghGE
	QfWwb43U/JhgurWbnRsy+k3MiwlXRNfC0PV06Odk3cF5Sp6D+QSb/ExyrPmKXXL2
	P/AMX50KpbuQbiS98Pjly4Pf8=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgD3Bf0Q9DVqnONsDQ--.63648S2;
	Sat, 20 Jun 2026 09:59:46 +0800 (CST)
From: Miao Li <limiao870622@163.com>
To: jic23@kernel.org
Cc: andy@kernel.org,
	joshua.crofts1@gmail.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	marcus.folkesson@gmail.com,
	dixitparmar19@gmail.com,
	bigeasy@linutronix.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	limiao870622@163.com,
	Miao Li <limiao@kylinos.cn>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v4] iio: accel: stk8ba50: Update includes to match IWYU
Date: Sat, 20 Jun 2026 09:59:40 +0800
Message-Id: <20260620015940.27636-1-limiao870622@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgD3Bf0Q9DVqnONsDQ--.63648S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZF13Kr17CrWrCryrGryrXrb_yoW8CF47pF
	WDCF4kGr47Jw18JF17uF1avF9xXan8J3WIqry7Ka4YvFWavryqg39Y9Fnaqr1DZrZrKFW3
	Xa43Kr4qk3y5Z3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pisXo7UUUUU=
X-CM-SenderInfo: 5olpxtbryxiliss6il2tof0z/xtbC7xMp9mo19BNXvAAA3w

From: Miao Li <limiao@kylinos.cn>

Update the list of included headers in stk8ba50.c using
Include-What-You-Use (IWYU) tool, mainly to remove kernel.h
and add missing headers such as array_size.h, bitops.h,
dev_printk.h, etc.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Miao Li <limiao@kylinos.cn>
---

Changes in v4:
- Removing <linux/bits.h> and adding <linux/bitops.h> instead,
  as sign_extend32() is declared in <linux/bitops.h>, 
  and <linux/bitops.h> already includes <linux/bits.h>.
- Link to v3:
  https://lore.kernel.org/all/20260617013834.166337-1-limiao870622@163.com/

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
index a9ff2a273fe1..e2cd5a528c16 100644
--- a/drivers/iio/accel/stk8ba50.c
+++ b/drivers/iio/accel/stk8ba50.c
@@ -7,12 +7,19 @@
  * STK8BA50 7-bit I2C address: 0x18.
  */
 
+#include <linux/array_size.h>
+#include <linux/bitops.h>
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

