Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E3439E6F2
	for <linux-iio@vger.kernel.org>; Tue, 24 Feb 2026 14:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771941855; cv=none; b=RFdLnJ/BQVZD1nCO+2sQY2bsz22UB0cnk0l4SJftLd+EGJK3CLFig9wyYesD0lAtr9VwKWPwHqC2zGA23DNG8AhfLCtsygTC3wNB0/xJ9hgXfaHeSI0fxH9B6x+4utmEJwwlY67EWz4TkmcsqUq9Tcw+hi5w9SSPxlWOVy/Ozt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771941855; c=relaxed/simple;
	bh=au0e4ypE6x/0jDdOhryMt7CY81fCNnbWNQRijiJCi8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qmZbupWLZoJXeVhhtutQmrU34dXLxWLPX+dN0C+WaX1yPkGwJo73DSj8XSwnvA1GcqUijkU77CV7T5fQSGX59lWGvLWuZ/SiP7e8TNl0yxWnYciiy7NMqorGOhdu73xidvnzJglGrXiGXf8g9ZELdKlLpEDgaoAeWtEeObwcW4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RAYqyike; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RAYqyike"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-483a233819aso54148615e9.3
        for <linux-iio@vger.kernel.org>; Tue, 24 Feb 2026 06:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771941848; x=1772546648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ecdWDoUpwMTmcnEbrWr6+7wrPFW+milCk6Hirg8t6A=;
        b=RAYqyikeoeHLs9HnL3NsRYx4WoH62zSUshSllM1ASby/aWFWCSkDmEBrTXNGEKDCKy
         fMfsAP4uvy53IMeDSu2YqTFMBQ0Ubr8mH6YlQ+Ece9E2Sj27bWnJ6BoClqdyqe6VhICE
         fvtnFtLlBy+d0SOauubwQdTt7PMYj9Tnw6U3myphBRuQypjiADbAh8bKpiXilEAKLU40
         wlf7oaAEeoausjMVvoYImJFHi0GTN7hcyYSdMrZ5uzzam90ukEh/5cbkoDZY/rDWnH1p
         kz0Zrf9oilRNcSd7etbJyXOxMJ4G6tlI+u1zr6N5DCH9CSDWC4P1chF9H1PIVTufy3x7
         E7tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771941848; x=1772546648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5ecdWDoUpwMTmcnEbrWr6+7wrPFW+milCk6Hirg8t6A=;
        b=fL4bnWlzdLbrbJSh4A56xkiuOMpTnBfFh5FH99B5ptlAzdQXrNfjaeabjcezfZ6NId
         kMlSXUlqyV3gvWem59//e5ohe87lfJEQtwejnszmrqn1veACiqgrbWe0gU49byb8Ao19
         KZSmpxTKWHpG9CMqMJ+XbgpH4/z92z31f+Rw6hxRFxf5c106nTsGuwy7hOAHQbSNyfkR
         taDKdo7+iQgu0Ur/24aua8CEXcqwRfpgtqhOiNhgnrGgdaULQTQzSbWnJB/6dXNB/R9V
         hIZIkxmoS8WK6Mjb7A6mbjNKDkIaBfXZC8+cBt8MELW+yN+O6YzVLcZhavJ/8l0PK8KR
         wlGQ==
X-Gm-Message-State: AOJu0YyvTp5lEho7E8LOYoFjsx758ETiJbZ4cu7MaV+czdGkN8WtffwU
	0agg658f5+hREPan3D50RedMfk474AQojtzWMySkQwB0QPeHpecTbqaf6/vKh7vT
X-Gm-Gg: AZuq6aILNye7cYm8PAQSN0MagX7MtoniERACfHsSv8SYWJFTH/diVdYg1MmkQoX6Udw
	Efz/fidXlhyJVTwLZ0jGbLJvu+n+E2GcVxQTsBo0n8BED6rSDRu7TFBgsPvgBsJVTCFl4OeH446
	FvxO+BC/so4bmEmMZSLDdFUwvIO3iLxcU6Yha7wFkWo9ggROPKOX5dSByoMUSvauArHu7WapBZq
	Vvt88/dfz0GdPMQrOIu8/y21UAI2Fkb3iT7hFa1YsQLco7jML4YMBFi9YiThZWGmZ5aXHf21vej
	klG/11HVzMYOQfuuqdkBXOKvj+vNj2O/GV4CuXmNVjWI7xHikwDEjCdJlD5NSWH+3rQ9IplknCr
	PUihRgFh4pkCK0LpvEPL5YhomDwMTlnXDAZ5gJkjRCOfAKzyxwYCWuLSs6mIitzA+wxOyICqdji
	Ks+M/nTlzD3NRhLqi5vzrSspGDk8jCOBq1zzwAWJBgUVHQkgjcqwh1d1Ubks6Lgg==
X-Received: by 2002:a05:600c:1e1d:b0:480:f27c:6335 with SMTP id 5b1f17b1804b1-483a9637a55mr221457985e9.25.1771941847732;
        Tue, 24 Feb 2026 06:04:07 -0800 (PST)
