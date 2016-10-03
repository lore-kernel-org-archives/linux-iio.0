Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58389 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753350AbcJCT1N (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Oct 2016 15:27:13 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 09/18] staging:iio:accel:sca3000 Clean up register defines.
Date: Mon,  3 Oct 2016 20:26:53 +0100
Message-Id: <20161003192702.24361-10-jic23@kernel.org>
In-Reply-To: <20161003192702.24361-1-jic23@kernel.org>
References: <20161003192702.24361-1-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Introduce some more masks and generally drive towards consistent naming.
Note the small indents used to indicate parts of registers + parts of
multiplexed registers.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/accel/sca3000.c | 318 ++++++++++++++++++------------------
 1 file changed, 160 insertions(+), 158 deletions(-)

diff --git a/drivers/staging/iio/accel/sca3000.c b/drivers/staging/iio/accel/sca3000.c
index 8337d5f05c20..cd08330e79b8 100644
--- a/drivers/staging/iio/accel/sca3000.c
+++ b/drivers/staging/iio/accel/sca3000.c
@@ -28,110 +28,110 @@
 #define SCA3000_WRITE_REG(a) (((a) << 2) | 0x02)
 #define SCA3000_READ_REG(a) ((a) << 2)
 
-#define SCA3000_REG_ADDR_REVID			0x00
-#define SCA3000_REVID_MAJOR_MASK		0xf0
-#define SCA3000_REVID_MINOR_MASK		0x0f
+#define SCA3000_REG_REVID_ADDR				0x00
+#define   SCA3000_REG_REVID_MAJOR_MASK			GENMASK(8, 4)
+#define   SCA3000_REG_REVID_MINOR_MASK			GENMASK(3, 0)
 
-#define SCA3000_REG_ADDR_STATUS			0x02
-#define SCA3000_LOCKED				0x20
-#define SCA3000_EEPROM_CS_ERROR			0x02
-#define SCA3000_SPI_FRAME_ERROR			0x01
+#define SCA3000_REG_STATUS_ADDR				0x02
+#define   SCA3000_LOCKED				BIT(5)
+#define   SCA3000_EEPROM_CS_ERROR			BIT(1)
+#define   SCA3000_SPI_FRAME_ERROR			BIT(0)
 
 /* All reads done using register decrement so no need to directly access LSBs */
-#define SCA3000_REG_ADDR_X_MSB			0x05
-#define SCA3000_REG_ADDR_Y_MSB			0x07
-#define SCA3000_REG_ADDR_Z_MSB			0x09
+#define SCA3000_REG_X_MSB_ADDR				0x05
+#define SCA3000_REG_Y_MSB_ADDR				0x07
+#define SCA3000_REG_Z_MSB_ADDR				0x09
 
-#define SCA3000_REG_ADDR_RING_OUT		0x0f
+#define SCA3000_REG_RING_OUT_ADDR			0x0f
 
 /* Temp read untested - the e05 doesn't have the sensor */
-#define SCA3000_REG_ADDR_TEMP_MSB		0x13
+#define SCA3000_REG_TEMP_MSB_ADDR			0x13
 
-#define SCA3000_REG_ADDR_MODE			0x14
-#define SCA3000_MODE_PROT_MASK			0x28
-
-#define SCA3000_RING_BUF_ENABLE			0x80
-#define SCA3000_RING_BUF_8BIT			0x40
+#define SCA3000_REG_MODE_ADDR				0x14
+#define SCA3000_MODE_PROT_MASK				0x28
+#define   SCA3000_REG_MODE_RING_BUF_ENABLE		BIT(7)
+#define   SCA3000_REG_MODE_RING_BUF_8BIT		BIT(6)
 /*
  * Free fall detection triggers an interrupt if the acceleration
  * is below a threshold for equivalent of 25cm drop
  */
-#define SCA3000_FREE_FALL_DETECT		0x10
-#define SCA3000_MEAS_MODE_NORMAL		0x00
-#define SCA3000_MEAS_MODE_OP_1			0x01
-#define SCA3000_MEAS_MODE_OP_2			0x02
+#define   SCA3000_REG_MODE_FREE_FALL_DETECT		BIT(4)
+#define   SCA3000_REG_MODE_MEAS_MODE_NORMAL		0x00
+#define   SCA3000_REG_MODE_MEAS_MODE_OP_1		0x01
+#define   SCA3000_REG_MODE_MEAS_MODE_OP_2		0x02
 
 /*
  * In motion detection mode the accelerations are band pass filtered
  * (approx 1 - 25Hz) and then a programmable threshold used to trigger
  * and interrupt.
  */
-#define SCA3000_MEAS_MODE_MOT_DET		0x03
-
-#define SCA3000_REG_ADDR_BUF_COUNT		0x15
+#define   SCA3000_REG_MODE_MEAS_MODE_MOT_DET		0x03
+#define   SCA3000_REG_MODE_MODE_MASK			0x03
 
