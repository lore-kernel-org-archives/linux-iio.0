Return-Path: <stefan@agner.ch>
From: Stefan Agner <stefan@agner.ch>
To: jic23@kernel.org
Cc: knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	robh+dt@kernel.org,
	pawel.moll@arm.com,
	mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk,
	galak@codeaurora.org,
	B38611@freescale.com,
	maitysanchayan@gmail.com,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Stefan Agner <stefan@agner.ch>
Subject: [PATCH v2 2/3] iio: adc: vf610: implement configurable conversion modes
Date: Mon, 16 Mar 2015 16:10:13 +0100
Message-Id: <1426518614-20201-3-git-send-email-stefan@agner.ch>
In-Reply-To: <1426518614-20201-1-git-send-email-stefan@agner.ch>
References: <1426518614-20201-1-git-send-email-stefan@agner.ch>
List-ID: <linux-iio@vger.kernel.org>

Support configureable conversion mode through sysfs. So far, the
mode used was low-power, which is enabled by default now. Beside
that, the modes normal and high-speed are selectable as well.

Use the new device tree property which specifies the maximum ADC
conversion clock frequencies. Depending on the mode used, the
available resulting conversion frequency are calcaulated
dynamically.

Acked-by: Fugang Duan <B38611@freescale.com>
Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/iio/adc/vf610_adc.c | 146 +++++++++++++++++++++++++++++++-------------
 1 file changed, 104 insertions(+), 42 deletions(-)

diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
index e63b8e7..b5f94ab8 100644
--- a/drivers/iio/adc/vf610_adc.c
+++ b/drivers/iio/adc/vf610_adc.c
@@ -118,15 +118,21 @@ enum average_sel {
 	VF610_ADC_SAMPLE_32,
 };
 
+enum conversion_mode_sel {
+	VF610_ADC_CONV_NORMAL,
+	VF610_ADC_CONV_HIGH_SPEED,
+	VF610_ADC_CONV_LOW_POWER,
+};
+
 struct vf610_adc_feature {
 	enum clk_sel	clk_sel;
 	enum vol_ref	vol_ref;
+	enum conversion_mode_sel conv_mode;
 
 	int	clk_div;
 	int     sample_rate;
 	int	res_mode;
 
-	bool	lpm;
 	bool	calibration;
 	bool	ovwren;
 };
@@ -139,6 +145,8 @@ struct vf610_adc {
 	u32 vref_uv;
 	u32 value;
 	struct regulator *vref;
+
+	u32 max_adck_rate[3];
 	struct vf610_adc_feature adc_feature;
 
 	u32 sample_freq_avail[5];
@@ -148,46 +156,22 @@ struct vf610_adc {
 
 static const u32 vf610_hw_avgs[] = { 1, 4, 8, 16, 32 };
 
-#define VF610_ADC_CHAN(_idx, _chan_type) {			\
-	.type = (_chan_type),					\
-	.indexed = 1,						\
-	.channel = (_idx),					\
-	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
-	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
-				BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
-}
-
-#define VF610_ADC_TEMPERATURE_CHAN(_idx, _chan_type) {	\
-	.type = (_chan_type),	\
-	.channel = (_idx),		\
-	.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),	\
-}
-
-static const struct iio_chan_spec vf610_adc_iio_channels[] = {
-	VF610_ADC_CHAN(0, IIO_VOLTAGE),
-	VF610_ADC_CHAN(1, IIO_VOLTAGE),
-	VF610_ADC_CHAN(2, IIO_VOLTAGE),
-	VF610_ADC_CHAN(3, IIO_VOLTAGE),
-	VF610_ADC_CHAN(4, IIO_VOLTAGE),
-	VF610_ADC_CHAN(5, IIO_VOLTAGE),
-	VF610_ADC_CHAN(6, IIO_VOLTAGE),
-	VF610_ADC_CHAN(7, IIO_VOLTAGE),
-	VF610_ADC_CHAN(8, IIO_VOLTAGE),
-	VF610_ADC_CHAN(9, IIO_VOLTAGE),
-	VF610_ADC_CHAN(10, IIO_VOLTAGE),
-	VF610_ADC_CHAN(11, IIO_VOLTAGE),
-	VF610_ADC_CHAN(12, IIO_VOLTAGE),
-	VF610_ADC_CHAN(13, IIO_VOLTAGE),
-	VF610_ADC_CHAN(14, IIO_VOLTAGE),
-	VF610_ADC_CHAN(15, IIO_VOLTAGE),
-	VF610_ADC_TEMPERATURE_CHAN(26, IIO_TEMP),
-	/* sentinel */
-};
-
 static inline void vf610_adc_calculate_rates(struct vf610_adc *info)
 {
+	struct vf610_adc_feature *adc_feature = &info->adc_feature;
 	unsigned long adck_rate, ipg_rate = clk_get_rate(info->clk);
-	int i;
+	int divisor, i;
+
+	adck_rate = info->max_adck_rate[adc_feature->conv_mode];
+
+	if (adck_rate) {
+		/* calculate clk divider which is within specification */
+		divisor = ipg_rate / adck_rate;
+		adc_feature->clk_div = 1 << fls(divisor + 1);
+	} else {
+		/* fall-back value using a safe divisor */
+		adc_feature->clk_div = 8;
+	}
 
 	/*
 	 * Calculate ADC sample frequencies
@@ -219,10 +203,8 @@ static inline void vf610_adc_cfg_init(struct vf610_adc *info)
 
 	adc_feature->res_mode = 12;
 	adc_feature->sample_rate = 1;
-	adc_feature->lpm = true;
 
-	/* Use a save ADCK which is below 20MHz on all devices */
-	adc_feature->clk_div = 8;
+	adc_feature->conv_mode = VF610_ADC_CONV_LOW_POWER;
 
 	vf610_adc_calculate_rates(info);
 }
