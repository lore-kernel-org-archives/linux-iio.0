Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48138 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751060AbcGRHDL (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 18 Jul 2016 03:03:11 -0400
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Olof Johansson <olof@lixom.net>, Lee Jones <lee.jones@linaro.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Guenter Roeck <groeck@chromium.org>,
	Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 01/10] mfd: cros_ec: add ChromeOS EC sensor platform information.
Date: Mon, 18 Jul 2016 09:02:41 +0200
Message-Id: <1468825370-20075-2-git-send-email-enric.balletbo@collabora.com>
In-Reply-To: <1468825370-20075-1-git-send-email-enric.balletbo@collabora.com>
References: <1468825370-20075-1-git-send-email-enric.balletbo@collabora.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The platform information will be used for the new cros-ec sensors driver
that presents sensors attached to the ChromeOS Embedded Controller.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
 include/linux/mfd/cros_ec.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
index d6539c1..cd4833a 100644
--- a/include/linux/mfd/cros_ec.h
+++ b/include/linux/mfd/cros_ec.h
@@ -151,6 +151,16 @@ struct cros_ec_device {
 	int event_size;
 };
 
+/* struct cros_ec_sensor_platform - ChromeOS EC sensor platform information
+ *
+ * On top of cros_ec_devicem information cros_ec_sensors needs.
+ *
+ * @sensor_num: Id of the sensor, as reported by the EC.
+ */
+struct cros_ec_sensor_platform {
+	u8 sensor_num;
+};
+
 /* struct cros_ec_platform - ChromeOS EC platform information
  *
  * @ec_name: name of EC device (e.g. 'cros-ec', 'cros-pd', ...)
-- 
2.1.0

