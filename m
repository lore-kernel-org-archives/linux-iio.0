Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FD4481FD7;
	Wed,  3 Jun 2026 14:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780497960; cv=none; b=AbeyNHPExSbp7KDY0gnXCbbufcN8HqQyhux5/DMQGLZFSSg3wqhP40AzqmPcCIRXTR+qoJs4lzgojcHNFRYoBTpxGU0H555rJmMuPqA8Nm4GC9uiVjcBuQBViC8KkdqWI3JztCQ6BdDelL80Q0/9rPqjRFiAJhgk3Ne4u63GN1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780497960; c=relaxed/simple;
	bh=bvUVoFTdaOhr99ucnb+AI/D7yly0q6bZXf/wsQQoBSI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=mfT5sKh/TZKiqnNcYA46Y02LBHY/ZZCRmDnIudI47PDXn+Z/FdTfasZ9yj6EZ2tN0/UD4odmDVXgQQ3bAK49LDD7cxClVB6VbW7lCO+H62WoxX978Hl5wZ4XFkvl0oI8bPt25V9SrLrWNa9IBRdI8OrM1pMQQuRskZrBCodcpAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=fvse6wo3; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="fvse6wo3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1780497958; x=1812033958;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=bvUVoFTdaOhr99ucnb+AI/D7yly0q6bZXf/wsQQoBSI=;
  b=fvse6wo3sya4MOBqwESU29AQt+MYf0hGxlLfRbBxG2Uk9glAsFRGnp+s
   /KUnHJ+6Wbb+4EmEIGIuVAImsLNd+7S1CJvX9UiTS2QLB+1U9vgaKE5JX
   SjXWJkg/k/hSZXPT8QeIsg6jv1GWRWTI+hYok8sSouIAkHdRIs8/R7gJ3
   OIA89ARPuTZYcy9lIejx1cwoyA2rTFDnwHegi0j48reVKBBkLpfQ4YWZO
   quKbMdeA24HR7idNbOb0LiK7Pf8o7UJ9bF6Hg9ZkwM8j/f1FC6StaiRan
   i8sehcPIbtoGz9E8meL2goY/9Cxnv/eWxOuDd8cRDT8X84P8R0f4iHSxR
   w==;
X-CSE-ConnectionGUID: I28YAzSmQle6rT5xDVWIHQ==
X-CSE-MsgGUID: xgMWgf5vTrKjZnF/6x6Vqw==
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="58944498"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Jun 2026 07:44:55 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 3 Jun 2026 07:44:54 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Wed, 3 Jun 2026 07:44:52 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Date: Wed, 3 Jun 2026 17:44:48 +0300
Subject: [PATCH v3] iio: dac: mcp47feb02: Fix passing uninitialized
 vref1_uV for no Vref1 case
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260603-mcp47feb02-fix4-v3-1-ed09975cad15@microchip.com>
X-B4-Tracking: v=1; b=H4sIAN89IGoC/3XNywrCMBCF4VcpWRtJpulFV76HuMhlYmfRpiQSl
 NJ3N+1KFJf/gflmYQkjYWLnamERMyUKU4n6UDE76OmOnFxpBgJaoaTio51V59EI4J6eirdSOTz
 VtfIArFzNEcu+i9db6YHSI8TX/iDLbf1vZcklP7lOGu28gwYvI9kY7EDz0YaRbV6GDwPErwHF6
 E3X9Kh1b6z/NtZ1fQNV//G09gAAAA==
X-Change-ID: 20260414-mcp47feb02-fix4-614de9334f22
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>
CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Dan Carpenter
	<error27@gmail.com>, Ariana Lazar <ariana.lazar@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780497891; l=13959;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=bvUVoFTdaOhr99ucnb+AI/D7yly0q6bZXf/wsQQoBSI=;
 b=GXZxmwl2n4/MYepPgJwu7cBpCseca3tjc83S5TnRng664XtftawkG7tWEWwWdAYGOqzh6yg5d
 6SaUstJMf98Ce8wyMD7e9+Uq9t/3m/+pmP707hpYCcTcZCE2phERMKa
X-Developer-Key: i=ariana.lazar@microchip.com; a=ed25519;
 pk=jmvf1fSxcnzZmXfITM3L94IwutM+wqA1POQHiYyD6Dk=

Ensure that if a device has Vref1 but reading the regulator returns an
error, mcp47feb02_init_ctrl_regs() is not called with an uninitialized
vref1_uV value.

