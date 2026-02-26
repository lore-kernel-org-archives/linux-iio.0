Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0A43ED134
	for <linux-iio@vger.kernel.org>; Thu, 26 Feb 2026 15:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772118690; cv=none; b=m82BHg2UQwn4N3vZcZiBbkY2yQoKiCIMS9F+lEzDXTE8iKSiVdrGwlBEk63TfY32snzUiLfU4Ibao8Fxx3hkisb8R6adKotbWScjPW5+haDcTBnK3luFrulOpVwA3B4VoprA47uQaAPDTLnx2dzvF7lbXVTTXOieQoG1MCj/nmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772118690; c=relaxed/simple;
	bh=JejjvVpPYrXeaRVSJxsfFS1CBfXAi1ii04aOuLTHn7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zfhh+RvvHI4JsRKBszVPS4IrhgNI5ECfn6Qwvn3qMQIN2niDNISWC2QsS7eistz6dsV1L3cGK2y+kSNvA54G8tAY57Oyx7RF91tffu/ajpR1VrHv8nOkYVky3nLqqYz82BPTjo8qimWFcK8Zfg/6CEIWNiLQsC17QRMEdrMOOd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c7kT3dXT; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7kT3dXT"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-899c97c5afeso4902206d6.1
        for <linux-iio@vger.kernel.org>; Thu, 26 Feb 2026 07:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772118686; x=1772723486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9TivuMjzjzE/SeADDnaO1za2lwOiaGnN4Z4jjyarfjs=;
        b=c7kT3dXTSpZrwTLFHa9ikNfYoaEom+ULvXS9iRmzds33EN2PSOP71F5eRx4X8tRlC5
         RieVLLjrUX6xrMMyOe0e6YqjTClx63UWkzPCSpLOhHVVDwgHOMrJrUQDoYD781gFEo0v
         4XzOfnFfeW62CeN3l6aGNlevmQXklBJ+MRTtZM/GAykAHFGVLbQMBM4FIrkWGI80a+ST
         HKB1Bd2LHnP/JzmhahXmOul6cbBHm3K88I5E9cpjEeTCm6bmdB7u6uRRyz7IhI33TNkc
         BKk5DtF0HioCt7oKNWO5cGwvwjwCL3eS1Pj1ZFfSZwU/+WW7rDCSA9V/7+7nD0vzEMIx
         2I7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772118686; x=1772723486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9TivuMjzjzE/SeADDnaO1za2lwOiaGnN4Z4jjyarfjs=;
        b=XuiJo+V947ODlKYGxndUevE5zW8T+XzE7lFNEFDPV/MpfvXHNOLpjTZUr49Vr7Bvbx
         KEy6E3YJ7RbOE2I9GIn3UX4DMTRs9Cd5yK31wh6NSXKedQzag+fnwMnyZNxgTxji3qyF
         2rP2SWouguhbNO2llI4BvBluyQgVmtlqgPwGPsYAoHcC+ctMdQFbAkEVKNavgc4UPnUl
         +k7d+1LDo5dKQyiILJ7uLQDR/ZOIi27TFQPbH8FoXFlW7htsdcWuZul9lxlYLnhT3kai
         XZRYimiB2xVxA9dN1njDInOIoTSleQ2As2aqsyWtBiUSmgEcbQpgdU4iqzZIJo303znt
         GZaA==
X-Gm-Message-State: AOJu0YyAMwtwTTzz/wiEzwpClklcme6as+xVkCsLWYFtVgQ8PILB6KdL
	rgj5FUC7X/Q3HxA6FfDEGScaB/BBJpi3e0cwgTz3/GU450u8LfIVaqPVR1bkf6v8
X-Gm-Gg: ATEYQzxxTnqjUut4u6CIo3alUa78L2CMn56B4zulaCd/2h+OChg9JTtzluzn21TWOCx
	pIJxmWBbwM5YHyF7lwM18ENtSqwZ1YKSvVF2B4jKYCrw0yY0nDtl800cpKQn7AxvA9JN5pAWKt6
	lXsm8uTBvc0aXNBSs1YjPIZqslsVveaVJYPwhE2+N0gwScjgNBeM4bePHIQZoHniMZEkhnIBNpc
	xg0H9gokdvmrIkXJ3C6wz1P6J5InMjWjUVNNAR5PIOjLDfwT5BW0H8WF06cWu22Eu+LaR/dYKUe
	Deq38c8Lan0NKJUD5D05rWprgDHHS0Yy1vQBadHmyEjEUMS1fA6DbkdauSlIpa7CJBHXGBreV3P
	FsMcTvy3/Rz+RZq7FfEydCMu+4Caez66kbXTRmyLq5AKSkCPAGd4AS7/kJaN6PbZNIxs51tau0d
	JrY5QUsXOgVlHimHmxK+5lP8GkJ6nvYlcPCLWvTdm4blJp030wQZgsQawXi6qPyg==
