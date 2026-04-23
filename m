Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409AD3806C2
	for <linux-iio@vger.kernel.org>; Thu, 23 Apr 2026 18:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776969244; cv=none; b=TtGccuR/hgfsGpPkX3qt4e/avD1E6BOw2BKXahZfcgr9EDJFN3cko58DPUS9d3DSwMLg1azknnS4nOQfKXD36MeGAaTJ8/0RLyGz5Kteob1bx7w+r+pnpr+lD0716+kHaiVRPJHLJgQZqpuTdQFFl4DrL1dGbP0y6XDC7g1mbcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776969244; c=relaxed/simple;
	bh=4qsC2QOJs0CGRMTwNqZMfrxqKej/Ljowy7jv4nTaHZo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lD6AfNeM5QW6HmRd05wf+h7BHDNWsAKjDYOJSlxe9AZB/T8dC03wKE+sCOkjvBt9BPDcG8n6zAKH5lHSY2DqmDpLO0/xpTN6yArZwtr+nFt4bRnA3eAubaS3izfUX6qbRvHyZlDDmYV17rfKs9DciAemaAalHRR3zPwGG29A++o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=vwcN8arf; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="vwcN8arf"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-12c7212836bso1181979c88.0
        for <linux-iio@vger.kernel.org>; Thu, 23 Apr 2026 11:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776969240; x=1777574040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aCUIQKGwjYWyiYUETBzXQ2kYLoZVgqeL54EOmI3cmaM=;
        b=vwcN8arfFj4eK/7543qX3muBUmqkvdRE2MR/fVV6kuMfF8z7/DwsxnQX+X8KW0X6G2
         NApjx0V7Lc8fmiDU0RXswJYL5BtLsDYXlQLEOIRQ8NtAuRUgkFwqVjcQu2uUOcJvd/Fh
         iE+47H1qzk3Xk4wKce0GDnp4PDbemhdADpl3ueDpqRKKQQgI6VwxaYDrxbH7sPBLGx40
         s4glJZZNFWHdb/IML5Ga5kOmIi4pT0aG5bSKQL5HzMmqhp+cIu9S6RNMHZ0WKQZ0gLkx
         LOiwxAY9iis/nRCad4U3pawa7oRBSJeixNxKmUqeZmwVKGy5bY62Mq51Vq3jL5hy2gkl
         OiaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776969240; x=1777574040;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aCUIQKGwjYWyiYUETBzXQ2kYLoZVgqeL54EOmI3cmaM=;
        b=bJCSmoUsLVPaTDMaIpmQt4Zs9DX0onyG92f35m5uTD5Hz6CP/qjJdXzyNDZ8IG1gZN
         3EEwFImRucKgWOfF6Kxh4XlHZ2NKgl/CEaMKWuIGZ2p+01AvlJOKD/nPNMybPI6h3Dka
         og6sKqz7WlFpnvmApurJ2grlLEqlkUtmwl77a7MwZWDomr1f8GyVrIj1zFO8S1O3lRD4
         TTUk9vQmDEqcUj1rSrCImZhP8LAPU1K5CopBhg1BanIC/AzVBvki/y8ui4zTga+powN3
         kQWG+vDbpchRXBCq4rTyXLzRzyOXkHhzl9OruL/7OZ/rykHaLF5XC3/RRfnzbNnbR1N5
         CQGw==
X-Forwarded-Encrypted: i=1; AFNElJ96oWwKt4jXiasTb2dAgFBOmzzja3bztx6hKpAhIPl+5r+x/tV9I4lz3DRdudXaPxxyf7ZVeUks2mA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdO4YFz/0qjEi4JEQcnzEumgYRCqVTOLKFqv8DZpCZ17HrSyLx
	d4d0CBtJl4abwlzL/WrWbRybaUQSNiQq8283h1yD0ZDpqToT7MaQOSCm37M96sx+g8Q=
X-Gm-Gg: AeBDiev4stYUUqf03347rE8oUhNcksFgA4GfAugQ1r/i4WXTzNs3Rb3a8Xu5ahfrvC5
	xROVC1tVCoZu8kxYfIMQCkuedAZDYpDxqJSxQROgbpeBjpL+lkALUXJzT7wDUIHyrtxUv+m+GYW
	/WQ6nGT2EBpeG8lMynobLQfMFspk4sh0vHG1Ayxx9drj6rsBTdsLg3DJ+oC6+mr8yWf+ipP87s/
	WyvrGcWguv3pRpMbl02e+iQsu8gd7ZIrJ5EIJN66qO0ujmOzWGmetnnRrcElWkF0knso/y65wP5
	QhAVNP/uoNhFQ3OIMVyy1UcJ6OTeSG2jWVl13XatE6bInckP6ObtjqQTK/ZquhOcRssvUOrZ9S0
	H6je1BjFFIVUWKFY+GKH+bh9P7/KY0AqWfcfFBCQYA0Bqj7ek8G/n9jc7YCBpHGgJdaPH2bN37o
	1qHHUsLbdzpLOU02sSmp1wCqYq+pEhLr1a