Also add a device_property_present() check for the Vref1 supply before
reading the regulator.

Fixes: dd154646d292 ("iio: dac: mcp47feb02: Fix Vref validation [1-999] case")
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/all/adiPnla0M5EzvgD-@stanley.mountain/

Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
---
Changes in v3:
- Handle mismatch between vref modes at power up and enable regulator
   only after the user corrects it.
- Link to v2: https://lore.kernel.org/r/20260420-mcp47feb02-fix4-v2-1-8b758eaa8bcf@microchip.com

Changes in v2:
- return the reading regulator error to not use vref1_uV uninitialized in
   mcp47feb02_init_ctrl_regs() call 
- add device_property_present() check for the Vref1
- Link to v1: https://lore.kernel.org/r/20260414-mcp47feb02-fix4-v1-1-9d71badfd25e@microchip.com
---
 drivers/iio/dac/mcp47feb02.c | 245 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 202 insertions(+), 43 deletions(-)

diff --git a/drivers/iio/dac/mcp47feb02.c b/drivers/iio/dac/mcp47feb02.c
index faccb804a5ed548088aaf83266b16ed45a92916c..09eab829b1b57c7a794bbac2dee581cb1fad575f 100644
--- a/drivers/iio/dac/mcp47feb02.c
+++ b/drivers/iio/dac/mcp47feb02.c
@@ -68,6 +68,11 @@
 #define MCP47FEB02_INTERNAL_BAND_GAP_uV			2440000
 #define NV_DAC_ADDR_OFFSET				0x10
 
