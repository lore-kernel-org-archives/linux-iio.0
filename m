Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B7A3EE1E0
	for <linux-iio@vger.kernel.org>; Tue,  2 Jun 2026 13:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780407008; cv=none; b=ENm5GAuIRO/S9651MMGzJ34J6m+RZrTIWomN22mgPLILUXh3qkKry5y6DUkNzVEC5nADkcTlCmznGqdmsb2Wse2dzatBWd+j4UB7wElEQNvZQvobDTW+7FDRvgkrWqqDuebqE1S3ph4N2BCl+xsfutBRRKKRe+MRgfjfRtkvawI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780407008; c=relaxed/simple;
	bh=bWoSpvjx9PJhjBwwPPoW18WWraT/qFEhK2vRseW0WTQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W1RekKBi46TfgFQXWPL3z/9vXgw5Kb20uZGQ/I2vQ6f3b9grsj3KMvb8q2uE0xh7VjUZ7I+5vw3iZ9kxXSFdMjdQmFAjiglFCJUc3UDdcNnFlk8kNP+SBK1P2cDdfQJfe3R4ULsRKkGllQur3COsYUNCUhoOny9I093RE4C/tGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aMvTg1PQ; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMvTg1PQ"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c8585ecdd71so1248654a12.0
        for <linux-iio@vger.kernel.org>; Tue, 02 Jun 2026 06:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780407007; x=1781011807; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZtVC9C1cbta0kyUKVT4fHKeIkf1F//8fOgyITkkyulg=;
        b=aMvTg1PQQ1dpXiwiT+8NHCW+vp2StJG+P9P546kCJjnFY7PfJeX2sWaE641QaiCAdO
         xu3YOe9dubX7Mv/JfOMNIvtZtNNretdsJ5Ri/5mqf+B7iCDNOdEuUI22nNiYwP2X6dOm
         pRxnS7WtjgQQJF8CpGP/HzYvFW4UTaW4+vaqSfrZpMRlcTlZ1uIvLUEqxNgNuyC7MUxM
         96FUA4jyAM+4zSVh+MWw9b+BDdMELWBpvxO/hP17c07uaJbIyDyZokQeUqBZH+rS6f9n
         iiqCgKbpykhmqRF0H0Pl949NPgv9DpyqHkNbaf5GeSHYY6GF6FSWvSZmfsN1t+JFG3gx
         y/7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780407007; x=1781011807;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZtVC9C1cbta0kyUKVT4fHKeIkf1F//8fOgyITkkyulg=;
        b=N0FCK3AF4qU8DbtsxHvVOPZBhi7zFYJ8A9soVtHI3W4d9JzmbDEwUr3hdWGc/0kepL
         qH1ZCYoFjQoIIIF53H4HXYrvD8THcbzjt1UyrlEmCJgVo56SUdIGEyxpL+Y/D87Y9Ep4
         VJboIybns4mSnhtAezgBAkWxsfhu2c3QOVxu82jb963dW3N1TMXYkJNBwEOjKeSQcGSu
         9CmiXMil2Q1ZhwbxepjZrG1SxLxynrlXI02l2aNObaTmGU5zsZ2KcsMvrbnpRs3W2W75
         nii8DcAyNJNSAKAC+BfBKBm6oHba+jjZMNqxIPrWmj/1N2bPc5RXYM0gDM1P7jiRSVNJ
         HKAg==
X-Gm-Message-State: AOJu0Yzvp1mHB+D9CuCfBBQjOE4oRLrg2DVw+BcWLF1jcIOINWl4WNaR
	1iGloHTRBezE2ElkHPLgM5A4jKJrGtk9Xd3HS8kKxatQQyF3/eW2z1Ah7pOqag==
X-Gm-Gg: Acq92OFcjql5G2sxWSvAtyWo8VRar/KXbU4aY7+6xFSR/aa+Zqs9rkTjTsfS552nYv8
	TmSZKuYE5v/qzkXx+h/DJ293lYgCAOcwOMYJbQElPCFJmEfbh3OP3bEDGbO6XT+iqL092GmUzOu
	6yM4Br5QTKOtByT6b2bzvJ/PnhXkvIa3zq50ndVyon1hQP7jY96fnsGyHNW1XXCJT3eU8MSpNd/
	py+69pkHtCOblkrH+SfHhMuJ5/9Y4x66fUGSHWBaeE+/Cxx9jaRucfShZG3CTT6HJVrA3Qupk0g
	3QtYVj7DBxswDI74PMAUb7syEGJ9O0Drvhc/c8mSkhAbAChLgm4ZpS02RLbfDd0oYzPzQOjdgfz
	HMWt+O0SB9PllQdDD4YEg1PMFHjlf/Zbxq5Zp5IinjP2WsHlPvR6HQPEeemwM4uHZ1vU+esmCZ0
	JLyDlY4/1hyanpgQmHpNuCUd9bOH5UOS05Jwja7eo68NBjVFJuaN/ExxjKqQ4=
