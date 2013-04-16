Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:40432 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935534Ab3DPOh6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 16 Apr 2013 10:37:58 -0400
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MLC00HUARB9BXX0@mailout2.samsung.com> for
 linux-iio@vger.kernel.org; Tue, 16 Apr 2013 23:37:57 +0900 (KST)
From: Jacek Anaszewski <j.anaszewski@samsung.com>
To: linux-iio@vger.kernel.org, jic23@kernel.org, achew@nvidia.com
Cc: Jacek Anaszewski <j.anaszewski@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>
Subject: [PATCH 1/2] iio: ak8975: Add support for gpios DT property
Date: Tue, 16 Apr 2013 16:37:19 +0200
Message-id: <1366123040-17917-2-git-send-email-j.anaszewski@samsung.com>
In-reply-to: <1366123040-17917-1-git-send-email-j.anaszewski@samsung.com>
References: <1366123040-17917-1-git-send-email-j.anaszewski@samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add support for parsing 'gpios' property when initializing
from oftree.
This patch adds also the binding documentation file.

Signed-off-by: Jacek Anaszewski <j.anaszewski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Andrew Chew <achew@nvidia.com>
---
 .../bindings/staging/iio/magnetometer/ak8975.txt   |   19 +++++++++++++++++++
 drivers/iio/magnetometer/ak8975.c                  |    5 ++++-
 2 files changed, 23 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/staging/iio/magnetometer/ak8975.txt

diff --git a/Documentation/devicetree/bindings/staging/iio/magnetometer/ak8975.txt b/Documentation/devicetree/bindings/staging/iio/magnetometer/ak8975.txt
new file mode 100644
index 0000000..d085d90
--- /dev/null
+++ b/Documentation/devicetree/bindings/staging/iio/magnetometer/ak8975.txt
@@ -0,0 +1,19 @@
+* AsahiKASEI AK8975 device driver
+
+Required properties:
+
+  - compatible : should be "asahi-kasei,ak8975"
+  - reg : the I2C address of the magnetometer
+
+Optional properties:
+
+  - gpios : should be device tree identifier of magnetometer DRDY pin
+
+Example:
+
+ak8975@0C {
+        compatible = "asahi-kasei,ak8975";
+        reg = <0x0C>;
+        gpios = <&gpj0 7 0>;
+};
+
diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index af6c320..eb17eca 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -29,6 +29,7 @@
 #include <linux/delay.h>
 
 #include <linux/gpio.h>
+#include <linux/of_gpio.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -384,7 +385,9 @@ static int ak8975_probe(struct i2c_client *client,
 	int err;
 
 	/* Grab and set up the supplied GPIO. */
-	if (client->dev.platform_data == NULL)
+	if (client->dev.of_node)
+		eoc_gpio = of_get_gpio(client->dev.of_node, 0);
+	else if (client->dev.platform_data == NULL)
 		eoc_gpio = -1;
 	else
 		eoc_gpio = *(int *)(client->dev.platform_data);
-- 
1.7.5.4

