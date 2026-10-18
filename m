Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4542A3FA5F0
	for <linux-iio@vger.kernel.org>; Sun, 18 Oct 2026 17:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792342826; cv=none; b=FwZ3hNa6TkN8p6de1tcyHf5lzD7h7hg27T41ozodrvVIss4s/I+EL9LFsBsgOQY5bsLMwS2He6Prb/59BRMgUNjXp6276FmqKOBKj2SnwLlZp8PqpLZmBrJHF+Xo3ulmCRTQAMq18pJynSbVFw06Pi5Ol/kifRLMJDkky4IrWqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792342826; c=relaxed/simple;
	bh=ZjedDeld5RX6fASryBMqBtDu/GcSA57+Ex/jbaQmc/g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nIrs41a/k26h8MVztweoTrJLNyxaUzbKn9s6tASHy/GpituNL50ykXsW/hXEmdilWKtB3SSfTR72o0P/iCnLw6vrlp3gnQsaFUy+Ll1c5Uxbw6YUvm4NDiucDJyFsxhju8yLO/ItNrbJTc+1XjM8gt6aW7G/B6My4mWkvis6C74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kUPwox9Q; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUPwox9Q"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-35cd4e8bdbdso3454807eec.1
        for <linux-iio@vger.kernel.org>; Sun, 18 Oct 2026 10:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792342824; x=1792947624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6FM1MA66tNAmn5lRFJ2nA1E4CaxhhsRh1DU3FWW8nEE=;
        b=kUPwox9Qigi2DGd7nvcWQbnDZjyeAu57d1stVXXTHZ7VKqAAAJx8JtHfFASINkKKLB
         47/pPeOsLeblc3q9zhxc98RiwMb284IumbK8GnRhQW5TNE2gc4h5VmSpYNa/fTQeT2Uq
         L0LDDeKWVajxRpOQdN//xmT4mxCW/A+/IW5BWIVW+BKOt9opRM/GJiZYS/MCgCxTj+4W
         EAmNYzc9WLOQM9vJoCm//6K0BbsNtpwAI6YP46rnLOrIUbReP2MvDnmrD40x7KKt4/Tb
         ZzvyF68uy7T69wcHo/URf1ybmSPCrugoN2efOdEi/nsWn27JXuF2n5PaS8kkLAy7DyCz
         noGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792342824; x=1792947624;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6FM1MA66tNAmn5lRFJ2nA1E4CaxhhsRh1DU3FWW8nEE=;
        b=Xewwq8G+ViRzFSLZGbwnXH4l2SWXVFCqJ0K/DdkUL+RQTvFaX4uKPY4YexuWoHpi44
         g5m4NCFK7i2Q4d88TJkC1RBZMofbqto5KmlT/JpqB4/Bi64NT8f+kxdQjwJgf5Qh+Jjt
         +CioUU00BjekZ5NBgF4+c2TxtV0oQd6JDD+vE7tgXay4kDtUtNfu2WgBZYB/8sOdanvi
         4QTy9Crks5sqXeT9PqTglvxdK7MC3MElQjVHDeAtGAEjHypWwxCZNOke+2zsfdIvTBB8
         4Fu5hO0LZa6Q/oVGey1Pk6MG2GiY10CQUK+gohV8COKs12s9XO0ablvIAUL/PV6s2WKR
         QH2w==
X-Gm-Message-State: AFq9FYJiy2RxQw72Ust5D67j0z3MulJlBzrmxQKA7iJnsf6JRwS1xNJv
	PuqDw96a26fn1yOIKtsAn/xoBYxCDwyKdALXclOZF6mJwbdYVGDxfMDHpIg5gMTmog==
X-Gm-Gg: AYBFou2NchwHIwGH00jeQ4VRB2mRWgVQj+77TIdgxi/4gGPrO9rNh6tvKt6lQDzNTjz
	w8k6GB3pmWXSrcf68FePrv11vSAbhWuWJli5Awm7U6llFiUi/jgSQUl4fX5JNsmrbu7FRzd/KKH
	0MNLVBnwB87v/QxQ3FBFO7W9rt8qbdWp2h+DOIKwYIqwjXXrbveTiicYTFAqHerKWi5io+bvnYW
	PHWlq/8BrP50VLvzk4WsKkp+3+QlX0eh+AKQqf0hmd7W/IwpsIWpTHOwYUL2m3l6yV/msZf2gT0
	nhBwnyNpSaSsAdLmsg/HssEUHY11Mb2IytBCnFMlOJAwU82krQRApzp2TRpMrEpGYJxCXjlRmrW
	unaiaVVeK+dDv/AlIT1i0RDn7D5CCwDFGstmNp45sHvNdp8YT3PflVX1RBrz6UwGNXsRpJvzJVW
	hG/HfsLB2ksukUYSxgaam474S6QsUFcHpdA9IY4HbFllhaoSOyXBu5p8tFPKZqDwiQQKTt8c2SE
	apcOfyGbnAP5GVr+cQFRZVuOkgETzqwhLhnu0W0VHXkydXe
