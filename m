Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:63151 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933814AbdDFQNF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 6 Apr 2017 12:13:05 -0400
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <jic23@kernel.org>, <linux@armlinux.org.uk>, <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linux-iio@vger.kernel.org>, <mark.rutland@arm.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <fabrice.gasnier@st.com>, <benjamin.gaignard@linaro.org>,
        <benjamin.gaignard@st.com>
Subject: [PATCH v2 5/5] iio: dac: stm32: add support for waveform generator
Date: Thu, 6 Apr 2017 18:11:56 +0200
Message-ID: <1491495116-7209-6-git-send-email-fabrice.gasnier@st.com>
In-Reply-To: <1491495116-7209-1-git-send-email-fabrice.gasnier@st.com>
References: <1491495116-7209-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

STM32 DAC has built-in noise or triangle waveform generator.
- "wavetype" extended attribute selects noise or triangle.
- "amplitude" extended attribute selects amplitude for waveform generator

A DC offset can be added to waveform generator output. This can be done
using out_voltage[1/2]_offset

Waveform generator requires a trigger to be configured, to increment /
decrement internal counter in case of triangle generator. Noise
generator is a bit different,  but also requires a trigger to generate
samples.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
Changes in v2:
- use _offset parameter to add DC offset to waveform generator
- Rework ABI to better fit existing DDS ABI: use out_voltageY_wavetype,
  out_voltage_wavetype_available, out_voltageY_amplitude,
  out_voltage_amplitude_available
- Better explain trigger usage in case of waveform generator.
---
 Documentation/ABI/testing/sysfs-bus-iio-dac-stm32 |  16 +++
 drivers/iio/dac/stm32-dac-core.h                  |   4 +
 drivers/iio/dac/stm32-dac.c                       | 158 +++++++++++++++++++++-
 3 files changed, 177 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-dac-stm32

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-dac-stm32 b/Documentation/ABI/testing/sysfs-bus-iio-dac-stm32
new file mode 100644
index 0000000..8f1fa009
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-dac-stm32
@@ -0,0 +1,16 @@
+What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_wavetype
+What:		/sys/bus/iio/devices/iio:deviceX/out_voltage_wavetype_available
+KernelVersion:	4.12
+Contact:	fabrice.gasnier@st.com
+Description:
+		List and/or select waveform generation provided by STM32 DAC:
+		- "flat": waveform generator disabled (default)
+		- "noise": select noise waveform
+		- "triangle": select triangle waveform
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_amplitude
+What:		/sys/bus/iio/devices/iio:deviceX/out_voltage_amplitude_available
+KernelVersion:	4.12
+Contact:	fabrice.gasnier@st.com
+Description:
+		List and/or select amplitude used for waveform generator
diff --git a/drivers/iio/dac/stm32-dac-core.h b/drivers/iio/dac/stm32-dac-core.h
index e51a468..0f02975 100644
--- a/drivers/iio/dac/stm32-dac-core.h
+++ b/drivers/iio/dac/stm32-dac-core.h
@@ -37,8 +37,12 @@
 #define STM32H7_DAC_CR_TEN1		BIT(1)
 #define STM32H7_DAC_CR_TSEL1_SHIFT	2
 #define STM32H7_DAC_CR_TSEL1		GENMASK(5, 2)
+#define STM32_DAC_CR_WAVE1		GENMASK(7, 6)
+#define STM32_DAC_CR_MAMP1		GENMASK(11, 8)
 #define STM32H7_DAC_CR_HFSEL		BIT(15)
 #define STM32_DAC_CR_EN2		BIT(16)
+#define STM32_DAC_CR_WAVE2		GENMASK(23, 22)
+#define STM32_DAC_CR_MAMP2		GENMASK(27, 24)
 
 /* STM32_DAC_SWTRIGR bit fields */
 #define STM32_DAC_SWTRIGR_SWTRIG1	BIT(0)
diff --git a/drivers/iio/dac/stm32-dac.c b/drivers/iio/dac/stm32-dac.c
index a7a078e..2ed75db 100644
--- a/drivers/iio/dac/stm32-dac.c
+++ b/drivers/iio/dac/stm32-dac.c
@@ -42,10 +42,12 @@
 /**
  * struct stm32_dac - private data of DAC driver
  * @common:		reference to DAC common data
+ * @wavetype:		waveform generator
  * @swtrig:		Using software trigger
  */
 struct stm32_dac {
 	struct stm32_dac_common *common;
+	u32 wavetype;
 	bool swtrig;
 };
 
