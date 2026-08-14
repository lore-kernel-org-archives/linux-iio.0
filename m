Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E651545A284
	for <linux-iio@vger.kernel.org>; Fri, 14 Aug 2026 10:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786702759; cv=none; b=Yw2DQYHKYLx9E4XJCVa+4jSUEzfQj4ERwEEYINvx3WTmEWoj4LftZGdasxWkHY378HTWqRXIQRSLYiQzUVqu5IweU39uumiRu9rAtTDPR/qpFZ79NE7BtEzPeKSe3S6qBtQZu88GTZ8SC7kTPvfHinBsJQz/U/7pcY8FHMgoWbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786702759; c=relaxed/simple;
	bh=N1zYGwn3lS/lHxK27p6fiV8lb49hdDwVYs4y5wTr/U0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pSnCHvmOPoagrYyYqZz5MvdJeUzU1KoIlY7JNBMpauvO6KOvkfgftFsDVAy3dxNTF4DGMZ4AW23GT03tOK1vGY7snZ7wIVGEmzI1WbnwvXovFOYNlywFKjnlkpe2bBhQaiZ+bMuhM+N28cb3F0aqt1N7MU3Fdy5d/VJRGIkPwlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CkGgzrm7; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CkGgzrm7"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38759bcd877so986490a91.2
        for <linux-iio@vger.kernel.org>; Fri, 14 Aug 2026 03:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786702743; x=1787307543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4LB4D7prrJKar32PuQlOy+F4uxxxhz/ejXYg/JbcjVI=;
        b=CkGgzrm7IL7n37A8aWp25Y6V2Uc8Mf/z2F156geP5IxWO7vC9RWtr6732AeD2fsqit
         git8+HN9lG3PaXeDaOdb8cUeSD/3x87zwR6P5+gEUaMSw+/SPtFCQ/GVRe/cINkmrsc/
         d/Uwfmxw+aop1rETYHQbN0Wd7Ls7IQ5mY6D6sWnlyu8VAUjvPu+EpjiiiyVYQy9bxMJ2
         PnvULt+fni7Qbr4wWwrZuOSuAwCnJnv7etjKXF7rq3rRvSUodcaeF2m234VTXQCdLsSs
         vR49e2lsi/LcmdwM56Y9B6ebWCmC+54jFv4t4dIScYAdNGDIbFjvwn0AGa6rjmCJftoN
         Zn+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786702743; x=1787307543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4LB4D7prrJKar32PuQlOy+F4uxxxhz/ejXYg/JbcjVI=;
        b=l5FMkr7o5+qO5g93mV3RDk4e4Wg/PRGPq/gcHNKlekrHYq7qYpd5kNtWkJx/mU+RSr
         zapdgZ7JAHNEBPElgkZ88N8XmfAAPoumTBrwdIaRd+mUO5GwjN1rHS0Koc1HazZO2I7R
         q9Go2sTY2xU8UymAY1ZLEoTeM0/x/DAoe+5H13w++bZpLid94TMf5vnAMMIW1oOH4Za6
         cJQDKaObEn788XsNb9ZVHsYBTD2F5y/m+Dfqg4njE2qhPBLOCFvWquQfYUilR5YfOd5z
         WyGM8biGqFdc5ZuuVmgE9zBPE6b+6SK0MRgNC5vSakMoXFwhIn3MzfVGxsqbGFtULWGf
         oPwQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp5Lo+TlKqgxQJKlyDiIff071QWm2IxmBrhy31LoBiaYPOIv12kq6WryIaQ6phCnScO5JcIGBKHaUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP/zF08QAE75yuH8esplouvrNTBXkoQjtI5Di66AiowWgASw/s
	/d8vx5sIDCglfV0y5lPzG9Z1WHpPxxDM54/11Fo6jftC4wYHVN2zEh/g
X-Gm-Gg: AR+sD11R3u4tNyvDrpg/j0vZbEn+4RWmQ9rAWefde6gJ9YZoaptArl/Kd4K/wS7duSs
	m612m49e4gn/s72rv9dVQhft6IAkvTp4CisMMgYd5SOCIQuaTibW6fViYJ/7BDsZlLR1sFgB2Ru
	vmDh5y0X4W0ZmKv8kZ+o1OtN7SJUY/mpF0F6fn383PD4wwsRo2nexnTxg9W/soxVeFD3WCQ1RdD
	p5/zdEsxL8WxWYcbyCutivhBtb9wp6O8YUGuuqI3ObtEMQVFb13551IRteFZtDpRgb1Md87YlfP
	2lSq12K6uBmFgL29PVaRDKYAAbLfGhAnAMPahgugPhn4NsDEt6OlHz7AEhD1ZBQM7YLGBM7JqCo
	X3kJkUSIVsFnzOJcu8fCt19B9f4qQsYPgR7H0I11ejbdbWPHtdYsm/CU4LSzKjB/+wJVjuGz/cE
	Ux0lYwvObvqCaCgTYRBEnFpx+37fYyBAQvysGNU8s7nOG5dEpwvoK052jR2NUEn9khWPOn01lwp
	B+/qu+d
X-Received: by 2002:a17:90a:d006:b0:38e:75f3:ad4d with SMTP id 98e67ed59e1d1-3933cae6243mr5172951a91.7.1786702742910;
        Fri, 14 Aug 2026 03:19:02 -0700 (PDT)
Received: from yash-Bravo-15-B5DD.. ([2409:40d4:124c:2e49:6997:3d3f:909e:c279])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-394e920ba18sm2074218a91.0.2026.08.14.03.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 03:19:02 -0700 (PDT)
From: Yash Suthar <yashsuthar983@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	yashsuthar983@gmail.com,
	grondon@gmail.com,
	linusw@kernel.org,
	hexlabsecurity@proton.me,
	sakari.ailus@linux.intel.com,
	srinivas.pandruvada@linux.intel.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] iio: accel: bmc150: use DMA-safe buffers for regmap bulk reads
Date: Fri, 14 Aug 2026 15:48:43 +0530
Message-ID: <20260814101845.301769-3-yashsuthar983@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260814101845.301769-1-yashsuthar983@gmail.com>
References: <20260814101845.301769-1-yashsuthar983@gmail.com>
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
 drivers/iio/accel/bmc150-accel.h      |  6 ++++++
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 596ff8267ead..30d91d417ac4 100644
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
index 9deff256aed5..a1734f5d30a4 100644
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
@@ -81,6 +83,10 @@ struct bmc150_accel_data {
 		__le16 channels[3];
 		aligned_s64 ts;
 	} scan __aligned(IIO_DMA_MINALIGN);
+	/* DMA-safe buffers for bulk/raw reads */
+	__le16 fifo_buff[BMC150_ACCEL_FIFO_LENGTH * 3]
+		__aligned(IIO_DMA_MINALIGN);
+	__le16 regval __aligned(IIO_DMA_MINALIGN);
 };
 
 int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
-- 
2.43.0

