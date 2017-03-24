Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:43020 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753238AbdCXRog (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 Mar 2017 13:44:36 -0400
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Olof Johansson <olof@lixom.net>, bleung@chromium.org
Cc: martinez.javier@gmail.com, Guenter Roeck <groeck@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        rtc-linux@googlegroups.com
Subject: [PATCH 3/7] iio: cros_ec_sensors: Use devm to setup the triggered buffer.
Date: Fri, 24 Mar 2017 18:44:03 +0100
Message-Id: <20170324174407.25401-4-enric.balletbo@collabora.com>
In-Reply-To: <20170324174407.25401-1-enric.balletbo@collabora.com>
References: <20170324174407.25401-1-enric.balletbo@collabora.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Use resourced managed function devm_iio_triggered_buffer_setup
to make error path simpler and be able to get rid of the remove
function.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

  This is an improvement that can wait to 4.12 merge window, again can be
picked independently of the other patches and can go through IIO Jonathan's
Cameron tree.

 .../iio/common/cros_ec_sensors/cros_ec_sensors.c   | 26 +++-------------------
 1 file changed, 3 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
index c17596f..38e8783 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
@@ -267,31 +267,12 @@ static int cros_ec_sensors_probe(struct platform_device *pdev)
 	else
 		state->core.read_ec_sensors_data = cros_ec_sensors_read_cmd;
 
-	ret = iio_triggered_buffer_setup(indio_dev, NULL,
-					 cros_ec_sensors_capture, NULL);
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
+			cros_ec_sensors_capture, NULL);
 	if (ret)
 		return ret;
 
-	ret = iio_device_register(indio_dev);
-	if (ret)
-		goto error_uninit_buffer;
-
-	return 0;
-
-error_uninit_buffer:
-	iio_triggered_buffer_cleanup(indio_dev);
-
-	return ret;
-}
-
-static int cros_ec_sensors_remove(struct platform_device *pdev)
-{
-	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
-
-	iio_device_unregister(indio_dev);
-	iio_triggered_buffer_cleanup(indio_dev);
-
-	return 0;
+	return devm_iio_device_register(dev, indio_dev);
 }
 
 static const struct platform_device_id cros_ec_sensors_ids[] = {
@@ -313,7 +294,6 @@ static struct platform_driver cros_ec_sensors_platform_driver = {
 		.name	= "cros-ec-sensors",
 	},
 	.probe		= cros_ec_sensors_probe,
-	.remove		= cros_ec_sensors_remove,
 	.id_table	= cros_ec_sensors_ids,
 };
 module_platform_driver(cros_ec_sensors_platform_driver);
-- 
2.9.3

