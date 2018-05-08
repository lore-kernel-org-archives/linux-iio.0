Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:39649 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754065AbeEHFd7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 8 May 2018 01:33:59 -0400
Received: by mail-pg0-f67.google.com with SMTP id e1-v6so9315324pga.6
        for <linux-iio@vger.kernel.org>; Mon, 07 May 2018 22:33:59 -0700 (PDT)
From: Matt Ranostay <matt.ranostay@konsulko.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, Matt Ranostay <matt.ranostay@konsulko.com>,
        devicetree@vger.kernel.org
Subject: [PATCH v2] iio: potentiostat: lmp91000: add LMP91002 support
Date: Mon,  7 May 2018 22:34:01 -0700
Message-Id: <20180508053401.32485-1-matt.ranostay@konsulko.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

LMP91002 is register compatible so add devicetree and i2c client ids

Cc: devicetree@vger.kernel.org
Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
---

Changes from v1:
* Split out compatible options in multiple lines for the lmp91000.txt documentation

 Documentation/devicetree/bindings/iio/potentiostat/lmp91000.txt | 9 ++++++---
 drivers/iio/potentiostat/lmp91000.c                             | 2 ++
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/potentiostat/lmp91000.txt b/Documentation/devicetree/bindings/iio/potentiostat/lmp91000.txt
index b9b621e94cd7..e6d0c2eb345c 100644
--- a/Documentation/devicetree/bindings/iio/potentiostat/lmp91000.txt
+++ b/Documentation/devicetree/bindings/iio/potentiostat/lmp91000.txt
@@ -1,10 +1,13 @@
-* Texas Instruments LMP91000 potentiostat
+* Texas Instruments LMP91000 series of potentiostats
 
-http://www.ti.com/lit/ds/symlink/lmp91000.pdf
+LMP91000: http://www.ti.com/lit/ds/symlink/lmp91000.pdf
+LMP91002: http://www.ti.com/lit/ds/symlink/lmp91002.pdf
 
 Required properties:
 
-  - compatible: should be "ti,lmp91000"
+  - compatible: should be one of the following:
+                 "ti,lmp91000"
+                 "ti,lmp91002"
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

