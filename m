Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6383E9F77
	for <linux-iio@vger.kernel.org>; Tue, 17 Mar 2026 15:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773759837; cv=none; b=BOCRU0SMl67tuJgHIsZ+rsr083XKHpRtntOb3xHlDkmIoNBmajewwzeQZz64wglbrEaHVYwMSSWQoWo1GvEpWVh/lIv+dJazWuLaP6owAGMw+MZhF4u2Zfe9dO4QHa1+NsvXCde9m9stfs5Uhahw3+YIkvxkuNIQBRwTab3bMSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773759837; c=relaxed/simple;
	bh=LhhuQW+kXumxf4ZHnfybInW36mhcntwwfWxHRNAL3MI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GX3Bt1a6/oSp1tQL9yacSgdGAVD7IZJgyqGjxhU+qL2Bls+jVeGWcJag932spxA59z/bc8IIVHe53l3BO6jJsbVkqghFl6BU19hoH0n2u3AICbUNrwbSg1iMA+zLS6VZzOd4E221LK3GpQbQraVyoaKmaqDKjFDzUbv79F1jFBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=PEt4xb8b; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PEt4xb8b"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso52280355e9.1
        for <linux-iio@vger.kernel.org>; Tue, 17 Mar 2026 08:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773759834; x=1774364634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D6Ly+Y1OaGrVPqGuh6+YPQYhQbgbR6xEfPk5ktqV5IQ=;
        b=PEt4xb8bTBmjG8/yiQqWtWbhlqRlleg5cuuPH4tW3mNdQ9lGjqiB5f34TGWOQMEpKU
         UraYsoxowHUnVWE/0IlxbDAD4yoVA7F+jIkzBHqYdqmMslWFndRXK/T/VkvIjyvOkndS
         1VIX2jqTd1gT/Bqu0tXZ6/UjalIh4soy0LPncQnt7i78Mwx+XT9zmGS1zt16nLmU6NBB
         5cdWF/H6VafobRLAt81RjL8RNpf2Stq43qBIXNkGg0/Rmf811LoaeSCOC+lnl+JXahUo
         B3JfWnwVzqIlSzF+ap7M2KLpisfOAW1XBEPxNvRllBOsELeKRqIMmFBPcUHFb+sziK+y
         2ZcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773759834; x=1774364634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=D6Ly+Y1OaGrVPqGuh6+YPQYhQbgbR6xEfPk5ktqV5IQ=;
        b=AG94QunuYu2YEtLwJiuovS2JpVH8srKYKSBuGJb3+ZqPdmbJnIfux6RBtJMM7VlX71
         lH1lWeg3sBmySmwuzYeM0N8cIqJc528fVBioPBBxSdwpg5zSyX/v+Asrvy35plADxoqJ
         fc2jIatStSDDMH7IOgAn88ppnF2D6BzijpOC1fwjB2nLkKLaW6kReQfoKr/WJlcre5uL
         TtiDqzevYLW/1suLWOiZVtYuJDfnO8/xNRIOr4xYwlQy5/2jImN2sLHxSVPmvsEzi3Yr
         enYLFdQd5yOL9trp4+DJUf8UAqQTbev566Vtx4kE4k0BjfG4W4i8/7tscgr2FdNJrt1x
         UIAA==
X-Forwarded-Encrypted: i=1; AJvYcCWsqJooFHm2N3msiCkFuGZXMJFt/caLi7QW8F4bVN5T+Yjr1Pv9AB3aQV7CfdfjdVmTwJkppYSTY+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPcsO2CC8avOB/FEVeoKVTY4n8AIwHhWCZ/UF2qhRYsy/yIT5y
	vVLnRcSm+oh8fd8dDJ9HSQYK9L7Xunz0f/k9KH+70KIPo57GxLeN0ctNNiT9+lQdyxA=
X-Gm-Gg: ATEYQzyh5RJ4f2BmTHJv8nB8V51z1lQ7P+LpocYiAWqPqJwYCYBeXB3hxCtWRFv8XUQ
	+C8RfV+sZdZfSJOf2fNENkQJ2l9TVy58WsXuCPvXydMz8k2G5Vfnj3bcUXe3EuVs7MDb4W3aIlF
	pdNh6gcRYZR2TOlA3lny1Uhr0qKjbePE5aCW7vx4kekYTD1SixLmMetajDtZ1RGOWoGl7QrDXrY
	v9lr79hlbpsskbL3WLvD2AA74e58QWjWggHrU14B5V2EC+gG68tQMDCAApZFCTkjKzbZOcYMvBn
	IuX+qN7K7HKVY/ZsbwsUOWZMHDsjFFF+ZoxGKJ8W4EExXHtiKUOH/iOPLUqLr6iNpvjUwGGYawV
	KikHEu9nn9plSPZ0glAhMVonEcHpY3/AKocfRri9e7kWJ8ZEBLbaKfjDoV9JuWDbqGCNfGPS/RA
	lw33ns