@@ -307,10 +289,12 @@ static void vf610_adc_cfg_set(struct vf610_adc *info)
 	cfg_data = readl(info->regs + VF610_REG_ADC_CFG);
 
 	cfg_data &= ~VF610_ADC_ADLPC_EN;
-	if (adc_feature->lpm)
+	if (adc_feature->conv_mode == VF610_ADC_CONV_LOW_POWER)
 		cfg_data |= VF610_ADC_ADLPC_EN;
 
 	cfg_data &= ~VF610_ADC_ADHSC_EN;
+	if (adc_feature->conv_mode == VF610_ADC_CONV_HIGH_SPEED)
+		cfg_data |= VF610_ADC_ADHSC_EN;
 
 	writel(cfg_data, info->regs + VF610_REG_ADC_CFG);
 }
@@ -412,6 +396,81 @@ static void vf610_adc_hw_init(struct vf610_adc *info)
 	vf610_adc_cfg_set(info);
 }
 
+static int vf610_set_conversion_mode(struct iio_dev *indio_dev,
+				     const struct iio_chan_spec *chan,
+				     unsigned int mode)
+{
+	struct vf610_adc *info = iio_priv(indio_dev);
+
+	mutex_lock(&indio_dev->mlock);
+	info->adc_feature.conv_mode = mode;
+	vf610_adc_calculate_rates(info);
+	vf610_adc_hw_init(info);
+	mutex_unlock(&indio_dev->mlock);
+
+	return 0;
+}
+
+static int vf610_get_conversion_mode(struct iio_dev *indio_dev,
+				     const struct iio_chan_spec *chan)
+{
+	struct vf610_adc *info = iio_priv(indio_dev);
+
+	return info->adc_feature.conv_mode;
+}
+
+static const char * const vf610_conv_modes[] = { "normal", "high-speed",
+						 "low-power" };
+
+static const struct iio_enum vf610_conversion_mode = {
+	.items = vf610_conv_modes,
+	.num_items = ARRAY_SIZE(vf610_conv_modes),
+	.get = vf610_get_conversion_mode,
+	.set = vf610_set_conversion_mode,
+};
+
+static const struct iio_chan_spec_ext_info vf610_ext_info[] = {
+	IIO_ENUM("conversion_mode", IIO_SHARED_BY_DIR, &vf610_conversion_mode),
+	{},
+};
+
+#define VF610_ADC_CHAN(_idx, _chan_type) {			\
+	.type = (_chan_type),					\
+	.indexed = 1,						\
+	.channel = (_idx),					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
+				BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
+	.ext_info = vf610_ext_info,				\
+}
+
+#define VF610_ADC_TEMPERATURE_CHAN(_idx, _chan_type) {	\
+	.type = (_chan_type),	\
+	.channel = (_idx),		\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),	\
+}
+
+static const struct iio_chan_spec vf610_adc_iio_channels[] = {
+	VF610_ADC_CHAN(0, IIO_VOLTAGE),
+	VF610_ADC_CHAN(1, IIO_VOLTAGE),
+	VF610_ADC_CHAN(2, IIO_VOLTAGE),
+	VF610_ADC_CHAN(3, IIO_VOLTAGE),
+	VF610_ADC_CHAN(4, IIO_VOLTAGE),
+	VF610_ADC_CHAN(5, IIO_VOLTAGE),
+	VF610_ADC_CHAN(6, IIO_VOLTAGE),
+	VF610_ADC_CHAN(7, IIO_VOLTAGE),
+	VF610_ADC_CHAN(8, IIO_VOLTAGE),
+	VF610_ADC_CHAN(9, IIO_VOLTAGE),
+	VF610_ADC_CHAN(10, IIO_VOLTAGE),
+	VF610_ADC_CHAN(11, IIO_VOLTAGE),
+	VF610_ADC_CHAN(12, IIO_VOLTAGE),
+	VF610_ADC_CHAN(13, IIO_VOLTAGE),
+	VF610_ADC_CHAN(14, IIO_VOLTAGE),
+	VF610_ADC_CHAN(15, IIO_VOLTAGE),
+	VF610_ADC_TEMPERATURE_CHAN(26, IIO_TEMP),
+	/* sentinel */
+};
+
 static int vf610_adc_read_data(struct vf610_adc *info)
 {
 	int result;
@@ -654,6 +713,9 @@ static int vf610_adc_probe(struct platform_device *pdev)
 
 	info->vref_uv = regulator_get_voltage(info->vref);
 
+	of_property_read_u32_array(pdev->dev.of_node, "fsl,adck-max-frequency",
+			info->max_adck_rate, 3);
+
 	platform_set_drvdata(pdev, indio_dev);
 
 	init_completion(&info->completion);
-- 
2.3.3
