Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2585D3CC333
	for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 03:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778814827; cv=none; b=QSUUnw6c77Va1BsY7r5vBk+cFi97RzSPoad/o6Pj4HKW3OU+QT8QYrgQI8EQqwdHzpP9ajCx9ZzI5MFXLkY8ERIQsigfu62nHoT8pMC7D2C23TtNuYEK6SrR8fE1rdl9xeEZ9XZN8XME1vhwdn2JVCa3uNtDBDCUTorkSdXFcAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778814827; c=relaxed/simple;
	bh=RIdYUPIkj55aOxKmG8ieOZf2q4U8JvdBnT6YZ3PGbgU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nV60iStuXhVko8QxrVNkEW58UWnZLJFeNAb3xCgZPnCuPzkYrGYAP4PYtpARtsUEBLJrPzYwJoA2KvuIGrtiepn/+eh/z4Ih4x6DZ77S6xHzk+fxBWeeFUF4+Fs6hN9KOzVCZM4MD7eM6M+1jF99OsYxOTE/qrb1qltoCtyjpL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qLgOCNfS; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qLgOCNfS"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-479d9b155deso3163976b6e.3
        for <linux-iio@vger.kernel.org>; Thu, 14 May 2026 20:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778814825; x=1779419625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H679N6O22BUouiiSiZpjnTQT+Ni/owHD5GAANlmVxKc=;
        b=qLgOCNfS6akJxio7aZE5RxkHv5xTlamQfsRmeX22SVGzips/CYsw9JI5zMsmlGrvJX
         llUyg5tv4xFsqmXeBnkfBey+CAgaIkXy8aK9aMnzDw92AVVQ6+LpzTFyE6Ep7m9gczUX
         VHFFeCw0hnqWYiXPELxDJ79/l/oqNK+LyXOpJNQ9sdzap3zJ+zP5Rwm0m7AKFL8GaQIv
         oTMQa3v0ztrt2I554j5uLraOl5M4GQF6Re96PXwbRz8ur0Hl905zf1+Pbfwx1nWmDmcb
         LnY5CFNaroHu56xiXOwBf13rcQaeZreoc9gyoDKEDC4DEg4S2gmnYcE/Dx0Wxs0nbNan
         1oJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778814825; x=1779419625;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H679N6O22BUouiiSiZpjnTQT+Ni/owHD5GAANlmVxKc=;
        b=OepCebEQegWkMUy7MmzPBp59AaoL5nkdn7PcMVq1WIpF6hPiqmN0PBLkVy4wn3LKDy
         A55RvFKtU0TchrV5wxInth+RigFi1Ma723CwXkBJYMsxKEo5L5U4lMp8p9xfVg1FStzu
         YJClEYlTSTsUkErM+QKyx7ZItkfUIZUKC0QjhgNWcedS/EJ+n9t7TZYnAvMp/wkZOvlg
         Sq+/Lz4+tAWnyvogkL7XHZUjnNMHv44BY7TLhGKPu51DU1a/XH+1fTdKpNZVpK5DsvT+
         OKb1ZgO07msMMj4Ii1zbF/OEeIPHq3hSdMxFvvSaDjfSrMG5Lz1h4SIq7RsUlc5cI+iQ
         lfZw==
X-Forwarded-Encrypted: i=1; AFNElJ9EDjUF6qhuWfwLQ1JH9u9l0us71gutDtxmvzMZFgA6G7LcfvWJSN1HE5qALWc6buNJGd4h63ZN+pI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/QH7aump1ZiLRIKWkTXrWEWhHdi/E3MmrXf2YLICP1a/2VeuY
	qM5eOcldNuGD8u1AGefU1Og6aU7tMggf7LYrinf0hs1YYmX7H0eXdgty
