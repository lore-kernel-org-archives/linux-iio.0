Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:33393 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752824AbdASNfm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Jan 2017 08:35:42 -0500
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <jic23@kernel.org>, <linux@armlinux.org.uk>, <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linux-iio@vger.kernel.org>, <mark.rutland@arm.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <fabrice.gasnier@st.com>, <benjamin.gaignard@linaro.org>,
        <benjamin.gaignard@st.com>
Subject: [PATCH 3/7] iio: adc: stm32: add trigger polarity extended attribute
Date: Thu, 19 Jan 2017 14:34:10 +0100
Message-ID: <1484832854-6314-4-git-send-email-fabrice.gasnier@st.com>
In-Reply-To: <1484832854-6314-1-git-send-email-fabrice.gasnier@st.com>
References: <1484832854-6314-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Define extended attribute so that user may choose rising, falling or both
edges for external trigger sources.
Default to rising edge in case it isn't set.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/iio/adc/stm32-adc.c | 51 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index 30708bc..9753c39 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -164,6 +164,7 @@ struct stm32_adc_trig_info {
  * @lock:		spinlock
  * @bufi:		data buffer index
  * @num_conv:		expected number of scan conversions
+ * @exten:		external trigger config (enable/polarity)
  */
 struct stm32_adc {
 	struct stm32_adc_common	*common;
@@ -175,6 +176,7 @@ struct stm32_adc {
 	spinlock_t		lock;		/* interrupt lock */
 	int			bufi;
 	int			num_conv;
+	enum stm32_adc_exten	exten;
 };
 
 /**
@@ -449,7 +451,9 @@ static int stm32_adc_set_trig(struct iio_dev *indio_dev,
 
 		/* set trigger source, default to rising edge */
 		extsel = ret;
-		exten = STM32_EXTEN_HWTRIG_RISING_EDGE;
+		if (adc->exten == STM32_EXTEN_SWTRIG)
+			adc->exten = STM32_EXTEN_HWTRIG_RISING_EDGE;
+		exten = adc->exten;
 	}
 
 	spin_lock_irqsave(&adc->lock, flags);
@@ -463,6 +467,39 @@ static int stm32_adc_set_trig(struct iio_dev *indio_dev,
 	return 0;
 }
 
+static int stm32_adc_set_trig_pol(struct iio_dev *indio_dev,
+				  const struct iio_chan_spec *chan,
+				  unsigned int type)
+{
+	struct stm32_adc *adc = iio_priv(indio_dev);
+
+	adc->exten = type;
+
+	return 0;
+}
+
+static int stm32_adc_get_trig_pol(struct iio_dev *indio_dev,
+				  const struct iio_chan_spec *chan)
+{
+	struct stm32_adc *adc = iio_priv(indio_dev);
+
+	return adc->exten;
+}
+
+static const char * const stm32_trig_pol_items[] = {
+	[STM32_EXTEN_SWTRIG] = "swtrig",
+	[STM32_EXTEN_HWTRIG_RISING_EDGE] = "rising-edge",
+	[STM32_EXTEN_HWTRIG_FALLING_EDGE] = "falling-edge",
+	[STM32_EXTEN_HWTRIG_BOTH_EDGES] = "both-edges",
+};
+
+const struct iio_enum stm32_adc_trig_pol = {
+	.items = stm32_trig_pol_items,
+	.num_items = ARRAY_SIZE(stm32_trig_pol_items),
+	.get = stm32_adc_get_trig_pol,
+	.set = stm32_adc_set_trig_pol,
+};
+
 /**
  * stm32_adc_single_conv() - Performs a single conversion
  * @indio_dev: IIO device
@@ -745,6 +782,17 @@ static irqreturn_t stm32_adc_trigger_handler(int irq, void *p)
 	return IRQ_HANDLED;
 }
 
+static const struct iio_chan_spec_ext_info stm32_adc_ext_info[] = {
+	IIO_ENUM("trigger_pol", IIO_SHARED_BY_ALL, &stm32_adc_trig_pol),
+	{
+		.name = "trigger_pol_available",
+		.shared = IIO_SHARED_BY_ALL,
+		.read = iio_enum_available_read,
+		.private = (uintptr_t)&stm32_adc_trig_pol,
+	},
+	{},
+};
+
 static void stm32_adc_chan_init_one(struct iio_dev *indio_dev,
 				    struct iio_chan_spec *chan,
 				    const struct stm32_adc_chan_spec *channel,
@@ -760,6 +808,7 @@ static void stm32_adc_chan_init_one(struct iio_dev *indio_dev,
 	chan->scan_type.sign = 'u';
 	chan->scan_type.realbits = 12;
 	chan->scan_type.storagebits = 16;
+	chan->ext_info = stm32_adc_ext_info;
 }
 
 static int stm32_adc_chan_of_init(struct iio_dev *indio_dev)
-- 
1.9.1

