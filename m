Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2333859E9
	for <linux-iio@vger.kernel.org>; Wed,  3 Jun 2026 14:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780496209; cv=none; b=XVDKOSnGLUWOLAEpa/YHCgB0PT67/hcOblOgvU+R3U3sfRIjzFJQJzUDiVuboP/j+kQUClRA9M47hVx5+oJbzY6VDqfDB8c1l50JlKIXsc4OTiB0j5rs/C9owhm/bvBrBvHDiLxAYqkgrKQJMj+7juK3HbI94vIyEKV2IO/xSrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780496209; c=relaxed/simple;
	bh=ah9xfzgM92eXLddOxDq/JlXQ1OjtgcGukZnCaH2pRO4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BOjGwA7RZQS8Dt5GoHyYP1DYeZTIriMSSZmX+tmjteVeXgV4VSyj5Il1+RSgFznlyyWcVuV0kjbXf6lJPDVTAfxHoPXiL2ieR6xp4xtkHmcU9zxl9g8cF0Qw4PBJvcsTK2S6D2dxx0Mchigk1xtkAiAMurorqHHsa9pjfDtD148=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FCWk2v+5; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FCWk2v+5"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2c0c2c7e0c5so26525245ad.1
        for <linux-iio@vger.kernel.org>; Wed, 03 Jun 2026 07:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780496207; x=1781101007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M+NwVbHm0E3Ls8aygQ9mOq7lXbu26hGo6QJSyEvKkCw=;
        b=FCWk2v+53S7Yj9voyduchdzjUMWnKf2shoa4CI+++LGv7wQMnIk+/ie67C8tyJ1Usn
         +tTPI2PpOoZWEl8nROP2wMiJahogFeEd8uSMgO+vBfOAtDRWGeOOvFkXlTx5OO0PpvSf
         HEB78VUVf1q4K/CMS/YvCWiNeQdr+lMXTNl3Y5y+4T/vdhVl/65009+H8BBUdZJh4i0T
         GPXp5f98/7jMPxaE7RZbhnaT7mROEe4n9sCWNQrnqgPQ0w1uAVeAEyFWWmELERh3JZ5i
         3ztscc4ZAYOJk9nem5ndyNJDTNh28wTbViRXc41qB37VqCyvjLj+F2ZPEtXibiLz3Vbj
         +nMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780496207; x=1781101007;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M+NwVbHm0E3Ls8aygQ9mOq7lXbu26hGo6QJSyEvKkCw=;
        b=PRRkgQoPQ24E8m+lOwtLS+utrDQOJDrAqeO4ON1Tu5FmY7Mzm09H9fcS+DQQxYq1aB
         YojH3ogdoFX67BILuf/UBj+no4xONp89u/JzogaU5VxPX1E14lB9LJbIBN9taCjcMO9c
         MNmXgSoxJ6+jvW1oOlLqYoCDNGkiAVBgWPHRmE7QOs6vFnCArEZlrlbSujMQMh0fD5sz
         wBkGiz+Ih+95cXsKhRUlZhMX7/1dOFTNG8LJtiHXEVjDE//0091xe9oRsKb/gNA7GEKz
         2gKjtQpiq09YELcWWkg28xURQ5WM2t6MJnu+sCipIGtvJI6zYL2HLPkrJtVmgvDs2Rl6
         c1eA==
X-Forwarded-Encrypted: i=1; AFNElJ+med2LPSxycAxJ1aH1FaZn8Fb/Q1y7f1vKQwYyPJ/+TBh7dWhO19DzA8JOVw0M46QBmSJhTWFW/3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzGABqsOV4r2wT5jCRd2P5ueK0Ttn5YTwlGiohd9qZKx4HfgD6
	IGOolItYhUQ7IEZPlrKvycQ0/u5+1ojYprWX2ZNv3WOxLcrWOUZX7YA1
X-Gm-Gg: Acq92OEXyCWpk9emkroNZhLBnepm1E5EcwZVrey18dCCHL+y9+0GWnm+vS89o8zxFJx
	8q3KGm6OMfeN6COGyzMbWq0BBlN4KGRKPdVZWyASiQ/v2QRNwbz3nzQrx5LNCAP2837OayDRJCy
	8qZy/ILn1rLj2mceGmD37zLbEg1WKvxis8X8+iZJU9W0dZ+9HWDxn2t1fkI8Kx5YSTpKlU0ZNXB
	aDtqLPDMBLVsAzBSD2QrpeLKpVVEnpozUA/qfdrE7WZzDHcZqyPngyAUwXpaDhbRKwijQVBrdb9
	yN9cwGj28U0m1BiUGPLS7SHH+McgxR/54BNJgIluONIlS9lEchN31VCg2y3xKBGmYNZ2Td+H47v
	NHBoB4mysIKj6ljDdJCNp/n0Q42Q4zZl1F2LE0O3sfQAzTuKvUykDWKmesnGqIg+ZCAEzC2GI2B
	+IW/LSXSw1P8M8m7x2Y1TntXc=
X-Received: by 2002:a17:903:3887:b0:2bd:9061:d544 with SMTP id d9443c01a7336-2c1644b829bmr37259575ad.34.1780496207463;
        Wed, 03 Jun 2026 07:16:47 -0700 (PDT)
Received: from lgs.. ([152.32.188.52])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6e294sm27832925ad.6.2026.06.03.07.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 07:16:46 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Linus Walleij <linusw@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Ethan Tidmore <ethantidmore06@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>
Subject: [PATCH] iio: gyro: mpu3050: avoid double free_irq after trigger failure
Date: Wed,  3 Jun 2026 22:16:33 +0800
Message-ID: <20260603141633.1398943-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 4216db1043a3b ("iio: gyro: mpu3050: Fix irq resource leak") made
mpu3050_trigger_probe() release the IRQ when iio_trigger_register() fails
after request_threaded_irq() succeeds.

However, that failure is non-fatal to mpu3050_common_probe(). The caller
only logs the trigger setup failure and continues to register the IIO
device. Since mpu3050_trigger_probe() leaves mpu3050->irq set after
freeing the IRQ, later cleanup still believes the driver owns that IRQ.

If iio_device_register() fails, the probe error path frees the IRQ again.
If probe succeeds, mpu3050_common_remove() frees it again during unbind.

Clear mpu3050->irq after releasing the IRQ, and use mpu3050->irq rather
than the original irq argument to decide whether the probe error path
still has an IRQ to release.

Fixes: 4216db1043a3b ("iio: gyro: mpu3050: Fix irq resource leak")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/iio/gyro/mpu3050-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
index d84e04e4b431..0fd881fdd1ad 100644
--- a/drivers/iio/gyro/mpu3050-core.c
+++ b/drivers/iio/gyro/mpu3050-core.c
@@ -1137,6 +1137,7 @@ static int mpu3050_trigger_probe(struct iio_dev *indio_dev, int irq)
 
 err_iio_trigger:
 	free_irq(mpu3050->irq, mpu3050->trig);
+	mpu3050->irq = 0;
 
 	return ret;
 }
@@ -1260,7 +1261,7 @@ int mpu3050_common_probe(struct device *dev,
 	pm_runtime_get_sync(dev);
 	pm_runtime_put_noidle(dev);
 	pm_runtime_disable(dev);
-	if (irq)
+	if (mpu3050->irq)
 		free_irq(mpu3050->irq, mpu3050->trig);
 	iio_triggered_buffer_cleanup(indio_dev);
 err_power_down:
-- 
2.43.0