X-Gm-Gg: Acq92OFnZ5xyLeoIcKy8O/ID3cugnIpYgL7F4weeKmspxjNchV/Nsf76ZwMkMRgCT8t
	laaBWD+gyzOv5A6E/gLq2P2SmCnFqjQqK83doWrih1T5CAaR7GoLxtYiCFBG59mugetTn0a2G/R
	4by45rdiFdY8I/6xcA2kPBLYSRL5wlZxUtV2Yeiud5wy15TfQmQr8utx5emP9/ARlFhJOOHnLEa
	dokSrG1trzgw54rzW965rJMMD0KOf+8rC/FOr80bkWrJjAkbHYvKWZdPBQ8zi/1ixGKxALQUkuM
	mMSkYi6VPiTMtMJO2hc1qt3hSD4sJFX3OaMTuveaHKmieL3j20lCcqkThuG7daBn1zIR3c4q7G9
	OD5H0f4yx8IVjoqNehLNen/sDZfF1wWmrfIp9ySCBTL8zuEvP+IKCH5i83V9O0kK1LNzs9jZJDM
	Sk/vSSTUEdEKhwPQV6xs7LvYH1+ovYIBoOa/nVjUsoHwy6QRmuRaOSi4K2Yg==
X-Received: by 2002:a05:6820:81c7:b0:694:8cb0:4efb with SMTP id 006d021491bc7-69c942aeddemr1372306eaf.8.1778814824795;
        Thu, 14 May 2026 20:13:44 -0700 (PDT)
Received: from linuxescape.lan (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69d0460b68bsm238434eaf.4.2026.05.14.20.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 20:13:44 -0700 (PDT)
From: Maxwell Doose <m32285159@gmail.com>
To: jic23@kernel.org
Cc: Tomasz Duszynski <tduszyns@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3] iio: chemical: sps30: Replace manual locking with RAII locking
Date: Thu, 14 May 2026 22:13:42 -0500
Message-ID: <20260515031343.56039-1-m32285159@gmail.com>
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

Signed-off-by: Maxwell Doose <m32285159@gmail.com>
---
v2:
 - Switch over some scoped_guard()s to guard(mutex)() per David's
   suggestion.
 - Remove redundant whitespace per Andy's suggestion.
 - Add new wrapper sps30_do_meas() per Andy's suggestion (see commit
   message).
 - Add Joshua's RB
   (link: https://lore.kernel.org/linux-iio/CAKqfh0FWig8mRR-xhvnfcFeSinR6RySyPaf9Gbpb6WU+diiiUQ@mail.gmail.com/T/#t)

v3:
 - Remove sps30_do_meas() wrapper per Andy's suggestion.
 - Remove Joshua's RB (major changes).

 drivers/iio/chemical/sps30.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/chemical/sps30.c b/drivers/iio/chemical/sps30.c
index a934bf0298dd..9cb201cf0f15 100644
--- a/drivers/iio/chemical/sps30.c
+++ b/drivers/iio/chemical/sps30.c
@@ -5,6 +5,7 @@
  * Copyright (c) Tomasz Duszynski <tduszyns@gmail.com>
  */
 
+#include <linux/cleanup.h>
 #include <linux/crc8.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
@@ -111,9 +112,8 @@ static irqreturn_t sps30_trigger_handler(int irq, void *p)
 		aligned_s64 ts;
 	} scan;
 
-	mutex_lock(&state->lock);
-	ret = sps30_do_meas(state, scan.data, ARRAY_SIZE(scan.data));
-	mutex_unlock(&state->lock);
+	scoped_guard(mutex, &state->lock)
+		ret = sps30_do_meas(state, scan.data, ARRAY_SIZE(scan.data));
 	if (ret)
 		goto err;
 
@@ -135,8 +135,8 @@ static int sps30_read_raw(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_PROCESSED:
 		switch (chan->type) {
-		case IIO_MASSCONCENTRATION:
-			mutex_lock(&state->lock);
+		case IIO_MASSCONCENTRATION: {
+			guard(mutex)(&state->lock);
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
+		}
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