-#define SCA3000_REG_ADDR_INT_STATUS		0x16
+#define SCA3000_REG_BUF_COUNT_ADDR			0x15
 
-#define SCA3000_INT_STATUS_THREE_QUARTERS	0x80
-#define SCA3000_INT_STATUS_HALF			0x40
+#define SCA3000_REG_INT_STATUS_ADDR			0x16
+#define   SCA3000_REG_INT_STATUS_THREE_QUARTERS		BIT(7)
+#define   SCA3000_REG_INT_STATUS_HALF			BIT(6)
 
-#define SCA3000_INT_STATUS_FREE_FALL		0x08
-#define SCA3000_INT_STATUS_Y_TRIGGER		0x04
-#define SCA3000_INT_STATUS_X_TRIGGER		0x02
-#define SCA3000_INT_STATUS_Z_TRIGGER		0x01
+#define SCA3000_INT_STATUS_FREE_FALL			BIT(3)
+#define SCA3000_INT_STATUS_Y_TRIGGER			BIT(2)
+#define SCA3000_INT_STATUS_X_TRIGGER			BIT(1)
+#define SCA3000_INT_STATUS_Z_TRIGGER			BIT(0)
 
 /* Used to allow access to multiplexed registers */
-#define SCA3000_REG_ADDR_CTRL_SEL		0x18
+#define SCA3000_REG_CTRL_SEL_ADDR			0x18
 /* Only available for SCA3000-D03 and SCA3000-D01 */
-#define SCA3000_REG_CTRL_SEL_I2C_DISABLE	0x01
-#define SCA3000_REG_CTRL_SEL_MD_CTRL		0x02
-#define SCA3000_REG_CTRL_SEL_MD_Y_TH		0x03
-#define SCA3000_REG_CTRL_SEL_MD_X_TH		0x04
-#define SCA3000_REG_CTRL_SEL_MD_Z_TH		0x05
+#define   SCA3000_REG_CTRL_SEL_I2C_DISABLE		0x01
+#define   SCA3000_REG_CTRL_SEL_MD_CTRL			0x02
+#define   SCA3000_REG_CTRL_SEL_MD_Y_TH			0x03
+#define   SCA3000_REG_CTRL_SEL_MD_X_TH			0x04
+#define   SCA3000_REG_CTRL_SEL_MD_Z_TH			0x05
 /*
  * BE VERY CAREFUL WITH THIS, IF 3 BITS ARE NOT SET the device
  * will not function
  */
-#define SCA3000_REG_CTRL_SEL_OUT_CTRL		0x0B
-#define SCA3000_OUT_CTRL_PROT_MASK		0xE0
-#define SCA3000_OUT_CTRL_BUF_X_EN		0x10
-#define SCA3000_OUT_CTRL_BUF_Y_EN		0x08
-#define SCA3000_OUT_CTRL_BUF_Z_EN		0x04
-#define SCA3000_OUT_CTRL_BUF_DIV_MASK		0x03
-#define SCA3000_OUT_CTRL_BUF_DIV_4		0x02
-#define SCA3000_OUT_CTRL_BUF_DIV_2		0x01
+#define   SCA3000_REG_CTRL_SEL_OUT_CTRL			0x0B
+
+#define     SCA3000_REG_OUT_CTRL_PROT_MASK		0xE0
+#define     SCA3000_REG_OUT_CTRL_BUF_X_EN		0x10
+#define     SCA3000_REG_OUT_CTRL_BUF_Y_EN		0x08
+#define     SCA3000_REG_OUT_CTRL_BUF_Z_EN		0x04
+#define     SCA3000_REG_OUT_CTRL_BUF_DIV_MASK		0x03
+#define     SCA3000_REG_OUT_CTRL_BUF_DIV_4		0x02
+#define     SCA3000_REG_OUT_CTRL_BUF_DIV_2		0x01
 
 /*
  * Control which motion detector interrupts are on.
  * For now only OR combinations are supported.
  */
-#define SCA3000_MD_CTRL_PROT_MASK		0xC0
-#define SCA3000_MD_CTRL_OR_Y			0x01
-#define SCA3000_MD_CTRL_OR_X			0x02
-#define SCA3000_MD_CTRL_OR_Z			0x04
+#define SCA3000_MD_CTRL_PROT_MASK			0xC0
+#define SCA3000_MD_CTRL_OR_Y				BIT(0)
+#define SCA3000_MD_CTRL_OR_X				BIT(1)
+#define SCA3000_MD_CTRL_OR_Z				BIT(2)
 /* Currently unsupported */
-#define SCA3000_MD_CTRL_AND_Y			0x08
-#define SCA3000_MD_CTRL_AND_X			0x10
-#define SAC3000_MD_CTRL_AND_Z			0x20
+#define SCA3000_MD_CTRL_AND_Y				BIT(3)
+#define SCA3000_MD_CTRL_AND_X				BIT(4)
+#define SAC3000_MD_CTRL_AND_Z				BIT(5)
 
 /*
  * Some control registers of complex access methods requiring this register to
  * be used to remove a lock.
  */
