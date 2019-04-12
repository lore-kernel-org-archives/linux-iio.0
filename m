Return-Path: <SRS0=K6jb=SO=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A23AC10F14
	for <linux-iio@archiver.kernel.org>; Fri, 12 Apr 2019 16:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19DF820869
	for <linux-iio@archiver.kernel.org>; Fri, 12 Apr 2019 16:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tpDfdMmb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbfDLQtV (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 12 Apr 2019 12:49:21 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39644 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbfDLQtV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 Apr 2019 12:49:21 -0400
Received: by mail-wr1-f66.google.com with SMTP id j9so12804403wrn.6
        for <linux-iio@vger.kernel.org>; Fri, 12 Apr 2019 09:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WAPVaWgzUO2VZ+rDT4jNyOi+EGyhB4RKVLvR+cRCnoQ=;
        b=tpDfdMmbCxuDFBNNFrqWfGi5FkKz1/XXso7X9eNAQFGw2o3Ovy0dP6zeqYjLNjOE+j
         qNQ+aZ+tar2rxbja5ZTLrmz/TkBMXQXvEWkvd732eWmPWhQyK3JGAUA2LAvSnfVeSGcG
         zzdKWjcoYGcPC5fvJsWehF8GjDAIRuUF2kYP1pzxo30brzG87a1iUv2aDDyX53v6P50V
         wnKBoR2iXA8GJaQJ7YHaW+bE5Bz7YbWTwPlghnSbWGtey60ZC6L6eXhvmqpfDs/yswvb
         yMzdj4ilzVFDI45Rid0eOnlczvv0OBpL+XNXOM1Hz/S9StThUy0t+S9C+lpx5LK3YCfz
         bh9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WAPVaWgzUO2VZ+rDT4jNyOi+EGyhB4RKVLvR+cRCnoQ=;
        b=kkEI8i1G2QdNTRLdKTLTrVSgnS7bEN3TPo27+pl+UcFxQcN6IzPgz8MOC6/jIRUprE
         baCRHha7VvrgsSa6NBhyO9kOe99f7Md5TdKv4zhr2QLmUSylHqZvU6PK4+d80lG9yBhR
         LNadYQ93yr8XuPsqoB4MSir6NKZyb0lFv7//iPgMZuJmCFs73N7/DFuKG0xeA9TUGofe
         2gf6sODeCtE3/uVvsC+Btky69B+s72hCznId+GDwiYGhlRNfJTxLuNXLNBmPnCDIWF/Y
         jz0sexeOR/902qUhc8UwbfGmDnywmcbAkPZ69lknswheKY8Mi345096jzvHWlBqmtytB
         8bOw==
X-Gm-Message-State: APjAAAVltspF+/0Br77fDBRJLx66cCuDbBu0S+1UHeTUx+DYFho/dbnJ
        OdpR1KkQffA7W4AxQwiqdXrbRA==
X-Google-Smtp-Source: APXvYqy9USuVOQpScV1Fgw13sco7cnJlDd2ddonMGbjvije7mvKM2b4Rya4jU+XUWrI6zgPaXo/9hw==
X-Received: by 2002:adf:f78d:: with SMTP id q13mr36416522wrp.194.1555087759475;
        Fri, 12 Apr 2019 09:49:19 -0700 (PDT)
Received: from arch-late.local (a109-49-46-234.cpe.netcabo.pt. [109.49.46.234])
        by smtp.gmail.com with ESMTPSA id h10sm73863141wrs.27.2019.04.12.09.49.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 09:49:19 -0700 (PDT)
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
Subject: [PATCH v6 4/6] iio: gyro: fxas21002c: add spi driver
Date:   Fri, 12 Apr 2019 17:48:59 +0100
Message-Id: <20190412164901.2321-5-rui.silva@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190412164901.2321-1-rui.silva@linaro.org>
References: <20190412164901.2321-1-rui.silva@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add driver to talk over spi to a fxas21002c gyroscope device and use
the core as main controller.

Signed-off-by: Rui Miguel Silva <rui.silva@linaro.org>
---
 drivers/iio/gyro/Kconfig          |  7 +++-
 drivers/iio/gyro/Makefile         |  1 +
 drivers/iio/gyro/fxas21002c_spi.c | 70 +++++++++++++++++++++++++++++++
 3 files changed, 77 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iio/gyro/fxas21002c_spi.c

diff --git a/drivers/iio/gyro/Kconfig b/drivers/iio/gyro/Kconfig
index 71b6552ee06b..61c00cee037d 100644
--- a/drivers/iio/gyro/Kconfig
+++ b/drivers/iio/gyro/Kconfig
@@ -78,7 +78,8 @@ config FXAS21002C
        select IIO_BUFFER
        select IIO_TRIGGERED_BUFFER
        select FXAS21002C_I2C if (I2C)
-       depends on I2C
+       select FXAS21002C_SPI if (SPI)
+       depends on (I2C || SPI_MASTER)
        help
          Say yes here to build support for NXP FXAS21002C Tri-axis Gyro
          Sensor driver connected via I2C or SPI.
@@ -90,6 +91,10 @@ config FXAS21002C_I2C
        tristate
        select REGMAP_I2C
 
+config FXAS21002C_SPI
+       tristate
+       select REGMAP_SPI
+
 config HID_SENSOR_GYRO_3D
 	depends on HID_SENSOR_HUB
 	select IIO_BUFFER
diff --git a/drivers/iio/gyro/Makefile b/drivers/iio/gyro/Makefile
index adc18a5eb283..45cbd5dc644e 100644
--- a/drivers/iio/gyro/Makefile
+++ b/drivers/iio/gyro/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_BMG160_I2C) += bmg160_i2c.o
 obj-$(CONFIG_BMG160_SPI) += bmg160_spi.o
 obj-$(CONFIG_FXAS21002C) += fxas21002c_core.o
 obj-$(CONFIG_FXAS21002C_I2C) += fxas21002c_i2c.o
