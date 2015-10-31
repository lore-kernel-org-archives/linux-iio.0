Return-Path: <MAILER-DAEMON>
From: "Andrew F. Davis" <afd@ti.com>
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark
 Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
        Peter
 Meerwald <pmeerw@pmeerw.net>
CC: <devicetree@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-api@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Andrew F.
 Davis" <afd@ti.com>
Subject: [PATCH 2/2] iio: health: Add driver for the TI AFE4404 heart monitor
Date: Sat, 31 Oct 2015 11:31:29 -0500
Message-ID: <1446309089-21094-3-git-send-email-afd@ti.com>
In-Reply-To: <1446309089-21094-1-git-send-email-afd@ti.com>
References: <1446309089-21094-1-git-send-email-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Add driver for the TI AFE4404 heart rate monitor and pulse oximeter.
This device detects reflected LED light fluctuations and presents an ADC
value to the user space for further signal processing.

Data sheet located here:
http://www.ti.com/product/AFE4404/datasheet

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 .../ABI/testing/sysfs-bus-iio-health-afe4404       |  70 +++
 drivers/iio/Kconfig                                |   1 +
 drivers/iio/Makefile                               |   1 +
 drivers/iio/health/Kconfig                         |  24 +
 drivers/iio/health/Makefile                        |   6 +
 drivers/iio/health/afe4404.c                       | 526 +++++++++++++++++++++
 drivers/iio/health/afe440x.h                       | 159 +++++++
 7 files changed, 787 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-health-afe4404
 create mode 100644 drivers/iio/health/Kconfig
 create mode 100644 drivers/iio/health/Makefile
 create mode 100644 drivers/iio/health/afe4404.c
 create mode 100644 drivers/iio/health/afe440x.h

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-health-afe4404 b/Documentation/ABI/testing/sysfs-bus-iio-health-afe4404
new file mode 100644
index 0000000..c67748b
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-health-afe4404
@@ -0,0 +1,70 @@
+What:		/sys/bus/iio/devices/iio:deviceX/out_resistanceY_tia_raw
+		/sys/bus/iio/devices/iio:deviceX/out_capacitanceY_tia_raw
+Date:		October 2015
+KernelVersion:
+Contact:	Andrew F. Davis <afd@ti.com>
+Description:
+		Get and set the resistance and the capacitance settings for the
+		Transimpedance Amplifier. Y is 1 for Rf1 and Cf1, Y is 2 for
+		Rf2 and Cf2 values.
+		Resistance setting is from 0 -> 7
+		Capcitance setting is from 0 -> 15
+
+What:		/sys/bus/iio/devices/iio:deviceX/tia_separate_enable
+Date:		October 2015
+KernelVersion:
+Contact:	Andrew F. Davis <afd@ti.com>
+Description:
+		Enable or disable separate settings for the TransImpedance
+		Amplifier above, when disabled both values are set by the
+		first channel.
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_current_ledY_raw
+Date:		October 2015
+KernelVersion:
+Contact:	Andrew F. Davis <afd@ti.com>
+Description:
+		Get and set the LED current for the specified LED.
+		Y is the specific LED number.
+		Values range from 0 -> 63.  Current is calculated by
+		current = value * 0.8mA
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_ledY_raw
+		/sys/bus/iio/devices/iio:deviceX/in_intensity_ledY_ambient_raw
+Date:		October 2015
+KernelVersion:
+Contact:	Andrew F. Davis <afd@ti.com>
+Description:
+		Get measured values from the ADC for these stages. Y is the
+		specific LED number. The values are expressed in 24-bit twos
+		complement for the specified LEDs.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_led1-led1_ambient_raw
+		/sys/bus/iio/devices/iio:deviceX/in_intensity_led2-led2_ambient_raw
+Date:		October 2015
+KernelVersion:
+Contact:	Andrew F. Davis <afd@ti.com>
+Description:
+		Get differential values from the ADC for these stages.  The
+		values are expressed in 24-bit twos complement for the
+		specified LEDs.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_led1-led1_ambient_mean_raw
+		/sys/bus/iio/devices/iio:deviceX/in_intensity_led2-led2_ambient_mean_raw
+Date:		October 2015
+KernelVersion:
+Contact:	Andrew F. Davis <afd@ti.com>
+Description:
+		Get average values from the ADC for these stages.  The
+		values are expressed in 24-bit twos complement for the
+		specified LEDs.
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_current_offdac_ledY_raw
+		/sys/bus/iio/devices/iio:deviceX/out_current_offdac_ledY_ambient_raw
+Date:		October 2015
+KernelVersion:
+Contact:	Andrew F. Davis <afd@ti.com>
+Description:
+		Get and set the offset cancellation DAC setting for these
+		stages.
+		Values range from 0 -> 15
diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
index 4011eff..53e1892 100644
--- a/drivers/iio/Kconfig
+++ b/drivers/iio/Kconfig
@@ -65,6 +65,7 @@ source "drivers/iio/common/Kconfig"
 source "drivers/iio/dac/Kconfig"
 source "drivers/iio/frequency/Kconfig"
 source "drivers/iio/gyro/Kconfig"