-#define SCA3000_REG_ADDR_UNLOCK			0x1e
+#define SCA3000_REG_UNLOCK_ADDR				0x1e
 
-#define SCA3000_REG_ADDR_INT_MASK		0x21
-#define SCA3000_INT_MASK_PROT_MASK		0x1C
+#define SCA3000_REG_INT_MASK_ADDR			0x21
+#define   SCA3000_REG_INT_MASK_PROT_MASK		0x1C
 
-#define SCA3000_INT_MASK_RING_THREE_QUARTER	0x80
-#define SCA3000_INT_MASK_RING_HALF		0x40
+#define   SCA3000_REG_INT_MASK_RING_THREE_QUARTER	BIT(7)
+#define   SCA3000_REG_INT_MASK_RING_HALF		BIT(6)
 
-#define SCA3000_INT_MASK_ALL_INTS		0x02
-#define SCA3000_INT_MASK_ACTIVE_HIGH		0x01
-#define SCA3000_INT_MASK_ACTIVE_LOW		0x00
+#define SCA3000_REG_INT_MASK_ALL_INTS			0x02
+#define SCA3000_REG_INT_MASK_ACTIVE_HIGH		0x01
+#define SCA3000_REG_INT_MASK_ACTIVE_LOW			0x00
 
 /* Values of multiplexed registers (write to ctrl_data after select) */
-#define SCA3000_REG_ADDR_CTRL_DATA		0x22
+#define SCA3000_REG_CTRL_DATA_ADDR			0x22
 
 /*
  * Measurement modes available on some sca3000 series chips. Code assumes others
@@ -145,9 +145,9 @@
  *
  * Wide - Widen low-pass filtering of signal channel to increase bandwidth
  */
-#define SCA3000_OP_MODE_BYPASS			0x01
-#define SCA3000_OP_MODE_NARROW			0x02
-#define SCA3000_OP_MODE_WIDE			0x04
+#define SCA3000_OP_MODE_BYPASS				0x01
+#define SCA3000_OP_MODE_NARROW				0x02
+#define SCA3000_OP_MODE_WIDE				0x04
 #define SCA3000_MAX_TX 6
 #define SCA3000_MAX_RX 2
 
@@ -287,7 +287,7 @@ static int sca3000_reg_lock_on(struct sca3000_state *st)
 {
 	int ret;
 
-	ret = sca3000_read_data_short(st, SCA3000_REG_ADDR_STATUS, 1);
+	ret = sca3000_read_data_short(st, SCA3000_REG_STATUS_ADDR, 1);
 	if (ret < 0)
 		return ret;
 
@@ -317,11 +317,11 @@ static int __sca3000_unlock_reg_lock(struct sca3000_state *st)
 			.tx_buf = st->tx + 4,
 		},
 	};
-	st->tx[0] = SCA3000_WRITE_REG(SCA3000_REG_ADDR_UNLOCK);
+	st->tx[0] = SCA3000_WRITE_REG(SCA3000_REG_UNLOCK_ADDR);
 	st->tx[1] = 0x00;
-	st->tx[2] = SCA3000_WRITE_REG(SCA3000_REG_ADDR_UNLOCK);
+	st->tx[2] = SCA3000_WRITE_REG(SCA3000_REG_UNLOCK_ADDR);
 	st->tx[3] = 0x50;
-	st->tx[4] = SCA3000_WRITE_REG(SCA3000_REG_ADDR_UNLOCK);
+	st->tx[4] = SCA3000_WRITE_REG(SCA3000_REG_UNLOCK_ADDR);
 	st->tx[5] = 0xA0;
 
 	return spi_sync_transfer(st->us, xfer, ARRAY_SIZE(xfer));
@@ -353,12 +353,12 @@ static int sca3000_write_ctrl_reg(struct sca3000_state *st,
 	}
 
 	/* Set the control select register */
-	ret = sca3000_write_reg(st, SCA3000_REG_ADDR_CTRL_SEL, sel);
+	ret = sca3000_write_reg(st, SCA3000_REG_CTRL_SEL_ADDR, sel);
 	if (ret)
 		goto error_ret;
 
 	/* Write the actual value into the register */
-	ret = sca3000_write_reg(st, SCA3000_REG_ADDR_CTRL_DATA, val);
+	ret = sca3000_write_reg(st, SCA3000_REG_CTRL_DATA_ADDR, val);
 
 error_ret:
 	return ret;
@@ -383,10 +383,10 @@ static int sca3000_read_ctrl_reg(struct sca3000_state *st,
 			goto error_ret;
 	}
 	/* Set the control select register */
-	ret = sca3000_write_reg(st, SCA3000_REG_ADDR_CTRL_SEL, ctrl_reg);
+	ret = sca3000_write_reg(st, SCA3000_REG_CTRL_SEL_ADDR, ctrl_reg);
 	if (ret)
 		goto error_ret;
