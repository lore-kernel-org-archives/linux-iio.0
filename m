Return-Path: <SRS0=Oeur=RQ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28066C43381
	for <linux-iio@archiver.kernel.org>; Wed, 13 Mar 2019 18:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF21C213A2
	for <linux-iio@archiver.kernel.org>; Wed, 13 Mar 2019 18:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cJL8Luw2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbfCMSkX (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 13 Mar 2019 14:40:23 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50713 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbfCMSkW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 13 Mar 2019 14:40:22 -0400
Received: by mail-wm1-f68.google.com with SMTP id x7so364300wmj.0
        for <linux-iio@vger.kernel.org>; Wed, 13 Mar 2019 11:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YBROu6s1aUqFXVAOn6ZhMxPUlZjIbwtgWmPTml7WQYY=;
        b=cJL8Luw2mmbur8J9ux/dfWGjDSuhM4V6OBO3gN6evqtSl4a/odxL3hVjoH7RdSTmX2
         X1t9q2IWQLE4x77IqfdD8eTk78h+vMaleJ8dpeZq+CjAMxCg08nUr9wVMhVg+uyjY5k4
         IEp2WQRf+uj30w2DASs2AYEdGqG/2whPVOf5IPzaAFCVsHmjut82rLRmNAmXkoO7XuES
         3HvkHOqTOnQI9hXvYgbmJp+fONO3RRwGZw8OmY38W9DWscC3nJ9LIWCZsLULBuuib+IW
         IeOnD8QKnPp1QSAokz4UvMFGGXIFtQowpVcqc3FvzbtV9CwOmVVPbB3ytCS56+H4Cy8v
         ktsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YBROu6s1aUqFXVAOn6ZhMxPUlZjIbwtgWmPTml7WQYY=;
        b=SNsrLlqHoCXpgfC5Ua0npGk/ZusJLw3/u1XHF8An7zWdKvIfDK6zvuwPXhBpU5uSvG
         aAnyrEn19Ye0TLE1loj3aGrqEN+QcF5wwZBOfVgLicfJ8WResfFkyavD82a1HC/hffy6
         3E5zqw3YoqtSvKYx9zL54MJmU9EcpW6/bj/Pj+ZTYMVZt5RR4KiJFpLmdhm2ytsahe+p
         qdAy83zlG6UmA1NJ+aPnlL5wsGKu4h14pMkhGEiyDv7bZWoxcxgPUzznh02/Vqlm1cLI
         qGWZj5u6JGPYTeVocFnvplOVs/asnFjLUAySisedJY/DZYgiUBn7p5vrGuS+24pGHSE/
         EiTg==
X-Gm-Message-State: APjAAAVbRd9sA5wAYV02E7Jivf1l2QlQ47NEFFO4l4k99p7jawFyBj0f
        j2ljus0+M3uFwxHCeeHsQWqyFw==
X-Google-Smtp-Source: APXvYqyeMi4OKw8wdGfycDVKFqMIf6evdXw8DmvXUaihOT+oXj3bjaO4Q+pcNAOCXs07l4E+s9454g==
X-Received: by 2002:a1c:1cf:: with SMTP id 198mr3120510wmb.52.1552502420799;
        Wed, 13 Mar 2019 11:40:20 -0700 (PDT)
Received: from arch-late.localdomain ([87.196.73.151])
        by smtp.gmail.com with ESMTPSA id p17sm3829660wmi.35.2019.03.13.11.40.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 11:40:20 -0700 (PDT)
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
Subject: [PATCH v3 4/6] iio: gyro: fxas21002c: add spi driver
Date:   Wed, 13 Mar 2019 18:40:00 +0000
Message-Id: <20190313184002.2501-5-rui.silva@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190313184002.2501-1-rui.silva@linaro.org>
References: <20190313184002.2501-1-rui.silva@linaro.org>
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
 drivers/iio/gyro/fxas21002c_spi.c | 69 +++++++++++++++++++++++++++++++
 3 files changed, 76 insertions(+), 1 deletion(-)
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
index 000000000000..88a4e9acad24
--- /dev/null
+++ b/drivers/iio/gyro/fxas21002c_spi.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for NXP Fxas21002c Gyroscope - SPI
+ *
+ * Copyright (C) 2019 Linaro Ltd.
+ */
+
+#include <linux/module.h>
+#include <linux/of.h>
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
+	{ },
+};
+MODULE_DEVICE_TABLE(of, fxas21002c_spi_of_match);
+
+static struct spi_driver fxas21002c_spi_driver = {
+	.driver = {
+		.name = "fxas21002c_spi",
+		.pm = &fxas21002c_pm_ops,
+		.of_match_table = of_match_ptr(fxas21002c_spi_of_match),
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
2.20.1

