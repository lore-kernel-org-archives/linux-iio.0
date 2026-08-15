Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D1B425895
	for <linux-iio@vger.kernel.org>; Sat, 15 Aug 2026 17:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786816669; cv=none; b=fXm0/F7Q0umCn1mzu35m5h9Q0q6uxi3mJq2D9kpvWVHOkK5StYJY/eXd8zusXtyAOu+NTd5IyHHHaN7vlR1oVeZbsrvCzUCDvrmXuoXnq0rd0QtQz6tyElqgu5X01wmG1kCO69ypOkyoSX+L8OA/f5T5zLP1kUTX1OKpDz9DIYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786816669; c=relaxed/simple;
	bh=nDPGlDwlnm9kRZGhwhrLqboq0/TEPJOiY31oDryGZyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=izmZ0azKJ6Qhw/FP/FkHZ+S3yuBAVPxdPfYu0k7asSJhrmG8YTtq2OltcfgnLggnB18yXyl9aUejGgBPV5v1N/dA7ntnvKaDgnV7GaV2QMJd+JV3gBk3UCeJBJnvV5pBcRfes4nZleMEjeeTdbylWCth18IFv/4E7RXQz94OZlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JszdG18N; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JszdG18N"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2caea3f742bso35681115ad.0
        for <linux-iio@vger.kernel.org>; Sat, 15 Aug 2026 10:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786816668; x=1787421468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gIlktj+wxmAUkq3OHJvtiyHqtwOwmYETQ46YaPY3Vxk=;
        b=JszdG18NzayTkhgLJ6wngugMo34fHp2p+RUzreOx5Iw3r5GI2zaEoLWUUIRkUv9fk5
         aaxRKvALG/9KQm/n3Jl2J885wkGxlh3A9V23yoHitoYRHqIJYV43rdzvPmKeYAXjP055
         TlsVQ1n1Kgyi/wYWrrGcG+R4GI5j1N4OEkHRb7SUh6gR+9Jzw+sjunCXcAM4xBf0LDFB
         rcv8h+w9wUeCdHrqMnPBAASeRTUeGBtQr8MFVAIF6ElFDRsAje0nnr2w9+Hk37Ht74oh
         VJqpus9A3SBhwsihNoB4aSNhANX42eBUc6Wkx/t4WVfOL8Py0cJm0f9k4M0q76CW9BOx
         u3xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786816668; x=1787421468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gIlktj+wxmAUkq3OHJvtiyHqtwOwmYETQ46YaPY3Vxk=;
        b=AHXuDPqkWYglNv3weD1fBX1RFoJDkpAxmREOEWnWklf5b6omR63PS9yRtWoU4ph+cf
         dQPnvq+J09hoVtwBvPFvDdf3ACz+77z/5coGUHI9Bolpkad+b0AU25S7BcvotdH6DvGh
         gkgmN+uwmYRy10pTHh1sjTrt4Bx8/SFJ/iCYavTo6th2zLdYCmpPYWs0doXW6X77FJC9
         6UiT7U1osrw3cTj/AECS5ExuckUUIRVwO+3Le4ef7KbP8hpbajtiWerl/U+RMSJf0Ic8
         WwVlTrZH0cXbzs54In8xIPsDqmIx8cgpSsK7TxEKN4iMg7BQ+bgzfjzCIHXa2GnMSz6S
         wNFA==
X-Forwarded-Encrypted: i=1; AHgh+RrenbSHM9N6ueNCkQhaGTAYxWYoaqdHkbAk5fcexQ0jDVQs5aXupDZMOErPOd84d2yf9O8BGDL84VM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxkGuGuF/+PsfFW2I5rT1+SfYazBh63d5vZfE17udRfXVRoyQv
	RxGaVCc3YdM8LZ5rxF0XeDdfInZBLwd2QIlycqKIOUkC+UFUCZRrCJRX
X-Gm-Gg: AR+sD106hArSw6vfRdnMyo023hAN7cS0nlpUysAwp/lfk7XWKVfo9lXHxykKhEjBbCA
	5qrX2dO39dWmDqtc5A+rtEfCRQJlGOytP2h2f9n8Rhz5gcG7TXA4qoKzCAq+puenzzMSsZKBFY4
	T6qz0Gbh9Dz0GxpDAblr5wQDFJP/akp0wlG5ZgbUd5LY+geynNeRLKFlblVaT7bGRGwqAuPAp5N
	zwtfgUlRBbct1NmPMvPEHDHAJQXPK6fiGitXcBs4xHPMRy6/eZacnHrifg6Fu98FRTsh0Sd8Ps4
	Eu2CcwflYiRynEZGnvIqfX5IvN4LVPsfL3PRfWQ+AzJzo269Dq1//ESbFaFXZ8eEKbh5nNnOYMZ
	Z1aElCLCiVJ1j6vkl/+DyzXV0utgDIEaghg6feeuC9KEx3BqQiQB/8WVroTHlxq9rEQZhvBUnmD
	GduTOBJ8MnqTzjmAEf0AU9Q0EhrkNH6OFE/Fx3coqi4dArR/9bF+/zhS0Zlnk9fr0HPnF6SlFRW
	lOJDamS
X-Received: by 2002:a05:6a21:e8b:b0:3cb:eb06:ce09 with SMTP id adf61e73a8af0-3cc71de3b98mr15980190637.25.1786816667768;
        Sat, 15 Aug 2026 10:57:47 -0700 (PDT)
