Return-Path: <jic23@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: k.wrona@samsung.com,
	kbuild-all@01.org,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH] iio:common:ssp_sensors fix warnings due to 32 bit instead of 64 bit passed to do_div
Date: Fri, 30 Jan 2015 18:25:58 +0000
Message-Id: <1422642358-30473-1-git-send-email-jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

Fixes warnings with asm-generic/div64.h do_div such as:
   In file included from drivers/iio/common/ssp_sensors/ssp_iio.c:20:0:
   drivers/iio/common/ssp_sensors/ssp_iio_sensor.h: In function 'ssp_convert_to_freq':
>> drivers/iio/common/ssp_sensors/ssp_iio_sensor.h:56:16: warning: comparison of distinct pointer types lacks a cast [enabled by default]
   drivers/iio/common/ssp_sensors/ssp_iio_sensor.h:56:2: warning: right shift count >= width of type [enabled by default]
>> drivers/iio/common/ssp_sensors/ssp_iio_sensor.h:56:2: warning: passing argument 1 of '__div64_32' from incompatible pointer type [enabled by default]
   include/asm-generic/div64.h:35:17: note: expected 'uint64_t *' but argument is of type 'int *'
   drivers/iio/common/ssp_sensors/ssp_iio.c: In function 'ssp_common_process_data':
   include/linux/iio/buffer.h:142:32: warning: 'calculated_time' may be used uninitialized in this function [-Wuninitialized]
   drivers/iio/common/ssp_sensors/ssp_iio.c:83:10: note: 'calculated_time' was declared here

Fixed by using straight coded version as per the description in the
div64.h header, thus ensuring no issue with 32 bit integers.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/common/ssp_sensors/ssp_iio_sensor.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/common/ssp_sensors/ssp_iio_sensor.h b/drivers/iio/common/ssp_sensors/ssp_iio_sensor.h
index dda267c9bd2a..fdf61a8c499a 100644
--- a/drivers/iio/common/ssp_sensors/ssp_iio_sensor.h
+++ b/drivers/iio/common/ssp_sensors/ssp_iio_sensor.h
@@ -53,7 +53,8 @@ static inline void ssp_convert_to_freq(u32 time, int *integer_part,
 	}
 
 	*integer_part = SSP_FACTOR_WITH_MS / time;
-	*fractional = do_div(*integer_part, SSP_INVERTED_SCALING_FACTOR);
+	*fractional = *integer_part % SSP_INVERTED_SCALING_FACTOR;
+	*integer_part = *integer_part / SSP_INVERTED_SCALING_FACTOR;
 }
 
 /* Converts frequency to time in ms */
-- 
2.2.2
