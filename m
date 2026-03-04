Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FF12D949B
	for <linux-iio@vger.kernel.org>; Wed,  4 Mar 2026 08:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772611564; cv=none; b=JHtvBRwQ10O44+CAPyKO7rw2ZgW2rT+etOz9hKHJwka98bM6+flKGBKtWbWNe+VBGLtyMD/IlXYgORTxc162erFd/VMOT5BkND/fRKVcYvOVzx+tP3304UqZWvA6odkP+qlTHqi+oEfi+s8QB0U6xKmUA1LMHzRbbWj1ZFqVsYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772611564; c=relaxed/simple;
	bh=8vSSfk/mqV/Diy8xqYAvuYstYG9PfyLi4Xga/dffatA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ht5miCf+rNiKNMivCxCqdPIWasYzjwU8BFA+VtOZJx7FSG/WXcWLSGZnvLhCXyw5mSLRUYFhYRmnPvFKusmc1lua1qPUVwa2HO+tspQBbiN2o04fBgC0rcGCyOltH0M3MIItPpyzLaq10H9OfpGysqvg++FCxA8qLMbaG9Q3PZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=PBN6bi+y; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PBN6bi+y"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48373a4bca3so40063425e9.0
        for <linux-iio@vger.kernel.org>; Wed, 04 Mar 2026 00:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772611562; x=1773216362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oGDK1Bq0ybXWleKDcajfmOxR9UUUs8qs+hjFsjzRODo=;
        b=PBN6bi+yMi6otpkTa1iWhLRPrHuqmjROttuG8WwMjzaprZnYP34MmRs0Mm7w3kiTn1
         lYQyGeNHdNZ7YS0cklc62mrLiO4e2KOU7Xcik94jjQMVuapa6REOvDGFShJVuHNediNI
         /EvinsMO56Sb5bRv5S671751Qf9pV/abnZtpbEVkKcu6PQA+wRjWYBA0Jm24JI51RVGZ
         X7k42TPSrg/zp9R8iZm+M8BccGX8+S654p48bRTGMId1yWDUj6bgb+YLPyvN/9T++dqj
         lH6/Gi/Qa59oC843dI/hBR2Jp9iWee8QXfcgonYgEVwsQGDSXH2uRpSQoVGpXLBHc9YY
         0m2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772611562; x=1773216362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oGDK1Bq0ybXWleKDcajfmOxR9UUUs8qs+hjFsjzRODo=;
        b=QgRcgo0rPTlrVbgBOhymDkpcLTkpl0JThdYZxPxAo2214JQUzhT5XLr/CdmzmC+lNS
         WyUo7CI44xJyoN6OUUpxSNs9t/tLyEzDWmlo8CsIDTDdS+kpIuRHAKcM1h/nFm7kmZz+
         BANSo1vq+PE/a7oK5nOkePMoq3J8BDtdgXBf7VtWFi6/8fi2/nguOukjzP/8Svp6kldm
         rsFtlX8FMaMuSXhjCiAOC1sPKzkc2h8EwzcriS+xIQWPom4tCsN6W4bzBv1XF1GtzG/4
         g0l2DXOL8gEItcJHkQyvn7fdvmgSWmtTKWX2uBESZEAU1oNSGSLm+R5A0+iP9lEw/SnM
         yTyQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0amoxNqL8GRk4qqBrE0rT8lFA/37F6ZQYbTMkWJlknZAmjweisRX4yEOSypTfQmMR03ecM4/fbqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS2RdFJXoycG0gHnYMX7wEaluKPtUCmJFOXr0BuZqfmH3hVRgg
	p4EBklQRV0Vx1+c3oPuUjuV5mTSINZrwUIMkJVk9+S7vQx31v/iVEO6YojVsWZHPjfd2OBF1cBm
	Vh3NRqUQ=
