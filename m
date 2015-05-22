Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp107.biz.mail.bf1.yahoo.com ([98.139.244.55]:33539 "EHLO
	smtp107.biz.mail.bf1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755960AbbEVAcG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 21 May 2015 20:32:06 -0400
From: Kevin Tsai <ktsai@capellamicro.com>
To: Kevin Tsai <ktsai@capellamicro.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
	Arnd Bergmann <arnd@arndb.de>, Joe Perches <joe@perches.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH 5/6] iio: light: Updated Vishay Capella cm32181 ambient light sensor driver. - Added Device Tree support.
Date: Thu, 21 May 2015 17:30:44 -0700
Message-Id: <1432254645-5349-5-git-send-email-ktsai@capellamicro.com>
In-Reply-To: <1432254645-5349-1-git-send-email-ktsai@capellamicro.com>
References: <1432254645-5349-1-git-send-email-ktsai@capellamicro.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Kevin Tsai <ktsai@capellamicro.com>
---
Added Device Tree support.

 .../devicetree/bindings/iio/light/cm32181.txt      | 33 +++++++++++
 MAINTAINERS                                        | 13 +++--
 drivers/iio/light/cm32181.c                        | 66 ++++++++++------------
 3 files changed, 71 insertions(+), 41 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/light/cm32181.txt

diff --git a/Documentation/devicetree/bindings/iio/light/cm32181.txt b/Documentation/devicetree/bindings/iio/light/cm32181.txt
new file mode 100644
index 0000000..b81a3e3
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/cm32181.txt
@@ -0,0 +1,33 @@
+* Vishay Capella CM32181 Ambient Light sensor
+
+Required properties:
+- compatible: must be "capella,cm32181"
+- reg: the I2C address of the device
+
+Optional properties:
+- capella,hw_id: hardware device id.
+- capella,reg_cmd: command register initialization.
+- capella,reg_als_wh: high threshold register initialization.
+- capella,reg_als_wl: low threshold register initialization.
+- capella,calibscale: calibrated factor with 10^-5 notation.
+- capella,hw_id: hardware device id.
+- capella,mlux_per_bit: millilux per bit under the default IT.
+- capella,thd_percent: threshold percentage change to trigger.
+
+Example:
+
+cm32181@10 {
+	compatible = "capella,cm32181";
+	reg = <0x10>;
+	interrupt-parent = <&gpio1>;
+	interrupts = <17 0>;
+
+	capella,hw_id = <0x81>;
+	capella,reg_cmd = <0x04>;
+	capella,reg_als_wh = <0xFFFF>;
+	capella,reg_als_wl = <0x0000>;
+	capella,calibscale = <10000>;
+	capella,mlux_per_bit = <5>;
+	capella,thd_percent = <5>;
+};
+
diff --git a/MAINTAINERS b/MAINTAINERS
index f8e0afb..3af7eda 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2431,12 +2431,6 @@ F:	security/capability.c
 F:	security/commoncap.c
 F:	kernel/capability.c
 
-CAPELLA MICROSYSTEMS LIGHT SENSOR DRIVER
-M:	Kevin Tsai <ktsai@capellamicro.com>
-S:	Maintained
-F:	drivers/iio/light/cm*
-F:	Documentation/devicetree/bindings/i2c/trivial-devices.txt
-
 CC2520 IEEE-802.15.4 RADIO DRIVER
 M:	Varka Bhadram <varkabhadram@gmail.com>
 L:	linux-wpan@vger.kernel.org
@@ -10610,6 +10604,13 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/via/via-velocity.*
 
+VISHAY CAPELLA LIGHT SENSOR DRIVER
+M:	Kevin Tsai <ktsai@capellamicro.com>
+S:	Maintained
+F:	drivers/iio/light/cm*
+F:	Documentation/devicetree/bindings/i2c/trivial-devices.txt
+F:	Documentation/devicetree/bindings/iio/light/cm*
+
 VIVID VIRTUAL VIDEO DRIVER
 M:	Hans Verkuil <hverkuil@xs4all.nl>
 L:	linux-media@vger.kernel.org
diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
index 54bf0cb..b7abd46 100644
--- a/drivers/iio/light/cm32181.c
+++ b/drivers/iio/light/cm32181.c
@@ -51,6 +51,7 @@
 #define CM32181_HW_ID			0x81
 #define CM32181_MLUX_PER_BIT		5	/* ALS_SM=01 IT=800ms */
 #define CM32181_MLUX_PER_BIT_BASE_IT	800000	/* Based on IT=800ms */
+#define CM32181_THD_PERCENT		5	/* 0 for polling mode */
 #define	CM32181_CALIBSCALE_DEFAULT	1000
 #define CM32181_CALIBSCALE_RESOLUTION	1000
 #define CM32181_MLUX_PER_LUX		1000
