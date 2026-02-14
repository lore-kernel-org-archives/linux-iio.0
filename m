Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6514314A65
	for <linux-iio@vger.kernel.org>; Sat, 14 Feb 2026 22:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771107054; cv=none; b=tz2YeeMDJjwoxQYKZ06rlIcSAN/6tfzriSSAAmGWfrMkVoz/nu/9jeaMLcyvXkOHLcju/sTMDQBWgUmXKCuvVztlQq1wIiP7Qa5bjMN9wCgD9nivpwE/JYJ5OBQQM1e6vr3n8S21o6r2Jl+yopBMzaTxEr9VCYGhduUNEJ0aV2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771107054; c=relaxed/simple;
	bh=ODrZgpweP48EKYZknvbUzaE4n0zuYcFxL/c5awbHz3U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZL/HABljhdn1WtsDnEiDM7GP6Ij/O6sDkdJwWzwKvrayeQuV1nPQ35UJA7NXN+v3ltS293rE65sbVc2OKWW4UajjbkC+m/jJrDU4C90VRsTU4YGlXIKRTd2tCpIoIlbrURS79DZgGJpECMEtcNbpWbttsxh3er+0tfWjCQKb1CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=f9fnhETm; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="f9fnhETm"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-40ef10ec84cso1224296fac.2
        for <linux-iio@vger.kernel.org>; Sat, 14 Feb 2026 14:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771107049; x=1771711849; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I6BugSQ/CL65rE3opDOxux3g1OYZ7rPOULymJCM9Yvw=;
        b=f9fnhETmAqmnjznEUX8PVTRqHYecBaJKcZR04WSnZsioYpwVr8d+qYLNIsodAR1S4P
         edtfAeH57bhrRx8KTu59xoXKh1MzXDvGjCl1SLPMN6sVQfdWPtiERcP5ZY0IR6eD/T/r
         vtapsowSnkidSfkGgg4cv9bl1ridgfocjDZ4IRw56IRyp8O4WSyt0wKwlm3tppr+pl71
         m9eU4bRNueaKiReKtp2vY4SHhy1rRv2JuHz6ocAwbbe/vmeoNMYOlsOm/C3wZnRdaW+d
         UPtqEK2wOuEiRJ28Ch7RERwL2Lq5dY4Mmian0mufM4BOHYF37k+OXhFd6HbzWPjE6quk
         yHjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771107049; x=1771711849;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I6BugSQ/CL65rE3opDOxux3g1OYZ7rPOULymJCM9Yvw=;
        b=NJ28iWH8ppiNAjXS8ft/B+YF6uHwie2sRtE5XrPxlwUFeVODl1yNWFT3kQ16NkKgZ4
         kgxdJJBL+n8JzwHr4YqSVVDxUbfE74ijuB8jr/D5l3EadNUft5MVI5i5Kc1c0qWXIfzh
         aQq72jZKC3N9Z5+co1UMmzPHdmnrlWFdaePHU4ITzyqx6f8MqYAuzIJNEIlxbZWCwSjW
         ncAhlIjaVcoou6HcMt2PvTyI8CMq1WKVgw+ga5rOeJ2O5ZzxCjINEX2LbTgln0SkqRVH
         CQBtT1qJH8d8ONfHOIbJXxnlRYvX7JnDadRqa3ttRuagn+qqtYd2HH6ha9DXepCxw7rq
         eDiw==
X-Gm-Message-State: AOJu0YyztP8g4bRhNQYW+SRzRCMaDkHMunbZ+NoYq+faE+I33VasrycD
	B3tpgKVXR7zZLxxMrn2KMAD3pl7iI57Xx9G8P+PcaOniZJb5cocLkhfVUdhwFxBt3Vg=
X-Gm-Gg: AZuq6aLEISVcMZLQIPYFDvztYb40dR44wEUGIsSPKFat+TsBgCUq72GYYF4r5w7Tphn
	IfItpdRGZ0Z3ZUKQmPGJiVCiTV9BibKfKOzc49gv0X8E/Z9AnPOyv4AyP4HiHHgmbc/43wtdsP1
	V/a34u90Ox8E7DxcS/AajuebIF7R0cy+mKJFGdlRQfRPiI/a4y78q8RKGNqZdFvi+myTNZOB75R
	CA/TJpmeIaTr9SvrolAmNxJif9fTX7/IM1cJ+AaZDFvfEkx2+7/hkJcWlGWddF7+eZ0WBQnaGce
	db3k2d4jro2AKUWVW6iNfbV8G5J1w8O3Q1o14emlDpKLwBHr4hC0OVuNzKpImuGzXTkoPqjJRci
	h29UBa8Ixwf3gDWToW7x8m3M7N9INn5+IPH0XQOz8QX/kWQsU0eEWZc3tUuaprAbz2tro+hiMAo
	YYwfcaySiwwD8VyAygu23hOUh0RQ==
