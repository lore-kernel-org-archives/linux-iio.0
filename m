Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47542 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754090AbdDCQfu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Apr 2017 12:35:50 -0400
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Olof Johansson <olof@lixom.net>, bleung@chromium.org
Cc: martinez.javier@gmail.com, Guenter Roeck <groeck@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        rtc-linux@googlegroups.com, Stephen Barber <smbarber@chromium.org>
Subject: [PATCH v2 5/5] mfd: cros_ec: add RTC as mfd subdevice
Date: Mon,  3 Apr 2017 18:35:36 +0200
Message-Id: <20170403163536.25634-6-enric.balletbo@collabora.com>
In-Reply-To: <20170403163536.25634-1-enric.balletbo@collabora.com>
References: <20170403163536.25634-1-enric.balletbo@collabora.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Stephen Barber <smbarber@chromium.org>

If the EC supports RTC host commands, expose an RTC device.

Signed-off-by: Stephen Barber <smbarber@chromium.org>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

Changes since v1:
 - Use PLATFORM_DEVID_AUTO to add the subdevice.

 drivers/mfd/cros_ec.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
index bbc17ab..76874be 100644
--- a/drivers/mfd/cros_ec.c
+++ b/drivers/mfd/cros_ec.c
@@ -51,6 +51,10 @@ static const struct mfd_cell ec_pd_cell = {
 	.pdata_size = sizeof(pd_p),
 };
 
+static const struct mfd_cell ec_rtc_cell = {
+	.name = "cros-ec-rtc",
+};
+
 static irqreturn_t ec_irq_thread(int irq, void *data)
 {
 	struct cros_ec_device *ec_dev = data;
@@ -238,6 +242,16 @@ static void cros_ec_sensors_register(struct cros_ec_device *ec_dev)
 	kfree(msg);
 }
 
+static void cros_ec_rtc_register(struct cros_ec_device *ec_dev)
+{
+	int ret;
+
+	ret = mfd_add_devices(ec_dev->dev, PLATFORM_DEVID_AUTO, &ec_rtc_cell,
+			      1, NULL, 0, NULL);
+	if (ret)
+		dev_err(ec_dev->dev, "failed to add EC RTC\n");
+}
+
 int cros_ec_register(struct cros_ec_device *ec_dev)
 {
 	struct device *dev = ec_dev->dev;
@@ -287,6 +301,10 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 	if (cros_ec_check_features(ec_dev, EC_FEATURE_MOTION_SENSE))
 		cros_ec_sensors_register(ec_dev);
 
+	/* Check whether this EC has RTC support */
+	if (cros_ec_check_features(ec_dev, EC_FEATURE_RTC))
+		cros_ec_rtc_register(ec_dev);
+
 	if (ec_dev->max_passthru) {
 		/*
 		 * Register a PD device as well on top of this device.
-- 
2.9.3

