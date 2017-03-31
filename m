Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:60439 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933015AbdCaLqe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 31 Mar 2017 07:46:34 -0400
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <jic23@kernel.org>, <linux@armlinux.org.uk>, <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linux-iio@vger.kernel.org>, <mark.rutland@arm.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <fabrice.gasnier@st.com>, <benjamin.gaignard@linaro.org>,
        <benjamin.gaignard@st.com>, <linus.walleij@linaro.org>,
        <amelie.delaunay@st.com>
Subject: [PATCH 4/4] iio: dac: stm32: add support for waveform generator
Date: Fri, 31 Mar 2017 13:45:07 +0200
Message-ID: <1490960707-22422-5-git-send-email-fabrice.gasnier@st.com>
In-Reply-To: <1490960707-22422-1-git-send-email-fabrice.gasnier@st.com>
References: <1490960707-22422-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

STM32 DAC has built-in noise or triangle waveform generator.
Waveform generator requires trigger to be configured.
- "wave" extended attribute selects noise or triangle.
- "mamp" extended attribute selects either LFSR (linear feedback
  shift register) mask for noise waveform, OR triangle amplitude.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 Documentation/ABI/testing/sysfs-bus-iio-dac-stm32 |  32 ++++++
 drivers/iio/dac/stm32-dac.c                       | 124 ++++++++++++++++++++++
 2 files changed, 156 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-dac-stm32

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-dac-stm32 b/Documentation/ABI/testing/sysfs-bus-iio-dac-stm32
new file mode 100644
index 0000000..c2432e1
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-dac-stm32
@@ -0,0 +1,32 @@
+What:		/sys/bus/iio/devices/iio:deviceX/wave
+What:		/sys/bus/iio/devices/iio:deviceX/wave_available
+KernelVersion:	4.12
+Contact:	fabrice.gasnier@st.com
+Description:
+		List and/or select waveform generation provided by STM32 DAC:
+		- "none": (default) means normal DAC operations
+		- "noise": select noise waveform
+		- "triangle": select triangle waveform
+		Note: when waveform generator is used, writing _raw sysfs entry
+		adds a DC offset to generated waveform. Reading it reports
+		current output value.
+
+What:		/sys/bus/iio/devices/iio:deviceX/mamp
+What:		/sys/bus/iio/devices/iio:deviceX/mamp_available
+KernelVersion:	4.12
+Contact:	fabrice.gasnier@st.com
+Description:
+		List and select mask/amplitude used for noise/triangle waveform
+		generator, which are:
+		- "0": unmask bit 0 of LFSR / triangle amplitude equal to 1
+		- "1": unmask bit [1:0] of LFSR / triangle amplitude equal to 3
+		- "2": unmask bit [2:0] of LFSR / triangle amplitude equal to 7
+		- "3": unmask bit [3:0] of LFSR / triangle amplitude equal to 15
+		- "4": unmask bit [4:0] of LFSR / triangle amplitude equal to 31
+		- "5": unmask bit [5:0] of LFSR / triangle amplitude equal to 63
+		- "6": unmask bit [6:0] of LFSR / triangle amplitude equal to 127
+		- "7": unmask bit [7:0] of LFSR / triangle amplitude equal to 255
+		- "8": unmask bit [8:0] of LFSR / triangle amplitude equal to 511
+		- "9": unmask bit [9:0] of LFSR / triangle amplitude equal to 1023
+		- "10": unmask bit [10:0] of LFSR / triangle amplitude equal to 2047
+		- "11": unmask bit [11:0] of LFSR / triangle amplitude equal to 4095
diff --git a/drivers/iio/dac/stm32-dac.c b/drivers/iio/dac/stm32-dac.c
index 62e43e9..d7dda78 100644
--- a/drivers/iio/dac/stm32-dac.c
+++ b/drivers/iio/dac/stm32-dac.c
@@ -41,10 +41,14 @@
 /**
  * struct stm32_dac - private data of DAC driver
  * @common:		reference to DAC common data
+ * @wave:		waveform generator
+ * @mamp:		waveform mask/amplitude
  * @swtrig:		Using software trigger
  */
 struct stm32_dac {
 	struct stm32_dac_common *common;
+	u32 wave;
+	u32 mamp;
 	bool swtrig;
 };
 
@@ -157,6 +161,24 @@ static int stm32_dac_is_enabled(struct stm32_dac *dac, int channel)
 	return !!en;
 }
 
