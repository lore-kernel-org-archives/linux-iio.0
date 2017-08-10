Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38256 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750841AbdHJGa0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Aug 2017 02:30:26 -0400
Received: by mail-wm0-f66.google.com with SMTP id y206so1813296wmd.5
        for <linux-iio@vger.kernel.org>; Wed, 09 Aug 2017 23:30:25 -0700 (PDT)
From: Michal Simek <michal.simek@xilinx.com>
To: linux-kernel@vger.kernel.org, monstr@monstr.eu
Cc: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>,
        =?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>,
        linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] iio: adc: Fix coding style violations
Date: Thu, 10 Aug 2017 08:30:20 +0200
Message-Id: <4d8fa659c811106d57122b24ae8e9c075dc8843a.1502346616.git.michal.simek@xilinx.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>

This patch fix following checkpatch warnings in xadc driver
1. prefer 'unsigned int' to bare use of 'unsigned'.
2. else is not generally useful after a break or return.
3. fill all function definition arguments with identifier name

Signed-off-by: Sai Krishna Potthuri <lakshmis@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2:
- Fix all functions definition arguments in header with identifier name
- Change commit message to reflect v2 changes
  both reported by: Joe Perches

 drivers/iio/adc/xilinx-xadc-events.c | 38 +++++++++++++++++-------------------
 drivers/iio/adc/xilinx-xadc.h        | 10 +++++-----
 2 files changed, 23 insertions(+), 25 deletions(-)

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
index f6f081965647..62edbdae1244 100644
--- a/drivers/iio/adc/xilinx-xadc.h
+++ b/drivers/iio/adc/xilinx-xadc.h
@@ -71,13 +71,13 @@ struct xadc {
 };
 
 struct xadc_ops {
-	int (*read)(struct xadc *, unsigned int, uint16_t *);
-	int (*write)(struct xadc *, unsigned int, uint16_t);
+	int (*read)(struct xadc *xadc, unsigned int reg, uint16_t *val);
+	int (*write)(struct xadc *xadc, unsigned int reg, uint16_t val);
 	int (*setup)(struct platform_device *pdev, struct iio_dev *indio_dev,
 			int irq);
-	void (*update_alarm)(struct xadc *, unsigned int);
-	unsigned long (*get_dclk_rate)(struct xadc *);
-	irqreturn_t (*interrupt_handler)(int, void *);
+	void (*update_alarm)(struct xadc *xadc, unsigned int alarm);
+	unsigned long (*get_dclk_rate)(struct xadc *xadc);
+	irqreturn_t (*interrupt_handler)(int irq, void *devid);
 
 	unsigned int flags;
 };
-- 
1.9.1

