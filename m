Return-Path: <SRS0=iTXR=QM=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67256C282CB
	for <linux-iio@archiver.kernel.org>; Tue,  5 Feb 2019 17:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BB9120811
	for <linux-iio@archiver.kernel.org>; Tue,  5 Feb 2019 17:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FFWqg5ck"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbfBERn5 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 5 Feb 2019 12:43:57 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:32954 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727835AbfBERn5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 5 Feb 2019 12:43:57 -0500
Received: by mail-wm1-f67.google.com with SMTP id r24so102872wmh.0
        for <linux-iio@vger.kernel.org>; Tue, 05 Feb 2019 09:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gDgmk73jZxpcUob0JtNtldENUWQY6jE2DXwyzn7tmw8=;
        b=FFWqg5ckf/0PWzXYi1ObveJ1ACjS4K62xIljtH0ecFKVbLdTFeV0ipWd3DZa5X0T/8
         71tlAK9js3avffXFWwkiesU0RkMAy84y/J0lUcV05icR6o7naw3H1YJhzNJUJqXwFfWw
         Ahj2tECW76394VTqCLC8G0HJ+lKlGsm/EulW2scJ5qMF3b8x98dsPF1E3M+Mz5c7y2sH
         NNWYlUiDPeuRxzKiGzcFMqiEr1Raj55EqmyUOUsjg9FV4WQ9pkZn5TNMc6koB4FpOpim
         ewkFfr5G86o+H/hmQhUUzVhXHBJ3kLOdc+js8pfKnBc7Wb6S/N3b+Bz1iNcmdTDv3990
         wYZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gDgmk73jZxpcUob0JtNtldENUWQY6jE2DXwyzn7tmw8=;
        b=SkDbiZ6xNY9E7xHomkAovck9EWDHjZpjuoSbc3cbL8xrfTo5nLgUTXx2+abEH2H5Bk
         XHzOTHXoton3lcBVXW3Z+0CFeWnsux4pqDRu8vrbQuLdOQdwQWGIYwXE4ABwMaFmNoU1
         EOVTKU2eQ8qP14W23BX2AFRFXOlEDPWe4vfSUYCjwDzI+iFx5W1Ecr64jQigariT+mKc
         r5kUgqZIvU75xvpKe/aawKO0RUb12UqMyl9485Gb09szT2pMPpu5nyjvhHrr11oOEimv
         RQhZr2NaGF2X6BW3Xj1EEFh8x9lR0IvKYG5tlH3QW9aT62i1RmDRpkEOGCyQ/eCNkkzU
         LnrA==
X-Gm-Message-State: AHQUAua/XM2Jpsjt6aAiu4+3BJDnyEi37+Ryvq7nJeP6kXmtoOOgJsIa
        TRmNBIm2EDnYgEIOuPi6PM8SNA==
X-Google-Smtp-Source: AHgI3IYXOf1GGWpN77W881VdnTtje7gTPaarnTRDpRr9WdiWtTsnZzqTluWsG+35auZuk3dgWLDTtQ==
X-Received: by 2002:a1c:5a42:: with SMTP id o63mr4608833wmb.88.1549388635740;
        Tue, 05 Feb 2019 09:43:55 -0800 (PST)
Received: from arch-late.local (a109-49-46-234.cpe.netcabo.pt. [109.49.46.234])
        by smtp.gmail.com with ESMTPSA id s132sm12225751wmf.28.2019.02.05.09.43.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 09:43:55 -0800 (PST)
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
Subject: [PATCH v2 4/5] iio: gyro: fxas2100x: add spi driver
Date:   Tue,  5 Feb 2019 17:43:32 +0000
Message-Id: <20190205174333.17672-5-rui.silva@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190205174333.17672-1-rui.silva@linaro.org>
References: <20190205174333.17672-1-rui.silva@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add driver to talk over spi to a fxas21002 gyroscope device and use the
core as main controller.

Signed-off-by: Rui Miguel Silva <rui.silva@linaro.org>
---
 drivers/iio/gyro/Kconfig         |  5 +++
 drivers/iio/gyro/Makefile        |  1 +
 drivers/iio/gyro/fxas2100x_spi.c | 70 ++++++++++++++++++++++++++++++++
 3 files changed, 76 insertions(+)
 create mode 100644 drivers/iio/gyro/fxas2100x_spi.c

