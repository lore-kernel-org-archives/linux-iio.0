Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792949760;
	b=p5pDjSoab6qozViPClm/V59yU06rG/V2L1PyX1rgl7YRVOV9WhakXo8tIeHso6wS1TG2
	 TESWZvYL3Im652F1Sxg2/q1eEU3WkjcU/idCzK/xqYKClEY+HZ1ze/apHLOvscs8zNcMi
	 9o27YrVNvvhXhImjSK8LaLRxKxkrGsZi41153b32HbQGFdbrblDBFKuRFeyGLwxDs3pCR
	 vRbTLJg2KXN9+//qXvqYDST4gaCRraIcwOuLqgNXrD+2FP5NJQeobpGLAsTabp/MMyPjk
	 jaaA8WaDAZckORtzFivgCofpM51qZvQbmp6WYAVnVji0AG98946IRSDkUB0AP6u9DcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792949760;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=tKLQKvsimDDDuLYKKuKDJqLjquQrqqUC14jGSjgst9s=;
	b=tZulNal1VBi3R/B0Bm0XQNMsQC1c97w3lDPcLPqvScAWKVMjQoc7RYDbPBR1FiCJqywA
	 AR6fv9qs57vYy571o7AwHKoBNj51UD3tkdFYjsEXESnMBE3zucezejMyIjpVTlpnbfG9S
	 PJKW/sOueLibAtzRIIVibWjo21nrq1ry3ZPkRTpiRk7TpDFXlrYxaviuZ1LSxIV1cwP+Q
	 A3LhQ3zOhRRyWqnnhjwBoQTwVc4KEFl6phNJ2r/uETdTarMyUpWiMRzpRXnMKYibG9HJg
	 e8ZoSxuHOD4RibVlS6zGxJuCrPzSeGoE0V1d6XDKXEFKVZrG8UajHCdzSFPOB+xa9wA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rZqacP1h;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09428606A31B
	for <linux-iio@vger.kernel.org>; Sun, 25 Oct 2026 17:35:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09428606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rZqacP1h
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-35d0be18c71so3975078eec.1
        for <linux-iio@vger.kernel.org>; Sun, 25 Oct 2026 10:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792949759; x=1793554559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tKLQKvsimDDDuLYKKuKDJqLjquQrqqUC14jGSjgst9s=;
        b=rZqacP1h3pRLDurrpI2QEWtdqyQ9Sy1Au9XDAMC8IGsZOKtScAonRChhMdkqKYfbk/
         oGlfp3NCJ3xR/dST7swJU7jKTzxViD1DZErxHDZISSmROxqPJEIhuklQsAA0OH8jfcAF
         SjJACs8jn1zxbI+sRlQQEnMuJcLwRzYy7Wbb85CIT/RnJaM0qMV1j6535RTyMZAvxC5O
         8zIDqe3cUylBddaFY0VZQXmxphwT5DQnNuBsf+dcPvFuzU6xGJ6DaWNrG4HZYCGC0teY
         OkLHOGsrYQIImpMFymZ3H5CFleVc6FLa36NhIEOT8mzfuAZ1XwEsJO+LXXfy3Gf1y8MS
         5nxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792949759; x=1793554559;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tKLQKvsimDDDuLYKKuKDJqLjquQrqqUC14jGSjgst9s=;
        b=1bBzpQFJr/f7NGE2wg1EiRSGbuOtvHf4WFcc0T/oJBg8Vp5kbUb/Ff8MI5VCNkelEq
         NRpdJ8dAsVXs7CJH+bkO13qt2I+jYGpLNypuXOitDEiZJRGRPRjW+txU94uEZd9mtOYE
         if3Uro7eAqDYOareDPCwo2fW8oZ9BGIuXZ3BAonxn730KslKIVnJJm6Pe/rbMJVl+wUJ
         quvk2+Y3qbd+9eVRFLNJp7cejwXj/w/6RC1hbr86zOS2dl0pEMXXckVGvwmMCCVXtEux
         swNoDn0FKF7qnzS7NveFjaRuvE1hQizSJ3rAeT3zIxk3dsyJaLF/L0GDRWSF9GJImY74
         7O7A==
