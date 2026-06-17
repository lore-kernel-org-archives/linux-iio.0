Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D11E348C54
	for <linux-iio@vger.kernel.org>; Wed, 17 Jun 2026 17:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781717267; cv=none; b=FyuXRZKbk4xsP13foqDxt+SkIs0seZcBgKmjLHoG/i5u2FCVi+rL86n31JLsJTeUf7Mcbk7co+PSDcm6p1Rqwu6GI2LGFuhC/llRug9wC+TZYbbLPqTwF/Ay8M7gzG+IO7+8Bxfde9m9PKoYeSLwNgc84na0mNSsIe/0JvjEAa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781717267; c=relaxed/simple;
	bh=hy0kUEdyAzGkpXs2bNUP9twvB0sX3g16t5dxLsuXeY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wyb6Vnucv0ipkLxfsucwNqKNZSBWWAVVvFaQyANJP69dJ8+MrxwHTAOOvbWhaUbALXVNf754OFlS/6NFhXEX8ihc2JykHH+E8OeaPz9FOO46xvhRxQjzaAOHmvfHxFarDjSiUXME27zGQjM3rtpdPHE2+5zBXSzLwvLKu5835r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I2Tl6S9a; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2Tl6S9a"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-45eea68dd6fso36737f8f.2
        for <linux-iio@vger.kernel.org>; Wed, 17 Jun 2026 10:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781717265; x=1782322065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wpagMfDboOlmTEBILYrzaPkkT8D8ogdxdbm3KFmEmxI=;
        b=I2Tl6S9a9GqV2BCb9QSkvkPdCxqLtooKKA3t7qpuZ59iYiLOHZMs97wI9DvajlKz5E
         Vs1NBwO6ed6E0KvhlJpiZr+XSNJuYWkXoguYEwmET8bWvnQEA+07IM2wM0qRv5IgCRhS
         umT5NPFV4YgqksPdYcsPNtsbjpZVknIEuvonxmDYRS9Nu1aqK9YEXWLIt1/QXeAYeFjN
         fMzghXmMZnIQGS/+tHoRPM+XqKQff0kQzSlxWoLarLPmY56ft7End+QOSbdI1K8YDIin
         lQGoZLjYcSTh6JO2jCamrKLNyUtLbDADN9c/QX5VnjHlG9SQY1AEPSdif1vn0QbSRK/9
         N3TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781717265; x=1782322065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wpagMfDboOlmTEBILYrzaPkkT8D8ogdxdbm3KFmEmxI=;
        b=P6psL9x/1oqc6KmgSz/OB6yuDbvjR8pEKrygOgF0t0TQT24mi25fCCQjPuhsBHfl/G
         eRjuQQQ9+AaHex7E8Dv4xKmoOjcE3+xbI8YLk7F24ukos6T6qdrk9ARR8uKGCg6XIwph
         fC/5iFtXPERU13pN3bvdGJton78GvYwbLbUcBLE5q0XFVKYRKgQEZ0NjVe7NkTuhzwi/
         8MGYTdsGha/m9kid2rFkDAGu13D29pc2IU2FQ09rDa7adhTYz8p7iFNegJjYwDYMK4T7
         JdRMezBwipeNSp9lGW5zKcQkm/5lEZ3+JCXVYm7+vYut2oLA3KTazZewJvWmvy8xQ115
         kC6Q==
X-Gm-Message-State: AOJu0YxFtwW+4LqpAHPVsewRY/T3eMFf0t4XMQl8L/r0YmhNyPubwenB
	tIFKK/L2vZx8sF+sZVn8mSEd3M2kYMabF7PQn8T+mRYtBlQd2Z5cb8+U
X-Gm-Gg: AfdE7cn17dln18wNbonrI76z+q/IhYzr308Fz+ffQIELWA8ArxFtGfnRVm9LBAirVyu
	MNz/3zhxBJpE72SBfxDazli+3Sl4TlPKBhtQiETqJcx3nEbLJ1XL013beG2siTqESoLZRvB40o6
	HagGxsaZmaC/r8pJmprVvYbX73VJoRnob8iFXTjypiLGnjF74yiQImYNs9AFFRoJ5979iZV5lk2
	liRg6mBcU7sDCKzBXzT2xuqmSMoFjEVKavoNCHomOdv6dqTwJLKdkabMU5wp0rrO8E+ckszskmL
	+6p2BLVNtE+xz+FTjudfLy8PPdmUQ7Uv3O+48kcKrZwax8ryM+sB0DUmgmPW6myNIaIvhpgx+0f
	hfTFRRJ7zkt8pgJiQOD4PSnbucWxS3H3E3VHEK4Gzv99n9XT4DmFHAdmLfG1J8LzfH01YGbZqAS
	3AZw1JhAOmqHi1cO1LcIqQjruUNTAuTs7pHPsU3ouOpGZe+mT0RwKXut4esyaRHPBjF0glmGWuO
	F0beg==
X-Received: by 2002:adf:fc8c:0:b0:460:138d:c9b0 with SMTP id ffacd0b85a97d-4623f2e7ed6mr6920805f8f.2.1781717264598;
        Wed, 17 Jun 2026 10:27:44 -0700 (PDT)
