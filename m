Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00FA2C0F7F
	for <linux-iio@vger.kernel.org>; Wed, 25 Feb 2026 10:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772014639; cv=none; b=QuePeXkuSkqcc1qBg33+ZvB8uFlZ5gParrRoejWkqIk/JiGOeXyBKZFPSroswSMn4blbvKQsEa0aa+2FFvJtpTYOy0f6h0rLno+KHcxhWGWE5siISidCWEeA0HxtieCBT3gZgvT25b0l7fqwJh4trzmEMoamIBQQZZXhbgkeDS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772014639; c=relaxed/simple;
	bh=8vSSfk/mqV/Diy8xqYAvuYstYG9PfyLi4Xga/dffatA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hu8mAxhSDipsuEeYCvjePcxrdRI2OqyND58Wz0ePsbNrrO8lhacegYFdPNErL+uL3IJXYxTl1mEtBL6Gr9T9sNDIenKPhGZd45chWXroBrbRRIQzU67aelzJRKy/8BWLBCZxrieLjLgKWqYyAywxn3AgeaY//BD8PwreI4pxKIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XtzOXm+C; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XtzOXm+C"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4837907f535so58500325e9.3
        for <linux-iio@vger.kernel.org>; Wed, 25 Feb 2026 02:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772014636; x=1772619436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oGDK1Bq0ybXWleKDcajfmOxR9UUUs8qs+hjFsjzRODo=;
        b=XtzOXm+CsUo4pt2wQeJ93gjYava25dAKo1rlsIMmoKErnVj/cMjoHyXX2m38i6jqob
         ShhzEyigMM9bAQtpo52YHCbfv7ME5BIy8+Mo6XgkxEEfXXQr0baSK3EaBWuZMmkD5EiW
         QkQROMn1CEnY29V1XzljCY/EHihf7MorZvB3IHVaVfIZjVFdCBiTdwt5ey8uzSivghIo
         vV9/Ku0v4US8tM+T8Y1GzWL1fuB6vOT5xM5BjYEhzmr5Dd2m69ECuErZ8xwt3MLvUoqB
         dCgPLFPHoXe7TYhQGNCYNIuuOWGYwojkJXq9FJgmz+A/BQYXwvjlDCvFf452H3jAeUNg
         SKLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772014636; x=1772619436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oGDK1Bq0ybXWleKDcajfmOxR9UUUs8qs+hjFsjzRODo=;
        b=ehuTBfyxGleBSBZxdyJAyt0lcgsoWcSLyO3QLJv1OM5z6LKFTeG7UyCv4qs5UK/pO+
         e2QUAm+UDg+VgO0HBzXEv0b5kKonU2VFrG6YH1DoRyt2HXCPnRYrNh8CsJdIkIZHpHDR
         nU2v7shkBs+mBuxzmaewofGS5phuGYsA7xfviF34BXYvrENmwBLHouPE1aHFwMICl8r+
         +0GOuStMrSO14dxU6AhRQg9K0jHHwak3QuDM7OjCTSYnOOya1x9ewiRw/+W4gnKSgfVZ
         LAo6eChduIAh8KMULndXCgV9xVhWf9kCVNwcs0bTYwgsIzlfXW8OJ48FNXZ01NOOS6Uc
         Xg9A==
X-Forwarded-Encrypted: i=1; AJvYcCXaRii9xfOjoPq7AMh7hfd+2Lu7MbVFSLA9ea2XEeTm2CKUPoo4ey7hJT1LU5r+8LWJjqsV8ehjVqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAnPvix2Hifxh53lqtp+udw9LmjDQBisYhFsdwhiTOEQd8p0EL
	MTwC2nCVcPcF3VVJl2U5HHAxdiz/amBq+gcpYUSESxqE5+1UGhYZwBUbJa/nZhgfz5w=
X-Gm-Gg: ATEYQzyzXeMYTuJOEjp1zysWJNKyB3v4N1q9yzU0pQo7kp7yyjnhPuB1mO3fRJQfAWh
	943KIrAl1bDZ9+Pt/TkSBUZJ5zqakqajdgSvE3lNY5cpRmGF70R+1Gc/EQyOQ0Xxy8OMaupRY+h
	KmLpDghgwaJygWU1gDQKfHcjDwXUyFk7v7gi1cMrchAK+oI4PFWb/SSnOKR5Q8IPslygEOklX5b
	qlrQTbgxCZkoFeGMaf49qzoE6UC1+oFLl4WYRKbeqpAw743f5ww2p1PFDvRX/zqW0G9CVsTsgRu
	YvymKR0CQIooW2gl0GXELrklGVrC5jXg1F6nWEC8cQd4yn7/stl2fxRB6pgzIc5KfPv5SjXsWvb
	fUPSwgExXf2dyWaiIcBNYLOMPkX4eoUCD+/YSTdpyAihQC/6cnBbkYjZwBCo7HYeJ3Maf/Q==
X-Received: by 2002:a05:600c:6090:b0:480:426e:9d38 with SMTP id 5b1f17b1804b1-483bef5aa31mr32058395e9.27.1772014636068;
        Wed, 25 Feb 2026 02:17:16 -0800 (PST)
Received: from localhost ([151.35.220.155])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd6f19f5sm145273255e9.1.2026.02.25.02.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 02:17:15 -0800 (PST)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/7] iio: imu: st_lsm6dsx: Fix check for invalid samples from FIFO
Date: Wed, 25 Feb 2026 11:17:11 +0100
Message-Id: <20260225101711.2368206-1-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260225100421.2366864-1-flavra@baylibre.com>
References: <20260225100421.2366864-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3692; i=flavra@baylibre.com; h=from:subject; bh=8vSSfk/mqV/Diy8xqYAvuYstYG9PfyLi4Xga/dffatA=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpnswnfn5oXpJpDx0hpSTDM4Sw5hhySnctawLYJ Rj4y1hM/+aJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaZ7MJwAKCRDt8TtzzpQ2 X+2yC/4sBe9Ti6DyUgsh4R9EH5M4vFQfZsYmaei2eO2sODb4uUQUe3M6KalTXlF1fgdNaHGsJ1L HuTbHKtXtUYI8EhBCTbaYdL5Cz2YwFX5McZgfg+EgJm1FQ0bSM9udsiJ6CrusmCbO+5Ql8K3nfL o9JK/pCwv020/cQDIoeBU6hsElQ1vbUbblJcLBY086rH4wRSAqvnoQvFczqLNc7vY2U4HdmKOge b7PutZgkvx0jk6J1s4ffQcqpG1w4oKPUROCWeXKWN1WvcXZzt/kd8nm76i4pHUIzBcXIg0PSJYY EpM3OeZuAlzZX2oobqNOWufowEkkouvZMaSxZafA+Bzt7ncetVLfztmOYcXw4S3S4Neh/CzGx8Z rgGM9o4jFTAxN/7xASKHYEVIOQMxSFKeFwnUL8YSQtCz4E1Z4yTPzoXDPJb9ifDGiuUBhKAX/k0 GrD92617djIy3sU4p80o6WQhjq7YA5AlTNftLKHDsN/Ml+BDZAoWVH9yUqEl9HsKWexmI=
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