X-Received: by 2002:a05:7301:1888:b0:351:595f:a941 with SMTP id 5a478bee46e88-361a166778fmr6962607eec.8.1792342822362;
        Sun, 18 Oct 2026 10:00:22 -0700 (PDT)
Received: from localhost.localdomain ([101.0.63.175])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36083283478sm24222297eec.29.2026.10.18.10.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 10:00:21 -0700 (PDT)
From: Nikhil Gautam <nikhilgtr@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-kernel@vger.kernel.org,
	Nikhil Gautam <nikhilgtr@gmail.com>
Subject: [PATCH] iio: chemical: ccs811: Make sampling frequency configurable
Date: Sun, 18 Oct 2026 22:30:13 +0530
Message-Id: <20261018170013.79443-1-nikhilgtr@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow userspace to configure the CCS811 IAQ measurement rate through
the IIO sampling_frequency attribute.

Support the three IAQ measurement modes with sampling frequencies of
1 Hz, 0.1 Hz, and approximately 0.016667 Hz, corresponding to
measurement intervals of 1, 10, and 60 seconds.

Preserve unrelated bits in the MEAS_MODE register when updating the
drive mode, and cache the selected mode after a successful register
write. Expose the supported frequencies through
sampling_frequency_available.

Signed-off-by: Nikhil Gautam <nikhilgtr@gmail.com>
---
 drivers/iio/chemical/ccs811.c | 139 +++++++++++++++++++++++++++++++---
 1 file changed, 130 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/chemical/ccs811.c b/drivers/iio/chemical/ccs811.c
index d126ee12ffe5..4d157f3f5714 100644
--- a/drivers/iio/chemical/ccs811.c
+++ b/drivers/iio/chemical/ccs811.c
@@ -9,10 +9,9 @@
  * IIO driver for AMS CCS811 (I2C address 0x5A/0x5B set by ADDR Low/High)
  *
  * TODO:
- * 1. Make the drive mode selectable form userspace
- * 2. Add support for interrupts
- * 3. Adjust time to wait for data to be ready based on selected operation mode
- * 4. Read error register and put the information in logs
+ * 1. Add support for interrupts
+ * 2. Adjust time to wait for data to be ready based on selected operation mode
+ * 3. Read error register and put the information in logs
  */
 
 #include <linux/cleanup.h>
@@ -54,6 +53,7 @@
 #define CCS811_STATUS_FW_MODE_APPLICATION	BIT(7)
 
 /* Measurement modes */
+#define CCS811_MODE_MASK	GENMASK(6, 4)
 #define CCS811_MODE_IDLE	0x00
 #define CCS811_MODE_IAQ_1SEC	0x10
 #define CCS811_MODE_IAQ_10SEC	0x20
