Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793511633;
	b=PYRR4+nPmPQRQzkK+fpjGjyOYm11RZp2d80Gla2n0fHAyRKi0fRPmvw4R29kZS5fuZBR
	 0YtnRWRdB/lGjyMoISDGGG14u4wHdRkPL3RUTnViqEuc1ZU/FpP1jgv5zLxj/wsdCG3cX
	 KRJzLYa5tdfewDJoJWxVyZSIC7CLLh7pMt3qJ3OQVTC4r/GwNLQo6UDenImT60UQ+wyq8
	 nMQsEguD0KBJQw8NAnbJ1VouRf8fgQDvwuYWx66z7Pd2b2iwMvQzvOqUe7xRVhjbS68f/
	 lduFldhoDMHdTs9eJGmOVlEOnZb+UJ99TDQizk6lEIxYN9esXY2V5K1qzdGPcQI3xnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793511633;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=qmg7W2cGTeAOdvv8zg7tvgjytF9NfVgM1HwYSB4ggA4=;
	b=gJKyNKSn7/nfrVFhtDs7ZWSSk7Oy6hAt4SHcIIbw92yvl7RE/fAKKCPBxHDT7Pf8BcBK
	 2opU7RWQPi+7ZlF6y19LvYcgqwwuqOU/T6PKA3ik/8GO9zExJ1vrWLb1of3F0AyZHTu72
	 YZIs3FOx28KeYE7ZN0PjNJh5licyzRGBZLtoKSQ37/J1x7dCo1B7NxvTwsd4ahw9EhVRR
	 EJa+kQ/9lNLXI3NUqfKGQ9x/r1gfdEo4+LQKZ//TR+p5A8d9KJUDKTQSNtDiTQtGDPUe1
	 c1IaedKHgKxtYeFvqx1WLHMVdfUKSXt2PRWJ1w6CrZBy7bXFroZzDbw/qrSCe6CxBQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RNK4gJ50;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACEF606A324
	for <linux-iio@vger.kernel.org>; Sun,  1 Nov 2026 05:40:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3ACEF606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RNK4gJ50
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-35829219da8so3588094eec.0
        for <linux-iio@vger.kernel.org>; Sat, 31 Oct 2026 22:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793511631; x=1794116431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qmg7W2cGTeAOdvv8zg7tvgjytF9NfVgM1HwYSB4ggA4=;
        b=RNK4gJ50pRsm7+tfNa4ZRyzuRGbacSK0/Nn2w+/9cdXKOu2mdV0JFfTVxRRZdatVPG
         RH+vfXmrOYE9MkEdvVuQhQgrtBUouGxvqYpNaIuuhYhCCZ+fk7Gk0QwxTeIWs0Yc843t
         hFChSd/sAG0vpUaJNqXHpX1OAodBljZ2qBg8dYABHErHJJixA/JAzes7dyTvDCcyylF5
         GDsHN2afqRp7SaWC8XZzKBTmTFx1vhNoJavM4K7ip0li8e8yiPfx7VyGwdrMYWqHaYR/
         PeVxcGKBqrio7n9+8uE+TpOYrJb5LRn0Kb0+0ExTV3L4Qeo+Smvh+BqXrhadShEfv+29
         Gbiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793511631; x=1794116431;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qmg7W2cGTeAOdvv8zg7tvgjytF9NfVgM1HwYSB4ggA4=;
        b=Zh0QXrgnE+eCeO6MM5avy45M+4Yl1129jvJmz8Fro1N9m34ZUI8y4FjQnHfwwUzbVA
         K4la6R5ReG3M9n3oSCXxsI9TBCX9HqX7Wg9lY9SDl9a9ESVApTjWWJkEVCiXt1hai/OY
         6YjaHPvT7jQjlQKtPhW5uhF47X2HLIwVXtyfPJAbA1R/5Mryt4tvkUwAdtvGIs9lVtje
         jjgpGRKowUb3opmURQ3Od1pyogOPU68Ug+906BO8bxqGlNL95fR88NFELPJuH44ejXfB
         1pBqpLDlcFEYpsS+khUPGoknnosXUrde7NtNMGpQtd5+21rsljHDNLoxGD5bQzH0r9AU
         Zanw==
X-Gm-Message-State: APuU4Z9XEXLBn/b7+oJzWCa0jz27Ocd/JiKCe5+W5GNwWHFf1C3BgE0n
	Pnt8KPu9008NsyAcB4OlMj0iCRzO04t2dZ/fXTgd1st3LOr5CFBVJulnNm7EvxU=
