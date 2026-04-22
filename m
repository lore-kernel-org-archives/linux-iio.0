Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D7B34A3A5
	for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 23:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776899627; cv=none; b=nZdjm7xElqr1IfdXmpOQxJ0i6D25lzn7QVfVUOrwZXQJSup/x9JiocuWzzDe4bZPZJWEK5LwDVcF/dfiOgpWlzkh+eg/tFLxrSyeigsibMNqFAMqKdQSlTVAe9Hw6tdlE+MBy8dAcdqV55D1Ni+gOyUlDbDuse40U3PRd1MxmqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776899627; c=relaxed/simple;
	bh=HpUHxXQviyAvg6b61Y5IhyJMu0juPSDMJSYcI25BnjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=USKBYO5Iz5qfnPYY5ZEtyOoifYKLHtOtqO/tVuWuGuFtbfZ+gJ22WrvAkICA5Zhpp0uPOwaQFMCbm1aEVa4ljywRk02YwC86Jr3DjRX6jTtfZ/pgbb/q1uRsPDpOA8yAG02BiGyLyxhqFuM1Uvuull4nBZ7ZQTk6E5J/XU+mE7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=iVExG6Fi; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="iVExG6Fi"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-56a9076813bso2466408e0c.3
        for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 16:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776899624; x=1777504424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ql9EMTv3njIVGDuJgi9LEzfYh6RWEOPc8TpaDZg/Yvw=;
        b=iVExG6FittbP/su1fGzyUhlI7+ja/HX6j2XbWis9vmMl2q9JizAXqG2/yMGYipLVFT
         EM6eOvPFYYiCz99IZLWslBLNt1oo1tkbIp+R02ezmK9bimjzawAm6RNjvVl6rVji/0s3
         KG20/u64qfy07ihXa9BRAFGReQHsXnRhAZmqmoL1ZWK3Ib+WKT0tjvPCWmHQ4k6i5mTp
         exDjphqQ+4Jx4Zjl69MRvNLcoWSxKH64BUpxBUkc5uX8oMqKJTHGNxO7z/01mBzQEK/i
         7B6cCJ4BXF9afaHzRtH3r0F20bv+jhA8AeRTH9VDJnUKq5WiIEHBruxCECF8p2ix+gOc
         +tnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776899624; x=1777504424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ql9EMTv3njIVGDuJgi9LEzfYh6RWEOPc8TpaDZg/Yvw=;
        b=AcABNuZss8H78o0vC/nDUOl58ibgjg4qfvfOoT1GJOP/ypT343lFddxelRITyBMaa8
         gqr19IgXvOZSKuJQUXs/D+nIfDN0b7I1xwo8D1GQyHEzs4e74km3qBqfkYnjgYtFryi5
         bt1lPd+TB8fU5zFQTxnIxUbd4TKyf+hHvA1ZUm/FvvF1DaRieYoBGaxn7kR2wGUIrOyT
         pP6JFbxVJ6b32nrEu0+Arp9VVjrl+6A5Flf0+Vl2acWuuA5w2nUShs+LgJJ4/9x0hcQI
         WoVX8aCPFqytb3EKd4WSkhKXmWFweOru7oys+Mtqzha9tyWZtRa0woIuw3nXodNXz9Fe
         wG5A==
X-Forwarded-Encrypted: i=1; AFNElJ+ko1rCowZvbqARfL5Vy3qM+AyFeXHef8NDrgFQvvmsP8nlhRREQ4d/izQzFx/ivYczuWROAiVd1MQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCrkwZ0+PMNEtVCkpbd4Ccum6TpArBYg+Bmh/NQuNr+gg63zGc
	G5adep6Wkjyup1SGFRGLTNtvCBG/YqLfvDL3+K+QDoJunY9DFfd4yC79fCur6ycVUfA=