+static int stm32_dac_wavegen(struct stm32_dac *dac, int channel)
+{
+	struct regmap *regmap = dac->common->regmap;
+	u32 mask, val;
+
+	if (channel == STM32_DAC_CHANNEL_1) {
+		val = FIELD_PREP(STM32_DAC_CR_WAVE1, dac->wave) |
+			FIELD_PREP(STM32_DAC_CR_MAMP1, dac->mamp);
+		mask = STM32_DAC_CR_WAVE1 | STM32_DAC_CR_MAMP1;
+	} else {
+		val = FIELD_PREP(STM32_DAC_CR_WAVE2, dac->wave) |
+			FIELD_PREP(STM32_DAC_CR_MAMP2, dac->mamp);
+		mask = STM32_DAC_CR_WAVE2 | STM32_DAC_CR_MAMP2;
+	}
+
+	return regmap_update_bits(regmap, STM32_DAC_CR, mask, val);
+}
+
 static int stm32_dac_enable(struct iio_dev *indio_dev, int channel)
 {
 	struct stm32_dac *dac = iio_priv(indio_dev);
@@ -164,6 +186,17 @@ static int stm32_dac_enable(struct iio_dev *indio_dev, int channel)
 		STM32_DAC_CR_EN1 : STM32_DAC_CR_EN2;
 	int ret;
 
+	if (dac->wave && !indio_dev->trig) {
+		dev_err(&indio_dev->dev, "Wavegen requires a trigger\n");
+		return -EINVAL;
+	}
+
+	ret = stm32_dac_wavegen(dac, channel);
+	if (ret < 0) {
+		dev_err(&indio_dev->dev, "Wavegen setup failed\n");
+		return ret;
+	}
+
 	ret = stm32_dac_set_trig(dac, indio_dev->trig, channel);
 	if (ret < 0) {
 		dev_err(&indio_dev->dev, "Trigger setup failed\n");
@@ -291,6 +324,96 @@ static int stm32_dac_debugfs_reg_access(struct iio_dev *indio_dev,
 	.driver_module = THIS_MODULE,
 };
 
+/* waveform generator wave selection */
+static const char * const stm32_dac_wave_desc[] = {
+	"none",
+	"noise",
+	"triangle",
+};
+
+static int stm32_dac_set_wave(struct iio_dev *indio_dev,
+			      const struct iio_chan_spec *chan,
+			      unsigned int type)
+{
+	struct stm32_dac *dac = iio_priv(indio_dev);
+
+	if (stm32_dac_is_enabled(dac, chan->channel))
+		return -EBUSY;
+	dac->wave = type;
+
+	return 0;
+}
+
+static int stm32_dac_get_wave(struct iio_dev *indio_dev,
+			      const struct iio_chan_spec *chan)
+{
+	struct stm32_dac *dac = iio_priv(indio_dev);
+
+	return dac->wave;
+}
+
+static const struct iio_enum stm32_dac_wave_enum = {
+	.items = stm32_dac_wave_desc,
+	.num_items = ARRAY_SIZE(stm32_dac_wave_desc),
+	.get = stm32_dac_get_wave,
+	.set = stm32_dac_set_wave,
+};
+
+/*
+ * waveform generator mask/amplitude selection:
+ * - noise: LFSR mask (linear feedback shift register, umasks bit 0, [1:0]...)
+ * - triangle: amplitude (equal to 1, 3, 5, 7... 4095)
+ */
+static const char * const stm32_dac_mamp_desc[] = {
+	"0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11",
+};
+
+static int stm32_dac_set_mamp(struct iio_dev *indio_dev,
+			      const struct iio_chan_spec *chan,
+			      unsigned int type)
+{
+	struct stm32_dac *dac = iio_priv(indio_dev);
+
+	if (stm32_dac_is_enabled(dac, chan->channel))
+		return -EBUSY;
+	dac->mamp = type;
+
+	return 0;
+}
+
+static int  stm32_dac_get_mamp(struct iio_dev *indio_dev,
+			       const struct iio_chan_spec *chan)
+{
+	struct stm32_dac *dac = iio_priv(indio_dev);
+
+	return dac->mamp;
+}
+
+static const struct iio_enum stm32_dac_mamp_enum = {
+	.items = stm32_dac_mamp_desc,
+	.num_items = ARRAY_SIZE(stm32_dac_mamp_desc),
+	.get = stm32_dac_get_mamp,
+	.set = stm32_dac_set_mamp,
+};
+
+static const struct iio_chan_spec_ext_info stm32_dac_ext_info[] = {
+	IIO_ENUM("wave", IIO_SHARED_BY_ALL, &stm32_dac_wave_enum),
+	{
+		.name = "wave_available",
+		.shared = IIO_SHARED_BY_ALL,
+		.read = iio_enum_available_read,
+		.private = (uintptr_t)&stm32_dac_wave_enum,
+	},
+	IIO_ENUM("mamp", IIO_SHARED_BY_ALL, &stm32_dac_mamp_enum),
+	{
+		.name = "mamp_available",
+		.shared = IIO_SHARED_BY_ALL,
+		.read = iio_enum_available_read,
+		.private = (uintptr_t)&stm32_dac_mamp_enum,
+	},
+	{},
+};
+
 #define STM32_DAC_CHANNEL(chan, name) {		\
 	.type = IIO_VOLTAGE,			\
 	.indexed = 1,				\
@@ -306,6 +429,7 @@ static int stm32_dac_debugfs_reg_access(struct iio_dev *indio_dev,
 		.storagebits = 16,		\
 	},					\
 	.datasheet_name = name,			\
+	.ext_info = stm32_dac_ext_info		\
 }
 
 static const struct iio_chan_spec stm32_dac_channels[] = {
-- 
1.9.1

