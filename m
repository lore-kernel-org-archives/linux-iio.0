Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32D5476040
	for <linux-iio@vger.kernel.org>; Thu, 20 Aug 2026 14:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787235305; cv=none; b=TnDgOpWtgXoAmK8ZENaWEIER+mLsykmHlackUQxj+KTyEAGRyKkFATlRC2fIvfTseyl/86qjvGP5zpVFkFM5Ygylb4mwHStnEoSIkkvgKAnEg7YktbRjX+Bv1BjuvQITk+gQSSeXzXNyNjh72KmsodWnlOXSCC1eQ3Qm8vovHXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787235305; c=relaxed/simple;
	bh=vaUt2WngZvej8rMhw+20QIRLHh5i07s/h72XHZcc7m8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RrdMyP5sq4ydt2+dkZHTCUMTUwD6XzLif98rUH1hX9O57FTYfl7R+XN0tWijvCqykv5dIgnv8x9ZfLF5kWDZpfawtciuHIvG/DJsiQKQ+Yux3y12WCDcsA8tlJNvXDk7Eu4YgA30X2wjDXBXP3k0bylheU8awj2vRQO0WYWFelM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ponazmE2; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ponazmE2"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-936623c6dd3so65682085a.0
        for <linux-iio@vger.kernel.org>; Thu, 20 Aug 2026 07:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787235301; x=1787840101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V4byyIVDC8xrDqBbbdyyVfs3GYKxJM8abcStoyFq/yk=;
        b=ponazmE2+gT8sYyxLidZt7UeS1Oo81EGiT77CeVDHmdVp4LT3NWq8RwjxQwC51KDU1
         gZzW7kuts8W3ywk3Hb2m7KAGy1kSYTb3vALbybSpkI28wJUkcn0jGGFrCGdbcPReI378
         xNOvNpR2w638Z+uGWSDF/AYHCWq1CmCi4xIRtrmnYdjHsBFzTaHPOZpXAkOgLDdC1eob
         B/2ugUUhSBkLv/L9mBlf4s5jEUzVjlfukDCyYi0xHgtSDd16C+r+uWQzTmUAEpWcqYYR
         aMr820+we21kqbVEx+ZLh9FLPqDfvJoYX43n+sr359YTMRazHn5pN/drZ8LSIRfshFbH
         xFRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787235301; x=1787840101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=V4byyIVDC8xrDqBbbdyyVfs3GYKxJM8abcStoyFq/yk=;
        b=GbkxZoSEy/sU300LYMioVteAe+geqjaSdRT48QqlCFDSAZqhE/HB0GsB/vZo1wmWaL
         BSDbaK6YsqZkpLSf2xXjVUQ3HekOgiA0x2c6f45bRVxhHCeqdAGt//+jHY2CAZ//n576
         6YmVNztw/BBDjvxq19XSuB20GaLV8yRpSbLcWvn4aRC2qOBHKaVlEblg/ZoLz/++ZbeU
         sw9A4oRc0at00EIY2ygV2YN/vTPPCBkJv8o+VENzZ2vKrr3I1yj+tqdQa83INMao727L
         lVuQrrYGvugFOGldp0ykfHH8PO6Vw85yO/sCps1PPu1Tjj0Bq+6dIZ3wPgHajXCTaAFJ
         YGmQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpjoo58hGnARNpNfuML2hafteNJi7Prs46gC6p4GMA1lXh+WedKFqT05q1mZqtvoo5PtJKyn4vKxzM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPRXkNVo2XZ3mdndV1i9YPXjLbjKg3IZcf91ZphnyVsKUWqdxz
	b2MTck8H8UawfDI9n0cvBv78r3uH4J44eMkGqCY2M4UVfc9zFhfrWlvs
X-Gm-Gg: AR+sD10vB4iYt9efmdzsPgYahzmlnrdiHk1Oj8i2BXdHmyMV5On/bOC6lHEUXRk6s2R
	8dqDVuqVV6UvqWadmUSGnrJ37C6Ud5EqLkaFNtplzQok2GkLanEAwqiHRP5Vim1FDKHVPk47Rdd
	obh2cI81aeuTUxl7G9/9OKHlpNuMhcB3isSku5c/QZbJHmvH3juj0NKHesPelEaprVL5RngoZDd
	//u7hswJgR1HhfNMMCwwRls6sgvJKfHnFiTGQI0Xu+zJh7AbM1bv/NNlZf+BIyFJ7RNvn790sAT
	R/qZekaoSyjVPtLZclaDh6M14Wuo4jJy+4J20/iwzw2ewt5lMHeCXePPxET81ytxOU2R6IwkeB7
	D+HlCurHrHZ0UZzqVzee3/SzqdAYqponQH7RzkWobzZxml4PYrTDOGd4m5IJQ/RgJxnpBLs4WJc
	FyggWxQm/oBzjDVwVxiD+nQuOHoVkRLVPNbMdedTETehPtn0MUa5RvK68fwkXLDlQLTAUeaCLeO
	A==
X-Received: by 2002:a05:620a:3942:b0:915:e8fc:1396 with SMTP id af79cd13be357-9372844ddcemr697466785a.13.1787235301379;
        Thu, 20 Aug 2026 07:15:01 -0700 (PDT)
