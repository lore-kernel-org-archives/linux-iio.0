Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCB8318EDC
	for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 21:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778448308; cv=none; b=uO1U6RwrDbmrCzT8C8A9mBxtUpzyH7hjKbLKElWdvt1uWicw11WKzqH429NEpJhzwI8cQxzLPRkjqHB4tR9sV9KscMAbU0Kkff0vWGmlZLL8Pc9IpF6YnipGfbd5r8l4wfLn9Gt/08td0cUCsjqcqf0qwlPcF05/sQgeb/rFVSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778448308; c=relaxed/simple;
	bh=JRY1F65O7IYM1S6iPNZKOcOvrVEw4sF1YmF/8ic/MtM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T5/lOaVhPus2e2DkXIpVwGuhinEhhHT0aHRQUOnfHZ+bfEjvSNPPRp/KMhd2q3LvCfF9FaTGTSKD7WIajEEvWYZGmkDhCaOqkBdl14CDUvPuz78DU8K72elfZfUZ/HK5zzs93psm8O6Lg7GJ/pQFGmb4zJHQBMUfasAPcqYhgWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cwJs15sE; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cwJs15sE"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-47cbd444fd0so2404645b6e.2
        for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 14:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778448306; x=1779053106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8kP/NXnV1x8+CLUpqNrBV3guCuP9Ar3LabTgNAmSG54=;
        b=cwJs15sE8lTm0MDZT2JaRIyrjCyeKT3mky6DbydEr4/YGKhi876sM4yuidvgiwIGA9
         3CdY/9Mh+kMhn2agQeIR7Bei0CLluOgsAPeTPNfkgg2VZZ5uX3vlVOwKCqIobogPaynm
         43j7kKh0QUOvtczGt9xBmjPkySFJRChOVTZAZrzTRIEfpGGn5P+PBNjCXHriPcNwClA0
         r++C4XPMeSQ0PV+C/Z56VvVOwWdfkJ1v2pm+4N3PjZ8rv7F/gS2Ux/T2maCeETQxLfSL
         IEYmtKthLk2v6vwVPdZeihhAzclwqg40QUR5plW364Hic/sIYhT8wZsKVTSxrI9Wg+Q3
         eQsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778448306; x=1779053106;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8kP/NXnV1x8+CLUpqNrBV3guCuP9Ar3LabTgNAmSG54=;
        b=T6arQbPdQ/eGtzQP73diqOuTcVaBbINBXrT2l3i0zcvqjvAz5lel/kYdijerDQKJsZ
         7GCDZgRFrGbmmMUZ97MMQxKL+sEZ54i+pqm3F29eSY1E4vUZft9zoQY8SZBtzCnCs2B5
         uBS0bjaRBc7HxK3ysMRPCcOK90P63/OntaZBf1nUoyhqZD6O6AR2qBLqxZW+F0JERglw
         HROJ1OC8bKa3KrR+Rqizmmc/ZrBfhWaW0HY5xwDgf4axL+SpD2FFTmntad+U1PnAAaO4
         x66xwE1OJedZleozL2lqYuuca35ahzJbETywohPla7+OxpfZoxNl7PH4xSDlGiR0izKM
         0aEA==
X-Forwarded-Encrypted: i=1; AFNElJ+fgkDKnwQIUFPUGoW2G4HmAbyx8iZgPU5Ma22MTdsXp93SKi77VcDcYroBruHSz6KKMOicekKbFbs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUn60Mm/Smauv+2Omo5W0fZNeNz2y+1ph/kbUuG0W+CumzIoz+
	VvelqFEa3x6XbPFcw7ojaay3aauOa4lcer8pmeLs1AWMqiOHWdJMmFiP
X-Gm-Gg: Acq92OEwc5WlAIVwRuphU7libkvjgEPWQVNgYAjKhBAXKUMrVKSCwGbxrESMusuqCsO
	HXvkZQo5QaNOanywzA+83wyR9V62hwBSZoPpSQXCXSxozwjW+BIFY9CdhXdhxk4CuMWYyVFOPm5
	He/VmnoLnuzQuW1WYz9LZQUNGqEaAK6XHsB5423TqmxXTnjmSWK6m/xsLnxTq1g3hZN+OhaDZxf
	IlJIhSlltz7RGl5LDk/Nn6fJTWHSurSf6S+3RmlHykNDM7vcem8vf2qmpwxOCkTK4CTzM69LqcV
	3YMhSB6GCpxH8CXSwduKRuaoZPmiqr6htjPr+a/653PfBW5QCFYrOYxzB4gzHhgI6x1LwFdQhOQ
	Grv99EMZpsFxJYll5yVfpM5LTlGHUxyaJZu9+olCj2Nt/W9+Or+CFEuXohBo3/6s8fatemqWSH9
	XmVs4H1Ktu+mAkSVS1yX2Rk44Pr1Ng5Xe5bLjLi5GzmAYPeAqqkfOVt87Y+A==
