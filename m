Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34272 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755037AbdERIgr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 18 May 2017 04:36:47 -0400
From: surenderpolsani@gmail.com
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        gregor.boirie@parrot.com
Cc: singhalsimran0@gmail.com, maitysanchayan@gmail.com,
        eraretuya@gmail.com, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Surender Polsani <surenderpolsani@gmail.com>
Subject: [PATCH] staging: iio: light: Replace symbolic permissions as per coding style
Date: Thu, 18 May 2017 14:06:29 +0530
Message-Id: <1495096589-5846-1-git-send-email-surenderpolsani@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Surender Polsani <surenderpolsani@gmail.com>

Fixed the following checkpatch.pl warnings:
octal permissions are more preferable than symbolic permissions

Signed-off-by: Surender Polsani <surenderpolsani@gmail.com>
---
 drivers/staging/iio/light/tsl2x7x_core.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x_core.c b/drivers/staging/iio/light/tsl2x7x_core.c
index af3910b..c63fe6a 100644
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
+static DEVICE_ATTR(in_proximity0_thresh_period, 0644,
 		tsl2x7x_prox_persistence_show, tsl2x7x_prox_persistence_store);
 
 /* Use the default register values to identify the Taos device */
-- 
1.9.1

