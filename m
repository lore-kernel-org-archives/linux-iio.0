Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D633148DD
	for <linux-iio@vger.kernel.org>; Sun, 26 Apr 2026 09:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777195062; cv=none; b=sOvy0Sl1MxDfDZa60NRflEPwwwqxAVzIBUDgW4DdIcpMlHQIcDfcP5Xg1CqCHGOS4SwjJE0qYHehxF45nvyvXuABVavknM38PomjBTmGimu3FE/k3mA38fouuYU+u1Y6qBRowGAajccfxEhvGoAMBOA9yp1CuL19zdPAy8xl4hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777195062; c=relaxed/simple;
	bh=1XbT4DFv59qx2zEQidQrmQJpZi9ihMKSMAMKDP1misE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OGy4AeN5l69zV6gc+F2i1Ps9sokT4ed7LdkOBy7eKdXte1nEI8okkq5viUhN5ANrkckiH04XbZZvWpRxo9q7KIHt9OaFKE1rV/F9f8znaonbvMdriTBkC7SsL6lYa7xAWfN6Wb7By6FVL6kGexyH4U62KdnLHybmm9wFOrLLVcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EwhcQZsG; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EwhcQZsG"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-82f69a286dbso6991347b3a.2
        for <linux-iio@vger.kernel.org>; Sun, 26 Apr 2026 02:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777195061; x=1777799861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nl8W6B5QxibAvKD5ouhYFUfJc3VYKgW5BCHReA7sRZM=;
        b=EwhcQZsGYaI9EGSUaPMoKKpfMAHA8ho0ka9u9MMNrzGwIReN98e1nV2Ch4i5dVBLwF
         7jmNaHPtUZQdDdUwM7khFiuAcSEy4QXiVNSqyPf5AAtc5y1nGZ6yhcnwGXMUiPaE7jn8
         UadnH34m5+1huj4EB8X4aaXOAYHCNwx4JKXkBwuqcStaniMsVgKnpBepTrG3nKTXqnnT
         T9AmV21rXgkp2L80wGtZ5kFMPBa9chBxrLk/1n+Ddjkz8TaUEpcplP5ESqKdb5FpPxNe
         iPaHArH16trrx/lEpCmXSCs22GYhbyK9lML9pwXZaMPC5eLK6KQjl14zXyD2QVk/g2Hr
         A7jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777195061; x=1777799861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nl8W6B5QxibAvKD5ouhYFUfJc3VYKgW5BCHReA7sRZM=;
        b=MdzoaPv7Qn7os95SH8iMsvl6wFLIiSa9iL13gmkgnS4MOV6DCJmeaOIl/p72pUS5Ta
         gW0kfAPWVxgltf7Q9Hf7P+n1DevKeLvnSQgaXUkTF1ylmvMUreLfOVeyhW02lWefv91A
         n3ZSCoG5kV9cJPqovAT8aDyic81S9behzXSgM1IszeZVHli7IVMUH4zPKBYb1ULtmBdq
         M3QC0doFWOSUKcmTSmWLFTwso3fXOPUp53DAaqdy/+yhD16XgUp/6ihNyMb8yc5ZmL3U
         P2K4ixigBZyid38z+4KzQplJ+t8QCAaP3hQ+R7noq7Jo5rolzbSYkRZVCyKWbXXQ1wJX
         swdQ==
X-Forwarded-Encrypted: i=1; AFNElJ9pzsZLL0QPAWGRdSZ+Yw/nzqQ0TThToqFML4xCw/DJ/pZtzvd0NkVU4bGbHx367JZYO1enEw49dEc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb+qIi46QcQaSsE9Nx2/oMgbeViacC3IzVPqtmWUbrpUQavQJs
	+a+kXyAoUi9ZTKJA5hw2fGKhEXYSfjvQ6zCFbuiWRYZF/p9RnkKh1lE1rteF6A==
X-Gm-Gg: AeBDieuoYSl6nkMpm6DXXv8/Kpnd8Iy50CVq2lIKY6XqaS4wsw84NmjONQ37CFDTYqx
	O67drH87fGy3g9fXWWkp+Xqf5B5O8iwQkklGTkCemTXwng4sCYT7GEBzMqRYSnZKK7GnCHKa1es
	b37/RUQ13JAC8+HY2vEGkKDJEhKDx9oTsKgIgPi7tiXbY9mG88TlKhxVu66HZeY4WoTuIp/BwlO
	1DTRyFF2TySQ+sOAF7ZnuYTnq6Vw57eg72r1Cc90JiH5SRRtprJghFRSeD64v4y6BRuAPkNgsOM
	BWbPmEA/iE/kyJNgxw5psuaJZtCOc4JAi9g9PJj2urGhdxWCeyd2q6YgL7Ze07v5++GVmUo3H0E
	ANlUIGX62Jw+jAcGcJ3JHRjvVt9KDXiedBj86QO3/7UTPIOlFhYCko7UVR+YplKRMJOqClCWKdC
	/DTjgmL4/oEKaNl527MSpIGQmYSPn8H8t5JDHP03+75h+n/t5ofA9zELzMMWE=