@@ -80,6 +81,7 @@ struct cm32181_als_info {
 	int calibscale;
 	int mlux_per_bit;
 	int mlux_per_bit_base_it;
+	int thd_percent;
 };
 
 static struct cm32181_als_info cm32181_als_info_default = {
@@ -90,6 +92,7 @@ static struct cm32181_als_info cm32181_als_info_default = {
 	.calibscale = CM32181_CALIBSCALE_DEFAULT,
 	.mlux_per_bit = CM32181_MLUX_PER_BIT,
 	.mlux_per_bit_base_it = CM32181_MLUX_PER_BIT_BASE_IT,
+	.thd_percent = CM32181_THD_PERCENT,
 };
 
 struct cm32181_chip {
@@ -99,6 +102,30 @@ struct cm32181_chip {
 	u16 conf_regs[CM32181_CONF_REG_NUM];
 };
 
+#ifdef CONFIG_OF
+void cm32181_parse_dt(struct cm32181_chip *chip)
+{
+	struct device_node *dn = chip->client->dev.of_node;
+	struct cm32181_als_info *als_info = chip->als_info;
+	u32 temp_val;
+
+	if (!of_property_read_u32(dn, "capella,hw_id", &temp_val))
+		als_info->hw_id = (uint8_t)temp_val;
+	if (!of_property_read_u32(dn, "capella,reg_cmd", &temp_val))
+		als_info->reg_cmd = (uint16_t)temp_val;
+	if (!of_property_read_u32(dn, "capella,reg_als_wh", &temp_val))
+		als_info->reg_als_wh = (uint16_t)temp_val;
+	if (!of_property_read_u32(dn, "capella,reg_als_wl", &temp_val))
+		als_info->reg_als_wl = (uint16_t)temp_val;
+	if (!of_property_read_u32(dn, "capella,calibscale", &temp_val))
+		als_info->calibscale = (int)temp_val;
+	if (!of_property_read_u32(dn, "capella,mlux_per_bit", &temp_val))
+		als_info->mlux_per_bit = (int)temp_val;
+	if (!of_property_read_u32(dn, "capella,thd_percent", &temp_val))
+		als_info->thd_percent = (int)temp_val;
+}
+#endif
+
 /**
  * cm32181_reg_init() - Initialize CM32181 registers
  * @chip:	pointer of struct cm32181_chip
@@ -116,6 +143,10 @@ static int cm32181_reg_init(struct cm32181_chip *chip)
 
 	chip->als_info = &cm32181_als_info_default;
 	als_info = chip->als_info;
+#ifdef CONFIG_OF
+	if (client->dev.of_node)
+		cm32181_parse_dt(chip);
+#endif
 
 	ret = i2c_smbus_read_word_data(client, CM32181_REG_ADDR_ID);
 	if (ret < 0)
@@ -208,33 +239,6 @@ static int cm32181_write_als_it(struct cm32181_chip *chip, int val, int val2)
 		}
 	}
 	return -EINVAL;
-
-/*
-	struct i2c_client *client = chip->client;
-	u16 als_it;
-	int ret, i, n;
-
-	n = ARRAY_SIZE(als_it_value);
-	for (i = 0; i < n; i++)
-		if (val <= als_it_value[i])
-			break;
-	if (i >= n)
-		i = n - 1;
-
-	als_it = als_it_bits[i];
-	als_it <<= CM32181_CMD_ALS_IT_SHIFT;
-
-	mutex_lock(&chip->lock);
-	chip->conf_regs[CM32181_REG_ADDR_CMD] &=
-		~CM32181_CMD_ALS_IT_MASK;
-	chip->conf_regs[CM32181_REG_ADDR_CMD] |=
-		als_it;
-	ret = i2c_smbus_write_word_data(client, CM32181_REG_ADDR_CMD,
-			chip->conf_regs[CM32181_REG_ADDR_CMD]);
-	mutex_unlock(&chip->lock);
-
-	return ret;
-*/
 }
 
 /**
@@ -344,14 +348,6 @@ static ssize_t cm32181_get_it_available(struct device *dev,
 			cm32181_als_it_scales[i].val,
 			cm32181_als_it_scales[i].val2);
 	return len + scnprintf(buf + len, PAGE_SIZE - len, "\n");
-/*
-	int i, n, len;
-
-	n = ARRAY_SIZE(als_it_value);
-	for (i = 0, len = 0; i < n; i++)
-		len += sprintf(buf + len, "0.%06u ", als_it_value[i]);
-	return len + sprintf(buf + len, "\n");
-*/
 }
 
 static const struct iio_chan_spec cm32181_channels[] = {
-- 
1.8.3.1

