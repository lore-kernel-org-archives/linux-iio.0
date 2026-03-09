Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B483D4100
	for <linux-iio@vger.kernel.org>; Mon,  9 Mar 2026 15:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773070495; cv=none; b=kI0Ct3nB8FCw/+oJ9jWoFU30eOovOQ/MlhH60JUuItBmVbGe1oqRl8XRLYCYUpYki6SJwN5qyEYU3NKZ4C7GvTyI8SQVG7U6nBil+pIObyQG5hw5Tx+Wgp/nHABx73xV7kTemvbZEeA0yL4aRvw3ns5sqEAEgtt9Mng9bmoNGVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773070495; c=relaxed/simple;
	bh=F3cLyKU+aCEV8LPCrPgFgnGx7rxodlQMavEUkf2SfO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VHBldo5uG8uwKyYBQBGaMiw4qrFlzB6zU93Mw55zw56+GVXSfY9urS9eDHZcTqASdNMCdYWDAsYJr98dHTGHWZHAlXlCUMuJPjgN2btM7xL4qIp/CtLep+iqZqiN3gi3iMfqpYIAx+V58DwqDAxrZEZ8VGjqeJTlyiCRbMEGumI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JP7dtz0I; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JP7dtz0I"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-829928e512aso2234324b3a.2
        for <linux-iio@vger.kernel.org>; Mon, 09 Mar 2026 08:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773070493; x=1773675293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2aTy0R+XTQKbHXXKr9Mnyna9OWj3RkjcnoZQYJLkb9g=;
        b=JP7dtz0Ig3QyfxodVaVQNmu3oJk5iKQPmqk0Mef4BqQUnzmBJyt7cowPOikhJ0qwOr
         VfspcYEz8odxAX9UxplZcB7zWNGFgswde2ixgT4o8OIN9odG9uJUuB+0Q/mWEetX+7vW
         md5+Nj/yEJY2scRE52AkAoQNc3V/muba4nwDX9514zNsvkpKvNRK1hbIx+Yfh9bslFKs
         VrYtFIA0yt9yiH29Ar+ga25qEZj78+DbjuNIrJnsUyaN9zE8joQfMoOSECnPL76D/POg
         jeUZ86eV9Ng1jdQflclib96LYtcNVrZhfNDHGG1mrpYghIKon5KKiNAg1rCGx9YAjIt0
         yTSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773070493; x=1773675293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2aTy0R+XTQKbHXXKr9Mnyna9OWj3RkjcnoZQYJLkb9g=;
        b=WQ/x87CuEMnxdPtaPDBkKSnyWpZV6WPEOT4PWxGeGakT4U+9IF8t2STsHyowj7nvzY
         WemRFL9c3FIYVvrxSHN9iacV1lj0VLYcrOg+6h0Eo8CIgPoNmLWkiebGZ2sWdfJwQZVm
         c6Blc1+LS5FjXe3LeUhXK8Bb/G/t77FHMz7wttoWDklhEKqWCR/HkYlT1fwIcpa37eFM
         4DDel5ow+z6OmGbBJRSGCdsZlwYqQ2Ypt89xSJFoCG1P1v2jsDcKfbAb6/XWRcznfLmk
         qa2x/xmQjAoPahhHwkPhP23+rP6kc7gHnnJMYKYNK0lmgKHYqub6zMzk4VhD1YzB2b3G
         diZA==
X-Gm-Message-State: AOJu0YxQSfV4tZm0kL1KthqE8bnS8KWbWM78wDyApEbCePb4GMbIVINZ
	H8iRBRXNT8ZY3Hs10L1zMkjOWS5FnDSTBuMx9It7IPbT68PCqpuokI45