Received: from yash-Bravo-15-B5DD.. ([2409:40d4:1248:1816:fcb7:1765:17f9:b9a5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320ea2fcfb8sm17305163eec.21.2026.08.15.10.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 10:57:47 -0700 (PDT)
From: Yash Suthar <yashsuthar983@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	andriy.shevchenko@intel.com,
	yashsuthar983@gmail.com,
	grondon@gmail.com,
	linusw@kernel.org,
	hexlabsecurity@proton.me,
	sakari.ailus@linux.intel.com,
	srinivas.pandruvada@linux.intel.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] iio: accel: bmc150: use DMA-safe buffers for regmap bulk reads
Date: Sat, 15 Aug 2026 23:27:27 +0530
Message-ID: <20260815175728.99541-3-yashsuthar983@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260815175728.99541-1-yashsuthar983@gmail.com>
References: <20260815175728.99541-1-yashsuthar983@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The FIFO and read_raw buffers are passed to regmap bulk/raw reads
,which is not DMA-safe.Moved them into struct bmc150_accel_data
after scan, each aligned to IIO_DMA_MINALIGN.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Yash Suthar <yashsuthar983@gmail.com>
---
 drivers/iio/accel/bmc150-accel-core.c | 14 ++++++--------
 drivers/iio/accel/bmc150-accel.h      |  5 +++++
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 89a475ef9a9b..e8d27fd1be3f 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -125,7 +125,6 @@
 #define BMC150_ACCEL_REG_FIFO_CONFIG0		0x30
 #define BMC150_ACCEL_REG_FIFO_CONFIG1		0x3E
 #define BMC150_ACCEL_REG_FIFO_DATA		0x3F
-#define BMC150_ACCEL_FIFO_LENGTH		32
 
 enum bmc150_accel_axis {
 	AXIS_X,
@@ -622,7 +621,6 @@ static int bmc150_accel_get_axis(struct bmc150_accel_data *data,
 	struct device *dev = regmap_get_device(data->regmap);
 	int ret;
 	int axis = chan->scan_index;
-	__le16 raw_val;
 
 	mutex_lock(&data->mutex);
 	ret = bmc150_accel_set_power_state(data, true);
@@ -632,14 +630,14 @@ static int bmc150_accel_get_axis(struct bmc150_accel_data *data,
 	}
 
 	ret = regmap_bulk_read(data->regmap, BMC150_ACCEL_AXIS_TO_REG(axis),
-			       &raw_val, sizeof(raw_val));
+			       &data->regval, sizeof(data->regval));
 	if (ret < 0) {
 		dev_err(dev, "Error reading axis %d\n", axis);
 		bmc150_accel_set_power_state(data, false);
 		mutex_unlock(&data->mutex);
 		return ret;
 	}
-	*val = sign_extend32(le16_to_cpu(raw_val) >> chan->scan_type.shift,
+	*val = sign_extend32(le16_to_cpu(data->regval) >> chan->scan_type.shift,
 			     chan->scan_type.realbits - 1);
 	ret = bmc150_accel_set_power_state(data, false);
 	mutex_unlock(&data->mutex);
@@ -918,7 +916,7 @@ static int bmc150_accel_set_watermark(struct iio_dev *indio_dev, unsigned val)
  * frame data is discarded.
  */
 static int bmc150_accel_fifo_transfer(struct bmc150_accel_data *data,
-				      char *buffer, int samples)
+				      void *buffer, int samples)
 {
 	struct device *dev = regmap_get_device(data->regmap);
 	int sample_length = 3 * 2;
@@ -941,7 +939,6 @@ static int __bmc150_accel_fifo_flush(struct iio_dev *indio_dev,
 	struct device *dev = regmap_get_device(data->regmap);
 	int ret, i;
 	u8 count;
-	u16 buffer[BMC150_ACCEL_FIFO_LENGTH * 3];
 	int64_t tstamp;
 	uint64_t sample_period;
 	unsigned int val;
@@ -993,7 +990,7 @@ static int __bmc150_accel_fifo_flush(struct iio_dev *indio_dev,
 
 	count = min_t(u8, count, BMC150_ACCEL_FIFO_LENGTH);
 
-	ret = bmc150_accel_fifo_transfer(data, (u8 *)buffer, count);
+	ret = bmc150_accel_fifo_transfer(data, data->fifo_buff, count);
 	if (ret)
 		return ret;
 
@@ -1008,7 +1005,8 @@ static int __bmc150_accel_fifo_flush(struct iio_dev *indio_dev,
 
 		j = 0;
 		iio_for_each_active_channel(indio_dev, bit)
-			memcpy(&data->scan.channels[j++], &buffer[i * 3 + bit],
+			memcpy(&data->scan.channels[j++],
+			       &data->fifo_buff[i * 3 + bit],
 			       sizeof(data->scan.channels[0]));
 
 		iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
diff --git a/drivers/iio/accel/bmc150-accel.h b/drivers/iio/accel/bmc150-accel.h
index 9deff256aed5..8f64b24339e4 100644
--- a/drivers/iio/accel/bmc150-accel.h
+++ b/drivers/iio/accel/bmc150-accel.h
@@ -56,6 +56,8 @@ enum bmc150_accel_trigger_id {
 	BMC150_ACCEL_TRIGGERS,
 };
 
+#define BMC150_ACCEL_FIFO_LENGTH		32
+
 struct bmc150_accel_data {
 	struct regmap *regmap;
 	int irq;
@@ -81,6 +83,9 @@ struct bmc150_accel_data {
 		__le16 channels[3];
 		aligned_s64 ts;
 	} scan __aligned(IIO_DMA_MINALIGN);
+	/* DMA-safe buffers for bulk/raw reads */
+	__le16 fifo_buff[BMC150_ACCEL_FIFO_LENGTH * 3] __aligned(IIO_DMA_MINALIGN);
+	__le16 regval __aligned(IIO_DMA_MINALIGN);
 };
 
 int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
-- 
2.43.0

