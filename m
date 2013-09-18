Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:53756 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751651Ab3IRRNH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 18 Sep 2013 13:13:07 -0400
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: linux-input@vger.kernel.org, linux-iio@vger.kernel.org
Cc: jic23@kernel.org, jkosina@suse.cz, holler@ahsoftware.de,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 2/3] IIO: call sensor hub open close function
Date: Wed, 18 Sep 2013 10:13:18 -0700
Message-Id: <1379524399-16995-2-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1379524399-16995-1-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1379524399-16995-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Call hid_sensor_hub_device_open when user space opens device and call
hid_sensor_hub_device_close when device is closed. This helps in
saving power.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/common/hid-sensors/hid-sensor-trigger.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
index 87419c4..b6e77e0 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
@@ -34,6 +34,12 @@ static int hid_sensor_data_rdy_trigger_set_state(struct iio_trigger *trig,
 	struct hid_sensor_common *st = iio_trigger_get_drvdata(trig);
 	int state_val;
 
+	if (state) {
+		if (sensor_hub_device_open(st->hsdev))
+			return -EIO;
+	} else
+		sensor_hub_device_close(st->hsdev);
+
 	state_val = state ? 1 : 0;
 	if (IS_ENABLED(CONFIG_HID_SENSOR_ENUM_BASE_QUIRKS))
 		++state_val;
-- 
1.8.3.1

