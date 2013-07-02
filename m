Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:32020 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751853Ab3GBMQc (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 2 Jul 2013 08:16:32 -0400
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout1.w1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MPB009R462P1Y40@mailout1.w1.samsung.com> for
 linux-iio@vger.kernel.org; Tue, 02 Jul 2013 13:16:31 +0100 (BST)
From: Lukasz Czerwinski <l.czerwinski@samsung.com>
To: jic23@kernel.org, denis.ciocca@st.com
Cc: linux-iio@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	Jacek Anaszewski <j.anaszewski@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>
Subject: [PATCH 4/4] iio: lps331ap: Add support for DT
Date: Tue, 02 Jul 2013 14:15:38 +0200
Message-id: <1372767338-13179-5-git-send-email-l.czerwinski@samsung.com>
In-reply-to: <1372767338-13179-1-git-send-email-l.czerwinski@samsung.com>
References: <1372767338-13179-1-git-send-email-l.czerwinski@samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Jacek Anaszewski <j.anaszewski@samsung.com>

This patch adds DT support for the lps331ap barometer
sensor.

Signed-off-by: Jacek Anaszewski <j.anaszewski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 .../bindings/iio/pressure/st_pressure.txt          |   41 ++++++++++++++++++++
 drivers/iio/pressure/st_pressure_i2c.c             |    9 +++++
 drivers/iio/pressure/st_pressure_spi.c             |    9 +++++
 3 files changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/st_pressure.txt

diff --git a/Documentation/devicetree/bindings/iio/pressure/st_pressure.txt b/Documentation/devicetree/bindings/iio/pressure/st_pressure.txt
new file mode 100644
index 0000000..73a4b7d
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/pressure/st_pressure.txt
@@ -0,0 +1,41 @@
+* STMicroelectronics LPS331AP barometer sensor
+
+Required properties:
+
+  - compatible : should be "lps331ap"
+  - reg : the I2C address of the barometer
+
+Optional properties:
+
+  - drdy-int-pin : redirect DRDY on pin INT1 (1) or pin INT2 (2) (u8)
+  - interrupt-parent : phandle to the interrupt map subnode
+  - interrupts : interrupt mapping for LPS331AP interrupt sources:
+		2 sources: 0 - INT1, 1 - INT2
+  - irq-map : irq sub-node defining interrupt map
+	      (all properties listed below are required):
+      - #interrupt-cells : should be 1
+      - #address-cells : should be 0
+      - #size-cells : should be 0
+      - interrupt-map : table of entries consisting of three child elements:
+	  - unit_interrupt_specifier - 0 : INT1, 1 : INT2
+	  - interrupt parent phandle
+	  - parent unit interrupt specifier consisiting of two elements:
+	      - index of the interrupt within the controller
+	      - flags : should be 0
+
+Example:
+
+lps331ap@5d {
+	compatible = "lps331ap";
+	reg = <0x5d>;
+	drdy-int-pin = /bits/ 8 <2>;
+	interrupt-parent = <&irq_map>;
+	interrupts = <0>, <1>;
+
+	irq_map: irq-map {
+		#interrupt-cells = <1>;
+		#address-cells = <0>;
+		#size-cells = <0>;
+		interrupt-map = <0 &gpf0 5 0>;
+	};
+};
diff --git a/drivers/iio/pressure/st_pressure_i2c.c b/drivers/iio/pressure/st_pressure_i2c.c
index 7cebcc7..a1ad3cf 100644
--- a/drivers/iio/pressure/st_pressure_i2c.c
+++ b/drivers/iio/pressure/st_pressure_i2c.c
@@ -61,10 +61,19 @@ static const struct i2c_device_id st_press_id_table[] = {
 };
 MODULE_DEVICE_TABLE(i2c, st_press_id_table);
 
+#ifdef CONFIG_OF
+static const struct of_device_id lps331ap_of_match[] = {
+	{ .compatible = LPS331AP_PRESS_DEV_NAME, },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, lps331ap_of_match);
+#endif
+
 static struct i2c_driver st_press_driver = {
 	.driver = {
 		.owner = THIS_MODULE,
 		.name = "st-press-i2c",
+		.of_match_table = of_match_ptr(lps331ap_of_match),
 	},
 	.probe = st_press_i2c_probe,
 	.remove = st_press_i2c_remove,
diff --git a/drivers/iio/pressure/st_pressure_spi.c b/drivers/iio/pressure/st_pressure_spi.c
index 17a1490..e49269d 100644
--- a/drivers/iio/pressure/st_pressure_spi.c
+++ b/drivers/iio/pressure/st_pressure_spi.c
@@ -60,10 +60,19 @@ static const struct spi_device_id st_press_id_table[] = {
 };
 MODULE_DEVICE_TABLE(spi, st_press_id_table);
 
+#ifdef CONFIG_OF
+static const struct of_device_id lps331ap_of_match[] = {
+	{ .compatible = LPS331AP_PRESS_DEV_NAME, },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, lps331ap_of_match);
+#endif
+
 static struct spi_driver st_press_driver = {
 	.driver = {
 		.owner = THIS_MODULE,
 		.name = "st-press-spi",
+		.of_match_table = of_match_ptr(lps331ap_of_match),
 	},
 	.probe = st_press_spi_probe,
 	.remove = st_press_spi_remove,
-- 
1.7.9.5