Received: from arch.lan ([91.230.98.156])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26f1cdsm58275428f8f.11.2026.06.17.10.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 10:27:43 -0700 (PDT)
From: Tomasz Duszynski <tduszyns@gmail.com>
To: andriy.shevchenko@intel.com,
	andy@kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	m32285159@gmail.com,
	nuno.sa@analog.com,
	tduszyns@gmail.com
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] iio: chemical: scd30: update email
Date: Wed, 17 Jun 2026 19:27:41 +0200
Message-ID: <20260617172741.115044-1-tduszyns@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617172138.114572-1-tduszyns@gmail.com>
References: <20260617172138.114572-1-tduszyns@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The old email has been inactive for a while. Replace all occurrences
with the current address.

While at it, add myself to MAINTAINERS as relevant driver files still
hold my address.

Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
---
 MAINTAINERS                         | 1 +
 drivers/iio/chemical/scd30_core.c   | 4 ++--
 drivers/iio/chemical/scd30_i2c.c    | 4 ++--
 drivers/iio/chemical/scd30_serial.c | 4 ++--
 4 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b051eccafa60..4cab384e8864 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24271,6 +24271,7 @@ F:	drivers/iio/chemical/sunrise_co2.c
 
 SENSIRION SCD30 CARBON DIOXIDE SENSOR DRIVER
 M:	Maxwell Doose <m32285159@gmail.com>
+M:	Tomasz Duszynski <tduszyns@gmail.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/chemical/sensirion,scd30.yaml
 F:	drivers/iio/chemical/scd30.h
diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/scd30_core.c
index 104a29550a22..1765cbbbb3b9 100644
--- a/drivers/iio/chemical/scd30_core.c
+++ b/drivers/iio/chemical/scd30_core.c
@@ -2,7 +2,7 @@
 /*
  * Sensirion SCD30 carbon dioxide sensor core driver
  *
- * Copyright (c) 2020 Tomasz Duszynski <tomasz.duszynski@octakon.com>
+ * Copyright (c) 2020 Tomasz Duszynski <tduszyns@gmail.com>
  */
 #include <linux/bits.h>
 #include <linux/cleanup.h>
@@ -763,6 +763,6 @@ int scd30_probe(struct device *dev, int irq, const char *name, void *priv,
 }
 EXPORT_SYMBOL_NS(scd30_probe, "IIO_SCD30");
 
-MODULE_AUTHOR("Tomasz Duszynski <tomasz.duszynski@octakon.com>");
+MODULE_AUTHOR("Tomasz Duszynski <tduszyns@gmail.com>");
 MODULE_DESCRIPTION("Sensirion SCD30 carbon dioxide sensor core driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/chemical/scd30_i2c.c b/drivers/iio/chemical/scd30_i2c.c
index 9e841f565149..406f650a0083 100644
--- a/drivers/iio/chemical/scd30_i2c.c
+++ b/drivers/iio/chemical/scd30_i2c.c
@@ -2,7 +2,7 @@
 /*
  * Sensirion SCD30 carbon dioxide sensor i2c driver
  *
- * Copyright (c) 2020 Tomasz Duszynski <tomasz.duszynski@octakon.com>
+ * Copyright (c) 2020 Tomasz Duszynski <tduszyns@gmail.com>
  *
  * I2C slave address: 0x61
  */
@@ -137,7 +137,7 @@ static struct i2c_driver scd30_i2c_driver = {
 };
 module_i2c_driver(scd30_i2c_driver);
 
-MODULE_AUTHOR("Tomasz Duszynski <tomasz.duszynski@octakon.com>");
+MODULE_AUTHOR("Tomasz Duszynski <tduszyns@gmail.com>");
 MODULE_DESCRIPTION("Sensirion SCD30 carbon dioxide sensor i2c driver");
 MODULE_LICENSE("GPL v2");
 MODULE_IMPORT_NS("IIO_SCD30");
diff --git a/drivers/iio/chemical/scd30_serial.c b/drivers/iio/chemical/scd30_serial.c
index e8b453aae859..05d9e0e9de1e 100644
--- a/drivers/iio/chemical/scd30_serial.c
+++ b/drivers/iio/chemical/scd30_serial.c
@@ -2,7 +2,7 @@
 /*
  * Sensirion SCD30 carbon dioxide sensor serial driver
  *
- * Copyright (c) 2020 Tomasz Duszynski <tomasz.duszynski@octakon.com>
+ * Copyright (c) 2020 Tomasz Duszynski <tduszyns@gmail.com>
  */
 #include <linux/crc16.h>
 #include <linux/device.h>
@@ -258,7 +258,7 @@ static struct serdev_device_driver scd30_serdev_driver = {
 };
 module_serdev_device_driver(scd30_serdev_driver);
 
-MODULE_AUTHOR("Tomasz Duszynski <tomasz.duszynski@octakon.com>");
+MODULE_AUTHOR("Tomasz Duszynski <tduszyns@gmail.com>");
 MODULE_DESCRIPTION("Sensirion SCD30 carbon dioxide sensor serial driver");
 MODULE_LICENSE("GPL v2");
 MODULE_IMPORT_NS("IIO_SCD30");
-- 
2.54.0

