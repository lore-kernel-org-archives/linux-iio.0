Return-Path: <a0132425@kernel.org>
From: Vignesh R <vigneshr@ti.com>
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark
 Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, Jonathan Cameron <jic23@kernel.org>
CC: Randy Dunlap <rdunlap@infradead.org>,
        Samuel Ortiz
	<sameo@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>, Felipe Balbi
	<balbi@ti.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, Vignesh R <vigneshr@ti.com>
Subject: [PATCH 2/2] iio: adc: ti_am335x_adc: make sample delay, open delay, averaging DT parameters
Date: Wed, 27 Aug 2014 17:49:50 +0530
Message-ID: <1409141990-29627-2-git-send-email-vigneshr@ti.com>
In-Reply-To: <1409141990-29627-1-git-send-email-vigneshr@ti.com>
References: <1409141990-29627-1-git-send-email-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Number of averaging, open delay, sample delay are made DT parameters.
By decreasing averaging and delays more samples can be obtained per
second increasing performance of ADC. Previously the number of
averages per step was fixed to 16. Making these parameters
configurable will help in balancing speed vs accuracy.
For each ADC step provide DT based paramters to set open delay,
sample delay and number of averaging. One configurable step is
used per ADC channel. Since there can be atmost 8 ADC channels,
steps 16 to 8 are used for ADC.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 .../bindings/input/touchscreen/ti-tsc-adc.txt      |   18 +++++++
 drivers/iio/adc/ti_am335x_adc.c                    |   49 +++++++++++++++++---
 include/linux/mfd/ti_am335x_tscadc.h               |    3 ++
 3 files changed, 63 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt b/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt
index 878549b..09ac097 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt
@@ -27,6 +27,21 @@ Required properties:
 - child "adc"
 	ti,adc-channels: List of analog inputs available for ADC.
 			 AIN0 = 0, AIN1 = 1 and so on till AIN7 = 7.
+Optional properties:
+- child "adc"
+	ti,step-opendelay: List of open delays for each channel of ADC in the order
+			   of ti,adc-channels. This value is written to corresponding
+			   step-config register. Default value is 0x098.
+			   Maximum value is 0x3FFF.
+	ti,step-sampledelay: List of sample delays for each channel of ADC in the order
+			     of ti,adc-channels. This value is written to corresponding
+			     step-config register. Default value is 0x0.
+			     Maximum value is 0xFF.
+	ti,step-average: Number of averages to be performed for each channel of ADC.
+			 If average is 16 then input is sampled 16 times and averaged to
+			 get more accurate value. This increases the time taken by ADC
+			 to generate a sample. Valid range is 0 average to 16 averages.
+			 Default value is 16. Maximum value is 16.
 
 Example:
 	tscadc: tscadc@44e0d000 {
@@ -40,5 +55,8 @@ Example:
 
 		adc {
 			ti,adc-channels = <4 5 6 7>;
+			ti,step-opendelay = <0x098 0x3FFFF 0x098 0x0>;
+			ti,step-sampledelay = <0xFF 0x0 0xF 0x0>;
+			ti,step-average = <16 2 4 8>;
 		};
 	}
diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index dfb0db0..2b31ef2 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -37,6 +37,7 @@ struct tiadc_device {
 	u8 channel_line[8];
 	u8 channel_step[8];
 	int buffer_en_ch_steps;
+	u32 open_delay[8], sample_delay[8], step_avg[8];
 	u16 data[8];
 };
 
