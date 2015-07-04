Return-Path: <martink@posteo.de>
From: Martin Kepplinger <martink@posteo.de>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	mfuzzey@parkeon.com,
	roberta.dobrescu@gmail.com,
	christoph.muellner@theobroma-systems.com
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Martin Kepplinger <martink@posteo.de>,
	Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
Subject: [PATCH 9/9] iio: mma8452: add devicetree property to allow all pin wirings
Date: Sat,  4 Jul 2015 15:55:10 +0200
Message-Id: <1436018110-3903-10-git-send-email-martink@posteo.de>
In-Reply-To: <1436018110-3903-1-git-send-email-martink@posteo.de>
References: <1436018110-3903-1-git-send-email-martink@posteo.de>
List-ID: <linux-iio@vger.kernel.org>

For the devices supported by the mma8452 driver, two interrupt pins are
available to route the interrupt signals to. By default INT1 is assumed.

This adds a simple boolean DT property, for users to configure it for
INT2, if that is the wired interrupt pin for them.

This is important for everyone to be able to use this driver, no matter
how their chip is wired.

Since this doesn't change the default behaviour, it doesn't break anything
for existing users.

Signed-off-by: Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
---
 Documentation/devicetree/bindings/iio/accel/mma8452.txt |  2 ++
 drivers/iio/accel/mma8452.c                             | 14 ++++++++------
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/accel/mma8452.txt b/Documentation/devicetree/bindings/iio/accel/mma8452.txt
index 8d98e05..0048415 100644
--- a/Documentation/devicetree/bindings/iio/accel/mma8452.txt
+++ b/Documentation/devicetree/bindings/iio/accel/mma8452.txt
@@ -10,6 +10,7 @@ Optional properties:
 
   - interrupt-parent: should be the phandle for the interrupt controller
   - interrupts: interrupt mapping for GPIO IRQ
+  - int2: assume interrupt pin wired to INT2 instead of INT1
 
 Example:
 
@@ -18,4 +19,5 @@ Example:
 		reg = <0x1d>;
 		interrupt-parent = <&gpio1>;
 		interrupts = <5 0>;
+		int2;
 	};
diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 2491ed0..0768e66 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -1072,12 +1072,14 @@ static int mma8452_probe(struct i2c_client *client,
 		int enabled_interrupts = MMA8452_INT_TRANS |
 					 MMA8452_INT_FF_MT;
 
-		/* Assume wired to INT1 pin */
-		ret = i2c_smbus_write_byte_data(client,
-						MMA8452_CTRL_REG5,
-						supported_interrupts);
-		if (ret < 0)
-			return ret;
+		/* Assume wired to INT1 pin, except "int2" is found in DT */
+		if (!of_property_read_bool(client->dev.of_node, "int2")) {
+			ret = i2c_smbus_write_byte_data(client,
+							MMA8452_CTRL_REG5,
+							supported_interrupts);
+			if (ret < 0)
+				return ret;
+		}
 
 		ret = i2c_smbus_write_byte_data(client,
 						MMA8452_CTRL_REG4,
-- 
2.1.4
