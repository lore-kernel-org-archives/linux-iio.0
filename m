Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042213E4E99
	for <linux-iio@vger.kernel.org>; Thu, 22 Jan 2026 16:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769099036; cv=none; b=SEBEh5cI6xjrTm7+6avFeV3gQ3bvprC0c8ejPXHg7CEwcCNiGUL3qYZ+ypD7kSUZQQ/TchUkMbEcismlmaaH7OX9tmFkqLazqvMtunOySLbhSouHM+q/OFleEsIo/gRKmdceLYuUzTGC1E/EdHl2oPEyddUbtaW7vK8cmr2bOx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769099036; c=relaxed/simple;
	bh=PfmODYCm5rMmK7m/DHbR719NzpB5H2VEDNy6yDKy03s=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BwbjoDjI6wjgEw+3YKZXdBCXoYBgU29GUO128tWtzy+nKKU7WbGUtPWC8DpLNpYjX0XVRSKxKUQj+L7edJ1XsP4JIH+g75yKABKAP7T8UcZGb/SP+x0YCIN6SgPOcZ/js9qwmTkgGmgI0Z0NDeFzInQNiHT5/nAhOJXbYTcC254=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=1VH1iz/d; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1VH1iz/d"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47ff94b46afso10187215e9.1
        for <linux-iio@vger.kernel.org>; Thu, 22 Jan 2026 08:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769099020; x=1769703820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zl/f9Vr/KBTc2N5tZDEA6huhuIWhhr6+cS2Ujvjr4tM=;
        b=1VH1iz/dSJU9HzBxWfaymK0UBvO4d2Sv/Gjof+A0gFJLfgJd8RJnrWqo08fmM26U01
         h6Q777fKIMTDCjj3E+Dcm0GpriYO9AE7JM+ZaEJv5pQ3hk/dj182Lc1hodFbC7iFRVMW
         /2AP3fy1sCkwQ8UK0yS3+Qt5Iwo24R0y4ZVwbVivQYFHMh4jP40nfMGMHyXL6O/c1HMs
         9Kv0OQbd8oN9buvz4AgiBnNlCJluaza9NK1YYIUrdJVBfw/2qJirM2o4r55TjOkptAai
         A/3/Y4MhU3aebn9BHPkxqSGTNvk6ba9LZ4rM61fP30S7D938iNvYQAHBNT65filQsMXT
         abMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769099020; x=1769703820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Zl/f9Vr/KBTc2N5tZDEA6huhuIWhhr6+cS2Ujvjr4tM=;
        b=em+JjhKujXV/hZdxeuS3JqKdIdLXO3W0IpiBxihOnogI06cw5yRoDIoY3Qgbns//yn
         UzD4ANOPdVjhbKeIDwv1dwBXkivMILWGdyOrGIT6rg5zRAx4uyLtaSKwrZQsYAyEcwn9
         19szNpv/Qr2XoLGa6W/2o+TM0CvVbj6Cl7jDBFx5A/+Lr2p41GnQnbYYGl/TfMiV/Vs/
         z4FY+AUVRmAKOL+f0RUEBhfKZoKL4mwGEK4RjncBsl8UD/x5npRYfv5U0r2dPQK2262P
         nCmj7jYad+HL0vsoPS1LhM9GHbFgV/uD6za3jdrXNOSf1c883QXdTA4FC0Ap0PVPwkIt
         xWoQ==
X-Forwarded-Encrypted: i=1; AJvYcCU49FvUvz2+51hQ0aPo9rd/PAZkkhTbH2LGIF98z0cCcn/WAgCtRGwkqpoa2WzPPX2kFkE1Ofl4W8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIoEnYS9/Z/1eZEE+/xj6Ty3XhouhO8RnEQETr+xIwShh047Ah
	tNJ/HqEafOQT5vziYKkfCoOdAx/guzFPMN4yCNLa9WrTuzh7kYe8yM4nRSu4C5LPK4M=