X-Received: by 2002:a05:6820:450f:b0:65d:88b:c00d with SMTP id 006d021491bc7-677694a0f8emr2397144eaf.66.1771107048786;
        Sat, 14 Feb 2026 14:10:48 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:109:393c:254e:962e])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-40eaee45d12sm10686339fac.1.2026.02.14.14.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Feb 2026 14:10:47 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Sat, 14 Feb 2026 16:10:38 -0600
Subject: [PATCH] iio: imu: bno055: add explicit scan buf layout
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260214-iio-imu-bno055-repeated-element-v1-1-b57b08efd566@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/1WNywrCMBBFf6Vk7dAkNIr9Fekirdc6YBJNogjFf
 3d8gLgazsA9Z1EFmVFU3ywq48aFUxQwq0ZNRx9nEO+FldV2ra3piDkRhyuNMWnnKOMMX7EnnBA
 QK5nJOGfhN90IJZZzxoHv78Ju+HDG5Sqh+nn+On3zV5HZV0/+xHN8693GjXbSegvr+pt5FUZfQ
 FMKgWvfSK20GSGJvRVLK7dynNXweDwBjWK22u0AAAA=
X-Change-ID: 20260214-iio-imu-bno055-repeated-element-1c1552ea74be
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2194; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=ODrZgpweP48EKYZknvbUzaE4n0zuYcFxL/c5awbHz3U=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBpkPLg23z87PbR/7sLSokPCvF3KgUEMzMenMyJn
 +xBaOZPdy6JATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaZDy4AAKCRDCzCAB/wGP
 wFuXCACBGoa1XPdvLFz2zU1wlb689rUGm76QE7w8BWpsyH4FFpC+fquDNGAx+I2zUckZth75tOw
 HGG/krBudEhBOgo1NJlmDoIqJFg78CuhzI/oO2ARgOn7831Tsi/DuB8CzY6gWFWoeiv1RhUdHb2
 XqtwGPg0kIqgCVYt1IW+iNlcSxJu2x4w+XYt1ou+zmNJ58qHXYGq5+vRpO//mOt5uzzKv7xTT0v
 4sdx+NnaQxIva2t90Z899A8KrgeQUt+XjDr+TwX9tF37ZOIlaU+HRvI5esGLttB3MxYl2caa9AV
 rTujGmGuoQwzEjquaqeUMWXJBah9EJz00/cP0EmegsXUMNB9
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Move the scan buf.chans array into a union along with a struct that
gives the layout of the buffer with all channels enabled.

Although not technically required in this case, if there had been a
different number of items before the quaternion, there could have been
a subtle bug with the special alignment needed for the quaternion
channel data and the array would have been too small.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
This depends on [1] that introduces the IIO_DECLARE_REPEATED_ELEMENT()
macro. I didn't include it in the same series because the other series
contains a fix and should be backported while this one ins't a fix.

[1]: https://lore.kernel.org/linux-iio/20260214-iio-fix-repeat-alignment-v1-1-47f01288c803@baylibre.com/
---
 drivers/iio/imu/bno055/bno055.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/bno055/bno055.c b/drivers/iio/imu/bno055/bno055.c
index 303bc308f80a..47afda01229f 100644
--- a/drivers/iio/imu/bno055/bno055.c
+++ b/drivers/iio/imu/bno055/bno055.c
@@ -211,7 +211,25 @@ struct bno055_priv {
 	struct gpio_desc *reset_gpio;
 	bool sw_reset;
 	struct {
-		__le16 chans[BNO055_SCAN_CH_COUNT];
+		union {
+			__le16 chans[BNO055_SCAN_CH_COUNT];
+			/*
+			 * Struct is to ensure proper size in case any padding
+			 * is needed. Technically not needed in this case, but
+			 * better to be explicit about the requirements.
+			 */
+			struct {
+				__le16 acc[3];
+				__le16 magn[3];
+				__le16 gyr[3];
+				__le16 yaw;
+				__le16 pitch;
+				__le16 roll;
+				IIO_DECLARE_REPEATED_ELEMENT(__le16, quaternion, 4);
+				__le16 lia[3];
+				__le16 gravity[3];
+			};
+		};
 		aligned_s64 timestamp;
 	} buf;
 	struct dentry *debugfs;

---
base-commit: 0713b26190addfa3a774b386c8658952ef9f7faf
change-id: 20260214-iio-imu-bno055-repeated-element-1c1552ea74be
prerequisite-change-id: 20260214-iio-fix-repeat-alignment-575b2c009e25:v1
prerequisite-patch-id: f7d2b3c87791f50de610900f5680d1b9b503702a
prerequisite-patch-id: 28aed7da5bbcd16f83256bbe2d4c209fc26888bc

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

