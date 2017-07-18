Return-Path: <SRS0=r+Hi=6V=gmail.com=rjdurga@kernel.org>
From: Jaya Durga <rjdurga@gmail.com>
To: gregkh@linuxfoundation.org
Cc: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	singhalsimran0@gmail.com,
	eraretuya@gmail.com,
	linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	Jaya Durga <rjdurga@gmail.com>
Subject: [PATCH 2/2] Staging: iio: light: tsl2x7x_core.c: Replace symbolic permission with octal permission
Date: Tue, 18 Jul 2017 12:53:23 +0530
Message-Id: <1500362603-31924-1-git-send-email-rjdurga@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Replace symbolic permissions with their
octect representation to fix checkpatch warnings.

Signed-off-by: Jaya Durga <rjdurga@gmail.com>
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
