Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx02.posteo.de ([89.146.194.165]:48331 "EHLO mx02.posteo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753578AbbG0OJu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 27 Jul 2015 10:09:50 -0400
From: Martin Kepplinger <martink@posteo.de>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, mfuzzey@parkeon.com, roberta.dobrescu@gmail.com,
	robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org
Cc: devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	christoph.muellner@theobroma-systems.com,
	Martin Kepplinger <martink@posteo.de>,
	Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
Subject: [PATCH 3/8] iio: mma8452: add freefall / motion interrupt source
Date: Mon, 27 Jul 2015 16:08:10 +0200
Message-Id: <1438006095-26920-4-git-send-email-martink@posteo.de>
In-Reply-To: <1438006095-26920-1-git-send-email-martink@posteo.de>
References: <1438006095-26920-1-git-send-email-martink@posteo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This adds the freefall / motion interrupt source definitions to the driver.
It is used in this series' next patch, for chips that don't support the
transient interrupt source.

The iio event type is IIO_EV_TYPE_MAG since the threshold for comparison
is no signed value. An interrupt occurs on positive and negative values
when the magnitude crosses the threshold value.

Signed-off-by: Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
---
 drivers/iio/accel/mma8452.c | 45 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 36 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 57b12eb..d51ce63 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -37,9 +37,18 @@
 #define MMA8452_DATA_CFG 0x0e
 #define MMA8452_HP_FILTER_CUTOFF 0x0f
 #define MMA8452_HP_FILTER_CUTOFF_SEL_MASK	(BIT(0) | BIT(1))
+#define MMA8452_FF_MT_CFG 0x15
+#define MMA8452_FF_MT_CFG_OAE			BIT(6)
+#define MMA8452_FF_MT_CFG_ELE			BIT(7)
+#define MMA8452_FF_MT_SRC 0x16
+#define MMA8452_FF_MT_SRC_XHE			BIT(1)
+#define MMA8452_FF_MT_SRC_YHE			BIT(3)
+#define MMA8452_FF_MT_SRC_ZHE			BIT(5)
+#define MMA8452_FF_MT_THS 0x17
+#define MMA8452_FF_MT_THS_MASK 0x7f
+#define MMA8452_FF_MT_COUNT 0x18
 #define MMA8452_TRANSIENT_CFG 0x1d
 #define MMA8452_TRANSIENT_CFG_ELE		BIT(4)
-#define MMA8452_TRANSIENT_CFG_CHAN(chan)	BIT(chan + 1)
 #define MMA8452_TRANSIENT_CFG_HPF_BYP		BIT(0)
 #define MMA8452_TRANSIENT_SRC 0x1e
 #define MMA8452_TRANSIENT_SRC_XTRANSE		BIT(1)
@@ -73,6 +82,7 @@
 #define MMA8452_DATA_CFG_HPF_MASK BIT(4)
 
 #define MMA8452_INT_DRDY	BIT(0)
+#define MMA8452_INT_FF_MT	BIT(2)
 #define MMA8452_INT_TRANS	BIT(5)
 
 #define MMA8452_DEVICE_ID 0x2a
@@ -590,7 +600,8 @@ static int mma8452_write_event_config(struct iio_dev *indio_dev,
 	else
 		val &= ~BIT(chan->scan_index + chip->ev_cfg_chan_shift);
 
-	val |= MMA8452_TRANSIENT_CFG_ELE;
+	val |= chip->ev_cfg_ele;
+	val |= MMA8452_FF_MT_CFG_OAE;
 
 	return mma8452_change_config(data, chip->ev_cfg, val);
 }
@@ -631,6 +642,7 @@ static irqreturn_t mma8452_interrupt(int irq, void *p)
 {
 	struct iio_dev *indio_dev = p;
 	struct mma8452_data *data = iio_priv(indio_dev);
+	const struct mma_chip_info *chip = data->chip_info;
 	int ret = IRQ_NONE;
 	int src;
 
@@ -643,7 +655,10 @@ static irqreturn_t mma8452_interrupt(int irq, void *p)
 		ret = IRQ_HANDLED;
 	}
 
-	if (src & MMA8452_INT_TRANS) {
+	if ((src & MMA8452_INT_TRANS &&
+	     chip->ev_src == MMA8452_TRANSIENT_SRC) ||
+	    (src & MMA8452_INT_FF_MT &&
+	     chip->ev_src == MMA8452_FF_MT_SRC)) {
 		mma8452_transient_interrupt(indio_dev);
 		ret = IRQ_HANDLED;
 	}
@@ -704,6 +719,16 @@ static const struct iio_event_spec mma8452_transient_event[] = {
 	},
 };
 
+static const struct iio_event_spec mma8452_motion_event[] = {
+	{
+		.type = IIO_EV_TYPE_MAG,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
+		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
+					BIT(IIO_EV_INFO_PERIOD)
+	},
+};
+
 /*
  * Threshold is configured in fixed 8G/127 steps regardless of
  * currently selected scale for measurement.
@@ -987,13 +1012,15 @@ static int mma8452_probe(struct i2c_client *client,
 
 	if (client->irq) {
 		/*
-		 * Although we enable the transient interrupt source once and
-		 * for all here the transient event detection itself is not
-		 * enabled until userspace asks for it by
-		 * mma8452_write_event_config()
+		 * Although we enable the interrupt sources once and for
+		 * all here the event detection itself is not enabled until
+		 * userspace asks for it by mma8452_write_event_config()
 		 */
-		int supported_interrupts = MMA8452_INT_DRDY | MMA8452_INT_TRANS;
-		int enabled_interrupts = MMA8452_INT_TRANS;
+		int supported_interrupts = MMA8452_INT_DRDY |
+					   MMA8452_INT_TRANS |
+					   MMA8452_INT_FF_MT;
+		int enabled_interrupts = MMA8452_INT_TRANS |
+					 MMA8452_INT_FF_MT;
 
 		/* Assume wired to INT1 pin */
 		ret = i2c_smbus_write_byte_data(client,
-- 
2.1.4

