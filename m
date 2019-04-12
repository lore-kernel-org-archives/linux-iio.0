Return-Path: <SRS0=K6jb=SO=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE477C10F0E
	for <linux-iio@archiver.kernel.org>; Fri, 12 Apr 2019 16:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAB8A20850
	for <linux-iio@archiver.kernel.org>; Fri, 12 Apr 2019 16:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VuyBPgUy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfDLQtT (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 12 Apr 2019 12:49:19 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36002 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbfDLQtT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 Apr 2019 12:49:19 -0400
Received: by mail-wr1-f65.google.com with SMTP id y13so12833687wrd.3
        for <linux-iio@vger.kernel.org>; Fri, 12 Apr 2019 09:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3FuoTdxdgrSIz8LEOIAnwc6QDsOzlUpwDf9yyB40/K0=;
        b=VuyBPgUy+H4L3MXlBdVMhaPKhpyBnmsDZO8p/2jfWfQhYnf8NE9aU8ayCfJr5lWKur
         ymQt00B4+WuYI+y+61cFgOTZxf/A6I5x58zddw8qOux0gsZiwGs5A5+QdTjRtQ6QtH3Z
         v6s6hElHl/U/fESsqufZtHHPO24Fslhed+lXLzmfngKAc5SIevnaKT8Rj+CUV6Ov0NSc
         HMqdOK03eGYJjqGZzpnE2Lz7hz111oSQhoxdLfgfnLCz91MPx+29C9ZVcyWuShIdPdQt
         /SODIrNKnaNOA4PExf9MgMCfoJb4Re3SI7VOc/APFBciXpZ1zMGF05wWUNZfptoyccc3
         D0Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3FuoTdxdgrSIz8LEOIAnwc6QDsOzlUpwDf9yyB40/K0=;
        b=QVhMHjgftqIE5jasZk65mJuaIvMURgLi1s2KW8VXh1b8Vmge30auDLcnZb+ug4JtGT
         BDgkrHamyyixilhrv7gqO3YGQxSj3NJzwsebtDUNDcwg3EiBcCeKVS/fXgv6ImZ3wRmA
         ZHr9qrZVlDzOZ+tmUgMw6t5pB5QplkZu2qEjQAPOyv7enrg3GNkX7pfJQOpUaqtIXgK0
         QD1O6xZL99XbgxpUkmGXIdoZAAJnGKHCgfT0suYUFyZNNHwTEZKcluBQ8aoOlQcYo1MJ
         aY77iDnhK3lnLRbwNYPZwSjsPGAoygeblQ+p93mTThOR3uXVqDEYji73rjxuXKzW0lNl
         /UEQ==
X-Gm-Message-State: APjAAAVLpdkb1UuyQnFneE5jZaJ+hl1jh3T8xuO+uXHpSfOKPrppyUBb
        hVlTd3Hi4E5XPN0EsZKpM5zvyg==
X-Google-Smtp-Source: APXvYqzvqLH9DX3hbPOOAFvSQ9th6B+C/uRYumYSdyRWWpgZBBSkvPNElEy7c4A6PNg1Pju8klPbRQ==
X-Received: by 2002:a5d:4f07:: with SMTP id c7mr8391671wru.104.1555087757239;
        Fri, 12 Apr 2019 09:49:17 -0700 (PDT)
Received: from arch-late.local (a109-49-46-234.cpe.netcabo.pt. [109.49.46.234])
        by smtp.gmail.com with ESMTPSA id h10sm73863141wrs.27.2019.04.12.09.49.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 09:49:16 -0700 (PDT)
From:   Rui Miguel Silva <rui.silva@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Rui Miguel Silva <rui.silva@linaro.org>
Subject: [PATCH v6 3/6] iio: gyro: fxas21002c: add i2c driver
Date:   Fri, 12 Apr 2019 17:48:58 +0100
Message-Id: <20190412164901.2321-4-rui.silva@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190412164901.2321-1-rui.silva@linaro.org>
References: <20190412164901.2321-1-rui.silva@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add the real driver to talk over i2c and use the fxas21002c core
for the main tasks.

Signed-off-by: Rui Miguel Silva <rui.silva@linaro.org>
---
 drivers/iio/gyro/Kconfig          |  6 +++
 drivers/iio/gyro/Makefile         |  1 +
 drivers/iio/gyro/fxas21002c_i2c.c | 69 +++++++++++++++++++++++++++++++
 3 files changed, 76 insertions(+)
 create mode 100644 drivers/iio/gyro/fxas21002c_i2c.c

diff --git a/drivers/iio/gyro/Kconfig b/drivers/iio/gyro/Kconfig
index cfd2cf44bac8..71b6552ee06b 100644
--- a/drivers/iio/gyro/Kconfig
+++ b/drivers/iio/gyro/Kconfig
@@ -77,6 +77,8 @@ config FXAS21002C
        tristate "NXP FXAS21002C Gyro Sensor"
        select IIO_BUFFER
        select IIO_TRIGGERED_BUFFER
+       select FXAS21002C_I2C if (I2C)
+       depends on I2C
        help
          Say yes here to build support for NXP FXAS21002C Tri-axis Gyro
          Sensor driver connected via I2C or SPI.
@@ -84,6 +86,10 @@ config FXAS21002C
          This driver can also be built as a module.  If so, the module
          will be called fxas21002c_i2c or fxas21002c_spi.
 
+config FXAS21002C_I2C
+       tristate
+       select REGMAP_I2C
+
 config HID_SENSOR_GYRO_3D
 	depends on HID_SENSOR_HUB
 	select IIO_BUFFER
diff --git a/drivers/iio/gyro/Makefile b/drivers/iio/gyro/Makefile
index 247dc600a602..adc18a5eb283 100644
--- a/drivers/iio/gyro/Makefile
+++ b/drivers/iio/gyro/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_BMG160) += bmg160_core.o
 obj-$(CONFIG_BMG160_I2C) += bmg160_i2c.o
 obj-$(CONFIG_BMG160_SPI) += bmg160_spi.o
 obj-$(CONFIG_FXAS21002C) += fxas21002c_core.o
