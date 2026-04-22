Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFB7386557
	for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 16:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776877019; cv=none; b=KcJgsQ69ZJ2hcgb7HgNg0CeK4JftApazK30ut2hJkqYVstDyJVBys2MuR/riQeYYRIiO/RNuyJNyb8kTMJ5FhPN1JC6RCFzUNaN0K3Edr4P3AfS2JhnG6paVVZ0Tjxw5c6rJNDDq8Vw5fJqt4MuxJ3JEpzJinaeDZ20Ycbq4Wjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776877019; c=relaxed/simple;
	bh=MhJmoEAYvAq3zlu4mLX96ThWtNiAsD8w6ypo3RKq594=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rQ04lx/NFzqi34hvaLZEZjXRO1GvitCuvGXM0nRilz8hsGb8XrLUbbFFvkfHMC2Kce3yxrvxYnf9BtTgH7VPqd3tRoP2VDowMoJRljOdEwZ2bZyNNE4nVnvohQEV3ty2Om0xGrR0h/Aab7adm99HyZWAyiafjKfDMUoM7RhMsUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bV5Q9uT0; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bV5Q9uT0"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c70f91776fcso2251042a12.0
        for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 09:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776877016; x=1777481816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zuuPXKx9fNOIPTaVS+7TepVaEnB9XvGzk7sNSjhVUGQ=;
        b=bV5Q9uT0B955L9D4MwC/4sPupIjFuvZlyEUjQaT7Jedmc8n/4CTP+3PYSSJC2gM4b8
         9sfHx1y1Sx7njKFNdLYiLBViIXOIr0fCLOcfGk5MykuXKEiyuClP+NM/54scGMn+6cnW
         TYKOW+6G0yLFFBPKbmafqJD9JMFtXIHryCxLmmpV5WCgILaolbnJfflZW6ujsvXny4VU
         ofk3qFrTbWDA3yRb+KqsJEyzqk5tbxeboZPD88MlUCQAFqC49la1vr8VoeZTo7gLg1Ra
         pMP9CjusZK0YrGNXdiwn9ah4k0nGZ5rTGjemUCGp39ntqjSLWm2YXdhkQq2ekKnCTqL4
         RKkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776877016; x=1777481816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zuuPXKx9fNOIPTaVS+7TepVaEnB9XvGzk7sNSjhVUGQ=;
        b=rCqSo4jN9cMRmTTqIFg68Hyi7tMscGVaeQZ0OL/1EVQZ1PPzrkZYlNX84o/WYEZkN5
         /CEAtPIU9s6uilB2T3W1koxxPlNYZoPOIA6PhiKs0HBPiClbiazXQiuvGh77ZQB6UtzD
         WcHpz6fGvITHPV34aypIFk8JgtFGilspJNTTRNYU5YRRoQ36C8UclvP5Q1WNZxdZQTlS
         rXv8y4gz0HVs3CWkfGEpoE05XUpc5C/BOWVjL0jSbFsTVGweX99OA+QblneVcVrJPnqZ
         MPQB9OJiU/FZG1wOzYnpkQtfBihRwtz0r7jPYyqqWMEz4hg7/ez1v1fAtG/uCkKWP+V9
         Cm2A==
X-Forwarded-Encrypted: i=1; AFNElJ9YNJg5S3g85bVtZsMo7ENX0kV05xrHE8K9be7FTwHRMBlWmqA9d0PMFC/xcpEXYlbKcZyROOMDr28=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7VXQyUc6kpxQATMaP/HsxVRGDrzgkBaBM5LUkcna7mozTk0R3
	UYFdanrv5ZzSpw16dB7rj/Ff+iOEle5BkDZNJwuNVr/5KzLjaRXy0V64
X-Gm-Gg: AeBDietwADkSZytl2UHzYzerfilQ2K8/IneEhA7m4vKJBkfwtY4Nd/jRXE/QrrhV46m
	r5aXnRvGG6oT4Y7fX6WJyJLVHnvZiGx3M58InFSknpwF5h6mzpaBYcvu6zYUSc9uP/wft3Zc7QL
	vBmlnYx29AmdFNGTiyYI4SVzoej9hE50oC2VrpyRzF+/U6d0lItPoNsylVSxHMPXQGHMwgaYlz3
	ghezfpdpUbw82nhw3jUyoc2RJqO0c1938fHUPRFdmSWFNyoTb8OO89x/+WidkTnwc0PnXRPVb6X
	Oa1bdCmfJIN2lgbwPhdqz5G/d9M0Hr5FK/m2g093k55+JmxDXR5LARoZ7sfSjCpCxHOFSTnvPzO
	0fQShBZEN32lK4D6wdEyEOPMCQRqV2uisJWiPEB8I6HZnUD2W2UmGwHytEmaStch0Zbztggr8Dt
	yUQrUhHflZ+jE3jKfGh0V+xYjzFoCUGOwepbnu7xRjd4iqnu7FZhAtpsBYOHg=
X-Received: by 2002:a05:6a21:1644:b0:39b:f25a:28d7 with SMTP id adf61e73a8af0-3a08d687945mr26426153637.3.1776877015685;
        Wed, 22 Apr 2026 09:56:55 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7976fa3604sm11908675a12.14.2026.04.22.09.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 09:56:55 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	sanjayembeddedse@gmail.com,
	sakari.ailus@linux.intel.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/6] iio: accel: mma8452: sort headers alphabetically
Date: Wed, 22 Apr 2026 22:26:39 +0530
Message-Id: <20260422165643.2148195-3-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260422165643.2148195-1-sanjayembedded@gmail.com>
References: <20260422165643.2148195-1-sanjayembedded@gmail.com>
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
 drivers/iio/accel/mma8452.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 6d9091f696cf..c54c0ea05ac1 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -18,21 +18,23 @@
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
+
 #include <linux/regulator/consumer.h>
-#include <linux/types.h>
 
 #define MMA8452_STATUS				0x00
 #define  MMA8452_STATUS_DRDY			(BIT(2) | BIT(1) | BIT(0))
-- 
2.34.1

