Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1918D390200
	for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 16:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776877030; cv=none; b=acT08ckM43Mt0VVD9hpX8osQMnvA5Q4GoqBbxxANqh8cscQugnUhPSv0XroVNqKmgK951rASvTqDytG8LGOHzotOdYwTpzMF7Ie0x9YMLdYtVIDbz8Z/czo24DMHKeOQtp3wG4vqETMwQBKLa3TLJGaT1eOmg0yP8LMAqt7F+0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776877030; c=relaxed/simple;
	bh=phuovY5LGPNUA1tGMKpHr8w+7ex72MZcp1bQbV/VAnM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jHLo54+uuOnT0qoFBmC0XF2lklFCnr1i/IZ1sX35vV4pFHQqB6Hw+f3NPIoWQdRhQgmJe28t9cIU96qfVGhjzndRhXWkZN90mODlDWYRlD98ybWRDGhUYqFxZOo+xRSaTrwVVngwz8Pv6BY1FPRAVyrGkRA2OQFCabFcs5/zouM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fGqrn23G; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fGqrn23G"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-35fc258aaa4so3611515a91.2
        for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 09:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776877028; x=1777481828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N7RWTZe2CgWdqhLVIQJNNjEv3qVx1AKFr1CFK8ZC+yg=;
        b=fGqrn23Gj5KQuYQYYjQGh5V8JaO8y/RPEtA/kyQ5tfXz/iViFAKPrGpDvctFZEsdP3
         3rWjys0Ar0WBIO2J/F+5SH+F80Bi7VYwMplqDO8nHyZH3++ERLyw8S0T/uY+2ivTfIQL
         Wtz2b1BZsvr+44LwRUM5HxKAHeu/JyLIfHV6UW5vKD7SybAXaL8cBHVM4L1cuTaihi1Y
         SYfOPRTXM/BEY9uw+6SGm1tlLeW0dkl07rFn6YTl77VbeMl8IWFzemvzlhcLEb4DjN3W
         DzygcxiTxRp6XYZ/dAPIyNZFcbLHmxcC2yP66Lv70ICOIo9tap08aOCuQgyPIdPooZWR
         7sMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776877028; x=1777481828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N7RWTZe2CgWdqhLVIQJNNjEv3qVx1AKFr1CFK8ZC+yg=;
        b=chvQIHOgyhgMNUmPBvpnkNpSsdIUmsMloRqkAzFkhLZ5IrDRc3/joamGuQPfL4j+uS
         udQXWHZCj14ywQOcczSDlWWblBM5y5lCRpU4xDf9IMmRdsAL5JsuduleWgimYvwLWMeq
         KaqFxui+0EewgjTX20TVbcAVdRd3XuHilZdxfGCuUV+eJSxnzdb3rfYPvqtz9QDlVF0e
         w6zexMxkJdqaLo2XjBFkKKoIlnTTYHaHf9MdYHvTeoNC13W37Zxck/Oeaz0KyuSvw02k
         ZR7SY1bG2D8HOFtMFSRKI4qQmaImWWQK+m60QVOveARujwUEC2qNiRCf5VsLCjI1lFrh
         oKrw==
X-Forwarded-Encrypted: i=1; AFNElJ8DWehsjMvpNbWgRqJ2I0fz0nBbjr3gsw/LqR5rMx19b/NYhdhCPuPqgpBPoA3l8Z7YfohPDZe/At8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcU865QRO3p7Co0QO5gPrmytzh6HSNqSpNda8/wZYBNUdUmvir
	DB0tsVQ8dCwW0ZB1O84FxTIE2F93uW5waLvVznOUOkoJjwWDNzKZF4TX
X-Gm-Gg: AeBDietK1r46qjQLzSowMrzdgp7VoCasEIz8anmhngA/ozC6Vx93yPR1Qcs2PaOSkEf
	VeLFCrPmi6PL6StxLFqK2z3Yd8LA6QG/UDhmZNZEdY+ATHhSWn3d3EEa0yBdX8p6NZ27DsnVT1p
	dCDjOjBOiGyQS1HItuoH4DJ1tpuS4Dl+KfPrDeyhjwYhfFdSVHIrnZJ7fN4/h1NPtl52Tlrupsa
	7r7vanwwAGA+TxKVvIqDAykL1UEpIwU7ieSGD+Vq6ChX5x2Y3OZuaBV98NXaQFYD6kmPq7eqbj4
	rakB/O/lDIzwX/a1usTMUP+ayf5bWlogu9OihmoRh1NQbf9x+pWpDX6XDK3v++3zmNbST6aMm+L
	xW+WdsS0gBgCBsJktzVh3CiU6hbe1fOl3Zn41gssEj74VPRfFDP74pH6urHmgR17Kn3AJWEtYVx
	FrX1qdiDEp22MlvRcQ6MjA/aCHOujjuuYR2JHuoHH/zHkXA1izz/CKajYy8DU=
X-Received: by 2002:a05:6a21:3282:b0:39b:f026:6f8e with SMTP id adf61e73a8af0-3a08d897d89mr26229089637.34.1776877028436;
        Wed, 22 Apr 2026 09:57:08 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7976fa3604sm11908675a12.14.2026.04.22.09.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 09:57:08 -0700 (PDT)
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
Subject: [PATCH v2 6/6] iio: accel: mma8452: use guard() to release mutexes
Date: Wed, 22 Apr 2026 22:26:43 +0530
Message-Id: <20260422165643.2148195-7-sanjayembedded@gmail.com>
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

Replace explicit mutex_lock() and mutex_unlock() with the guard() and
scoped_guard() macro for cleaner and safer mutex handling.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/accel/mma8452.c | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 9983f76a8bcd..1c284bdcc44a 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -18,6 +18,7 @@
  * TODO: orientation events
  */
 
+#include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/mod_devicetable.h>
@@ -500,9 +501,8 @@ static int mma8452_read_raw(struct iio_dev *indio_dev,
 		if (!iio_device_claim_direct(indio_dev))
 			return -EBUSY;
 
-		mutex_lock(&data->lock);
-		ret = mma8452_read(data, buffer);
-		mutex_unlock(&data->lock);
+		scoped_guard(mutex, &data->lock)
+			ret = mma8452_read(data, buffer);
 		iio_device_release_direct(indio_dev);
 		if (ret < 0)
 			return ret;
@@ -600,36 +600,30 @@ static int mma8452_change_config(struct mma8452_data *data, u8 reg, u8 val)
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
@@ -1753,9 +1747,8 @@ static int mma8452_runtime_suspend(struct device *dev)
 	struct mma8452_data *data = iio_priv(indio_dev);
 	int ret;
 
-	mutex_lock(&data->lock);
-	ret = mma8452_standby(data);
-	mutex_unlock(&data->lock);
+	scoped_guard(mutex, &data->lock)
+		ret = mma8452_standby(data);
 	if (ret < 0) {
 		dev_err(dev, "powering off device failed\n");
 		return -EAGAIN;
-- 
2.34.1

