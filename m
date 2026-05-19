Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6307C3BB68B
	for <linux-iio@vger.kernel.org>; Tue, 19 May 2026 21:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779225967; cv=none; b=nOVeNX9pJrUOCVZsp06O8jnFpBIgYXAZOiw36C9xkX7xO3mhAk0Dn47erARWtzm/pWIQ/XT2wD+1+05OE7Yz389JtV+spUqTznQQSCvth1/SCLFnmt6pdfQ3izM4APylQCn20BoW9lclUPOtLjrninZPIB3ieX1P8Dv25SoYS0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779225967; c=relaxed/simple;
	bh=Q6Kpw7qYanWlv6raDyDWu1oLUku62fOxzuJhGCZ1q7A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RVnYuj29T2cKHW6zXLOAxwMKYLWXgYJFT41O+G0vNyWomXWUP6VMIfCgxmcIwJcTrXtB4qjjApYStHu39DGNcSjELBfLE1B1DhcPqCkNysENnb99ECXGUYkxmm80Y1YLc+tbgRdch5s/t1ICDcmG8qVwUhDollzivKsgMmuc+2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g3qZZlQN; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g3qZZlQN"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-682fce74c06so2573971eaf.3
        for <linux-iio@vger.kernel.org>; Tue, 19 May 2026 14:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779225964; x=1779830764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B0KyhkGaS/nUapgZFdjRlHgIG4C/dkih9MtGyG/usJY=;
        b=g3qZZlQNKF6mrtSMZzXAtU3s2UWfpZQTbCbl0f0I3WLCgXgeMIont9nk2+TlWdLdoc
         S3hecVNIaLzIyPtdiG7+FlRWYGRN3ee+EgXuCkAQAVlvJYAF9BwsljQkH/wa+gSWmn/y
         cowdzx3695EIAsxeB13IvOJ0n45zY8CqjH792sDUvL2PW+HjdXyDdWnpApqdyanbdmBW
         yUSPQ8jL52EoXFlw6+2/dECh3msFH86hXR1eWTDIM/cY05XGo1yc/7Raj8FyCEJm+SUD
         6fLimfDrXN2V+TCUEiP7Cm532YMAprd/wZZ34ZZ9eMl/giJKbsSQ5DZ5vVtCSADll/4z
         hgUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779225964; x=1779830764;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B0KyhkGaS/nUapgZFdjRlHgIG4C/dkih9MtGyG/usJY=;
        b=lNFDYoTB/07JxuhtDopmjmHh3Q7j9faYtldG8gK9aHo+rb/pcKVtIsYiFy3ZUwRxzl
         xGlqeB7nkLKhTS5fJCQWuZq64/6+Yg9/mpmn87cJ38HxgU78DWqE4a+pM5qlbaRprt5R
         qtkPSIGPcfJqeDxi3yi8Y9z/+Bei+M8t/TYCS7ObavgplKDgi6M5EL/DpNBG8AqPVQtZ
         x/x+kaEXH7jcph4KZTu75LTqbLmr4gQSu9LPU9WuE7pS0swXlF4zBbMkX836REykr9I1
         S+Wc6p5hvWIWmsNZQ3puP2w3rifKluBnM837LM4BIaUrVB0NH8isZN9iX9CnxHbCG9Pb
         dg0Q==
X-Forwarded-Encrypted: i=1; AFNElJ8AI4JwhJLke4sBfywYo74n37+inERBX5EUtky/IjPY89CpEypFrl51tZX8291lRWlepMDC4f45uPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YysiJsFpcy/hmL4pwTGmQzeYqRNjK6AfHLwoQPxuUnKcXcOrOu/
	ipkxhMyrvW5ot2O07t8rxohVBnI0e6jfATLjiXMVEt64qXjVJ0FFb9LU
X-Gm-Gg: Acq92OFLd6fnADwrAAqJh7uxUOMwlvZ9751BY5i9QZJZyyxkcqeJNjK+rmKehgez/Ck
	Wb2RYeF4awpHdsmxN4Jik8sBlbldstRWrzcjPgtZONWkHD/SY79hN1ZLCfI7ZJF5f6VQ20gKA8d
	sgDLeVYpLVLcdTPZ8ggUcLFMTdfPQXkf5QdUvwyy2iIn/yxolyiULjFkkFlLwfNZY7HF2h+qV0e
	7KuXkAjrvqKk7kCE1iuSKSeFbuLKk4Cwslx6LtPzttEmOAnxYWM8wuvDAJgGxZhiZl7ssTHqncJ
	oMV3dOfyI3w53fdQK9sZ7eHUukTOEZfau+SHELeumexLxGZHq0qoCYyqVeWpJnRmfZyaWUIEx1i
	bivC7oi60autR42vSPd5QtQJmu/k+Oz6XgrbRk+KLm59+zndLXyNRnKAbC88MKuPBTfP6L/z2Kn
	R3DbdwhpeJFLLKFBVZ6zkHY2dwdtxYY3+Y0Bi6pM84222U2BEkiIXMwgrDCQ==
