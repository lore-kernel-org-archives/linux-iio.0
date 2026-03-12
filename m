Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBCE1A5B9E
	for <linux-iio@vger.kernel.org>; Thu, 12 Mar 2026 08:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773303618; cv=none; b=gmVvJpLUJi9/wkkRQJs1snm5n3rze3KkUfiqS5dnkDhlniBITODV9PEC4yPk9S3BoJxTV5WEB18lsiie9Vn0E7l333R1gyUABgpqGCsXAPZ0/oDrBsV/TUsfkcw05OER0UTcsKJdQPKx1nYHalCDOW6xLLS9S1N8aICeNfuOl/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773303618; c=relaxed/simple;
	bh=Edaye/3CrVze15FJxoamDG+w6ueaUaBhBylJlmgV0tY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WF75vxE1gjTmHHzNQ8/6YPeYR1wlhyya8DGG7Qtv4pD4Na8FUopPnfjO3UAqgOBNLv4FAF6mgEerMIObndBNgYnYv6z9egpzDDPvaKhc2hUJjekYHQRtNNi8IcHFt9Anf0009vedHFspym5B/+038R1Bw6IvGnjvAvlqyMQ20j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m5/gHJOH; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m5/gHJOH"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ae5636ab04so8450795ad.3
        for <linux-iio@vger.kernel.org>; Thu, 12 Mar 2026 01:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773303616; x=1773908416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Da6CmLvCiNOlwy1v5QAVRL0Kuj4W/ug/xDjVba+jfw=;
        b=m5/gHJOHfmffvTAOog2oXqR7DOCuOw6VqWukAoe0kbKIMAGi78S8p95D6S9Z/68mhH
         +vWSN7lI3n4lgYFjqD1STMGxfjoRSpPHvrDZguv2+2nPKDMCCmXdUfls4EJFfA6uCxw/
         +3L4jeMOToQwEu7HvLXOpgRgAEDjggAQMNb/EaKlaCx9iXlvy2fb6dFwg5etP+zSwE3/
         xBKgM/j3+GKW7i8MXoxxkqM5IS7Pk8Jgl1ZzhqcO00gX50soytZjM0ZVUXD+Trrj7IRx
         yodJgxTo4QdJOT1V5+NitQ5LOpSKu2B5aOI6ie9qzENEWAu6QJzND7HlgJRl7MXJmj4b
         A39g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773303616; x=1773908416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6Da6CmLvCiNOlwy1v5QAVRL0Kuj4W/ug/xDjVba+jfw=;
        b=iGFZ9UYYAzZ+4gySynqM1mwHKEvSRdSSmssZ6BsWy73xw/P+RnrxtEQLVeeRBymMJR
         9J9jBy698ULMYLm7BSkSg2dgIe+eNXhA5h5Kf6gqqzZypknCZWoCiABeVd9fO4Qf/orw
         258zyg6JSAyPR4dFugbvYD6RvTnLYxIzmqPC6fl5OBYobp6fJCBQoEhet0t2OiCgL3Oz
         9A7VDZvAgTZFa4dAsWKD2ztwYInOFV3WIJvS99aw57LSewoXEetgejMvNIO+k+/iaa4j
         2XZbyQtmlZbaGQHs+Tc1M5KNHJHb1PgyZ6UT2MgIZ9CCl1QUq6q3+Kzu7yIWdBSNj2gN
         cuRA==
X-Gm-Message-State: AOJu0Yy5GeXw0wb2gx0udVA8FYr5vCFoRBFrEvlnrn1Kyw2JrYBfQn/j
	I9FHlUGdu6dsWVu/l7gMYVJMPjfPhowZVvdDrpDYMvvOG3CRFGvLbjt8
X-Gm-Gg: ATEYQzzugCHHMMVi9dbUgisr4ssN2Webbgbt35fwNS7+jmIi4s6BNUIsmfl9vdIY5Zb
	gDP9viH2x0zH2dW0f57biPeJ5Ixz3kPf/waWlF/HKN0b1psqQvoi5BNUUXuQPA5Z/geXyS7nE3X
	pcP4XrgmtLXjcCGs897fNUeymk0f3B69n0g4oGGgKksU/3UWZGtRVzXuda9pcMDShZEidtJbtEE
	TUA4Am8HkxPo1Sm2XK+lbo/2mXsC2tKxHGZbidp3YA4RWDXUwtIVjFSTu7OXMwCoHKHeWodPZxb
	E8UgWQNjIZ2U0j1AbnzfHijaopa88AKio7WgA7By1iveskZOsPvPQ+2+oiE80m40dTOKqy4KYcI
	/2ICnJ4PWfEp7SZiYPga7RFDOYwn0gZFP8VWQ0dwWKKMO+L07N47NqSva07d2DWRi87xMalmD7r
	9jfBgy5hS4WHxNG+AKM3Kn74Rxwmfu5TeLoSd8HcPYlN7NYZoqaJnoESdPt0F3CQv3Vq5ySw5tG
	48Fxxs5ovrpjUmHYX+ax8c=
