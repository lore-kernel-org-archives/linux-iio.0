Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout01.posteo.de ([185.67.36.65]:35169 "EHLO mout01.posteo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753475AbbJNNdM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 14 Oct 2015 09:33:12 -0400
Received: from dovecot03.posteo.de (dovecot03.posteo.de [172.16.0.13])
	by mout01.posteo.de (Postfix) with ESMTPS id E99B920932
	for <linux-iio@vger.kernel.org>; Wed, 14 Oct 2015 15:33:08 +0200 (CEST)
From: Martin Kepplinger <martink@posteo.de>
To: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, mfuzzey@parkeon.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, Martin Kepplinger <martink@posteo.de>,
	Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
Subject: [PATCH v3] iio: mma8452: support either of the available interrupt pins
Date: Wed, 14 Oct 2015 15:15:42 +0200
Message-Id: <1444828542-28861-1-git-send-email-martink@posteo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This change is important in order for everyone to be easily able to use the
driver for one of the supported accelerometer chips!

Until now, the driver blindly assumed that the INT1 interrupt line is wired
on a user's board. But these devices have 2 interrupt lines and can route
their different interrupt sources to one of them. Since only their motion
detection interrupt source is implemented as IIO events, users just use
either one of the pins.

Of course, this also falls back to assuming INT1, so for existing users
nothing will break. The new functionality is described in the bindings doc.

Signed-off-by: Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
---
changelog:
v3: correctly assign irq if both pins are described in DT. thanks again
v2: don't warn but normally handle if both pins are described in dts
    thanks Mark Rutland
v1: initial post

 .../devicetree/bindings/iio/accel/mma8452.txt      |  6 +++++
 drivers/iio/accel/mma8452.c                        | 26 +++++++++++++++++-----
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/accel/mma8452.txt b/Documentation/devicetree/bindings/iio/accel/mma8452.txt
index e3c3746..3c10e85 100644
--- a/Documentation/devicetree/bindings/iio/accel/mma8452.txt
+++ b/Documentation/devicetree/bindings/iio/accel/mma8452.txt
@@ -7,13 +7,18 @@ Required properties:
     * "fsl,mma8453"
     * "fsl,mma8652"
     * "fsl,mma8653"
+
   - reg: the I2C address of the chip
 
 Optional properties:
 
   - interrupt-parent: should be the phandle for the interrupt controller
+
   - interrupts: interrupt mapping for GPIO IRQ
 
+  - interrupt-names: should contain "INT1" and/or "INT2", the accelerometer's
+		     interrupt line in use.
+
 Example:
 
 	mma8453fc@1d {
@@ -21,4 +26,5 @@ Example:
 		reg = <0x1d>;
 		interrupt-parent = <&gpio1>;
 		interrupts = <5 0>;
+		interrupt-names = "INT2";
 	};
diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 1eccc2d..6b9b360 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -29,6 +29,7 @@
 #include <linux/iio/events.h>
 #include <linux/delay.h>
 #include <linux/of_device.h>
+#include <linux/of_irq.h>
 
 #define MMA8452_STATUS				0x00
 #define  MMA8452_STATUS_DRDY			(BIT(2) | BIT(1) | BIT(0))
@@ -1130,13 +1131,26 @@ static int mma8452_probe(struct i2c_client *client,
 					   MMA8452_INT_FF_MT;
 		int enabled_interrupts = MMA8452_INT_TRANS |
 					 MMA8452_INT_FF_MT;
+		int irq1, irq2;
 
-		/* Assume wired to INT1 pin */
-		ret = i2c_smbus_write_byte_data(client,
-						MMA8452_CTRL_REG5,
-						supported_interrupts);
-		if (ret < 0)
-			return ret;
+		irq1 = of_irq_get_byname(client->dev.of_node, "INT1");
+		irq2 = of_irq_get_byname(client->dev.of_node, "INT2");
+
+		/* if INT2 is found, use it. Otherwise INT1 */
+		if (!(irq2 > 0 && irq1 < 0)) {
+			ret = i2c_smbus_write_byte_data(client,
+							MMA8452_CTRL_REG5,
+							supported_interrupts);
+			if (ret < 0)
+				return ret;
+
+			if (irq1 > 0)
+				client->irq = irq1;
+			dev_info(&client->dev, "using interrupt line INT1\n");
+		} else {
+			client->irq = irq2;
+			dev_info(&client->dev, "using interrupt line INT2\n");
+		}
 
 		ret = i2c_smbus_write_byte_data(client,
 						MMA8452_CTRL_REG4,
-- 
2.1.4

