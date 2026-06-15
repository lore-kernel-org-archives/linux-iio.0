Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266973B585C
	for <linux-iio@vger.kernel.org>; Mon, 15 Jun 2026 20:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781553928; cv=none; b=EKaxlNYlHdasZ8w4nZFiWwkAS24itvJ/92iUGHaXruzNOg+O7pd3B5wHzr/bMU0lSE8D0G5RmrRey3udaLIkBweXezZFZTZdq5EvpTotBUtst3L0uJqYxijYZxhuIsM2MCJUHLVstI+dOZAftbFOY+OYPWSI/lQ0LmiprhMtmBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781553928; c=relaxed/simple;
	bh=hy0kUEdyAzGkpXs2bNUP9twvB0sX3g16t5dxLsuXeY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LssZgwP8eKjej2O6OmdUq3z6oqe4qx9wMhgIBOhVNY0R64UJIJPUwzgbbJdX5EOrnmCb0ehA9JAbrWu3BdHkz3TuKh/wWZ42CzD1ohFRYxuLPeJjouOUH6yo+8Ae/XHCopS+KR1yK8bPc9QPNjBFIXDW59aBGvetnHMYcXkQdlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iP+CH8NE; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iP+CH8NE"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-45efb698ef2so1986687f8f.3
        for <linux-iio@vger.kernel.org>; Mon, 15 Jun 2026 13:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781553925; x=1782158725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wpagMfDboOlmTEBILYrzaPkkT8D8ogdxdbm3KFmEmxI=;
        b=iP+CH8NET3bhRHzAa6fURZ4HozcHjXWMYVrSyfMREXqEvBQgUeRzrVa06d9vmC3f57
         +JWEDLK36Mvis0/yWicuW11QSr3r9m8svbXy1UMSU0jGOWsLaM7KnOzmhUA+Da83u1N3
         VN9nMzxlVApCfSCHwdz1hX/+8QWor90vS3RUNdY1UQc5yVmLHvBB+HJcWIpqeXSJK6je
         8BSb7aUTkr/HDx948qBacIBJEsA+QAWdhd8HF96vf9eVEvmcrx/wKFMcMtvHJ2VDQQ0w
         BfLyMVEvqjAhWQt5NDZ56lA0HMmFauHSh6HkbJ4HXeoUb7gxPTUDgysLxjYd9V2FpEOV
         bAug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781553925; x=1782158725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wpagMfDboOlmTEBILYrzaPkkT8D8ogdxdbm3KFmEmxI=;
        b=IeznDNN2lEkA8+BxV9mGynn75Z+IyyT35aJzeeNvFvU33WIFw6oLOFEXIbuc9ulwvp
         S4AOvj2MRvK3NU1U6NogbD2qdMoXsmbEP8cFPpWdhRDMpbEY5PL0ItBmvIUDr6pQDTYa
         FUQThLcTh39smdtevjvQ4QusgSGkAy8IpzGK95wEgGxy6jKUbBdS7egs9WjjsfuMMYTk
         gOriWOsu59/AzHYaen4mDmC053p6VxEgtusJ4YOvgFexnpXVF8gbwF5WW7p38s7MQvym
         wSJc0DH2DVID2T7+2ygCDvGF6U+ZJswn/FEKfcoDsW6pAT6i+g3WARAGGCJkMkOMQqgJ
         z6/A==
X-Forwarded-Encrypted: i=1; AFNElJ9h69W2i6ufBSdEVsYj3ppdIqKRSo9o6a0u4s1qOU6MIIKiRWbK0GNO2AN8Hnw7CYfdopK7LyAwmqc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyxvtk2w6jkxDpJPnC0xyLD/y67tvxk2duOPAi+WQqfGBaPLs9
	2Tzqf3DRMtsZCULtwRrifUqiDk5hY2VmUxzZz0AEEYNP8dqlY1ANaYN8
X-Gm-Gg: Acq92OHOraa86tQLWQTLAr1rRvVugVdiucRtCIZRr/9URRalrql014ouPl7grvZ96N/
	+nFUs1dFCrABUjL+MciuEg9TNKPk7AcjoZmiyrE4mAmUmEu4ZarqrRKfRUQF2bOBcYKaQwHnne9
	zL3vHvW4oTgdGZE+hjY22UIWB1SVTv9f+Z4ekORT0eWKuTdngrhgW3ThvmBNIcMa5EZgBWmeFoP
	IZShhla+8snLkwt3PFFcHQA1wWmaqifAMkmh9shNGdaeDWoMOtnBy2UaBXvwI99MaknmudmBd8E
	O4Dx86Y2zE9Oeb+4AZ10wKz3CC0fK/utD8CIMw+QUA0lUnSi/NaDMZumxxh2EV67hBSM+YB5Y+d
	LIoT77bZYJxZXSjnZJxT5EUXkDBy/rpfc6sYlMHw+n/1fG9uyqsoGtzDtbBN34vvXt8Q5Vaphrp
	h9gIaqp7HTDE4FSPZsjcmtb0yOktboeqRJm5Spqgx8eTpxCM1nM7aTBINUo0nenhYZjG1Lus+bQ
	QS3UA==
X-Received: by 2002:a05:6000:4a05:b0:460:1223:a044 with SMTP id ffacd0b85a97d-460749fab6amr17635560f8f.0.1781553925504;
        Mon, 15 Jun 2026 13:05:25 -0700 (PDT)
Received: from arch.lan ([91.230.98.156])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2e592csm40267547f8f.36.2026.06.15.13.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 13:05:23 -0700 (PDT)
From: Tomasz Duszynski <tduszyns@gmail.com>
To: m32285159@gmail.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Tomasz Duszynski <tduszyns@gmail.com>
Subject: [PATCH 2/2] iio: chemical: scd30: update email
Date: Mon, 15 Jun 2026 22:04:59 +0200
Message-ID: <20260615200459.8272-3-tduszyns@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615200459.8272-1-tduszyns@gmail.com>
References: <20260615200459.8272-1-tduszyns@gmail.com>
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

