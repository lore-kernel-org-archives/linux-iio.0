Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36891 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751103AbdE2PwM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 May 2017 11:52:12 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 08/38] iio:common: drop assign iio_info.driver_module and iio_trigger_ops.owner
Date: Mon, 29 May 2017 16:51:24 +0100
Message-Id: <20170529155154.22580-9-jic23@kernel.org>
In-Reply-To: <20170529155154.22580-1-jic23@kernel.org>
References: <20170529155154.22580-1-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The equivalent of both of these are now done via macro magic when
the relevant register calls are made.  The actual structure
elements will shortly go away.

Clearly this set jumps across multiple areas, but inherently it
can't be grouped like the other sets in this series so I've done
all the stuff in the common directory together.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c | 1 -
 drivers/iio/common/hid-sensors/hid-sensor-trigger.c  | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
index 38e8783e4b05..ed8063f2da99 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
@@ -185,7 +185,6 @@ static int cros_ec_sensors_write(struct iio_dev *indio_dev,
 static const struct iio_info ec_sensors_info = {
 	.read_raw = &cros_ec_sensors_read,
 	.write_raw = &cros_ec_sensors_write,
-	.driver_module = THIS_MODULE,
 };
 
 static int cros_ec_sensors_probe(struct platform_device *pdev)
diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
index 16ade0a0327b..1f967cce2714 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
@@ -241,7 +241,6 @@ void hid_sensor_remove_trigger(struct hid_sensor_common *attrb)
 EXPORT_SYMBOL(hid_sensor_remove_trigger);
 
 static const struct iio_trigger_ops hid_sensor_trigger_ops = {
-	.owner = THIS_MODULE,
 	.set_trigger_state = &hid_sensor_data_rdy_trigger_set_state,
 };
 
-- 
2.13.0