+#define MCP47FEB02_VDD_VOLTAGE_REFERENCE "Device VDD"
+#define MCP47FEB02_INTERNAL_BAND_GAP_VOLTAGE_REFERENCE "Internal Band Gap"
+#define MCP47FEB02_PRIMARY_VOLTAGE_REFERENCE "External VREF pin"
+#define MCP47FEB02_SECOND_VOLTAGE_REFERENCE "External VREF1 pin"
+
 enum mcp47feb02_vref_mode {
 	MCP47FEB02_VREF_VDD = 0,
 	MCP47FEB02_INTERNAL_BAND_GAP = 1,
@@ -307,6 +312,7 @@ static const struct mcp47feb02_features mcp47fvb28_chip_features = {
  * @powerdown: is false if the channel is in normal operation mode
  * @powerdown_mode: selected power-down mode
  * @dac_data: dac value
+ * @ref_mismatch: true if the restored register configuration is different from the device tree one
  */
 struct mcp47feb02_channel_data {
 	u8 ref_mode;
@@ -314,6 +320,7 @@ struct mcp47feb02_channel_data {
 	bool powerdown;
 	u8 powerdown_mode;
 	u16 dac_data;
+	bool ref_mismatch;
 };
 
 /**
@@ -326,11 +333,15 @@ struct mcp47feb02_channel_data {
  * @active_channels_mask: enabled channels
  * @regmap: regmap for directly accessing device register
  * @labels: table with channels labels
+ * @vref1_reg: Vref1 regulator to be enabled after correcting reference mismatch
+ * @vref_reg: Vref/Vref0 regulator to be enabled after correcting reference mismatch
  * @phys_channels: physical channels on the device
  * @vref1_buffered: Vref1 buffer is enabled
  * @vref_buffered: Vref/Vref0 buffer is enabled
  * @use_vref1: vref1-supply is defined
  * @use_vref: vref-supply is defined
+ * @vref1_enabled: true if Vref1 regulator has been enabled
+ * @vref_enabled: true if Vref/Vref0 regulator has been enabled
  */
 struct mcp47feb02_data {
 	struct mcp47feb02_channel_data chdata[MCP47FEB02_MAX_CH];
@@ -341,11 +352,15 @@ struct mcp47feb02_data {
 	unsigned long active_channels_mask;
 	struct regmap *regmap;
 	const char *labels[MCP47FEB02_MAX_CH];
+	struct regulator *vref_reg;
+	struct regulator *vref1_reg;
 	u16 phys_channels;
 	bool vref1_buffered;
 	bool vref_buffered;
 	bool use_vref1;
 	bool use_vref;
+	bool vref1_enabled;
+	bool vref_enabled;
 };
 
 static const struct regmap_range mcp47feb02_readable_ranges[] = {
@@ -798,6 +813,48 @@ static int mcp47feb02_check_scale(struct mcp47feb02_data *data, int val, int val
 	return -EINVAL;
 }
 
+static void mcp47feb02_regulator_disable(void *d)
+{
+	struct regulator *reg = (struct regulator *)d;
+
+	if (reg)
+		regulator_disable(reg);
+}
+
+static bool mcp47feb02_ref_mismatch(struct mcp47feb02_data *data, unsigned int ch)
+{
+	bool use_vref, use_bandgap;
+
+	if (data->chdata[ch].ref_mode == MCP47FEB02_VREF_VDD)
+		return false;
+
+	use_vref = (data->phys_channels >= 4 && (ch % 2)) ?  data->use_vref1 : data->use_vref;
+	use_bandgap = (data->chdata[ch].ref_mode == MCP47FEB02_INTERNAL_BAND_GAP);
+
+	return use_vref == use_bandgap;
+}
+
+static int mcp47feb02_enable_reg(struct mcp47feb02_data *data, struct regulator *reg, bool *enabled)
+{
+	struct device *dev = regmap_get_device(data->regmap);
+	int ret;
+
+	if (*enabled)
+		return 0;
+
+	ret = regulator_enable(reg);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable regulator\n");
+
+	ret = devm_add_action_or_reset(dev, mcp47feb02_regulator_disable, reg);
+	if (ret)
+		return ret;
+
+	*enabled = true;
+
+	return 0;
+}
+
 static int mcp47feb02_ch_scale(struct mcp47feb02_data *data, int ch, int scale)
 {
 	int tmp_val, ret;
@@ -806,6 +863,10 @@ static int mcp47feb02_ch_scale(struct mcp47feb02_data *data, int ch, int scale)
 		tmp_val = MCP47FEB02_VREF_VDD;
 	} else if (data->phys_channels >= 4 && (ch % 2)) {
 		if (data->use_vref1) {
+			ret = mcp47feb02_enable_reg(data, data->vref1_reg, &data->vref1_enabled);
+			if (ret)
+				return ret;
+
 			if (data->vref1_buffered)
 				tmp_val = MCP47FEB02_EXTERNAL_VREF_BUFFERED;
 			else
@@ -814,6 +875,10 @@ static int mcp47feb02_ch_scale(struct mcp47feb02_data *data, int ch, int scale)
 			tmp_val = MCP47FEB02_INTERNAL_BAND_GAP;
 		}
 	} else if (data->use_vref) {
+		ret = mcp47feb02_enable_reg(data, data->vref_reg, &data->vref_enabled);
+			if (ret)
+				return ret;
+
 		if (data->vref_buffered)
 			tmp_val = MCP47FEB02_EXTERNAL_VREF_BUFFERED;
 		else
@@ -828,6 +893,7 @@ static int mcp47feb02_ch_scale(struct mcp47feb02_data *data, int ch, int scale)
 		return ret;
 
 	data->chdata[ch].ref_mode = tmp_val;
+	data->chdata[ch].ref_mismatch = false;
 
 	return 0;
 }
@@ -872,6 +938,16 @@ static int mcp47feb02_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec c
 	struct mcp47feb02_data *data = iio_priv(indio_dev);
 	int ret;
 
+	guard(mutex)(&data->lock);
+
+	/*
+	 * The reference mode restored from EEPROM may not match the current
+	 * device tree configuration. Access will be allowed after a matching
+	 * scale is written by the user.
+	 */
+	if (data->chdata[ch->address].ref_mismatch)
+		return -EBUSY;
+
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 		ret = regmap_read(data->regmap, REG_ADDR(ch->address), val);
@@ -896,6 +972,12 @@ static int mcp47feb02_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
+		/*
+		 * Allow only scale write operation until reference mismatch is corrected.
+		 */
+		if (data->chdata[ch->address].ref_mismatch)
+			return -EBUSY;
+
 		ret = regmap_write(data->regmap, REG_ADDR(ch->address), val);
 		if (ret)
 			return ret;
@@ -1034,36 +1116,67 @@ static int mcp47feb02_init_ctrl_regs(struct mcp47feb02_data *data)
 		 * In order to overwrite the setting from volatile register with the one from the
 		 * device tree, the user needs to write the chosen scale.
 		 */
-		switch (data->chdata[i].ref_mode) {
-		case MCP47FEB02_INTERNAL_BAND_GAP:
-			if (data->phys_channels >= 4 && (i % 2) && data->use_vref1) {
-				dev_dbg(dev, "ch[%u]: was configured to use internal band gap", i);
-				dev_dbg(dev, "ch[%u]: reference voltage set to VREF1", i);
-				break;
-			}
-			if ((data->phys_channels < 4 || (data->phys_channels >= 4 && !(i % 2))) &&
-			    data->use_vref) {
-				dev_dbg(dev, "ch[%u]: was configured to use internal band gap", i);
-				dev_dbg(dev, "ch[%u]: reference voltage set to VREF", i);
-				break;
+		data->chdata[i].ref_mismatch = mcp47feb02_ref_mismatch(data, i);
+		if (data->chdata[i].ref_mismatch) {
+			unsigned int ref_mode = data->chdata[i].ref_mode;
+			const char *restored_vref;
+			const char *dt_vref;
+
+			if (ref_mode == MCP47FEB02_VREF_VDD) {
+				restored_vref = MCP47FEB02_VDD_VOLTAGE_REFERENCE;
+			} else if (ref_mode == MCP47FEB02_INTERNAL_BAND_GAP) {
+				restored_vref = MCP47FEB02_INTERNAL_BAND_GAP_VOLTAGE_REFERENCE;
+			} else if ((ref_mode == MCP47FEB02_EXTERNAL_VREF_UNBUFFERED ||
+				ref_mode == MCP47FEB02_EXTERNAL_VREF_BUFFERED) &&
+				data->phys_channels >= 4 && (i % 2)) {
+				restored_vref = MCP47FEB02_SECOND_VOLTAGE_REFERENCE;
+			} else {
+				restored_vref = MCP47FEB02_PRIMARY_VOLTAGE_REFERENCE;
 			}
-			break;
-		case MCP47FEB02_EXTERNAL_VREF_UNBUFFERED:
-		case MCP47FEB02_EXTERNAL_VREF_BUFFERED:
-			if (data->phys_channels >= 4 && (i % 2) && !data->use_vref1) {
-				dev_dbg(dev, "ch[%u]: was configured to use VREF1", i);
-				dev_dbg(dev,
-					"ch[%u]: reference voltage set to internal band gap", i);
-				break;
-			}
-			if ((data->phys_channels < 4 || (data->phys_channels >= 4 && !(i % 2))) &&
-			    !data->use_vref) {
-				dev_dbg(dev, "ch[%u]: was configured to use VREF", i);
-				dev_dbg(dev,
-					"ch[%u]: reference voltage set to internal band gap", i);
-				break;
+
+			if (data->phys_channels >= 4 && (i % 2))
+				if (data->use_vref1)
+					dt_vref = MCP47FEB02_SECOND_VOLTAGE_REFERENCE;
+				else
+					dt_vref = MCP47FEB02_INTERNAL_BAND_GAP_VOLTAGE_REFERENCE;
+			else
+				if (data->use_vref)
+					dt_vref = MCP47FEB02_PRIMARY_VOLTAGE_REFERENCE;
+				else
+					dt_vref = MCP47FEB02_INTERNAL_BAND_GAP_VOLTAGE_REFERENCE;
+
+			dev_info(dev, "ch[%u]: restored configuration uses %s\n",
+				 i, restored_vref);
+			dev_info(dev,
+				 "ch[%u]: currently selected vref will not be in scale_available\n",
+				 i);
+			dev_info(dev, "ch[%u]: DT describes %s as the available reference source\n",
+				 i, dt_vref);
+		} else if (data->chdata[i].ref_mode == MCP47FEB02_EXTERNAL_VREF_UNBUFFERED ||
+			   data->chdata[i].ref_mode == MCP47FEB02_EXTERNAL_VREF_BUFFERED) {
+			unsigned int reg_vref;
+			bool is_buf;
+
+			if (data->phys_channels >= 4 && (i % 2))
+				is_buf = data->vref1_buffered;
+			else
+				is_buf = data->vref_buffered;
+
+			if (is_buf)
+				reg_vref = MCP47FEB02_EXTERNAL_VREF_BUFFERED;
+			else
+				reg_vref = MCP47FEB02_EXTERNAL_VREF_UNBUFFERED;
+
+			if (data->chdata[i].ref_mode != reg_vref) {
+				ret = regmap_update_bits(data->regmap, MCP47FEB02_VREF_REG_ADDR,
+							 DAC_CTRL_MASK(i),
+							 DAC_CTRL_VAL(i, reg_vref));
+				if (ret)
+					return ret;
+
+				data->chdata[i].ref_mode = reg_vref;
+				dev_info(dev, "Mismatch buffer property for ch[%u]\n", i);
 			}
-			break;
 		}
 
 		pd_tmp = (pd_ch >> (2 * i)) & MCP47FEB02_DAC_CTRL_MASK;
@@ -1091,11 +1204,35 @@ static int mcp47feb02_init_ch_scales(struct mcp47feb02_data *data, int vdd_uV,
 	return 0;
 }
 
+static int mcp47feb02_try_enable_reg(struct mcp47feb02_data *data)
+{
+	unsigned int i;
+	int ret;
+
+	for_each_set_bit(i, &data->active_channels_mask, data->phys_channels) {
+		if (data->chdata[i].ref_mismatch)
+			continue;
+
+		if (data->chdata[i].ref_mode < MCP47FEB02_EXTERNAL_VREF_UNBUFFERED)
+			continue;
+
+		if (data->phys_channels >= 4 && (i % 2))
+			ret = mcp47feb02_enable_reg(data, data->vref1_reg, &data->vref1_enabled);
+		else
+			ret = mcp47feb02_enable_reg(data, data->vref_reg, &data->vref_enabled);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int mcp47feb02_probe(struct i2c_client *client)
 {
 	const struct mcp47feb02_features *chip_features;
 	struct device *dev = &client->dev;
 	struct mcp47feb02_data *data;
+	struct regulator *vref_reg;
 	struct iio_dev *indio_dev;
 	int vref1_uV, vref_uV, vdd_uV, ret;
 
@@ -1136,32 +1273,54 @@ static int mcp47feb02_probe(struct i2c_client *client)
 
 	vdd_uV = ret;
 
-	ret = devm_regulator_get_enable_read_voltage(dev, "vref");
-	if (ret > 0) {
-		vref_uV = ret;
-		data->use_vref = true;
+	if (device_property_present(dev, "vref-supply")) {
+		vref_reg = devm_regulator_get(dev, "vref");
+		if (IS_ERR(vref_reg))
+			return PTR_ERR(vref_reg);
+
+		data->vref_reg = vref_reg;
+
+		vref_uV = regulator_get_voltage(vref_reg);
+		if (vref_uV < 0)
+			return vref_uV;
+
+		if (vref_uV > 0)
+			data->use_vref = true;
+		else
+			dev_dbg(dev, "Vref is 0 uV, internal band gap will be used.\n");
 	} else {
 		vref_uV = 0;
-		dev_dbg(dev, "using internal band gap as voltage reference.\n");
-		dev_dbg(dev, "Vref is unavailable.\n");
+		dev_dbg(dev, "Using internal band gap as voltage reference.\n");
 	}
 
-	if (chip_features->have_ext_vref1) {
-		ret = devm_regulator_get_enable_read_voltage(dev, "vref1");
-		if (ret > 0) {
-			vref1_uV = ret;
+	if (chip_features->have_ext_vref1 && device_property_present(dev, "vref1-supply")) {
+		vref_reg = devm_regulator_get(dev, "vref1");
+		if (IS_ERR(vref_reg))
+			return PTR_ERR(vref_reg);
+
+		data->vref1_reg = vref_reg;
+
+		vref1_uV = regulator_get_voltage(vref_reg);
+		if (vref1_uV < 0)
+			return vref1_uV;
+
+		if (vref1_uV > 0)
 			data->use_vref1 = true;
-		} else {
-			vref1_uV = 0;
-			dev_dbg(dev, "using internal band gap as voltage reference 1.\n");
-			dev_dbg(dev, "Vref1 is unavailable.\n");
-		}
+		else
+			dev_dbg(dev, "Vref1 is 0 uV, internal band gap will be used.\n");
+	} else {
+		vref1_uV = 0;
+		dev_dbg(dev, "Using internal band gap as voltage reference 1.\n");
 	}
 
 	ret = mcp47feb02_init_ctrl_regs(data);
 	if (ret)
 		return dev_err_probe(dev, ret, "Error initialising vref register\n");
 
+	ret = mcp47feb02_try_enable_reg(data);
+	if (ret)
+		return ret;
+
 	ret = mcp47feb02_init_ch_scales(data, vdd_uV, vref_uV, vref1_uV);
 	if (ret)
 		return ret;

---
base-commit: 51e7665ab81f02adc80a1219c260ee678e9c6eb8
change-id: 20260414-mcp47feb02-fix4-614de9334f22

Best regards,
-- 
Ariana Lazar <ariana.lazar@microchip.com>

