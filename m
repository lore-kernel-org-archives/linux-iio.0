Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792681624;
	b=ntoRHoXzpgRRZuaHZYJpGC0lvmCRn4k5+HC2u0016l6LZ2LEgrPoOF+fzh4nB+/OIGs7
	 knFXmVFmuXOvvVIxIcVOmJGVgbSf0USJIEEqF1KZ8MHnvk2EDdiyMWkCRo1eb0hIdBUjs
	 iOnJ9vCmWEKHOZxlha3ZjAoKaLo4+AxUgUKPHF63XwZC24VOYXeVZ6tU6m8dTrEnpRAWb
	 iu3CWTpiIUgX3Ckcl8uy8e+8275Z0MM6FTMHGk7Oqq1q89EP80CuZwLCp5gXFetpIYhi3
	 xVgPt7yu1P5IV2CGDXQWjGqcApybN6LoFsgshJMPjZBBF2MaW6Q1F/8GIiXxjWOwivA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792681624;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WJvVinknyEzeiRsHAYM6GbQze/GHN3YehwHAtJv+JOI=;
	b=1ULvJ/YMdVdE13sbvSAgKNqGZu/lFO510trE+08C6tlfYyPqCPxtwjA9i8WBYq6P43Cu
	 M92rj8AhzRiRDuiUB+sSoDlhhh3DnQqDN7H4htI6JTAPXIgmFZ/rFK5dyJRBHexg4pFe9
	 tnYregqjA6jW1mem7RuIjlq7Gi0XZVMEpILPlkjpeNPZYUwak2hgez8oLC8E+Va9vIaMc
	 J9k0bGdA9wALiatyA+ThEMoISeu4k77AuMQVYA8eHKxgc41NUTAhmjmOAeOTnRG3i6jCc
	 FBIFB4f954/HhO+tAwlPcpOwlkNMRVrjru/cSs/tHl2cZ7IgrzaIHXjri4jkAsro1kA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OcuNHFRm;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E23360A4ADB
	for <linux-iio@vger.kernel.org>; Thu, 22 Oct 2026 15:07:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E23360A4ADB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OcuNHFRm
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1438d9363fbso837266c88.0
        for <linux-iio@vger.kernel.org>; Thu, 22 Oct 2026 08:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792681623; x=1793286423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WJvVinknyEzeiRsHAYM6GbQze/GHN3YehwHAtJv+JOI=;
        b=OcuNHFRmYwSXXcbTWye1iR3vSZT+PF5Kw5TZsHpKEEA6Sy+nOIUzQNQOWV4Av8dKD7
         s4zZ7nYxLUArQ+kW7iSM8XPsXeA4RvzHbjYptgXWGNIrmFcchPupu+htAuDMpjIR7eve
         wae5XnOz7JGEEgYBAZWcqQFuaxpfivtkhdE/tTIApSI0XCPvVM8Fz2EL5RNUKVALuf2d
         /p//SwiC3+X24Hn+4DY/skGW0lXdMXMPtX5Epkytzycv4+AEZPlXDW58OV5ig3pUW9eu
         3v6H6JXTbNeSPQU+4H4dzBkl3Q9ZEbNT+xq8aSTVdFHU3ymJp1l7J3dAZPyAmi/1JJOv
         sQOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792681623; x=1793286423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WJvVinknyEzeiRsHAYM6GbQze/GHN3YehwHAtJv+JOI=;
        b=B0qW5mDnPJFUQa8qEjm5smLkmJR53e0vrRt9NYKkFyW9drWWWK4dOJeoc8rwnK/JKN
         koMCkfu2tJBvuc6jndtl2qn4yszLD5l78YXjt4RgBdlWApxCoGv3Rdl84yPSJAqhaXjy
         RZv0sxw5X1PQk1uK1e4Uwex1PeIs/6pPPyvSHM+R+0wLx7LkGabtJppcZQYxxoHiqCL8
         e6N2R7hdyxbsMsrv+Z/8v90Ue7jAsRJceeNWEWMrazOcGaJysO+a/iy3xDGAuWYeb9yK
         hCN5vG/ZISSo64dRowONGLUpvJH/wNjv0GvgQ8NVMQmUyTnceyNcuKGptpVAR6YaDNqt
         pdVA==
