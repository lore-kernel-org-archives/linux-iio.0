Return-Path: <jic23@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	ggao@invensense.com
Cc: lars@metafoo.de,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH] iio:imu:inv Suggested trivial fixups for the submitted patch.
Date: Sat,  2 Feb 2013 11:28:08 +0000
Message-Id: <1359804488-1393-1-git-send-email-jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

Not signed off on basis I would like these merged into the original
patch and then a new version of that sent out.
---
 Documentation/ABI/testing/sysfs-bus-iio-mpu6050  |  1 -
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c       | 45 ++++++++++++++----------
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h        |  1 -
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c       | 14 ++++----
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c    |  6 ++--
 include/linux/platform_data/invensense_mpu6050.h |  1 -
 6 files changed, 39 insertions(+), 29 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-mpu6050 b/Documentation/ABI/testing/sysfs-bus-iio-mpu6050
index d4ec747..cb53737 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio-mpu6050
+++ b/Documentation/ABI/testing/sysfs-bus-iio-mpu6050
@@ -11,4 +11,3 @@ Description:
 		positions relative to the board that holds these sensors. Identity matrix
 		[1, 0, 0; 0, 1, 0; 0, 0, 1] means sensor chip and device are perfectly
 		aligned with each other. All axes are exactly the same.
-
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 45fefaf..b26ade1 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -25,12 +25,16 @@
 #include <linux/spinlock.h>
 #include "inv_mpu_iio.h"
 
-/* this is the gyro scale translated from dynamic range plus/minus
-   {250, 500, 1000, 2000} to rad/s */
+/*
+ * this is the gyro scale translated from dynamic range plus/minus
+ * {250, 500, 1000, 2000} to rad/s 
+ */
 static const int gyro_scale_6050[] = {133090, 266181, 532362, 1064724};
 
-/* this is the accel scale translated from dynamic range plus/minus
-   {2, 4, 8, 16} to m/s^2 */
+/*
+ * this is the accel scale translated from dynamic range plus/minus
+ * {2, 4, 8, 16} to m/s^2
+ */
 static const int accel_scale[] = {598, 1196, 2392, 4785};
 
 static const struct inv_mpu6050_reg_map reg_set_6050 = {
@@ -145,7 +149,7 @@ int inv_mpu6050_set_power_itg(struct inv_mpu6050_state *st, bool power_on)
 	return 0;
 }
 
-/*
+/**
  *  inv_mpu6050_init_config() - Initialize hardware, disable FIFO.
  *
  *  Initial configuration:
@@ -400,7 +404,9 @@ error_write_raw:
 	return result;
 }
 
- /*  inv_mpu6050_set_lpf() - set low pass filer based on fifo rate.
+/**
+ *  inv_mpu6050_set_lpf() - set low pass filer based on fifo rate.
+ *
  *                  Based on the Nyquist principle, the sampling rate must
  *                  exceed twice of the bandwidth of the signal, or there
  *                  would be alising. This function basically search for the
@@ -429,8 +435,8 @@ static int inv_mpu6050_set_lpf(struct inv_mpu6050_state *st, int rate)
 	return 0;
 }
 
-/*
- *  inv_mpu6050_fifo_rate_store() - Set fifo rate.
+/**
+ * inv_mpu6050_fifo_rate_store() - Set fifo rate.
  */
 static ssize_t inv_mpu6050_fifo_rate_store(struct device *dev,
 	struct device_attribute *attr, const char *buf, size_t count)
@@ -477,8 +483,8 @@ fifo_rate_fail:
 	return count;
 }
 
-/*
- *  inv_fifo_rate_show() - Get the current sampling rate.
+/**
+ * inv_fifo_rate_show() - Get the current sampling rate.
  */
 static ssize_t inv_fifo_rate_show(struct device *dev,
 	struct device_attribute *attr, char *buf)
@@ -488,9 +494,9 @@ static ssize_t inv_fifo_rate_show(struct device *dev,
 	return sprintf(buf, "%d\n", st->chip_config.fifo_rate);
 }
 
-/*
- * inv_attr_show() -  calling this function will show current
- *                     parameters.
+/**
+ * inv_attr_show() - calling this function will show current
+ *                    parameters.
  */
 static ssize_t inv_attr_show(struct device *dev,
 	struct device_attribute *attr, char *buf)