@@ -222,6 +224,29 @@ static int stm32_dac_set_value(struct stm32_dac *dac, int channel, int val)
 	return ret;
 }
 
+static int stm32_dac_get_offset(struct stm32_dac *dac, int channel, int *val)
+{
+	int ret;
+
+	/* Offset is only relevant in waveform generation mode. */
+	if (!dac->wavetype) {
+		*val = 0;
+		return IIO_VAL_INT;
+	}
+
+	/*
+	 * In waveform generation mode, DC offset in DHR is added to waveform
+	 * generator output, then stored to DOR (data output register).
+	 * Read offset from DHR.
+	 */
+	if (STM32_DAC_IS_CHAN_1(channel))
+		ret = regmap_read(dac->common->regmap, STM32_DAC_DHR12R1, val);
+	else
+		ret = regmap_read(dac->common->regmap, STM32_DAC_DHR12R2, val);
+
+	return ret ? ret : IIO_VAL_INT;
+}
+
 static int stm32_dac_read_raw(struct iio_dev *indio_dev,
 			      struct iio_chan_spec const *chan,
 			      int *val, int *val2, long mask)
@@ -231,6 +256,8 @@ static int stm32_dac_read_raw(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 		return stm32_dac_get_value(dac, chan->channel, val);
+	case IIO_CHAN_INFO_OFFSET:
+		return stm32_dac_get_offset(dac, chan->channel, val);
 	case IIO_CHAN_INFO_SCALE:
 		*val = dac->common->vref_mv;
 		*val2 = chan->scan_type.realbits;
@@ -247,8 +274,16 @@ static int stm32_dac_write_raw(struct iio_dev *indio_dev,
 	struct stm32_dac *dac = iio_priv(indio_dev);
 
 	switch (mask) {
+	case IIO_CHAN_INFO_OFFSET:
+		/* Offset only makes sense in waveform generation mode */
+		if (dac->wavetype)
+			return stm32_dac_set_value(dac, chan->channel, val);
+		return -EBUSY;
 	case IIO_CHAN_INFO_RAW:
-		return stm32_dac_set_value(dac, chan->channel, val);
+		if (!dac->wavetype)
+			return stm32_dac_set_value(dac, chan->channel, val);
+		/* raw value is read only in waveform generation mode */
+		return -EBUSY;
 	default:
 		return -EINVAL;
 	}
@@ -334,6 +369,122 @@ static ssize_t stm32_dac_write_powerdown(struct iio_dev *indio_dev,
 	.set = stm32_dac_set_powerdown_mode,
 };
 
+/* waveform generator wave selection */
+static const char * const stm32_dac_wavetype_desc[] = {
+	"flat",
+	"noise",
+	"triangle",
+};
+
+static int stm32_dac_set_wavetype(struct iio_dev *indio_dev,
+				  const struct iio_chan_spec *chan,
+				  unsigned int wavetype)
+{
+	struct stm32_dac *dac = iio_priv(indio_dev);
+	u32 mask, val;
+	int ret;
+
+	/*
+	 * Waveform generator requires a trigger to be configured, to increment
+	 * or decrement internal counter in case of triangle generator. Noise
+	 * generator is a bit different, but also requires a trigger to
+	 * generate samples.
+	 */
+	if (wavetype && !indio_dev->trig)
+		dev_dbg(&indio_dev->dev, "Wavegen requires a trigger\n");
+
+	if (STM32_DAC_IS_CHAN_1(chan->channel)) {
+		val = FIELD_PREP(STM32_DAC_CR_WAVE1, wavetype);
+		mask = STM32_DAC_CR_WAVE1;
+	} else {
+		val = FIELD_PREP(STM32_DAC_CR_WAVE2, wavetype);
+		mask = STM32_DAC_CR_WAVE2;
+	}
+
+	ret = regmap_update_bits(dac->common->regmap, STM32_DAC_CR, mask, val);
+	if (ret)
+		return ret;
+	dac->wavetype = wavetype;
+
+	return 0;
+}
+
+static int stm32_dac_get_wavetype(struct iio_dev *indio_dev,
+				  const struct iio_chan_spec *chan)
+{
+	struct stm32_dac *dac = iio_priv(indio_dev);
+	u32 val;
+	int ret;
+
+	ret = regmap_read(dac->common->regmap, STM32_DAC_CR, &val);
+	if (ret < 0)
+		return ret;
+
+	if (STM32_DAC_IS_CHAN_1(chan->channel))
+		return FIELD_GET(STM32_DAC_CR_WAVE1, val);
+	else
+		return FIELD_GET(STM32_DAC_CR_WAVE2, val);
+}
+
+static const struct iio_enum stm32_dac_wavetype_enum = {
+	.items = stm32_dac_wavetype_desc,
+	.num_items = ARRAY_SIZE(stm32_dac_wavetype_desc),
+	.get = stm32_dac_get_wavetype,
+	.set = stm32_dac_set_wavetype,
+};
+
+/*
+ * waveform generator mamp selection: mask/amplitude
+ * - noise: LFSR mask (linear feedback shift register, umasks bit 0, [1:0]...)
+ * - triangle: amplitude (equal to 1, 3, 5, 7... 4095)
+ */
+static const char * const stm32_dac_amplitude_desc[] = {
+	"1", "3", "7", "15", "31", "63", "127", "255", "511", "1023", "2047",
+	"4095",
+};
+
+static int stm32_dac_set_amplitude(struct iio_dev *indio_dev,
+				   const struct iio_chan_spec *chan,
+				   unsigned int amplitude)
+{
+	struct stm32_dac *dac = iio_priv(indio_dev);
+	u32 mask, val;
+
+	if (STM32_DAC_IS_CHAN_1(chan->channel)) {
+		val = FIELD_PREP(STM32_DAC_CR_MAMP1, amplitude);
+		mask = STM32_DAC_CR_MAMP1;
+	} else {
+		val = FIELD_PREP(STM32_DAC_CR_MAMP2, amplitude);
+		mask = STM32_DAC_CR_MAMP2;
+	}
+
+	return regmap_update_bits(dac->common->regmap, STM32_DAC_CR, mask, val);
+}
+
+static int stm32_dac_get_amplitude(struct iio_dev *indio_dev,
+				   const struct iio_chan_spec *chan)
+{
+	struct stm32_dac *dac = iio_priv(indio_dev);
+	u32 val;
+	int ret;
+
+	ret = regmap_read(dac->common->regmap, STM32_DAC_CR, &val);
+	if (ret < 0)
+		return ret;
+
+	if (STM32_DAC_IS_CHAN_1(chan->channel))
+		return FIELD_GET(STM32_DAC_CR_MAMP1, val);
+	else
+		return FIELD_GET(STM32_DAC_CR_MAMP2, val);
+}
+
+static const struct iio_enum stm32_dac_amplitude_enum = {
+	.items = stm32_dac_amplitude_desc,
+	.num_items = ARRAY_SIZE(stm32_dac_amplitude_desc),
+	.get = stm32_dac_get_amplitude,
+	.set = stm32_dac_set_amplitude,
+};
+
 static const struct iio_chan_spec_ext_info stm32_dac_ext_info[] = {
 	{
 		.name = "powerdown",
@@ -343,6 +494,10 @@ static ssize_t stm32_dac_write_powerdown(struct iio_dev *indio_dev,
 	},
 	IIO_ENUM("powerdown_mode", IIO_SEPARATE, &stm32_dac_powerdown_mode_en),
 	IIO_ENUM_AVAILABLE("powerdown_mode", &stm32_dac_powerdown_mode_en),
+	IIO_ENUM("wavetype", IIO_SEPARATE, &stm32_dac_wavetype_enum),
+	IIO_ENUM_AVAILABLE("wavetype", &stm32_dac_wavetype_enum),
+	IIO_ENUM("amplitude", IIO_SEPARATE, &stm32_dac_amplitude_enum),
+	IIO_ENUM_AVAILABLE("amplitude", &stm32_dac_amplitude_enum),
 	{},
 };
 
@@ -352,6 +507,7 @@ static ssize_t stm32_dac_write_powerdown(struct iio_dev *indio_dev,
 	.output = 1,					\
 	.channel = chan,				\
 	.info_mask_separate =				\
+		BIT(IIO_CHAN_INFO_OFFSET) |		\
 		BIT(IIO_CHAN_INFO_RAW) |		\
 		BIT(IIO_CHAN_INFO_SCALE),		\
 	/* scan_index is always 0 as num_channels is 1 */ \
-- 
1.9.1

