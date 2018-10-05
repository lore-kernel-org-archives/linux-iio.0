Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:36501 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728061AbeJFCsv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 5 Oct 2018 22:48:51 -0400
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
        <u.kleine-koenig@pengutronix.de>
To: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] iio: ssp_sensors: don't manually free devm managed resources
Date: Fri,  5 Oct 2018 21:48:30 +0200
Message-Id: <20181005194830.9332-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The charme of devm_* functions is that you don't need to care about them
in the error path. In this case it is valid to just return NULL which makes
the device fail to probe and then the two gpios and the allocated memory
are freed automatically by the driver core.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/iio/common/ssp_sensors/ssp_dev.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/common/ssp_sensors/ssp_dev.c b/drivers/iio/common/ssp_sensors/ssp_dev.c
index af3aa38f67cd..9e13be2c0cb9 100644
--- a/drivers/iio/common/ssp_sensors/ssp_dev.c
+++ b/drivers/iio/common/ssp_sensors/ssp_dev.c
@@ -462,43 +462,35 @@ static struct ssp_data *ssp_parse_dt(struct device *dev)
 
 	data->mcu_ap_gpio = of_get_named_gpio(node, "mcu-ap-gpios", 0);
 	if (data->mcu_ap_gpio < 0)
-		goto err_free_pd;
+		return NULL;
 
 	data->ap_mcu_gpio = of_get_named_gpio(node, "ap-mcu-gpios", 0);
 	if (data->ap_mcu_gpio < 0)
-		goto err_free_pd;
+		return NULL;
 
 	data->mcu_reset_gpio = of_get_named_gpio(node, "mcu-reset-gpios", 0);
 	if (data->mcu_reset_gpio < 0)
-		goto err_free_pd;
+		return NULL;
 
 	ret = devm_gpio_request_one(dev, data->ap_mcu_gpio, GPIOF_OUT_INIT_HIGH,
 				    "ap-mcu-gpios");
 	if (ret)
-		goto err_free_pd;
+		return NULL;
 
 	ret = devm_gpio_request_one(dev, data->mcu_reset_gpio,
 				    GPIOF_OUT_INIT_HIGH, "mcu-reset-gpios");
 	if (ret)
-		goto err_ap_mcu;
+		return NULL;
 
 	match = of_match_node(ssp_of_match, node);
 	if (!match)
-		goto err_mcu_reset_gpio;
+		return NULL;
 
 	data->sensorhub_info = match->data;
 
 	dev_set_drvdata(dev, data);
 
 	return data;
-
-err_mcu_reset_gpio:
-	devm_gpio_free(dev, data->mcu_reset_gpio);
-err_ap_mcu:
-	devm_gpio_free(dev, data->ap_mcu_gpio);
-err_free_pd:
-	devm_kfree(dev, data);
-	return NULL;
 }
 #else
 static struct ssp_data *ssp_parse_dt(struct device *pdev)
-- 
2.19.0
