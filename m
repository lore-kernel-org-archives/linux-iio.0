Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47D13E49DE
	for <linux-iio@vger.kernel.org>; Tue, 25 Aug 2026 08:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787647950; cv=none; b=sHR+Jod+zYsH0nVPyz4/BY/CGzvT2JqbXS1+32K9y9G2HVr4VZ/kkgGUC7wbOzyI9biHLWDAJHycxC1AYzQbevaFCaGoFnbvan5U4W8iYa8PBww/cH/4oh8M8RdYIU0iQfoXf1cemPF9/9nuvwhpF5ovUFN+3KtsHjAe5vKK6LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787647950; c=relaxed/simple;
	bh=MwuS9impfger2vse9ZSVY2mpFCX+U2Vi3yKXuzCx+a0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kg90b39Vi6Loz8ShqzKiCU+xLvnqwHmjqOND5Y9JHS8JymeOxEcz12poQKIhErLTGSuFfPiMVp8+lUWOQOfGpjd5PXXlLR293jElQUTv7s2cWeEw+7BO8YX1jtY6i/i2bTYGUR10IAT5B9OcshZMEFnQKxbVAZMuJulyYGVrJQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jrgbtuHC; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrgbtuHC"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3964b061528so747109a91.1
        for <linux-iio@vger.kernel.org>; Tue, 25 Aug 2026 01:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787647948; x=1788252748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s1gRFgntTce8MDNVMMnpHWytndgh7o6BOfxI/dHF7rE=;
        b=jrgbtuHCf/croigKNcPqHt+ZytNOV99PbI6PHLiW9x+NLUCATduU/p45BHMyAWjymG
         fwdl3CEGaBreOJ+D4SWrtnqLI795w8K4cfJ15o0joIH7dKgyrTmyvQkBwjwhQqnwz0B0
         4WZWfIxDjgR20+pqdgJDE6oOPIsUrWkYrOfuWvFDWYS1FaFkiWBTiX1SetZUFEZiRBdf
         1wEWlcfJgKmC2ttSzCCHWlrWsg9QrfQNrzq0ee0OL3KWRVaEsuS5lNxoaPDDcbOMEaWM
         +RZOz0S0uw13cIFmQ5sUivZJE/xgo8qizednHrxPXtBIp+9PowjMn9R/Jgrsj5HMTeko
         Ba7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787647948; x=1788252748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=s1gRFgntTce8MDNVMMnpHWytndgh7o6BOfxI/dHF7rE=;
        b=HiYaIHiGjNfRVrosP9yvmuM+/4J4GcYi0PzR6eYFEaFFLPLPis5Jm9V1YHiKgUHo4Z
         PEY/ioUrcLZpefrvJCCFz6M1KarHE1aUWBdCfqCJpNc8iDePJDMkZRg62RFUWo/Z2lY7
         2JgWFW2cNqxy4LWsOa5GXef3SASeW1XxtenhvpcWEHnq4dvXaVnWyqAj2cIOzUJ/3Ryu
         AJQmoPma+7QBBwIcCTYWp+GGtFRNFl2xnVYvd61kVGu9YDdwjtqh1kKxaX16QWcDZlCz
         cVCOUE9jtKGlKb3M1gwVenE3y4w2kFACozvbBFi8Xz+95TvFAFjj2i3323Bp56Ddr3e/
         zutQ==
X-Forwarded-Encrypted: i=1; AHgh+RoN71oLt1KiKmaUzym/irQ1R2n/xiIHilmJS1kI6iPJYgWxcrio6Ij/h2UPJ4zkEUrnGQhKh+ANFUk=@vger.kernel.org
X-Gm-Message-State: AFuF++lk6rxABlIAuYBzCAuR1QuJahlLamNjlZBlwQfd3Hc82Jym765K
	SEjO8FfCNWeBz7l0rKQfcQRktV4bqNxITNbY95bK/zGb1XqJNBNz51M+
X-Gm-Gg: AR+sD13wL+czPIOYTjtfJDqGEkIcmfcz7Q6YyMKPcEK6g3l7oWTZQB/l9RmMxRr45Jf
	5U3HvmhA5u+4PcDDlKsNs4wL3VLUe2t8Ik1+TdCnAILbZ/1WpM1qYNAcrLF/WjOv9rkqi4jxcJc
	CLG7/hDuA84a9NvjTWplaDwXpGa32pub2zrYintqvzGRXiQ/jk2fxHCEsKJDM3yYZbWp6NV07s+
	QWg0DeAiLhefeWY1tmupaaFyklkLH9uNBgrH8idYtjgLkB1TP5Ufl2+SUolPFDzLE/RvbD/KCwT
	wiS6S5/jcfyMYIzPL/AZnlPGqWIgotr4rQo1IOL4+Zf7/P+X+w+9QiMMdMD9E+eYTJWw8J5/Np3
	xzD4TprIxP4p10DCx7p5bfjUloe/j+wZnqr1+qWm2A0IbLLxFgg8p/DJlWc4PzPzrPA5v3CklNZ
	TkZyXyjrtOfNC5SRVETU5B9fmryVUJEDmMsl4/lpa4YkqQUX/bRBCp1qUZlDXgMOfM3rJ2
