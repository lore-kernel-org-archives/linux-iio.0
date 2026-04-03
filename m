Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B24930B514
	for <linux-iio@vger.kernel.org>; Fri,  3 Apr 2026 08:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775203593; cv=none; b=jHTmVEfogU+KAkJVgKwy+dJo/zSgH/9QJtQ65l4SALXYZkBPo0e3C0UvGZx7uwFdLtHoU58IrX57pXvqKBO3JmANnLAAzXt6LbAeVMJKIFYmAUFUu7WFGrDpMm2VvMBD2ALd6gVAgPen9X7QMhXPAJuke1bHldMYFcyjYKlfZOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775203593; c=relaxed/simple;
	bh=ct7uGHPjqUnB8e1rthoWoDqs6UOvFlQbDqGPqVutLkM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o+xN1plOXRk0zxkq+or62Z4I+iuPXwOyV1WT19dskmj0NDZxlfRp67wUE6b2Zq4m/IhKQrxPVHLzF4GtFLV5NPCtdwY2vAdxFRIxpKAIVRhwRgHQIVzecIZZCNkSyK8jyAILdMCohAHdLzjkJOBuzckBe/TABy4zr/jhKLfZIqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VxW/06aT; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VxW/06aT"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82ce0a9b3f7so768015b3a.0
        for <linux-iio@vger.kernel.org>; Fri, 03 Apr 2026 01:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775203591; x=1775808391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zkOUIY36rHh+B06Th/hdhTi/x0+53xtFclztLcGxX9g=;
        b=VxW/06aT+eEfixwL2/Q0Zl1b5UFCn8wP9bQ15olD7YrAjFw608zJ7FsAMVjROkGMey
         FqJS+lLki2WbdKlOUKKdqnCpok05+UYvYyw6ff5M818Fb2etvA5aSb8hVHby0oHAWIYO
         g5ryJjrQPWn5JCVUE4UOPDxXI2bHZz8JUVqh7k328k2vTFfktPgjPdMJM9sf4kROWQRL
         fmgv+9JwccSsucCqQJMFjr9SxMTz+PYtxWwKB7JGbPODTJePjJ+Emz1JFGVZYx0p2qtg
         OVd8mImodmBIuazNu9NNA4ATtBE8dYIk0+Ez0xlugLvrGiAiTVmHsT2eQWTipbhfZR0M
         4ZBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775203591; x=1775808391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zkOUIY36rHh+B06Th/hdhTi/x0+53xtFclztLcGxX9g=;
        b=gNEB2w5fKrgtnFC1EWUet6QYNsuH5mMpn1qP16FC1Wu/hHpHQzAhs1inmWvwUtSPwA
         Mq7XuOdxmMxVZKZ6xML0ChWcAII+txgu2tboUqNaT0Z5n2amVaSflf1P/xlJj0b/DboK
         RKit23PDYVdL9sVgesYf94gxQcOBUYx2NKJXRq6qMOPktOHhAzfvsPduaywAJuJJMhfo
         0OdNN/V2WGWPg5H9h2VooXuEYALgySvxOcIHL6C7H7WfhgOvtw77XIkijcp3zn54Wvpl
         eCLCcZWm3rMqGXwoNGgk80DT/RzNJbXYs+ITv+9yMHGT09B+OQYRwaVWAban4yk6ipJF
         ntpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvoTnHOgFBeFZxpd3HiHL3jz0pucDT/mEYBl+oA+LyepMVD0aLb6KnubLhC+kqiPuqEUWArAi+vZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTD1UJARKGFJVqGMfGgCS1qkUM2vDl1vTP+UnunL6PaYuYkxs0
	cg2adJM1swIMNjgkf/uicH49rukepD7jKicGjdASFqnRMa7IQoADL1YK
X-Gm-Gg: AeBDietMFX0skUb1ihD4jSA1Z4DdM1frjpusDovZ0XpC1Gm/HC3VfxDQ1A8Ir5HQSvb
	R9hSYgIrA7Aix5Httn8vjTwCTpC5u7gLVt+mRxrxG2MbS//nzwruvdGa8nAGPXdX6hSctON7apE
	PJ5sEsjgcS5UdPFuD98TfhCAbDg72nXda6yrSgjm1hc/eSQeH4CcjvL7U/Wje3KTAncBY8N9ECc
	lVjlj/EjW6RiOfLzDu4hOXrNvAMlMOz1g61KN4YZjeCrhiPzv2TiFfqvLGARhFe9aVJj8gexgOb
	w0r2gRX5dnZCPdk80lmWveQ7gu5dfwC2mieqtrF8VlmgX6qwmzputDCWI8JZaaAxAo2EfKAZ7oW
	hkIHmM4DsThKV9PtnfHnQ6Y+P9wX0raofY/SZ2traJde+txyzC+eGe99jRO1y2yDYCFQtyCh1fZ
	sBq8t6X5pQOzuBaj2Ad/ytcWvjhiEWg7pCVwPqkG0W1joQSHZ9vssbV1jJ8OtSw/wxQUaooMPfW
	w==
X-Received: by 2002:a05:6a00:3902:b0:82c:9fe1:aa4d with SMTP id d2e1a72fcca58-82d0da6d649mr2238540b3a.13.1775203591258;
        Fri, 03 Apr 2026 01:06:31 -0700 (PDT)
Received: from debian.ari ([152.58.181.253])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c6ad8asm5481093b3a.40.2026.04.03.01.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 01:06:30 -0700 (PDT)
From: Archit Anant <architanant5@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Archit Anant <architanant5@gmail.com>
Subject: [PATCH v7 1/5] iio: adc: ad799x: sort headers alphabetically
Date: Fri,  3 Apr 2026 13:36:10 +0530
Message-Id: <20260403080614.14213-2-architanant5@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260403080614.14213-1-architanant5@gmail.com>
References: <20260403080614.14213-1-architanant5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reorder header includes to maintain proper alphabetical ordering.

No functional changes.

Signed-off-by: Archit Anant <architanant5@gmail.com>
---
 drivers/iio/adc/ad799x.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index 108bb22162ef..f37f1fda2dc4 100644
--- a/drivers/iio/adc/ad799x.c
+++ b/drivers/iio/adc/ad799x.c
@@ -18,23 +18,23 @@
  * ad7998 and similar chips.
  */
 
-#include <linux/interrupt.h>
+#include <linux/bitops.h>
 #include <linux/device.h>
-#include <linux/kernel.h>
-#include <linux/sysfs.h>
+#include <linux/err.h>
 #include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
+#include <linux/sysfs.h>
 #include <linux/types.h>
-#include <linux/err.h>
-#include <linux/module.h>
-#include <linux/mutex.h>
-#include <linux/bitops.h>
 
+#include <linux/iio/buffer.h>
+#include <linux/iio/events.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
-#include <linux/iio/events.h>
-#include <linux/iio/buffer.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
 
-- 
2.39.5