+obj-$(CONFIG_FXAS21002C_I2C) += fxas21002c_i2c.o
 
 obj-$(CONFIG_HID_SENSOR_GYRO_3D) += hid-sensor-gyro-3d.o
 
diff --git a/drivers/iio/gyro/fxas21002c_i2c.c b/drivers/iio/gyro/fxas21002c_i2c.c
new file mode 100644
index 000000000000..a7807fd97483
--- /dev/null
+++ b/drivers/iio/gyro/fxas21002c_i2c.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for NXP FXAS21002C Gyroscope - I2C
+ *
+ * Copyright (C) 2018 Linaro Ltd.
+ */
+
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+
+#include "fxas21002c.h"
+
+static const struct regmap_config fxas21002c_regmap_i2c_conf = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = FXAS21002C_REG_CTRL3,
+};
+
+static int fxas21002c_i2c_probe(struct i2c_client *i2c)
+{
+	struct regmap *regmap;
+
+	regmap = devm_regmap_init_i2c(i2c, &fxas21002c_regmap_i2c_conf);
+	if (IS_ERR(regmap)) {
+		dev_err(&i2c->dev, "Failed to register i2c regmap: %ld\n",
+			PTR_ERR(regmap));
+		return PTR_ERR(regmap);
+	}
+
+	return fxas21002c_core_probe(&i2c->dev, regmap, i2c->irq, i2c->name);
+}
+
+static int fxas21002c_i2c_remove(struct i2c_client *i2c)
+{
+	fxas21002c_core_remove(&i2c->dev);
+
+	return 0;
+}
+
+static const struct i2c_device_id fxas21002c_i2c_id[] = {
+	{ "fxas21002c", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, fxas21002c_i2c_id);
+
+static const struct of_device_id fxas21002c_i2c_of_match[] = {
+	{ .compatible = "nxp,fxas21002c", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, fxas21002c_i2c_of_match);
+
+static struct i2c_driver fxas21002c_i2c_driver = {
+	.driver = {
+		.name = "fxas21002c_i2c",
+		.pm = &fxas21002c_pm_ops,
+		.of_match_table = fxas21002c_i2c_of_match,
+	},
+	.probe_new	= fxas21002c_i2c_probe,
+	.remove		= fxas21002c_i2c_remove,
+	.id_table	= fxas21002c_i2c_id,
+};
+module_i2c_driver(fxas21002c_i2c_driver);
+
+MODULE_AUTHOR("Rui Miguel Silva <rui.silva@linaro.org>");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("FXAS21002C I2C Gyro driver");
-- 
2.21.0

