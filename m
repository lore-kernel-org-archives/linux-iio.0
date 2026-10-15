Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A7849E146
	for <linux-iio@vger.kernel.org>; Thu, 15 Oct 2026 15:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792077621; cv=none; b=RQ+JeTnTZHIXs9LKDajvRJe2QhVXYIoqT2Pn3RCUTAHK+lV3zt7Lv+hnGx8D3vWTcZeAVEZvdzRTtNMLdCjAvFhAixMSj95FLLBS9bMtlrtPrr+eAcg/rZvX3Q9H0MBcHxL0LFSEPusAkW1tJ/Hk79MhxZHfsdyQHeLxwit0nis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792077621; c=relaxed/simple;
	bh=4NSUR17VCQVdZMTyKAJFDwPaPM61+d5u2XuQn5Nj6PI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i03H99XicURrKNgdC/5X8OpQvVn7dxhbD66xubcSEV5ESqlwMlsZqKFP7cXik+C2tZX9ZMBXtf++EWwirxJmXx1AYrbjWIMxOgtR+4s8AJBQiq/Kzvph1uX5Gsi4Hda2zdpqYzuDfsTRusRYueBbUQ5Vccog4MUAiHwNOnsr5h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AUKwHAIU; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AUKwHAIU"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a0e1b0681bso39584815e9.3
        for <linux-iio@vger.kernel.org>; Thu, 15 Oct 2026 08:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792077611; x=1792682411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rqM9JJ4Bu8nRxycdnvpW5GKXnWTBWTx9uL9yN9l3qfg=;
        b=AUKwHAIU/JqGordSLivWDyh0Fa4br1H8jQzKmPklBeduh8NXPl4ORAx3v+vX/VDMWe
         vlRUQZiNlc3/p/uAdFUQMBoFEJQ5xHZwMJxw/hQP1lOoUNd1vsgEOzaQsDxWd45kFqZk
         f/ddQlEJGK39s9mHUyk/UsSGJPLGcins5B5qImX4fzVrURfmJpf0fdk6y5IJvbggRIvL
         Kc8coCpBdUoQtK/3cLrqyP4ObACkCurW2i/j7e8Hw2FNza2VyyZrZ+0u4pJBnS1v9mbI
         lJR87NLBK/uklYOyn9qjy34wOS/0KExcKtFf+eNnL95nOZcKYaQoRkA0W0TDUsmenbLS
         g76w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792077611; x=1792682411;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rqM9JJ4Bu8nRxycdnvpW5GKXnWTBWTx9uL9yN9l3qfg=;
        b=P192DJV9qRCDvQ4Nq7Dxeui6/utiSTE2Yaocu51TUuvVnW4vO3xPjwsP8OSv5lxeGb
         E02ekax92mTWFV5W4rPPkwqXnVMd1iiqieST0mD4QlHf/wO3xOtQFF7W2uRoYUvIly//
         ZIGCl1eyirwkr4/abiUGORAhFy25AJL7jnV0nK3mMVo/xL6Q8RRCTIPY8d/JDp8fjBSx
         MgnYR3o24AS8h26ch0Vwu7tKjbMDEf4gw2bT2B2vA0BVVQJ2GWq1XWn0beDj3XjGPoQc
         CluoYp4a0tblFaLFgqa2XYRZldtcf1lMNPG/WtMYENTJi6EXaKfJUFMudG+nAOvGDPB8
         Kr+w==
X-Forwarded-Encrypted: i=1; AKwUvBzhuId3fdgFWUUtxKzHBjI2B99+BKwuzJzkuE5WJSTsDifQ6QYDWv35hFiQS8pXskxrM9L4FhA6Yuo=@vger.kernel.org
X-Gm-Message-State: AFq9FYIu3LSv+Y5Z8eg/MBjHjSpTyUL9skiZE2Nsxoppvj1v/Znl4Q5u
	Emtur1pviZv3ym8VPech6av3OOILmAQlumus+33JrZBqqnwnhITNVshs
X-Gm-Gg: AYBFou3Su0TM9YcItWO1ysyLjS9oZCnNDmt65IrA+EGokejrefJVHFHTLGD3qFumhe0
	F8tvbr/ZsShrdW2QjonTDGyu6B1S+Wj/+HM2XRpQVLxuOILOHfktXbV2Noo8dN9x3ON13O6RsB1
	TE0p0WzNps5eJvZFkPZJySDa7f7QkC0okpn8KQmnMU3bxI4YVn2cl3Ows2PqNtCMCpBtD9gy3sD
	3SWKBVlAs3Tc+55uhjTYhHzLUWwBZymmwgg5PXbCmvtjDDrKg9L1D61FJkKFLX6s9oVneFx2fTe
	cvw1qU6KmOJerCkazA9e90tTtdsFHpMT7ePn3BScC7NTqS0MXo9liAp8KEOKHNR3m6tqvuHrA77
	OM2g+YH1k7oDMJAuxnSvW99tZoXrbOPWkqfE6CHRmN0ofJnPClNHXmg31iRnp11k/Jfv2mppkLE
	7+qKhSF3sDQ/jLj7uUY+xgwm1EjLyg7c5oiW+Ts7cojZpofts/aC87d2dDypqEGxiLOrFVQFQ3t
	P17hj8vuYq2jLMGJrxciqjQyKzQllI=