X-Gm-Message-State: AFq9FYIVf364tOvlX7AOT7NfdTU1jgW73F6R1Un4wRK2DkbsjUaiUxUl
	pHQDzowqM+bl/Ef2D1NwNJsmHcFBzb7B4UoJAVTay5zIE+f6eZ7a0Kqy/Xomyfzhig==
X-Gm-Gg: AYBFou1XfXl1OQ5v6pPxx7BBLDL+ZyxUcm/sKhctXAR/mB7Igj9ibuHLfT82F8J086g
	ONw7yJlgj/Lcixu++seTPaIJkpie9Ny2lu1apQj0R6s8XemOspUom9bLgn4zDKNIEOtDVcZ+3io
	O/kCIg/OJUO0rEeiQfu3RrU0dU8IdYUGd5IgStqmUQKRH9YyA8JHdY73IV3anustCkX0Y8H75r5
	ahqDYsE1dEY8Km4E9dczTP1AzxaWwOMTVc/YpmU7lhBkmKp7GqPmiI5l0saTJo6/rOb3ouXQZMw
	3gPVz63gnzQSrxCHo0gIe2t6/bw7XemQ6xPZauY22LRHaLPbs3ZDFNn73v6OT7S2y71ivalvJaI
	SkvRNeCG7VxLyHJ54xt2pmTvsAphkswrMl5ssWaAf55kq7UifWPiDqEaF359iSN7JOHkbKrgUHa
	NwPnXBZBK093Mo8XgeNl9KGe8YSgZtBmIRfaJH7R5iRQg3IYfo8q2Iksq/kj/zjmJnI4QOLHET0
	wdVhhxTpUw3yJ/bUzw2h40Ba4i6DbwPLjmLZ2HEKi4Eescw4dbdFRruaBHgt8KP3GbjxIEtJvz2
	S6EvgjyuH04v/4wP+0k=
X-Received: by 2002:a05:7022:eb57:10b0:181:8948:f022 with SMTP id a92af1059eb24-1994fa65429mr7020163c88.21.1792949758947;
        Sun, 25 Oct 2026 10:35:58 -0700 (PDT)
Received: from localhost.localdomain ([45.127.46.6])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a0e8d700sm20990930c88.10.2026.10.25.10.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 10:35:58 -0700 (PDT)
From: Nikhil Gautam <nikhilgtr@gmail.com>
To: linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	Nikhil Gautam <nikhilgtr@gmail.com>
Subject: [PATCH v3] iio: chemical: ccs811: Make sampling frequency configurable
Date: Sun, 25 Oct 2026 23:05:45 +0530
Message-Id: <20261025173545.6892-1-nikhilgtr@gmail.com>
X-Mailer: git-send-email 2.39.5
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
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

Changes in v3:
- Reuse the sampling frequency array instead of duplicating frequency values.
- Separate register updates from locking and wakeup handling.
- Use a separate variable for the updated MEAS_MODE register value.
- Simplify the sampling frequency getter.
- Mark the completed drive-mode configuration TODO as done.

Changes in v2:
- Fix the Clang build error caused by guard() in the switch statement.
---
 drivers/iio/chemical/ccs811.c | 148 ++++++++++++++++++++++++++++++++--
 1 file changed, 142 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/chemical/ccs811.c b/drivers/iio/chemical/ccs811.c
index d126ee12ffe5..c48ac37b32be 100644
--- a/drivers/iio/chemical/ccs811.c
+++ b/drivers/iio/chemical/ccs811.c
@@ -9,7 +9,7 @@
  * IIO driver for AMS CCS811 (I2C address 0x5A/0x5B set by ADDR Low/High)
  *
  * TODO:
- * 1. Make the drive mode selectable form userspace
+ * 1. DONE. Was: "Make the drive mode selectable form userspace"
  * 2. Add support for interrupts
  * 3. Adjust time to wait for data to be ready based on selected operation mode
  * 4. Read error register and put the information in logs
@@ -54,6 +54,7 @@
 #define CCS811_STATUS_FW_MODE_APPLICATION	BIT(7)
 
 /* Measurement modes */
+#define CCS811_MODE_MASK	GENMASK(6, 4)
 #define CCS811_MODE_IDLE	0x00
 #define CCS811_MODE_IAQ_1SEC	0x10
 #define CCS811_MODE_IAQ_10SEC	0x20