X-Received: by 2002:a05:6a00:17a1:b0:82c:e83d:a9b0 with SMTP id d2e1a72fcca58-82f8c850e93mr39270060b3a.21.1777195060917;
        Sun, 26 Apr 2026 02:17:40 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e982fd3sm36145226b3a.10.2026.04.26.02.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 02:17:40 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	sanjayembeddedse@gmail.com,
	mingo@kernel.org,
	christophe.jaillet@wanadoo.fr,
	nabijaczleweli@nabijaczleweli.xyz,
	kees@kernel.org,
	kyungmin.park@samsung.com,
	k.wrona@samsung.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 5/9] iio: ssp_sensors: use local struct device
Date: Sun, 26 Apr 2026 14:47:06 +0530
Message-Id: <20260426091710.3722035-6-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260426091710.3722035-1-sanjayembedded@gmail.com>
References: <20260426091710.3722035-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Introduce a struct device *dev derived from &spi->dev to improve
readability and reorder variable(s) to follow reversed xmas tree style.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/common/ssp_sensors/ssp_dev.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/common/ssp_sensors/ssp_dev.c b/drivers/iio/common/ssp_sensors/ssp_dev.c
index 9b8642193176..fa47282b39c0 100644
--- a/drivers/iio/common/ssp_sensors/ssp_dev.c
+++ b/drivers/iio/common/ssp_sensors/ssp_dev.c
@@ -492,27 +492,28 @@ EXPORT_SYMBOL_NS(ssp_register_consumer, "IIO_SSP_SENSORS");
 
 static int ssp_probe(struct spi_device *spi)
 {
-	int ret, i;
+	struct device *dev = &spi->dev;
 	struct ssp_data *data;
+	int ret, i;
 
-	data = ssp_parse_dt(&spi->dev);
+	data = ssp_parse_dt(dev);
 	if (!data) {
-		dev_err(&spi->dev, "Failed to find platform data\n");
+		dev_err(dev, "Failed to find platform data\n");
 		return -ENODEV;
 	}
 
-	ret = mfd_add_devices(&spi->dev, PLATFORM_DEVID_NONE,
+	ret = mfd_add_devices(dev, PLATFORM_DEVID_NONE,
 			      sensorhub_sensor_devs,
 			      ARRAY_SIZE(sensorhub_sensor_devs), NULL, 0, NULL);
 	if (ret < 0) {
-		dev_err(&spi->dev, "mfd add devices fail\n");
+		dev_err(dev, "mfd add devices fail\n");
 		return ret;
 	}
 
 	spi->mode = SPI_MODE_1;
 	ret = spi_setup(spi);
 	if (ret < 0) {
-		dev_err(&spi->dev, "Failed to setup spi\n");
+		dev_err(dev, "Failed to setup spi\n");
 		goto err_setup_spi;
 	}
 
@@ -548,7 +549,7 @@ static int ssp_probe(struct spi_device *spi)
 				   IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 				   "SSP_Int", data);
 	if (ret < 0) {
-		dev_err(&spi->dev, "Irq request fail\n");
+		dev_err(dev, "Irq request fail\n");
 		goto err_setup_irq;
 	}
 
@@ -562,11 +563,11 @@ static int ssp_probe(struct spi_device *spi)
 	if (data->fw_dl_state == SSP_FW_DL_STATE_NONE) {
 		ret = ssp_initialize_mcu(data);
 		if (ret < 0) {
-			dev_err(&spi->dev, "Initialize_mcu failed\n");
+			dev_err(dev, "Initialize_mcu failed\n");
 			goto err_read_reg;
 		}
 	} else {
-		dev_err(&spi->dev, "Firmware version not supported\n");
+		dev_err(dev, "Firmware version not supported\n");
 		ret = -EPERM;
 		goto err_read_reg;
 	}
@@ -579,9 +580,9 @@ static int ssp_probe(struct spi_device *spi)
 	mutex_destroy(&data->pending_lock);
 	mutex_destroy(&data->comm_lock);
 err_setup_spi:
-	mfd_remove_devices(&spi->dev);
+	mfd_remove_devices(dev);
 
-	dev_err(&spi->dev, "Probe failed!\n");
+	dev_err(dev, "Probe failed!\n");
 
 	return ret;
 }
-- 
2.34.1

