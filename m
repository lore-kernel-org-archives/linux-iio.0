Received: from mail-dl1-f67.google.com (mail-dl1-f67.google.com [74.125.82.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BE7363089
	for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 04:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781065477; cv=none; b=gYtW70cd8hmLpRnCbTCy8Uvv/uR6Wv3Ry62UuKoMRNWKOpCu16qUEIbaG1wehx4KGUxdaDMgcAfUyhHTrXsbmvSZQ8fHFwwRiwc3kinutkLtOpQtUZ8xZRGKqLrtmFPR1HExql/Kq8jbjzCak8MjnVZ7wwyhOPTQhBnluoDhSI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781065477; c=relaxed/simple;
	bh=e7NHbDHvB0LL9s23hKboeGP83ERY9Fa460rVgG483Sk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qEHisuCsWKUveCTU8EQMUsHb1NHVh3H5A2esMnJrno11BXjZbqX8fm83+EIDPklIy9XPO2cZYJUVuBIYLphaKIWSOFAwABX52vwlbc2bEkBFMkVc+eCRrhZ/8j6fT2AQzp6kBZJREgSIcpgechjtezjxlXfnffZP5176TUVTE7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bOBiUTZQ; arc=none smtp.client-ip=74.125.82.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bOBiUTZQ"
Received: by mail-dl1-f67.google.com with SMTP id a92af1059eb24-1382533d428so2749042c88.1
        for <linux-iio@vger.kernel.org>; Tue, 09 Jun 2026 21:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781065474; x=1781670274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BOyuVcPENX+3J+cj9H/+//SNzPslISxsapH678b5nC8=;
        b=bOBiUTZQNH7AMB0ozqdhGPLj16DRUaLIIW+KHd5emNVXTkPfpFMCotPWefARTO9sQq
         gmdaog1ZLb953q1YRyEiWUIYfjFTzMj5Oez0Tgb3tEto43WXpz97PcC9yDjyMGd8+xQX
         Qcqfc6ge0R74b/Ghvl0q22JdibCxi4KfVYzdSQF5FzteLEHmL+2E6AgzdqOfkz/dapoV
         zEc7dSQ1NSUXK7s6qwY0m7E+nICCcYDXXBlkJ+7Zigc4DVHGx9CAPCB6mwoGsbRzzkPL
         q9MDmeLL82y/dIj5CP6Z0HB1KQgG01Wqx388iOHLBytsMr6yb0X+LMJhLLUFf6zgLt00
         myVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781065474; x=1781670274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BOyuVcPENX+3J+cj9H/+//SNzPslISxsapH678b5nC8=;
        b=J5yfbTqA/kFbD+XhjmYghgmhw4KRR0F22eKgTJQbA94W/oPvxWkDesqJ+8E+ZTP+MO
         Uvtk9lXApOnV6CFvwyHh5lzTjOUPe+evVjF2R+wZ3VDp91tVeSyaghfvT77gVSq60GS0
         uhDk1JEkkuvSpAoadiYmHanjjpPy6xaL54+c000IiKN0gAaYMZKG3/ZobX1IsQdR9Wac
         3OhIaZ2MsT0VfSiMgIKxi8hcfUMy4nYhm19Fg5ZJPmgTlhAo4ww597PnnzO2Dl24JbbL
         ydGmBKX/pyziWxnVhybVVuZC249DX0Iy0/jbiDmUDfhR6sQ8YPq72hl5wgILL9xkKd06
         NcvA==
X-Forwarded-Encrypted: i=1; AFNElJ/Kaeu3ng4euLMBJXEPQPwhgS5bUgOq5K8CUI9E0n0prSNQJIMW9FmObUlLUMPOf13vcH5gVM3GS3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yycv4Rw0iGUJutQ24ONa2gcS5n4CITa/ZzFP+AdgaIBnwQ6x4MG
	8nDoEFIeGnkWtbl1y+lh6gxyTULMHAcKVm1YM+XU41XrYDeLyaeya25+
X-Gm-Gg: Acq92OHzJdZQP/nEA5o4nAF9FO5YM/MsbUrsVtvXKGTdoLT2zUkeDqY5hrGRjg/qV1l
	8Exw3YiRJ4G4NvnO6pWNuhT4o6uCkBrYBUdNpjbVSFT4IaOpp086Zj3v2wrMRkFeyMnntV0TNtt
	DI1TxBe1OhRLlgpmya0a2ICzR6O9GCy6M7d2JlcTdLOO/Q26GElPKMVG0zOI+Nlipi21dbG9xeg
	AvrRpRmfi0gqot8zIaikgs5Pjc2se5E0PZ5+0N+EnvdAqwDFuJWRrhvQMo9O2XBoLzi4MFJB9bq
	V2Xl+Gy/HfWu1Yxrw1+x7qt3Yp6i8XBzMr5ZIXjzEteXVCUOfxi7ZLAggJjk9b6nUx8kUNaDS1J
	pf6IPfpXkwYTmxkVGUnMjIeiB61orX3UwQqixv3RVpPqLG5LDGpxKUDJYx/GufyRxghOZwnHRCp
	HUzLRW9uSzoaKgL1uCDqQcb6YJ+4pGVcS3UDygPZ4CZVlwqjAP6+3cGrVINIXLsYMJTg==
X-Received: by 2002:a05:7022:2397:b0:128:bae0:e03c with SMTP id a92af1059eb24-13806726c70mr13862240c88.30.1781065473990;
        Tue, 09 Jun 2026 21:24:33 -0700 (PDT)
Received: from localhost.localdomain ([76.32.119.210])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1381495bb00sm10941619c88.3.2026.06.09.21.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 21:24:33 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 1/2] iio: magnetometer: bmc150: sort includes
Date: Wed, 10 Jun 2026 04:24:17 +0000
Message-Id: <20260610042418.90308-2-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260610042418.90308-1-dennylin0707@gmail.com>
References: <20260610042418.90308-1-dennylin0707@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sort the include list alphabetically.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 drivers/iio/magnetometer/bmc150_magn.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
index bf2551988008..6f2a4a863fbe 100644
--- a/drivers/iio/magnetometer/bmc150_magn.c
+++ b/drivers/iio/magnetometer/bmc150_magn.c
@@ -9,23 +9,23 @@
  * (C) Copyright 2011~2014 Bosch Sensortec GmbH All Rights Reserved
  */
 
-#include <linux/module.h>
-#include <linux/i2c.h>
-#include <linux/interrupt.h>
 #include <linux/cleanup.h>
 #include <linux/delay.h>
-#include <linux/slab.h>
-#include <linux/pm.h>
-#include <linux/pm_runtime.h>
-#include <linux/iio/iio.h>
-#include <linux/iio/sysfs.h>
+#include <linux/i2c.h>
 #include <linux/iio/buffer.h>
 #include <linux/iio/events.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
 #include <linux/iio/trigger.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/pm.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
+#include <linux/slab.h>
 
 #include "bmc150_magn.h"
 
-- 
2.34.1