X-Gm-Gg: AeBDietx7Lv5s4nRZ0q7p8D3H46lRTgZrL00YYiXRu57+bzuLtsCCx0BQaOs9Z4XXu7
	Dex7xir0LdxOUODY5GsVc6WN4GaQcpINRCCo5lJcd4ygKqaUc43KdH2BfdzMYHDIzKWKlJDpyPj
	SyLHnpZOg0boqzYl796MvwUV1EECLYLcvOuUfbgr7Ted2lof1XQZ8JmvmZ1b1SClH2Zbwap4P9+
	L7I8StyDEND3u9Zqc1FqCFkFEboyS/pAkzYIDSZ74mTTe0QWs7r6e0O6nV02jSc/KjUhSrIomFE
	6JOabFa2EnaFd+GV6feqOvjyzcF2yGKDCyAsudDGtW/M8ucJeliVCFsQUp87wbYcIjO7ZQxL/AW
	O0p9LZose/+3dLcvxfSdVaYxsgQXo7MY8kw+6k9iASONxX6odnkRuR5mLnmP5qYZFR0EEDsbAud
	goCcf8MI9vQ55eavnt/fDS6TlHyuilpO3q+GGeMD0X
X-Received: by 2002:a05:6122:378e:b0:56c:da22:6921 with SMTP id 71dfb90a1353d-56fa5817ad4mr10874851e0c.5.1776899623974;
        Wed, 22 Apr 2026 16:13:43 -0700 (PDT)
Received: from sales-arch ([2804:7f0:d889:b103:1320:e321:eae6:2f6e])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56fa91ea606sm10669834e0c.5.2026.04.22.16.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 16:13:43 -0700 (PDT)
From: rafasales@usp.br
To: andy@kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	nuno.sa@analog.com
Cc: "Rafael B. Sales" <rafasales@usp.br>,
	"Gustavo C. Arakaki" <gustavo.arakaki@usp.br>,
	linux-iio@vger.kernel.org
Subject: [PATCH v3 1/3] iio: light: ltr501: update header inclusions
Date: Wed, 22 Apr 2026 20:12:55 -0300
Message-ID: <20260422231305.677778-2-rafasales@usp.br>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422231305.677778-1-rafasales@usp.br>
References: <20260422231305.677778-1-rafasales@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Rafael B. Sales" <rafasales@usp.br>

Update header inclusions to follow IWYU (Include What You Use)
principle

Signed-off-by: Rafael B. Sales <rafasales@usp.br>
Co-developed-by: Gustavo C. Arakaki <gustavo.arakaki@usp.br>
Signed-off-by: Gustavo C. Arakaki <gustavo.arakaki@usp.br>
---
Changes in v3:
- Separates asm/, linux/ and linux/iio/ headers in separate blocks
- Removes redundant headers
- Replaces some headers
- Removes cleanup.h
---
 drivers/iio/light/ltr501.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 4d99ae336f61..277c497bd6d8 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -9,20 +9,37 @@
  * TODO: IR LED characteristics
  */
 
-#include <linux/module.h>
-#include <linux/mod_devicetable.h>
-#include <linux/i2c.h>
-#include <linux/err.h>
+#include <asm/page.h>
+#include <asm/byteorder.h>
+
+#include <linux/array_size.h>
+#include <linux/bitops.h>
 #include <linux/delay.h>
+#include <linux/dev_printk.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/math.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/pm.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
+#include <linux/sprintf.h>
+#include <linux/sysfs.h>
+#include <linux/types.h>
 
-#include <linux/iio/iio.h>
+#include <linux/iio/buffer.h>
 #include <linux/iio/events.h>
+#include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/trigger_consumer.h>
-#include <linux/iio/buffer.h>
 #include <linux/iio/triggered_buffer.h>
+#include <linux/iio/types.h>
 
 #define LTR501_ALS_CONTR 0x80 /* ALS operation mode, SW reset */
 #define LTR501_PS_CONTR 0x81 /* PS operation mode */
-- 
2.53.0