Received: from louisarchdesktop ([2601:184:417f:5ad5:c570:9008:5a2b:8db7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9372059de87sm372738085a.47.2026.08.20.07.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 07:15:01 -0700 (PDT)
From: Louis Adamian <adamianlouis@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Louis Adamian <adamianlouis@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/5] iio: pressure: ms5637: Move device data struct to header
Date: Thu, 20 Aug 2026 10:12:17 -0400
Message-ID: <20260820141224.23730-3-adamianlouis@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820141224.23730-1-adamianlouis@gmail.com>
References: <20260820141224.23730-1-adamianlouis@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ms_tp_dev duplicated the hw pointer already in ms_tp_data. This stores a
pointer to ms_tp_data instead which requires moving the struct
definition from ms5637.c to ms_sensors_i2c.h.

No functional change intended

Signed-off-by: Louis Adamian <adamianlouis@gmail.com>
---
 drivers/iio/common/ms_sensors/ms_sensors_i2c.c |  4 ++--
 drivers/iio/common/ms_sensors/ms_sensors_i2c.h | 13 ++++++++++++-
 drivers/iio/pressure/ms5637.c                  |  9 ++-------
 3 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/common/ms_sensors/ms_sensors_i2c.c b/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
index 1960a2ce82a8..f9dc7c7468c1 100644
--- a/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
+++ b/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
@@ -579,7 +579,7 @@ int ms_sensors_tp_read_prom(struct ms_tp_dev *dev_data)
 	int i, ret;
 	bool valid;
 
-	for (i = 0; i < dev_data->hw->prom_len; i++) {
+	for (i = 0; i < dev_data->data->hw->prom_len; i++) {
 		ret = ms_sensors_read_prom_word(
 			dev_data->client,
 			MS_SENSORS_TP_PROM_READ + (i << 1),
@@ -589,7 +589,7 @@ int ms_sensors_tp_read_prom(struct ms_tp_dev *dev_data)
 			return ret;
 	}
 
-	if (dev_data->hw->prom_len == 8)
+	if (dev_data->data->hw->prom_len == 8)
 		valid = ms_sensors_tp_crc_valid_128(dev_data->prom);
 	else
 		valid = ms_sensors_tp_crc_valid_112(dev_data->prom);
diff --git a/drivers/iio/common/ms_sensors/ms_sensors_i2c.h b/drivers/iio/common/ms_sensors/ms_sensors_i2c.h
index f15b973f27c6..d9898098c066 100644
--- a/drivers/iio/common/ms_sensors/ms_sensors_i2c.h
+++ b/drivers/iio/common/ms_sensors/ms_sensors_i2c.h
@@ -35,6 +35,16 @@ struct ms_tp_hw_data {
 	u8 max_res_index;
 };
 
+/**
+ * struct ms_tp_data - Temperature/Pressure sensor data
+ * @name: Device name
+ * @hw: Sensor hardware data
+ */
+struct ms_tp_data {
+	const char *name;
+	const struct ms_tp_hw_data *hw;
+};
+
 /**
  * struct ms_tp_dev - Temperature/Pressure sensor device structure
  * @client:	i2c client
@@ -42,11 +52,12 @@ struct ms_tp_hw_data {
  * @prom:	array of PROM coefficients used for conversion. Added element
  *              for CRC computation
  * @res_index:	index to selected sensor resolution
+ * @data:	Temperature/Pressure sensor data
  */
 struct ms_tp_dev {
 	struct i2c_client *client;
 	struct mutex lock;
-	const struct ms_tp_hw_data *hw;
+	const struct ms_tp_data *data;
 	u16 prom[MS_SENSORS_TP_PROM_WORDS_NB];
 	u8 res_index;
 };
diff --git a/drivers/iio/pressure/ms5637.c b/drivers/iio/pressure/ms5637.c
index 4f9f556bd123..6009d87f3d4c 100644
--- a/drivers/iio/pressure/ms5637.c
+++ b/drivers/iio/pressure/ms5637.c
@@ -29,11 +29,6 @@
 
 #include "../common/ms_sensors/ms_sensors_i2c.h"
 
-struct ms_tp_data {
-	const char *name;
-	const struct ms_tp_hw_data *hw;
-};
-
 static const int ms5637_samp_freq[6] = { 960, 480, 240, 120, 60, 30 };
 
 static ssize_t ms5637_show_samp_freq(struct device *dev, struct device_attribute *attr, char *buf)
@@ -42,7 +37,7 @@ static ssize_t ms5637_show_samp_freq(struct device *dev, struct device_attribute
 	struct ms_tp_dev *dev_data = iio_priv(indio_dev);
 	int i, len = 0;
 
-	for (i = 0; i <= dev_data->hw->max_res_index; i++)
+	for (i = 0; i <= dev_data->data->hw->max_res_index; i++)
 		len += sysfs_emit_at(buf, len, "%u ", ms5637_samp_freq[i]);
 	sysfs_emit_at(buf, len - 1, "\n");
 
@@ -168,7 +163,7 @@ static int ms5637_probe(struct i2c_client *client)
 	dev_data = iio_priv(indio_dev);
 	dev_data->client = client;
 	dev_data->res_index = data->hw->max_res_index;
-	dev_data->hw = data->hw;
+	dev_data->data = data;
 	mutex_init(&dev_data->lock);
 
 	indio_dev->info = &ms5637_info;
-- 
2.55.0

