Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B323848C8DC
	for <linux-iio@vger.kernel.org>; Tue,  5 May 2026 17:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778003226; cv=none; b=IpOGSyiRZLmVaDU698LNe1BirU2R7hyXtyrYGYtSypYUkb0Sx7F036gjd5Bd8crIiNnoNkgEt5O9dSX4Wj1c5XuOHerNLm7cdZatnLLBVi4Z13FYsO18Ll1ctvsXPR4zPEF0BJqy3cyVeYzj9uw1/UO56ADhM/yG2zhuWkllHtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778003226; c=relaxed/simple;
	bh=y8SRYHQerR/XiaUYzpkFsyaswiEukmiY0smd6M2kZg4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y9+yfRshYYYUVlBPtnl30seowbjMkli5l3N9D9ROvUGblA+lpahHQcHfPzCTGtaZwi4myP/MBKU+xv1qNwOZJatYSbTWxSc58CRfRNuTVKZB8h1XaISScfa1x1nco+r6uUaVOj7BYdn+27abnBwbvIEsotrg9VlGi8Y3OewfLqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xd6haFs3; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xd6haFs3"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-35fb0bb27e7so3654364a91.1
        for <linux-iio@vger.kernel.org>; Tue, 05 May 2026 10:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778003223; x=1778608023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2rqqPVndgRmW/1rhBFidKTKPMvulZqpEw44BSS2zn88=;
        b=Xd6haFs3+Sgs7GecZEY19xJThYvvOJmIxWg3Kjxh496kNYKz9kHCWbDh7lbv0KPoFV
         wzXPRNGYpOlL3TmRxkvnUK4qIbuQV8muaNTP4pfYhIZJEeY7BQOJbGtwrjDJx7COZHzL
         e/QKPJn0+RCFAa4A2ksC7d2ApCMdndEFUb9ylz15piUuu9Ue6EyOEfOpyTyUSSOg5Pqc
         DPHNAWgPE74id96yTg5GnmuvMYNPCou2u0DwAHyYrhvIft1D25zxRMk6X+QUtjxorApF
         ZOxFoyvbJ56gC6NuJvBhOIlj5hxN64vwFHRfdZ5T6Wia1JH+2vRCZYSdJz2j+4JFOsP3
         dBPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778003223; x=1778608023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2rqqPVndgRmW/1rhBFidKTKPMvulZqpEw44BSS2zn88=;
        b=WE4ZNmOhqb2sGxBJuJ9REJWgdGbdx3d40njH+s3Pby7BZp0rihHdXkwpbSPmk0EGLx
         qit4lHS5HvPA9ANwTOiNwZaqVqoxrIWLg1iRuWd4savfMVm07JV7qfCKovBWZUU3ZCks
         QgsSo8b35T0jWOxvBiyB/PW4ql/JkkDgRrVDocdZpKswghH1q0gWHhekn95d+o9bf7m8
         Bj4/nNTWKzgJIdccOJdZc/SPIaNGBK1PYRwdb4gHZG36XKOCxWWJNlZHl/8AK1syCqi2
         F1cMRCOwV8AkCtION75IH5+v5+LNCQeuE5VnF8UKE0VmcHwxP5+bXK5EQuCBJFNn3iRb
         S9aQ==
X-Forwarded-Encrypted: i=1; AFNElJ+j/jE49gF++UesgTvia/HskRMQ9QcJ8MRBV8vL0WIA8WCER2MSNJSW5Gw7wuaKvXVZTdB+SMutnuc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoQ0zGwDtGu9exDnGM3uJm0rqE6vQ1xyXItOam58mRoFJ2phW/
	AsQKX86NDw4ZgkBY85Bo1h7AGUs3ARTxsSB3OwGAQ/TowROFE1TF2JoI
X-Gm-Gg: AeBDietq7wX/01Z2sewyRj2I/l7J0R6ql4Zrjvp9YgSgwetzSheW7NAfRASJd0sDsv4
	aLYlzBq/VckOEQcq0M5FdcB2z5UxJL4gZTYFCjs2AAAgfL/lqQy635bxpoyJ1yyJhygxQS2SkKf
	tOxijDncoYDDr3CpHbJAnwPriI0ms6E5SERt+9ZuHXIVUq5uo27Wa4a7BIR3q/imw58CRowyTkW
	0PWKu+aft5JYvwFR7AoS1WCwkLiznZZiTrvPldNop7r9EnhzyZ5gR8nr3THnuKxIuQJsvYw//IB
	Lwi+EMt9RNzf59eccgRAFAlJn3xQbxJBRlYv2zVur9R+O6IuS8eM+Q72hmcpoLJoUzC1+Uy0Ug2
	O7+wv64HeBeGAfvUX7GE+pjS1jBFz8Fso6rbM4QSv09eqKEuUbIGH8xZFx6iQGgV2A45/PnZ0N1
	KTpPL75U70KBvvR02fytPGaJYj1KBtNJuRUDqtRYEAK9J0R9ulkFPvZNA8QPE=
X-Received: by 2002:a17:903:3c66:b0:2b2:4cd2:e16c with SMTP id d9443c01a7336-2b9f260d87bmr145993195ad.20.1778003222631;
        Tue, 05 May 2026 10:47:02 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae3b169sm148663355ad.63.2026.05.05.10.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 10:47:02 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	sanjayembeddedse@gmail.com,
	sakari.ailus@linux.intel.com,
	christoph.muellner@theobroma-systems.com,
	martink@posteo.de,
	mfuzzey@parkeon.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 04/10] iio: accel: mma8452: sort headers alphabetically
Date: Tue,  5 May 2026 23:16:34 +0530
Message-Id: <20260505174640.3998281-5-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260505174640.3998281-1-sanjayembedded@gmail.com>
References: <20260505174640.3998281-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Sort include headers alphabetically to improve readability.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
Changes in v3:
- Grouped regulator header with common linux header group
- Link to v2: https://lore.kernel.org/all/20260422165643.2148195-3-sanjayembedded@gmail.com/
---
 drivers/iio/accel/mma8452.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 916631519d3f..d227ce3d5f67 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -18,21 +18,22 @@
  * TODO: orientation events
  */
 
-#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
 #include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/pm_runtime.h>
 #include <linux/property.h>
-#include <linux/i2c.h>
+#include <linux/types.h>
+#include <linux/regulator/consumer.h>
+
+#include <linux/iio/buffer.h>
+#include <linux/iio/events.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
-#include <linux/iio/buffer.h>
 #include <linux/iio/trigger.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
-#include <linux/iio/events.h>
-#include <linux/delay.h>
-#include <linux/pm_runtime.h>
-#include <linux/regulator/consumer.h>
-#include <linux/types.h>
 
 #define MMA8452_STATUS				0x00
 #define  MMA8452_STATUS_DRDY			(BIT(2) | BIT(1) | BIT(0))
-- 
2.34.1

