Received: from mail-dy1-f196.google.com (mail-dy1-f196.google.com [74.125.82.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A6C370AE4
	for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 04:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781066336; cv=none; b=b4PQF9l/U/5oGDW5VRADVi8R9gGXQNDQWl8sw9QqeN7gvVWWITIa7J6Dkonta6GM5KxVGncDU7nH8DK6fpXQR7usx4MhV74lgAgHEej+J4AqMsFkuFSqlIWRFj/d3EOHk9QS23m1qcVaHa+m/X7M7ify6Yznr8oMWBwDxaCd5iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781066336; c=relaxed/simple;
	bh=e7NHbDHvB0LL9s23hKboeGP83ERY9Fa460rVgG483Sk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xej2Knv40h3w2ILVNca9AZSXJTZx/qprCykWhFkEOPogT3kToIOuPgXPg8+Y+RLASfeszL0ZxLbWtVxWEmqVGUCNivhvJ6CsCEqgl5Y+48ydDKuTLCkSmKbLezNIwxBOLcCn76PquYH1tw0ysKqE5kxIDJR2JiAnKEqhv7IM1z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jp429Trs; arc=none smtp.client-ip=74.125.82.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jp429Trs"
Received: by mail-dy1-f196.google.com with SMTP id 5a478bee46e88-304e83724bfso7890125eec.0
        for <linux-iio@vger.kernel.org>; Tue, 09 Jun 2026 21:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781066334; x=1781671134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BOyuVcPENX+3J+cj9H/+//SNzPslISxsapH678b5nC8=;
        b=Jp429Trs0Z49zqvy5ppEaa8aQwmwRh8WTjxRX886f2F0aM707YxxgwWPLStN66tsEo
         HT59ETH/BYVqglEMNa8obpMLmlN51zDK6WVqKExIuPzPiX5Cc5JiMm/iNRkbqoCACbO1
         0GmpHCf6Gu93VVVWvi33c+t4SigcMEFESovanrVykTR1nF9u/OKwyb6PU3O9dNiXyHMo
         iX1LknTOUAHMqSXU31K8/K8ZaK232CWTiFZIYQYvpjRyMRSGm+RCnE9tDBs2dnB4pjL1
         dXTM34Vd1yNApoXHUnOjLcBiaYY3wiAeMP48h7aXF4KJZLajOeJe4aoWJ1CSoqrqVelL
         V/VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781066334; x=1781671134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BOyuVcPENX+3J+cj9H/+//SNzPslISxsapH678b5nC8=;
        b=bTcWbgYQnk2NNZ4RUBG2Q6VzAf8Xd4LES0osPMGPv2r7bEooOZ9CiM9FvH0ot9afaE
         r4nmbhSEjoFdLTehyIDCaCMW2mgusLbISpMAWzhTPNOUveohEWUho9C9jD16PIUPELcP
         3K2QZZ29q/28Cu09gP9MTYw4MD+phVjmKxJRUs+IZpeUx/UZ6dzv301ZcTsCNbIlXm5j
         9KX+0UtqrGohIZD9cEyOkMMW2DR1EHCBJLQttAeqWBK3irBbCLObkH73Yr+ZI0fluilP
         VqMwclQdN67wQcsVs3UcdB5bq+UH+eGcYFdNvEzW/Hp5Ae6nFJhX/ISiu0POT+RcrI43
         9+vw==
X-Forwarded-Encrypted: i=1; AFNElJ+/kAiB6KiopuZNLDy6AU/ocoBGqmkLI/AY7RbcSzCOYrUV/GWbdblU+MDvX+ug91wr9LGV2zbUjXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YztShRJRbvIgnxSNb+UIvbnbU6tg+NVLnC59B3PLkaalf+9H9M2
	GDVPl97iwulDflwnmPZraGgBLV4Kqhd/+BMQkY9zvq//JbToy3oF2urv
X-Gm-Gg: Acq92OGCcEU/xqG0lP3Vs8Ck1TuRwd5eayusLjGTtP5U86wjWXbC0xG4NuP78UpFHDv
	L4qCmlFMnmRR/xsSeCCVwGcPrPUleMN8RSAnTi5H1gkiQg3XDGKwqnDT3PE4ZZgvoEg1De4TfKt
	nA3X5S8ZgbIlzZpdzCVU4JbT3qOEZbdJwW6R1+o9edUUv33xB+xKS9S5yespTjCXpHM6eybUZUy
	MTneaYMM1HQ70YprcdXWTgh9jhxCmbaOE4srACMBj/wIj1msLkdxnElSDfBmKgEp6tpnRN+8sn0
	qW3WobGIxOFgRQQzl/mwe4jc57nHir8oAUAqeeWPUnhhNGRx3b5NWvqWvncO89TgZtziiBAaHK3
	IyuGmtzEPjtMGbC7BZepUFIagBCXRfmjLkjfwwt7ZHdWG7GrVFbm56q+c11ZZ8/UC2rJoNy/6og
	0Smrs1aMWbcfH4eeZohpp0hpXfe/mEk9+FUer9mKF8NzX2ckG4ss5dvntpzXLrGy2bhA==
X-Received: by 2002:a05:7300:6da7:b0:304:13f3:e461 with SMTP id 5a478bee46e88-3077b25c4f6mr13146654eec.3.1781066334476;
        Tue, 09 Jun 2026 21:38:54 -0700 (PDT)
Received: from localhost.localdomain ([76.32.119.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074dea8708sm25693676eec.15.2026.06.09.21.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 21:38:54 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v5 1/2] iio: magnetometer: bmc150: sort includes
Date: Wed, 10 Jun 2026 04:38:37 +0000
Message-Id: <20260610043838.90708-2-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260610043838.90708-1-dennylin0707@gmail.com>
References: <20260610043838.90708-1-dennylin0707@gmail.com>
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