X-Received: by 2002:a05:7022:ec09:b0:12d:c4a1:2dd0 with SMTP id a92af1059eb24-12dc4a12defmr436977c88.2.1776969240164;
        Thu, 23 Apr 2026 11:34:00 -0700 (PDT)
Received: from eileen ([38.10.152.240])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c74a20eb5sm36357934c88.14.2026.04.23.11.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 11:33:59 -0700 (PDT)
From: Caio Morais <caiomorais@usp.br>
X-Google-Original-From: Caio Morais
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	michal.simek@amd.com
Cc: Caio Morais <caiomorais@usp.br>,
	linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] iio: fix header includes across multiple drivers
Date: Thu, 23 Apr 2026 15:33:41 -0300
Message-ID: <20260423183349.636757-1-caiomorais@usp.br>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Caio Morais <caiomorais@usp.br>

Remove unnecessary includes and add missing ones as reported by the
include-what-you-use (IWYU) tool.

Files changed:
- drivers/iio/adc/xilinx-xadc-events.c
- drivers/iio/buffer/industrialio-triggered-buffer.c
- drivers/iio/common/st_sensors/st_sensors_i2c.c
- drivers/iio/common/st_sensors/st_sensors_spi.c

Signed-off-by: Caio Morais <caiomorais@usp.br>
---
 drivers/iio/adc/xilinx-xadc-events.c               | 4 ++--
 drivers/iio/buffer/industrialio-triggered-buffer.c | 8 ++++----
 drivers/iio/common/st_sensors/st_sensors_i2c.c     | 2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-events.c b/drivers/iio/adc/xilinx-xadc-events.c
index d16e61953..20b796ec7 100644
--- a/drivers/iio/adc/xilinx-xadc-events.c
+++ b/drivers/iio/adc/xilinx-xadc-events.c
@@ -7,11 +7,11 @@
  */
 
 #include <linux/bitmap.h>
-#include <linux/types.h>
 #include <linux/errno.h>
-#include <linux/mutex.h>
 #include <linux/iio/events.h>
 #include <linux/iio/iio.h>
+#include <linux/mutex.h>
+#include <linux/types.h>
 
 #include "xilinx-xadc.h"
 
diff --git a/drivers/iio/buffer/industrialio-triggered-buffer.c b/drivers/iio/buffer/industrialio-triggered-buffer.c
index 601a26398..5796c9da7 100644
--- a/drivers/iio/buffer/industrialio-triggered-buffer.c
+++ b/drivers/iio/buffer/industrialio-triggered-buffer.c
@@ -5,15 +5,15 @@
  */
 
 #include <linux/errno.h>
-#include <linux/linkage.h>
-#include <linux/module.h>
-#include <linux/stddef.h>
-#include <linux/iio/iio.h>
 #include <linux/iio/buffer.h>
 #include <linux/iio/buffer_impl.h>
+#include <linux/iio/iio.h>
 #include <linux/iio/kfifo_buf.h>
 #include <linux/iio/triggered_buffer.h>
 #include <linux/iio/trigger_consumer.h>
+#include <linux/linkage.h>
+#include <linux/module.h>
+#include <linux/stddef.h>
 
 /**
  * iio_triggered_buffer_setup_ext() - Setup triggered buffer and pollfunc
diff --git a/drivers/iio/common/st_sensors/st_sensors_i2c.c b/drivers/iio/common/st_sensors/st_sensors_i2c.c
index 6ab143498..974e349ae 100644
--- a/drivers/iio/common/st_sensors/st_sensors_i2c.c
+++ b/drivers/iio/common/st_sensors/st_sensors_i2c.c
@@ -10,10 +10,10 @@
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
+#include <linux/iio/iio.h>
 #include <linux/linkage.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
-#include <linux/iio/iio.h>
 
 #include <linux/iio/common/st_sensors_i2c.h>
 
-- 
2.54.0