@@ -79,6 +79,7 @@ struct ccs811_data {
 	struct iio_trigger *drdy_trig;
 	struct gpio_desc *wakeup_gpio;
 	bool drdy_trig_on;
+	u8 drive_mode;
 	/* Ensures correct alignment of timestamp if present */
 	struct {
 		s16 channels[2];
@@ -86,6 +87,12 @@ struct ccs811_data {
 	} scan;
 };
 
+static const int ccs811_samp_freq[] = {
+	1, 0,
+	0, 100000,
+	0, 16667,
+};
+
 static const struct iio_chan_spec ccs811_channels[] = {
 	{
 		.type = IIO_CURRENT,
@@ -103,6 +110,8 @@ static const struct iio_chan_spec ccs811_channels[] = {
 		.modified = 1,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),
 		.scan_index = 0,
 		.scan_type = {
 			.sign = 'u',
@@ -163,16 +172,21 @@ static int ccs811_start_sensor_application(struct i2c_client *client)
 	return 0;
 }
 
-static int ccs811_setup(struct i2c_client *client)
+static int ccs811_setup(struct ccs811_data *data)
 {
 	int ret;
 
-	ret = ccs811_start_sensor_application(client);
+	ret = ccs811_start_sensor_application(data->client);
+	if (ret < 0)
+		return ret;
+
+	ret = i2c_smbus_write_byte_data(data->client, CCS811_MEAS_MODE,
+					CCS811_MODE_IAQ_1SEC);
 	if (ret < 0)
 		return ret;
 
-	return i2c_smbus_write_byte_data(client, CCS811_MEAS_MODE,
-					 CCS811_MODE_IAQ_1SEC);
+	data->drive_mode = CCS811_MODE_IAQ_1SEC;
+	return 0;
 }
 
 static void ccs811_set_wakeup(struct ccs811_data *data, bool enable)
@@ -188,6 +202,44 @@ static void ccs811_set_wakeup(struct ccs811_data *data, bool enable)
 		usleep_range(20, 30);
 }
 
+static int ccs811_set_sampling_freq(struct ccs811_data *data,
+				    int val, int val2)
+{
+	u8 drive_mode;
+	int ret;
+
+	if (val == 1 && val2 == 0)
+		drive_mode = CCS811_MODE_IAQ_1SEC;
+	else if (val == 0 && val2 == 100000)
+		drive_mode = CCS811_MODE_IAQ_10SEC;
+	else if (val == 0 && val2 == 16667)
+		drive_mode = CCS811_MODE_IAQ_60SEC;
+	else
+		return -EINVAL;
+
+	guard(mutex)(&data->lock);
+	ccs811_set_wakeup(data, true);
+
+	ret = i2c_smbus_read_byte_data(data->client, CCS811_MEAS_MODE);
+	if (ret < 0)
+		goto out;
+
+	ret &= ~CCS811_MODE_MASK;
+	ret |= drive_mode;
+
+	ret = i2c_smbus_write_byte_data(data->client,
+					CCS811_MEAS_MODE, ret);
+	if (ret < 0)
+		goto out;
+
+	data->drive_mode = drive_mode;
+	ret = 0;
+
+out:
+	ccs811_set_wakeup(data, false);
+	return ret;
+}
+
 static int ccs811_get_measurement(struct ccs811_data *data)
 {
 	int ret, tries = 11;
@@ -249,6 +301,28 @@ static int ccs811_read_info_raw(struct ccs811_data *data,
 	}
 }
 
+static int ccs811_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int val, int val2, long mask)
+{
+	struct ccs811_data *data = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+
+		ret = ccs811_set_sampling_freq(data, val, val2);
+
+		iio_device_release_direct(indio_dev);
+		return ret;
+
+	default:
+		return -EINVAL;
+	}
+}
+
 static int ccs811_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan,
 			   int *val, int *val2, long mask)
@@ -293,13 +367,60 @@ static int ccs811_read_raw(struct iio_dev *indio_dev,
 		default:
 			return -EINVAL;
 		}
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		guard(mutex)(&data->lock);
+		switch (data->drive_mode) {
+		case CCS811_MODE_IAQ_1SEC:
+			*val = 1;
+			*val2 = 0;
+			return IIO_VAL_INT_PLUS_MICRO;
+		case CCS811_MODE_IAQ_10SEC:
+			*val = 0;
+			*val2 = 100000;
+			return IIO_VAL_INT_PLUS_MICRO;
+		case CCS811_MODE_IAQ_60SEC:
+			*val = 0;
+			*val2 = 16667;
+			return IIO_VAL_INT_PLUS_MICRO;
+		default:
+			return -EINVAL;
+		}
+
 	default:
 		return -EINVAL;
 	}
 }
 
+static int ccs811_read_avail(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     const int **vals, int *type, int *length,
+			     long mask)
+{
+	if (mask != IIO_CHAN_INFO_SAMP_FREQ)
+		return -EINVAL;
+
+	*vals = ccs811_samp_freq;
+	*type = IIO_VAL_INT_PLUS_MICRO;
+	*length = ARRAY_SIZE(ccs811_samp_freq);
+
+	return IIO_AVAIL_LIST;
+}
+
+static int ccs811_write_raw_get_fmt(struct iio_dev *indio_dev,
+				    struct iio_chan_spec const *chan,
+				    long mask)
+{
+	if (mask == IIO_CHAN_INFO_SAMP_FREQ)
+		return IIO_VAL_INT_PLUS_MICRO;
+
+	return -EINVAL;
+}
+
 static const struct iio_info ccs811_info = {
 	.read_raw = ccs811_read_raw,
+	.write_raw = ccs811_write_raw,
+	.read_avail = ccs811_read_avail,
+	.write_raw_get_fmt = ccs811_write_raw_get_fmt,
 };
 
 static int ccs811_set_trigger_state(struct iio_trigger *trig,
@@ -460,7 +581,7 @@ static int ccs811_probe(struct i2c_client *client)
 		return -ENODEV;
 	}
 
-	ret = ccs811_setup(client);
+	ret = ccs811_setup(data);
 	if (ret < 0) {
 		ccs811_set_wakeup(data, false);
 		return ret;
-- 
2.39.5

