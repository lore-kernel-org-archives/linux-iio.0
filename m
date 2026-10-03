Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34CC221F39
	for <linux-iio@vger.kernel.org>; Sat,  3 Oct 2026 00:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790986861; cv=none; b=ktnwd9ooezOkv0YZNNOLvOQu3l5TjUgJYctCQ3Z7vFqkqZ/qF6DDRxFXKMFGH4wUkFxkV+1ctHVkL+l2v2oY0/BxrY55eCT83flMvMrAUFCRj7TxV8Qls/MQ6s89heue3FRwtTwASmSwlN0H4f159p75ywdOauHW4ilG12O93jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790986861; c=relaxed/simple;
	bh=mI2RgxDq8URYeJCIbXzCTwlkOLdbmQifZh73SfGqMn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g7gPUUgv2+UamOLMknm+bhfgXDn3ogA10a2Ry6BZJg+dm8gxdC6W44TvssC3ZnQYuSQZzeuc4auVs/WBb2WnJKedkUiltBSfghhNWeLKjGLkcEIWwXLcIyyIOAsABD127YJmGgWMjXs8IEHfpGj/tb14iR0cwmnJoREbbBcPBOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WI6IXkOF; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WI6IXkOF"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49ffbd83a92so3077385e9.0
        for <linux-iio@vger.kernel.org>; Fri, 02 Oct 2026 17:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790986858; x=1791591658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k3HnVca/e+fx9kJGyHM2Gbh+uKVtad0BFTOrk0gsBOU=;
        b=WI6IXkOFAcS46ALVysRjuq+UPRwUPqtsNn2CQ671w1YnVAOQqOf1P3ZmUmfFIxZvL+
         uSC5kuAWkEoyB/jdAcqhYeBTxWUWkq8Goz1mekqN+HM0dRibHMRa/leMFm8fuaw/5iLY
         pWGEa2nTj5hnZDuUEjhGnmjzPxRWOdQEU/f6ChmYqP/72tU9f/C1kvBSDopYMk3dD7ZM
         9s7RP9OljFN0BLSyShqSRFLIpjA11UPveictDHU4Z1bEL5s/4BfeYk2OGAzBWVkUUAx3
         /f/tb4Xw8pg+W2IY0fqRhrs3Ubz6dMPwJaxdWxry3ky22pNPqal8yL4kD0zwGUGi5ozW
         TwHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790986858; x=1791591658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=k3HnVca/e+fx9kJGyHM2Gbh+uKVtad0BFTOrk0gsBOU=;
        b=X/eVuMBzFjRGG/UwgqiMx4JqbQRyltlhRBGUDvmrnTRExeqXaZtc2RaX68mQ0xWAee
         VkIyauoKH+I32NrJcskOhxSsdRx1/T7z3rswZR3LGuH/XYqGfyu6J5P+7hwJg8R8GXYx
         Lj+x86cTdgxy8qZvg+3swMNAeH7yJLeYhxz3s8sbt8uW0OT8v0Yo6SdSWi9v2HyAoYBV
         2+PSoXL9SQiNvBsXAHsqORMCdkSt+9BWxp3wdVGhg0lR40OEsRyQeBcdYuTbMRneqb5e
         RKzF0MhudXVZOIWD7PTO9lOWqhBV0oEkZFOtu1K9FS5FNc5dEm/qJ1X+bAAIsddZVvxQ
         V0wg==
X-Gm-Message-State: AFuF++lpwhpcBEpnb4UHTMypWZ+sU7zqnVlPzsF23iYYvyYq+7/4xKou
	I3RDjItFxADriqLesW90qfm8H2eg0lfAqnW9j7pisrxWSffJaEc9ZiFBpAjQ1SzU