X-Received: by 2002:a05:600c:19c8:b0:4a1:7bae:d80a with SMTP id 5b1f17b1804b1-4a18e47ad49mr400472685e9.9.1792077611250;
        Thu, 15 Oct 2026 08:20:11 -0700 (PDT)
Received: from fedora ([154.183.128.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd9a8a22sm88390005e9.5.2026.10.15.08.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 08:20:10 -0700 (PDT)
From: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: nuno.sa@analog.com,
	Michael.Hennerich@analog.com,
	dlechner@baylibre.com,
	andy@kernel.org,
	linux@analog.com,
	linux-kernel@vger.kernel.org,
	Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Subject: [PATCH] iio: adc: ad7606: use EXPORT_NS_GPL_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
Date: Thu, 15 Oct 2026 18:19:03 +0300
Message-ID: <20261015151903.13613-1-abdelnasserhussein11@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace SIMPLE_DEV_PM_OPS() with EXPORT_NS_GPL_SIMPLE_DEV_PM_OPS()
and use pm_sleep_ptr() to wire up the power management operations.

This allows dropping the #ifdef CONFIG_PM_SLEEP guards, simplifying the
code and improving compile test coverage of the suspend/resume callbacks
while still allowing the compiler to optimize them out when
CONFIG_PM_SLEEP is disabled.

Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
---
 drivers/iio/adc/ad7606.c     | 9 +++------
 drivers/iio/adc/ad7606.h     | 5 -----
 drivers/iio/adc/ad7606_par.c | 3 ++-
 drivers/iio/adc/ad7606_spi.c | 3 ++-
 4 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index cebb8ed8dcb1..e71ff8d38e4c 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -14,6 +14,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/pm.h>
 #include <linux/property.h>
 #include <linux/pwm.h>
 #include <linux/regulator/consumer.h>
@@ -1673,8 +1674,6 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 }
 EXPORT_SYMBOL_NS_GPL(ad7606_probe, "IIO_AD7606");
 
-#ifdef CONFIG_PM_SLEEP
-
 static int ad7606_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
@@ -1702,10 +1701,8 @@ static int ad7606_resume(struct device *dev)
 	return 0;
 }
 
-SIMPLE_DEV_PM_OPS(ad7606_pm_ops, ad7606_suspend, ad7606_resume);
-EXPORT_SYMBOL_NS_GPL(ad7606_pm_ops, "IIO_AD7606");
-
-#endif
+EXPORT_NS_GPL_SIMPLE_DEV_PM_OPS(ad7606_pm_ops, ad7606_suspend, ad7606_resume,
+				IIO_AD7606);
 
 MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
 MODULE_DESCRIPTION("Analog Devices AD7606 ADC");
diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
index 2951bb731354..c60f71a38883 100644
--- a/drivers/iio/adc/ad7606.h
+++ b/drivers/iio/adc/ad7606.h
@@ -241,11 +241,6 @@ extern const struct ad7606_chip_info ad7608_info;
 extern const struct ad7606_chip_info ad7609_info;
 extern const struct ad7606_chip_info ad7616_info;
 
-#ifdef CONFIG_PM_SLEEP
 extern const struct dev_pm_ops ad7606_pm_ops;
-#define AD7606_PM_OPS (&ad7606_pm_ops)
-#else
-#define AD7606_PM_OPS NULL
-#endif
 
 #endif /* IIO_ADC_AD7606_H_ */
diff --git a/drivers/iio/adc/ad7606_par.c b/drivers/iio/adc/ad7606_par.c
index 5b137e947f0b..986c15db90c7 100644
--- a/drivers/iio/adc/ad7606_par.c
+++ b/drivers/iio/adc/ad7606_par.c
@@ -11,6 +11,7 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/pm.h>
 #include <linux/property.h>
 #include <linux/types.h>
 
@@ -251,7 +252,7 @@ static struct platform_driver ad7606_driver = {
 	.id_table = ad7606_driver_ids,
 	.driver = {
 		.name = "ad7606",
-		.pm = AD7606_PM_OPS,
+		.pm = pm_sleep_ptr(&ad7606_pm_ops),
 		.of_match_table = ad7606_of_match,
 	},
 };
diff --git a/drivers/iio/adc/ad7606_spi.c b/drivers/iio/adc/ad7606_spi.c
index 8c479fa50a23..10df12311561 100644
--- a/drivers/iio/adc/ad7606_spi.c
+++ b/drivers/iio/adc/ad7606_spi.c
@@ -9,6 +9,7 @@
 #include <linux/err.h>
 #include <linux/math.h>
 #include <linux/module.h>
+#include <linux/pm.h>
 #include <linux/pwm.h>
 #include <linux/spi/offload/consumer.h>
 #include <linux/spi/offload/provider.h>
@@ -502,7 +503,7 @@ static struct spi_driver ad7606_driver = {
 	.driver = {
 		.name = "ad7606",
 		.of_match_table = ad7606_of_match,
-		.pm = AD7606_PM_OPS,
+		.pm = pm_sleep_ptr(&ad7606_pm_ops),
 	},
 	.probe = ad7606_spi_probe,
 	.id_table = ad7606_id_table,
-- 
2.54.0

