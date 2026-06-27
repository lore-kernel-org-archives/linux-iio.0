Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A48374192
	for <linux-iio@vger.kernel.org>; Sat, 27 Jun 2026 13:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782566745; cv=none; b=qRg2mmYKuESpKlzlbZt6FLnkMu16utEhBisWezrZi7Tjf2HReksJNh67D5LtrF8g5TqhU2uTNmCe43nnqFQOW50UxLFt0Qs2xfmTANtK+8TYTWw9FrtuiyNqMBW8OGf8Z5r9T+KbT3/lwbBnBBEFgMHXM6gLWKLjlvleJWpWJeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782566745; c=relaxed/simple;
	bh=4IYaij18ypA6Oo1THTT+b/9xlPWdX5l6ib0435mY5YU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TNb+UuDk+Ab/LebeUc0KU4VI9FXNuJHhsExYaGqkJM5kBOtt3VYD0a+uX/Y4beQ1dNrJ1HOciwnKqL4jBt4kWcXeLjr2FsKvUrSD5Qc7Ky1ckNeu2HG/bV9RD9F3FHZvkyINcSQ4DWoHSBl9zN/H0S2dpxUHKo5QbwYBE7ippRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=LqeRXXB/; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="LqeRXXB/"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1384ebe7a10so3179010c88.1
        for <linux-iio@vger.kernel.org>; Sat, 27 Jun 2026 06:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1782566742; x=1783171542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GblxmKiRfcm1lT/JcVGoUyhh/yQstrpEWtgXJsE2xT8=;
        b=LqeRXXB/tLEmTONXqfO4yQ0d0Fe/er6zqTyGAM95pQMquOgREmlkxXuSL5uJeZQMt4
         Ni9t/AC1n3a8UHEe6X/x4kmG5ZGnxwCKVg2NXK3SgIu7TdYuHcr9zk8o8dRq1skNJ2iu
         Pi4rL9Di3tGvwb/QYrGhqgh+tigePTweditfw28LNEtpZUjbThaL6mgwiAi90chrnPuY
         zBrSde0mYFlU3xGc9ztmQqtOB3fzeHaOuBTG3O2mpU5heFILALLuHnQFlmszfrsXOu6w
         fKX7s0CVu2GRrbYL23NLUsUEOTGmWMUdKgCAlcH0FVGaFMw/p7qvoTtx9dVfXTqDcCyn
         l+zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782566742; x=1783171542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GblxmKiRfcm1lT/JcVGoUyhh/yQstrpEWtgXJsE2xT8=;
        b=laB4j/C5IbsXB20Eq/VOyfLIVGe0p8gPPy+GqSqU/GPa1+KVp5cAGNTeG+hUdx+ZWy
         rhh2D+8g2E/5ugIGn9g500mhhKfSkVDBQTFS0ptn6TTFAyB8Wu+pW9YlC1si//G6Js50
         N2U5p+6ey7e/wHzlAThsqYgQDTTiYAQboi3eGWbVFhzy/3DQ7D9xS/qKjo7seSIT8puQ
         tHxHOUCMWF4ZPIejvv4uX9VVEqrZ6hbKSSfwuSZnGkW/5A+BA0AdK4JmfqxGnMOugaly
         JesKivCY2BLJ2Cg5r2BPPCJ8rd+4ImJJ/S7UCgs8Uc4T7Oto8Vnul0UiuKbRkvP3dILJ
         ESxQ==
X-Forwarded-Encrypted: i=1; AFNElJ/s/z2tjOIp6/NE/TEBauqAakLo39faSN01mLSYvtyE8XHZKxEqpjeT4K0Wcr4hahkVcUzpXkb1v28=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmLAUXTy2IdYcBf+7AAbMbouXDBcMo1qCTN1fdXIecg3LOviS8
	gvSmy7uvLtzxJ5PoqTByFEDR2rY6NQjmyOElTp8Q4lG9etURrqMUpeJYb5UE5Ii01VI=
X-Gm-Gg: AfdE7cnjjs1EioR5f/7V4aZlIwUwDWpnquzxGvBvOW3M0FFIEPbxWSVtMx55C2Szqfe
	BALs5XYkPbjZ1MSLP9vwHEhxz3etePob302V4KS3KvnyHi6J0hCCyaMYgabQFSdZTa8M1zRUwtd
	X5dQmxKTLBPHVr7/C1gnfkvnPfsyvaPEjTRUF8+LX+IK5Q7jai6cwUQwiMYL3PkYYOEbQpKqNai
	BjvdZscuJQ5mxzefwmWayTpBtekOx72naS5Vj1rOA6tTxtL56rxnxLSS9HpgBetP553A1lVIDD4
	VnqGD458IZ8bi4PpN9HchGUQuLJrDTxqA16c8KBnZ2N8eK3WVnLjFkQw0mfXDjH6swpHLZ7rgTk
	kC0CTzV+XBXI8QJv+dZrUi4BR85YB4OP8HRQmhKRvurvWgBBvCtNDB0/P6eZdfdxV2mDZKBmnEv
	Hwfqh1QN3enzQSgJXb0uqDNklep0Y=
X-Received: by 2002:a05:7023:908:b0:139:ed5d:3b7 with SMTP id a92af1059eb24-139ed5d0629mr2689711c88.48.1782566742017;
        Sat, 27 Jun 2026 06:25:42 -0700 (PDT)
Received: from localhost ([2804:1b3:aa80:ec21:dab8:1927:ea27:9d41])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-139d90e95c6sm41183098c88.11.2026.06.27.06.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 06:25:41 -0700 (PDT)
From: Erick Henrique <erick.henrique.rodrigues@usp.br>
To: jic23@kernel.org
Cc: andriy.shevchenko@intel.com,
	andy@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	linux-iio@vger.kernel.org,
	Erick Henrique <erick.henrique.rodrigues@usp.br>
Subject: [PATCH v4 1/3] iio: dac: m62332: Sort header includes alphabetically
Date: Sat, 27 Jun 2026 10:25:28 -0300
Message-ID: <20260627132530.96680-2-erick.henrique.rodrigues@usp.br>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260627132530.96680-1-erick.henrique.rodrigues@usp.br>
References: <20260627132530.96680-1-erick.henrique.rodrigues@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sort the existing header includes alphabetically within their groups.
No headers are added or removed; this only reorders them so the
following include cleanup is easier to review.

Signed-off-by: Erick Henrique <erick.henrique.rodrigues@usp.br>
---
 drivers/iio/dac/m62332.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/dac/m62332.c b/drivers/iio/dac/m62332.c
index 3497513854d7..56cd0081afde 100644
--- a/drivers/iio/dac/m62332.c
+++ b/drivers/iio/dac/m62332.c
@@ -8,13 +8,13 @@
  *  Copyright (C) 2010, 2011 Roland Stigge <stigge@antcom.de>
  */
 
+#include <linux/err.h>
+#include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/slab.h>
-#include <linux/i2c.h>
-#include <linux/err.h>
 
-#include <linux/iio/iio.h>
 #include <linux/iio/driver.h>
+#include <linux/iio/iio.h>
 
 #include <linux/regulator/consumer.h>
 
-- 
2.51.0

