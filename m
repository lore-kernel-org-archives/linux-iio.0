Return-Path: <srinivas.pandruvada@linux.intel.com>
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] io: accel: kxcjk1013 Fix missing unlock errors
Date: Mon, 16 Jun 2014 12:00:57 -0700
Message-Id: <1402945257-12665-1-git-send-email-srinivas.pandruvada@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

Fix unlock at two places. One when i2c error occurs and other
when trigger set state when raw read is in progress.

kbuild test robot errors:
>> drivers/iio/accel/kxcjk-1013.c:531:3-9: preceding lock on line 524
>> drivers/iio/accel/kxcjk-1013.c:376:4-10: preceding lock on line 368

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/accel/kxcjk-1013.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index 2326e43..72a6dbb 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -372,8 +372,10 @@ static int kxcjk1013_read_raw(struct iio_dev *indio_dev,
 			int sleep_val;
 
 			ret = kxcjk1013_set_mode(data, OPERATION);
-			if (ret < 0)
+			if (ret < 0) {
+				mutex_unlock(&data->mutex);
 				return ret;
+			}
 			++data->power_state;
 			sleep_val = kxcjk1013_get_startup_times(data);
 			if (sleep_val < 20000)
@@ -527,8 +529,10 @@ static int kxcjk1013_data_rdy_trigger_set_state(struct iio_trigger *trig,
 		kxcjk1013_set_mode(data, OPERATION);
 		++data->power_state;
 	} else {
-		if (--data->power_state)
+		if (--data->power_state) {
+			mutex_unlock(&data->mutex);
 			return 0;
+		}
 		kxcjk1013_chip_setup_interrupt(data, false);
 		kxcjk1013_set_mode(data, STANDBY);
 	}
-- 
1.7.11.7
