Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E6C3246EB
	for <linux-iio@vger.kernel.org>; Sat, 14 Mar 2026 17:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773508022; cv=none; b=nKEbh+Z9+fjmGWijLrUVATWUrI4G/sj+adzW5E4Tm1/1Poj/nHoHhJr+h2oTUMKnz+mJKZexQw3XDePDSgjRoGs4XIIMPU+KUVI2y3J+zarglywi/+df1GLNffc8mZD9UdxC9PyuFX67+1FG7BMDQ+KZAqm2MiGWSmUJcAEf9T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773508022; c=relaxed/simple;
	bh=KE7Z7cx4nctVTMLw7OR5xaT3+rD4CxWaBg7rIVfSHC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pXZAwF2GBKd3KU8tiBtiZSMoQ6Wh+x2oAShY4E/2jac8sBIpfRhQyoZUBAHTrFvH/c34gKn/iWjzLoHqJaXGiN+Oy5iefxTCPsPGBwY4vWKbSt0wwsT2GA1KHwN/qEDkfijy7PFh7ZVuGn54BMI/owzuJ5PCvZ5CQbu+fDKkvzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jB2L9GcO; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jB2L9GcO"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-35a04d6aeb0so1972433a91.0
        for <linux-iio@vger.kernel.org>; Sat, 14 Mar 2026 10:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773508020; x=1774112820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O0WZvcr8z2ScNIiVKlO93t9t9l4r1I3AeV73VTHXtOg=;
        b=jB2L9GcOeDJaYTfa/vg8Fvc/Zj3cdqnLAAo5g3rVaJdv+vepj+VkjNciJ+5akXEhR2
         Vl4hgZrF0el8R/jjVQ5zxqJuGWT7W+4z6AyEDBc1/RwB3T3YKaQhxeyZwCAOsXH0KHap
         WvpkXn6sRuh3TQHZag6zTXA1wqfCKkTgVr6QzUoR1UBuSGxLz8j2ZV5om8uA0NMwOtWg
         hbEziTV3OQRKAq7lO391gHyxwYLocghvezoMjU/gIAPILlbwKE1hYZ+QDViTKjM7zAKq
         pynbkpnwYvfVE8k9ncCTO4ZHX/Mwuh9EukUlC/3kqXELB5WG4FD7QoRl8SWDmZEJaeGl
         8W4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773508020; x=1774112820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O0WZvcr8z2ScNIiVKlO93t9t9l4r1I3AeV73VTHXtOg=;
        b=HBM5C4gdK5fHmnHTC+48bU3Nyr8eqW9sJBEPOJe9nShzjBdykpyKfw4bfUXK6LISMz
         GQ7U9hv7+qUcOc7fAv7hqFG0OXBP6NfgJyq3qfXnHPsjgPGYvOCoA5VWJZTXoryzSew3
         V6819Z/wWNwvJmBMQmv+orGa4xoAI6lSsAfZ2VqgJQoOT/PlTGcS235qSMcwd9SjEyOG
         PhLjtgAzBf2MpcS5HXTC/IXSvsvTK7pIWKKUjWLHAayA9DIUmMqoY6lI8i1SpVaLf9CA
         i9g8KVRudWcuRSyzjWgFZNpHP1BlVhNhxBpLJtVUw71C5dyy7UNwa3q2rQ7c37dVjNwu
         DJlA==
X-Gm-Message-State: AOJu0YxkSV7z7QpefCUsa8hblS1HR5SNDxTShGa+yCp6H8G95WeHSJMg
	9hRb5ZdaWO8gVnNqwLf3YU9jwHivl8rEpd4uDQcJfP/zddIpLuQQEX3z
X-Gm-Gg: ATEYQzwY8nZTkW9Mv0398W7mUisyrn/Se5HVXv3HUEmDzzy/f7xmG/mNawWC8NYlLhJ
	8d5c0SH09Bnk5NO4oZ1ABi9PnLlKLlPnePiH22RZ1QzG0r4dLwyzuhN/gc72CQLtrbByEMVMx6R
	iRDgvzl020qP2bio8QyPRj8u85/HPjdT5oc18/Q03yPJJYCvePOWdacAiDZ+OWpjh5C5xeLHwC7
	U7XrmZGQLt+bwi3HHxjOPEwsBnb5RuypJdJRzLyMmpI900/aUmUhPq+Bcqy+Vif0ErnbSFq8Pbx
	xaMOXatHD+CmN4I5RzY37Ui93RYFq3JebdN54P2IvpVBx4gYMK+DnMTEbCUAa0vYpvjKOI0L6iH
	kjLxwxCuDAkn66Ums6DbqDq79gAZRJi1plcuMT9/+u6rSuq3Oa4I+xApcffK0LrjDYz1p7LmTPz
	VcmZfO5vCZJdP5yQgSLu9C41hCbWp1qEx94BKL6xOIrq/X/aTqCi0AHReG8E0zEsIGJbYCEo3jv
	y+Yi8pOtEGcooZRLrUAUjO6iz4=
X-Received: by 2002:a17:90b:1b10:b0:356:3ba2:122c with SMTP id 98e67ed59e1d1-35a21efa8cdmr7049842a91.9.1773508020512;
        Sat, 14 Mar 2026 10:07:00 -0700 (PDT)
Received: from fedora ([2401:4900:8898:a35f:15b4:3058:14c8:4287])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35b90d3f572sm1600116a91.14.2026.03.14.10.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 10:07:00 -0700 (PDT)
From: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	waqar.hameed@axis.com,
	linusw@kernel.org,
	sakari.ailus@linux.intel.com,
	harshit.m.mogalapalli@oracle.com,
	antoniu.miclaus@analog.com,
	andrew.ijano@gmail.com
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
Subject: [PATCH v4 1/8] iio: accel: bmc150: sort headers alphabetically
Date: Sat, 14 Mar 2026 22:36:02 +0530
Message-ID: <20260314170609.26827-2-rajveer.chaudhari.linux@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260314170609.26827-1-rajveer.chaudhari.linux@gmail.com>
References: <20260314170609.26827-1-rajveer.chaudhari.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
---
v4 : Patch added in v4
---
 drivers/iio/accel/bmc150-accel-core.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 42ccf0316ce5..4eb4293a741d 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -4,23 +4,26 @@
  * Copyright (c) 2014, Intel Corporation.
  */
 
-#include <linux/module.h>
+#include <linux/acpi.h>
+#include <linux/cleanup.h>
+#include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
-#include <linux/delay.h>
-#include <linux/slab.h>
-#include <linux/acpi.h>
+#include <linux/module.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
 #include <linux/property.h>
-#include <linux/iio/iio.h>
-#include <linux/iio/sysfs.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
 #include <linux/iio/buffer.h>
 #include <linux/iio/events.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
 #include <linux/iio/trigger.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
-#include <linux/regmap.h>
+
 #include <linux/regulator/consumer.h>
 
 #include "bmc150-accel.h"
-- 
2.53.0

