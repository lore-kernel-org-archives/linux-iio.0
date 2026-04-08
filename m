Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7798139FCC5
	for <linux-iio@vger.kernel.org>; Wed,  8 Apr 2026 08:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775636928; cv=none; b=k8CrkUUUZHVpFn2JEWSTC8vlqZjgdAG1EGGmyqqefMkgH5eQHK4r4wyxSMomQIEbAgQgMpHTXxFmf+Wnt+/oiidvBkyVp0UWm7yapfXqECa2PuGNVdqGH1GiPgad1hBOSr/Ax2c+zsOKuUHolVeVqx73xaE7KAjTq+/72WgzQnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775636928; c=relaxed/simple;
	bh=v/FO0aWWbbSb3JoRTo/+tfhB+lXepZqUYX6A2C5W97k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RnCChMHDE82xR6NN/m0gUMHUCjH9HmABj7MFhNpo8eiqESKdO0JoDkuqrqIh38kIGRgprToFbsjqRxHa4YRpdFrlFj0sHtU7p5Y3kcjJGNWu901J8XhD7ZaLBjZJMfH+LNDcR2tpuL1ALxPjdpj4LKIaM9lK6Fv7WwTOSuc8/60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ms97RULX; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ms97RULX"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4889e045bc6so41041365e9.2
        for <linux-iio@vger.kernel.org>; Wed, 08 Apr 2026 01:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775636926; x=1776241726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Do246NgdUNzatBzvaCGxffgVv9rn8I33X/aBmCFoZtY=;
        b=ms97RULXLdgRAKYz+k/4NboF/GZx/pbyJYltdVuzR9y1C9UclipD0m9HuvRm2leJgT
         qUz0h8AQC59TUsr41xJlm4RuyjFcRXd3/4YPt2jhmzd+5bfDn4jpx9aWURoZQ4jV/LnE
         IVLQqUo4APTn8R9frvPaZKaEN2o2Cm/7VDvNdF0+JvRwaQPAAkwCL2nSFFE6Deqe6LrJ
         q/94oWyqVqjY3CdohiC0lC7iqkRgRChi+f9cKgmyahjDOtAoQka+DqieafhNi16Ubf32
         /UWiImCnZNkpXuXO2eZgW4YjUztg5JSYj0v/gQCfGeWOZp68cuwuwmFV5H/uQuLSlr0o
         VvSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775636926; x=1776241726;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Do246NgdUNzatBzvaCGxffgVv9rn8I33X/aBmCFoZtY=;
        b=n2z5IoX2WiLMtcvijrnKpbZXNR7u3eBGa/t4A1BqjlToytR/Kidgc/BVbGknhGrElL
         6v3H0njFigw89lVluGNd1StLhYg085cqmAJEWcg5+T3wfpSwGn/vhCuoaqjMg33KUbYA
         9qhG2c2z80zAyGLl5bidfsEw2kdr00xHY6WZs0A4GC5suq4HIfTbVKXhl6RYs8mTCmeX
         zAU9qYAD58ufmy1YgHRf8zoSKcdHcMVIpBIUM7hh6WyLPJ427Fi1mKeWBiaQdn1QHezr
         Ea0QdcfFXoJMOLFH0QxwgI/ewZSdvlxTcep40A1VQ9CxRKtQzTbEhQ4asRGvUcUHQOzB
         5xjw==
X-Forwarded-Encrypted: i=1; AJvYcCXy8qY2Q2IuQaBJoc/V5sAXbHUA06pvZGIlOIFOz+xHKsAjKWQ432tCB2S7Az/h5tnwKQb28scpIdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpP1t5oparrRkyo9w+ZxN5u4QM6Q0R8ErI5LLVBcZPGrwdNg1E
	YbgCCxl006etcTqL/Ku10XP+TSfGudnJDxgAjIUgK/Y4LWTE0gKSrwkp
X-Gm-Gg: AeBDieuFWTs1cjba7lcM8moW2TQLyfpaV/639eCbfNmk6gbfmwfed1PLVUKvW9aZVyY
	ObKC7IFpaiB+6imJmoQi1WksaxddJqVuTGarDXEy3aILqFdwR9q9TitPBMiu0ZBJvNk/FDfUKOC
	fNMQPq2Z4Ar9SehR6eHiVsFdAwEyvMDLOT65EOwUIYKKdgfiU7abVe/ItVLRPrUZUW3CNuOEPs+
	weoMdVKHE78RV7xdfF2NSb4mX8XYJ49bjK3zWoYFrrpxuapul04KzAwrrFRxluNfFQ7Ys5iRC8D
	C+dqhM0NWIJlB9HVhc1il6RIysKneuvRaJm3anIVZMgcClHjNkZaGfAP3nxBaJ9bpsS5yarp3Eb
	XrrB5NIFQ5bdbr5jOgUUlzoKhyHig4asGTcAAhvZd66tZV7Xcucss9lyhb86tZVfg4AMnH0dQc7
	x7hbDRNGdGfKtwSsVzjP6ut0Ny4k3MTRRIIjOCtRvjYI5Bzr1jTQGc
X-Received: by 2002:a05:600c:8b54:b0:488:869c:edaa with SMTP id 5b1f17b1804b1-488996d9cdcmr302389285e9.7.1775636925713;
        Wed, 08 Apr 2026 01:28:45 -0700 (PDT)
Received: from localhost.localdomain ([2001:8a0:6c9b:a000:d997:3078:a4d3:4f51])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488c5ceb914sm22341925e9.3.2026.04.08.01.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 01:28:45 -0700 (PDT)
From: Gabriel Rondon <grondon@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: accel: bmc150: use guard(mutex) for mutex handling
Date: Wed,  8 Apr 2026 09:28:42 +0100
Message-Id: <20260408082843.35716-1-grondon@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace manual mutex_lock()/mutex_unlock() pairs with guard(mutex)
from cleanup.h in functions where the mutex protects the entire
function body. This simplifies error paths by removing the need for
explicit unlock calls before returning.

