Return-Path: <SRS0=k1jU=7K=monstr.eu=monstr@kernel.org>
Sender: Michal Simek <monstr@monstr.eu>
From: Michal Simek <michal.simek@xilinx.com>
To: linux-kernel@vger.kernel.org,
	monstr@monstr.eu
Cc: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>,
	=?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>,
	linux-iio@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Jonathan Cameron <jic23@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] iio: adc: Fix coding style violations
Date: Tue,  8 Aug 2017 14:04:41 +0200
Message-Id: <d310ac06b13cf803bd3a2a6bcfb92169445f929c.1502193860.git.michal.simek@xilinx.com>
List-ID: <linux-iio@vger.kernel.org>

From: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>

This patch fix following checkpatch warnings in xadc driver
1. Prefer 'unsigned int' to bare use of 'unsigned'.
2. else is not generally useful after a break or return.
3. function definition argument 'struct xadc *' should also
have an identifier name.

Signed-off-by: Sai Krishna Potthuri <lakshmis@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/iio/adc/xilinx-xadc-events.c | 38 +++++++++++++++++-------------------
 drivers/iio/adc/xilinx-xadc.h        |  2 +-
 2 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-events.c b/drivers/iio/adc/xilinx-xadc-events.c
index 6d5c2a6f4e6e..dc0670308253 100644
--- a/drivers/iio/adc/xilinx-xadc-events.c
+++ b/drivers/iio/adc/xilinx-xadc-events.c
@@ -68,7 +68,7 @@ void xadc_handle_events(struct iio_dev *indio_dev, unsigned long events)
 		xadc_handle_event(indio_dev, i);
 }
 
-static unsigned xadc_get_threshold_offset(const struct iio_chan_spec *chan,
+static unsigned int xadc_get_threshold_offset(const struct iio_chan_spec *chan,
 	enum iio_event_direction dir)
 {
 	unsigned int offset;
@@ -90,26 +90,24 @@ static unsigned xadc_get_threshold_offset(const struct iio_chan_spec *chan,
 
 static unsigned int xadc_get_alarm_mask(const struct iio_chan_spec *chan)
 {
-	if (chan->type == IIO_TEMP) {
+	if (chan->type == IIO_TEMP)
 		return XADC_ALARM_OT_MASK;
-	} else {
-		switch (chan->channel) {
-		case 0:
-			return XADC_ALARM_VCCINT_MASK;
-		case 1:
-			return XADC_ALARM_VCCAUX_MASK;
-		case 2:
-			return XADC_ALARM_VCCBRAM_MASK;
-		case 3:
-			return XADC_ALARM_VCCPINT_MASK;
-		case 4:
-			return XADC_ALARM_VCCPAUX_MASK;
-		case 5:
-			return XADC_ALARM_VCCODDR_MASK;
-		default:
-			/* We will never get here */
-			return 0;
-		}
+	switch (chan->channel) {
+	case 0:
+		return XADC_ALARM_VCCINT_MASK;
+	case 1:
+		return XADC_ALARM_VCCAUX_MASK;
+	case 2:
+		return XADC_ALARM_VCCBRAM_MASK;
+	case 3:
+		return XADC_ALARM_VCCPINT_MASK;
+	case 4:
+		return XADC_ALARM_VCCPAUX_MASK;
+	case 5:
+		return XADC_ALARM_VCCODDR_MASK;
+	default:
+		/* We will never get here */
+		return 0;
 	}
 }
 
diff --git a/drivers/iio/adc/xilinx-xadc.h b/drivers/iio/adc/xilinx-xadc.h
index f6f081965647..9069396d7622 100644
--- a/drivers/iio/adc/xilinx-xadc.h
+++ b/drivers/iio/adc/xilinx-xadc.h
@@ -76,7 +76,7 @@ struct xadc_ops {
 	int (*setup)(struct platform_device *pdev, struct iio_dev *indio_dev,
 			int irq);
 	void (*update_alarm)(struct xadc *, unsigned int);
-	unsigned long (*get_dclk_rate)(struct xadc *);
+	unsigned long (*get_dclk_rate)(struct xadc *xadc);
 	irqreturn_t (*interrupt_handler)(int, void *);
 
 	unsigned int flags;
-- 
1.9.1
