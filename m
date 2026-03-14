Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE40326945
	for <linux-iio@vger.kernel.org>; Sat, 14 Mar 2026 17:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773508049; cv=none; b=cRVy5hUM9tUEI+gqa28P3GMt6owhKdZAbtz0L1rh1hsCBYU6zgDFNBmeH7CeUD+q1LpNhiJ9iWeQBZA2w7UrY8G+79+jWWZEOV3+NlaaUTEUCVv0ftEmMCkjJxOOFeZFeBYHyRDl8WQrGsV049A92URx4gGRv0rCU0CSEINdOa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773508049; c=relaxed/simple;
	bh=JO2lgHGjI/H4pkBrT3QY9+E0yEWU3kAxLNo0zyIutmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C22G0ZPE5Y+8zKgEhKaVaCOZQ7EI32X0eJBMr7LYI9CCS6mWaIEJUu+mMobKquuxubN9IpMYw8tNGEoWOoZFUOv4GbqFyBuqX3/wuk+1yJzAaPV2FUBAHMoO9BZklFkUPf1XXHRhcmI/+84Oy99khPsVLuRsWRp6g7gy2eMk1XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cli4eewq; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cli4eewq"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-359fea895b5so1844777a91.0
        for <linux-iio@vger.kernel.org>; Sat, 14 Mar 2026 10:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773508047; x=1774112847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GCIZZ83Yc5ssG2jBwGB0tj+l0UN5cE4lj0Bvgi3e/Mc=;
        b=cli4eewqiHZekJdNWxrAxmPyLcA7m26ylsAgS4YmFK+zS3RRMCpY4srVSK4V+1ns3k
         xcdDCkB/OIF5JEaqi2uz0Wps2E3GlVq6i0t81sVEaF7v+E5ys/1VqyFLMLQiO6787Hau
         yJdSDKSgOOYRGlFn7fZHSrHkWB/r8YgSd8WAxDb1s2TxmPlNptzaDPGKQoZHRA10Ej7M
         xmyzQ1e1o46sLH6B8i14U8R4DKWzVcRKrl3aeowMDj1yuSX1fReGo7GeTFlGB85JDnhG
         sGzvUWvckK7nkLpPCZwuy2WDkzIjvIFwOC4errWeKq3K3BG4QZXylC5aHRFtJmlCcjB5
         HcBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773508047; x=1774112847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GCIZZ83Yc5ssG2jBwGB0tj+l0UN5cE4lj0Bvgi3e/Mc=;
        b=R/tJUanWOwp+FVPWfLiVDVRkHIemgeEMm+rvMY48ylFEQDuW6DA9/8gbBZAxbUqaxL
         u7QkT7Hdwpd5rJQPTjk08aoUmEF9CPvkPV9uQtIgPbWgxDqqeA8pB+ziITv0Ge3fLcpb
         qYJKvUcO1r2UQdyveY3TEIujZx6XBsWIjwcYNRN8+STOA533vf+W2xfqLC1RySrit2l7
         O7e/6Joj8dlu7T2P8N7h1j6Cx3Crsl2Zsz5+82rvkCtuo/0uBD/O81oeNfazTjKU5s46
         M7JydfgW6bjtzHbozkczsO37713Is0LoplvzuR+qXc1mg3r9ylh01TCra99MIrlJlDrk
         ByXQ==
X-Gm-Message-State: AOJu0YxoMu0ibi83+3sfGIl5S5uL7J7NyzNiK1IdjC1ZEkF3ZEaHPhVR
	KURQ5kxZfT0VL5TubNEUjbiDpJ2fNM0A6leON0fiSWVyuCygbJ+y0prN
X-Gm-Gg: ATEYQzyPFJvJPb3mY5SCbR63NJ03Y7vfVmNxUI8oFEfcNSrSus0UqcD4+bg62FaDMla
	4hEVyR22MGg4fXdWJpY3BL7JlRr45iDEyW9FKoW1h2olZjHatEKipriwSEm3dyyubOKrFhzfre/
	DJCH1/+a6jXvqUq2+6dDttV4tRpOiJ7V+P1sQB4G4aK/G7gGmZxpeBraOnu8wQBPVh/G3eh3ih5
	Oow4nhJIJ/oQYhvUeA/+8ESv2qyRQND3tfz7Dud8Auhi4XB79C3Zlkv76p19jy1QRiYAmM8dpgw
	Qyj134nYbCp/peQG2GLNBXmm4gEEdiV0OAMRC5YiMwjokWOzHY/DW3TsGIZWrJmCRdzLhy6Rw2d
	W2iSjdG9wKUT6KnaC2+gyWsGAsjmDbqPdlaHnRNwcWRaCXUBp88Hb/Btcw5EMcRIucvn8zpDDpL
	izYt1zs6qRBQRKfapPPtwk8TZ4AAk+dx1pTA+5ENI88FuDQnJ32RSP47eBRw2wSKorBrGd5vLdZ
	FHVywaXwEzIpuk7Zd+dthlFms8=
X-Received: by 2002:a17:90a:e7d0:b0:359:ff8a:ee46 with SMTP id 98e67ed59e1d1-35a21e30c55mr7411173a91.3.1773508047470;
        Sat, 14 Mar 2026 10:07:27 -0700 (PDT)
Received: from fedora ([2401:4900:8898:a35f:15b4:3058:14c8:4287])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35b90d3f572sm1600116a91.14.2026.03.14.10.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 10:07:27 -0700 (PDT)
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
Subject: [PATCH v4 5/8] iio: accel: mma9551: sort headers alphabetically
Date: Sat, 14 Mar 2026 22:36:06 +0530
Message-ID: <20260314170609.26827-6-rajveer.chaudhari.linux@gmail.com>
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
v4: Patch added in v4
---
 drivers/iio/accel/mma9551.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/mma9551.c b/drivers/iio/accel/mma9551.c
index 02195deada49..31e5c3699c19 100644
--- a/drivers/iio/accel/mma9551.c
+++ b/drivers/iio/accel/mma9551.c
@@ -4,17 +4,21 @@
  * Copyright (c) 2014, Intel Corporation.
  */
 
+#include <linux/cleanup.h>
+#include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/pm_runtime.h>
 #include <linux/slab.h>
-#include <linux/delay.h>
+
 #include <linux/gpio/consumer.h>
+
+#include <linux/iio/events.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
-#include <linux/iio/events.h>
-#include <linux/pm_runtime.h>
+
 #include "mma9551_core.h"
 
 #define MMA9551_GPIO_COUNT		4
-- 
2.53.0

