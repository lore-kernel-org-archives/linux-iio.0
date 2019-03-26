Return-Path: <SRS0=TPgR=R5=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 750BEC10F06
	for <linux-iio@archiver.kernel.org>; Tue, 26 Mar 2019 10:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43FA320866
	for <linux-iio@archiver.kernel.org>; Tue, 26 Mar 2019 10:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cnQ3koZt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731148AbfCZKRP (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 26 Mar 2019 06:17:15 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52824 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731003AbfCZKRO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 26 Mar 2019 06:17:14 -0400
Received: by mail-wm1-f65.google.com with SMTP id a184so11939369wma.2
        for <linux-iio@vger.kernel.org>; Tue, 26 Mar 2019 03:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3FuoTdxdgrSIz8LEOIAnwc6QDsOzlUpwDf9yyB40/K0=;
        b=cnQ3koZtzi+LMqR0gmraF/aTYn0Hz1iHaSZ3fY4FtnDMtc9ovi6mMIshctAXwxcOnH
         HX7Fyk+bVw+r4BfSqczjKSfON6gzaU9H466JlsjBU/xb24LOg4bcpyzimVeaNCGswU7N
         Sy+LPF70ZLUwtHKsJzY/VYDrV0J5IoyIlJLTWAlBe4vjqX+ju81h0nw+TctWqxM9cyNG
         7MPm5Ep0yhziLNgLdBSKC0YrnwSd4ZGcE+WTB2+VIn/NB9iFD7ZJG9iAW/yT4mkyGNfI
         ouwDw8A/Le+gX236R+8tdappQhfSvz3l11uzIUDcAQdtHag7uidiiMFTIJ3NX8MtU0Bt
         s4uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3FuoTdxdgrSIz8LEOIAnwc6QDsOzlUpwDf9yyB40/K0=;
        b=CozSAqkqQwlNcQZPgJbW/NGmZ8utTzanUq7F/rdG5jBS8IdIZIMbANCReMSeD34KAA
         40NFR/6l5qg0gQKWsRiLHJzU36TT+I+kjYOuiFAiwR69iTmrGXsWL4+VZy2DOg57jTGp
         wNYwxuSr07OG347stRWOozvStOtUand+Fh5sI6I7aROpBhP3d29Io8GXhshE7w1dNCPl
         G7RbZcS63JdRmr5OkbURsUo+QlX2IbwIQEAMLv+T48Gyo8b7EKHOCaJEh+ki52ERWa6u
         F+o0AQUfBej+4cGcxrhrFi9hSh1C+mgFCiGOEjmpWiD+3xaspX9NXLeDKs4nKFmNDtd2
         BnYw==
X-Gm-Message-State: APjAAAUR0Y+79bMfs41MxzhPpv2NC8Apo2L1fvdKBzSl0BAxfMb7zg9T
        5qxvvigaTkrJgxS8vrKf/ax3qQ==
X-Google-Smtp-Source: APXvYqzT1KyGds1Fdg7ecB9lQSY5AyYWbU0abhjl1IetoQj1tbIeLG/T0oMNk9zhTdtgRHufp3DhyQ==
X-Received: by 2002:a1c:c707:: with SMTP id x7mr12421316wmf.149.1553595432226;
        Tue, 26 Mar 2019 03:17:12 -0700 (PDT)
Received: from arch-late.local (a109-49-46-234.cpe.netcabo.pt. [109.49.46.234])
        by smtp.gmail.com with ESMTPSA id j1sm22281024wme.4.2019.03.26.03.17.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 03:17:11 -0700 (PDT)
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
Subject: [PATCH v5 3/6] iio: gyro: fxas21002c: add i2c driver
Date:   Tue, 26 Mar 2019 10:16:48 +0000
Message-Id: <20190326101651.25056-4-rui.silva@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326101651.25056-1-rui.silva@linaro.org>
References: <20190326101651.25056-1-rui.silva@linaro.org>
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

