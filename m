Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3124D39890F
	for <linux-iio@vger.kernel.org>; Fri,  6 Mar 2026 20:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772828838; cv=none; b=SQqgC7l8YjygsNCaXQKDLRBTR0mvGTekIqU9tX0LhAQhbCKtK11IvDG8D1JmhDjF73NuL4G7MXDv8vU4Yen9yLTDN/G4KYJoih5AKyDqT7SSLNCaH0Zxc+S38mV+z++b4bbIvTZv2TE27qaQEjNrDx9JWRkwBixOEQ+sArd54NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772828838; c=relaxed/simple;
	bh=g3oAsMDa6tuR+/A6Em0En8JCTZpVH/momdRatLteLhE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I1xV4qXIxL1iL74m+FocaKAii9JFX+E9JGo6poonFrdIoAaytBXd29k1yKzBOwQu79jIqsto5qQW7tbRaB7+gvNHZnQbErZ8tA892RT2Fr7pbwS1PqgIcTvKI97A48G1yfAksAxvAxzWJyPZXOrZaxU37uByT7V2PhnQ3hRI53s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bSWpWrvb; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bSWpWrvb"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-358ed696623so4046056a91.0
        for <linux-iio@vger.kernel.org>; Fri, 06 Mar 2026 12:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772828836; x=1773433636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=raCgZFvVUfOpsCKvrIvPbVa+6HmFw1W/wn9qNthdpCU=;
        b=bSWpWrvbnmwJt+kLA7LpIZhk7gt0jui3qFdFjGYhCbnQLl26XUuz1Q6i5akrGjFEAM
         2FyovGM6aI+6iaBrq4hFhz3kxFAOXBM9fvhjaCfLXTJisgNpTcI+D9AmCSGcLSpljyMJ
         FmuybG+nPaGp8QZjd3N5rlbpihtqdzwWlDfbKSbqPUBk49X+vBlMYZsf8FVwuaZ9Y8eM
         SjR5Z2w8pOX9dHE2CNJVGadWp5Ztn5+o2NkoyNE6XAiL0wsIbDIwNd/G2189ZvMip8Ds
         Bhs3QX78pnJ96IsveD1LNWGhFwJAx3RvjnN9ThOvDZmaQ9tLHMgQDGEFqHwPKT224Ire
         cyQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772828836; x=1773433636;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=raCgZFvVUfOpsCKvrIvPbVa+6HmFw1W/wn9qNthdpCU=;
        b=VfM2bSW0l4Vrmwwxz359Juy+c5ByImfWIsu17BFlchnakk3jfVt4DZBRVf6yJxBcdC
         rVEJuLH6vJeMk88W5sXyclV5tS5gqQlYn//AcmNOfGZvV+ovaS6YFlshQNC0QWuLpbjg
         IDKh6L2T/DfoC3ATiYuju+3lKi79x82RL1h4cR0rnv3xeG0siS1ZHR91xNanVDk+CoYC
         Sc6UE7qF4NZYPgk2ig+K33hbY/CwzmzRG+HD63UfPSE58+SiLe08JCTU+zuGPk2lKEn+
         jfL1ECdoApgUPYrEIP0xE/roHcVOUL1dVBjcWI1orGi3SFHwT5AjjnkONTs+on11PcFd
         +5KA==
X-Gm-Message-State: AOJu0YxAGcyQu0u5uhm1wr9GT5VmvDfgWatw9b23FfG7v8fORflsCK4w
	NpgNy7ktYnJl5NQUNjgonpZed7jjhMM1HIDsepTgPO/T/mjc7qQ2xJWR
X-Gm-Gg: ATEYQzyGri/V6cKISF9DOKze8PhKIG8NleEJV5KaiBOw5vlXP1kyYtCkkrrWflikYxi
	lEZTLdCmvIAXIBw0BgoNDq8M3lVQwrIDb6QNifYA2ecL+ddEojqXaKBmkdTWTjMAHqKgSPqniOf
	niBX1NbJcDMgxso9W9V8ifygSg+ZH4ewxtceZ4/HUP67yFCZfgJZ/Ihg3L8bSlm07mi7iUKguPz
	J4orp1mkV/2P3/Tw7ddj+4LHwCyjQRqGJPQkVGDXfSL3Qk8bWxKm0nKbMGTY7ULZppW8aWfkL9h
	abnzY5WUYTefg9aT3bC78jP4OxXDqj3qUWQawzP391IAmZ7J4LY8RV0w/vS2V1Wdkpevi8FZeIy
	ePA0HbdV3S7RtJjhjac7Kebc/4R0O3fmuVenGT0CGxwwdDgNYAc3lDH6Cp9hE/hB5E+Fxs9/rK2
	UFCP/dbsqUlxV5aQkXC9inrIC4Sgh3+zd5nJ6b3HWvrZwNru3LrWu16Ruw9Dk2dO6OuZ0G/QdlV
	DA7AJWlQHF8WUtTQ5Ik1g4ZZmAkPm8pgLk=