X-Gm-Gg: AZuq6aIpUHw2MIGTWpWY8DyoQcEdvQa06GMHuQ/t/QZ+Fi3Y/6DFR12z2imCmv5Qd9h
	BEVxMZzEWgAivtHb7PGxbgYe3fMoa98dND2NCT3uMXnB30k7tV/s309bkhTCcf6X9PcfnUbSHpB
	IA694SNzU+zk//nt8yzoDtlLAexqTqTd3pfBxKpgD45CB9mzhr6ac8JYPaGgXFhTRM/wEsQKlCS
	L3NqPkaF8reMrQ7Rpzgr2vz8foC7rXVl6sIwfAFG+xbViEmNe3Yhlmu4vOSQblwlOf6hoNph/Gt
	H8TwHoFQcREtag3bIHTvSEQ+KGqqqu1Ayji0g3NpYPAhSY+E+6y2MWeG5HsX/RiWJaHneeGvQRh
	pOTavp80a6UhuEnVu9gHxs9yy8JrpUQfEAWaEoUr+CUGeRpo9mMTL0MLQlA==
X-Received: by 2002:a05:600c:1f8f:b0:479:1348:c63e with SMTP id 5b1f17b1804b1-480470829c1mr55210245e9.9.1769099020474;
        Thu, 22 Jan 2026 08:23:40 -0800 (PST)
Received: from localhost ([151.57.192.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804704b4e6sm78749905e9.7.2026.01.22.08.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 08:23:40 -0800 (PST)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/4] iio: imu: st_lsm6dsx: Fix check for invalid samples from FIFO
Date: Thu, 22 Jan 2026 17:23:34 +0100
Message-Id: <20260122162335.2020006-4-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260122162335.2020006-1-flavra@baylibre.com>
References: <20260122162335.2020006-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2293; i=flavra@baylibre.com; h=from:subject; bh=PfmODYCm5rMmK7m/DHbR719NzpB5H2VEDNy6yDKy03s=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpck7pgyhWYQgyBUGgQsIIVzZcw3+kO9V5IIeI5 AeGG5tZnKyJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaXJO6QAKCRDt8TtzzpQ2 XzKPC/0UFIw3hI7t5P5/KJCIcTKUlPND0fF1birPI3LD+r4vm8FWlo7nUniLVXG0KEYVgv10SoT /ss+N6BxgIMya8HiPYJfkVBJl/f5LSvotvEfkclqgqXnpAL21JhJwcOIL6JioHjH3rn1xRKjSWF KRfv7r7FFd3EI1+webyZbjlVnUAPgnAV/zGZ6Z/FdqvOsg/khaBiA6CDO0dbDTXsH4ecuA2BOQG KgzfpNVeLTB1Woo7W39AhQN7M0R/ePLC6qJYhTbd4QrWVMJ1LQSG2jK7zo0lER2xuc3DxAA7FBK k4jpW0IfmQYTEZ5oCRjvEdoGmtzO1j8Yu3LrQrj+AxRmA4vKDeMMXv2h4FnXrGYk3u5p8yJJaN1 Vr8LaUAbrY7RQi0VrwTTbIy5ypfzMnrkATxqjzP5DO7PQoRoMmJ81sUmJoYbPwEblfmYCWtCOaR o2sFbBGCa+Nrh9p0wOd3TKEvOBk8wazKZ8dx3yKBPz/X0E1KjmGrtCOq66M2bFPwnOry0=
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
processed. In st_lsm6dsx_push_tagged_data(), change the type of the data
parameter to __le16 *, to reflect the fact that this function is called
with an aligned data argument and avoid casting to __le16 * when checking
sample values.

Fixes: 960506ed2c69 ("iio: imu: st_lsm6dsx: enable drdy-mask if available")
Signed-off-by: Francesco Lavra <flavra@baylibre.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index 5b28a3ffcc3d..ded9a96076e6 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -539,14 +539,14 @@ int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
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
@@ -670,7 +670,8 @@ int st_lsm6dsx_read_tagged_fifo(struct st_lsm6dsx_hw *hw)
 					reset_ts = true;
 				ts *= hw->ts_gain;
 			} else {
-				st_lsm6dsx_push_tagged_data(hw, tag, iio_buff,
+				st_lsm6dsx_push_tagged_data(hw, tag,
+							    (__le16 *)iio_buff,
 							    ts);
 			}
 		}
-- 
2.39.5