X-Received: by 2002:a17:903:22c5:b0:2c0:c625:4019 with SMTP id d9443c01a7336-2c0c6254474mr124411525ad.25.1780407006419;
        Tue, 02 Jun 2026 06:30:06 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23a1ee6esm148548215ad.33.2026.06.02.06.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 06:30:06 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
Date: Tue, 02 Jun 2026 18:59:26 +0530
Subject: [PATCH v4 5/5] iio: accel: mma8452: use guard() to release mutexes
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-15-apr-pm-iio-mma8452-v4-temp-v4-5-26d6dff8fc55@gmail.com>
References: <20260602-15-apr-pm-iio-mma8452-v4-temp-v4-0-26d6dff8fc55@gmail.com>
In-Reply-To: <20260602-15-apr-pm-iio-mma8452-v4-temp-v4-0-26d6dff8fc55@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Mailer: b4 0.15.2

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Replace explicit mutex_lock() and mutex_unlock() with the guard() and
scoped_guard() macro for cleaner and safer mutex handling.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>

---
changes in v4:
- add blank line with input from Andy
- v3 link -> https://lore.kernel.org/all/20260505174640.3998281-11-sanjayembedded@gmail.com/
changes in v3:
- Following input from Jonathan extended mutex scope for
  IIO_CHAN_INFO_RAW case to include math operation under lock
- v2 link -> https://lore.kernel.org/all/20260422165643.2148195-7-sanjayembedded@gmail.com/
---
 drivers/iio/accel/mma8452.c | 30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 85dfd854e2b6..7d0b4560ba2a 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -19,6 +19,7 @@
  */
 
 #include <linux/array_size.h>
+#include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/mod_devicetable.h>
@@ -479,9 +480,9 @@ static int mma8452_read_raw(struct iio_dev *indio_dev,
 		if (IIO_DEV_ACQUIRE_FAILED(claim))
 			return -EBUSY;
 
-		mutex_lock(&data->lock);
+		guard(mutex)(&data->lock);
+
 		ret = mma8452_read(data, buffer);
-		mutex_unlock(&data->lock);
 		if (ret < 0)
 			return ret;
 
@@ -579,36 +580,30 @@ static int mma8452_change_config(struct mma8452_data *data, u8 reg, u8 val)
 	int ret;
 	int is_active;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 
 	is_active = mma8452_is_active(data);
-	if (is_active < 0) {
-		ret = is_active;
-		goto fail;
-	}
+	if (is_active < 0)
+		return is_active;
 
 	/* config can only be changed when in standby */
 	if (is_active > 0) {
 		ret = mma8452_standby(data);
 		if (ret < 0)
-			goto fail;
+			return ret;
 	}
 
 	ret = i2c_smbus_write_byte_data(data->client, reg, val);
 	if (ret < 0)
-		goto fail;
+		return ret;
 
 	if (is_active > 0) {
 		ret = mma8452_active(data);
 		if (ret < 0)
-			goto fail;
+			return ret;
 	}
 
-	ret = 0;
-fail:
-	mutex_unlock(&data->lock);
-
-	return ret;
+	return 0;
 }
 
 static int mma8452_set_power_mode(struct mma8452_data *data, u8 mode)
@@ -1754,9 +1749,8 @@ static int mma8452_runtime_suspend(struct device *dev)
 	struct mma8452_data *data = iio_priv(indio_dev);
 	int ret;
 
-	mutex_lock(&data->lock);
-	ret = mma8452_standby(data);
-	mutex_unlock(&data->lock);
+	scoped_guard(mutex, &data->lock)
+		ret = mma8452_standby(data);
 	if (ret < 0) {
 		dev_err(dev, "powering off device failed\n");
 		return -EAGAIN;

-- 
2.34.1