X-Received: by 2002:a17:90b:3c4a:b0:356:24f0:af08 with SMTP id 98e67ed59e1d1-359be28d404mr3003809a91.1.1772828836429;
        Fri, 06 Mar 2026 12:27:16 -0800 (PST)
Received: from fedora ([103.215.156.29])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359b2d5fe2dsm6326572a91.7.2026.03.06.12.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 12:27:16 -0800 (PST)
From: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
To: lucas.p.stankus@gmail.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	puranjay@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
Subject: [PATCH] iio: convert to guard(mutex)
Date: Sat,  7 Mar 2026 01:56:50 +0530
Message-ID: <20260306202650.61865-1-rajveer.chaudhari.linux@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace manual mutex_lock/mutex_unlock pairs with guard(mutex)
in several IIO drivers. This ensures the mutex is released on
every return path, preventing missed unlocks on error paths.

Signed-off-by: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
---
 drivers/iio/accel/adxl313_core.c      |  7 +++----
 drivers/iio/accel/adxl355_core.c      | 27 ++++++++-------------------
 drivers/iio/accel/adxl372.c           |  8 +++-----
 drivers/iio/industrialio-sw-device.c  |  4 ++--
 drivers/iio/industrialio-sw-trigger.c |  4 ++--
 5 files changed, 18 insertions(+), 32 deletions(-)

diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
index 9f5d4d2cb325..94c6023af487 100644
--- a/drivers/iio/accel/adxl313_core.c
+++ b/drivers/iio/accel/adxl313_core.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/cleanup.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/overflow.h>
@@ -356,18 +357,16 @@ static int adxl313_read_axis(struct adxl313_data *data,
 {
 	int ret;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 
 	ret = regmap_bulk_read(data->regmap,
 			       ADXL313_REG_DATA_AXIS(chan->address),
 			       &data->transf_buf, sizeof(data->transf_buf));
 	if (ret)
-		goto unlock_ret;
+		return ret;
 
 	ret = le16_to_cpu(data->transf_buf);
 
-unlock_ret:
-	mutex_unlock(&data->lock);
 	return ret;
 }
 
diff --git a/drivers/iio/accel/adxl355_core.c b/drivers/iio/accel/adxl355_core.c
index 1c1d64d5cbcb..ef05178bff00 100644
--- a/drivers/iio/accel/adxl355_core.c
+++ b/drivers/iio/accel/adxl355_core.c
@@ -9,6 +9,7 @@
 
 #include <linux/bits.h>
 #include <linux/bitfield.h>
+#include <linux/cleanup.h>
 #include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/trigger.h>
@@ -263,12 +264,11 @@ static int adxl355_data_rdy_trigger_set_state(struct iio_trigger *trig,
 	struct adxl355_data *data = iio_priv(indio_dev);
 	int ret;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 	ret = regmap_update_bits(data->regmap, ADXL355_POWER_CTL_REG,
 				 ADXL355_POWER_CTL_DRDY_MSK,
 				 FIELD_PREP(ADXL355_POWER_CTL_DRDY_MSK,
 					    state ? 0 : 1));
-	mutex_unlock(&data->lock);
 
 	return ret;
 }
@@ -409,16 +409,15 @@ static int adxl355_set_odr(struct adxl355_data *data,
 {
 	int ret;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 
 	if (data->odr == odr) {
-		mutex_unlock(&data->lock);
 		return 0;
 	}
 
 	ret = adxl355_set_op_mode(data, ADXL355_STANDBY);
 	if (ret)
-		goto err_unlock;
+		return ret;
 
 	ret = regmap_update_bits(data->regmap, ADXL355_FILTER_REG,
 				 ADXL355_FILTER_ODR_MSK,
@@ -433,13 +432,10 @@ static int adxl355_set_odr(struct adxl355_data *data,
 	if (ret)
 		goto err_set_opmode;
 
-	mutex_unlock(&data->lock);
 	return 0;
 
 err_set_opmode:
 	adxl355_set_op_mode(data, ADXL355_MEASUREMENT);
-err_unlock:
-	mutex_unlock(&data->lock);
 	return ret;
 }
 
@@ -448,16 +444,15 @@ static int adxl355_set_hpf_3db(struct adxl355_data *data,
 {
 	int ret;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 
 	if (data->hpf_3db == hpf) {
-		mutex_unlock(&data->lock);
 		return 0;
 	}
 
 	ret = adxl355_set_op_mode(data, ADXL355_STANDBY);
 	if (ret)
-		goto err_unlock;
+		return ret;
 
 	ret = regmap_update_bits(data->regmap, ADXL355_FILTER_REG,
 				 ADXL355_FILTER_HPF_MSK,
@@ -471,13 +466,10 @@ static int adxl355_set_hpf_3db(struct adxl355_data *data,
 	if (ret)
 		goto err_set_opmode;
 
-	mutex_unlock(&data->lock);
 	return 0;
 
 err_set_opmode:
 	adxl355_set_op_mode(data, ADXL355_MEASUREMENT);
-err_unlock:
-	mutex_unlock(&data->lock);
 	return ret;
 }
 
@@ -486,11 +478,11 @@ static int adxl355_set_calibbias(struct adxl355_data *data,
 {
 	int ret;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 
 	ret = adxl355_set_op_mode(data, ADXL355_STANDBY);
 	if (ret)
-		goto err_unlock;
+		return ret;
 
 	put_unaligned_be16(calibbias, data->transf_buf);
 	ret = regmap_bulk_write(data->regmap,
@@ -505,13 +497,10 @@ static int adxl355_set_calibbias(struct adxl355_data *data,
 	if (ret)
 		goto err_set_opmode;
 
-	mutex_unlock(&data->lock);
 	return 0;
 
 err_set_opmode:
 	adxl355_set_op_mode(data, ADXL355_MEASUREMENT);
-err_unlock:
-	mutex_unlock(&data->lock);
 	return ret;
 }
 
diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index 28a8793a53b6..24a79f61900d 100644
--- a/drivers/iio/accel/adxl372.c
+++ b/drivers/iio/accel/adxl372.c
@@ -7,6 +7,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
+#include <linux/cleanup.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/module.h>
@@ -336,17 +337,14 @@ static ssize_t adxl372_write_threshold_value(struct iio_dev *indio_dev, unsigned
 	struct adxl372_state *st = iio_priv(indio_dev);
 	int ret;
 
-	mutex_lock(&st->threshold_m);
+	guard(mutex)(&st->threshold_m);
 	ret = regmap_write(st->regmap, addr, ADXL372_THRESH_VAL_H_SEL(threshold));
 	if (ret < 0)
-		goto unlock;
+		return ret;
 
 	ret = regmap_update_bits(st->regmap, addr + 1, GENMASK(7, 5),
 				 ADXL372_THRESH_VAL_L_SEL(threshold) << 5);
 
-unlock:
-	mutex_unlock(&st->threshold_m);
-
 	return ret;
 }
 
diff --git a/drivers/iio/industrialio-sw-device.c b/drivers/iio/industrialio-sw-device.c
index 3582524de0b8..a2a3e3a67d79 100644
--- a/drivers/iio/industrialio-sw-device.c
+++ b/drivers/iio/industrialio-sw-device.c
@@ -10,6 +10,7 @@
 #include <linux/kmod.h>
 #include <linux/list.h>
 #include <linux/slab.h>
+#include <linux/cleanup.h>
 
 #include <linux/iio/sw_device.h>
 #include <linux/iio/configfs.h>
@@ -84,11 +85,10 @@ struct iio_sw_device_type *iio_get_sw_device_type(const char *name)
 {
 	struct iio_sw_device_type *dt;
 
-	mutex_lock(&iio_device_types_lock);
+	guard(mutex)(&iio_device_types_lock);
 	dt = __iio_find_sw_device_type(name, strlen(name));
 	if (dt && !try_module_get(dt->owner))
 		dt = NULL;
-	mutex_unlock(&iio_device_types_lock);
 
 	return dt;
 }
diff --git a/drivers/iio/industrialio-sw-trigger.c b/drivers/iio/industrialio-sw-trigger.c
index 334b6b10a784..4af601ae286c 100644
--- a/drivers/iio/industrialio-sw-trigger.c
+++ b/drivers/iio/industrialio-sw-trigger.c
@@ -10,6 +10,7 @@
 #include <linux/kmod.h>
 #include <linux/list.h>
 #include <linux/slab.h>
+#include <linux/cleanup.h>
 
 #include <linux/iio/sw_trigger.h>
 #include <linux/iio/configfs.h>
@@ -88,11 +89,10 @@ struct iio_sw_trigger_type *iio_get_sw_trigger_type(const char *name)
 {
 	struct iio_sw_trigger_type *t;
 
-	mutex_lock(&iio_trigger_types_lock);
+	guard(mutex)(&iio_trigger_types_lock);
 	t = __iio_find_sw_trigger_type(name, strlen(name));
 	if (t && !try_module_get(t->owner))
 		t = NULL;
-	mutex_unlock(&iio_trigger_types_lock);
 
 	return t;
 }
-- 
2.53.0