X-Gm-Gg: ATEYQzyCcY4PWeA3z/h67ksgovOXPTzBzXxlHBL2sq6QaA2T+LePLomTzOZBYVffXph
	VhK4LAw1h3X+EyMAM3TUTXN0/rcR/2PhIxzqw/5VAxGHmrmcRObRpNLNDp2mE4Knqrw770RZUY7
	3V73AOk7PYh9co5ex2bsId3kNVy1bOmC8tEIHFaUwQjREaMdmHTGr6RcCtJt/xfm1O6u2DvTsSD
	DN6zCQqoN9jKXuGQPOpbI7aJzhKsV10uqUY+8UMd82WiRYDtL7XDWsozQn9Ew4AH1FANSCuyov2
	VZ71tQ/BK/kAsHxk7kR6pttYeYXgybWjgx4FxkjrYyeoTCo7Y6GBEpEJe9eyJd0arUhzOFWlxkI
	ritlINgJ4LS5wfyC3pafCy6HzD4gTIUOMvIT6BVnV28Ofw8WQiPkikqvVJ18vTNXvTFcr
X-Received: by 2002:a05:600c:4fc9:b0:471:1765:839c with SMTP id 5b1f17b1804b1-4851986eff6mr14795685e9.20.1772611561838;
        Wed, 04 Mar 2026 00:06:01 -0800 (PST)
Received: from localhost ([151.19.177.89])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851883a012sm64697625e9.3.2026.03.04.00.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 00:06:01 -0800 (PST)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 1/6] iio: imu: st_lsm6dsx: Fix check for invalid samples from FIFO
Date: Wed,  4 Mar 2026 09:06:00 +0100
Message-Id: <20260304080600.2844267-1-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260304080519.2844101-1-flavra@baylibre.com>
References: <20260304080519.2844101-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3692; i=flavra@baylibre.com; h=from:subject; bh=8vSSfk/mqV/Diy8xqYAvuYstYG9PfyLi4Xga/dffatA=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpp+fofn5oXpJpDx0hpSTDM4Sw5hhySnctawLYJ Rj4y1hM/+aJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaafn6AAKCRDt8TtzzpQ2 XxtDC/sHNqQxlIUz/V1r2lRsfTwpuGSACKMas3mZHZjObvAtV8D0Ga5LYF8qjCcvhv+hCxBZqmQ nVrVGO9Kjvi47IYechGHmL33jvOPYCHaKZfCSqdDpXcHA6lVs0MmswPm5T1Jtiehd2r8Nqz7uOr QixqryE28gbOxU1hB3ahYaLA5eoQy3o2UMMZgkgoFqWO/KoprBAq/SCo6jD9o5pZkphwscrOEmL eJMMxgDAh8B9j7nGTl6a8K//2C2gl6iZfPIGku0x5zNKFXuzQnI1amjEig8oHmrCoyns/q6ZNVL bXDlIAI7f+E/FwVnF4JQamHlQlscoR0Oar0ZRHNtLKZcYuwxD+g8JlIhds3fZPaaP9MQ0ts8qQ7 azjDkq+EjljTxDw71TfNyZayVRaHAdkW3iMXZ/Rs18cD5Sty7vRwzVShHvGAAnVCDCDjySx3vNi SJWDmJFcmvLnfyJC3YSMwqzG6Ns8FrKG7OHRVRf8NSv5oMZUcscoUZCrUrZWlayNn2BWA=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

The DRDY_MASK feature implemented in sensor chips marks gyroscope and
accelerometer invalid samples (i.e. samples that have been acquired during
the settling time of sensor filters) with the special values 0x7FFFh,
0x7FFE, and 0x7FFD.
The driver checks FIFO samples against these special values in order to
discard invalid samples; however, it does the check regardless of the type
of samples being processed, whereas this feature is specific to gyroscope
and accelerometer data. This could cause valid samples to be discarded.

Fix the above check so that it takes into account the type of samples being
processed. To avoid casting to __le16 * when checking sample values, clean
up the type representation for data read from the FIFO.