@@ -79,6 +80,7 @@ struct ccs811_data {
 	struct iio_trigger *drdy_trig;
 	struct gpio_desc *wakeup_gpio;
 	bool drdy_trig_on;
+	u8 drive_mode;
 	/* Ensures correct alignment of timestamp if present */
 	struct {
 		s16 channels[2];
@@ -86,6 +88,12 @@ struct ccs811_data {
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
@@ -103,6 +111,8 @@ static const struct iio_chan_spec ccs811_channels[] = {
 		.modified = 1,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),
 		.scan_index = 0,
 		.scan_type = {
 			.sign = 'u',
@@ -163,16 +173,21 @@ static int ccs811_start_sensor_application(struct i2c_client *client)
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
@@ -188,6 +203,52 @@ static void ccs811_set_wakeup(struct ccs811_data *data, bool enable)
 		usleep_range(20, 30);
 }
 
+static int ccs811_update_sampling_freq(struct ccs811_data *data,
+				       int val, int val2)
+{
+	u8 drive_mode;
+	u8 mode;
+	int ret;
+
+	if (val == ccs811_samp_freq[0] && val2 == ccs811_samp_freq[1])
+		drive_mode = CCS811_MODE_IAQ_1SEC;
+	else if (val == ccs811_samp_freq[2] && val2 == ccs811_samp_freq[3])
+		drive_mode = CCS811_MODE_IAQ_10SEC;
+	else if (val == ccs811_samp_freq[4] && val2 == ccs811_samp_freq[5])
+		drive_mode = CCS811_MODE_IAQ_60SEC;
+	else
+		return -EINVAL;
+
+	ret = i2c_smbus_read_byte_data(data->client, CCS811_MEAS_MODE);
+	if (ret < 0)
+		return ret;
+
+	mode = (ret & ~CCS811_MODE_MASK) | drive_mode;
+
+	ret = i2c_smbus_write_byte_data(data->client, CCS811_MEAS_MODE,
+					mode);
+	if (ret < 0)
+		return ret;
+
+	data->drive_mode = drive_mode;
+
+	return 0;
+}
+
+static int ccs811_set_sampling_freq(struct ccs811_data *data,
+				    int val, int val2)
+{
+	int ret;
+
+	guard(mutex)(&data->lock);
+
+	ccs811_set_wakeup(data, true);
+	ret = ccs811_update_sampling_freq(data, val, val2);
+	ccs811_set_wakeup(data, false);
+
+	return ret;
+}
+
 static int ccs811_get_measurement(struct ccs811_data *data)
 {
 	int ret, tries = 11;
@@ -215,6 +276,29 @@ static int ccs811_get_measurement(struct ccs811_data *data)
 	return ret;
 }
 
+static int ccs811_get_sampling_freq(struct ccs811_data *data,
+				    int *val, int *val2)
+{
+	guard(mutex)(&data->lock);
+
+	switch (data->drive_mode) {
+	case CCS811_MODE_IAQ_1SEC:
+		*val = ccs811_samp_freq[0];
+		*val2 = ccs811_samp_freq[1];
+		return IIO_VAL_INT_PLUS_MICRO;
+	case CCS811_MODE_IAQ_10SEC:
+		*val = ccs811_samp_freq[2];
+		*val2 = ccs811_samp_freq[3];
+		return IIO_VAL_INT_PLUS_MICRO;
+	case CCS811_MODE_IAQ_60SEC:
+		*val = ccs811_samp_freq[4];
+		*val2 = ccs811_samp_freq[5];
+		return IIO_VAL_INT_PLUS_MICRO;
+	default:
+		return -EINVAL;
+	}
+}
+
 static int ccs811_read_info_raw(struct ccs811_data *data,
 				struct iio_chan_spec const *chan,
 				int *val, int mask)
@@ -249,6 +333,28 @@ static int ccs811_read_info_raw(struct ccs811_data *data,
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
@@ -293,13 +399,43 @@ static int ccs811_read_raw(struct iio_dev *indio_dev,
 		default:
 			return -EINVAL;
 		}
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return ccs811_get_sampling_freq(data, val, val2);
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
@@ -460,7 +596,7 @@ static int ccs811_probe(struct i2c_client *client)
 		return -ENODEV;
 	}
 
-	ret = ccs811_setup(client);
+	ret = ccs811_setup(data);
 	if (ret < 0) {
 		ccs811_set_wakeup(data, false);
 		return ret;
-- 
2.39.5

