Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 1/3] staging:iio:tree wide.  abi fixup for in_ out_ prefix introduction.
Date: Wed, 14 Sep 2011 13:01:23 +0100
Message-Id: <1316001685-13375-2-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1316001685-13375-1-git-send-email-jic23@cam.ac.uk>
References: <1316001685-13375-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

This patch set should bring all the attributes created outside
of chan_spec registration inline with the new abi.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
Acked-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/accel/adis16204_core.c      |   12 ++--
 drivers/staging/iio/accel/adis16240_core.c      |    4 +-
 drivers/staging/iio/accel/sca3000_core.c        |   10 ++--
 drivers/staging/iio/accel/sca3000_ring.c        |    4 +-
 drivers/staging/iio/adc/ad7192.c                |    9 ++--
 drivers/staging/iio/adc/ad7280a.c               |   12 ++--
 drivers/staging/iio/adc/ad7745.c                |   36 +++++++-------
 drivers/staging/iio/adc/ad799x_core.c           |   60 +++++++++++-----------
 drivers/staging/iio/dac/ad5446.c                |   26 +++++-----
 drivers/staging/iio/dac/ad5504.c                |   43 ++++++++--------
 drivers/staging/iio/dac/ad5624r_spi.c           |   30 ++++++------
 drivers/staging/iio/dac/ad5686.c                |   30 ++++++-----
 drivers/staging/iio/dac/dac.h                   |    2 +-
 drivers/staging/iio/dac/max517.c                |   25 +++++----
 drivers/staging/iio/impedance-analyzer/ad5933.c |   32 ++++++------
 drivers/staging/iio/magnetometer/hmc5843.c      |    4 +-
 drivers/staging/iio/meter/ade7753.c             |   10 ++--
 drivers/staging/iio/meter/ade7754.c             |   10 ++--
 drivers/staging/iio/meter/ade7758_core.c        |   10 ++--
 drivers/staging/iio/meter/ade7759.c             |   10 ++--
 drivers/staging/iio/sysfs.h                     |    6 +-
 21 files changed, 196 insertions(+), 189 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16204_core.c b/drivers/staging/iio/accel/adis16204_core.c
index e0b8784..b0d6a2e 100644
--- a/drivers/staging/iio/accel/adis16204_core.c
+++ b/drivers/staging/iio/accel/adis16204_core.c
@@ -301,15 +301,15 @@ err_ret:
 
 /* Unique to this driver currently */
 #define IIO_DEV_ATTR_ACCEL_XY(_show, _addr)			\
-	IIO_DEVICE_ATTR(accel_xy, S_IRUGO, _show, NULL, _addr)
+	IIO_DEVICE_ATTR(in_accel_xy, S_IRUGO, _show, NULL, _addr)
 #define IIO_DEV_ATTR_ACCEL_XYPEAK(_show, _addr)		\
-	IIO_DEVICE_ATTR(accel_xypeak, S_IRUGO, _show, NULL, _addr)
+	IIO_DEVICE_ATTR(in_accel_xypeak, S_IRUGO, _show, NULL, _addr)
 
 static IIO_DEV_ATTR_ACCEL_XY(adis16204_read_14bit_signed,
 		ADIS16204_XY_RSS_OUT);
 static IIO_DEV_ATTR_ACCEL_XYPEAK(adis16204_read_14bit_signed,
 		ADIS16204_XY_PEAK_OUT);
-static IIO_CONST_ATTR(accel_xy_scale, "0.017125");
+static IIO_CONST_ATTR(in_accel_xy_scale, "0.017125");
 
 static IIO_DEVICE_ATTR(reset, S_IWUSR, NULL, adis16204_write_reset, 0);
 
@@ -475,9 +475,9 @@ static struct iio_chan_spec adis16204_channels[] = {
 
 static struct attribute *adis16204_attributes[] = {
 	&iio_dev_attr_reset.dev_attr.attr,
-	&iio_dev_attr_accel_xy.dev_attr.attr,
-	&iio_dev_attr_accel_xypeak.dev_attr.attr,
-	&iio_const_attr_accel_xy_scale.dev_attr.attr,
+	&iio_dev_attr_in_accel_xy.dev_attr.attr,
+	&iio_dev_attr_in_accel_xypeak.dev_attr.attr,
+	&iio_const_attr_in_accel_xy_scale.dev_attr.attr,
 	NULL
 };
 
diff --git a/drivers/staging/iio/accel/adis16240_core.c b/drivers/staging/iio/accel/adis16240_core.c
index 0dd02a3..282a746 100644
--- a/drivers/staging/iio/accel/adis16240_core.c
+++ b/drivers/staging/iio/accel/adis16240_core.c
@@ -325,7 +325,7 @@ err_ret:
 	return ret;
 }
 