X-Gm-Gg: AYBFou1dpDa2niuoyKlWs1o0rDDZWdmLkrHE1c0RCFUGrFWGJo/OoeNzXqWrIrvAISd
	epIKqSvcM04BbJLXvPEO6VaspJf99nC8PphpxklhYg7ZGhfWMbSQvHCOH7VCXu8K9x1+ry2uFdb
	rLDikPEyWBj5kpoS4xDPXvmcyKYKqSyMDCNPZt1W/uY1Tk56zi+7ReS2RF5dJsTr7Ha0RAtVhm+
	H89ClBlVsjV82bJyAMDRaVKzoeO6oLdbagznTY//XGR7DLwRlcm7exQhIpLQwc3CpvOLbl9hbGi
	WQZjoXjzeuk+VjjCAZqifACOvS1dOeIJAhuTHOL+9ajtowsFm5DcJLOCMlKH2Zs7ORlS5scf6TW
	UJa+AjyM27A5vxG5oXm0YZwbTziyAGwWw3TIYooU3GElb3eMcYBrG2j4rlITZ/M+FETJ3so0JWo
	rRooDPJRv9OBJQMnZymuLlrPNER/ul4HWZ+gqboxqVpzl3oVK5uUqiJ/yArePYF7ihWELVYPi2a
	UkPGUkkEjrQn5kXBJlrsTZUmCEskAw0RJNZyx82ZFPoG5nCofnaKlxuC/Tc1p/hYQl0G3JKZVFE
	2ku1Ny3wTAH6I+8iQc4mYEsjNhnOFdp+9AmQV4RajVl1ajJFA15qgGNSpfM6lDif6C+UuagoqGk
	G0XTI3xxnBl62QQ==
X-Received: by 2002:a05:7300:3b05:b0:369:fe82:8d3f with SMTP id 5a478bee46e88-36a3002ef31mr19060763eec.14.1793511631059;
        Sat, 31 Oct 2026 22:40:31 -0700 (PDT)
Received: from localhost.localdomain ([101.0.63.213])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42935b4asm32378828eec.16.2026.10.31.22.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 22:40:30 -0700 (PDT)
From: Nikhil Gautam <nikhilgtr@gmail.com>
To: linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	Nikhil Gautam <nikhilgtr@gmail.com>
Subject: [PATCH v4] iio: chemical: ccs811: Make sampling frequency configurable
Date: Sun,  1 Nov 2026 11:10:19 +0530
Message-Id: <20261101054019.10188-1-nikhilgtr@gmail.com>
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
index d126ee12ffe5..1a865377361c 100644
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
@@ -64,6 +65,19 @@
 
 #define CCS811_VOLTAGE_MASK	0x3FF
 
+static const int ccs811_samp_freq[][2] = {
+	{ 1, 0 },
+	{ 0, 100000 },
+	{ 0, 16667 },
+};
+
+/* Drive mode for each entry of ccs811_samp_freq[], same order */
+static const u8 ccs811_drive_mode[] = {
+	CCS811_MODE_IAQ_1SEC,
+	CCS811_MODE_IAQ_10SEC,
+	CCS811_MODE_IAQ_60SEC,
+};
+
 struct ccs811_reading {
 	__be16 co2;
 	__be16 voc;
@@ -79,6 +93,7 @@ struct ccs811_data {
 	struct iio_trigger *drdy_trig;
 	struct gpio_desc *wakeup_gpio;
 	bool drdy_trig_on;
+	u8 drive_mode;
 	/* Ensures correct alignment of timestamp if present */
 	struct {
 		s16 channels[2];
@@ -103,6 +118,8 @@ static const struct iio_chan_spec ccs811_channels[] = {
 		.modified = 1,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),
 		.scan_index = 0,
 		.scan_type = {
 			.sign = 'u',
@@ -163,16 +180,21 @@ static int ccs811_start_sensor_application(struct i2c_client *client)
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
@@ -188,6 +210,54 @@ static void ccs811_set_wakeup(struct ccs811_data *data, bool enable)
 		usleep_range(20, 30);
 }
 
+static int ccs811_update_sampling_freq(struct ccs811_data *data,
+				       int val, int val2)
+{
+	u8 drive_mode;
+	u8 mode;
+	int i, ret;
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
@@ -215,6 +285,26 @@ static int ccs811_get_measurement(struct ccs811_data *data)
 	return ret;
 }
 
+static int ccs811_get_sampling_freq(struct ccs811_data *data,
+				    int *val, int *val2)
+{
+	int i;
+
+	guard(mutex)(&data->lock);
+
+	for (i = 0; i < ARRAY_SIZE(ccs811_drive_mode); i++) {
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
@@ -249,6 +339,28 @@ static int ccs811_read_info_raw(struct ccs811_data *data,
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
+		IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
+		if (IIO_DEV_ACQUIRE_FAILED(claim))
+			return -EBUSY;
+
+		ret = ccs811_set_sampling_freq(data, val, val2);
+
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

