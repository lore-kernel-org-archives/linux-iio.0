Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C156038CFE4
	for <linux-iio@vger.kernel.org>; Thu,  2 Jul 2026 19:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783019877; cv=none; b=VZQY9coUIDF2eZqTRSPrGWJiGD68Qfz/6aBCBHEfPPXT2u1HIXCmFXj3M+GPcK0mI1ReItwjW7HdpawFOh46lRNLMNtvhcKp3oqXjSoxxUHuHLQn0rgrbaqJUkzgY1z6PxaScOcb4IG1JDQsP96VrtJyKO4jCShn1oCHPFHFyh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783019877; c=relaxed/simple;
	bh=fKEAmYihd8b27UnZ2k7bXYMOlH8bFzjnuX6+qxUd+fI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s6onkA50M1qSAkQ+87q8m85bMGsY4v0zxKCX2aoUSCfrWr5wFdew7bJI9Ekn2CkubT/F1seGtjKwVRCiX5E44rLvSJTuBZbD0F2cQdVBdwFQKC2zaKo+xDFS/wy9otc+nV1H0hGYMd/Iwbc5skHGifxdPUOAWJOdTIKTKPBb8MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J8BUCib2; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8BUCib2"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-493b779003fso10819115e9.3
        for <linux-iio@vger.kernel.org>; Thu, 02 Jul 2026 12:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783019873; x=1783624673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UYtJzIoz3BFKoJn5HD9gPGBtfcVmAhKjXkMxyrW005o=;
        b=J8BUCib2cv/8u/2l2s9nFPwdtbL6+QNxsp9dE6p6i50s8J/HbVTkPKWzUxOxBSH7So
         ak3CHNw1Lf3Be0Mrq9Tfj9oK3aZnZoidH1dxf+VXAgkdrQGyTQ5qytdT+i+4zOxvRVWU
         tDvysJjmaAg00EDs15m4ri9LziGmEMcrD/EZByKbs2i9bkTF5GBGu45OnVIhTUHtNhYL
         bnJG8y04VYuPUAFEZNpNcg18nZL325M4HXlK4LmrKjimGkH02IcoIluP2J/4Mc5I92P8
         2+VH2D9qx0o620oGvo2KipEe5CARNOWjLcrs2bdRqhcALa+4/pQlhv3CJKUh2oQ626lo
         ekTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783019873; x=1783624673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UYtJzIoz3BFKoJn5HD9gPGBtfcVmAhKjXkMxyrW005o=;
        b=dWE3EryxgKOz4jrf7RzWPYXkw0I2ZuYvSFTT/MFgBo+xSYfewp0rwcAnV+GToZ63nx
         gjKb0O5pH5jmv3cwITqBO5E8rP1eovP1qi6cmnKUiZwoDeqCvu/+Yv1LTqgVywbvbT1l
         3TH3BStrFEaIW4iHs/x8jLRuDko8jwYgqNVI/mI7ca9p7VpNuLhn/pdthZZYQhzBpvWY
         Rva5cE/cAs5Sb13OsMZSfqFyJIbay+3Gk6lX43sX8Ahlikn6Ct8d28GtwdFofIF1t/LB
         jEDcDqHiAdHPN/Ma7CXUbb8ZZcXCaC9CsUok/aO0C7pPBD50IIXGvy4P1m6oa1Z+30OW
         I0mw==
X-Gm-Message-State: AOJu0Yzj5mrmDs1JqkXko3aL7D8uws89AuL5rzdTDe6wh+8C794/R2Uv
	jY4W6MzIJpHciv8eJJf03L5KVPfBhjPQtvmUsoXTRjzFAlWSt7XhgjH6
X-Gm-Gg: AfdE7cn6ggUWOC0kgyl/1lkFWDPvAGbn8s5GxRIa5qFVcZMpwZ9hheL88XeHYmIAfMR
	zS8GYWu5VtYrBEp9y90hRUO8LBZGoZG4jGmetukdbRpdQ6999bc5GFidA22+95Irmjear5p6Fra
	fz9QPr9/jlaD6CmvxMuqUwkRJFU8K6KfECq+q/xma6YnnyN26lSo3R24/0xYxsMx0gXFWf6zCqz
	UNUTRLyjxKKmyzepr8Ch314siFT30SW6Pi1m7iR0YJMld4xlCtPmUSYPVn3wXNuuNvS0WdffMSc
	LUpVYze9qtjEjyZWGl2KwqN0ZD4SfNwTkPt7QTmhcK7VVgjK3HkbOSsbgUO19AZ0rBh00W2X3Rk
	B/bwJaKylqH6hRZ7ijiLzC/lIXuguJemi/39cqrUhCs6QGF3p5K4f/TTltSA0neA5ijTZau+d0M
	5ZHXEMo3cxXJpIO4PbR/Beank/RH1sCcVcLhp4yiwryBUjqgXdrTFA3gxQ385T9s9vLyM=
X-Received: by 2002:a05:600c:5010:b0:493:72d3:4a81 with SMTP id 5b1f17b1804b1-493c2b5161emr102988395e9.16.1783019872957;
        Thu, 02 Jul 2026 12:17:52 -0700 (PDT)
Received: from arch.lan ([91.230.98.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c6368f89sm64678805e9.8.2026.07.02.12.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 12:17:52 -0700 (PDT)
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
Subject: [PATCH v3 3/4] iio: chemical: scd30: update email
Date: Thu,  2 Jul 2026 21:17:43 +0200
Message-ID: <20260702191744.118898-4-tduszyns@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702191744.118898-1-tduszyns@gmail.com>
References: <20260702191744.118898-1-tduszyns@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The old email has been inactive for a while. Replace all occurrences
with the current address.

While at it, add myself to MAINTAINERS file as relevant driver files
still hold my address.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Acked-by: Maxwell Doose <m32285159@gmail.com>
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
2.55.0

