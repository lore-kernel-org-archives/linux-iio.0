Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793805112;
	b=E4tVX9RZ+GXMmql7kLYuTQjiLr1vK+E7wGLoHCrF85+nYxKq3zDfG7REDx4L/eHY6WgW
	 dqh4ytPlHZe/O1XUXoFT+zMyw1VHa7wy+2HI5wWQhVCGxZUNg2Mu7vZigjXpixLmqDfMy
	 STvMl0xu9xcLUsdTnCEcnv6RtEZy/GzbTto3hKCSo2p38ZtZ1yYWqZ9DdXTvZMHXiuO9Q
	 gOIGSJu+htwPa3rcG+ZRyV0mPCH8EmM+gRkRq74vNef0bVFo316/OsXoggA+vR9vIj1zc
	 YwzA8CNDcfGN4xIaq4cLakYbScRItQTD768RfY52/NhWx5zVFLgW68Yi2d3aDLc2sTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793805112;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=vFY3rUifhZYZptpkXHuxi9V9dsY7EaxoNRnnnDD65QE=;
	b=bJXrYRQ/SEfcnzh+P4ANw2H1wLtclR0HTFEtkv+lKCjMGLLWM0m/veGvReRrzgMan5iz
	 CQEbcjwkKEEEh3dNFt5ITGCPylVvGna4B1rFEyX6N6pQ/Cv6xtvvzeKnIksQSV19mNQKd
	 OWjaDJK3igBYKHBTC22YNFpfpo6uzcMEHfPbZJVwQp3o+2EMPfh94NZq1cNm+ypIkYfcI
	 5uI6OUc1mfh+zVPQWBpb37eK7IREMXRHRT7PkonTz+TMviNkiuFd+wTOr0z0PsW7+lw1e
	 Lm9Myu6K6P0I7j3UcSmvzPYPIgf9j1x8T0GswEkyc4vWat1uNV2nZ6yJ5kqi7wssAcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Nsf1Rb/c";
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B0B606A326
	for <linux-iio@vger.kernel.org>; Wed,  4 Nov 2026 15:11:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73B0B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Nsf1Rb/c
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-3514b90bb89so1518778eec.1
        for <linux-iio@vger.kernel.org>; Wed, 04 Nov 2026 07:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793805111; x=1794409911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vFY3rUifhZYZptpkXHuxi9V9dsY7EaxoNRnnnDD65QE=;
        b=Nsf1Rb/c9ysjs+EGyo/zIpNmDSF8Sogm2rYTyBq5rZBKjMKJeq1e3MKnxQXzZFa5OM
         FAmPY9bNy/aWOh6AVPNxkvuImZLEYY/USMBaPKDH31mopM3mNGvj9yGIbrSg56tFNoMS
         T6ItdwGfaY+kZYNsnhv+6V7H4RJ0ieb0wmCUR3OaB9jM8dcLMWf4jiWGHffpW87Qid2h
         2jhgW0rCcEh/VYBWsrNdV5K3nZqIk02rnzSejaqZ2D+9CULpMtdye1Hb9hVb9yJRutq2
         edD44dVG7Ea0zKUUNdBltY+n0ngBUeeBR04iXyY1dqmWG0Hiy8US+fBJHukzE4pWH69k
         Xrug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793805111; x=1794409911;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vFY3rUifhZYZptpkXHuxi9V9dsY7EaxoNRnnnDD65QE=;
        b=QtvjR2ILuB68NSfOAseL3/+OpF6kQv6IaR4lQlYeA3VSrapPyWJTkqXLTywcqh/oT/
         j8iDuSfOSwidAd+/NctHTx8FFyXCSWSP3VrDsBD1JE6h9PpznZxt7AqXwH+zmVmwsEK1
         5rKsvg3uR7/z1TcxMGZ3iDW2RC6EIu1byCHhOj1kcatcSZsqForvcIOJaGcf2zU9aJ7r
         F9HJ3zj8RHLx6Hsv43HnnVDDiHuo7KvuEskLUn0ACfbNxcaz+vY5RMhQiyPcGEh0vi/i
         VhJOvb7QMe/Sec+XjTaBlr8rqL+mEVb3ulUMFp39nz8gEDtaS0pC5NNTFYhCnp2CjmOc
         4Mzg==
X-Gm-Message-State: APuU4Z+H2b8/feIZci+73EvW/mGkdK3YOyiG8mkLdL4Jd3ZdgzFpDnB1
	uFLhHV9OaZx+7jMG7fTYYspQnRBSYXHvZyVcxCgRBxu2fJFheLtPDx2fp1TSRIw=
