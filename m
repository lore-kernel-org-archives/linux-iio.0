Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A8631716A
	for <linux-iio@vger.kernel.org>; Sat, 14 Mar 2026 17:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773508036; cv=none; b=a5mxY0pWZ5AcEKWH5UvF841DqHY6fgiu195PT4FpB3mu0N5Fm1uDtn9uBPF1sg+RfG//HkI4S432IsMLN2zyrJY5AIR5yQfeNlPRe+y066GpbdiH8wBFH2BwbQmcnIHmRSZFAHqFpGuNYxZwQeFdWSxDagwWCWpHyr1k8gkWPOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773508036; c=relaxed/simple;
	bh=WjaDMGSZe9UYhGr/JU0UvpxZ+V3tph9q5anJ+xy2UFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t+Vt4QMRdyJjFIMmQgB4bB1fNmI9GP2tzdNrDMEnCHmjG8GJehmAjTyCkdCZxTjLPkPepnxllOxaN1LsFo7sIDueiQXOjozrjRPqh18O/D7XtsqssPlBv671Vl1rHKg9Y+XWO0Scqksotu/8Hl/h0/8REXEa+IBHUguCDGgxPqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F112dR5J; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F112dR5J"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-358d80f60ccso1975630a91.3
        for <linux-iio@vger.kernel.org>; Sat, 14 Mar 2026 10:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773508034; x=1774112834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uhlr9nT/SHch836dV6HJr/QlJmVXAVlUY7mUE3f0unI=;
        b=F112dR5JDrS10ZOAF0Te5maN4JkM0xjrGghuJih0LoH3m3k2ZinTNlrJwXUYzeglSK
         HxZ0npfdam9sNt4fYqEATC3AwHn72TlY7TLPL806Cr85vHWDuzFcVBEi9Ul49KjS3yRF
         CNc/fTLxSAXcDVGZr0SlPi/b77sseyLI77mcYXI4hdmAFWxNEsy+SkgUb0q91x/wCDEC
         3ABzqgt+vMViSn53OT7QdJo/nMEsVJNJ2cucGYgmiTq2fNIKhXt9uZpxrjALZeMsNlt+
         JEm8nUfdMCtW7/DfdwtlewGR5EAeKDxhrPV3NjtbUii+bLmsSCEq9+kdlMZ4WYcPLBKb
         ZbPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773508034; x=1774112834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uhlr9nT/SHch836dV6HJr/QlJmVXAVlUY7mUE3f0unI=;
        b=lp1EKaPhHHfdSnUS3A8q4w+nCa5COO5qXfewMjnULiEbleIg8CxV5MaOCjjt2fRgRf
         WYiOKyTNwl1lDhuSDi4BW322Yd68bxg+bG/gNvjViGtHoHToTkJl3A4VATi5PlrU4lmq
         c2hMott7OgobnlQYRYmditgo7DA4CnPbrvb/qq2fT/DZr6VFrNm0t3fiz03Hp5KtsDVw
         brTYyy2ZRDP8ugxPBbHs4qPXOcGXO89G54lIRstegFKZmjoFfPzrjADl0b84cKeCi6Cb
         Rn2Lo5mU63KNJmErbN+nIv+7/YTtSh94vYl3qiU8Wd1EpTtIcStzkcA3N28k/yRLAU+D
         8KoQ==
X-Gm-Message-State: AOJu0Yy7E+V/tmmdL/gJbCa49yTN6q0NNSA0Gil6kkRG34mG1Zj/N1lg
	9pXeNJAnNvOmhpQvu2AzHDXBmARxbjmjozTrEmloafsfkRRbqy3plViy
X-Gm-Gg: ATEYQzw0mg9Atg4vJaLwL3aDEyge6L2chNF+ShBIbnnPz9pOpjPe5/KvtK0MX9TLYkg
	YT6WkjIz9VwW4P/hsM9GOwdxOE2cLAckB5Cg5wpJRBkucY5LKn294pc/KGCNbLgk/FuRRFwSfm3
	fPjsDqnF3ZpcZ6LoOaUcyeurVUEZ66BrKC1ZEjRgm6tkRGI7qHth2Pf70v9udMFybga/9MD6DLy
	+LV3+nKda4ApDWGa7XjmdU1Z0R9MQQo/Y0cgWEjXculGGLWJ+U4j4zwo5FijXOYck9OY3dyC7Wg
	cuEMTXmwHwDbXYRL3FPbc175BCghsHzbIFQb8rIepQraM173aPGbc0lxFHZA/wjt2WBDhEtLBo/
	VESBi6SCBQuoSLmRTjGoDowGibCDw5MWjvL+VLaNTmlggXP+CH/KdSBTRAaDxsu3d91DYYEo5Py
	nVw0S6xCy8NhswmQIffNAP8b5+TzR2CzS8hzC21TO+KcqbSSBnVcH4sT6FBzpYEsUDjnjlawU4Y
	WkP83C9LnyK4V3dCj8Ouq+0XBw=
X-Received: by 2002:a17:90b:4fcd:b0:359:d54:846f with SMTP id 98e67ed59e1d1-35a21e39599mr6486053a91.7.1773508034363;
        Sat, 14 Mar 2026 10:07:14 -0700 (PDT)
Received: from fedora ([2401:4900:8898:a35f:15b4:3058:14c8:4287])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35b90d3f572sm1600116a91.14.2026.03.14.10.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 10:07:14 -0700 (PDT)
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
Subject: [PATCH v4 3/8] iio: accel: mma8452: sort headers alphabetically
Date: Sat, 14 Mar 2026 22:36:04 +0530
Message-ID: <20260314170609.26827-4-rajveer.chaudhari.linux@gmail.com>
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
 drivers/iio/accel/mma8452.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 15172ba2972c..79ee4dff0ff6 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -17,22 +17,24 @@
  *
  * TODO: orientation events
  */
-
-#include <linux/module.h>
+#include <linux/cleanup.h>
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
2.53.0

