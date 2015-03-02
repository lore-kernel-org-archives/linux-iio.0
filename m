Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:22511 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754008AbbCBTD3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 2 Mar 2015 14:03:29 -0500
From: Octavian Purdila <octavian.purdila@intel.com>
To: linux-iio@vger.kernel.org
Cc: Octavian Purdila <octavian.purdila@intel.com>
Subject: [PATCH] iio: fix drivers that check buffer->scan_mask
Date: Mon,  2 Mar 2015 21:03:05 +0200
Message-Id: <1425322985-24190-1-git-send-email-octavian.purdila@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

If the in-kernel push interface is used we may have a different masks
on the device buffer and the kernel buffer and in this case the device
should generate data for the reunion of the buffers, which is
available at indio_dev->active_scan_mask.

Compiled tested only except for bmc150-accel which was tested at
runtime with the hardware.

Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
---
 drivers/iio/accel/bma180.c       | 2 +-
 drivers/iio/accel/bmc150-accel.c | 2 +-
 drivers/iio/accel/kxcjk-1013.c   | 2 +-
 drivers/iio/adc/at91_adc.c       | 5 ++---
 drivers/iio/adc/ti_am335x_adc.c  | 3 +--
 drivers/iio/gyro/bmg160.c        | 2 +-
 drivers/iio/imu/kmx61.c          | 2 +-
 drivers/iio/proximity/sx9500.c   | 2 +-
 8 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
index 1096da3..75c6d21 100644
--- a/drivers/iio/accel/bma180.c
+++ b/drivers/iio/accel/bma180.c
@@ -659,7 +659,7 @@ static irqreturn_t bma180_trigger_handler(int irq, void *p)
 
 	mutex_lock(&data->mutex);
 
-	for_each_set_bit(bit, indio_dev->buffer->scan_mask,
+	for_each_set_bit(bit, indio_dev->active_scan_mask,
 			 indio_dev->masklength) {
 		ret = bma180_get_data_reg(data, bit);
 		if (ret < 0) {
diff --git a/drivers/iio/accel/bmc150-accel.c b/drivers/iio/accel/bmc150-accel.c
index 46ac965..8004ce3 100644
--- a/drivers/iio/accel/bmc150-accel.c
+++ b/drivers/iio/accel/bmc150-accel.c
@@ -929,7 +929,7 @@ static irqreturn_t bmc150_accel_trigger_handler(int irq, void *p)
 	int bit, ret, i = 0;
 
 	mutex_lock(&data->mutex);
-	for_each_set_bit(bit, indio_dev->buffer->scan_mask,
+	for_each_set_bit(bit, indio_dev->active_scan_mask,
 			 indio_dev->masklength) {
 		ret = i2c_smbus_read_word_data(data->client,
 					       BMC150_ACCEL_AXIS_TO_REG(bit));
diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index a98b5d2..51da369 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -956,7 +956,7 @@ static irqreturn_t kxcjk1013_trigger_handler(int irq, void *p)
 
 	mutex_lock(&data->mutex);
 
-	for_each_set_bit(bit, indio_dev->buffer->scan_mask,
+	for_each_set_bit(bit, indio_dev->active_scan_mask,
 			 indio_dev->masklength) {
 		ret = kxcjk1013_get_acc_reg(data, bit);
 		if (ret < 0) {
diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index ff61ae5..8a0eb4a 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -544,7 +544,6 @@ static int at91_adc_configure_trigger(struct iio_trigger *trig, bool state)
 {
 	struct iio_dev *idev = iio_trigger_get_drvdata(trig);
 	struct at91_adc_state *st = iio_priv(idev);
-	struct iio_buffer *buffer = idev->buffer;
 	struct at91_adc_reg_desc *reg = st->registers;
 	u32 status = at91_adc_readl(st, reg->trigger_register);
 	int value;
@@ -564,7 +563,7 @@ static int at91_adc_configure_trigger(struct iio_trigger *trig, bool state)
 		at91_adc_writel(st, reg->trigger_register,
 				status | value);
 
-		for_each_set_bit(bit, buffer->scan_mask,
+		for_each_set_bit(bit, idev->active_scan_mask,
 				 st->num_channels) {
 			struct iio_chan_spec const *chan = idev->channels + bit;
 			at91_adc_writel(st, AT91_ADC_CHER,
@@ -579,7 +578,7 @@ static int at91_adc_configure_trigger(struct iio_trigger *trig, bool state)
 		at91_adc_writel(st, reg->trigger_register,
 				status & ~value);
 
-		for_each_set_bit(bit, buffer->scan_mask,
+		for_each_set_bit(bit, idev->active_scan_mask,
 				 st->num_channels) {
 			struct iio_chan_spec const *chan = idev->channels + bit;
 			at91_adc_writel(st, AT91_ADC_CHDR,
diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index 5eea299..29de6c8 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -189,12 +189,11 @@ static int tiadc_buffer_preenable(struct iio_dev *indio_dev)
 static int tiadc_buffer_postenable(struct iio_dev *indio_dev)
 {
 	struct tiadc_device *adc_dev = iio_priv(indio_dev);
-	struct iio_buffer *buffer = indio_dev->buffer;
 	unsigned int enb = 0;
 	u8 bit;
 
 	tiadc_step_config(indio_dev);
-	for_each_set_bit(bit, buffer->scan_mask, adc_dev->channels)
+	for_each_set_bit(bit, indio_dev->active_scan_mask, adc_dev->channels)
 		enb |= (get_adc_step_bit(adc_dev, bit) << 1);
 	adc_dev->buffer_en_ch_steps = enb;
 
diff --git a/drivers/iio/gyro/bmg160.c b/drivers/iio/gyro/bmg160.c
index 56d68e1..4415f55 100644
--- a/drivers/iio/gyro/bmg160.c
+++ b/drivers/iio/gyro/bmg160.c
@@ -822,7 +822,7 @@ static irqreturn_t bmg160_trigger_handler(int irq, void *p)
 	int bit, ret, i = 0;
 
 	mutex_lock(&data->mutex);
-	for_each_set_bit(bit, indio_dev->buffer->scan_mask,
+	for_each_set_bit(bit, indio_dev->active_scan_mask,
 			 indio_dev->masklength) {
 		ret = i2c_smbus_read_word_data(data->client,
 					       BMG160_AXIS_TO_REG(bit));
diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
index 75ab701..462a010 100644
--- a/drivers/iio/imu/kmx61.c
+++ b/drivers/iio/imu/kmx61.c
@@ -1215,7 +1215,7 @@ static irqreturn_t kmx61_trigger_handler(int irq, void *p)
 		base = KMX61_MAG_XOUT_L;
 
 	mutex_lock(&data->lock);
-	for_each_set_bit(bit, indio_dev->buffer->scan_mask,
+	for_each_set_bit(bit, indio_dev->active_scan_mask,
 			 indio_dev->masklength) {
 		ret = kmx61_read_measurement(data, base, bit);
 		if (ret < 0) {
diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
index 0b4d794..fa40f6d 100644
--- a/drivers/iio/proximity/sx9500.c
+++ b/drivers/iio/proximity/sx9500.c
@@ -494,7 +494,7 @@ static irqreturn_t sx9500_trigger_handler(int irq, void *private)
 
 	mutex_lock(&data->mutex);
 
-	for_each_set_bit(bit, indio_dev->buffer->scan_mask,
+	for_each_set_bit(bit, indio_dev->active_scan_mask,
 			 indio_dev->masklength) {
 		ret = sx9500_read_proximity(data, &indio_dev->channels[bit],
 					    &val);
-- 
1.9.1

