Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7114A4EF8
	for <linux-iio@vger.kernel.org>; Fri, 16 Oct 2026 13:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792156439; cv=none; b=IA9SinTUlbXMj+ECfbzVuXjwwuSDf5UzM+ImRvyOidiOvpc0KJ9qYjEj6Cv3ZY2kat+64q26qEcmIPmidOfKftK5p3YcopW2tqE5M1UssZ/eX1E3ohe13D67IjF8sJSZKdxIG6COSB5mgXyJA1DK8tcmqU6zvRjWZ3RHLdvVZhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792156439; c=relaxed/simple;
	bh=OtTFm0LSZUNZH63H0Uw8cqyMYSJbGUhZTDNmmpiEMWc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XQ7+pIEysZkuEp0ap62LFG/vEfbChR3MF+gHdhAxCeGz5qsM8hDoy1xDvzBTyh9H9rLZkENh41d/M4DBgbXrhy//DAfRVYzNKECiv9FBghDoqIIhgcaB68HsVZ03/tftF7Jo7K6GUrbJJi7nC5ez7dvVWc5ezd1ew6wcS55GNbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SnL1/Ezd; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SnL1/Ezd"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso30317405e9.3
        for <linux-iio@vger.kernel.org>; Fri, 16 Oct 2026 06:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792156436; x=1792761236; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HzgE9v7hmTq0+RYDnaatbRXXJ6uJY4tNBCa/XH5HTdk=;
        b=SnL1/EzdYwpdGQRyMNjQPKL09cVuFfn1gnRhKjT2btpHlZJn35k+hOl3/bL8KuckEy
         guqJauMRfF/cS7jzr/OYj+jpEMu7o24pQKUuSzF3489FKTxg4zSgoHwPG/HDszoVlSBL
         cK6bme9ZBrDZwtdTZC7aDFvKHwqv4KbBrj8kLTy8ajLwVfE6397mSLd6Uvw8sEik4hcO
         4Muo+VFXK618yYKD75eME9T3pVBQpABlMgwTslec6xP7zoipJUwEr4oKW8uTF9+t6Cjx
         LJaCyn4dnyNZVLwCFSE+PXCFoUQlNEMkINSAL+mCJvYy8XR8Ej+UdAEacy0fEr7sjCRX
         MXlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792156436; x=1792761236;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HzgE9v7hmTq0+RYDnaatbRXXJ6uJY4tNBCa/XH5HTdk=;
        b=OG6zs3Jiwuuwxuy/IPa7bwVkUXGEx3D1O944pprke3/8Mx2vQk5NNNfLZKGrwR7BKV
         8fqpQ5kR5ZDzvHhswsrY3ez42nT22Oba/vyEw5FQ9UKliytyd9VNFQLX0akYVfGdjH6Y
         Chdmn7pi5EXMo9VEsCppdImSmOvvUphyJLwx4WpcaKQP3uK9g24rk+Q+U7BiGLEuXkwo
         q+qi02/AeU/DjvqkH7oFA9yxe/W4+r6Cx9G941hGkJW9NjbpES5uGp4g2gDoGHuYMF+m
         OBSn7y17NgYVf/glVsZV49cC7x1PcqIA2TScDvp2FkvXIVv2wJ08xBLiJCuIGQgAOf5F
         6TRg==
X-Forwarded-Encrypted: i=1; AKwUvByb6rRKY6ERGl3leAG/WvaY1aDMtd8pf/eBw/bEeWtMuq6HSF9ZEyfS1fC4HQXZPBfjPkqGcYuWAeo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJcEIxPt1oYnoTDGuDCkLFCxHqtQK1w/lMpHXITewuscNKyTJkU
	m+j5LH323Af4LvICqS/2oITsJ3S1uUk8Kj+T5yd5vKNuaK4vbuc8dRww
X-Gm-Gg: AYBFou20jRpN1IF25eNY4xIzWL2tJabTf/8ODerDJ+EyJ/UQcpjFVCaC4CFBQREzK7H
	51AgcMtO9CD4aEC4zsz6xn2SjutDV5Wn6VHeXD+eAkw1B1X2xGvbk+zmWVs8vyP4cxq2mAbdeVG
	UEyK86PS7KyYp9W2piZ4BSQwj6cbPvgA3tG9lJ2W4R2On9JZq2MqRGRCej4OQk1IFaM1AgJpKI4
	yE48MA21mf0j/AjXOEWFdmSEtAkOb2hNPUTRqHCLjE79aCrYk/KgDrYe8PAj2p2/KJpq5WvqJTB
	r7w3TEvf6MDzSPPYY2IkSezujAMhM5/HQl2IhjO66aDP3sCzQb99pxK+JyGAQsASZPsMkyY8kuS
	nNTMnKBbR+55gNFfu7us3+TkUFcpc01ilZL3+8sVOkQ9pbqZOReU1Bf8S8/r9RSeCYIvmUqPt+W
	Ufv2iM8eXy8/2PtRtuvL+/TTi1GFauZs2NfuL3Z+CT6VLMSCivPXAvwAU4RbC/1/MMLi+Gwbzi5
	pJf6zoJHxUwYcOQk73AnjhjxrsGWA==
X-Received: by 2002:a05:600c:c165:b0:4a1:706f:b40d with SMTP id 5b1f17b1804b1-4a18e4988ecmr446677645e9.7.1792156436275;
        Fri, 16 Oct 2026 06:13:56 -0700 (PDT)
Received: from fedora ([154.183.128.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4c5942sm7983341f8f.16.2026.10.16.06.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 06:13:55 -0700 (PDT)
From: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: nuno.sa@analog.com,
	Michael.Hennerich@analog.com,
	dlechner@baylibre.com,
	andy@kernel.org,
	linux@analog.com,
	linux-kernel@vger.kernel.org,
	Abdelnasser Hussein <abdelnasserhussein11@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v2] iio: adc: ad7606: use EXPORT_NS_GPL_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
Date: Fri, 16 Oct 2026 16:13:34 +0300
Message-ID: <20261016131334.8029-1-abdelnasserhussein11@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Replace SIMPLE_DEV_PM_OPS() with EXPORT_NS_GPL_SIMPLE_DEV_PM_OPS()
and use pm_sleep_ptr() to wire up the power management operations.

This allows dropping the #ifdef CONFIG_PM_SLEEP guards, simplifying the
code and improving compile test coverage of the suspend/resume callbacks
while still allowing the compiler to optimize them out when
CONFIG_PM_SLEEP is disabled.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
---
Changes in v2:
- Put EXPORT_NS_GPL_SIMPLE_DEV_PM_OPS() on a single line.

 drivers/iio/adc/ad7606.c     | 8 ++------
 drivers/iio/adc/ad7606.h     | 5 -----
 drivers/iio/adc/ad7606_par.c | 3 ++-
 drivers/iio/adc/ad7606_spi.c | 3 ++-
 4 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index cebb8ed8dcb1..4a4a71256f8e 100644
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
@@ -1702,10 +1701,7 @@ static int ad7606_resume(struct device *dev)
 	return 0;
 }
 
-SIMPLE_DEV_PM_OPS(ad7606_pm_ops, ad7606_suspend, ad7606_resume);
-EXPORT_SYMBOL_NS_GPL(ad7606_pm_ops, "IIO_AD7606");
-
-#endif
+EXPORT_NS_GPL_SIMPLE_DEV_PM_OPS(ad7606_pm_ops, ad7606_suspend, ad7606_resume, IIO_AD7606);
 
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