-	ret = sca3000_read_data_short(st, SCA3000_REG_ADDR_CTRL_DATA, 1);
+	ret = sca3000_read_data_short(st, SCA3000_REG_CTRL_DATA_ADDR, 1);
 	if (ret)
 		goto error_ret;
 	return st->rx[0];
@@ -406,13 +406,13 @@ static ssize_t sca3000_show_rev(struct device *dev,
 	struct sca3000_state *st = iio_priv(indio_dev);
 
 	mutex_lock(&st->lock);
-	ret = sca3000_read_data_short(st, SCA3000_REG_ADDR_REVID, 1);
+	ret = sca3000_read_data_short(st, SCA3000_REG_REVID_ADDR, 1);
 	if (ret < 0)
 		goto error_ret;
 	len += sprintf(buf + len,
-		       "major=%d, minor=%d\n",
-		       st->rx[0] & SCA3000_REVID_MAJOR_MASK,
-		       st->rx[0] & SCA3000_REVID_MINOR_MASK);
+		       "major=%lu, minor=%lu\n",
+		       st->rx[0] & SCA3000_REG_REVID_MAJOR_MASK,
+		       st->rx[0] & SCA3000_REG_REVID_MINOR_MASK);
 error_ret:
 	mutex_unlock(&st->lock);
 