Fixes: 960506ed2c69 ("iio: imu: st_lsm6dsx: enable drdy-mask if available")
Signed-off-by: Francesco Lavra <flavra@baylibre.com>
---
 .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    | 23 +++++++++++--------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index 5b28a3ffcc3d..a6ee2da5a06c 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -365,8 +365,6 @@ static inline int st_lsm6dsx_read_block(struct st_lsm6dsx_hw *hw, u8 addr,
 	return 0;
 }
 
-#define ST_LSM6DSX_IIO_BUFF_SIZE	(ALIGN(ST_LSM6DSX_SAMPLE_SIZE, \
-					       sizeof(s64)) + sizeof(s64))
 /**
  * st_lsm6dsx_read_fifo() - hw FIFO read routine
  * @hw: Pointer to instance of struct st_lsm6dsx_hw.
@@ -539,14 +537,14 @@ int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
 #define ST_LSM6DSX_INVALID_SAMPLE	0x7ffd
 static int
 st_lsm6dsx_push_tagged_data(struct st_lsm6dsx_hw *hw, u8 tag,
-			    u8 *data, s64 ts)
+			    __le16 *data, s64 ts)
 {
-	s16 val = le16_to_cpu(*(__le16 *)data);
 	struct st_lsm6dsx_sensor *sensor;
 	struct iio_dev *iio_dev;
 
 	/* invalid sample during bootstrap phase */
-	if (val >= ST_LSM6DSX_INVALID_SAMPLE)
+	if ((tag == ST_LSM6DSX_GYRO_TAG || tag == ST_LSM6DSX_ACC_TAG) &&
+	    (s16)le16_to_cpup(data) >= ST_LSM6DSX_INVALID_SAMPLE)
 		return -EINVAL;
 
 	/*
@@ -609,7 +607,13 @@ int st_lsm6dsx_read_tagged_fifo(struct st_lsm6dsx_hw *hw)
 	 * must be passed a buffer that is aligned to 8 bytes so
 	 * as to allow insertion of a naturally aligned timestamp.
 	 */
-	u8 iio_buff[ST_LSM6DSX_IIO_BUFF_SIZE] __aligned(8);
+	struct {
+		union {
+			__le16 data[3];
+			__le32 fifo_ts;
+		};
+		aligned_s64 timestamp;
+	} iio_buff = { };
 	u8 tag;
 	bool reset_ts = false;
 	int i, err, read_len;
@@ -648,7 +652,7 @@ int st_lsm6dsx_read_tagged_fifo(struct st_lsm6dsx_hw *hw)
 
 		for (i = 0; i < pattern_len;
 		     i += ST_LSM6DSX_TAGGED_SAMPLE_SIZE) {
-			memcpy(iio_buff, &hw->buff[i + ST_LSM6DSX_TAG_SIZE],
+			memcpy(&iio_buff, &hw->buff[i + ST_LSM6DSX_TAG_SIZE],
 			       ST_LSM6DSX_SAMPLE_SIZE);
 
 			tag = hw->buff[i] >> 3;
@@ -659,7 +663,7 @@ int st_lsm6dsx_read_tagged_fifo(struct st_lsm6dsx_hw *hw)
 				 * B0 = ts[7:0], B1 = ts[15:8], B2 = ts[23:16],
 				 * B3 = ts[31:24]
 				 */
-				ts = le32_to_cpu(*((__le32 *)iio_buff));
+				ts = le32_to_cpu(iio_buff.fifo_ts);
 				/*
 				 * check if hw timestamp engine is going to
 				 * reset (the sensor generates an interrupt
@@ -670,7 +674,8 @@ int st_lsm6dsx_read_tagged_fifo(struct st_lsm6dsx_hw *hw)
 					reset_ts = true;
 				ts *= hw->ts_gain;
 			} else {
-				st_lsm6dsx_push_tagged_data(hw, tag, iio_buff,
+				st_lsm6dsx_push_tagged_data(hw, tag,
+							    iio_buff.data,
 							    ts);
 			}
 		}
-- 
2.39.5