@@ -86,6 +87,7 @@ static u32 get_adc_step_bit(struct tiadc_device *adc_dev, int chan)
 static void tiadc_step_config(struct iio_dev *indio_dev)
 {
 	struct tiadc_device *adc_dev = iio_priv(indio_dev);
+	struct device *dev = adc_dev->mfd_tscadc->dev;
 	unsigned int stepconfig;
 	int i, steps;
 
@@ -100,20 +102,41 @@ static void tiadc_step_config(struct iio_dev *indio_dev)
 	 */
 
 	steps = TOTAL_STEPS - adc_dev->channels;
-	if (iio_buffer_enabled(indio_dev))
-		stepconfig = STEPCONFIG_AVG_16 | STEPCONFIG_FIFO1
-					| STEPCONFIG_MODE_SWCNT;
-	else
-		stepconfig = STEPCONFIG_AVG_16 | STEPCONFIG_FIFO1;
-
 	for (i = 0; i < adc_dev->channels; i++) {
 		int chan;
 
 		chan = adc_dev->channel_line[i];
+
+		if (adc_dev->step_avg[i] > STEPCONFIG_AVG_MAX) {
+			dev_warn(dev, "channel %d step average exceeds max value, truncating to %d\n",
+				 chan, STEPCONFIG_AVG_MAX);
+			adc_dev->step_avg[i] = STEPCONFIG_AVG_MAX;
+		}
+
+		stepconfig = STEPCONFIG_AVG(ffs(adc_dev->step_avg[i]) - 1) |
+			     STEPCONFIG_FIFO1;
+
+		if (iio_buffer_enabled(indio_dev))
+			stepconfig |= STEPCONFIG_MODE_SWCNT;
+
 		tiadc_writel(adc_dev, REG_STEPCONFIG(steps),
 				stepconfig | STEPCONFIG_INP(chan));
+
+		if (adc_dev->open_delay[i] > STEPDELAY_OPEN_MAX) {
+			dev_warn(dev, "channel %d step delay open exceeds max value, truncating to %d\n",
+				 chan, STEPDELAY_OPEN_MAX);
+			adc_dev->open_delay[i] = STEPDELAY_OPEN_MAX;
+		}
+
+		if (adc_dev->sample_delay[i] > STEPDELAY_SAMPLE_MAX) {
+			dev_warn(dev, "channel %d step delay sample max value, truncating to %d\n",
+				 chan, STEPDELAY_SAMPLE_MAX);
+			adc_dev->sample_delay[i] = STEPDELAY_SAMPLE_MAX;
+		}
+
 		tiadc_writel(adc_dev, REG_STEPDELAY(steps),
-				STEPCONFIG_OPENDLY);
+			     STEPDELAY_OPEN(adc_dev->open_delay[i]) |
+			     STEPDELAY_SAMPLE(adc_dev->sample_delay[i]));
 		adc_dev->channel_step[i] = steps;
 		steps++;
 	}
@@ -418,10 +441,22 @@ static int tiadc_parse_dt(struct platform_device *pdev,
 
 	of_property_for_each_u32(node, "ti,adc-channels", prop, cur, val) {
 		adc_dev->channel_line[channels] = val;
+
+		/* Set Default values for optional DT parameters */
+		adc_dev->open_delay[channels] = STEPCONFIG_OPENDLY;
+		adc_dev->sample_delay[channels] = STEPCONFIG_SAMPLEDLY;
+		adc_dev->step_avg[channels] = 16;
 		channels++;
 	}
 
 	adc_dev->channels = channels;
+	of_property_read_u32_array(node, "ti,step-average",
+				   adc_dev->step_avg, channels);
+	of_property_read_u32_array(node, "ti,step-opendelay",
+				   adc_dev->open_delay, channels);
+	of_property_read_u32_array(node, "ti,step-sampledelay",
+				   adc_dev->sample_delay, channels);
+
 	return 0;
 }
 
diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd/ti_am335x_tscadc.h
index fb96c84..26d3e84 100644
--- a/include/linux/mfd/ti_am335x_tscadc.h
+++ b/include/linux/mfd/ti_am335x_tscadc.h
@@ -82,14 +82,17 @@
 #define STEPCONFIG_INP_AN4	STEPCONFIG_INP(4)
 #define STEPCONFIG_INP_ADCREFM	STEPCONFIG_INP(8)
 #define STEPCONFIG_FIFO1	BIT(26)
+#define STEPCONFIG_AVG_MAX	16
 
 /* Delay register */
 #define STEPDELAY_OPEN_MASK	(0x3FFFF << 0)
 #define STEPDELAY_OPEN(val)	((val) << 0)
 #define STEPCONFIG_OPENDLY	STEPDELAY_OPEN(0x098)
+#define STEPDELAY_OPEN_MAX	0x3FFFF
 #define STEPDELAY_SAMPLE_MASK	(0xFF << 24)
 #define STEPDELAY_SAMPLE(val)	((val) << 24)
 #define STEPCONFIG_SAMPLEDLY	STEPDELAY_SAMPLE(0)
+#define STEPDELAY_SAMPLE_MAX	0xFF
 
 /* Charge Config */
 #define STEPCHARGE_RFP_MASK	(7 << 12)
-- 
1.7.9.5