X-Gm-Gg: AYBFou0m60CKbwFg6wxCleweUZytTlml1tdTzJB+N6HKksb8Lb2KjRnQ6jwRt8C2uKl
	FvMjbE3ghsuU1GG91OdGMpq4hzuAjyKPePXqM9rB2gGuvqFSaWRuFSK9S0ML6rf4z77OtcrMuaQ
	132xf9pgYwYQu+l3vDFNQvP/UF5XSYwV4Q9alPJO7axnJmNJdelKMBS89HdfbIrtagwRQkL3J+S
	Jw43vw1hSaGa7Yuu1P/W+xDV8EBBrtSK0vmmd/LgUsBrlSFbpaCBHvVmcCa8rSQ/9BoMFdiraq7
	o8HtF3NCiTzUKUplVhA051oHmBGOZPjCY0XdHW2BiUjyEccgrc5ofI9jOYDe2JHHnAIi12fhFbG
	9ZxOMqCni8TEGlZnl3Yq6tD7sC+9Zm4PV1W69PjpvmXoWR7SiguJ/AkMvkG42/V0XtNoDqJ/jUT
	ug2d18VzIWFDIdc5lbBHEO7uWfwRaql8jGeehl9MHLIIR7pzqM76jHaWI9FY8eidTgtTBet+wM7
	iHO7THzsF5lBvVqNMSdDtTC0JHCkbtLfo3ZB4Yj7j9qFZMOb32FSwZMXMA08qkFNiQPDTBlCF2A
	rhQs+1U=
X-Received: by 2002:a05:600d:864b:20b0:49f:fbad:29be with SMTP id 5b1f17b1804b1-4a0276afda9mr51598135e9.34.1790986857932;
        Fri, 02 Oct 2026 17:20:57 -0700 (PDT)
Received: from SegFaultinator.localdomain ([37.142.148.246])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a02752aeb3sm124836705e9.0.2026.10.02.17.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 17:20:56 -0700 (PDT)
From: Yuval Saar <thefireking@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	maxwell@maxwelld.cc,
	Yuval Saar <thefireking@gmail.com>
Subject: [PATCH v3 2/2] iio: adc: mcp3422: use read_avail() for available attributes
Date: Sat,  3 Oct 2026 03:16:47 +0300
Message-ID: <20261003001647.1975549-3-thefireking@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261003001647.1975549-1-thefireking@gmail.com>
References: <20260919195507.94130-1-thefireking@gmail.com>
 <20261003001647.1975549-1-thefireking@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Custom sysfs show functions only expose the sampling frequency and
scale lists to userspace. Use read_avail() so the IIO core creates
those attributes and in-kernel consumers can query the lists.

sampling_frequency_available is device-wide, so mark it shared by all.
The scale list is shared by type, which keeps the existing
in_voltage_scale_available attribute name.

Store each scale as an { integer, nano } pair and cast the table for
read_avail().

Compile tested. checkpatch --strict clean. Available-list text checked
against IIO core formatters. No hardware.

Assisted-by: LLM
Signed-off-by: Yuval Saar <thefireking@gmail.com>
---
 drivers/iio/adc/mcp3422.c | 90 +++++++++++++++++++--------------------
 1 file changed, 45 insertions(+), 45 deletions(-)

diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
index 92825aaf2..39599dfbc 100644
--- a/drivers/iio/adc/mcp3422.c
+++ b/drivers/iio/adc/mcp3422.c
@@ -19,11 +19,9 @@
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/delay.h>
-#include <linux/sysfs.h>
 #include <linux/unaligned.h>
 
 #include <linux/iio/iio.h>
-#include <linux/iio/sysfs.h>
 
 #define MCP3422_CHANNEL_MASK	GENMASK(6, 5)
 #define MCP3422_SRATE_MASK	GENMASK(3, 2)
@@ -47,13 +45,27 @@
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) \
 				| BIT(IIO_CHAN_INFO_SCALE), \
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
+		.info_mask_shared_by_type_available = \
+				BIT(IIO_CHAN_INFO_SCALE), \
+		.info_mask_shared_by_all_available = \
+				BIT(IIO_CHAN_INFO_SAMP_FREQ), \
 	}
 