X-Gm-Gg: ATEYQzzjwfxJyZTrnIHbe7so+4n61Vn6oQwId4yGJrKLP/jDInEdRktZRaWNz7L803W
	qH6FM6/is5V3zBNFHxE6CCOIu2bzBtosbpFkXtr37UaWzRgd8gfpw7bi65j2l6LMbHcevErsgwC
	AVC6xBLehjqIGLvQNS1HBZGyRvZ4HXhGSzPF7HrRSeq7R35Ike8fFbVPAqcpxhbCebw2i93F6a9
	FxeeklFrgXOitMTW5eBodWD0WF100v0/1Ix4ZZvCxcOuOLK4T1alLAGFM4v3hR3R/m7l4svkzaA
	+GjHRkAL/WIpnYlD/TjO7DeMMFaJhR0IpQ+ConwuqV8qlativ49d8xD/eYTUyree0TdgYdsiBFY
	ukNwW+8e+zMxsVOV1I06K0cpejj0TLRgZMl19I2eJUhH4SNfbX3Giq42/1CTc8YgR1dbndavAT/
	BU80qY673gbDdd1CVOMiaS7c9J9MoYFogd/V8tvCnzVOJvJTduYWBPZIYBbIGrIhHOmidi0TbzQ
	xMqma+0sl0+BcS5xQgcAztFXN1ZWQ4mE1R5Kg==
X-Received: by 2002:a05:6a20:ce4d:b0:35d:5d40:6d79 with SMTP id adf61e73a8af0-39858fb5ea9mr11500525637.12.1773070493270;
        Mon, 09 Mar 2026 08:34:53 -0700 (PDT)
Received: from fedora ([2401:4900:1c80:20f6:77bf:3a75:33cb:748c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c739e16cebbsm9316563a12.16.2026.03.09.08.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 08:34:52 -0700 (PDT)
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
Subject: [PATCH v2 3/4] iio: accel: mma9551: convert to guard(mutex)
Date: Mon,  9 Mar 2026 21:04:07 +0530
Message-ID: <20260309153408.71512-4-rajveer.chaudhari.linux@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309153408.71512-1-rajveer.chaudhari.linux@gmail.com>
References: <20260309153408.71512-1-rajveer.chaudhari.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace manual mutex_lock/mutex_unlock pair with guard(mutex) in
mma9551_event_handler(). This ensures the mutex is
released on all return paths and allows returning directly
without a goto label.

Signed-off-by: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
---
v2: Dropped Header alignment change
---
 drivers/iio/accel/mma9551.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/accel/mma9551.c b/drivers/iio/accel/mma9551.c
index 02195deada49..65a913972ce2 100644
--- a/drivers/iio/accel/mma9551.c
+++ b/drivers/iio/accel/mma9551.c
@@ -9,6 +9,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/slab.h>
+#include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
 #include <linux/iio/iio.h>
@@ -337,7 +338,7 @@ static irqreturn_t mma9551_event_handler(int irq, void *private)
 	u16 reg;
 	u8 val;
 
-	mutex_lock(&data->mutex);
+	guard(mutex)(&data->mutex);
 
 	for (i = 0; i < 3; i++)
 		if (irq == data->irqs[i]) {
@@ -349,7 +350,7 @@ static irqreturn_t mma9551_event_handler(int irq, void *private)
 		/* IRQ was triggered on 4th line, which we don't use. */
 		dev_warn(&data->client->dev,
 			 "irq triggered on unused line %d\n", data->irqs[3]);
-		goto out;
+		return IRQ_HANDLED;
 	}
 
 	switch (mma_axis) {
@@ -373,7 +374,7 @@ static irqreturn_t mma9551_event_handler(int irq, void *private)
 	if (ret < 0) {
 		dev_err(&data->client->dev,
 			"error %d reading tilt register in IRQ\n", ret);
-		goto out;
+		return IRQ_HANDLED;
 	}
 
 	iio_push_event(indio_dev,
@@ -381,9 +382,6 @@ static irqreturn_t mma9551_event_handler(int irq, void *private)
 					  IIO_EV_TYPE_ROC, IIO_EV_DIR_RISING),
 		       iio_get_time_ns(indio_dev));
 
-out:
-	mutex_unlock(&data->mutex);
-
 	return IRQ_HANDLED;
 }
 
-- 
2.53.0

