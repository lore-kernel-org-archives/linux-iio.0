Return-Path: <jic23@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: k.wrona@samsung.com,
	kbuild-all@01.org,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH V2] iio:common:ssp_sensors fix warnings due to 32 bit instead of 64 bit passed to do_div
Date: Sat, 31 Jan 2015 09:42:14 +0000
Message-Id: <1422697334-13656-1-git-send-email-jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

Also change to div64_u64 in one place to avoid loss of precision
(was dividing a 32 bit number by a 64 bit number, but casting this
to 64 bit divided by 32 bit)  Those divide functions certainly have
esoteric naming!

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
 drivers/iio/common/ssp_sensors/ssp_iio_sensor.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/common/ssp_sensors/ssp_iio_sensor.h b/drivers/iio/common/ssp_sensors/ssp_iio_sensor.h
index dda267c9bd2a..541c6590d69c 100644
--- a/drivers/iio/common/ssp_sensors/ssp_iio_sensor.h
+++ b/drivers/iio/common/ssp_sensors/ssp_iio_sensor.h
@@ -30,7 +30,7 @@
 }
 
 #define SSP_MS_PER_S			1000
-#define SSP_INVERTED_SCALING_FACTOR	1000000ULL
+#define SSP_INVERTED_SCALING_FACTOR	1000000U
 
 #define SSP_FACTOR_WITH_MS \
 	(SSP_INVERTED_SCALING_FACTOR * SSP_MS_PER_S)
@@ -53,7 +53,8 @@ static inline void ssp_convert_to_freq(u32 time, int *integer_part,
 	}
 
 	*integer_part = SSP_FACTOR_WITH_MS / time;
-	*fractional = do_div(*integer_part, SSP_INVERTED_SCALING_FACTOR);
+	*fractional = *integer_part % SSP_INVERTED_SCALING_FACTOR;
+	*integer_part = *integer_part / SSP_INVERTED_SCALING_FACTOR;
 }
 
 /* Converts frequency to time in ms */
@@ -61,10 +62,10 @@ static inline int ssp_convert_to_time(int integer_part, int fractional)
 {
 	u64 value;
 
-	value = integer_part * SSP_INVERTED_SCALING_FACTOR + fractional;
+	value = (u64)integer_part * SSP_INVERTED_SCALING_FACTOR + fractional;
 	if (value == 0)
 		return 0;
 
-	return div_u64(SSP_FACTOR_WITH_MS, value);
+	return div64_u64((u64)SSP_FACTOR_WITH_MS, value);
 }
 #endif /* __SSP_IIO_SENSOR_H__ */
-- 
2.2.2