X-Received: by 2002:a05:600c:c8d:b0:486:de04:5906 with SMTP id 5b1f17b1804b1-486de045a22mr27707715e9.19.1773759834477;
        Tue, 17 Mar 2026 08:03:54 -0700 (PDT)
Received: from localhost ([151.37.101.237])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48634a7ac93sm51971735e9.2.2026.03.17.08.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 08:03:53 -0700 (PDT)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 1/6] iio: imu: st_lsm6dsx: Fix check for invalid samples from FIFO
Date: Tue, 17 Mar 2026 16:03:53 +0100
Message-Id: <20260317150353.3878258-1-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260317150316.3878107-1-flavra@baylibre.com>
References: <20260317150316.3878107-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3896; i=flavra@baylibre.com; h=from:subject; bh=LhhuQW+kXumxf4ZHnfybInW36mhcntwwfWxHRNAL3MI=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpuW1ZL3a1po6S4t6UgIXVMNxGsQxe+I2iIBwUl 6sQCXcfE7yJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCabltWQAKCRDt8TtzzpQ2 X1J/DACyD4pzkSXnCGT5iq86Iumn+gkCFDC3Pr9/8KiY6RtBNBRXV0Lo1jKtM0nfoTfr6jOddm5 3oHlr8qpqd8tdfuywK2UVpeYjhx8+eggCUizNtoJSNzAsTXjWSOxRcGSxK2kusKOWGHhc9H+UlB biQffbicZ6+L9j09cOvI4MNbMphHBiuub8QvDMXXzwiezy6FblGoRdKKTUkfSPcwrUqYuP8FdxT aYRtOPDYgH5D9KvXage+7hqGu2iZZ0QAp8ERB3xzRDyQ0Ov/NeVlVtZNfWRymI/llgJDXlCMk6w 80FjomauvE8v6nK7WohfLgXoEygwHIa6q9E3WEPZbyQdQnTLOZ3aBiJtdqoQtYX78T+vfT/Iixr eloR4uYJc7arn7OZ0xMWMDKVIhzUM8rBnY8J4yBitHS99hLDhyg6SktlRnSs9kVAk4Kv6AnCraJ m2eMWcvp6bTiXjxzNVtfeZn8/zdOPt6Vk6X7zJOfA7Q/CDQ23THXC24zQU4D5F3zC080M=
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
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    | 31 +++++++++++++------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index 5b28a3ffcc3d..19232146bd61 100644
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
@@ -537,16 +535,24 @@ int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
 }
 
 #define ST_LSM6DSX_INVALID_SAMPLE	0x7ffd
+static bool st_lsm6dsx_check_data(u8 tag, __le16 *data)
+{
+	if ((tag == ST_LSM6DSX_GYRO_TAG || tag == ST_LSM6DSX_ACC_TAG) &&
+	    (s16)le16_to_cpup(data) >= ST_LSM6DSX_INVALID_SAMPLE)
+		return false;
+
+	return true;
+}
+
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
+	if (!st_lsm6dsx_check_data(tag, data))
 		return -EINVAL;
 
 	/*
@@ -609,7 +615,13 @@ int st_lsm6dsx_read_tagged_fifo(struct st_lsm6dsx_hw *hw)
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
@@ -648,7 +660,7 @@ int st_lsm6dsx_read_tagged_fifo(struct st_lsm6dsx_hw *hw)
 
 		for (i = 0; i < pattern_len;
 		     i += ST_LSM6DSX_TAGGED_SAMPLE_SIZE) {
-			memcpy(iio_buff, &hw->buff[i + ST_LSM6DSX_TAG_SIZE],
+			memcpy(&iio_buff, &hw->buff[i + ST_LSM6DSX_TAG_SIZE],
 			       ST_LSM6DSX_SAMPLE_SIZE);
 
 			tag = hw->buff[i] >> 3;
@@ -659,7 +671,7 @@ int st_lsm6dsx_read_tagged_fifo(struct st_lsm6dsx_hw *hw)
 				 * B0 = ts[7:0], B1 = ts[15:8], B2 = ts[23:16],
 				 * B3 = ts[31:24]
 				 */
-				ts = le32_to_cpu(*((__le32 *)iio_buff));
+				ts = le32_to_cpu(iio_buff.fifo_ts);
 				/*
 				 * check if hw timestamp engine is going to
 				 * reset (the sensor generates an interrupt
@@ -670,7 +682,8 @@ int st_lsm6dsx_read_tagged_fifo(struct st_lsm6dsx_hw *hw)
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