X-Received: by 2002:a05:6820:1513:b0:67b:baae:3339 with SMTP id 006d021491bc7-69c94583a5fmr14064058eaf.45.1779225964100;
        Tue, 19 May 2026 14:26:04 -0700 (PDT)
Received: from linuxescape.lan (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69d045e6646sm8012606eaf.1.2026.05.19.14.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 14:26:03 -0700 (PDT)
From: Maxwell Doose <m32285159@gmail.com>
To: jic23@kernel.org
Cc: Tomasz Duszynski <tduszyns@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4] iio: chemical: sps30: Replace manual locking with RAII locking
Date: Tue, 19 May 2026 16:26:02 -0500
Message-ID: <20260519212602.30541-1-m32285159@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace manual mutex_lock() and mutex_unlock() calls with the much newer
guard(mutex)() and scoped_guard() macros to enable RAII patterns,
modernize the driver, and to increase readability.

Add guard(mutex)() into sps30_do_meas() as every caller locks it's call.

Signed-off-by: Maxwell Doose <m32285159@gmail.com>
---
 drivers/iio/chemical/sps30.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/chemical/sps30.c b/drivers/iio/chemical/sps30.c
index a934bf0298dd..c10026509e9c 100644
--- a/drivers/iio/chemical/sps30.c
+++ b/drivers/iio/chemical/sps30.c
@@ -5,6 +5,7 @@
  * Copyright (c) Tomasz Duszynski <tduszyns@gmail.com>
  */
 
+#include <linux/cleanup.h>
 #include <linux/crc8.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
@@ -69,6 +70,8 @@ static int sps30_do_meas(struct sps30_state *state, s32 *data, int size)
 {
 	int i, ret;
 
+	guard(mutex)(&state->lock);
+
 	if (state->state == RESET) {
 		ret = state->ops->start_meas(state);
 		if (ret)
@@ -111,9 +114,7 @@ static irqreturn_t sps30_trigger_handler(int irq, void *p)
 		aligned_s64 ts;
 	} scan;
 
-	mutex_lock(&state->lock);
 	ret = sps30_do_meas(state, scan.data, ARRAY_SIZE(scan.data));
-	mutex_unlock(&state->lock);
 	if (ret)
 		goto err;
 
@@ -136,7 +137,6 @@ static int sps30_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_PROCESSED:
 		switch (chan->type) {
 		case IIO_MASSCONCENTRATION:
-			mutex_lock(&state->lock);
 			/* read up to the number of bytes actually needed */
 			switch (chan->channel2) {
 			case IIO_MOD_PM1:
@@ -152,7 +152,6 @@ static int sps30_read_raw(struct iio_dev *indio_dev,
 				ret = sps30_do_meas(state, data, 4);
 				break;
 			}
-			mutex_unlock(&state->lock);
 			if (ret)
 				return ret;
 
@@ -160,6 +159,7 @@ static int sps30_read_raw(struct iio_dev *indio_dev,
 			*val2 = (data[chan->address] % 100) * 10000;
 
 			return IIO_VAL_INT_PLUS_MICRO;
+
 		default:
 			return -EINVAL;
 		}
@@ -197,9 +197,9 @@ static ssize_t start_cleaning_store(struct device *dev,
 	if (kstrtoint(buf, 0, &val) || val != 1)
 		return -EINVAL;
 
-	mutex_lock(&state->lock);
+	guard(mutex)(&state->lock);
+
 	ret = state->ops->clean_fan(state);
-	mutex_unlock(&state->lock);
 	if (ret)
 		return ret;
 
@@ -215,9 +215,9 @@ static ssize_t cleaning_period_show(struct device *dev,
 	__be32 val;
 	int ret;
 
-	mutex_lock(&state->lock);
+	guard(mutex)(&state->lock);
+
 	ret = state->ops->read_cleaning_period(state, &val);
-	mutex_unlock(&state->lock);
 	if (ret)
 		return ret;
 
@@ -238,12 +238,11 @@ static ssize_t cleaning_period_store(struct device *dev, struct device_attribute
 	    (val > SPS30_AUTO_CLEANING_PERIOD_MAX))
 		return -EINVAL;
 
-	mutex_lock(&state->lock);
+	guard(mutex)(&state->lock);
+
 	ret = state->ops->write_cleaning_period(state, cpu_to_be32(val));
-	if (ret) {
-		mutex_unlock(&state->lock);
+	if (ret)
 		return ret;
-	}
 
 	msleep(20);
 
@@ -256,8 +255,6 @@ static ssize_t cleaning_period_store(struct device *dev, struct device_attribute
 		dev_warn(dev,
 			 "period changed but reads will return the old value\n");
 
-	mutex_unlock(&state->lock);
-
 	return len;
 }
 
-- 
2.54.0

