Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35272 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751228AbdEDUi4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 4 May 2017 16:38:56 -0400
From: Enric Balletbo i Serra <eballetbo@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: [PATCH 2/2] tsl2x7x_core: use octal permission representation
Date: Thu,  4 May 2017 22:38:32 +0200
Message-Id: <20170504203832.5525-2-eballetbo@gmail.com>
In-Reply-To: <20170504203832.5525-1-eballetbo@gmail.com>
References: <20170504203832.5525-1-eballetbo@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Fix the output from checkpatch.pl like:
  Symbolic permissions 'S_IRUSR' are not preferred.
  Consider using octal permissions '0400'.

Also fix the alignment DEVICE_ATTR variables as should match open
parenthesis.

Signed-off-by: Enric Balletbo i Serra <eballetbo@gmail.com>
---
 drivers/staging/iio/light/tsl2x7x_core.c | 42 +++++++++++++++++---------------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x_core.c b/drivers/staging/iio/light/tsl2x7x_core.c
index b35ff63f7f60..41b8f5332737 100644
--- a/drivers/staging/iio/light/tsl2x7x_core.c
+++ b/drivers/staging/iio/light/tsl2x7x_core.c
@@ -1494,35 +1494,37 @@ static int tsl2x7x_write_raw(struct iio_dev *indio_dev,
 	return 0;
 }
 
-static DEVICE_ATTR(power_state, S_IRUGO | S_IWUSR,
-		tsl2x7x_power_state_show, tsl2x7x_power_state_store);
+static DEVICE_ATTR(power_state, 0644, tsl2x7x_power_state_show,
+		   tsl2x7x_power_state_store);
 
-static DEVICE_ATTR(in_proximity0_calibscale_available, S_IRUGO,
-		tsl2x7x_prox_gain_available_show, NULL);
+static DEVICE_ATTR(in_proximity0_calibscale_available, 0444,
+		   tsl2x7x_prox_gain_available_show, NULL);
 
-static DEVICE_ATTR(in_illuminance0_calibscale_available, S_IRUGO,
-		tsl2x7x_gain_available_show, NULL);
+static DEVICE_ATTR(in_illuminance0_calibscale_available, 0444,
+		   tsl2x7x_gain_available_show, NULL);
 
-static DEVICE_ATTR(in_illuminance0_integration_time, S_IRUGO | S_IWUSR,
-		tsl2x7x_als_time_show, tsl2x7x_als_time_store);
+static DEVICE_ATTR(in_illuminance0_integration_time, 0644,
+		   tsl2x7x_als_time_show, tsl2x7x_als_time_store);
 
-static DEVICE_ATTR(in_illuminance0_target_input, S_IRUGO | S_IWUSR,
-		tsl2x7x_als_cal_target_show, tsl2x7x_als_cal_target_store);
+static DEVICE_ATTR(in_illuminance0_target_input, 0644,
+		   tsl2x7x_als_cal_target_show, tsl2x7x_als_cal_target_store);
 
-static DEVICE_ATTR(in_illuminance0_calibrate, S_IWUSR, NULL,
-		tsl2x7x_do_calibrate);
+static DEVICE_ATTR(in_illuminance0_calibrate, 0200, NULL,
+		   tsl2x7x_do_calibrate);
 
-static DEVICE_ATTR(in_proximity0_calibrate, S_IWUSR, NULL,
-		tsl2x7x_do_prox_calibrate);
+static DEVICE_ATTR(in_proximity0_calibrate, 0200, NULL,
+		   tsl2x7x_do_prox_calibrate);
 
-static DEVICE_ATTR(in_illuminance0_lux_table, S_IRUGO | S_IWUSR,
-		tsl2x7x_luxtable_show, tsl2x7x_luxtable_store);
+static DEVICE_ATTR(in_illuminance0_lux_table, 0644, tsl2x7x_luxtable_show,
+		   tsl2x7x_luxtable_store);
 
-static DEVICE_ATTR(in_intensity0_thresh_period, S_IRUGO | S_IWUSR,
-		tsl2x7x_als_persistence_show, tsl2x7x_als_persistence_store);
+static DEVICE_ATTR(in_intensity0_thresh_period, 0644,
+		   tsl2x7x_als_persistence_show,
+		   tsl2x7x_als_persistence_store);
 
-static DEVICE_ATTR(in_proximity0_thresh_period, S_IRUGO | S_IWUSR,
-		tsl2x7x_prox_persistence_show, tsl2x7x_prox_persistence_store);
+static DEVICE_ATTR(in_proximity0_thresh_period, 0644,
+		   tsl2x7x_prox_persistence_show,
+		   tsl2x7x_prox_persistence_store);
 
 /* Use the default register values to identify the Taos device */
 static int tsl2x7x_device_id(unsigned char *id, int target)
-- 
2.11.0