-static const int mcp3422_scales[4][4] = {
-	{ 1000000, 500000, 250000, 125000 },
-	{ 250000,  125000, 62500,  31250  },
-	{ 62500,   31250,  15625,  7812   },
-	{ 15625,   7812,   3906,   1953   } };
+/* { integer, nano } per PGA gain, for the current sample rate. */
+static const int mcp3422_scales[][4][2] = {
+	[MCP3422_SRATE_240] = {
+		{ 0, 1000000 }, { 0, 500000 }, { 0, 250000 }, { 0, 125000 },
+	},
+	[MCP3422_SRATE_60] = {
+		{ 0, 250000 }, { 0, 125000 }, { 0, 62500 }, { 0, 31250 },
+	},
+	[MCP3422_SRATE_15] = {
+		{ 0, 62500 }, { 0, 31250 }, { 0, 15625 }, { 0, 7812 },
+	},
+	[MCP3422_SRATE_3] = {
+		{ 0, 15625 }, { 0, 7812 }, { 0, 3906 }, { 0, 1953 },
+	},
+};
 
 /* Constant msleep times for data acquisitions */
 static const int mcp3422_read_times[4] = {
@@ -174,8 +186,8 @@ static int mcp3422_read_raw(struct iio_dev *iio,
 
 	case IIO_CHAN_INFO_SCALE:
 
-		*val1 = 0;
-		*val2 = mcp3422_scales[sample_rate][pga];
+		*val1 = mcp3422_scales[sample_rate][pga][0];
+		*val2 = mcp3422_scales[sample_rate][pga][1];
 		return IIO_VAL_INT_PLUS_NANO;
 
 	case IIO_CHAN_INFO_SAMP_FREQ:
@@ -206,7 +218,8 @@ static int mcp3422_write_raw(struct iio_dev *iio,
 			return -EINVAL;
 
 		for (i = 0; i < ARRAY_SIZE(mcp3422_scales[0]); i++) {
-			if (val2 == mcp3422_scales[sample_rate][i]) {
+			if (val1 == mcp3422_scales[sample_rate][i][0] &&
+			    val2 == mcp3422_scales[sample_rate][i][1]) {
 				adc->pga[req_channel] = i;
 
 				FIELD_MODIFY(MCP3422_CHANNEL_MASK, &config, req_channel);
@@ -262,45 +275,32 @@ static int mcp3422_write_raw_get_fmt(struct iio_dev *indio_dev,
 	}
 }
 
-static ssize_t mcp3422_show_samp_freqs(struct device *dev,
-		struct device_attribute *attr, char *buf)
+static int mcp3422_read_avail(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      const int **vals, int *type, int *length,
+			      long mask)
 {
-	struct mcp3422 *adc = iio_priv(dev_to_iio_dev(dev));
-
-	if (!adc->chip_info->supports_3sps)
-		return sprintf(buf, "240 60 15\n");
-
-	return sprintf(buf, "240 60 15 3\n");
-}
-
-static ssize_t mcp3422_show_scales(struct device *dev,
-		struct device_attribute *attr, char *buf)
-{
-	struct mcp3422 *adc = iio_priv(dev_to_iio_dev(dev));
+	struct mcp3422 *adc = iio_priv(indio_dev);
 	u8 sample_rate = FIELD_GET(MCP3422_SRATE_MASK, adc->config);
 
-	return sprintf(buf, "0.%09u 0.%09u 0.%09u 0.%09u\n",
-		mcp3422_scales[sample_rate][0],
-		mcp3422_scales[sample_rate][1],
-		mcp3422_scales[sample_rate][2],
-		mcp3422_scales[sample_rate][3]);
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		*vals = (const int *)mcp3422_scales[sample_rate];
+		*type = IIO_VAL_INT_PLUS_NANO;
+		*length = ARRAY_SIZE(mcp3422_scales[0]) * 2;
+		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*vals = mcp3422_sample_rates;
+		*type = IIO_VAL_INT;
+		*length = ARRAY_SIZE(mcp3422_sample_rates);
+		if (!adc->chip_info->supports_3sps)
+			*length -= 1;
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
 }
 
-static IIO_DEVICE_ATTR(sampling_frequency_available, S_IRUGO,
-		mcp3422_show_samp_freqs, NULL, 0);
-static IIO_DEVICE_ATTR(in_voltage_scale_available, S_IRUGO,
-		mcp3422_show_scales, NULL, 0);
-
-static struct attribute *mcp3422_attributes[] = {
-	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
-	&iio_dev_attr_in_voltage_scale_available.dev_attr.attr,
-	NULL,
-};
-
-static const struct attribute_group mcp3422_attribute_group = {
-	.attrs = mcp3422_attributes,
-};
-
 static const struct iio_chan_spec mcp3421_channels[] = {
 	MCP3422_CHAN(0),
 };
@@ -367,9 +367,9 @@ static const struct mcp3422_chip_info mcp3428_chip_info = {
 
 static const struct iio_info mcp3422_info = {
 	.read_raw = mcp3422_read_raw,
+	.read_avail = mcp3422_read_avail,
 	.write_raw = mcp3422_write_raw,
 	.write_raw_get_fmt = mcp3422_write_raw_get_fmt,
-	.attrs = &mcp3422_attribute_group,
 };
 
 static int mcp3422_probe(struct i2c_client *client)
-- 
2.43.0

