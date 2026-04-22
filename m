Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D96F387594
	for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 16:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776877027; cv=none; b=NZVX6xjPYUAflSP8enqbQNMbTGyag57m4ab1G5s4XISACG//sOugzr3bLa9FtE3QrcGimbfCPhr0hz/UNqfLuxp9vLWPdvAJ+MnUXdx9WEvkn9E30gaKGYjB+uMdiIiwyUhFg9ZvyQFdLUy0uBMPYmXSfJz7ChfAoh+uX6GRsMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776877027; c=relaxed/simple;
	bh=ezpzTaXiSS5tWwZbT+HyQP2Q5+ghg+y+4Ax/LVTfoN8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c60oC1iVvoIO/D5yJdHvbgbgq86xQRntegnrLPfgbRXiRTTBilROIlfssIUFdh5qzLhnEQenMyV5Cv4LsTVRD4rxWz2q+upOhqoaC3SJayi2HaZzCSymBooFhTgi97yIQ4g4OLnDNE9W9oIUPGQsvLFgBRQLJEX9lGKiZCYnBlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r0YszkYe; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r0YszkYe"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c7961d7bc09so2138755a12.1
        for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 09:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776877025; x=1777481825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N7IfPX2Kd1lFJfKogZTn7YfG18XsUl0K/gq6N+2NVm4=;
        b=r0YszkYext8Y+3LVqg+ACvLKp/cWR8Zf1K+2KTTwbx/HQnq8nPi4Mw/cFdvL+Y5LJX
         Hk0iRwQziTrRDbxaLRyRwEEuiA51SH5OElCOhmXAmkUhBmva58Sqlnfo/v+8ieqHt66h
         BOVzoAy7VCxGYICfhrdZAanjM1nwr1zdvx8VMZWDOwzijKaFawW444mVp1iGWrQe4qF2
         j8II3qZp0hV05WCDQwhmBjucFy7USMUQjjk0HBA+9HzYuF7KwxRh6K4bPbbW0a892sKH
         O1oYYkvL0Q246AN1GzbMsffhyvtfQPXkp5STMpC/3ht1kiMBka/xLdhAbfLq7asIAZTt
         x/Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776877025; x=1777481825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N7IfPX2Kd1lFJfKogZTn7YfG18XsUl0K/gq6N+2NVm4=;
        b=Lfql7v0XAlZI6nRVYsXCC5YfXEDKNTr23LQBFXZE6FrDQHtbdV2hRhUPBa2C3d7Yok
         P5S4jyNkvmsIYFwYTRd4fvzto94ofAeMa9Rh7VIJdusRRq7rbwS6vU10NaUi+noOWrbg
         PjwSwFWi2itQQdALJ3mIMmzpB3C1iHWM1IkS49JIykmT/ZCJOxJIxvUXOCSi8KPQxunG
         NTRHRmFGqLH/BL2Wx2ShJLFkPys9nPDtIb1EBVDAaQ1tuAZdEaUUuqIQ6EaK4Q/mzb3g
         AtHgQrOluKIr7cyXrfLutuzebDzKiKBeTI2fiy2BYR5rbl+Eyu8H0g1LGXa8gzK7K/5d
         obAA==
X-Forwarded-Encrypted: i=1; AFNElJ9uYSdQHMWEXjIn+kvRGxpl3LhZcYZDbECwF4svW5YO/0hvdDVGUmqAsGtbAeJV/N7dokLyVa99XCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQRgsS3z1sbwuU20egjH/SFVAPf3ekARpVVmr666pMrjGPvA6g
	QvesarOQ28rkaiNgXhGKZsSkGIlixF3Q8x1+srJY7c9GmpBgcghE/wgP
X-Gm-Gg: AeBDietsP9xCIg5kHl7TGtBj+iXoU9WhW1Pg0YW3xS+feMEgTrMTzq7MRz6qh/rT6RP
	4s+RvIFD9eu26upwFSUGw+BQbSEPK4IMPYBkhacYgm0AF/bkPpbfE3PL4HywQkycY5jgwYEwsZr
	tUam1pBdK1M/uWd7RPznASTxiaTx0dxbBpwYJhCsASGK+rSwpRYqH15FfWVFO9z2le0ap+SV3/d
	dvWhwPVbrAsuhiXgGbdidknDJHj7n7f075D+xz4r4ny6eVvfXWk4RdlMjW1QKrx64ocw8C1Os4E
	QFCAOklXHtr6m2nyUq0+CK0GqW7+RvjQnplscx9eVoc8JYQAI8UUHd/+m5EasCCcOk3HTppgU+b
	6kmCdfCLzA0mBXSP/WlzIhoJ9Uzns67P0G9sSVHtAb919cp9QX8xtUVDSszNr/HlcQqRi+BxS35
	O2XLg1bXuGh33U4vpfKFQTNvWJi8dia6+1bbdALGHtBgnvXP2/vMTH2jidbpw=
X-Received: by 2002:a05:6a20:9194:b0:39f:2b9e:e472 with SMTP id adf61e73a8af0-3a08d68775cmr26519211637.3.1776877025271;
        Wed, 22 Apr 2026 09:57:05 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7976fa3604sm11908675a12.14.2026.04.22.09.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 09:57:04 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	sanjayembeddedse@gmail.com,
	sakari.ailus@linux.intel.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] iio: accel: mma8452: use pm_ptr() for dev_pm_ops
Date: Wed, 22 Apr 2026 22:26:42 +0530
Message-Id: <20260422165643.2148195-6-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260422165643.2148195-1-sanjayembedded@gmail.com>
References: <20260422165643.2148195-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Use pm_ptr() and DEFINE_RUNTIME_DEV_PM_OPS() so the PM ops pointer is
automatically handle when CONFIG_PM is enabled/disabled. This follows
modern kernel power-management conventions.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
Changes in v2:
- Use DEFINE_RUNTIME_DEV_PM_OPS to address review comment and resolve 0-day bot warning
- Link to v1: https://lore.kernel.org/all/20260414192045.3598010-1-sanjayembedded@gmail.com/
---
 drivers/iio/accel/mma8452.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index d1ae2bf37409..9983f76a8bcd 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -1747,7 +1747,6 @@ static void mma8452_remove(struct i2c_client *client)
 	regulator_disable(data->vdd_reg);
 }
 
-#ifdef CONFIG_PM
 static int mma8452_runtime_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
@@ -1815,13 +1814,9 @@ static int mma8452_runtime_resume(struct device *dev)
 
 	return ret;
 }
-#endif
 
-static const struct dev_pm_ops mma8452_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
-	SET_RUNTIME_PM_OPS(mma8452_runtime_suspend,
-			   mma8452_runtime_resume, NULL)
-};
+static DEFINE_RUNTIME_DEV_PM_OPS(mma8452_pm_ops, mma8452_runtime_suspend,
+				 mma8452_runtime_resume, NULL);
 
 static const struct i2c_device_id mma8452_id[] = {
 	{ "fxls8471", (kernel_ulong_t)&mma_chip_info_table[fxls8471] },
@@ -1838,7 +1833,7 @@ static struct i2c_driver mma8452_driver = {
 	.driver = {
 		.name	= "mma8452",
 		.of_match_table = mma8452_dt_ids,
-		.pm	= &mma8452_pm_ops,
+		.pm	= pm_ptr(&mma8452_pm_ops),
 	},
 	.probe = mma8452_probe,
 	.remove = mma8452_remove,
-- 
2.34.1