@@ -467,19 +467,19 @@ sca3000_show_measurement_mode(struct device *dev,
 	int len = 0, ret;
 
 	mutex_lock(&st->lock);
-	ret = sca3000_read_data_short(st, SCA3000_REG_ADDR_MODE, 1);
+	ret = sca3000_read_data_short(st, SCA3000_REG_MODE_ADDR, 1);
 	if (ret)
 		goto error_ret;
 	/* mask bottom 2 bits - only ones that are relevant */
-	st->rx[0] &= 0x03;
+	st->rx[0] &= SCA3000_REG_MODE_MODE_MASK;
 	switch (st->rx[0]) {
-	case SCA3000_MEAS_MODE_NORMAL:
+	case SCA3000_REG_MODE_MEAS_MODE_NORMAL:
 		len += sprintf(buf + len, "0 - normal mode\n");
 		break;
-	case SCA3000_MEAS_MODE_MOT_DET:
+	case SCA3000_REG_MODE_MEAS_MODE_MOT_DET:
 		len += sprintf(buf + len, "3 - motion detection\n");
 		break;
-	case SCA3000_MEAS_MODE_OP_1:
+	case SCA3000_REG_MODE_MEAS_MODE_OP_1:
 		switch (st->info->option_mode_1) {
 		case SCA3000_OP_MODE_NARROW:
 			len += sprintf(buf + len, "1 - narrow mode\n");
@@ -489,7 +489,7 @@ sca3000_show_measurement_mode(struct device *dev,
 			break;
 		}
 		break;
-	case SCA3000_MEAS_MODE_OP_2:
+	case SCA3000_REG_MODE_MEAS_MODE_OP_2:
 		switch (st->info->option_mode_2) {
 		case SCA3000_OP_MODE_WIDE:
 			len += sprintf(buf + len, "2 - wide mode\n");
@@ -516,7 +516,6 @@ sca3000_store_measurement_mode(struct device *dev,
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct sca3000_state *st = iio_priv(indio_dev);
 	int ret;
-	u8 mask = 0x03;
 	u8 val;
 
 	mutex_lock(&st->lock);
@@ -527,12 +526,12 @@ sca3000_store_measurement_mode(struct device *dev,
 		ret = -EINVAL;
 		goto error_ret;
 	}
-	ret = sca3000_read_data_short(st, SCA3000_REG_ADDR_MODE, 1);
+	ret = sca3000_read_data_short(st, SCA3000_REG_MODE_ADDR, 1);
 	if (ret)
 		goto error_ret;
-	st->rx[0] &= ~mask;
-	st->rx[0] |= (val & mask);
-	ret = sca3000_write_reg(st, SCA3000_REG_ADDR_MODE, st->rx[0]);
+	st->rx[0] &= ~SCA3000_REG_MODE_MODE_MASK;
+	st->rx[0] |= (val & SCA3000_REG_MODE_MODE_MASK);
+	ret = sca3000_write_reg(st, SCA3000_REG_MODE_ADDR, st->rx[0]);
 	if (ret)
 		goto error_ret;
 	mutex_unlock(&st->lock);
@@ -637,11 +636,11 @@ static const struct iio_chan_spec sca3000_channels_with_temp[] = {
 };
 
 static u8 sca3000_addresses[3][3] = {
-	[0] = {SCA3000_REG_ADDR_X_MSB, SCA3000_REG_CTRL_SEL_MD_X_TH,
+	[0] = {SCA3000_REG_X_MSB_ADDR, SCA3000_REG_CTRL_SEL_MD_X_TH,
 	       SCA3000_MD_CTRL_OR_X},
-	[1] = {SCA3000_REG_ADDR_Y_MSB, SCA3000_REG_CTRL_SEL_MD_Y_TH,
+	[1] = {SCA3000_REG_Y_MSB_ADDR, SCA3000_REG_CTRL_SEL_MD_Y_TH,
 	       SCA3000_MD_CTRL_OR_Y},
-	[2] = {SCA3000_REG_ADDR_Z_MSB, SCA3000_REG_CTRL_SEL_MD_Z_TH,
+	[2] = {SCA3000_REG_Z_MSB_ADDR, SCA3000_REG_CTRL_SEL_MD_Z_TH,
 	       SCA3000_MD_CTRL_OR_Z},
 };
 
@@ -656,17 +655,17 @@ static inline int __sca3000_get_base_freq(struct sca3000_state *st,
 {
 	int ret;
 
-	ret = sca3000_read_data_short(st, SCA3000_REG_ADDR_MODE, 1);
+	ret = sca3000_read_data_short(st, SCA3000_REG_MODE_ADDR, 1);
 	if (ret)
 		goto error_ret;
-	switch (0x03 & st->rx[0]) {
-	case SCA3000_MEAS_MODE_NORMAL:
+	switch (SCA3000_REG_MODE_MODE_MASK & st->rx[0]) {
+	case SCA3000_REG_MODE_MEAS_MODE_NORMAL:
 		*base_freq = info->measurement_mode_freq;
 		break;
-	case SCA3000_MEAS_MODE_OP_1:
+	case SCA3000_REG_MODE_MEAS_MODE_OP_1:
 		*base_freq = info->option_mode_1_freq;
 		break;
-	case SCA3000_MEAS_MODE_OP_2:
+	case SCA3000_REG_MODE_MEAS_MODE_OP_2:
 		*base_freq = info->option_mode_2_freq;
 		break;
 	default:
@@ -694,12 +693,12 @@ static int read_raw_samp_freq(struct sca3000_state *st, int *val)
 		return ret;
 
 	if (*val > 0) {
-		ret &= SCA3000_OUT_CTRL_BUF_DIV_MASK;
+		ret &= SCA3000_REG_OUT_CTRL_BUF_DIV_MASK;
 		switch (ret) {
-		case SCA3000_OUT_CTRL_BUF_DIV_2:
+		case SCA3000_REG_OUT_CTRL_BUF_DIV_2:
 			*val /= 2;
 			break;
-		case SCA3000_OUT_CTRL_BUF_DIV_4:
+		case SCA3000_REG_OUT_CTRL_BUF_DIV_4:
 			*val /= 4;
 			break;
 		}
@@ -725,12 +724,12 @@ static int write_raw_samp_freq(struct sca3000_state *st, int val)
 	if (ret < 0)
 		return ret;
 
-	ctrlval = ret & ~SCA3000_OUT_CTRL_BUF_DIV_MASK;
+	ctrlval = ret & ~SCA3000_REG_OUT_CTRL_BUF_DIV_MASK;
 
 	if (val == base_freq / 2)
-		ctrlval |= SCA3000_OUT_CTRL_BUF_DIV_2;
+		ctrlval |= SCA3000_REG_OUT_CTRL_BUF_DIV_2;
 	if (val == base_freq / 4)
-		ctrlval |= SCA3000_OUT_CTRL_BUF_DIV_4;
+		ctrlval |= SCA3000_REG_OUT_CTRL_BUF_DIV_4;
 	else if (val != base_freq)
 		return -EINVAL;
 
@@ -768,7 +767,7 @@ static int sca3000_read_raw(struct iio_dev *indio_dev,
 		} else {
 			/* get the temperature when available */
 			ret = sca3000_read_data_short(st,
-						      SCA3000_REG_ADDR_TEMP_MSB,
+						      SCA3000_REG_TEMP_MSB_ADDR,
 						      2);
 			if (ret < 0) {
 				mutex_unlock(&st->lock);
@@ -839,26 +838,26 @@ static ssize_t sca3000_read_av_freq(struct device *dev,
 	int len = 0, ret, val;
 
 	mutex_lock(&st->lock);
-	ret = sca3000_read_data_short(st, SCA3000_REG_ADDR_MODE, 1);
+	ret = sca3000_read_data_short(st, SCA3000_REG_MODE_ADDR, 1);
 	val = st->rx[0];
 	mutex_unlock(&st->lock);
 	if (ret)
 		goto error_ret;
 
-	switch (val & 0x03) {
-	case SCA3000_MEAS_MODE_NORMAL:
+	switch (val & SCA3000_REG_MODE_MODE_MASK) {
+	case SCA3000_REG_MODE_MEAS_MODE_NORMAL:
 		len += sprintf(buf + len, "%d %d %d\n",
 			       st->info->measurement_mode_freq,
 			       st->info->measurement_mode_freq / 2,
 			       st->info->measurement_mode_freq / 4);
 		break;
-	case SCA3000_MEAS_MODE_OP_1:
+	case SCA3000_REG_MODE_MEAS_MODE_OP_1:
 		len += sprintf(buf + len, "%d %d %d\n",
 			       st->info->option_mode_1_freq,
 			       st->info->option_mode_1_freq / 2,
 			       st->info->option_mode_1_freq / 4);
 		break;
-	case SCA3000_MEAS_MODE_OP_2:
+	case SCA3000_REG_MODE_MEAS_MODE_OP_2:
 		len += sprintf(buf + len, "%d %d %d\n",
 			       st->info->option_mode_2_freq,
 			       st->info->option_mode_2_freq / 2,
@@ -1005,8 +1004,9 @@ static void sca3000_ring_int_process(u8 val, struct iio_dev *indio_dev)
 	int ret, i, num_available;
 
 	mutex_lock(&st->lock);
-	if (val & SCA3000_INT_STATUS_HALF) {
-		ret = sca3000_read_data_short(st, SCA3000_REG_ADDR_BUF_COUNT,
+
+	if (val & SCA3000_REG_INT_STATUS_HALF) {
+		ret = sca3000_read_data_short(st, SCA3000_REG_BUF_COUNT_ADDR,
 					      1);
 		if (ret)
 			goto error_ret;
@@ -1015,7 +1015,7 @@ static void sca3000_ring_int_process(u8 val, struct iio_dev *indio_dev)
 		 * num_available is the total number of samples available
 		 * i.e. number of time points * number of channels.
 		 */
-		ret = sca3000_read_data(st, SCA3000_REG_ADDR_RING_OUT, st->rx,
+		ret = sca3000_read_data(st, SCA3000_REG_RING_OUT_ADDR, st->rx,
 					num_available * 2);
 		if (ret)
 			goto error_ret;
@@ -1056,7 +1056,7 @@ static irqreturn_t sca3000_event_handler(int irq, void *private)
 	 * but ensures no interrupt is missed.
 	 */
 	mutex_lock(&st->lock);
-	ret = sca3000_read_data_short(st, SCA3000_REG_ADDR_INT_STATUS, 1);
+	ret = sca3000_read_data_short(st, SCA3000_REG_INT_STATUS_ADDR, 1);
 	val = st->rx[0];
 	mutex_unlock(&st->lock);
 	if (ret)
@@ -1114,19 +1114,18 @@ static int sca3000_read_event_config(struct iio_dev *indio_dev,
 {
 	struct sca3000_state *st = iio_priv(indio_dev);
 	int ret;
-	u8 protect_mask = 0x03;
 	int num = chan->channel2;
 
 	/* read current value of mode register */
 	mutex_lock(&st->lock);
 
-	ret = sca3000_read_data_short(st, SCA3000_REG_ADDR_MODE, 1);
+	ret = sca3000_read_data_short(st, SCA3000_REG_MODE_ADDR, 1);
 	if (ret)
 		goto error_ret;
 
 	switch (chan->channel2) {
 	case IIO_MOD_X_AND_Y_AND_Z:
-		ret = !!(st->rx[0] & SCA3000_FREE_FALL_DETECT);
+		ret = !!(st->rx[0] & SCA3000_REG_MODE_FREE_FALL_DETECT);
 		break;
 	case IIO_MOD_X:
 	case IIO_MOD_Y:
@@ -1135,7 +1134,8 @@ static int sca3000_read_event_config(struct iio_dev *indio_dev,
 		 * Motion detection mode cannot run at the same time as
 		 * acceleration data being read.
 		 */
-		if ((st->rx[0] & protect_mask) != SCA3000_MEAS_MODE_MOT_DET) {
+		if ((st->rx[0] & SCA3000_REG_MODE_MODE_MASK)
+		    != SCA3000_REG_MODE_MEAS_MODE_MOT_DET) {
 			ret = 0;
 		} else {
 			ret = sca3000_read_ctrl_reg(st,
@@ -1162,18 +1162,18 @@ static int sca3000_freefall_set_state(struct iio_dev *indio_dev, int state)
 	int ret;
 
 	/* read current value of mode register */
-	ret = sca3000_read_data_short(st, SCA3000_REG_ADDR_MODE, 1);
+	ret = sca3000_read_data_short(st, SCA3000_REG_MODE_ADDR, 1);
 	if (ret)
 		return ret;
 
 	/* if off and should be on */
-	if (state && !(st->rx[0] & SCA3000_FREE_FALL_DETECT))
-		return sca3000_write_reg(st, SCA3000_REG_ADDR_MODE,
-					 st->rx[0] | SCA3000_FREE_FALL_DETECT);
+	if (state && !(st->rx[0] & SCA3000_REG_MODE_FREE_FALL_DETECT))
+		return sca3000_write_reg(st, SCA3000_REG_MODE_ADDR,
+					 st->rx[0] | SCA3000_REG_MODE_FREE_FALL_DETECT);
 	/* if on and should be off */
-	else if (!state && (st->rx[0] & SCA3000_FREE_FALL_DETECT))
-		return sca3000_write_reg(st, SCA3000_REG_ADDR_MODE,
-					 st->rx[0] & ~SCA3000_FREE_FALL_DETECT);
+	else if (!state && (st->rx[0] & SCA3000_REG_MODE_FREE_FALL_DETECT))
+		return sca3000_write_reg(st, SCA3000_REG_MODE_ADDR,
+					 st->rx[0] & ~SCA3000_REG_MODE_FREE_FALL_DETECT);
 	else
 		return 0;
 }
@@ -1212,20 +1212,22 @@ static int sca3000_motion_detect_set_state(struct iio_dev *indio_dev, int axis,
 	}
 
 	/* read current value of mode register */
-	ret = sca3000_read_data_short(st, SCA3000_REG_ADDR_MODE, 1);
+	ret = sca3000_read_data_short(st, SCA3000_REG_MODE_ADDR, 1);
 	if (ret)
 		return ret;
 	/* if off and should be on */
 	if ((st->mo_det_use_count) &&
-	    ((st->rx[0] & SCA3000_MODE_MASK) != SCA3000_MEAS_MODE_MOT_DET))
-		return sca3000_write_reg(st, SCA3000_REG_ADDR_MODE,
-					(st->rx[0] & ~SCA3000_MODE_MASK)
-					| SCA3000_MEAS_MODE_MOT_DET);
+	    ((st->rx[0] & SCA3000_REG_MODE_MODE_MASK)
+	     != SCA3000_REG_MODE_MEAS_MODE_MOT_DET))
+		return sca3000_write_reg(st, SCA3000_REG_MODE_ADDR,
+			(st->rx[0] & ~SCA3000_REG_MODE_MODE_MASK)
+			| SCA3000_REG_MODE_MEAS_MODE_MOT_DET);
 	/* if on and should be off */
 	else if (!(st->mo_det_use_count) &&
-		 ((st->rx[0] & SCA3000_MODE_MASK) == SCA3000_MEAS_MODE_MOT_DET))
-		return sca3000_write_reg(st, SCA3000_REG_ADDR_MODE,
-					st->rx[0] & SCA3000_MODE_MASK);
+		 ((st->rx[0] & SCA3000_REG_MODE_MODE_MASK)
+		  == SCA3000_REG_MODE_MEAS_MODE_MOT_DET))
+		return sca3000_write_reg(st, SCA3000_REG_MODE_ADDR,
+			st->rx[0] & SCA3000_REG_MODE_MODE_MASK);
 	else
 		return 0;
 }
@@ -1295,18 +1297,18 @@ int __sca3000_hw_ring_state_set(struct iio_dev *indio_dev, bool state)
 	int ret;
 
 	mutex_lock(&st->lock);
-	ret = sca3000_read_data_short(st, SCA3000_REG_ADDR_MODE, 1);
+	ret = sca3000_read_data_short(st, SCA3000_REG_MODE_ADDR, 1);
 	if (ret)
 		goto error_ret;
 	if (state) {
 		dev_info(&indio_dev->dev, "supposedly enabling ring buffer\n");
 		ret = sca3000_write_reg(st,
-					SCA3000_REG_ADDR_MODE,
-					(st->rx[0] | SCA3000_RING_BUF_ENABLE));
+			SCA3000_REG_MODE_ADDR,
+			(st->rx[0] | SCA3000_REG_MODE_RING_BUF_ENABLE));
 	} else
 		ret = sca3000_write_reg(st,
-					SCA3000_REG_ADDR_MODE,
-					(st->rx[0] & ~SCA3000_RING_BUF_ENABLE));
+			SCA3000_REG_MODE_ADDR,
+			(st->rx[0] & ~SCA3000_REG_MODE_RING_BUF_ENABLE));
 error_ret:
 	mutex_unlock(&st->lock);
 
@@ -1341,12 +1343,12 @@ static int sca3000_hw_ring_preenable(struct iio_dev *indio_dev)
 	mutex_lock(&st->lock);
 
 	/* Enable the 50% full interrupt */
-	ret = sca3000_read_data_short(st, SCA3000_REG_ADDR_INT_MASK, 1);
+	ret = sca3000_read_data_short(st, SCA3000_REG_INT_MASK_ADDR, 1);
 	if (ret)
 		goto error_unlock;
 	ret = sca3000_write_reg(st,
-				SCA3000_REG_ADDR_INT_MASK,
-				st->rx[0] | SCA3000_INT_MASK_RING_HALF);
+				SCA3000_REG_INT_MASK_ADDR,
+				st->rx[0] | SCA3000_REG_INT_MASK_RING_HALF);
 	if (ret)
 		goto error_unlock;
 
@@ -1372,12 +1374,12 @@ static int sca3000_hw_ring_postdisable(struct iio_dev *indio_dev)
 	/* Disable the 50% full interrupt */
 	mutex_lock(&st->lock);
 
-	ret = sca3000_read_data_short(st, SCA3000_REG_ADDR_INT_MASK, 1);
+	ret = sca3000_read_data_short(st, SCA3000_REG_INT_MASK_ADDR, 1);
 	if (ret)
 		goto unlock;
 	ret = sca3000_write_reg(st,
-				SCA3000_REG_ADDR_INT_MASK,
-				st->rx[0] & ~SCA3000_INT_MASK_RING_HALF);
+				SCA3000_REG_INT_MASK_ADDR,
+				st->rx[0] & ~SCA3000_REG_INT_MASK_RING_HALF);
 unlock:
 	mutex_unlock(&st->lock);
 	return ret;
@@ -1401,7 +1403,7 @@ static int sca3000_clean_setup(struct sca3000_state *st)
 
 	mutex_lock(&st->lock);
 	/* Ensure all interrupts have been acknowledged */
-	ret = sca3000_read_data_short(st, SCA3000_REG_ADDR_INT_STATUS, 1);
+	ret = sca3000_read_data_short(st, SCA3000_REG_INT_STATUS_ADDR, 1);
 	if (ret)
 		goto error_ret;
 
@@ -1419,21 +1421,21 @@ static int sca3000_clean_setup(struct sca3000_state *st)
 	if (ret < 0)
 		goto error_ret;
 	ret = sca3000_write_ctrl_reg(st, SCA3000_REG_CTRL_SEL_OUT_CTRL,
-				     (ret & SCA3000_OUT_CTRL_PROT_MASK)
-				     | SCA3000_OUT_CTRL_BUF_X_EN
-				     | SCA3000_OUT_CTRL_BUF_Y_EN
-				     | SCA3000_OUT_CTRL_BUF_Z_EN
-				     | SCA3000_OUT_CTRL_BUF_DIV_4);
+				     (ret & SCA3000_REG_OUT_CTRL_PROT_MASK)
+				     | SCA3000_REG_OUT_CTRL_BUF_X_EN
+				     | SCA3000_REG_OUT_CTRL_BUF_Y_EN
+				     | SCA3000_REG_OUT_CTRL_BUF_Z_EN
+				     | SCA3000_REG_OUT_CTRL_BUF_DIV_4);
 	if (ret)
 		goto error_ret;
 	/* Enable interrupts, relevant to mode and set up as active low */
-	ret = sca3000_read_data_short(st, SCA3000_REG_ADDR_INT_MASK, 1);
+	ret = sca3000_read_data_short(st, SCA3000_REG_INT_MASK_ADDR, 1);
 	if (ret)
 		goto error_ret;
 	ret = sca3000_write_reg(st,
-				SCA3000_REG_ADDR_INT_MASK,
-				(ret & SCA3000_INT_MASK_PROT_MASK)
-				| SCA3000_INT_MASK_ACTIVE_LOW);
+				SCA3000_REG_INT_MASK_ADDR,
+				(ret & SCA3000_REG_INT_MASK_PROT_MASK)
+				| SCA3000_REG_INT_MASK_ACTIVE_LOW);
 	if (ret)
 		goto error_ret;
 	/*
@@ -1441,10 +1443,10 @@ static int sca3000_clean_setup(struct sca3000_state *st)
 	 * Ring in 12 bit mode - it is fine to overwrite reserved bits 3,5
 	 * as that occurs in one of the example on the datasheet
 	 */
-	ret = sca3000_read_data_short(st, SCA3000_REG_ADDR_MODE, 1);
+	ret = sca3000_read_data_short(st, SCA3000_REG_MODE_ADDR, 1);
 	if (ret)
 		goto error_ret;
-	ret = sca3000_write_reg(st, SCA3000_REG_ADDR_MODE,
+	ret = sca3000_write_reg(st, SCA3000_REG_MODE_ADDR,
 				(st->rx[0] & SCA3000_MODE_PROT_MASK));
 
 error_ret:
@@ -1527,14 +1529,14 @@ static int sca3000_stop_all_interrupts(struct sca3000_state *st)
 	int ret;
 
 	mutex_lock(&st->lock);
-	ret = sca3000_read_data_short(st, SCA3000_REG_ADDR_INT_MASK, 1);
+	ret = sca3000_read_data_short(st, SCA3000_REG_INT_MASK_ADDR, 1);
 	if (ret)
 		goto error_ret;
-	ret = sca3000_write_reg(st, SCA3000_REG_ADDR_INT_MASK,
+	ret = sca3000_write_reg(st, SCA3000_REG_INT_MASK_ADDR,
 				(st->rx[0] &
-				 ~(SCA3000_INT_MASK_RING_THREE_QUARTER |
-				   SCA3000_INT_MASK_RING_HALF |
-				   SCA3000_INT_MASK_ALL_INTS)));
+				 ~(SCA3000_REG_INT_MASK_RING_THREE_QUARTER |
+				   SCA3000_REG_INT_MASK_RING_HALF |
+				   SCA3000_REG_INT_MASK_ALL_INTS)));
 error_ret:
 	mutex_unlock(&st->lock);
 	return ret;
-- 
2.10.0