+source "drivers/iio/health/Kconfig"
 source "drivers/iio/humidity/Kconfig"
 source "drivers/iio/imu/Kconfig"
 source "drivers/iio/light/Kconfig"
diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
index 698afc2..d350cb3 100644
--- a/drivers/iio/Makefile
+++ b/drivers/iio/Makefile
@@ -18,6 +18,7 @@ obj-y += common/
 obj-y += dac/
 obj-y += gyro/
 obj-y += frequency/
+obj-y += health/
 obj-y += humidity/
 obj-y += imu/
 obj-y += light/
diff --git a/drivers/iio/health/Kconfig b/drivers/iio/health/Kconfig
new file mode 100644
index 0000000..f5e5d82
--- /dev/null
+++ b/drivers/iio/health/Kconfig
@@ -0,0 +1,24 @@
+#
+# Health drivers
+#
+# When adding new entries keep the list in alphabetical order
+
+menu "Health"
+
+menu "Heart Rate Monitors"
+
+config AFE4404
+	tristate "TI AFE4404 Heart Rate Monitor"
+	depends on I2C
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	help
+	  Say yes to choose the Texas Instruments AFE4404
+	  heart rate monitor and low-cost pulse oximeter.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called afe4404.
+
+endmenu
+
+endmenu
diff --git a/drivers/iio/health/Makefile b/drivers/iio/health/Makefile
new file mode 100644
index 0000000..c108c8d
--- /dev/null
+++ b/drivers/iio/health/Makefile
@@ -0,0 +1,6 @@
+#
+# Makefile for IIO Health drivers
+#
+# When adding new entries keep the list in alphabetical order
+
+obj-$(CONFIG_AFE4404) += afe4404.o
diff --git a/drivers/iio/health/afe4404.c b/drivers/iio/health/afe4404.c
new file mode 100644
index 0000000..af65f30
--- /dev/null
+++ b/drivers/iio/health/afe4404.c
@@ -0,0 +1,526 @@
+/*
+ * AFE4404 Heart Rate Monitors and Low-Cost Pulse Oximeters
+ *
+ * Author: Andrew F. Davis <afd@ti.com>
+ *
+ * Copyright: (C) 2015 Texas Instruments, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ */
+
+#include <linux/device.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/i2c.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_gpio.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
+#include <linux/regulator/consumer.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/trigger_consumer.h>
+
+#include "afe440x.h"
+
+#define AFE4404_DRIVER_NAME		"afe4404"
+
+/* AFE4404 registers */
+#define AFE4404_TIA_GAIN_SEP		0x20
+#define AFE4404_TIA_GAIN		0x21
+#define AFE4404_PROG_TG_STC		0x34
+#define AFE4404_PROG_TG_ENDC		0x35
+#define AFE4404_LED3LEDSTC		0x36
+#define AFE4404_LED3LEDENDC		0x37
+#define AFE4404_CLKDIV_PRF		0x39
+#define AFE4404_OFFDAC			0x3a
+#define AFE4404_DEC			0x3d
+#define AFE4404_AVG_LED2_ALED2VAL	0x3f
+#define AFE4404_AVG_LED1_ALED1VAL	0x40
+
+/* AFE4404 GAIN register fields */
+#define AFE4404_TIA_GAIN_RES_MASK	GENMASK(2, 0)
+#define AFE4404_TIA_GAIN_RES_SHIFT	0
+#define AFE4404_TIA_GAIN_CAP_MASK	GENMASK(5, 3)
+#define AFE4404_TIA_GAIN_CAP_SHIFT	3
+
+/* AFE4404 LEDCNTRL register fields */
+#define AFE4404_LEDCNTRL_ILED1_MASK	GENMASK(5, 0)
+#define AFE4404_LEDCNTRL_ILED1_SHIFT	0
+#define AFE4404_LEDCNTRL_ILED2_MASK	GENMASK(11, 6)
+#define AFE4404_LEDCNTRL_ILED2_SHIFT	6
+#define AFE4404_LEDCNTRL_ILED3_MASK	GENMASK(17, 12)
+#define AFE4404_LEDCNTRL_ILED3_SHIFT	12
+
+/* AFE4404 CONTROL3 register fields */
+#define AFE440X_CONTROL3_OSC_ENABLE	BIT(9)
+
+/* AFE4404 OFFDAC register current fields */
+#define AFE4404_OFFDAC_CURR_LED1_MASK	GENMASK(8, 5)
+#define AFE4404_OFFDAC_CURR_LED1_SHIFT	5
+#define AFE4404_OFFDAC_CURR_LED2_MASK	GENMASK(18, 15)
+#define AFE4404_OFFDAC_CURR_LED2_SHIFT	15
+#define AFE4404_OFFDAC_CURR_LED3_MASK	GENMASK(3, 0)
+#define AFE4404_OFFDAC_CURR_LED3_SHIFT	0
+#define AFE4404_OFFDAC_CURR_AMB1_MASK	GENMASK(13, 10)
+#define AFE4404_OFFDAC_CURR_AMB1_SHIFT	10
+#define AFE4404_OFFDAC_CURR_AMB2_MASK	GENMASK(3, 0)
+#define AFE4404_OFFDAC_CURR_AMB2_SHIFT	0
+
+/* AFE4404 OFFDAC register polarity fields */
+#define AFE4404_OFFDAC_POL_LED1_MASK	BIT(9)
+#define AFE4404_OFFDAC_POL_LED1_SHIFT	9
+#define AFE4404_OFFDAC_POL_LED2_MASK	BIT(19)
+#define AFE4404_OFFDAC_POL_LED2_SHIFT	19
+#define AFE4404_OFFDAC_POL_LED3_MASK	BIT(4)
+#define AFE4404_OFFDAC_POL_LED3_SHIFT	4
+#define AFE4404_OFFDAC_POL_AMB1_MASK	BIT(14)
+#define AFE4404_OFFDAC_POL_AMB1_SHIFT	14
+#define AFE4404_OFFDAC_POL_AMB2_MASK	BIT(4)
+#define AFE4404_OFFDAC_POL_AMB2_SHIFT	4
+
+/* AFE4404 TIA_GAIN_CAP values */
+#define AFE4404_TIA_GAIN_CAP_5_P	0x0
+#define AFE4404_TIA_GAIN_CAP_2_5_P	0x1
+#define AFE4404_TIA_GAIN_CAP_10_P	0x2
+#define AFE4404_TIA_GAIN_CAP_7_5_P	0x3
+#define AFE4404_TIA_GAIN_CAP_20_P	0x4
+#define AFE4404_TIA_GAIN_CAP_17_5_P	0x5
+#define AFE4404_TIA_GAIN_CAP_25_P	0x6
+#define AFE4404_TIA_GAIN_CAP_22_5_P	0x7
+
+/* AFE4404 TIA_GAIN_RES values */
+#define AFE4404_TIA_GAIN_RES_500_K	0x0
+#define AFE4404_TIA_GAIN_RES_250_K	0x1
+#define AFE4404_TIA_GAIN_RES_100_K	0x2
+#define AFE4404_TIA_GAIN_RES_50_K	0x3
+#define AFE4404_TIA_GAIN_RES_25_K	0x4
+#define AFE4404_TIA_GAIN_RES_10_K	0x5
+#define AFE4404_TIA_GAIN_RES_1_M	0x6
+#define AFE4404_TIA_GAIN_RES_2_M	0x7
+
+enum afe4404_chan_id {
+	LED1VAL,
+	ALED1VAL,
+	LED2VAL,
+	ALED2VAL,
+	LED3VAL,
+	LED1_ALED1VAL,
+	LED2_ALED2VAL,
+	AVG_LED1_ALED1VAL,
+	AVG_LED2_ALED2VAL,
+};
+
+static const struct iio_chan_spec afe4404_channels[] = {
+	/* ADC values from the IC */
+	AFE440X_READ_CHAN(LED1VAL, "led1", AFE440X_LED1VAL),
+	AFE440X_READ_CHAN(ALED1VAL, "led1_ambient", AFE440X_ALED1VAL),
+	AFE440X_READ_CHAN(LED2VAL, "led2", AFE440X_LED2VAL),
+	AFE440X_READ_CHAN(ALED2VAL, "led2_ambient", AFE440X_ALED2VAL),
+	AFE440X_READ_CHAN(LED3VAL, "led3", AFE440X_ALED2VAL),
+	AFE440X_READ_CHAN(LED1_ALED1VAL, "led1-led1_ambient", AFE440X_LED1_ALED1VAL),
+	AFE440X_READ_CHAN(LED2_ALED2VAL, "led2-led2_ambient", AFE440X_LED2_ALED2VAL),
+	AFE440X_READ_CHAN(AVG_LED1_ALED1VAL, "led1-led1_ambient_mean", AFE4404_AVG_LED1_ALED1VAL),
+	AFE440X_READ_CHAN(AVG_LED2_ALED2VAL, "led2-led2_ambient_mean", AFE4404_AVG_LED2_ALED2VAL),
+};
+
+static ssize_t afe440x_show_register(struct device *dev,
+			      struct device_attribute *attr,
+			      char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct afe440x_data *afe440x = iio_device_get_drvdata(indio_dev);
+	struct afe440x_reg *afe440x_reg = to_afe440x_reg(attr);
+	int reg_val;
+	int ret;
+
+	ret = regmap_read(afe440x->regmap, afe440x_reg->reg, &reg_val);
+	if (ret)
+		return ret;
+
+	reg_val >>= afe440x_reg->shift;
+	reg_val &= afe440x_reg->mask;
+
+	return scnprintf(buf, PAGE_SIZE, "%u\n", reg_val);
+}
+
+static ssize_t afe440x_store_register(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf, size_t count)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct afe440x_data *afe440x = iio_device_get_drvdata(indio_dev);
+	struct afe440x_reg *afe440x_reg = to_afe440x_reg(attr);
+	unsigned val;
+	int reg_val;
+	int ret;
+
+	if (kstrtoint(buf, 0, &val))
+		return -EINVAL;
+
+	ret = regmap_read(afe440x->regmap, afe440x_reg->reg, &reg_val);
+	if (ret)
+		return ret;
+
+	reg_val &= ~afe440x_reg->mask;
+	reg_val |= ((val << afe440x_reg->shift) & afe440x_reg->mask);
+
+	ret = regmap_write(afe440x->regmap, afe440x_reg->reg, reg_val);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+AFE440X_ATTR(tia_separate_enable, AFE4404_TIA_GAIN_SEP, AFE440X_TIAGAIN_ENSEPGAIN);
+
+AFE440X_ATTR(out_resistance1_tia_raw, AFE4404_TIA_GAIN, AFE4404_TIA_GAIN_RES);
+AFE440X_ATTR(out_capacitance1_tia_raw, AFE4404_TIA_GAIN, AFE4404_TIA_GAIN_CAP);
+
+AFE440X_ATTR(out_resistance2_tia_raw, AFE4404_TIA_GAIN_SEP, AFE4404_TIA_GAIN_RES);
+AFE440X_ATTR(out_capacitance2_tia_raw, AFE4404_TIA_GAIN_SEP, AFE4404_TIA_GAIN_CAP);
+
+AFE440X_ATTR(out_current_offdac_led1_raw, AFE4404_OFFDAC, AFE4404_OFFDAC_CURR_LED1);
+AFE440X_ATTR(out_current_offdac_led2_raw, AFE4404_OFFDAC, AFE4404_OFFDAC_CURR_LED2);
+AFE440X_ATTR(out_current_offdac_led3_raw, AFE4404_OFFDAC, AFE4404_OFFDAC_CURR_LED3);
+
+AFE440X_ATTR(out_current_offdac_led1_ambient_raw, AFE4404_OFFDAC, AFE4404_OFFDAC_CURR_AMB1);
+AFE440X_ATTR(out_current_offdac_led2_ambient_raw, AFE4404_OFFDAC, AFE4404_OFFDAC_CURR_AMB2);
+
+AFE440X_ATTR(out_current_led1_raw, AFE440X_LEDCNTRL, AFE4404_LEDCNTRL_ILED1);
+AFE440X_ATTR(out_current_led2_raw, AFE440X_LEDCNTRL, AFE4404_LEDCNTRL_ILED2);
+AFE440X_ATTR(out_current_led3_raw, AFE440X_LEDCNTRL, AFE4404_LEDCNTRL_ILED3);
+
+static struct attribute *afe4404_attributes[] = {
+	&afe440x_reg_tia_separate_enable.dev_attr.attr,
+	&afe440x_reg_out_resistance1_tia_raw.dev_attr.attr,
+	&afe440x_reg_out_capacitance1_tia_raw.dev_attr.attr,
+	&afe440x_reg_out_resistance2_tia_raw.dev_attr.attr,
+	&afe440x_reg_out_capacitance2_tia_raw.dev_attr.attr,
+	&afe440x_reg_out_current_offdac_led1_raw.dev_attr.attr,
+	&afe440x_reg_out_current_offdac_led2_raw.dev_attr.attr,
+	&afe440x_reg_out_current_offdac_led3_raw.dev_attr.attr,
+	&afe440x_reg_out_current_offdac_led1_ambient_raw.dev_attr.attr,
+	&afe440x_reg_out_current_offdac_led2_ambient_raw.dev_attr.attr,
+	&afe440x_reg_out_current_led1_raw.dev_attr.attr,
+	&afe440x_reg_out_current_led2_raw.dev_attr.attr,
+	&afe440x_reg_out_current_led3_raw.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group afe4404_attribute_group = {
+	.attrs = afe4404_attributes
+};
+
+static int afe440x_read_raw(struct iio_dev *indio_dev,
+		     struct iio_chan_spec const *chan,
+		     int *val, int *val2, long mask)
+{
+	struct afe440x_data *afe440x = iio_device_get_drvdata(indio_dev);
+	int ret;
+
+	ret = regmap_read(afe440x->regmap, chan->address, val);
+	if (ret)
+		return ret;
+
+	*val2 = 0;
+
+	return IIO_VAL_INT;
+}
+
+static const struct iio_info afe4404_iio_info = {
+	.attrs	= &afe4404_attribute_group,
+	.read_raw = afe440x_read_raw,
+	.driver_module = THIS_MODULE,
+};
+
+static irqreturn_t afe440x_trigger_handler(int irq, void *private)
+{
+	struct iio_poll_func *pf = (struct iio_poll_func *)private;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct afe440x_data *afe440x = iio_device_get_drvdata(indio_dev);
+	int ret, bit, reg, i = 0;
+	s32 buffer[10];
+
+	for_each_set_bit(bit, indio_dev->active_scan_mask,
+			 indio_dev->masklength) {
+		reg = afe440x->channels[bit].address;
+		ret = regmap_read(afe440x->regmap, reg, &buffer[i++]);
+		if (ret)
+			goto err;
+	}
+
+	iio_push_to_buffers_with_timestamp(indio_dev, buffer, pf->timestamp);
+err:
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
+static const struct iio_trigger_ops afe440x_trigger_ops = {
+	.owner = THIS_MODULE,
+};
+
+/* Default timings from data-sheet */
+#define AFE4404_TIMING_PAIRS			\
+	{ AFE440X_PRPCOUNT,	39999	},	\
+	{ AFE440X_LED2LEDSTC,	0	},	\
+	{ AFE440X_LED2LEDENDC,	398	},	\
+	{ AFE440X_LED2STC,	80	},	\
+	{ AFE440X_LED2ENDC,	398	},	\
+	{ AFE440X_ADCRSTSTCT0,	5600	},	\
+	{ AFE440X_ADCRSTENDCT0,	5606	},	\
+	{ AFE440X_LED2CONVST,	5607	},	\
+	{ AFE440X_LED2CONVEND,	6066	},	\
+	{ AFE4404_LED3LEDSTC,	400	},	\
+	{ AFE4404_LED3LEDENDC,	798	},	\
+	{ AFE440X_ALED2STC,	480	},	\
+	{ AFE440X_ALED2ENDC,	798	},	\
+	{ AFE440X_ADCRSTSTCT1,	6068	},	\
+	{ AFE440X_ADCRSTENDCT1,	6074	},	\
+	{ AFE440X_ALED2CONVST,	6075	},	\
+	{ AFE440X_ALED2CONVEND,	6534	},	\
+	{ AFE440X_LED1LEDSTC,	800	},	\
+	{ AFE440X_LED1LEDENDC,	1198	},	\
+	{ AFE440X_LED1STC,	880	},	\
+	{ AFE440X_LED1ENDC,	1198	},	\
+	{ AFE440X_ADCRSTSTCT2,	6536	},	\
+	{ AFE440X_ADCRSTENDCT2,	6542	},	\
+	{ AFE440X_LED1CONVST,	6543	},	\
+	{ AFE440X_LED1CONVEND,	7003	},	\
+	{ AFE440X_ALED1STC,	1280	},	\
+	{ AFE440X_ALED1ENDC,	1598	},	\
+	{ AFE440X_ADCRSTSTCT3,	7005	},	\
+	{ AFE440X_ADCRSTENDCT3,	7011	},	\
+	{ AFE440X_ALED1CONVST,	7012	},	\
+	{ AFE440X_ALED1CONVEND,	7471	},	\
+	{ AFE440X_PDNCYCLESTC,	7671	},	\
+	{ AFE440X_PDNCYCLEENDC,	39199	}
+
+static const struct reg_sequence afe4404_reg_sequences[] = {
+	AFE4404_TIMING_PAIRS,
+	{ AFE440X_CONTROL1, AFE440X_CONTROL1_TIMEREN },
+	{ AFE4404_TIA_GAIN, AFE4404_TIA_GAIN_RES_50_K },
+	{ AFE440X_LEDCNTRL, (0xf << AFE4404_LEDCNTRL_ILED1_SHIFT) |
+			    (0x3 << AFE4404_LEDCNTRL_ILED2_SHIFT) |
+			    (0x3 << AFE4404_LEDCNTRL_ILED3_SHIFT) },
+	{ AFE440X_CONTROL2, AFE440X_CONTROL3_OSC_ENABLE	},
+};
+
+static const struct regmap_range afe4404_yes_ranges[] = {
+	regmap_reg_range(AFE440X_LED2VAL, AFE440X_LED1_ALED1VAL),
+	regmap_reg_range(AFE4404_AVG_LED2_ALED2VAL, AFE4404_AVG_LED1_ALED1VAL),
+};
+
+static const struct regmap_access_table afe4404_volatile_table = {
+	.yes_ranges = afe4404_yes_ranges,
+	.n_yes_ranges = ARRAY_SIZE(afe4404_yes_ranges),
+};
+
+static const struct regmap_config afe4404_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 24,
+
+	.max_register = AFE4404_AVG_LED1_ALED1VAL,
+	.cache_type = REGCACHE_RBTREE,
+	.volatile_table = &afe4404_volatile_table,
+};
+
+#ifdef CONFIG_OF
+static const struct of_device_id afe4404_of_match[] = {
+	{ .compatible = "ti,afe4404", },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, afe4404_of_match);
+#endif
+
+static int afe440x_suspend(struct device *dev)
+{
+	struct afe440x_data *afe440x = dev_get_drvdata(dev);
+	int ret;
+
+	ret = regmap_update_bits(afe440x->regmap, AFE440X_CONTROL2,
+				 AFE440X_CONTROL2_PDN_AFE,
+				 AFE440X_CONTROL2_PDN_AFE);
+	if (ret)
+		return ret;
+
+	ret = regulator_disable(afe440x->regulator);
+	if (ret) {
+		dev_err(dev, "Failed to disable regulator\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int afe440x_resume(struct device *dev)
+{
+	struct afe440x_data *afe440x = dev_get_drvdata(dev);
+	int ret;
+
+	ret = regmap_update_bits(afe440x->regmap, AFE440X_CONTROL2,
+				 AFE440X_CONTROL2_PDN_AFE, 0);
+	if (ret)
+		return ret;
+
+	ret = regulator_enable(afe440x->regulator);
+	if (ret) {
+		dev_err(dev, "Failed to enable regulator\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+SIMPLE_DEV_PM_OPS(afe440x_pm_ops, afe440x_suspend, afe440x_resume);
+
+static int afe440x_iio_setup(struct afe440x_data *afe440x)
+{
+	struct iio_dev *indio_dev;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(afe440x->dev, 0);
+	if (indio_dev == NULL) {
+		dev_err(afe440x->dev, "Unable to allocate IIO device\n");
+		return -ENOMEM;
+	}
+
+	iio_device_set_drvdata(indio_dev, afe440x);
+
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->dev.parent = afe440x->dev;
+	indio_dev->channels = afe440x->channels;
+	indio_dev->num_channels = afe440x->num_channels;
+	indio_dev->name = afe440x->name;
+	indio_dev->info = afe440x->info;
+
+	if (afe440x->irq > 0) {
+		afe440x->trig = devm_iio_trigger_alloc(afe440x->dev, "%s-dev%d",
+						       indio_dev->name,
+						       indio_dev->id);
+		if (afe440x->trig == NULL) {
+			dev_err(afe440x->dev, "Unable to allocate IIO trigger\n");
+			return -ENOMEM;
+		}
+
+		iio_trigger_set_drvdata(afe440x->trig, indio_dev);
+
+		afe440x->trig->ops = &afe440x_trigger_ops;
+		afe440x->trig->dev.parent = afe440x->dev;
+
+		ret = iio_trigger_register(afe440x->trig);
+		if (ret) {
+			dev_err(afe440x->dev, "Unable to register IIO trigger\n");
+			return ret;
+		}
+
+		ret = devm_request_threaded_irq(afe440x->dev, afe440x->irq,
+						iio_trigger_generic_data_rdy_poll,
+						NULL, IRQF_ONESHOT,
+						"afe4404", afe440x->trig);
+		if (ret) {
+			dev_err(afe440x->dev, "Unable to request IRQ\n");
+			return ret;
+		}
+	}
+
+	ret = iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
+					 &afe440x_trigger_handler, NULL);
+	if (ret) {
+		dev_err(afe440x->dev, "Unable to setup buffer\n");
+		return ret;
+	}
+
+	ret = devm_iio_device_register(afe440x->dev, indio_dev);
+	if (ret) {
+		dev_err(afe440x->dev, "Unable to register IIO device\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int afe4404_probe(struct i2c_client *client,
+			const struct i2c_device_id *id)
+{
+	struct afe440x_data *afe440x;
+	int ret;
+
+	afe440x = devm_kzalloc(&client->dev, sizeof(*afe440x), GFP_KERNEL);
+	if (!afe440x)
+		return -ENOMEM;
+
+	i2c_set_clientdata(client, afe440x);
+
+	afe440x->dev = &client->dev;
+	afe440x->irq = client->irq;
+
+	afe440x->regmap = devm_regmap_init_i2c(client, &afe4404_regmap_config);
+	if (IS_ERR(afe440x->regmap)) {
+		dev_err(afe440x->dev, "Unable to allocate register map\n");
+		return PTR_ERR(afe440x->regmap);
+	}
+
+	afe440x->regulator = devm_regulator_get(afe440x->dev, "led");
+	if (IS_ERR(afe440x->regulator)) {
+		dev_err(afe440x->dev, "Unable to get regulator\n");
+		return PTR_ERR(afe440x->regulator);
+	}
+
+	ret = regmap_write(afe440x->regmap, AFE440X_CONTROL0,
+			   AFE440X_CONTROL0_SW_RESET);
+	if (ret) {
+		dev_err(afe440x->dev, "Unable to reset device\n");
+		return ret;
+	}
+
+	ret = regmap_register_patch(afe440x->regmap, afe4404_reg_sequences,
+				    ARRAY_SIZE(afe4404_reg_sequences));
+	if (ret) {
+		dev_err(afe440x->dev, "Unable to set register defaults\n");
+		return ret;
+	}
+
+	afe440x->channels = afe4404_channels;
+	afe440x->num_channels = ARRAY_SIZE(afe4404_channels);
+	afe440x->name = AFE4404_DRIVER_NAME;
+	afe440x->info = &afe4404_iio_info;
+
+	return afe440x_iio_setup(afe440x);
+}
+
+static const struct i2c_device_id afe4404_ids[] = {
+	{ "afe4404", 0 },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(i2c, afe4404_ids);
+
+static struct i2c_driver afe4404_i2c_driver = {
+	.driver = {
+		.name = AFE4404_DRIVER_NAME,
+		.of_match_table = of_match_ptr(afe4404_of_match),
+		.pm = &afe440x_pm_ops,
+	},
+	.probe = afe4404_probe,
+	.id_table = afe4404_ids,
+};
+module_i2c_driver(afe4404_i2c_driver);
+
+MODULE_AUTHOR("Andrew F. Davis <afd@ti.com>");
+MODULE_DESCRIPTION("TI AFE4404 Heart Rate and Pulse Oximeter");
+MODULE_LICENSE("GPL");
diff --git a/drivers/iio/health/afe440x.h b/drivers/iio/health/afe440x.h
new file mode 100644
index 0000000..2d98a20
--- /dev/null
+++ b/drivers/iio/health/afe440x.h
@@ -0,0 +1,159 @@
+/*
+ * AFE440X Heart Rate Monitors and Low-Cost Pulse Oximeters
+ *
+ * Author: Andrew F. Davis <afd@ti.com>
+ *
+ * Copyright: (C) 2015 Texas Instruments, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ */
+
+#ifndef _AFE440X_H
+#define _AFE440X_H
+
+/* AFE440X registers */
+#define AFE440X_CONTROL0		0x00
+#define AFE440X_LED2STC			0x01
+#define AFE440X_LED2ENDC		0x02
+#define AFE440X_LED1LEDSTC		0x03
+#define AFE440X_LED1LEDENDC		0x04
+#define AFE440X_ALED2STC		0x05
+#define AFE440X_ALED2ENDC		0x06
+#define AFE440X_LED1STC			0x07
+#define AFE440X_LED1ENDC		0x08
+#define AFE440X_LED2LEDSTC		0x09
+#define AFE440X_LED2LEDENDC		0x0a
+#define AFE440X_ALED1STC		0x0b
+#define AFE440X_ALED1ENDC		0x0c
+#define AFE440X_LED2CONVST		0x0d
+#define AFE440X_LED2CONVEND		0x0e
+#define AFE440X_ALED2CONVST		0x0f
+#define AFE440X_ALED2CONVEND		0x10
+#define AFE440X_LED1CONVST		0x11
+#define AFE440X_LED1CONVEND		0x12
+#define AFE440X_ALED1CONVST		0x13
+#define AFE440X_ALED1CONVEND		0x14
+#define AFE440X_ADCRSTSTCT0		0x15
+#define AFE440X_ADCRSTENDCT0		0x16
+#define AFE440X_ADCRSTSTCT1		0x17
+#define AFE440X_ADCRSTENDCT1		0x18
+#define AFE440X_ADCRSTSTCT2		0x19
+#define AFE440X_ADCRSTENDCT2		0x1a
+#define AFE440X_ADCRSTSTCT3		0x1b
+#define AFE440X_ADCRSTENDCT3		0x1c
+#define AFE440X_PRPCOUNT		0x1d
+#define AFE440X_CONTROL1		0x1e
+#define AFE440X_TIAGAIN			0x20
+#define AFE440X_TIA_AMB_GAIN		0x21
+#define AFE440X_LEDCNTRL		0x22
+#define AFE440X_CONTROL2		0x23
+#define AFE440X_ALARM			0x29
+#define AFE440X_LED2VAL			0x2a
+#define AFE440X_ALED2VAL		0x2b
+#define AFE440X_LED1VAL			0x2c
+#define AFE440X_ALED1VAL		0x2d
+#define AFE440X_LED2_ALED2VAL		0x2e
+#define AFE440X_LED1_ALED1VAL		0x2f
+#define AFE440X_CONTROL3		0x31
+#define AFE440X_PDNCYCLESTC		0x32
+#define AFE440X_PDNCYCLEENDC		0x33
+
+/* CONTROL0 register fields */
+#define AFE440X_CONTROL0_REG_READ	BIT(0)
+#define AFE440X_CONTROL0_TM_COUNT_RST	BIT(1)
+#define AFE440X_CONTROL0_SW_RESET	BIT(3)
+
+/* CONTROL1 register fields */
+#define AFE440X_CONTROL1_TIMEREN	BIT(8)
+
+/* TIAGAIN register fields */
+#define AFE440X_TIAGAIN_ENSEPGAIN_MASK	BIT(15)
+#define AFE440X_TIAGAIN_ENSEPGAIN_SHIFT	15
+
+/* CONTROL2 register fields */
+#define AFE440X_CONTROL2_PDN_AFE	BIT(0)
+#define AFE440X_CONTROL2_PDN_RX		BIT(1)
+#define AFE440X_CONTROL2_DYNAMIC4	BIT(3)
+#define AFE440X_CONTROL2_DYNAMIC3	BIT(4)
+#define AFE440X_CONTROL2_DYNAMIC2	BIT(14)
+#define AFE440X_CONTROL2_DYNAMIC1	BIT(20)
+
+/* CONTROL3 register fields */
+#define AFE440X_CONTROL3_CLKDIV		GENMASK(2, 0)
+
+/* CONTROL0 values */
+#define AFE440X_CONTROL0_WRITE		0x0
+#define AFE440X_CONTROL0_READ		0x1
+
+#define AFE440X_READ_CHAN(_index, _name, _address)		\
+	{							\
+		.type = IIO_INTENSITY,				\
+		.channel = _index,				\
+		.address = _address,				\
+		.scan_index = _index,				\
+		.scan_type = {					\
+				.sign = 's',			\
+				.realbits = 24,			\
+				.storagebits = 32,		\
+				.endianness = IIO_CPU,		\
+		},						\
+		.extend_name = _name,				\
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
+	}
+
+struct afe440x_reg {
+	struct device_attribute dev_attr;
+	u8 reg;
+	unsigned long shift;
+	unsigned long mask;
+};
+
+#define to_afe440x_reg(_dev_attr)				\
+	container_of(_dev_attr, struct afe440x_reg, dev_attr)
+
+#define AFE440X_ATTR(_name, _reg, _field)			\
+	struct afe440x_reg afe440x_reg_##_name = {		\
+		.dev_attr = __ATTR(_name, (S_IRUGO | S_IWUSR),	\
+				   afe440x_show_register,	\
+				   afe440x_store_register),	\
+		.reg = _reg,					\
+		.shift = _field ## _SHIFT,			\
+		.mask = _field ## _MASK,			\
+	}
+
+/**
+ * struct afe440x_data
+ * @dev - Device structure
+ * @name - Device name
+ * @spi - SPI device pointer the driver is attached to
+ * @iolock - Read/Write mutex
+ * @regmap - Register map of the device
+ * @regulator - Pointer to the regulator for the IC
+ * @channels - IIO channels
+ * @num_channels - Number of IIO channels
+ * @info - IIO info for device
+ * @trig - IIO trigger for this device
+ * @irq - ADC_RDY line interrupt number
+**/
+struct afe440x_data {
+	struct device *dev;
+	const char *name;
+	struct spi_device *spi;
+	struct mutex iolock;
+	struct regmap *regmap;
+	struct regulator *regulator;
+	struct iio_chan_spec const *channels;
+	int num_channels;
+	const struct iio_info *info;
+	struct iio_trigger *trig;
+	int irq;
+};
+
+#endif /* _AFE440X_H */
-- 
1.9.1
