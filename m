Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34693 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752157AbdCWLyE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 Mar 2017 07:54:04 -0400
Date: Thu, 23 Mar 2017 17:23:57 +0530
From: Arushi Singhal <arushisinghal19971997@gmail.com>
To: jic23@kernel.org
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: [PATCH] staging: tsl2x7x: Moved contents of the header to the source
 file.
Message-ID: <20170323115357.GA24360@arushi-HP-Pavilion-Notebook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Moved the contents of the header(tsl2x7x.h) into the source file
tsl2x7x_core.c with the exception of the platform data struct which is
supposed to be used from somewhere else other than the driver.

Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
---
 drivers/staging/iio/light/tsl2x7x.h      | 57 -------------------------------
 drivers/staging/iio/light/tsl2x7x_core.c | 58 ++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+), 57 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.h b/drivers/staging/iio/light/tsl2x7x.h
index ecae92211216..7b71003ddb33 100644
--- a/drivers/staging/iio/light/tsl2x7x.h
+++ b/drivers/staging/iio/light/tsl2x7x.h
@@ -23,63 +23,6 @@
 #define __TSL2X7X_H
 #include <linux/pm.h>
 
-/* Max number of segments allowable in LUX table */
-#define TSL2X7X_MAX_LUX_TABLE_SIZE		9
-#define MAX_DEFAULT_TABLE_BYTES (sizeof(int) * TSL2X7X_MAX_LUX_TABLE_SIZE)
-
-struct iio_dev;
-
-struct tsl2x7x_lux {
-	unsigned int ratio;
-	unsigned int ch0;
-	unsigned int ch1;
-};
-
-/**
- * struct tsl2x7x_default_settings - power on defaults unless
- *                                   overridden by platform data.
- *  @als_time:              ALS Integration time - multiple of 50mS
- *  @als_gain:              Index into the ALS gain table.
- *  @als_gain_trim:         default gain trim to account for
- *                          aperture effects.
- *  @wait_time:             Time between PRX and ALS cycles
- *                          in 2.7 periods
- *  @prx_time:              5.2ms prox integration time -
- *                          decrease in 2.7ms periods
- *  @prx_gain:              Proximity gain index
- *  @prox_config:           Prox configuration filters.
- *  @als_cal_target:        Known external ALS reading for
- *                          calibration.
- *  @interrupts_en:         Enable/Disable - 0x00 = none, 0x10 = als,
- *                                           0x20 = prx,  0x30 = bth
- *  @persistence:           H/W Filters, Number of 'out of limits'
- *                          ADC readings PRX/ALS.
- *  @als_thresh_low:        CH0 'low' count to trigger interrupt.
- *  @als_thresh_high:       CH0 'high' count to trigger interrupt.
- *  @prox_thres_low:        Low threshold proximity detection.
- *  @prox_thres_high:       High threshold proximity detection
- *  @prox_pulse_count:      Number if proximity emitter pulses
- *  @prox_max_samples_cal:  Used for prox cal.
- */
-struct tsl2x7x_settings {
-	int als_time;
-	int als_gain;
-	int als_gain_trim;
-	int wait_time;
-	int prx_time;
-	int prox_gain;
-	int prox_config;
-	int als_cal_target;
-	u8  interrupts_en;
-	u8  persistence;
-	int als_thresh_low;
-	int als_thresh_high;
-	int prox_thres_low;
-	int prox_thres_high;
-	int prox_pulse_count;
-	int prox_max_samples_cal;
-};
-
 /**
  * struct tsl2X7X_platform_data - Platform callback, glass and defaults
  * @platform_power:            Suspend/resume platform callback
diff --git a/drivers/staging/iio/light/tsl2x7x_core.c b/drivers/staging/iio/light/tsl2x7x_core.c
index ea15bc1c300c..21cbf7e95c4e 100644
--- a/drivers/staging/iio/light/tsl2x7x_core.c
+++ b/drivers/staging/iio/light/tsl2x7x_core.c
@@ -32,6 +32,64 @@
 #include <linux/iio/sysfs.h>
 #include "tsl2x7x.h"
 
+/* Max number of segments allowable in LUX table */
+#define TSL2X7X_MAX_LUX_TABLE_SIZE              9
+#define MAX_DEFAULT_TABLE_BYTES (sizeof(int) * TSL2X7X_MAX_LUX_TABLE_SIZE)
+
+struct iio_dev;
+
+struct tsl2x7x_lux {
+	unsigned int ratio;
+	unsigned int ch0;
+	unsigned int ch1;
+};
+
+/**
+ * struct tsl2x7x_default_settings - power on defaults unless
+ *                                   overridden by platform data.
+ *  @als_time:              ALS Integration time - multiple of 50mS
+ *  @als_gain:              Index into the ALS gain table.
+ *  @als_gain_trim:         default gain trim to account for
+ *                          aperture effects.
+ *  @wait_time:             Time between PRX and ALS cycles
+ *                          in 2.7 periods
+ *  @prx_time:              5.2ms prox integration time -
+ *                          decrease in 2.7ms periods
+ *  @prx_gain:              Proximity gain index
+ *  @prox_config:           Prox configuration filters.
+ *  @als_cal_target:        Known external ALS reading for
+ *                          calibration.
+ *  @interrupts_en:         Enable/Disable - 0x00 = none, 0x10 = als,
+ *                                           0x20 = prx,  0x30 = bth
+ *  @persistence:           H/W Filters, Number of 'out of limits'
+ *                          ADC readings PRX/ALS.
+ *  @als_thresh_low:        CH0 'low' count to trigger interrupt.
+ *  @als_thresh_high:       CH0 'high' count to trigger interrupt.
+ *  @prox_thres_low:        Low threshold proximity detection.
+ *  @prox_thres_high:       High threshold proximity detection
+ *  @prox_pulse_count:      Number if proximity emitter pulses
+ *  @prox_max_samples_cal:  Used for prox cal.
+ */
+
+struct tsl2x7x_settings {
+	int als_time;
+	int als_gain;
+	int als_gain_trim;
+	int wait_time;
+	int prx_time;
+	int prox_gain;
+	int prox_config;
+	int als_cal_target;
+	u8  interrupts_en;
+	u8  persistence;
+	int als_thresh_low;
+	int als_thresh_high;
+	int prox_thres_low;
+	int prox_thres_high;
+	int prox_pulse_count;
+	int prox_max_samples_cal;
+};
+
 /* Cal defs*/
 #define PROX_STAT_CAL        0
 #define PROX_STAT_SAMP       1
-- 
2.11.0

