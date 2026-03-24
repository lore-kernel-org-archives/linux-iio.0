Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC44A3D8116
	for <linux-iio@vger.kernel.org>; Tue, 24 Mar 2026 08:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774342058; cv=none; b=It6Yrjp82RVeAwQ17r2BuA8mBm6XVac7p5GGd3IJiFurGPHetAp5o4CzZJc2A3hka++YGUuRC+AE5eAFkZkHiNJJqFGsC/+8poMyaHKcu+ceZzJ8HnaQmHJKBIChZAOMyMMpYiAPcYmB2KxYQV9hEVYwxdGJk0k9TnWphdH3txE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774342058; c=relaxed/simple;
	bh=LhhuQW+kXumxf4ZHnfybInW36mhcntwwfWxHRNAL3MI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p8l+TnUJ0SmiaBBNBr2yP7TBRs03lrUm692OYA1BuDV3qkB+aytw4ZoDRCwVSPwOAMfKmaB90wEcMdyGFzZ5mMXeT/0EfAkJjKAyh31SiwQS11yGXsJ5r/xHVzGvQWpoxxDDKRBtO5lp1MSXnvK2vgWmBwmIB84ItJhuBi0tYYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2vag2aFf; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2vag2aFf"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43b7ff8fe92so592924f8f.0
        for <linux-iio@vger.kernel.org>; Tue, 24 Mar 2026 01:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774342055; x=1774946855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D6Ly+Y1OaGrVPqGuh6+YPQYhQbgbR6xEfPk5ktqV5IQ=;
        b=2vag2aFfDgWe2MSYJMaX/FTfJPtLNUnY5FjFHKiPa5MjdQo9Y9IMXJbDCGmwj97OXC
         pLAWLzCf1fYvHz4pc9zwNELSsNw8KWUIsVfceJArYz2Rmffk5hJo16OYB14E76iplX8V
         BcjoSwm+WUFBrgt5ESvPZUO/mA8N0mvzYdXs4eVUj2xNBwbjByq3mCqSlHzM8lvOdyGo
         a/oVdkq40uwjWYVN0wujWk/ADfZ/eahkoufcynX3g58oVVVwFDzn82bg6/SuCcBF3o+K
         Zk1Fv6xwqYdQHUtaCytIEVHwTLkl71ryfrACqV78LTJGDTQ0S069/l65qemHadvpT7Ai
         dhOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774342055; x=1774946855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=D6Ly+Y1OaGrVPqGuh6+YPQYhQbgbR6xEfPk5ktqV5IQ=;
        b=hRfKpc3mU6zm/eSPMYYsLLozk/IxCQKIQLepSoLt2Fmf8najptOtPJq9DKPlR2nadJ
         zFxDLzdhGX1EvbYmAd2g3d9JRTXEcYggKGgp62kOAOpVuSeN6hEPGkc1G1iWceqFstdb
         fL5LNJZPExT2bZvbtRmcMyb6zBYQOTEM1Ol1tI3qbO5Hi4i80CjWdtSurvM2dm4fGUuI
         G8HMOrgdYiNOkghywYYWLGlti9yxzFf20LcLzplXljcq/7rQ4trAXjA3JY31dDdvHMmE
         tbiQLTTTfKI7rUJVDpnsN5xVXEIw4BoBA39dRvH7CMasGrOvQevn0BEoBg7LLnlpuQ4g
         hQXg==
X-Forwarded-Encrypted: i=1; AJvYcCWHA1QseVqus0m6HdFE9hikPKuUuebNpi5ILPCIikWFv3xBXCOt3TCpcsNgS2eUsLiCHujof68yd7w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz246r84YkNQauycc1Jmpk9QmqJkMx8imPMogK4nof8BVrqGbnn
	8sZvKFwxpnjV0+M9aeSaU9waISWFaa2Hj15i4ww6jjcReeZMEoRBTkWFx/tAUZA1uu0=
X-Gm-Gg: ATEYQzxiE/3dn7OvvzKhZPN2JCi786oyFpiD0qEdYUgtTGy5jFVRp6yXO3H8i9KLUM6
	mAUDLnT8EQ+liF16rMwsKVd+zG1tzxsXDvrC8H3fNSWV8Fkzsq9E5T9g4fujaqmbHc6s2Vb6iu8
	+zfvFCyUFD6azU5u8S7Etd3IkguttZHG7PkB9ACtSbbcr0K4wKGrKSXiCwFUA+oT/lM0Ka44NaT
	NbBTx6srx77SX06udE+eOdHNQlq1Y0YLyCpTPbYoXfkUROseUxn2zYUWtC0mah9HzkljKuVIoXR
	6RXWkpEUzBOcso8+7w+NIXck3o2fmVO0zAtNgOu1UYM2RIy7mgP29UhTXkT5u5tdWnS/U1QAxNS
	phNzyS2URBWHYubjjaZeXF7tJ/HooMjoeb5OdX499wwloX0OzyGNvCaj4tIozAAYvwm0=
X-Received: by 2002:a05:600c:c167:b0:486:fb5c:3b20 with SMTP id 5b1f17b1804b1-486fedc39e5mr196391305e9.13.1774342055028;
        Tue, 24 Mar 2026 01:47:35 -0700 (PDT)
Received: from localhost ([151.43.230.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487116f17f3sm31333105e9.1.2026.03.24.01.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 01:47:34 -0700 (PDT)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v9 1/6] iio: imu: st_lsm6dsx: Fix check for invalid samples from FIFO
Date: Tue, 24 Mar 2026 09:47:33 +0100
Message-Id: <20260324084733.653906-1-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260324084655.653781-1-flavra@baylibre.com>
References: <20260324084655.653781-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3896; i=flavra@baylibre.com; h=from:subject; bh=LhhuQW+kXumxf4ZHnfybInW36mhcntwwfWxHRNAL3MI=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpwk+lL3a1po6S4t6UgIXVMNxGsQxe+I2iIBwUl 6sQCXcfE7yJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCacJPpQAKCRDt8TtzzpQ2 X/YpC/wIwu5GGBLlNaWQ+zF2JSZosTWqJ7IQSMY98lF9BVvCHPMKn2kYlHSIRSvhIu7veNsOr/E xV+wuYVF6uQZDHgJCkV3u3T1t7OEHdlQvN1dHf9YGxWCfYcAw1AmhvLktRgHUhJksZZ4p7HYrqh Ds+yEkA5n73knf0JR2XNlSm3JRkii6QXO7i/rvuj9uElv2QhAKRuldoAInaXZQ7K/IRgo3Fq56r NyMB4vUE70ggPzM2drhmucN6k+1uxgjHnMAcDBO6a6gjPbqXF6Tr1KQbwc8crVM4Syyl+e8ONiG +FCbaBtrvcqFJermd1C0YBASiOZhXM0T2hjdpxk5Ln0Mz3QbgS7TmaPquIUNO6CwqWaHaeQLxL2 vADLzOJU5jc5849eap7oabdOtGrm8obxYtCeuVMPCkRusBItUoXlghQkeaAySr0Dmy06H5GtVZh yIM8yayG+bdyURhkHL+u1wgFPITd3yeAwTXgBWu8FVdMCLynEwakfhvetDQz7jaO1n770=
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