X-Gm-Gg: AYBFou2Y4VrvvwGWvMP3qqXl1rzzPN6F32Xezesnw8Py2MAfzmrZijrm5bjkLtZwD1k
	/Qe5m0B3bpv+4Xq2v5x0tnqhCPZgjJO6C2qlkBQmuFJf4wF9oCfQERfpmvBRcguHsqWnUXoul0U
	Sr3YNqDI8IXZymo1HaaAOLPu3e2Hn+IUsN+QreeMqaMWBJxdVKChARSiaQWBspPle7HjQurvsMB
	BsCKzRn06msDga48u/1+5vqAtK5iH3iR2qnmIJ2ShAzE1/Ri3KjtbLgJ7ORT4RIb6bwOmLVY/ms
	Htovbj95C13SDlSE1Qxb/N1yJiKudb/9LnjqcqB2AiUj7tYiWUsdVlxcmehSEZvi/O1ajiv15bt
	IJ3mxzySOaW6APpC93zkNTDLizWWTg/75QaiihLKkNh4xxGhj5r0KRCrHeu3m5zeIFi3tnLayWc
	0VcTqsLhDDfyqaJkVa6u0tIW9pat9zI/uq7M8CiYOGy+2Dn2F2hX/YcTtK9MK1nmgX/gqw0CFIj
	M0lmox+QgE714vQy5xQoY1EXtMzmFl3XXSMQIG8EppjwJu33mxtPYt1OCATf7oRSDZ81si3NILm
	/iXcxCn3B1GlqVn1Lnc4DUHPd/9AFacC1yh2S3N0FDd1bn28nxgG95BtEy0HBq7vWjMGig==
X-Received: by 2002:a05:7301:1a15:b0:34d:7ae5:8d78 with SMTP id 5a478bee46e88-36a42418401mr22538914eec.31.1793805110881;
        Wed, 04 Nov 2026 07:11:50 -0800 (PST)
Received: from localhost.localdomain ([45.127.46.119])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca3989670sm11062900eec.25.2026.11.04.07.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 07:11:48 -0800 (PST)
From: Nikhil Gautam <nikhilgtr@gmail.com>
To: linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	Nikhil Gautam <nikhilgtr@gmail.com>
Subject: [PATCH v5] iio: chemical: ccs811: Make sampling frequency configurable
Date: Wed,  4 Nov 2026 20:41:38 +0530
Message-Id: <20261104151138.9968-1-nikhilgtr@gmail.com>
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
---
Changes in v5:
- Add an index enum shared by the sampling frequency and drive mode tables.
- Make loop counters unsigned and use reverse xmas tree declaration order.
- Use a local i2c_client pointer in ccs811_update_sampling_freq().
- Drop the redundant ret variable in ccs811_write_raw().

Changes in v4:
- Move the changelog below the cutter line.
- Use a two-dimensional sampling frequency table with a matching
  drive mode table, and look entries up with simple loops.
- Use IIO_DEV_ACQUIRE_DIRECT_MODE() in write_raw().

Changes in v3:
- Reuse the sampling frequency array instead of duplicating frequency values.
- Separate register updates from locking and wakeup handling.
- Use a separate variable for the updated MEAS_MODE register value.
- Simplify the sampling frequency getter.
- Mark the completed drive-mode configuration TODO as done.

Changes in v2:
- Fix the Clang build error caused by guard() in the switch statement.

 drivers/iio/chemical/ccs811.c | 154 ++++++++++++++++++++++++++++++++--
 1 file changed, 148 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/chemical/ccs811.c b/drivers/iio/chemical/ccs811.c
index d126ee12ffe5..6d675534c5b6 100644
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
@@ -64,6 +65,24 @@
 
 #define CCS811_VOLTAGE_MASK	0x3FF
 
