Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C763B4E89
	for <linux-iio@vger.kernel.org>; Mon,  9 Mar 2026 14:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773066283; cv=none; b=VKbyvIzDXFrI/U3lZMuofTkt4qSMfQxeHSSdvXCYtbPP6+o47fNLU8PLhCv5tx2t186tGSW/bLabhLjpX6YIq4eExgMyrRXEti9S/ItLVxf+pHATrac4967H0BWttNa+g0iCGOFnAPviCq6R3xLfoM0LuJo3Y59FjmLC/+kX2+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773066283; c=relaxed/simple;
	bh=Xk7m8/mkiyg6mbJTkQMB8wQklO+XexSBMMj2nrqvkFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lTAh7ghpcnpdMABKQxGUZVTpdx/6Vdm9EFy0ZLYUdNuN5xtEQ13uAZXCwQbbtu0A34GgdqSvENmeHiE1R0M+KJMPM0gcJV8dM6YlJMkQaAlIZ+FizUe9+oEvuX1VhlXnUkM6sZSelz6tj355eiNtUCnNoqph5xlt+6cEghMzp+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nB5LQr86; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nB5LQr86"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-35982fd8910so3709997a91.1
        for <linux-iio@vger.kernel.org>; Mon, 09 Mar 2026 07:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773066281; x=1773671081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Gi/KzmvgogoeZ0YSdr3ckB0WaDai77wMnlhlj2jBFg=;
        b=nB5LQr86/UgC8AYGBFNtwgcSvOVvz7tAH0PkMTdf+aYhdtOk/GmSlDVkM43ypysgip
         fVFEOBJiXAYB7SZZvqer8C0U4YHWi6TGm2PkO+9pUkpKcrvBsl0Au1tV59xD06X+Z51U
         00E5zvIjITwuGAPc0YmrQ0r9JyOEWYHORKm1azkLEcVMxjtWnfpuQD3bCZeEGm5yMjQi
         oj0c1UF6BKGcH1yxdV043nNmPmCItV/PFKZ3sVjQuo3CB+F6UESKb22QsWb8TR3BgYWA
         TYFblz1GgpxSgB0OqgRk4UdrSL9bAIWGNB1CAbWu7mhvLhZ5+5SaFTOX+LBgGQqusks+
         vGaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773066281; x=1773671081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1Gi/KzmvgogoeZ0YSdr3ckB0WaDai77wMnlhlj2jBFg=;
        b=MugQ0EVIa2bIfXBWIu86jqTd4N9JLJA79wXErEmP8L5JocfNL5XaolxdAPwDKDGfjd
         Fr4ATPRZuugnBGfcQ0e0GDsFVcN0wWKbZUSifdBR1uNEZZf2GJBvbYgSq3h9DTZB+yJR
         HAC2Ny98P3FfDdGX+hbp6kP8hdHfpNXXjqhwCYD5E6B3S/8Ntt2AJfSWrQcAq6X0iisl
         w8IxLXdJTM8yMbUzzfK29IXBk7GyEtwthMsQMmFm9O6OwD33YUTR1f7KdmgMSBXuEpSB
         Pkx8be0XOrpBsCqf0MarAqhNbXJcHKLl66c17vFlX6laEfDpSDewG5dIuml1M5HKBQXL
         X3Fw==
X-Gm-Message-State: AOJu0YzZ3GW96vUSNY6yvBIAshNLjmSRiGQ1MmdVkcf6wpIcPPLTUfCo
	RX08aXq+EFKgdfDHHkIVc0CFkW370lZtczOgaXKRpgnh4hTWOlvkFP7c
X-Gm-Gg: ATEYQzxM2BselzAVX5Y4b1I80W1xaAQjgpYzleW+Bz9BDHxTRs1P9/WIUKfNIFAaaj0
	Ibu3WRyu6aMgP6KVrfZRCftPBYhMsw7OUR8M/vkFfma/DmNwtl39sTh4rBiAjdI+RfpOSdZrTY0
	PlEUkIUMBuqrsvitGvf9VhRPob8s81Q6Hz7P4PAIVIMuegeUTUp3e9b7X8O4MSEzOdPYjPXwhsk
	IsEhJyuxBroxZRTLJQh4qFWvxnTfht8ZgvS3QCe2jayAlKY5bGqZNla2LWem43gwClKd1hpVN3T
	+oo+UI8Xiwz3H750i2zGUkC+unmmZEIDm6AY/tML9gWDx4VOQ0BFD9iJ7E3+UlJA+afk+CTKDrJ
	Z69h/i0kGE1BX4mFKr9hxE9V+tnF5y5YNT4PiK/6BYO8NrhSxTwOkn/BE0FPmM9tTuSlpyC7Zdj
	XgZ/tL8mDQeJVKf9rnFH8qx02WjmN4kY0OdZZMByodpB7ItY0hGNGHqyLz13mGMAg38f95mYu4P
	nvaHU9tETBb6D+/Zv4rzLS1WWZvZ7EzhQo10w==
X-Received: by 2002:a17:90b:5587:b0:34c:2db6:57a7 with SMTP id 98e67ed59e1d1-359be24b367mr10913972a91.8.1773066281336;
        Mon, 09 Mar 2026 07:24:41 -0700 (PDT)
Received: from fedora ([2401:4900:1c80:20f6:77bf:3a75:33cb:748c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359b2e0e1aasm18985311a91.15.2026.03.09.07.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 07:24:41 -0700 (PDT)
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
Subject: [PATCH 2/4] iio: accel: mma8452: convert to guard(mutex)
Date: Mon,  9 Mar 2026 19:53:50 +0530
Message-ID: <20260309142352.57407-3-rajveer.chaudhari.linux@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309142352.57407-1-rajveer.chaudhari.linux@gmail.com>
References: <20260309142352.57407-1-rajveer.chaudhari.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace manual mutex_lock/mutex_unlock pair with guard(mutex) in
mma8452_change_config(). This ensures the mutex is
released on all return paths and allows returning directly
without a goto label.

Aligned	headers	in alphabatical	order.

Signed-off-by: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
---
 drivers/iio/accel/mma8452.c | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 15172ba2972c..ae096e618810 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -18,21 +18,24 @@
  * TODO: orientation events
  */
 
+#include <linux/cleanup.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
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
@@ -597,36 +600,30 @@ static int mma8452_change_config(struct mma8452_data *data, u8 reg, u8 val)
 	int ret;
 	int is_active;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 
 	is_active = mma8452_is_active(data);
-	if (is_active < 0) {
-		ret = is_active;
-		goto fail;
-	}
+	if (is_active < 0)
+		return is_active;
 
 	/* config can only be changed when in standby */
 	if (is_active > 0) {
 		ret = mma8452_standby(data);
 		if (ret < 0)
-			goto fail;
+			return ret;
 	}
 
 	ret = i2c_smbus_write_byte_data(data->client, reg, val);
 	if (ret < 0)
-		goto fail;
+		return ret;
 
 	if (is_active > 0) {
 		ret = mma8452_active(data);
 		if (ret < 0)
-			goto fail;
+			return ret;
 	}
 
-	ret = 0;
-fail:
-	mutex_unlock(&data->lock);
-
-	return ret;
+	return 0;
 }
 
 static int mma8452_set_power_mode(struct mma8452_data *data, u8 mode)
-- 
2.53.0