-static IIO_DEVICE_ATTR(accel_xyz_squared_peak_raw, S_IRUGO,
+static IIO_DEVICE_ATTR(in_accel_xyz_squared_peak_raw, S_IRUGO,
 		       adis16240_read_12bit_signed, NULL,
 		       ADIS16240_XYZPEAK_OUT);
 
@@ -500,7 +500,7 @@ static struct iio_chan_spec adis16240_channels[] = {
 };
 
 static struct attribute *adis16240_attributes[] = {
-	&iio_dev_attr_accel_xyz_squared_peak_raw.dev_attr.attr,
+	&iio_dev_attr_in_accel_xyz_squared_peak_raw.dev_attr.attr,
 	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
 	&iio_dev_attr_reset.dev_attr.attr,
 	NULL
diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
index e0407e2..394b04e 100644
--- a/drivers/staging/iio/accel/sca3000_core.c
+++ b/drivers/staging/iio/accel/sca3000_core.c
@@ -771,9 +771,9 @@ static struct attribute *sca3000_attributes_with_temp[] = {
 	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
 	&iio_dev_attr_sampling_frequency.dev_attr.attr,
 	/* Only present if temp sensor is */
-	&iio_dev_attr_temp_raw.dev_attr.attr,
-	&iio_const_attr_temp_offset.dev_attr.attr,
-	&iio_const_attr_temp_scale.dev_attr.attr,
+	&iio_dev_attr_in_temp_raw.dev_attr.attr,
+	&iio_const_attr_in_temp_offset.dev_attr.attr,
+	&iio_const_attr_in_temp_scale.dev_attr.attr,
 	NULL,
 };
 
@@ -1018,14 +1018,14 @@ exit_point:
 
 /* Free fall detector related event attribute */
 static IIO_DEVICE_ATTR_NAMED(accel_xayaz_mag_falling_en,
-			     accel_x&y&z_mag_falling_en,
+			     in_accel_x&y&z_mag_falling_en,
 			     S_IRUGO | S_IWUSR,
 			     sca3000_query_free_fall_mode,
 			     sca3000_set_free_fall_mode,
 			     0);
 
 static IIO_CONST_ATTR_NAMED(accel_xayaz_mag_falling_period,
-			    accel_x&y&z_mag_falling_period,
+			    in_accel_x&y&z_mag_falling_period,
 			    "0.226");
 
 static struct attribute *sca3000_event_attributes[] = {
diff --git a/drivers/staging/iio/accel/sca3000_ring.c b/drivers/staging/iio/accel/sca3000_ring.c
index 3d6dafa..996b01e 100644
--- a/drivers/staging/iio/accel/sca3000_ring.c
+++ b/drivers/staging/iio/accel/sca3000_ring.c
@@ -229,7 +229,7 @@ static ssize_t sca3000_show_buffer_scale(struct device *dev,
 	return sprintf(buf, "0.%06d\n", 4*st->info->scale);
 }
 
-static IIO_DEVICE_ATTR(accel_scale,
+static IIO_DEVICE_ATTR(in_accel_scale,
 		       S_IRUGO,
 		       sca3000_show_buffer_scale,
 		       NULL,
@@ -247,7 +247,7 @@ static struct attribute *sca3000_ring_attributes[] = {
 	&dev_attr_enable.attr,
 	&iio_dev_attr_50_percent.dev_attr.attr,
 	&iio_dev_attr_75_percent.dev_attr.attr,
-	&iio_dev_attr_accel_scale.dev_attr.attr,
+	&iio_dev_attr_in_accel_scale.dev_attr.attr,
 	NULL,
 };
 
diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index 5bc1051..5a389b8 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -747,10 +747,11 @@ static ssize_t ad7192_show_scale_available(struct device *dev,
 	return len;
 }
 
-static IIO_DEVICE_ATTR_NAMED(in_m_in_scale_available, in-in_scale_available,
+static IIO_DEVICE_ATTR_NAMED(in_v_m_v_scale_available,
+			     in_voltage-voltage_scale_available,
 			     S_IRUGO, ad7192_show_scale_available, NULL, 0);
 
-static IIO_DEVICE_ATTR(in_scale_available, S_IRUGO,
+static IIO_DEVICE_ATTR(in_voltage_scale_available, S_IRUGO,
 		       ad7192_show_scale_available, NULL, 0);
 
 static ssize_t ad7192_show_ac_excitation(struct device *dev,
@@ -830,8 +831,8 @@ static IIO_DEVICE_ATTR(ac_excitation_en, S_IRUGO | S_IWUSR,
 
 static struct attribute *ad7192_attributes[] = {
 	&iio_dev_attr_sampling_frequency.dev_attr.attr,
-	&iio_dev_attr_in_m_in_scale_available.dev_attr.attr,
-	&iio_dev_attr_in_scale_available.dev_attr.attr,
+	&iio_dev_attr_in_v_m_v_scale_available.dev_attr.attr,
+	&iio_dev_attr_in_voltage_scale_available.dev_attr.attr,
 	&iio_dev_attr_bridge_switch_en.dev_attr.attr,
 	&iio_dev_attr_ac_excitation_en.dev_attr.attr,
 	NULL
diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index 2d8d650..4c67cfe 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -736,26 +736,26 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
 }
 
 static IIO_DEVICE_ATTR_NAMED(in_thresh_low_value,
-		in-in_thresh_low_value,
+		in_voltage-voltage_thresh_low_value,
 		S_IRUGO | S_IWUSR,
 		ad7280_read_channel_config,
 		ad7280_write_channel_config,
 		AD7280A_CELL_UNDERVOLTAGE);
 
 static IIO_DEVICE_ATTR_NAMED(in_thresh_high_value,
-		in-in_thresh_high_value,
+		in_voltage-voltage_thresh_high_value,
 		S_IRUGO | S_IWUSR,
 		ad7280_read_channel_config,
 		ad7280_write_channel_config,
 		AD7280A_CELL_OVERVOLTAGE);
 
-static IIO_DEVICE_ATTR(temp_thresh_low_value,
+static IIO_DEVICE_ATTR(in_temp_thresh_low_value,
 		S_IRUGO | S_IWUSR,
 		ad7280_read_channel_config,
 		ad7280_write_channel_config,
 		AD7280A_AUX_ADC_UNDERVOLTAGE);
 
-static IIO_DEVICE_ATTR(temp_thresh_high_value,
+static IIO_DEVICE_ATTR(in_temp_thresh_high_value,
 		S_IRUGO | S_IWUSR,
 		ad7280_read_channel_config,
 		ad7280_write_channel_config,
@@ -765,8 +765,8 @@ static IIO_DEVICE_ATTR(temp_thresh_high_value,
 static struct attribute *ad7280_event_attributes[] = {
 	&iio_dev_attr_in_thresh_low_value.dev_attr.attr,
 	&iio_dev_attr_in_thresh_high_value.dev_attr.attr,
-	&iio_dev_attr_temp_thresh_low_value.dev_attr.attr,
-	&iio_dev_attr_temp_thresh_high_value.dev_attr.attr,
+	&iio_dev_attr_in_temp_thresh_low_value.dev_attr.attr,
+	&iio_dev_attr_in_temp_thresh_high_value.dev_attr.attr,
 	NULL,
 };
 
diff --git a/drivers/staging/iio/adc/ad7745.c b/drivers/staging/iio/adc/ad7745.c
index eea77f1..827344c 100644
--- a/drivers/staging/iio/adc/ad7745.c
+++ b/drivers/staging/iio/adc/ad7745.c
@@ -131,21 +131,21 @@ static int ad774x_i2c_write(struct ad774x_chip_info *chip, u8 reg, u8 data)
 #define IIO_DEV_ATTR_CONVERSION_MODE(_mode, _show, _store)              \
 	IIO_DEVICE_ATTR(conversion_mode, _mode, _show, _store, 0)
 #define IIO_DEV_ATTR_CAP_SETUP(_mode, _show, _store)		\
-	IIO_DEVICE_ATTR(cap_setup, _mode, _show, _store, 0)
+	IIO_DEVICE_ATTR(in_capacitance_setup, _mode, _show, _store, 0)
 #define IIO_DEV_ATTR_VT_SETUP(_mode, _show, _store)              \
-	IIO_DEVICE_ATTR(in0_setup, _mode, _show, _store, 0)
+	IIO_DEVICE_ATTR(in_voltage0_setup, _mode, _show, _store, 0)
 #define IIO_DEV_ATTR_EXEC_SETUP(_mode, _show, _store)              \
 	IIO_DEVICE_ATTR(exec_setup, _mode, _show, _store, 0)
 #define IIO_DEV_ATTR_VOLT_GAIN(_mode, _show, _store)		\
-	IIO_DEVICE_ATTR(in0_gain, _mode, _show, _store, 0)
+	IIO_DEVICE_ATTR(in_voltage0_gain, _mode, _show, _store, 0)
 #define IIO_DEV_ATTR_CAP_OFFS(_mode, _show, _store)		\
-	IIO_DEVICE_ATTR(cap_offs, _mode, _show, _store, 0)
+	IIO_DEVICE_ATTR(in_capacitance_offs, _mode, _show, _store, 0)
 #define IIO_DEV_ATTR_CAP_GAIN(_mode, _show, _store)		\
-	IIO_DEVICE_ATTR(cap_gain, _mode, _show, _store, 0)
+	IIO_DEVICE_ATTR(in_capacitance_gain, _mode, _show, _store, 0)
 #define IIO_DEV_ATTR_CAP_DATA(_show)		\
-	IIO_DEVICE_ATTR(cap0_raw, S_IRUGO, _show, NULL, 0)
+	IIO_DEVICE_ATTR(in_capacitance0_raw, S_IRUGO, _show, NULL, 0)
 #define IIO_DEV_ATTR_VT_DATA(_show)		\
-	IIO_DEVICE_ATTR(in0_raw, S_IRUGO, _show, NULL, 0)
+	IIO_DEVICE_ATTR(in_voltage0_raw, S_IRUGO, _show, NULL, 0)
 
 static ssize_t ad774x_show_conversion_modes(struct device *dev,
 		struct device_attribute *attr,
@@ -241,12 +241,12 @@ static ssize_t ad774x_store_dac_value(struct device *dev,
 	return -EINVAL;
 }
 
-static IIO_DEVICE_ATTR(capdac0_raw, S_IRUGO | S_IWUSR,
+static IIO_DEVICE_ATTR(out_capacitance0_raw, S_IRUGO | S_IWUSR,
 			ad774x_show_dac_value,
 			ad774x_store_dac_value,
 			AD774X_CAPDACA);
 
-static IIO_DEVICE_ATTR(capdac1_raw, S_IRUGO | S_IWUSR,
+static IIO_DEVICE_ATTR(out_capacitance1_raw, S_IRUGO | S_IWUSR,
 			ad774x_show_dac_value,
 			ad774x_store_dac_value,
 			AD774X_CAPDACB);
@@ -501,16 +501,16 @@ static IIO_DEV_ATTR_CAP_GAIN(S_IRUGO | S_IWUSR,
 static struct attribute *ad774x_attributes[] = {
 	&iio_dev_attr_available_conversion_modes.dev_attr.attr,
 	&iio_dev_attr_conversion_mode.dev_attr.attr,
-	&iio_dev_attr_cap_setup.dev_attr.attr,
-	&iio_dev_attr_in0_setup.dev_attr.attr,
+	&iio_dev_attr_in_capacitance_setup.dev_attr.attr,
+	&iio_dev_attr_in_voltage0_setup.dev_attr.attr,
 	&iio_dev_attr_exec_setup.dev_attr.attr,
-	&iio_dev_attr_cap_offs.dev_attr.attr,
-	&iio_dev_attr_cap_gain.dev_attr.attr,
-	&iio_dev_attr_in0_gain.dev_attr.attr,
-	&iio_dev_attr_in0_raw.dev_attr.attr,
-	&iio_dev_attr_cap0_raw.dev_attr.attr,
-	&iio_dev_attr_capdac0_raw.dev_attr.attr,
-	&iio_dev_attr_capdac1_raw.dev_attr.attr,
+	&iio_dev_attr_in_capacitance_offs.dev_attr.attr,
+	&iio_dev_attr_in_capacitance_gain.dev_attr.attr,
+	&iio_dev_attr_in_voltage0_gain.dev_attr.attr,
+	&iio_dev_attr_in_voltage0_raw.dev_attr.attr,
+	&iio_dev_attr_in_capacitance0_raw.dev_attr.attr,
+	&iio_dev_attr_out_capacitance0_raw.dev_attr.attr,
+	&iio_dev_attr_out_capacitance1_raw.dev_attr.attr,
 	NULL,
 };
 
diff --git a/drivers/staging/iio/adc/ad799x_core.c b/drivers/staging/iio/adc/ad799x_core.c
index 75b8c37..ae64ee9 100644
--- a/drivers/staging/iio/adc/ad799x_core.c
+++ b/drivers/staging/iio/adc/ad799x_core.c
@@ -350,73 +350,73 @@ static irqreturn_t ad799x_event_handler(int irq, void *private)
 	return IRQ_HANDLED;
 }
 
-static IIO_DEVICE_ATTR(in0_thresh_low_value,
+static IIO_DEVICE_ATTR(in_voltage0_thresh_low_value,
 		       S_IRUGO | S_IWUSR,
 		       ad799x_read_channel_config,
 		       ad799x_write_channel_config,
 		       AD7998_DATALOW_CH1_REG);
 
-static IIO_DEVICE_ATTR(in0_thresh_high_value,
+static IIO_DEVICE_ATTR(in_voltage0_thresh_high_value,
 		       S_IRUGO | S_IWUSR,
 		       ad799x_read_channel_config,
 		       ad799x_write_channel_config,
 		       AD7998_DATAHIGH_CH1_REG);
 
-static IIO_DEVICE_ATTR(in0_thresh_both_hyst_raw,
+static IIO_DEVICE_ATTR(in_voltage0_thresh_both_hyst_raw,
 		       S_IRUGO | S_IWUSR,
 		       ad799x_read_channel_config,
 		       ad799x_write_channel_config,
 		       AD7998_HYST_CH1_REG);
 
-static IIO_DEVICE_ATTR(in1_thresh_low_value,
+static IIO_DEVICE_ATTR(in_voltage1_thresh_low_value,
 		       S_IRUGO | S_IWUSR,
 		       ad799x_read_channel_config,
 		       ad799x_write_channel_config,
 		       AD7998_DATALOW_CH2_REG);
 
-static IIO_DEVICE_ATTR(in1_thresh_high_value,
+static IIO_DEVICE_ATTR(in_voltage1_thresh_high_value,
 		       S_IRUGO | S_IWUSR,
 		       ad799x_read_channel_config,
 		       ad799x_write_channel_config,
 		       AD7998_DATAHIGH_CH2_REG);
 
-static IIO_DEVICE_ATTR(in1_thresh_both_hyst_raw,
+static IIO_DEVICE_ATTR(in_voltage1_thresh_both_hyst_raw,
 		       S_IRUGO | S_IWUSR,
 		       ad799x_read_channel_config,
 		       ad799x_write_channel_config,
 		       AD7998_HYST_CH2_REG);
 
-static IIO_DEVICE_ATTR(in2_thresh_low_value,
+static IIO_DEVICE_ATTR(in_voltage2_thresh_low_value,
 		       S_IRUGO | S_IWUSR,
 		       ad799x_read_channel_config,
 		       ad799x_write_channel_config,
 		       AD7998_DATALOW_CH3_REG);
 
-static IIO_DEVICE_ATTR(in2_thresh_high_value,
+static IIO_DEVICE_ATTR(in_voltage2_thresh_high_value,
 		       S_IRUGO | S_IWUSR,
 		       ad799x_read_channel_config,
 		       ad799x_write_channel_config,
 		       AD7998_DATAHIGH_CH3_REG);
 
-static IIO_DEVICE_ATTR(in2_thresh_both_hyst_raw,
+static IIO_DEVICE_ATTR(in_voltage2_thresh_both_hyst_raw,
 		       S_IRUGO | S_IWUSR,
 		       ad799x_read_channel_config,
 		       ad799x_write_channel_config,
 		       AD7998_HYST_CH3_REG);
 
-static IIO_DEVICE_ATTR(in3_thresh_low_value,
+static IIO_DEVICE_ATTR(in_voltage3_thresh_low_value,
 		       S_IRUGO | S_IWUSR,
 		       ad799x_read_channel_config,
 		       ad799x_write_channel_config,
 		       AD7998_DATALOW_CH4_REG);
 
-static IIO_DEVICE_ATTR(in3_thresh_high_value,
+static IIO_DEVICE_ATTR(in_voltage3_thresh_high_value,
 		       S_IRUGO | S_IWUSR,
 		       ad799x_read_channel_config,
 		       ad799x_write_channel_config,
 		       AD7998_DATAHIGH_CH4_REG);
 
-static IIO_DEVICE_ATTR(in3_thresh_both_hyst_raw,
+static IIO_DEVICE_ATTR(in_voltage3_thresh_both_hyst_raw,
 		       S_IRUGO | S_IWUSR,
 		       ad799x_read_channel_config,
 		       ad799x_write_channel_config,
@@ -428,18 +428,18 @@ static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
 static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("15625 7812 3906 1953 976 488 244 0");
 
 static struct attribute *ad7993_4_7_8_event_attributes[] = {
-	&iio_dev_attr_in0_thresh_low_value.dev_attr.attr,
-	&iio_dev_attr_in0_thresh_high_value.dev_attr.attr,
-	&iio_dev_attr_in0_thresh_both_hyst_raw.dev_attr.attr,
-	&iio_dev_attr_in1_thresh_low_value.dev_attr.attr,
-	&iio_dev_attr_in1_thresh_high_value.dev_attr.attr,
-	&iio_dev_attr_in1_thresh_both_hyst_raw.dev_attr.attr,
-	&iio_dev_attr_in2_thresh_low_value.dev_attr.attr,
-	&iio_dev_attr_in2_thresh_high_value.dev_attr.attr,
-	&iio_dev_attr_in2_thresh_both_hyst_raw.dev_attr.attr,
-	&iio_dev_attr_in3_thresh_low_value.dev_attr.attr,
-	&iio_dev_attr_in3_thresh_high_value.dev_attr.attr,
-	&iio_dev_attr_in3_thresh_both_hyst_raw.dev_attr.attr,
+	&iio_dev_attr_in_voltage0_thresh_low_value.dev_attr.attr,
+	&iio_dev_attr_in_voltage0_thresh_high_value.dev_attr.attr,
+	&iio_dev_attr_in_voltage0_thresh_both_hyst_raw.dev_attr.attr,
+	&iio_dev_attr_in_voltage1_thresh_low_value.dev_attr.attr,
+	&iio_dev_attr_in_voltage1_thresh_high_value.dev_attr.attr,
+	&iio_dev_attr_in_voltage1_thresh_both_hyst_raw.dev_attr.attr,
+	&iio_dev_attr_in_voltage2_thresh_low_value.dev_attr.attr,
+	&iio_dev_attr_in_voltage2_thresh_high_value.dev_attr.attr,
+	&iio_dev_attr_in_voltage2_thresh_both_hyst_raw.dev_attr.attr,
+	&iio_dev_attr_in_voltage3_thresh_low_value.dev_attr.attr,
+	&iio_dev_attr_in_voltage3_thresh_high_value.dev_attr.attr,
+	&iio_dev_attr_in_voltage3_thresh_both_hyst_raw.dev_attr.attr,
 	&iio_dev_attr_sampling_frequency.dev_attr.attr,
 	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
 	NULL,
@@ -451,12 +451,12 @@ static struct attribute_group ad7993_4_7_8_event_attrs_group = {
 };
 
 static struct attribute *ad7992_event_attributes[] = {
-	&iio_dev_attr_in0_thresh_low_value.dev_attr.attr,
-	&iio_dev_attr_in0_thresh_high_value.dev_attr.attr,
-	&iio_dev_attr_in0_thresh_both_hyst_raw.dev_attr.attr,
-	&iio_dev_attr_in1_thresh_low_value.dev_attr.attr,
-	&iio_dev_attr_in1_thresh_high_value.dev_attr.attr,
-	&iio_dev_attr_in1_thresh_both_hyst_raw.dev_attr.attr,
+	&iio_dev_attr_in_voltage0_thresh_low_value.dev_attr.attr,
+	&iio_dev_attr_in_voltage0_thresh_high_value.dev_attr.attr,
+	&iio_dev_attr_in_voltage0_thresh_both_hyst_raw.dev_attr.attr,
+	&iio_dev_attr_in_voltage1_thresh_low_value.dev_attr.attr,
+	&iio_dev_attr_in_voltage1_thresh_high_value.dev_attr.attr,
+	&iio_dev_attr_in_voltage1_thresh_both_hyst_raw.dev_attr.attr,
 	&iio_dev_attr_sampling_frequency.dev_attr.attr,
 	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
 	NULL,
diff --git a/drivers/staging/iio/dac/ad5446.c b/drivers/staging/iio/dac/ad5446.c
index c670fb9..41a8872 100644
--- a/drivers/staging/iio/dac/ad5446.c
+++ b/drivers/staging/iio/dac/ad5446.c
@@ -105,7 +105,7 @@ static ssize_t ad5446_show_scale(struct device *dev,
 
 	return sprintf(buf, "%d.%03d\n", scale_uv / 1000, scale_uv % 1000);
 }
-static IIO_DEVICE_ATTR(out_scale, S_IRUGO, ad5446_show_scale, NULL, 0);
+static IIO_DEVICE_ATTR(out_voltage_scale, S_IRUGO, ad5446_show_scale, NULL, 0);
 
 static ssize_t ad5446_write_powerdown_mode(struct device *dev,
 				       struct device_attribute *attr,
@@ -177,23 +177,23 @@ static ssize_t ad5446_write_dac_powerdown(struct device *dev,
 	return ret ? ret : len;
 }
 
-static IIO_DEVICE_ATTR(out_powerdown_mode, S_IRUGO | S_IWUSR,
+static IIO_DEVICE_ATTR(out_voltage_powerdown_mode, S_IRUGO | S_IWUSR,
 			ad5446_read_powerdown_mode,
 			ad5446_write_powerdown_mode, 0);
 
-static IIO_CONST_ATTR(out_powerdown_mode_available,
+static IIO_CONST_ATTR(out_voltage_powerdown_mode_available,
 			"1kohm_to_gnd 100kohm_to_gnd three_state");
 
-static IIO_DEVICE_ATTR(out0_powerdown, S_IRUGO | S_IWUSR,
+static IIO_DEVICE_ATTR(out_voltage0_powerdown, S_IRUGO | S_IWUSR,
 			ad5446_read_dac_powerdown,
 			ad5446_write_dac_powerdown, 0);
 
 static struct attribute *ad5446_attributes[] = {
-	&iio_dev_attr_out0_raw.dev_attr.attr,
-	&iio_dev_attr_out_scale.dev_attr.attr,
-	&iio_dev_attr_out0_powerdown.dev_attr.attr,
-	&iio_dev_attr_out_powerdown_mode.dev_attr.attr,
-	&iio_const_attr_out_powerdown_mode_available.dev_attr.attr,
+	&iio_dev_attr_out_voltage0_raw.dev_attr.attr,
+	&iio_dev_attr_out_voltage_scale.dev_attr.attr,
+	&iio_dev_attr_out_voltage0_powerdown.dev_attr.attr,
+	&iio_dev_attr_out_voltage_powerdown_mode.dev_attr.attr,
+	&iio_const_attr_out_voltage_powerdown_mode_available.dev_attr.attr,
 	NULL,
 };
 
@@ -207,10 +207,12 @@ static mode_t ad5446_attr_is_visible(struct kobject *kobj,
 	mode_t mode = attr->mode;
 
 	if (!st->chip_info->store_pwr_down &&
-		(attr == &iio_dev_attr_out0_powerdown.dev_attr.attr ||
-		attr == &iio_dev_attr_out_powerdown_mode.dev_attr.attr ||
+		(attr == &iio_dev_attr_out_voltage0_powerdown.dev_attr.attr ||
+		attr == &iio_dev_attr_out_voltage_powerdown_mode.
+		 dev_attr.attr ||
 		attr ==
-		&iio_const_attr_out_powerdown_mode_available.dev_attr.attr))
+		&iio_const_attr_out_voltage_powerdown_mode_available.
+		 dev_attr.attr))
 		mode = 0;
 
 	return mode;
diff --git a/drivers/staging/iio/dac/ad5504.c b/drivers/staging/iio/dac/ad5504.c
index c528dff..a430874 100644
--- a/drivers/staging/iio/dac/ad5504.c
+++ b/drivers/staging/iio/dac/ad5504.c
@@ -169,10 +169,10 @@ static ssize_t ad5504_show_scale(struct device *dev,
 
 	return sprintf(buf, "%d.%03d\n", scale_uv / 1000, scale_uv % 1000);
 }
-static IIO_DEVICE_ATTR(out_scale, S_IRUGO, ad5504_show_scale, NULL, 0);
+static IIO_DEVICE_ATTR(out_voltage_scale, S_IRUGO, ad5504_show_scale, NULL, 0);
 
 #define IIO_DEV_ATTR_OUT_RW_RAW(_num, _show, _store, _addr)		\
-	IIO_DEVICE_ATTR(out##_num##_raw,				\
+	IIO_DEVICE_ATTR(out_voltage##_num##_raw,			\
 			S_IRUGO | S_IWUSR, _show, _store, _addr)
 
 static IIO_DEV_ATTR_OUT_RW_RAW(0, ad5504_read_dac,
@@ -184,17 +184,16 @@ static IIO_DEV_ATTR_OUT_RW_RAW(2, ad5504_read_dac,
 static IIO_DEV_ATTR_OUT_RW_RAW(3, ad5504_read_dac,
 	ad5504_write_dac, AD5504_ADDR_DAC3);
 
-static IIO_DEVICE_ATTR(out_powerdown_mode, S_IRUGO |
+static IIO_DEVICE_ATTR(out_voltage_powerdown_mode, S_IRUGO |
 			S_IWUSR, ad5504_read_powerdown_mode,
 			ad5504_write_powerdown_mode, 0);
 
-static IIO_CONST_ATTR(out_powerdown_mode_available,
+static IIO_CONST_ATTR(out_voltage_powerdown_mode_available,
 			"20kohm_to_gnd three_state");
 
 #define IIO_DEV_ATTR_DAC_POWERDOWN(_num, _show, _store, _addr)		\
-	IIO_DEVICE_ATTR(out##_num##_powerdown,				\
+	IIO_DEVICE_ATTR(out_voltage##_num##_powerdown,			\
 			S_IRUGO | S_IWUSR, _show, _store, _addr)
-
 static IIO_DEV_ATTR_DAC_POWERDOWN(0, ad5504_read_dac_powerdown,
 				   ad5504_write_dac_powerdown, 0);
 static IIO_DEV_ATTR_DAC_POWERDOWN(1, ad5504_read_dac_powerdown,
@@ -205,17 +204,17 @@ static IIO_DEV_ATTR_DAC_POWERDOWN(3, ad5504_read_dac_powerdown,
 				   ad5504_write_dac_powerdown, 3);
 
 static struct attribute *ad5504_attributes[] = {
-	&iio_dev_attr_out0_raw.dev_attr.attr,
-	&iio_dev_attr_out1_raw.dev_attr.attr,
-	&iio_dev_attr_out2_raw.dev_attr.attr,
-	&iio_dev_attr_out3_raw.dev_attr.attr,
-	&iio_dev_attr_out0_powerdown.dev_attr.attr,
-	&iio_dev_attr_out1_powerdown.dev_attr.attr,
-	&iio_dev_attr_out2_powerdown.dev_attr.attr,
-	&iio_dev_attr_out3_powerdown.dev_attr.attr,
-	&iio_dev_attr_out_powerdown_mode.dev_attr.attr,
-	&iio_const_attr_out_powerdown_mode_available.dev_attr.attr,
-	&iio_dev_attr_out_scale.dev_attr.attr,
+	&iio_dev_attr_out_voltage0_raw.dev_attr.attr,
+	&iio_dev_attr_out_voltage1_raw.dev_attr.attr,
+	&iio_dev_attr_out_voltage2_raw.dev_attr.attr,
+	&iio_dev_attr_out_voltage3_raw.dev_attr.attr,
+	&iio_dev_attr_out_voltage0_powerdown.dev_attr.attr,
+	&iio_dev_attr_out_voltage1_powerdown.dev_attr.attr,
+	&iio_dev_attr_out_voltage2_powerdown.dev_attr.attr,
+	&iio_dev_attr_out_voltage3_powerdown.dev_attr.attr,
+	&iio_dev_attr_out_voltage_powerdown_mode.dev_attr.attr,
+	&iio_const_attr_out_voltage_powerdown_mode_available.dev_attr.attr,
+	&iio_dev_attr_out_voltage_scale.dev_attr.attr,
 	NULL,
 };
 
@@ -224,11 +223,11 @@ static const struct attribute_group ad5504_attribute_group = {
 };
 
 static struct attribute *ad5501_attributes[] = {
-	&iio_dev_attr_out0_raw.dev_attr.attr,
-	&iio_dev_attr_out0_powerdown.dev_attr.attr,
-	&iio_dev_attr_out_powerdown_mode.dev_attr.attr,
-	&iio_const_attr_out_powerdown_mode_available.dev_attr.attr,
-	&iio_dev_attr_out_scale.dev_attr.attr,
+	&iio_dev_attr_out_voltage0_raw.dev_attr.attr,
+	&iio_dev_attr_out_voltage0_powerdown.dev_attr.attr,
+	&iio_dev_attr_out_voltage_powerdown_mode.dev_attr.attr,
+	&iio_const_attr_out_voltage_powerdown_mode_available.dev_attr.attr,
+	&iio_dev_attr_out_voltage_scale.dev_attr.attr,
 	NULL,
 };
 
diff --git a/drivers/staging/iio/dac/ad5624r_spi.c b/drivers/staging/iio/dac/ad5624r_spi.c
index e5edf59..8e7fafb 100644
--- a/drivers/staging/iio/dac/ad5624r_spi.c
+++ b/drivers/staging/iio/dac/ad5624r_spi.c
@@ -173,22 +173,22 @@ static ssize_t ad5624r_show_scale(struct device *dev,
 
 	return sprintf(buf, "%d.%03d\n", scale_uv / 1000, scale_uv % 1000);
 }
-static IIO_DEVICE_ATTR(out_scale, S_IRUGO, ad5624r_show_scale, NULL, 0);
+static IIO_DEVICE_ATTR(out_voltage_scale, S_IRUGO, ad5624r_show_scale, NULL, 0);
 
 static IIO_DEV_ATTR_OUT_RAW(0, ad5624r_write_dac, AD5624R_ADDR_DAC0);
 static IIO_DEV_ATTR_OUT_RAW(1, ad5624r_write_dac, AD5624R_ADDR_DAC1);
 static IIO_DEV_ATTR_OUT_RAW(2, ad5624r_write_dac, AD5624R_ADDR_DAC2);
 static IIO_DEV_ATTR_OUT_RAW(3, ad5624r_write_dac, AD5624R_ADDR_DAC3);
 
-static IIO_DEVICE_ATTR(out_powerdown_mode, S_IRUGO |
+static IIO_DEVICE_ATTR(out_voltage_powerdown_mode, S_IRUGO |
 			S_IWUSR, ad5624r_read_powerdown_mode,
 			ad5624r_write_powerdown_mode, 0);
 
-static IIO_CONST_ATTR(out_powerdown_mode_available,
+static IIO_CONST_ATTR(out_voltage_powerdown_mode_available,
 			"1kohm_to_gnd 100kohm_to_gnd three_state");
 
 #define IIO_DEV_ATTR_DAC_POWERDOWN(_num, _show, _store, _addr)		\
-	IIO_DEVICE_ATTR(out##_num##_powerdown,				\
+	IIO_DEVICE_ATTR(out_voltage##_num##_powerdown,			\
 			S_IRUGO | S_IWUSR, _show, _store, _addr)
 
 static IIO_DEV_ATTR_DAC_POWERDOWN(0, ad5624r_read_dac_powerdown,
@@ -201,17 +201,17 @@ static IIO_DEV_ATTR_DAC_POWERDOWN(3, ad5624r_read_dac_powerdown,
 				   ad5624r_write_dac_powerdown, 3);
 
 static struct attribute *ad5624r_attributes[] = {
-	&iio_dev_attr_out0_raw.dev_attr.attr,
-	&iio_dev_attr_out1_raw.dev_attr.attr,
-	&iio_dev_attr_out2_raw.dev_attr.attr,
-	&iio_dev_attr_out3_raw.dev_attr.attr,
-	&iio_dev_attr_out0_powerdown.dev_attr.attr,
-	&iio_dev_attr_out1_powerdown.dev_attr.attr,
-	&iio_dev_attr_out2_powerdown.dev_attr.attr,
-	&iio_dev_attr_out3_powerdown.dev_attr.attr,
-	&iio_dev_attr_out_powerdown_mode.dev_attr.attr,
-	&iio_const_attr_out_powerdown_mode_available.dev_attr.attr,
-	&iio_dev_attr_out_scale.dev_attr.attr,
+	&iio_dev_attr_out_voltage0_raw.dev_attr.attr,
+	&iio_dev_attr_out_voltage1_raw.dev_attr.attr,
+	&iio_dev_attr_out_voltage2_raw.dev_attr.attr,
+	&iio_dev_attr_out_voltage3_raw.dev_attr.attr,
+	&iio_dev_attr_out_voltage0_powerdown.dev_attr.attr,
+	&iio_dev_attr_out_voltage1_powerdown.dev_attr.attr,
+	&iio_dev_attr_out_voltage2_powerdown.dev_attr.attr,
+	&iio_dev_attr_out_voltage3_powerdown.dev_attr.attr,
+	&iio_dev_attr_out_voltage_powerdown_mode.dev_attr.attr,
+	&iio_const_attr_out_voltage_powerdown_mode_available.dev_attr.attr,
+	&iio_dev_attr_out_voltage_scale.dev_attr.attr,
 	NULL,
 };
 
diff --git a/drivers/staging/iio/dac/ad5686.c b/drivers/staging/iio/dac/ad5686.c
index 6e76820..b55ef42 100644
--- a/drivers/staging/iio/dac/ad5686.c
+++ b/drivers/staging/iio/dac/ad5686.c
@@ -247,11 +247,12 @@ static ssize_t ad5686_write_dac_powerdown(struct device *dev,
 	return ret ? ret : len;
 }
 
-static IIO_CONST_ATTR(out_powerdown_mode_available,
+static IIO_CONST_ATTR(out_voltage_powerdown_mode_available,
 			"1kohm_to_gnd 100kohm_to_gnd three_state");
 
-#define IIO_DEV_ATTR_DAC_POWERDOWN_MODE(_num) \
-	IIO_DEVICE_ATTR(out##_num##_powerdown_mode, S_IRUGO | S_IWUSR,	\
+#define IIO_DEV_ATTR_DAC_POWERDOWN_MODE(_num)				\
+	IIO_DEVICE_ATTR(out_voltage##_num##_powerdown_mode,		\
+			S_IRUGO | S_IWUSR,				\
 			ad5686_read_powerdown_mode,			\
 			ad5686_write_powerdown_mode, _num)
 
@@ -260,8 +261,9 @@ static IIO_DEV_ATTR_DAC_POWERDOWN_MODE(1);
 static IIO_DEV_ATTR_DAC_POWERDOWN_MODE(2);
 static IIO_DEV_ATTR_DAC_POWERDOWN_MODE(3);
 
-#define IIO_DEV_ATTR_DAC_POWERDOWN(_num)	\
-	IIO_DEVICE_ATTR(out##_num##_powerdown, S_IRUGO | S_IWUSR,	\
+#define IIO_DEV_ATTR_DAC_POWERDOWN(_num)				\
+	IIO_DEVICE_ATTR(out_voltage##_num##_powerdown,			\
+			S_IRUGO | S_IWUSR,				\
 			ad5686_read_dac_powerdown,			\
 			ad5686_write_dac_powerdown, _num)
 
@@ -271,15 +273,15 @@ static IIO_DEV_ATTR_DAC_POWERDOWN(2);
 static IIO_DEV_ATTR_DAC_POWERDOWN(3);
 
 static struct attribute *ad5686_attributes[] = {
-	&iio_dev_attr_out0_powerdown.dev_attr.attr,
-	&iio_dev_attr_out1_powerdown.dev_attr.attr,
-	&iio_dev_attr_out2_powerdown.dev_attr.attr,
-	&iio_dev_attr_out3_powerdown.dev_attr.attr,
-	&iio_dev_attr_out0_powerdown_mode.dev_attr.attr,
-	&iio_dev_attr_out1_powerdown_mode.dev_attr.attr,
-	&iio_dev_attr_out2_powerdown_mode.dev_attr.attr,
-	&iio_dev_attr_out3_powerdown_mode.dev_attr.attr,
-	&iio_const_attr_out_powerdown_mode_available.dev_attr.attr,
+	&iio_dev_attr_out_voltage0_powerdown.dev_attr.attr,
+	&iio_dev_attr_out_voltage1_powerdown.dev_attr.attr,
+	&iio_dev_attr_out_voltage2_powerdown.dev_attr.attr,
+	&iio_dev_attr_out_voltage3_powerdown.dev_attr.attr,
+	&iio_dev_attr_out_voltage0_powerdown_mode.dev_attr.attr,
+	&iio_dev_attr_out_voltage1_powerdown_mode.dev_attr.attr,
+	&iio_dev_attr_out_voltage2_powerdown_mode.dev_attr.attr,
+	&iio_dev_attr_out_voltage3_powerdown_mode.dev_attr.attr,
+	&iio_const_attr_out_voltage_powerdown_mode_available.dev_attr.attr,
 	NULL,
 };
 
diff --git a/drivers/staging/iio/dac/dac.h b/drivers/staging/iio/dac/dac.h
index 1d82f35..0754d71 100644
--- a/drivers/staging/iio/dac/dac.h
+++ b/drivers/staging/iio/dac/dac.h
@@ -3,4 +3,4 @@
  */
 
 #define IIO_DEV_ATTR_OUT_RAW(_num, _store, _addr)				\
-	IIO_DEVICE_ATTR(out##_num##_raw, S_IWUSR, NULL, _store, _addr)
+	IIO_DEVICE_ATTR(out_voltage##_num##_raw, S_IWUSR, NULL, _store, _addr)
diff --git a/drivers/staging/iio/dac/max517.c b/drivers/staging/iio/dac/max517.c
index d54262f..fb780d0 100644
--- a/drivers/staging/iio/dac/max517.c
+++ b/drivers/staging/iio/dac/max517.c
@@ -120,8 +120,9 @@ static ssize_t max517_set_value_both(struct device *dev,
 {
 	return max517_set_value(dev, attr, buf, count, 3);
 }
-static IIO_DEVICE_ATTR_NAMED(out1and2_raw, out1&2_raw, S_IWUSR, NULL,
-		max517_set_value_both, -1);
+static IIO_DEVICE_ATTR_NAMED(out_voltage1and2_raw,
+			     out_voltage1&2_raw, S_IWUSR, NULL,
+			     max517_set_value_both, -1);
 
 static ssize_t max517_show_scale(struct device *dev,
 				struct device_attribute *attr,
@@ -141,7 +142,8 @@ static ssize_t max517_show_scale1(struct device *dev,
 {
 	return max517_show_scale(dev, attr, buf, 1);
 }
-static IIO_DEVICE_ATTR(out1_scale, S_IRUGO, max517_show_scale1, NULL, 0);
+static IIO_DEVICE_ATTR(out_voltage1_scale, S_IRUGO,
+		       max517_show_scale1, NULL, 0);
 
 static ssize_t max517_show_scale2(struct device *dev,
 				struct device_attribute *attr,
@@ -149,12 +151,13 @@ static ssize_t max517_show_scale2(struct device *dev,
 {
 	return max517_show_scale(dev, attr, buf, 2);
 }
-static IIO_DEVICE_ATTR(out2_scale, S_IRUGO, max517_show_scale2, NULL, 0);
+static IIO_DEVICE_ATTR(out_voltage2_scale, S_IRUGO,
+		       max517_show_scale2, NULL, 0);
 
 /* On MAX517 variant, we have one output */
 static struct attribute *max517_attributes[] = {
-	&iio_dev_attr_out1_raw.dev_attr.attr,
-	&iio_dev_attr_out1_scale.dev_attr.attr,
+	&iio_dev_attr_out_voltage1_raw.dev_attr.attr,
+	&iio_dev_attr_out_voltage1_scale.dev_attr.attr,
 	NULL
 };
 
@@ -164,11 +167,11 @@ static struct attribute_group max517_attribute_group = {
 
 /* On MAX518 and MAX519 variant, we have two outputs */
 static struct attribute *max518_attributes[] = {
-	&iio_dev_attr_out1_raw.dev_attr.attr,
-	&iio_dev_attr_out1_scale.dev_attr.attr,
-	&iio_dev_attr_out2_raw.dev_attr.attr,
-	&iio_dev_attr_out2_scale.dev_attr.attr,
-	&iio_dev_attr_out1and2_raw.dev_attr.attr,
+	&iio_dev_attr_out_voltage1_raw.dev_attr.attr,
+	&iio_dev_attr_out_voltage1_scale.dev_attr.attr,
+	&iio_dev_attr_out_voltage2_raw.dev_attr.attr,
+	&iio_dev_attr_out_voltage2_scale.dev_attr.attr,
+	&iio_dev_attr_out_voltage1and2_raw.dev_attr.attr,
 	NULL
 };
 
diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index 65399d1..6d1086b 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -308,12 +308,12 @@ static ssize_t ad5933_store_frequency(struct device *dev,
 	return ret ? ret : len;
 }
 
-static IIO_DEVICE_ATTR(out0_freq_start, S_IRUGO | S_IWUSR,
+static IIO_DEVICE_ATTR(out_voltage0_freq_start, S_IRUGO | S_IWUSR,
 			ad5933_show_frequency,
 			ad5933_store_frequency,
 			AD5933_REG_FREQ_START);
 
-static IIO_DEVICE_ATTR(out0_freq_increment, S_IRUGO | S_IWUSR,
+static IIO_DEVICE_ATTR(out_voltage0_freq_increment, S_IRUGO | S_IWUSR,
 			ad5933_show_frequency,
 			ad5933_store_frequency,
 			AD5933_REG_FREQ_INC);
@@ -431,32 +431,32 @@ static ssize_t ad5933_store(struct device *dev,
 	return ret ? ret : len;
 }
 
-static IIO_DEVICE_ATTR(out0_scale, S_IRUGO | S_IWUSR,
+static IIO_DEVICE_ATTR(out_voltage0_scale, S_IRUGO | S_IWUSR,
 			ad5933_show,
 			ad5933_store,
 			AD5933_OUT_RANGE);
 
-static IIO_DEVICE_ATTR(out0_scale_available, S_IRUGO,
+static IIO_DEVICE_ATTR(out_voltage0_scale_available, S_IRUGO,
 			ad5933_show,
 			NULL,
 			AD5933_OUT_RANGE_AVAIL);
 
-static IIO_DEVICE_ATTR(in0_scale, S_IRUGO | S_IWUSR,
+static IIO_DEVICE_ATTR(in_voltage0_scale, S_IRUGO | S_IWUSR,
 			ad5933_show,
 			ad5933_store,
 			AD5933_IN_PGA_GAIN);
 
-static IIO_DEVICE_ATTR(in0_scale_available, S_IRUGO,
+static IIO_DEVICE_ATTR(in_voltage0_scale_available, S_IRUGO,
 			ad5933_show,
 			NULL,
 			AD5933_IN_PGA_GAIN_AVAIL);
 
-static IIO_DEVICE_ATTR(out0_freq_points, S_IRUGO | S_IWUSR,
+static IIO_DEVICE_ATTR(out_voltage0_freq_points, S_IRUGO | S_IWUSR,
 			ad5933_show,
 			ad5933_store,
 			AD5933_FREQ_POINTS);
 
-static IIO_DEVICE_ATTR(out0_settling_cycles, S_IRUGO | S_IWUSR,
+static IIO_DEVICE_ATTR(out_voltage0_settling_cycles, S_IRUGO | S_IWUSR,
 			ad5933_show,
 			ad5933_store,
 			AD5933_OUT_SETTLING_CYCLES);
@@ -467,14 +467,14 @@ static IIO_DEVICE_ATTR(out0_settling_cycles, S_IRUGO | S_IWUSR,
  * don't create dedicated sysfs channel attributes for out0 and in0.
  */
 static struct attribute *ad5933_attributes[] = {
-	&iio_dev_attr_out0_scale.dev_attr.attr,
-	&iio_dev_attr_out0_scale_available.dev_attr.attr,
-	&iio_dev_attr_out0_freq_start.dev_attr.attr,
-	&iio_dev_attr_out0_freq_increment.dev_attr.attr,
-	&iio_dev_attr_out0_freq_points.dev_attr.attr,
-	&iio_dev_attr_out0_settling_cycles.dev_attr.attr,
-	&iio_dev_attr_in0_scale.dev_attr.attr,
-	&iio_dev_attr_in0_scale_available.dev_attr.attr,
+	&iio_dev_attr_out_voltage0_scale.dev_attr.attr,
+	&iio_dev_attr_out_voltage0_scale_available.dev_attr.attr,
+	&iio_dev_attr_out_voltage0_freq_start.dev_attr.attr,
+	&iio_dev_attr_out_voltage0_freq_increment.dev_attr.attr,
+	&iio_dev_attr_out_voltage0_freq_points.dev_attr.attr,
+	&iio_dev_attr_out_voltage0_settling_cycles.dev_attr.attr,
+	&iio_dev_attr_in_voltage0_scale.dev_attr.attr,
+	&iio_dev_attr_in_voltage0_scale_available.dev_attr.attr,
 	NULL
 };
 
diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
index 1bb7186..04c7ab0 100644
--- a/drivers/staging/iio/magnetometer/hmc5843.c
+++ b/drivers/staging/iio/magnetometer/hmc5843.c
@@ -445,7 +445,7 @@ exit:
 	return count;
 
 }
-static IIO_DEVICE_ATTR(magn_range,
+static IIO_DEVICE_ATTR(in_magn_range,
 			S_IWUSR | S_IRUGO,
 			show_range,
 			set_range,
@@ -490,7 +490,7 @@ static struct attribute *hmc5843_attributes[] = {
 	&iio_dev_attr_meas_conf.dev_attr.attr,
 	&iio_dev_attr_operating_mode.dev_attr.attr,
 	&iio_dev_attr_sampling_frequency.dev_attr.attr,
-	&iio_dev_attr_magn_range.dev_attr.attr,
+	&iio_dev_attr_in_magn_range.dev_attr.attr,
 	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
 	NULL
 };
diff --git a/drivers/staging/iio/meter/ade7753.c b/drivers/staging/iio/meter/ade7753.c
index 8cf7308..3d62bfd 100644
--- a/drivers/staging/iio/meter/ade7753.c
+++ b/drivers/staging/iio/meter/ade7753.c
@@ -454,8 +454,8 @@ out:
 }
 
 static IIO_DEV_ATTR_TEMP_RAW(ade7753_read_8bit);
-static IIO_CONST_ATTR(temp_offset, "-25 C");
-static IIO_CONST_ATTR(temp_scale, "0.67 C");
+static IIO_CONST_ATTR(in_temp_offset, "-25 C");
+static IIO_CONST_ATTR(in_temp_scale, "0.67 C");
 
 static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
 		ade7753_read_frequency,
@@ -466,9 +466,9 @@ static IIO_DEV_ATTR_RESET(ade7753_write_reset);
 static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("27900 14000 7000 3500");
 
 static struct attribute *ade7753_attributes[] = {
-	&iio_dev_attr_temp_raw.dev_attr.attr,
-	&iio_const_attr_temp_offset.dev_attr.attr,
-	&iio_const_attr_temp_scale.dev_attr.attr,
+	&iio_dev_attr_in_temp_raw.dev_attr.attr,
+	&iio_const_attr_in_temp_offset.dev_attr.attr,
+	&iio_const_attr_in_temp_scale.dev_attr.attr,
 	&iio_dev_attr_sampling_frequency.dev_attr.attr,
 	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
 	&iio_dev_attr_reset.dev_attr.attr,
diff --git a/drivers/staging/iio/meter/ade7754.c b/drivers/staging/iio/meter/ade7754.c
index 8adb2a9..cdb62a4 100644
--- a/drivers/staging/iio/meter/ade7754.c
+++ b/drivers/staging/iio/meter/ade7754.c
@@ -473,8 +473,8 @@ out:
 	return ret ? ret : len;
 }
 static IIO_DEV_ATTR_TEMP_RAW(ade7754_read_8bit);
-static IIO_CONST_ATTR(temp_offset, "129 C");
-static IIO_CONST_ATTR(temp_scale, "4 C");
+static IIO_CONST_ATTR(in_temp_offset, "129 C");
+static IIO_CONST_ATTR(in_temp_scale, "4 C");
 
 static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
 		ade7754_read_frequency,
@@ -485,9 +485,9 @@ static IIO_DEV_ATTR_RESET(ade7754_write_reset);
 static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("26000 13000 65000 33000");
 
 static struct attribute *ade7754_attributes[] = {
-	&iio_dev_attr_temp_raw.dev_attr.attr,
-	&iio_const_attr_temp_offset.dev_attr.attr,
-	&iio_const_attr_temp_scale.dev_attr.attr,
+	&iio_dev_attr_in_temp_raw.dev_attr.attr,
+	&iio_const_attr_in_temp_offset.dev_attr.attr,
+	&iio_const_attr_in_temp_scale.dev_attr.attr,
 	&iio_dev_attr_sampling_frequency.dev_attr.attr,
 	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
 	&iio_dev_attr_reset.dev_attr.attr,
diff --git a/drivers/staging/iio/meter/ade7758_core.c b/drivers/staging/iio/meter/ade7758_core.c
index 7cbf1cb..6507875 100644
--- a/drivers/staging/iio/meter/ade7758_core.c
+++ b/drivers/staging/iio/meter/ade7758_core.c
@@ -584,8 +584,8 @@ out:
 }
 
 static IIO_DEV_ATTR_TEMP_RAW(ade7758_read_8bit);
-static IIO_CONST_ATTR(temp_offset, "129 C");
-static IIO_CONST_ATTR(temp_scale, "4 C");
+static IIO_CONST_ATTR(in_temp_offset, "129 C");
+static IIO_CONST_ATTR(in_temp_scale, "4 C");
 
 static IIO_DEV_ATTR_AWATTHR(ade7758_read_16bit,
 		ADE7758_AWATTHR);
@@ -615,9 +615,9 @@ static IIO_DEV_ATTR_RESET(ade7758_write_reset);
 static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("26040 13020 6510 3255");
 
 static struct attribute *ade7758_attributes[] = {
-	&iio_dev_attr_temp_raw.dev_attr.attr,
-	&iio_const_attr_temp_offset.dev_attr.attr,
-	&iio_const_attr_temp_scale.dev_attr.attr,
+	&iio_dev_attr_in_temp_raw.dev_attr.attr,
+	&iio_const_attr_in_temp_offset.dev_attr.attr,
+	&iio_const_attr_in_temp_scale.dev_attr.attr,
 	&iio_dev_attr_sampling_frequency.dev_attr.attr,
 	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
 	&iio_dev_attr_reset.dev_attr.attr,
diff --git a/drivers/staging/iio/meter/ade7759.c b/drivers/staging/iio/meter/ade7759.c
index 8e44e46..69b1f8b 100644
--- a/drivers/staging/iio/meter/ade7759.c
+++ b/drivers/staging/iio/meter/ade7759.c
@@ -413,8 +413,8 @@ out:
 	return ret ? ret : len;
 }
 static IIO_DEV_ATTR_TEMP_RAW(ade7759_read_8bit);
-static IIO_CONST_ATTR(temp_offset, "70 C");
-static IIO_CONST_ATTR(temp_scale, "1 C");
+static IIO_CONST_ATTR(in_temp_offset, "70 C");
+static IIO_CONST_ATTR(in_temp_scale, "1 C");
 
 static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
 		ade7759_read_frequency,
@@ -425,9 +425,9 @@ static IIO_DEV_ATTR_RESET(ade7759_write_reset);
 static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("27900 14000 7000 3500");
 
 static struct attribute *ade7759_attributes[] = {
-	&iio_dev_attr_temp_raw.dev_attr.attr,
-	&iio_const_attr_temp_offset.dev_attr.attr,
-	&iio_const_attr_temp_scale.dev_attr.attr,
+	&iio_dev_attr_in_temp_raw.dev_attr.attr,
+	&iio_const_attr_in_temp_offset.dev_attr.attr,
+	&iio_const_attr_in_temp_scale.dev_attr.attr,
 	&iio_dev_attr_sampling_frequency.dev_attr.attr,
 	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
 	&iio_dev_attr_reset.dev_attr.attr,
diff --git a/drivers/staging/iio/sysfs.h b/drivers/staging/iio/sysfs.h
index 174f2c6..868952b 100644
--- a/drivers/staging/iio/sysfs.h
+++ b/drivers/staging/iio/sysfs.h
@@ -106,13 +106,13 @@ struct iio_const_attr {
 	IIO_CONST_ATTR(sampling_frequency_available, _string)
 
 #define IIO_DEV_ATTR_TEMP_RAW(_show)			\
-	IIO_DEVICE_ATTR(temp_raw, S_IRUGO, _show, NULL, 0)
+	IIO_DEVICE_ATTR(in_temp_raw, S_IRUGO, _show, NULL, 0)
 
 #define IIO_CONST_ATTR_TEMP_OFFSET(_string)		\
-	IIO_CONST_ATTR(temp_offset, _string)
+	IIO_CONST_ATTR(in_temp_offset, _string)
 
 #define IIO_CONST_ATTR_TEMP_SCALE(_string)		\
-	IIO_CONST_ATTR(temp_scale, _string)
+	IIO_CONST_ATTR(in_temp_scale, _string)
 
 enum iio_event_type {
 	IIO_EV_TYPE_THRESH,
-- 
1.7.3.4
