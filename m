Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DD2367F53
	for <linux-iio@vger.kernel.org>; Sun, 12 Apr 2026 09:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775986691; cv=none; b=VYTyzE6bPfrBAw/saFZsCU6XiZX5ivBB0WmdQVkI9mzawKrnkAipprRzzunByNZ1CpjjXIphbfhAkueUmkkOP72I8cEfLqfBqiB8j76t0ZcKuvW5sNJIMhub3yU43Uj9CNK27ScwY+kgk01XVI6a+jqkWg+rpReeAJT/BCn7EkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775986691; c=relaxed/simple;
	bh=66d0P0PAn9Tlw6ElUOtNk6ATPYX/gPspPgl+2G1pr4M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mKZZ7/ul5BqVyZZvAry34tiJOVw+E3ljuEM0I6VP0PgF4wkoZbJ1GPbUe2bfb7VQ+pu1uezEQynjuvuW5z4Cp9guyULluV1jbe5fkostCHGR93/i4CuRo2SZvfvSJRlufpWT6o+k6X11nb5O9KAthEuvXDKi8XTYHtWwBo+Tw9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AhC2gT+V; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AhC2gT+V"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82f351ca23cso110097b3a.2
        for <linux-iio@vger.kernel.org>; Sun, 12 Apr 2026 02:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775986689; x=1776591489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L/O/blVFIoopxT0bw2o9ftno7RBysSZwHamFsCbrXTo=;
        b=AhC2gT+V9c5cGsYQzHBAghOxz5PPdOImnwMt65S9dG7IUZIGKJ6vC+s/2AuKPsLq5I
         OpGYPfzfzy71RlCvlO5emiV5P4gCwC50KBM//g/NeawSCPUSDZqBhQiUdpLQoyHFLNl5
         cRNl85asuUB4xhp0KQeErizM9LqRLPMgtz6HQGY0CM4PmJBcjs0lSxNpQYZcR1S3WEGg
         4cgZ8GIBdP7v0YJNqSy6LAH72v6Z8+t0Ca6GXnpGPQu6upk2Gn38ZCSfxToILCyCk7om
         RnVZKDpp4w2l/iVLHmtxb3sfdL+85KVJD5rlbXf+5VcBN/LTHpDCwo7E662MpAoDI5Y4
         4Lug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775986689; x=1776591489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L/O/blVFIoopxT0bw2o9ftno7RBysSZwHamFsCbrXTo=;
        b=dsYwqFOfSfpvGY0Kat8p6iuItjx6fyGuxggNijMplLuRnb5QEBvtNNyt8505jcOuy4
         rRrvUmwA/J/aM52xaIXLGycGfmkIFxhvPUSofyjbtkBrTHErmWschea4wv6ClDkyVJYU
         Nxkaghz7V/YUQGMTvdtglxqWhfZgMPIBQozNAyhO9y6npZC9CsP59ns2FTe57jANKSfX
         VYvPKbsfMjcMXxhCnDssyE7zROiy8N6VfKGj1NDAlhJ+k92SlRvXsIJM8u/lEr06/7Zd
         n1eQU5cXYknl5dJxKDIzT681iXlGiS/sW0hbwJG4S/4v7/dFGkwIwfKPZK2V7C0hvxdl
         AD0g==
X-Forwarded-Encrypted: i=1; AFNElJ9ra79/VLXlqbEJ/qP8kEkSkI7756KcZfXq9ibP0jVIwctbtUj17qdFav78OH4UghlVbq4If0+NgWk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1YXDXEHUWFtp7JnpbrruJuhgadWjMiB9axqbmoVprOaTrwcOC
	Ggpuh0IbX6abOPvG5YpPnSDAhf5YhAcuq2USHOm5CmouvYHA7CSkAcYMCVyGqJIX
X-Gm-Gg: AeBDieuuGixc3fkbSstSsLAJ3Mw55xsDy9qEIY1guVMboqOskOa0y6ZFOOXUmh88qZH
	pLusd1X6nFqp0vyDb6dba8rUamampzBhIVPAyoXDxsOjE85LvdOz26aZ5d38M3BkAsCXfMqaUkz
	94+1I0UGegakEmKf+S689oryFnmS2veLAwPc0TBIVhzP8s4htqHNszAN2tbqIJuuuGYl/EHuODw
	2Iv6/HbGec7z55CkNYWcGATmCVnv/ZKy2wWbEWGX36fGXInvcruOpJA2ul9LoQ0Nbsir56jN2WA
	JhfxCFq/Rw33NadMiiQ0v9ITw+tcLTDyiLxapdwBZX39bUTFxZzvoCGmygs7YK4mO5KViiD4Bs7
	eZiIWCvA3/SOVGiAX6BsQo6XbsNVxvW/AQKi3seKKCpXMnThfln6vCmeHPFsfaoyEk6cKhqMIIk
	jfz2CoVBAZELStyJNXifMgGB72xAzxETq5Xae1DyqPHWowNEsgfeDUvN9a6lE1hrsMg7fiCUJX
X-Received: by 2002:a05:6a00:a86:b0:81b:c2b5:31a with SMTP id d2e1a72fcca58-82f0c40d36emr9398443b3a.53.1775986689333;
        Sun, 12 Apr 2026 02:38:09 -0700 (PDT)
Received: from debian.ari ([152.56.156.42])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c36130csm7885038b3a.24.2026.04.12.02.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 02:38:09 -0700 (PDT)
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
Subject: [PATCH v8 1/5] iio: adc: ad799x: sort headers alphabetically
Date: Sun, 12 Apr 2026 15:07:35 +0530
Message-Id: <20260412093739.17116-2-architanant5@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260412093739.17116-1-architanant5@gmail.com>
References: <20260412093739.17116-1-architanant5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reorder header includes to maintain proper alphabetical ordering.

No functional changes.

Reviewed-by: David Lechner <dlechner@baylibre.com>
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