@@ -552,8 +558,10 @@ static int inv_mpu6050_validate_trigger(struct iio_dev *indio_dev,
 
 static const struct iio_chan_spec inv_mpu_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(INV_MPU6050_SCAN_TIMESTAMP),
-	/* Note that temperature should only be via polled reading only,
-	   not the final scan elements output. */
+	/*
+	 * Note that temperature should only be via polled reading only,
+	 * not the final scan elements output.
+	 */
 	{
 		.type = IIO_TEMP,
 		.info_mask =  IIO_CHAN_INFO_RAW_SEPARATE_BIT
@@ -570,7 +578,7 @@ static const struct iio_chan_spec inv_mpu_channels[] = {
 	INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_Z, INV_MPU6050_SCAN_ACCL_Z),
 };
 
-/*constant IIO attribute */
+/* constant IIO attribute */
 static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("10 20 50 100 200 500");
 static IIO_DEV_ATTR_SAMP_FREQ(S_IRUGO | S_IWUSR, inv_fifo_rate_show,
 	inv_mpu6050_fifo_rate_store);
@@ -599,7 +607,7 @@ static const struct iio_info mpu_info = {
 	.validate_trigger = inv_mpu6050_validate_trigger,
 };
 
-/*
+/**
  *  inv_check_and_setup_chip() - check and setup chip.
  */
 static int inv_check_and_setup_chip(struct inv_mpu6050_state *st,
@@ -758,7 +766,8 @@ static SIMPLE_DEV_PM_OPS(inv_mpu_pmops, inv_mpu_suspend, inv_mpu_resume);
 #define INV_MPU6050_PMOPS NULL
 #endif /* CONFIG_PM_SLEEP */
 
-/* device id table is used to identify what device can be
+/*
+ * device id table is used to identify what device can be
  * supported by this driver
  */
 static const struct i2c_device_id inv_mpu_id[] = {
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
index 34cd054..f383955 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -244,4 +244,3 @@ int inv_reset_fifo(struct iio_dev *indio_dev);
 int inv_mpu6050_switch_engine(struct inv_mpu6050_state *st, bool en, u32 mask);
 int inv_mpu6050_write_reg(struct inv_mpu6050_state *st, int reg, u8 val);
 int inv_mpu6050_set_power_itg(struct inv_mpu6050_state *st, bool power_on);
-
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
index e1deee4..331781f 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
@@ -94,8 +94,8 @@ static void inv_clear_kfifo(struct inv_mpu6050_state *st)
 	spin_unlock_irqrestore(&st->time_stamp_lock, flags);
 }
 
-/*
- *  inv_mpu6050_irq_handler() - Cache a timestamp at each data ready interrupt.
+/**
+ * inv_mpu6050_irq_handler() - Cache a timestamp at each data ready interrupt.
  */
 irqreturn_t inv_mpu6050_irq_handler(int irq, void *p)
 {
@@ -112,8 +112,8 @@ irqreturn_t inv_mpu6050_irq_handler(int irq, void *p)
 	return IRQ_WAKE_THREAD;
 }
 
-/*
- *  inv_mpu6050_read_fifo() - Transfer data from hardware FIFO to KFIFO.
+/**
+ * inv_mpu6050_read_fifo() - Transfer data from hardware FIFO to KFIFO.
  */
 irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 {
@@ -138,8 +138,10 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 	if (st->chip_config.gyro_fifo_enable)
 		bytes_per_datum += INV_MPU6050_BYTES_PER_3AXIS_SENSOR;
 
-	/* read fifo_count register to know how many bytes inside FIFO
-	   right now */
+	/*
+	 * read fifo_count register to know how many bytes inside FIFO
+	 * right now
+	 */
 	result = i2c_smbus_read_i2c_block_data(st->client,
 				       st->reg->fifo_count_h,
 				       INV_MPU6050_FIFO_COUNT_BYTE, data);
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
index 6f62caf..e1d0869 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
@@ -95,8 +95,10 @@ static int inv_mpu6050_set_enable(struct iio_dev *indio_dev, bool enable)
 	return 0;
 }
 
-/*
- * inv_mpu_data_rdy_trigger_set_state() set data ready interrupt state
+/**
+ * inv_mpu_data_rdy_trigger_set_state() - set data ready interrupt state
+ * @trig: Trigger instance
+ * @state: Desired trigger state
  */
 static int inv_mpu_data_rdy_trigger_set_state(struct iio_trigger *trig,
 						bool state)
diff --git a/include/linux/platform_data/invensense_mpu6050.h b/include/linux/platform_data/invensense_mpu6050.h
index 2303d65..ad3aa7b 100644
--- a/include/linux/platform_data/invensense_mpu6050.h
+++ b/include/linux/platform_data/invensense_mpu6050.h
@@ -9,7 +9,6 @@
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
-*
 */
 
 #ifndef __INV_MPU6050_PLATFORM_H_
-- 
1.8.1.1