X-Received: by 2002:a05:6808:1644:b0:479:fbe5:3a4a with SMTP id 5614622812f47-4804258ba5emr12406956b6e.46.1778448306268;
        Sun, 10 May 2026 14:25:06 -0700 (PDT)
Received: from linuxescape.lan (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-47c76986f9dsm19269848b6e.16.2026.05.10.14.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 14:25:05 -0700 (PDT)
From: Maxwell Doose <m32285159@gmail.com>
To: jic23@kernel.org,
	tduszyns@gmail.com
Cc: Joshua Crofts <joshua.crofts1@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] iio: chemical: sps30: Replace manual locking with RAII locking
Date: Sun, 10 May 2026 16:24:28 -0500
Message-ID: <20260510212427.358756-2-m32285159@gmail.com>
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

Add new wrapper sps30_do_meas() for cleaner locking, and rename existing
sps30_do_meas() to __sps30_do_meas() to denote locking requirements.

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
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

 drivers/iio/chemical/sps30.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/chemical/sps30.c b/drivers/iio/chemical/sps30.c
index a934bf0298dd..1c44524be1cf 100644
--- a/drivers/iio/chemical/sps30.c
+++ b/drivers/iio/chemical/sps30.c
@@ -5,6 +5,7 @@
  * Copyright (c) Tomasz Duszynski <tduszyns@gmail.com>
  */
 
+#include <linux/cleanup.h>
 #include <linux/crc8.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
@@ -65,7 +66,7 @@ static s32 sps30_float_to_int_clamped(__be32 *fp)
 	return val * 100 + ((fraction * 100) >> shift);
 }
 
-static int sps30_do_meas(struct sps30_state *state, s32 *data, int size)
+static int __sps30_do_meas(struct sps30_state *state, s32 *data, int size)
 {
 	int i, ret;
 
@@ -87,6 +88,12 @@ static int sps30_do_meas(struct sps30_state *state, s32 *data, int size)
 	return 0;
 }
 
+static int sps30_do_meas(struct sps30_state *state, s32 *data, int size)
+{
+	guard(mutex)(&state->lock);
+	return __sps30_do_meas(state, data, size);
+}
+
 static int sps30_do_reset(struct sps30_state *state)
 {
 	int ret;
@@ -111,9 +118,7 @@ static irqreturn_t sps30_trigger_handler(int irq, void *p)
 		aligned_s64 ts;
 	} scan;
 
-	mutex_lock(&state->lock);
 	ret = sps30_do_meas(state, scan.data, ARRAY_SIZE(scan.data));
-	mutex_unlock(&state->lock);
 	if (ret)
 		goto err;
 
@@ -136,7 +141,6 @@ static int sps30_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_PROCESSED:
 		switch (chan->type) {
 		case IIO_MASSCONCENTRATION:
-			mutex_lock(&state->lock);
 			/* read up to the number of bytes actually needed */
 			switch (chan->channel2) {
 			case IIO_MOD_PM1:
@@ -152,7 +156,6 @@ static int sps30_read_raw(struct iio_dev *indio_dev,
 				ret = sps30_do_meas(state, data, 4);
 				break;
 			}
-			mutex_unlock(&state->lock);
 			if (ret)
 				return ret;
 
@@ -197,9 +200,9 @@ static ssize_t start_cleaning_store(struct device *dev,
 	if (kstrtoint(buf, 0, &val) || val != 1)
 		return -EINVAL;
 
-	mutex_lock(&state->lock);
+	guard(mutex)(&state->lock);
+
 	ret = state->ops->clean_fan(state);
-	mutex_unlock(&state->lock);
 	if (ret)
 		return ret;
 
@@ -215,9 +218,9 @@ static ssize_t cleaning_period_show(struct device *dev,
 	__be32 val;
 	int ret;
 
-	mutex_lock(&state->lock);
+	guard(mutex)(&state->lock);
+
 	ret = state->ops->read_cleaning_period(state, &val);
-	mutex_unlock(&state->lock);
 	if (ret)
 		return ret;
 
@@ -238,12 +241,11 @@ static ssize_t cleaning_period_store(struct device *dev, struct device_attribute
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
 
@@ -256,8 +258,6 @@ static ssize_t cleaning_period_store(struct device *dev, struct device_attribute
 		dev_warn(dev,
 			 "period changed but reads will return the old value\n");
 
-	mutex_unlock(&state->lock);
-
 	return len;
 }
 
-- 
2.54.0