X-Received: by 2002:a17:903:2451:b0:2ae:4fdb:d596 with SMTP id d9443c01a7336-2aeae769ac1mr61672975ad.11.1773303616233;
        Thu, 12 Mar 2026 01:20:16 -0700 (PDT)
Received: from fedora ([103.92.106.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae24a91dsm64388905ad.31.2026.03.12.01.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 01:20:15 -0700 (PDT)
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
Subject: [PATCH v3 1/4] iio: accel: bmc150: convert to guard(mutex)
Date: Thu, 12 Mar 2026 13:49:39 +0530
Message-ID: <20260312081942.23858-2-rajveer.chaudhari.linux@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312081942.23858-1-rajveer.chaudhari.linux@gmail.com>
References: <20260312081942.23858-1-rajveer.chaudhari.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace manual mutex_lock/mutex_unlock pair with guard(mutex)
in bmc150_accel_buffer_predisable() and
bmc150_accel_buffer_postenable(). This ensures the mutex is
released on all return paths and allows returning directly
without a goto label.

Signed-off-by: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
---
v3: stop initialising ret=0 at start, making clear about good path.
moved return ret up into the if (ret) {} block in
bmc150_accel_buffer_postenable().

v2: Cleaned mutex_unlock and goto in
bmc150_accel_buffer_postenable(),
Dropped Header alignment change.
---
 drivers/iio/accel/bmc150-accel-core.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 42ccf0316ce5..4772dc6fcee9 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -7,6 +7,7 @@
 #include <linux/module.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
+#include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/acpi.h>
@@ -1480,20 +1481,20 @@ static int bmc150_accel_buffer_preenable(struct iio_dev *indio_dev)
 static int bmc150_accel_buffer_postenable(struct iio_dev *indio_dev)
 {
 	struct bmc150_accel_data *data = iio_priv(indio_dev);
-	int ret = 0;
+	int ret;
 
 	if (iio_device_get_current_mode(indio_dev) == INDIO_BUFFER_TRIGGERED)
 		return 0;
 
-	mutex_lock(&data->mutex);
+	guard(mutex)(&data->mutex);
 
 	if (!data->watermark)
-		goto out;
+		return 0;
 
 	ret = bmc150_accel_set_interrupt(data, BMC150_ACCEL_INT_WATERMARK,
 					 true);
 	if (ret)
-		goto out;
+		return ret;
 
 	data->fifo_mode = BMC150_ACCEL_FIFO_MODE_FIFO;
 
@@ -1502,12 +1503,10 @@ static int bmc150_accel_buffer_postenable(struct iio_dev *indio_dev)
 		data->fifo_mode = 0;
 		bmc150_accel_set_interrupt(data, BMC150_ACCEL_INT_WATERMARK,
 					   false);
+		return ret;
 	}
 
-out:
-	mutex_unlock(&data->mutex);
-
-	return ret;
+	return 0;
 }
 
 static int bmc150_accel_buffer_predisable(struct iio_dev *indio_dev)
@@ -1517,19 +1516,16 @@ static int bmc150_accel_buffer_predisable(struct iio_dev *indio_dev)
 	if (iio_device_get_current_mode(indio_dev) == INDIO_BUFFER_TRIGGERED)
 		return 0;
 
-	mutex_lock(&data->mutex);
+	guard(mutex)(&data->mutex);
 
 	if (!data->fifo_mode)
-		goto out;
+		return 0;
 
 	bmc150_accel_set_interrupt(data, BMC150_ACCEL_INT_WATERMARK, false);
 	__bmc150_accel_fifo_flush(indio_dev, BMC150_ACCEL_FIFO_LENGTH, false);
 	data->fifo_mode = 0;
 	bmc150_accel_fifo_set_mode(data);
 
-out:
-	mutex_unlock(&data->mutex);
-
 	return 0;
 }
 
-- 
2.53.0

