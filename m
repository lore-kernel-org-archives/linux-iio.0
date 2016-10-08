Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35435 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756584AbcJHQjg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 8 Oct 2016 12:39:36 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 17/18] staging:iio:accel:sca3000 kernel docify comments that were nearly kernel doc.
Date: Sat,  8 Oct 2016 17:39:17 +0100
Message-Id: <20161008163918.18758-18-jic23@kernel.org>
In-Reply-To: <20161008163918.18758-1-jic23@kernel.org>
References: <20161008163918.18758-1-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Basic tidy up of comments to bring them into a standard style.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/accel/sca3000.c | 106 ++++++++++++++++++++++++++----------
 1 file changed, 77 insertions(+), 29 deletions(-)

diff --git a/drivers/staging/iio/accel/sca3000.c b/drivers/staging/iio/accel/sca3000.c
index af1a4c1ec365..47df88ffe802 100644
--- a/drivers/staging/iio/accel/sca3000.c
+++ b/drivers/staging/iio/accel/sca3000.c
@@ -178,10 +178,20 @@ struct sca3000_state {
  * @scale:			scale * 10^-6
  * @temp_output:		some devices have temperature sensors.
  * @measurement_mode_freq:	normal mode sampling frequency
+ * @measurement_mode_3db_freq:	3db cutoff frequency of the low pass filter for
+ * the normal measurement mode.
  * @option_mode_1:		first optional mode. Not all models have one
  * @option_mode_1_freq:		option mode 1 sampling frequency
+ * @option_mode_1_3db_freq:	3db cutoff frequency of the low pass filter for
+ * the first option mode.
  * @option_mode_2:		second optional mode. Not all chips have one
  * @option_mode_2_freq:		option mode 2 sampling frequency
+ * @option_mode_2_3db_freq:	3db cutoff frequency of the low pass filter for
+ * the second option mode.
+ * @mod_det_mult_xz:		Bit wise multipliers to calculate the threshold
+ * for motion detection in the x and z axis.
+ * @mod_det_mult_y:		Bit wise multipliers to calculate the threshold
+ * for motion detection in the y axis.
  *
  * This structure is used to hold information about the functionality of a given
  * sca3000 variant.
@@ -292,7 +302,8 @@ static int sca3000_read_data_short(struct sca3000_state *st,
 }
 
 /**
- * sca3000_reg_lock_on() test if the ctrl register lock is on
+ * sca3000_reg_lock_on() - test if the ctrl register lock is on
+ * @st: Driver specific device instance data.
  *
  * Lock must be held.
  **/
@@ -308,12 +319,13 @@ static int sca3000_reg_lock_on(struct sca3000_state *st)
 }
 
 /**
- * __sca3000_unlock_reg_lock() unlock the control registers
+ * __sca3000_unlock_reg_lock() - unlock the control registers
+ * @st: Driver specific device instance data.
  *
  * Note the device does not appear to support doing this in a single transfer.
  * This should only ever be used as part of ctrl reg read.
  * Lock must be held before calling this
- **/
+ */
 static int __sca3000_unlock_reg_lock(struct sca3000_state *st)
 {
 	struct spi_transfer xfer[3] = {
@@ -342,6 +354,7 @@ static int __sca3000_unlock_reg_lock(struct sca3000_state *st)
 
 /**
  * sca3000_write_ctrl_reg() write to a lock protect ctrl register
+ * @st: Driver specific device instance data.
  * @sel: selects which registers we wish to write to
  * @val: the value to be written
  *
@@ -349,7 +362,7 @@ static int __sca3000_unlock_reg_lock(struct sca3000_state *st)
  * register and use a shared write address. This function allows writing of
  * these registers.
  * Lock must be held.
- **/
+ */
 static int sca3000_write_ctrl_reg(struct sca3000_state *st,
 				  u8 sel,
 				  uint8_t val)
@@ -379,9 +392,11 @@ error_ret:
 
 /**
  * sca3000_read_ctrl_reg() read from lock protected control register.
+ * @st: Driver specific device instance data.
+ * @ctrl_reg: Which ctrl register do we want to read.
  *
  * Lock must be held.
- **/
+ */
 static int sca3000_read_ctrl_reg(struct sca3000_state *st,
 				 u8 ctrl_reg)
 {
@@ -409,7 +424,10 @@ error_ret:
 
 /**
  * sca3000_show_rev() - sysfs interface to read the chip revision number
- **/
+ * @indio_dev: Device instance specific generic IIO data.
+ * Driver specific device instance data can be obtained via
+ * via iio_priv(indio_dev)
+ */
 static int sca3000_print_rev(struct iio_dev *indio_dev)
 {
 	int ret;
@@ -539,10 +557,13 @@ static u8 sca3000_addresses[3][3] = {
 };
 
 /**
- * __sca3000_get_base_freq() obtain mode specific base frequency
+ * __sca3000_get_base_freq() - obtain mode specific base frequency
+ * @st: Private driver specific device instance specific state.
+ * @info: chip type specific information.
+ * @base_freq: Base frequency for the current measurement mode.
  *
  * lock must be held
- **/
+ */
 static inline int __sca3000_get_base_freq(struct sca3000_state *st,
 					  const struct sca3000_chip_info *info,
 					  int *base_freq)
@@ -570,11 +591,13 @@ error_ret:
 }
 
 /**
- * read_raw handler for IIO_CHAN_INFO_SAMP_FREQ
+ * sca3000_read_raw_samp_freq() - read_raw handler for IIO_CHAN_INFO_SAMP_FREQ
+ * @st: Private driver specific device instance specific state.
+ * @val: The frequency read back.
  *
  * lock must be held
  **/
-static int read_raw_samp_freq(struct sca3000_state *st, int *val)
+static int sca3000_read_raw_samp_freq(struct sca3000_state *st, int *val)
 {
 	int ret;
 
@@ -602,11 +625,13 @@ static int read_raw_samp_freq(struct sca3000_state *st, int *val)
 }
 
 /**
- * write_raw handler for IIO_CHAN_INFO_SAMP_FREQ
+ * sca3000_write_raw_samp_freq() - write_raw handler for IIO_CHAN_INFO_SAMP_FREQ
+ * @st: Private driver specific device instance specific state.
+ * @val: The frequency desired.
  *
  * lock must be held
- **/
-static int write_raw_samp_freq(struct sca3000_state *st, int val)
+ */
+static int sca3000_write_raw_samp_freq(struct sca3000_state *st, int val)
 {
 	int ret, base_freq, ctrlval;
 
@@ -737,7 +762,7 @@ static int sca3000_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		mutex_lock(&st->lock);
-		ret = read_raw_samp_freq(st, val);
+		ret = sca3000_read_raw_samp_freq(st, val);
 		mutex_unlock(&st->lock);
 		return ret ? ret : IIO_VAL_INT;
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
@@ -762,7 +787,7 @@ static int sca3000_write_raw(struct iio_dev *indio_dev,
 		if (val2)
 			return -EINVAL;
 		mutex_lock(&st->lock);
-		ret = write_raw_samp_freq(st, val);
+		ret = sca3000_write_raw_samp_freq(st, val);
 		mutex_unlock(&st->lock);
 		return ret;
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
@@ -779,7 +804,10 @@ static int sca3000_write_raw(struct iio_dev *indio_dev,
 }
 
 /**
- * sca3000_read_av_freq() sysfs function to get available frequencies
+ * sca3000_read_av_freq() - sysfs function to get available frequencies
+ * @dev: Device structure for this device.
+ * @attr: Description of the attribute.
+ * @buf: Incoming string
  *
  * The later modes are only relevant to the ring buffer - and depend on current
  * mode. Note that data sheet gives rather wide tolerances for these so integer
@@ -874,8 +902,18 @@ static int sca3000_read_event_value(struct iio_dev *indio_dev,
 }
 
 /**
- * sca3000_write_value() control of threshold and period
- **/
+ * sca3000_write_value() - control of threshold and period
+ * @indio_dev: Device instance specific IIO information.
+ * @chan: Description of the channel for which the event is being
+ * configured.
+ * @type: The type of event being configured, here magnitude rising
+ * as everything else is read only.
+ * @dir: Direction of the event (here rising)
+ * @info: What information about the event are we configuring.
+ * Here the threshold only.
+ * @val: Integer part of the value being written..
+ * @val2: Non integer part of the value being written. Here always 0.
+ */
 static int sca3000_write_event_value(struct iio_dev *indio_dev,
 				     const struct iio_chan_spec *chan,
 				     enum iio_event_type type,
@@ -950,11 +988,10 @@ static int sca3000_read_data(struct sca3000_state *st,
 }
 
 /**
- * sca3000_ring_int_process() ring specific interrupt handling.
- *
- * This is only split from the main interrupt handler so as to
- * reduce the amount of code if the ring buffer is not enabled.
- **/
+ * sca3000_ring_int_process() - ring specific interrupt handling.
+ * @val: Value of the interrupt status register.
+ * @indio_dev: Device instance specific IIO device structure.
+ */
 static void sca3000_ring_int_process(u8 val, struct iio_dev *indio_dev)
 {
 	struct sca3000_state *st = iio_priv(indio_dev);
@@ -993,6 +1030,8 @@ error_ret:
 
 /**
  * sca3000_event_handler() - handling ring and non ring events
+ * @irq: The irq being handled.
+ * @private: struct iio_device pointer for the device.
  *
  * Ring related interrupt handler. Depending on event, push to
  * the ring buffer event chrdev or the event one.
@@ -1000,7 +1039,7 @@ error_ret:
  * This function is complicated by the fact that the devices can signify ring
  * and non ring events via the same interrupt line and they can only
  * be distinguished via a read of the relevant status register.
- **/
+ */
 static irqreturn_t sca3000_event_handler(int irq, void *private)
 {
 	struct iio_dev *indio_dev = private;
@@ -1188,7 +1227,13 @@ static int sca3000_motion_detect_set_state(struct iio_dev *indio_dev, int axis,
 }
 
 /**
- * sca3000_write_event_config() simple on off control for motion detector
+ * sca3000_write_event_config() - simple on off control for motion detector
+ * @indio_dev: IIO device instance specific structure. Data specific to this
+ * particular driver may be accessed via iio_priv(indio_dev).
+ * @chan: Description of the channel whose event we are configuring.
+ * @type: The type of event.
+ * @dir: The direction of the event.
+ * @state: Desired state of event being configured.
  *
  * This is a per axis control, but enabling any will result in the
  * motion detector unit being enabled.
@@ -1272,12 +1317,14 @@ error_ret:
 }
 
 /**
- * sca3000_hw_ring_preenable() hw ring buffer preenable function
+ * sca3000_hw_ring_preenable() - hw ring buffer preenable function
+ * @indio_dev: structure representing the IIO device. Device instance
+ * specific state can be accessed via iio_priv(indio_dev).
  *
  * Very simple enable function as the chip will allows normal reads
  * during ring buffer operation so as long as it is indeed running
  * before we notify the core, the precise ordering does not matter.
- **/
+ */
 static int sca3000_hw_ring_preenable(struct iio_dev *indio_dev)
 {
 	int ret;
@@ -1334,12 +1381,13 @@ static const struct iio_buffer_setup_ops sca3000_ring_setup_ops = {
 };
 
 /**
- * sca3000_clean_setup() get the device into a predictable state
+ * sca3000_clean_setup() - get the device into a predictable state
+ * @st: Device instance specific private data structure
  *
  * Devices use flash memory to store many of the register values
  * and hence can come up in somewhat unpredictable states.
  * Hence reset everything on driver load.
- **/
+ */
 static int sca3000_clean_setup(struct sca3000_state *st)
 {
 	int ret;
-- 
2.10.0