Converted functions:
  - bmc150_accel_get_temp()
  - bmc150_accel_write_event_config()
  - bmc150_accel_get_fifo_watermark()
  - bmc150_accel_get_fifo_state()
  - bmc150_accel_set_watermark()
  - bmc150_accel_fifo_flush()
  - bmc150_accel_trigger_set_state()

Functions where the mutex is released before subsequent non-trivial
work (e.g. bmc150_accel_get_axis, bmc150_accel_trigger_handler) are
left unchanged to preserve the existing lock scope.

Signed-off-by: Gabriel Rondon <grondon@gmail.com>
---
 drivers/iio/accel/bmc150-accel-core.c | 49 ++++++++-------------------
 1 file changed, 15 insertions(+), 34 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 42ccf0316ce5..6a2d7a133d2e 100644
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
@@ -597,21 +598,18 @@ static int bmc150_accel_set_scale(struct bmc150_accel_data *data, int val)
 static int bmc150_accel_get_temp(struct bmc150_accel_data *data, int *val)
 {
 	struct device *dev = regmap_get_device(data->regmap);
-	int ret;
 	unsigned int value;
+	int ret;
 
-	mutex_lock(&data->mutex);
+	guard(mutex)(&data->mutex);
 
 	ret = regmap_read(data->regmap, BMC150_ACCEL_REG_TEMP, &value);
 	if (ret < 0) {
 		dev_err(dev, "Error reading reg_temp\n");
-		mutex_unlock(&data->mutex);
 		return ret;
 	}
 	*val = sign_extend32(value, 7);
 
-	mutex_unlock(&data->mutex);
-
 	return IIO_VAL_INT;
 }
 
@@ -810,17 +808,14 @@ static int bmc150_accel_write_event_config(struct iio_dev *indio_dev,
 	if (state == data->ev_enable_state)
 		return 0;
 
-	mutex_lock(&data->mutex);
+	guard(mutex)(&data->mutex);
 
 	ret = bmc150_accel_set_interrupt(data, BMC150_ACCEL_INT_ANY_MOTION,
 					 state);
-	if (ret < 0) {
-		mutex_unlock(&data->mutex);
+	if (ret < 0)
 		return ret;
-	}
 
 	data->ev_enable_state = state;
-	mutex_unlock(&data->mutex);
 
 	return 0;
 }
@@ -847,9 +842,8 @@ static ssize_t bmc150_accel_get_fifo_watermark(struct device *dev,
 	struct bmc150_accel_data *data = iio_priv(indio_dev);
 	int wm;
 
-	mutex_lock(&data->mutex);
+	guard(mutex)(&data->mutex);
 	wm = data->watermark;
-	mutex_unlock(&data->mutex);
 
 	return sprintf(buf, "%d\n", wm);
 }
@@ -862,9 +856,8 @@ static ssize_t bmc150_accel_get_fifo_state(struct device *dev,
 	struct bmc150_accel_data *data = iio_priv(indio_dev);
 	bool state;
 
-	mutex_lock(&data->mutex);
+	guard(mutex)(&data->mutex);
 	state = data->fifo_mode;
-	mutex_unlock(&data->mutex);
 
 	return sprintf(buf, "%d\n", state);
 }
@@ -906,9 +899,8 @@ static int bmc150_accel_set_watermark(struct iio_dev *indio_dev, unsigned val)
 	if (val > BMC150_ACCEL_FIFO_LENGTH)
 		val = BMC150_ACCEL_FIFO_LENGTH;
 
-	mutex_lock(&data->mutex);
+	guard(mutex)(&data->mutex);
 	data->watermark = val;
-	mutex_unlock(&data->mutex);
 
 	return 0;
 }
@@ -1021,13 +1013,10 @@ static int __bmc150_accel_fifo_flush(struct iio_dev *indio_dev,
 static int bmc150_accel_fifo_flush(struct iio_dev *indio_dev, unsigned samples)
 {
 	struct bmc150_accel_data *data = iio_priv(indio_dev);
-	int ret;
 
-	mutex_lock(&data->mutex);
-	ret = __bmc150_accel_fifo_flush(indio_dev, samples, false);
-	mutex_unlock(&data->mutex);
+	guard(mutex)(&data->mutex);
 
-	return ret;
+	return __bmc150_accel_fifo_flush(indio_dev, samples, false);
 }
 
 static IIO_CONST_ATTR_SAMP_FREQ_AVAIL(
@@ -1230,32 +1219,24 @@ static int bmc150_accel_trigger_set_state(struct iio_trigger *trig,
 	struct bmc150_accel_data *data = t->data;
 	int ret;
 
-	mutex_lock(&data->mutex);
+	guard(mutex)(&data->mutex);
 
-	if (t->enabled == state) {
-		mutex_unlock(&data->mutex);
+	if (t->enabled == state)
 		return 0;
-	}
 
 	if (t->setup) {
 		ret = t->setup(t, state);
-		if (ret < 0) {
-			mutex_unlock(&data->mutex);
+		if (ret < 0)
 			return ret;
-		}
 	}
 
 	ret = bmc150_accel_set_interrupt(data, t->intr, state);
-	if (ret < 0) {
-		mutex_unlock(&data->mutex);
+	if (ret < 0)
 		return ret;
-	}
 
 	t->enabled = state;
 
-	mutex_unlock(&data->mutex);
-
-	return ret;
+	return 0;
 }
 
 static const struct iio_trigger_ops bmc150_accel_trigger_ops = {
-- 
2.33.0