X-Gm-Message-State: AFq9FYKE+9fzJtoLpkKobUPWq/PYQaVVkNrPwR2ZXxkgXqLJ3s+WMuzi
	nNaFtpYaiDBi1rZ/pC9T7rokEpNZxlw8BLkU5eh7aM54e7SKg9tQVWbeHINDk86NyQ==
X-Gm-Gg: AYBFou2qE0e7SsSI0PKXlqhq0faNWj2knYfmB5R2OaZZY0Qzk6bBY/X9r6D0kZ90aIU
	/BVn3C7rs5dakYIFGX5UQBaGmVpPG4IcbKqRrqcgmMBZxDP88TgR3W3MM0sU33vS1PoSKJn0+5e
	DXNQwHwLzOALfEHwoMsQEIrUoe51mMWOdDrk113s4Cy2sLfFujMDgSlmAXtoDrVeF0ibL25i4hO
	wayYW6TyR9AmvkJup/QyJd6yR8ChK/BloxXY3ufAui3SDo84v+YJqNZe+g5ciyzI3TRYQjSCTCl
	ZNi75TXRXoS6f6OFsiirVjWn9oimj79zBA31VdEPdCoNKoQKag54DcmihhUermEWcjvg/vRCG3k
	Q9KizLJa4OVD8evLe0/848W6tb56m9XpC11tg66pA9+64bZATFYfbPyxFs7uakLuW7rb5dXKV0H
	PB13wlfwqmfgz0/6yeAWd77C0sxd5GUTin+2ObxtLoIjOvHtc9S6LuvQuM6u2Jv4bDCpFXPmB8G
	wGBLXs+2OweaaIvZBe5vK4C7SuEbZOvgaKYEnSN/RIPYw/5vDctr5Uf8tmhB+DHQY2jTy86ol/x
	E5c01e7IYijWq2pR
X-Received: by 2002:a05:701b:42d1:20b0:185:e68c:904c with SMTP id a92af1059eb24-192f2f0ae92mr3345694c88.7.1792681623297;
        Thu, 22 Oct 2026 08:07:03 -0700 (PDT)
Received: from localhost.localdomain ([101.0.63.6])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903bb7f098sm24297301c88.12.2026.10.22.08.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 08:07:02 -0700 (PDT)
From: Nikhil Gautam <nikhilgtr@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	lkp@intel.com,
	Nikhil Gautam <nikhilgtr@gmail.com>
Subject: [PATCH v2] iio: chemical: ccs811: Make sampling frequency configurable
Date: Thu, 22 Oct 2026 20:36:52 +0530
Message-Id: <20261022150652.4842-1-nikhilgtr@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261018170013.79443-1-nikhilgtr@gmail.com>
References: <20261018170013.79443-1-nikhilgtr@gmail.com>
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
 drivers/iio/chemical/ccs811.c | 147 +++++++++++++++++++++++++++++++---
 1 file changed, 138 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/chemical/ccs811.c b/drivers/iio/chemical/ccs811.c
index d126ee12ffe5..a1cbc4fa6a82 100644
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
@@ -215,6 +267,31 @@ static int ccs811_get_measurement(struct ccs811_data *data)
 	return ret;
 }
 
+static int ccs811_get_sampling_freq(struct ccs811_data *data,
+				    int *val, int *val2)
+{
+	guard(mutex)(&data->lock);
+
+	switch (data->drive_mode) {
+	case CCS811_MODE_IAQ_1SEC:
+		*val = 1;
+		*val2 = 0;
+		break;
+	case CCS811_MODE_IAQ_10SEC:
+		*val = 0;
+		*val2 = 100000;
+		break;
+	case CCS811_MODE_IAQ_60SEC:
+		*val = 0;
+		*val2 = 16667;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
 static int ccs811_read_info_raw(struct ccs811_data *data,
 				struct iio_chan_spec const *chan,
 				int *val, int mask)
@@ -249,6 +326,28 @@ static int ccs811_read_info_raw(struct ccs811_data *data,
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
@@ -293,13 +392,43 @@ static int ccs811_read_raw(struct iio_dev *indio_dev,
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
@@ -460,7 +589,7 @@ static int ccs811_probe(struct i2c_client *client)
 		return -ENODEV;
 	}
 
-	ret = ccs811_setup(client);
+	ret = ccs811_setup(data);
 	if (ret < 0) {
 		ccs811_set_wakeup(data, false);
 		return ret;
-- 
2.39.5

