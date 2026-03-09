Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B4C3AE6FD
	for <linux-iio@vger.kernel.org>; Mon,  9 Mar 2026 14:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773066276; cv=none; b=lo4MC8sYSvQsJeTAJARBzEQCTsPxqioiP8pjDpMPlkzopAop5kLbIIcdEd16lHLh0OGnMxdmoXWAq682j4wURPm2VE6gY3klDGLljYJf1S44FEc+4az0Dpj5p7Z+cBAZNnSN+7t4f7wkgqtJ2+twgbABkVPYl75TYyjU7AyuY90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773066276; c=relaxed/simple;
	bh=CLI9Tm1/iHPRkfpythGWyrB52NK/CNiw9SacNMZjIS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WSSzQCC0SaweP5lqQ79q16KTAfAeqcracOzB6A6wAXbURG14xUwF23XGUk6iQMennNcx3bE8/ajpG/zMT4LVsCI+uMtuHfS9m8LRXm5etZBR2zPpRM3xzKL/E0atQHuHTeXeoBtQ2t9tOVdOFcAue3hfCToSho7Ea9LFoR+sNuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K4CU5VHZ; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4CU5VHZ"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3598b2318c2so4864617a91.3
        for <linux-iio@vger.kernel.org>; Mon, 09 Mar 2026 07:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773066275; x=1773671075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bgyeu6qwDJxvPvHbOAbXi+4MEkb/h61SteASe+ruxqw=;
        b=K4CU5VHZxuTKL6cp5UwMYNe658NAjSeDt7YTzZre2yDAFFwwxuYk/4WbEEr9r7HFR5
         JZ6KXpIuJ+bovhtgTb6YEt0tHyaJ/WWzKm1nQ6viO8bj6UYRU/agZhPaLaY9cwQ1cvAU
         4G7U5dCaEsOotiKmJljCeSE2dQkZQRKcfaPCedEal7GhsxoVGYYM2uIb4tsM4WqnkOG/
         OQKa6v85OcysLi5obvuYxSUbkosHixCZaKegNQkseQg2O/yoEE74diE8Lc5zxrZG/0qS
         vDFmZW/4nqP4j/j0Yq3pGjHJ7tN33PD30u9xxU1TGi7ZAGBqrHy5bhjRSCEv1pyEf1Ic
         7zZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773066275; x=1773671075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bgyeu6qwDJxvPvHbOAbXi+4MEkb/h61SteASe+ruxqw=;
        b=QrWo+Yg7TZBMqzu8HOUvwEhPG1ecbvAA3cpyzM66WrjuK5O1opPvqWncikwE7DIkDE
         rkIP1e96Q0LBITPFBxNt9rIn+jjLWvUwUAO9JwlyP7iHVJIF8onmTvG1j8j2sDrSj5sd
         qAT04QyeV8MhojpV+9M/61Rz/72xblW2SB4VPfesf7jm5uHVQ9jrC61hSAscJfu8Bx6q
         QGWE6jIXbIrDVdNY7EnxJNIaDMP1h4ufXzOdMu5fdnjvpnvloJQ8vCf7gq2M3CPypKxi
         JskX8fLA6mnWaS0O65nCAXefpuVi5WmdgHSVgzm0RMSV8UNqIxo4ImI5L8vDMcQ4oD0X
         9bcg==
X-Gm-Message-State: AOJu0YzZzuK0NSJm4c/U0eW5HG2ps/8xIU3MtYMR0Lgg492CKdzHIn+N
	snJQMDHEiXRpV29cnXSzC1+boLA1fdMv5+XJGK0o1huxZl9k3PkGqb/j
X-Gm-Gg: ATEYQzw5GZCSPGHoJrvN27zh9vIS5+aF4u8OeK0RlJCA1fKVzZUku0bed5rw4np2Azd
	p9KImqvV07Pnm8m5ER6Bk5Gq9z0c5t1nwwau29nM1uhH4PHmlxScUNTSKveJXVkEBnLTSaf/Z63
	nCzptg7vrO/cbFKmQg38FGuo+Jj7DthFDR0l7prU49HXeakKQdPUFrb8jArXPYaTbtTQUnd7F6y
	7MUEuIJAGEE9omO4Kemfhc22OXJCEkWA/N0NoK5FMhAOxM4a2jyrdC8jn+vE5Zd8qwbYz7WAV+g
	6rUqqpU7Ro0vm9erKnce6pmSZ1ZViih/SeKqBKWFMOtDb+hzGzXejQI14cnIW9T1jK0d32+zCJq
	XJ4/N7UJ//icG0WPMCDNLuk5A2FSsh8C1bDuLM4wv7kMdA7xYcyZJVjPqo4RjlCkl4bXE3mkZZv
	KflJF6Wl17MG7FVGR8aMgTwsoB3Qyzu/vcWVXOQ6qp9dkFhFIcbk6fltE5GKL5m7Uhv1cqUxr+k
	7DzvM012LUD56yxiydi3e/zNmA=
X-Received: by 2002:a17:90b:4f4d:b0:343:6108:1712 with SMTP id 98e67ed59e1d1-359be34987cmr10184664a91.18.1773066274989;
        Mon, 09 Mar 2026 07:24:34 -0700 (PDT)
Received: from fedora ([2401:4900:1c80:20f6:77bf:3a75:33cb:748c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359b2e0e1aasm18985311a91.15.2026.03.09.07.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 07:24:34 -0700 (PDT)
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
Subject: [PATCH 1/4] iio: accel: bmc150: convert to guard(mutex)
Date: Mon,  9 Mar 2026 19:53:49 +0530
Message-ID: <20260309142352.57407-2-rajveer.chaudhari.linux@gmail.com>
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
bmc150_accel_buffer_predisable(). This ensures the mutex is
released on all return paths and allows returning directly
without a goto label.

Aligned headers in alphabatical order.

Signed-off-by: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
---
 drivers/iio/accel/bmc150-accel-core.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 42ccf0316ce5..9ae325cdfdd3 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -4,23 +4,26 @@
  * Copyright (c) 2014, Intel Corporation.
  */
 
-#include <linux/module.h>
+#include <linux/acpi.h>
+#include <linux/cleanup.h>
+#include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
-#include <linux/delay.h>
-#include <linux/slab.h>
-#include <linux/acpi.h>
+#include <linux/module.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
 #include <linux/property.h>
-#include <linux/iio/iio.h>
-#include <linux/iio/sysfs.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
 #include <linux/iio/buffer.h>
 #include <linux/iio/events.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
 #include <linux/iio/trigger.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
-#include <linux/regmap.h>
+
 #include <linux/regulator/consumer.h>
 
 #include "bmc150-accel.h"
@@ -1485,7 +1488,7 @@ static int bmc150_accel_buffer_postenable(struct iio_dev *indio_dev)
 	if (iio_device_get_current_mode(indio_dev) == INDIO_BUFFER_TRIGGERED)
 		return 0;
 
-	mutex_lock(&data->mutex);
+	guard(mutex)(&data->mutex);
 
 	if (!data->watermark)
 		goto out;
@@ -1517,19 +1520,16 @@ static int bmc150_accel_buffer_predisable(struct iio_dev *indio_dev)
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

