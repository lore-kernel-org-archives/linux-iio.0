Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from fallback.mail.elte.hu ([157.181.151.13]:60282 "EHLO
        fallback.mail.elte.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S945583AbdDYNb2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 25 Apr 2017 09:31:28 -0400
From: Paolo Cretaro <melko@frugalware.org>
To: jic23@kernel.org
Cc: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org
Subject: [PATCH] staging: iio: tsl2x7x: Replace deprecated macros (S_IRUGO, S_IWUSR)
Date: Tue, 25 Apr 2017 15:00:50 +0200
Message-Id: <20170425130050.11064-1-melko@frugalware.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Use octal digits as suggested by checkpatch instead of deprecated macros.

Signed-off-by: Paolo Cretaro <melko@frugalware.org>
---
 drivers/staging/iio/light/tsl2x7x_core.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x_core.c b/drivers/staging/iio/light/tsl2x7x_core.c
index af3910bc1b4f..8121a5188638 100644
--- a/drivers/staging/iio/light/tsl2x7x_core.c
+++ b/drivers/staging/iio/light/tsl2x7x_core.c
@@ -1498,34 +1498,34 @@ static int tsl2x7x_write_raw(struct iio_dev *indio_dev,
 	return 0;
 }
 
-static DEVICE_ATTR(power_state, S_IRUGO | S_IWUSR,
+static DEVICE_ATTR(power_state, 0644,
 		tsl2x7x_power_state_show, tsl2x7x_power_state_store);
 
-static DEVICE_ATTR(in_proximity0_calibscale_available, S_IRUGO,
+static DEVICE_ATTR(in_proximity0_calibscale_available, 0444,
 		tsl2x7x_prox_gain_available_show, NULL);
 
-static DEVICE_ATTR(in_illuminance0_calibscale_available, S_IRUGO,
+static DEVICE_ATTR(in_illuminance0_calibscale_available, 0444,
 		tsl2x7x_gain_available_show, NULL);
 
-static DEVICE_ATTR(in_illuminance0_integration_time, S_IRUGO | S_IWUSR,
+static DEVICE_ATTR(in_illuminance0_integration_time, 0644,
 		tsl2x7x_als_time_show, tsl2x7x_als_time_store);
 
-static DEVICE_ATTR(in_illuminance0_target_input, S_IRUGO | S_IWUSR,
+static DEVICE_ATTR(in_illuminance0_target_input, 0644,
 		tsl2x7x_als_cal_target_show, tsl2x7x_als_cal_target_store);
 
-static DEVICE_ATTR(in_illuminance0_calibrate, S_IWUSR, NULL,
+static DEVICE_ATTR(in_illuminance0_calibrate, 0200, NULL,
 		tsl2x7x_do_calibrate);
 
-static DEVICE_ATTR(in_proximity0_calibrate, S_IWUSR, NULL,
+static DEVICE_ATTR(in_proximity0_calibrate, 0200, NULL,
 		tsl2x7x_do_prox_calibrate);
 
-static DEVICE_ATTR(in_illuminance0_lux_table, S_IRUGO | S_IWUSR,
+static DEVICE_ATTR(in_illuminance0_lux_table, 0644,
 		tsl2x7x_luxtable_show, tsl2x7x_luxtable_store);
 
-static DEVICE_ATTR(in_intensity0_thresh_period, S_IRUGO | S_IWUSR,
+static DEVICE_ATTR(in_intensity0_thresh_period, 0644,
 		tsl2x7x_als_persistence_show, tsl2x7x_als_persistence_store);
 
-static DEVICE_ATTR(in_proximity0_thresh_period, S_IRUGO | S_IWUSR,
+static DEVICE_ATTR(in_proximity0_thresh_period,  0644,
 		tsl2x7x_prox_persistence_show, tsl2x7x_prox_persistence_store);
 
 /* Use the default register values to identify the Taos device */
-- 
2.12.2

