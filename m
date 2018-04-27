Return-Path: <SRS0=tvY0=HQ=konsulko.com=matt.ranostay@kernel.org>
From: Matt Ranostay <matt.ranostay@konsulko.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Matt Ranostay <matt.ranostay@konsulko.com>,
	device-tree@vger.kernel.org
Subject: [PATCH] iio: potentiostat: lmp91000: add LMP91002 support
Date: Thu, 26 Apr 2018 19:15:05 -0700
Message-Id: <20180427021505.29526-1-matt.ranostay@konsulko.com>
List-ID: <linux-iio@vger.kernel.org>

LMP91002 is register compatible so add devicetree and i2c client ids

Cc: device-tree@vger.kernel.org
Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
---
 Documentation/devicetree/bindings/iio/potentiostat/lmp91000.txt | 7 ++++---
 drivers/iio/potentiostat/lmp91000.c                             | 2 ++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/potentiostat/lmp91000.txt b/Documentation/devicetree/bindings/iio/potentiostat/lmp91000.txt
index b9b621e94cd7..d51639f0ebbf 100644
--- a/Documentation/devicetree/bindings/iio/potentiostat/lmp91000.txt
+++ b/Documentation/devicetree/bindings/iio/potentiostat/lmp91000.txt
@@ -1,10 +1,11 @@
-* Texas Instruments LMP91000 potentiostat
+* Texas Instruments LMP91000 series of potentiostats
 
-http://www.ti.com/lit/ds/symlink/lmp91000.pdf
+LMP91000: http://www.ti.com/lit/ds/symlink/lmp91000.pdf
+LMP91002: http://www.ti.com/lit/ds/symlink/lmp91002.pdf
 
 Required properties:
 
-  - compatible: should be "ti,lmp91000"
+  - compatible: should be "ti,lmp91000" or "ti,lmp91002"
   - reg: the I2C address of the device
   - io-channels: the phandle of the iio provider
 
diff --git a/drivers/iio/potentiostat/lmp91000.c b/drivers/iio/potentiostat/lmp91000.c
index 85714055cc74..90e895adf997 100644
--- a/drivers/iio/potentiostat/lmp91000.c
+++ b/drivers/iio/potentiostat/lmp91000.c
@@ -411,12 +411,14 @@ static int lmp91000_remove(struct i2c_client *client)
 
 static const struct of_device_id lmp91000_of_match[] = {
 	{ .compatible = "ti,lmp91000", },
+	{ .compatible = "ti,lmp91002", },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, lmp91000_of_match);
 
 static const struct i2c_device_id lmp91000_id[] = {
 	{ "lmp91000", 0 },
+	{ "lmp91002", 0 },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, lmp91000_id);
-- 
2.14.1