Received: from db07.1337.ma ([197.230.240.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd7010a0sm1043505e9.5.2026.02.24.06.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 06:04:07 -0800 (PST)
From: Taha Ed-Dafili <0rayn.dev@gmail.com>
To: linux-iio@vger.kernel.org,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	rdunlap@infradead.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees-archive@lists.linuxfoundation.org,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Taha Ed-Dafili <0rayn.dev@gmail.com>
Subject: [PATCH v5 4/5] iio: accel: adxl345: Implement event scaling for ABI compliance
Date: Tue, 24 Feb 2026 14:03:47 +0000
Message-ID: <20260224140351.27288-5-0rayn.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260224140351.27288-1-0rayn.dev@gmail.com>
References: <20260224140351.27288-1-0rayn.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ADXL345 uses a fixed threshold resolution of 62.5 mg/LSB for
event-related registers. Previously, the driver reported raw
values without a scale factor.

Implement IIO_EV_INFO_SCALE for all event types to provide the
conversion factor (0.612915 m/s^2) as required by the IIO ABI.

Consequently, remove the obsolete comment in adxl345_read_event_value()
which stated that the scale factor is not applied.

Add explicit write rejection for IIO_EV_INFO_SCALE in
adxl345_write_event_value() returning -EINVAL.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Taha Ed-Dafili <0rayn.dev@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 1ac99263ad8e..722b5018757e 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -213,7 +213,8 @@ static const struct iio_event_spec adxl345_events[] = {
 		.dir = IIO_EV_DIR_RISING,
 		.mask_shared_by_type =
 			BIT(IIO_EV_INFO_ENABLE) |
-			BIT(IIO_EV_INFO_VALUE),
+			BIT(IIO_EV_INFO_VALUE)	|
+			BIT(IIO_EV_INFO_SCALE),
 	},
 	{
 		/* activity, ac bit set */
@@ -221,14 +222,17 @@ static const struct iio_event_spec adxl345_events[] = {
 		.dir = IIO_EV_DIR_RISING,
 		.mask_shared_by_type =
 			BIT(IIO_EV_INFO_ENABLE) |
-			BIT(IIO_EV_INFO_VALUE),
+			BIT(IIO_EV_INFO_VALUE)	|
+			BIT(IIO_EV_INFO_SCALE),
 	},
 	{
 		/* single tap */
 		.type = IIO_EV_TYPE_GESTURE,
 		.dir = IIO_EV_DIR_SINGLETAP,
 		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
-		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
+		.mask_shared_by_type =
+			BIT(IIO_EV_INFO_VALUE)	|
+			BIT(IIO_EV_INFO_SCALE)	|
 			BIT(IIO_EV_INFO_TIMEOUT),
 	},
 	{
@@ -238,6 +242,7 @@ static const struct iio_event_spec adxl345_events[] = {
 		.mask_shared_by_type =
 			BIT(IIO_EV_INFO_ENABLE)		|
 			BIT(IIO_EV_INFO_VALUE)		|
+			BIT(IIO_EV_INFO_SCALE)		|
 			BIT(IIO_EV_INFO_RESET_TIMEOUT)	|
 			BIT(IIO_EV_INFO_TAP2_MIN_DELAY),
 	},
@@ -277,6 +282,7 @@ static const struct iio_event_spec adxl345_fake_chan_events[] = {
 		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
 		.mask_shared_by_type =
 			BIT(IIO_EV_INFO_VALUE) |
+			BIT(IIO_EV_INFO_SCALE) |
 			BIT(IIO_EV_INFO_PERIOD),
 	},
 	{
@@ -286,6 +292,7 @@ static const struct iio_event_spec adxl345_fake_chan_events[] = {
 		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
 		.mask_shared_by_type =
 			BIT(IIO_EV_INFO_VALUE) |
+			BIT(IIO_EV_INFO_SCALE) |
 			BIT(IIO_EV_INFO_PERIOD),
 	},
 };
@@ -1343,6 +1350,16 @@ static int adxl345_read_event_value(struct iio_dev *indio_dev,
 	unsigned int tap_threshold;
 	int ret;
 
+	/*
+	 * The event threshold LSB is fixed at 62.5 mg/LSB
+	 * 0.0625 * 9.80665 = 0.612915625 m/s^2
+	 */
+	if (info == IIO_EV_INFO_SCALE) {
+		*val = 0;
+		*val2 = 612915;
+		return IIO_VAL_INT_PLUS_MICRO;
+	}
+
 	switch (type) {
 	case IIO_EV_TYPE_MAG:
 		return adxl345_read_mag_value(st, dir, info,
@@ -1357,12 +1374,6 @@ static int adxl345_read_event_value(struct iio_dev *indio_dev,
 	case IIO_EV_TYPE_GESTURE:
 		switch (info) {
 		case IIO_EV_INFO_VALUE:
-			/*
-			 * The scale factor would be 62.5mg/LSB (i.e. 0xFF = 16g) but
-			 * not applied here. In context of this general purpose sensor,
-			 * what imports is rather signal intensity than the absolute
-			 * measured g value.
-			 */
 			ret = regmap_read(st->regmap, ADXL345_REG_THRESH_TAP,
 					  &tap_threshold);
 			if (ret)
@@ -1403,6 +1414,9 @@ static int adxl345_write_event_value(struct iio_dev *indio_dev,
 	if (ret)
 		return ret;
 
+	if (info == IIO_EV_INFO_SCALE)
+		return -EINVAL;
+
 	switch (type) {
 	case IIO_EV_TYPE_MAG:
 		ret = adxl345_write_mag_value(st, dir, info,
-- 
2.47.3

