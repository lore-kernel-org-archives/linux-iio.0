Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A953F307481
	for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2026 15:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776786018; cv=none; b=GBKJhk8R8N07fKT3XsFft5aeWsZYJWny+CiuJAhvn462xW93tTigdL71AIwgg6KZwB7SXOvVB07Q7c/nL2dp9WHrGsNIq5colhZ3WL/VQxSuM53xSCmKQzxXQmAdzfzJQ1PLcV6gESq40gCFoLdqHQnqeNT0grKwbswwFsnQK5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776786018; c=relaxed/simple;
	bh=J8I3qguk6JZmaSr23q+KENpmCqifRZB8xguejX8P8v4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YLJSL0BACipHYKo3oUaglZxXU0ZNk0lqLIzcFqji1pBYehzKmBrLFsk29F4QsnQEg/6mRhNoruuUjghHW6dkxMd2WElWvTN2JVNKXGJcLuxt9/LAuZ427guEGDCW/l8r12noWNbWnnnTTU3bFiF2M1HgAClsBPrZjcr+ZWoGwcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rzKzD7zI; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rzKzD7zI"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-12c565dd3a7so3217112c88.1
        for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2026 08:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776786014; x=1777390814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aXp/jh8SX82hptn+GXsi5wEHFqg+ppWiYYciByN4RRs=;
        b=rzKzD7zIx2Pk+8SkdtWCWNo+gBrpjoWUCn8FMXX3ujGJ9mUKhw40b47+ga95VvYq15
         b6CDzKNbVwI25xjxTzN5CpF30gwSYkl8Dw1NDLHXcEtOeecC35z6aBRdsRwgO3GB3QDl
         ZP707dpwOATUPc5hiHtCi7j7bg/iISEgD/ZpNhHmfswrGdQSBfSsQEn3kpTbrE2Ho04T
         KaBxGEhHDJnKfaiKjaaIC7efDvA4WIcsNsNzQaSvF8cX5GEds5ekPcvsdOjvK9Z/NsAH
         9ilcDUgKTZ2TypC5w9uOOpUmRGMFlDpz52mEkq+V4W1rCTQzXImwrKXHpTgb7BH9SYHM
         pC7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776786014; x=1777390814;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aXp/jh8SX82hptn+GXsi5wEHFqg+ppWiYYciByN4RRs=;
        b=TB10CaUu8jBBKuW/FgalQLt8n0xzzj7ZRrrZ1orwX5EF+74VTptuRXsDjSy6cju5Y2
         JFk2E1jcvm1KHdlcNakyPXAJTfVAYYtigQOmLpgnSsVfDTANzIYiyXadtibsUK0GXGLl
         MKgvjeTgIjt98q/3cB4FSJ7q/W3N55KrMBuzeZ9Gh5thoxLPrPWoC+0gNpnHJsLsqOoE
         UqLXXN5Qs6A/bsuAU2nhIrM6uK4D2nBjvw6xp1SXoZXlRI3cdWOHW+uPVqN6xNh3elSR
         /8zSVLx+hRKTT+Hm3gd9UVrT9eW1CQzYwfLU5A7ha2Lv3ldO88JlUi0LlNwoGfgyPAqD
         7Jnw==
X-Gm-Message-State: AOJu0YzFbVcJkNsWrrIihflh5hc2fcLFctB4yY6h1+LcjCcS+P0rYNwE
	/2nJMqy1WQ5EssB1xilALek9xXI0upSo3yQlExPEhZOJjQR235zN2s4U
X-Gm-Gg: AeBDieuoKOqN4ET+xSksMB2yJzReO1PxEMqDmuFzlkowe181AGSrHyt6HVOSnjwOmHy
	qkhn+86kPxt13N0Ht/8d9CIwiMCLb45mt9evK2TRK+M1Bl2LOW+F++1MQKUXsmZDe1rrzsQ63Dz
	jOHrTfgP2/xGQHwo866hD5h8lByR6yZtncgcczIj1mcgOMkEd/kmNAKK5bMgzVUcXfkn/assLk+
	fbSpyZzkKIzqqvyABXQoCCtBCeN52odnaSFgytSvRaHMZaP762iCVgKz18L02yeAKGJjkYPfFMv
	PAzdBGrtX82HXpD991z1eCji7DtUf2GZIlDdWFtZnz0WeahAAu3pxnnYAMmfhRL6FKTpZILZFsa
	gJhKJFxb7GaPKtArCBR1dJws4kX8qB2u8MPLEbg9rtziAfJ843uvdYy2UWLRgmdz5v78apnUSlo
	sweFf0cORa+uN9t1Va4KkWA/bGXbgPe6cu8C8cmmzrtNsQR8e5lUFvXow=
X-Received: by 2002:a05:7022:ba7:b0:12c:14df:a510 with SMTP id a92af1059eb24-12c73f9c44emr9708868c88.28.1776786014148;
        Tue, 21 Apr 2026 08:40:14 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:dc81:86f7:2415:8ff1:852d:8e53])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c749c422csm19969034c88.3.2026.04.21.08.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 08:40:13 -0700 (PDT)
From: lauraarakaki <lauraarakaki23@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: linux-iio@vger.kernel.org
Subject: [PATCH] iio: temperature: tsys02d: Use guard(mutex) in tsys02d_write_raw()
Date: Tue, 21 Apr 2026 12:40:01 -0300
Message-ID: <20260421154007.1114389-1-lauraarakaki23@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the manual mutex_lock()/mutex_unlock() pair in
tsys02d_write_raw() with guard(mutex)() from the scope-based
cleanup helpers (include/linux/cleanup.h).

The previous code stored the return value of
ms_sensors_write_resolution() in a local variable solely to
bridge the gap between the manual mutex_unlock() call and the
return statement. Using guard(mutex)() removes the need for
both the intermediate variable and the explicit unlock call,
since the mutex is released automatically when the function
goes out of scope.

No functional change intended.

Signed-off-by: lauraarakaki <lauraarakaki23@gmail.com>
---
 drivers/iio/temperature/tsys02d.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/temperature/tsys02d.c b/drivers/iio/temperature/tsys02d.c
index 0cad27205667..55a55f2f4663 100644
--- a/drivers/iio/temperature/tsys02d.c
+++ b/drivers/iio/temperature/tsys02d.c
@@ -10,6 +10,7 @@
  *  http://www.meas-spec.com/downloads/Digital_Sensor_TSYS02D.pdf
  */
 
+#include <linux/cleanup.h>
 #include <linux/init.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
@@ -62,7 +63,7 @@ static int tsys02d_write_raw(struct iio_dev *indio_dev,
 			     int val, int val2, long mask)
 {
 	struct ms_ht_dev *dev_data = iio_priv(indio_dev);
-	int i, ret;
+	int i;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
@@ -72,17 +73,13 @@ static int tsys02d_write_raw(struct iio_dev *indio_dev,
 				break;
 		if (i < 0)
 			return -EINVAL;
-		mutex_lock(&dev_data->lock);
+		guard(mutex)(&dev_data->lock);
 		dev_data->res_index = i;
-		ret = ms_sensors_write_resolution(dev_data, i);
-		mutex_unlock(&dev_data->lock);
-
-		return ret;
+		return ms_sensors_write_resolution(dev_data, i);
 	default:
 		return -EINVAL;
 	}
 }
-
 static const struct iio_chan_spec tsys02d_channels[] = {
 	{
 		.type = IIO_TEMP,
-- 
2.47.3

