Return-Path: <SRS0=E0rE=6P=collabora.com=enric.balletbo@kernel.org>
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Lee Jones <lee.jones@linaro.org>,
	bleung@chromium.org
Cc: martinez.javier@gmail.com,
	Guenter Roeck <groeck@chromium.org>,
	Gwendal Grignou <gwendal@chromium.org>,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	rtc-linux@googlegroups.com,
	Stephen Barber <smbarber@chromium.org>
Subject: [PATCH v3 4/4] mfd: cros_ec: add RTC as mfd subdevice
Date: Wed, 12 Jul 2017 12:13:09 +0200
Message-Id: <20170712101309.6045-5-enric.balletbo@collabora.com>
In-Reply-To: <20170712101309.6045-1-enric.balletbo@collabora.com>
References: <20170712101309.6045-1-enric.balletbo@collabora.com>
List-ID: <linux-iio@vger.kernel.org>

From: Stephen Barber <smbarber@chromium.org>

If the EC supports RTC host commands, expose an RTC device.

Signed-off-by: Stephen Barber <smbarber@chromium.org>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
 drivers/mfd/cros_ec.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
index 75a27a6..ff972fb 100644
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
@@ -245,6 +249,16 @@ static void cros_ec_sensors_register(struct cros_ec_device *ec_dev)
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
@@ -294,6 +308,10 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
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