diff --git a/drivers/iio/gyro/Kconfig b/drivers/iio/gyro/Kconfig
index 1f9bfc51febb..4f6d6b393ad8 100644
--- a/drivers/iio/gyro/Kconfig
+++ b/drivers/iio/gyro/Kconfig
@@ -78,6 +78,7 @@ config FXAS2100X
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
 	select FXAS2100X_I2C if (I2C)
+	select FXAS2100X_SPI if (SPI)
 	depends on (I2C || SPI_MASTER)
 	help
 	  Say yes here to build support for NXP FXAS2100X family Tri-axis Gyro
@@ -90,6 +91,10 @@ config FXAS2100X_I2C
 	tristate
 	select REGMAP_I2C
 
+config FXAS2100X_SPI
+	tristate
+	select REGMAP_SPI
+
 config HID_SENSOR_GYRO_3D
 	depends on HID_SENSOR_HUB
 	select IIO_BUFFER
diff --git a/drivers/iio/gyro/Makefile b/drivers/iio/gyro/Makefile
index 8b1540ddbbce..29915ba124b0 100644
--- a/drivers/iio/gyro/Makefile
+++ b/drivers/iio/gyro/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_BMG160_I2C) += bmg160_i2c.o
 obj-$(CONFIG_BMG160_SPI) += bmg160_spi.o
 obj-$(CONFIG_FXAS2100X) += fxas2100x_core.o
 obj-$(CONFIG_FXAS2100X_I2C) += fxas2100x_i2c.o
+obj-$(CONFIG_FXAS2100X_SPI) += fxas2100x_spi.o
 
 obj-$(CONFIG_HID_SENSOR_GYRO_3D) += hid-sensor-gyro-3d.o
 
diff --git a/drivers/iio/gyro/fxas2100x_spi.c b/drivers/iio/gyro/fxas2100x_spi.c
new file mode 100644
index 000000000000..7bd16a607372
--- /dev/null
+++ b/drivers/iio/gyro/fxas2100x_spi.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for NXP FXAS2100x Gyroscope - SPI
+ *
+ * Copyright (C) 2018 Linaro Ltd.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/regmap.h>
+#include <linux/spi/spi.h>
+
+#include "fxas2100x.h"
+
+static const struct regmap_config fxas2100x_regmap_spi_conf = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = FXAS2100X_REG_CTRL3,
+};
+
+static int fxas2100x_spi_probe(struct spi_device *spi)
+{
+	const struct spi_device_id *id = spi_get_device_id(spi);
+	struct regmap *regmap;
+
+	regmap = devm_regmap_init_spi(spi, &fxas2100x_regmap_spi_conf);
+	if (IS_ERR(regmap)) {
+		dev_err(&spi->dev, "Failed to register spi regmap: %ld\n",
+			PTR_ERR(regmap));
+		return PTR_ERR(regmap);
+	}
+
+	return fxas2100x_core_probe(&spi->dev, regmap, spi->irq, id->name);
+}
+
+static int fxas2100x_spi_remove(struct spi_device *spi)
+{
+	fxas2100x_core_remove(&spi->dev);
+
+	return 0;
+}
+
+static const struct spi_device_id fxas2100x_spi_id[] = {
+	{ "fxas2100x", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, fxas2100x_spi_id);
+
+static const struct of_device_id fxas2100x_spi_of_match[] = {
+	{ .compatible = "nxp,fxas21002", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, fxas2100x_spi_of_match);
+
+static struct spi_driver fxas2100x_spi_driver = {
+	.driver = {
+		.name = "fxas2100x_spi",
+		.pm = &fxas2100x_pm_ops,
+		.of_match_table = of_match_ptr(fxas2100x_spi_of_match),
+	},
+	.probe		= fxas2100x_spi_probe,
+	.remove		= fxas2100x_spi_remove,
+	.id_table	= fxas2100x_spi_id,
+};
+module_spi_driver(fxas2100x_spi_driver);
+
+MODULE_AUTHOR("Rui Miguel Silva <rui.silva@linaro.org>");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("FXAS2100X SPI Gyro driver");
-- 
2.20.1