X-Received: by 2002:ad4:5d46:0:b0:899:bbba:b397 with SMTP id 6a1803df08f44-899c7fcd414mr34907026d6.30.1772118686218;
        Thu, 26 Feb 2026 07:11:26 -0800 (PST)
Received: from db07.1337.ma ([197.230.240.146])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c738e661sm19275136d6.43.2026.02.26.07.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 07:11:25 -0800 (PST)
From: Taha Ed-Dafili <0rayn.dev@gmail.com>
To: linux-iio@vger.kernel.org,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	rdunlap@infradead.org,
	skhan@linuxfoundation.org,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Taha Ed-Dafili <0rayn.dev@gmail.com>
Subject: [PATCH v6 4/5] iio: accel: adxl345: Implement event scaling for ABI compliance
Date: Thu, 26 Feb 2026 15:11:05 +0000
Message-ID: <20260226151108.22383-5-0rayn.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260226151108.22383-1-0rayn.dev@gmail.com>
References: <20260226151108.22383-1-0rayn.dev@gmail.com>
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
 drivers/iio/accel/adxl345_core.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 96d1417d77c6..6c9080d88c60 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -213,6 +213,7 @@ static const struct iio_event_spec adxl345_events[] = {
 		.dir = IIO_EV_DIR_RISING,
 		.mask_shared_by_type =
 			BIT(IIO_EV_INFO_ENABLE) |
+			BIT(IIO_EV_INFO_SCALE) |
 			BIT(IIO_EV_INFO_VALUE),
 	},
 	{
@@ -221,6 +222,7 @@ static const struct iio_event_spec adxl345_events[] = {
 		.dir = IIO_EV_DIR_RISING,
 		.mask_shared_by_type =
 			BIT(IIO_EV_INFO_ENABLE) |
+			BIT(IIO_EV_INFO_SCALE) |
 			BIT(IIO_EV_INFO_VALUE),
 	},
 	{
@@ -228,7 +230,9 @@ static const struct iio_event_spec adxl345_events[] = {
 		.type = IIO_EV_TYPE_GESTURE,
 		.dir = IIO_EV_DIR_SINGLETAP,
 		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
-		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
+		.mask_shared_by_type =
+			BIT(IIO_EV_INFO_SCALE) |
+			BIT(IIO_EV_INFO_VALUE) |
 			BIT(IIO_EV_INFO_TIMEOUT),
 	},
 	{
@@ -237,6 +241,7 @@ static const struct iio_event_spec adxl345_events[] = {
 		.dir = IIO_EV_DIR_DOUBLETAP,
 		.mask_shared_by_type =
 			BIT(IIO_EV_INFO_ENABLE) |
+			BIT(IIO_EV_INFO_SCALE) |
 			BIT(IIO_EV_INFO_VALUE) |
 			BIT(IIO_EV_INFO_RESET_TIMEOUT) |
 			BIT(IIO_EV_INFO_TAP2_MIN_DELAY),
@@ -276,6 +281,7 @@ static const struct iio_event_spec adxl345_fake_chan_events[] = {
 		.dir = IIO_EV_DIR_FALLING,
 		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
 		.mask_shared_by_type =
+			BIT(IIO_EV_INFO_SCALE) |
 			BIT(IIO_EV_INFO_VALUE) |
 			BIT(IIO_EV_INFO_PERIOD),
 	},
@@ -285,6 +291,7 @@ static const struct iio_event_spec adxl345_fake_chan_events[] = {
 		.dir = IIO_EV_DIR_FALLING,
 		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
 		.mask_shared_by_type =
+			BIT(IIO_EV_INFO_SCALE) |
 			BIT(IIO_EV_INFO_VALUE) |
 			BIT(IIO_EV_INFO_PERIOD),
 	},
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