+obj-$(CONFIG_FXAS21002C_SPI) += fxas21002c_spi.o
 
 obj-$(CONFIG_HID_SENSOR_GYRO_3D) += hid-sensor-gyro-3d.o
 
diff --git a/drivers/iio/gyro/fxas21002c_spi.c b/drivers/iio/gyro/fxas21002c_spi.c
new file mode 100644
index 000000000000..77ceebef4e34
--- /dev/null
+++ b/drivers/iio/gyro/fxas21002c_spi.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for NXP Fxas21002c Gyroscope - SPI
+ *
+ * Copyright (C) 2019 Linaro Ltd.
+ */
+
+#include <linux/err.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/spi/spi.h>
+
+#include "fxas21002c.h"
+
+static const struct regmap_config fxas21002c_regmap_spi_conf = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = FXAS21002C_REG_CTRL3,
+};
+
+static int fxas21002c_spi_probe(struct spi_device *spi)
+{
+	const struct spi_device_id *id = spi_get_device_id(spi);
+	struct regmap *regmap;
+
+	regmap = devm_regmap_init_spi(spi, &fxas21002c_regmap_spi_conf);
+	if (IS_ERR(regmap)) {
+		dev_err(&spi->dev, "Failed to register spi regmap: %ld\n",
+			PTR_ERR(regmap));
+		return PTR_ERR(regmap);
+	}
+
+	return fxas21002c_core_probe(&spi->dev, regmap, spi->irq, id->name);
+}
+
+static int fxas21002c_spi_remove(struct spi_device *spi)
+{
+	fxas21002c_core_remove(&spi->dev);
+
+	return 0;
+}
+
+static const struct spi_device_id fxas21002c_spi_id[] = {
+	{ "fxas21002c", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, fxas21002c_spi_id);
+
+static const struct of_device_id fxas21002c_spi_of_match[] = {
+	{ .compatible = "nxp,fxas21002c", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, fxas21002c_spi_of_match);
+
+static struct spi_driver fxas21002c_spi_driver = {
+	.driver = {
+		.name = "fxas21002c_spi",
+		.pm = &fxas21002c_pm_ops,
+		.of_match_table = fxas21002c_spi_of_match,
+	},
+	.probe		= fxas21002c_spi_probe,
+	.remove		= fxas21002c_spi_remove,
+	.id_table	= fxas21002c_spi_id,
+};
+module_spi_driver(fxas21002c_spi_driver);
+
+MODULE_AUTHOR("Rui Miguel Silva <rui.silva@linaro.org>");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("FXAS21002C SPI Gyro driver");
-- 
2.21.0