X-Received: by 2002:a17:90a:d44d:b0:38f:bbc:6a0f with SMTP id 98e67ed59e1d1-395dee7e2eamr47660577a91.1.1787647947864;
        Tue, 25 Aug 2026 01:52:27 -0700 (PDT)
Received: from shrey-Mi.local ([106.51.251.74])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f90c0a59sm42032202eec.9.2026.08.25.01.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 01:52:27 -0700 (PDT)
From: Yash Suthar <yashsuthar983@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	andriy.shevchenko@intel.com,
	grondon@gmail.com,
	linusw@kernel.org,
	hexlabsecurity@proton.me,
	sakari.ailus@linux.intel.com,
	srinivas.pandruvada@linux.intel.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yash Suthar <yashsuthar983@gmail.com>
Subject: [PATCH v3 2/3] iio: accel: bmc150: use DMA-safe buffers for regmap bulk reads
Date: Tue, 25 Aug 2026 14:21:55 +0530
Message-ID: <20260825085156.212042-3-yashsuthar983@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825085156.212042-1-yashsuthar983@gmail.com>
References: <20260825085156.212042-1-yashsuthar983@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The FIFO and read_raw buffers are passed to regmap bulk/raw reads,
which is not DMA-safe. Moved them into struct bmc150_accel_data
after scan, each buffer are protected by mutex, placing them
after ensure DMA safety.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Yash Suthar <yashsuthar983@gmail.com>
---
 drivers/iio/accel/bmc150-accel-core.c | 14 ++++++--------
 drivers/iio/accel/bmc150-accel.h      |  5 +++++
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 1472e0d1ef65..4c98f840e626 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -125,7 +125,6 @@
 #define BMC150_ACCEL_REG_FIFO_CONFIG0		0x30
 #define BMC150_ACCEL_REG_FIFO_CONFIG1		0x3E
 #define BMC150_ACCEL_REG_FIFO_DATA		0x3F
-#define BMC150_ACCEL_FIFO_LENGTH		32
 
 enum bmc150_accel_axis {
 	AXIS_X,
@@ -621,7 +620,6 @@ static int bmc150_accel_get_axis(struct bmc150_accel_data *data,
 	struct device *dev = regmap_get_device(data->regmap);
 	int ret;
 	int axis = chan->scan_index;
-	__le16 raw_val;
 
 	mutex_lock(&data->mutex);
 	ret = bmc150_accel_set_power_state(data, true);
@@ -631,14 +629,14 @@ static int bmc150_accel_get_axis(struct bmc150_accel_data *data,
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
@@ -917,7 +915,7 @@ static int bmc150_accel_set_watermark(struct iio_dev *indio_dev, unsigned val)
  * frame data is discarded.
  */
 static int bmc150_accel_fifo_transfer(struct bmc150_accel_data *data,
-				      char *buffer, int samples)
+				      void *buffer, int samples)
 {
 	struct device *dev = regmap_get_device(data->regmap);
 	int sample_length = 3 * 2;
@@ -940,7 +938,6 @@ static int __bmc150_accel_fifo_flush(struct iio_dev *indio_dev,
 	struct device *dev = regmap_get_device(data->regmap);
 	int ret, i;
 	u8 count;
-	u16 buffer[BMC150_ACCEL_FIFO_LENGTH * 3];
 	int64_t tstamp;
 	uint64_t sample_period;
 	unsigned int val;
@@ -992,7 +989,7 @@ static int __bmc150_accel_fifo_flush(struct iio_dev *indio_dev,
 
 	count = min_t(u8, count, BMC150_ACCEL_FIFO_LENGTH);
 
-	ret = bmc150_accel_fifo_transfer(data, (u8 *)buffer, count);
+	ret = bmc150_accel_fifo_transfer(data, data->fifo_buff, count);
 	if (ret)
 		return ret;
 
@@ -1007,7 +1004,8 @@ static int __bmc150_accel_fifo_flush(struct iio_dev *indio_dev,
 
 		j = 0;
 		iio_for_each_active_channel(indio_dev, bit)
-			memcpy(&data->scan.channels[j++], &buffer[i * 3 + bit],
+			memcpy(&data->scan.channels[j++],
+			       &data->fifo_buff[i * 3 + bit],
 			       sizeof(data->scan.channels[0]));
 
 		iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
diff --git a/drivers/iio/accel/bmc150-accel.h b/drivers/iio/accel/bmc150-accel.h
index 9deff256aed5..40f9d25a3d4e 100644
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
+	__le16 fifo_buff[BMC150_ACCEL_FIFO_LENGTH * 3];
+	__le16 regval;
 };
 
 int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
-- 
2.43.0