+enum {
+	CCS811_MODE_IAQ_1SEC_IDX,
+	CCS811_MODE_IAQ_10SEC_IDX,
+	CCS811_MODE_IAQ_60SEC_IDX,
+};
+
+static const int ccs811_samp_freq[][2] = {
+	[CCS811_MODE_IAQ_1SEC_IDX]  = { 1, 0 },
+	[CCS811_MODE_IAQ_10SEC_IDX] = { 0, 100000 },
+	[CCS811_MODE_IAQ_60SEC_IDX] = { 0, 16667 },
+};
+
+static const u8 ccs811_drive_mode[] = {
+	[CCS811_MODE_IAQ_1SEC_IDX]  = CCS811_MODE_IAQ_1SEC,
+	[CCS811_MODE_IAQ_10SEC_IDX] = CCS811_MODE_IAQ_10SEC,
+	[CCS811_MODE_IAQ_60SEC_IDX] = CCS811_MODE_IAQ_60SEC,
+};
+
 struct ccs811_reading {
 	__be16 co2;
 	__be16 voc;
@@ -79,6 +98,7 @@ struct ccs811_data {
 	struct iio_trigger *drdy_trig;
 	struct gpio_desc *wakeup_gpio;
 	bool drdy_trig_on;
+	u8 drive_mode;
 	/* Ensures correct alignment of timestamp if present */
 	struct {
 		s16 channels[2];
@@ -103,6 +123,8 @@ static const struct iio_chan_spec ccs811_channels[] = {
 		.modified = 1,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),
 		.scan_index = 0,
 		.scan_type = {
 			.sign = 'u',
@@ -163,16 +185,21 @@ static int ccs811_start_sensor_application(struct i2c_client *client)
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
@@ -188,6 +215,55 @@ static void ccs811_set_wakeup(struct ccs811_data *data, bool enable)
 		usleep_range(20, 30);
 }
 
+static int ccs811_update_sampling_freq(struct ccs811_data *data,
+				       int val, int val2)
+{
+	struct i2c_client *client = data->client;
+	unsigned int i;
+	u8 drive_mode;
+	u8 mode;
+	int ret;
+
+	for (i = 0; i < ARRAY_SIZE(ccs811_samp_freq); i++) {
+		if (val == ccs811_samp_freq[i][0] &&
+		    val2 == ccs811_samp_freq[i][1])
+			break;
+	}
+
+	if (i == ARRAY_SIZE(ccs811_samp_freq))
+		return -EINVAL;
+
+	drive_mode = ccs811_drive_mode[i];
+
+	ret = i2c_smbus_read_byte_data(client, CCS811_MEAS_MODE);
+	if (ret < 0)
+		return ret;
+
+	mode = (ret & ~CCS811_MODE_MASK) | drive_mode;
+
+	ret = i2c_smbus_write_byte_data(client, CCS811_MEAS_MODE, mode);
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
@@ -215,6 +291,24 @@ static int ccs811_get_measurement(struct ccs811_data *data)
 	return ret;
 }
 
+static int ccs811_get_sampling_freq(struct ccs811_data *data,
+				    int *val, int *val2)
+{
+	guard(mutex)(&data->lock);
+
+	for (unsigned int i = 0; i < ARRAY_SIZE(ccs811_drive_mode); i++) {
+		if (ccs811_drive_mode[i] != data->drive_mode)
+			continue;
+
+		*val = ccs811_samp_freq[i][0];
+		*val2 = ccs811_samp_freq[i][1];
+
+		return IIO_VAL_INT_PLUS_MICRO;
+	}
+
+	return -EINVAL;
+}
+
 static int ccs811_read_info_raw(struct ccs811_data *data,
 				struct iio_chan_spec const *chan,
 				int *val, int mask)
@@ -249,6 +343,24 @@ static int ccs811_read_info_raw(struct ccs811_data *data,
 	}
 }
 
+static int ccs811_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int val, int val2, long mask)
+{
+	struct ccs811_data *data = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
+		if (IIO_DEV_ACQUIRE_FAILED(claim))
+			return -EBUSY;
+
+		return ccs811_set_sampling_freq(data, val, val2);
+	default:
+		return -EINVAL;
+	}
+}
+
 static int ccs811_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan,
 			   int *val, int *val2, long mask)
@@ -293,13 +405,43 @@ static int ccs811_read_raw(struct iio_dev *indio_dev,
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
+	*vals = (const int *)ccs811_samp_freq;
+	*type = IIO_VAL_INT_PLUS_MICRO;
+	*length = ARRAY_SIZE(ccs811_samp_freq) * 2;
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
@@ -460,7 +602,7 @@ static int ccs811_probe(struct i2c_client *client)
 		return -ENODEV;
 	}
 
-	ret = ccs811_setup(client);
+	ret = ccs811_setup(data);
 	if (ret < 0) {
 		ccs811_set_wakeup(data, false);
 		return ret;
-- 
2.39.5

