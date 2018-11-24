Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45066 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbeKYJEG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 25 Nov 2018 04:04:06 -0500
From: Tomasz Duszynski <tduszyns@gmail.com>
To: linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tomasz Duszynski <tduszyns@gmail.com>
Subject: [PATCH 3/3] iio: chemical: sps30: add device tree support
Date: Sat, 24 Nov 2018 23:14:15 +0100
Message-Id: <20181124221415.10081-4-tduszyns@gmail.com>
In-Reply-To: <20181124221415.10081-1-tduszyns@gmail.com>
References: <20181124221415.10081-1-tduszyns@gmail.com>
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add device tree support for Sensirion SPS30 particulate
matter sensor.

Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
---
 .../bindings/iio/chemical/sensirion,sps30.txt        | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/sensirion,sps30.txt

diff --git a/Documentation/devicetree/bindings/iio/chemical/sensirion,sps30.txt b/Documentation/devicetree/bindings/iio/chemical/sensirion,sps30.txt
new file mode 100644
index 000000000000..6eee2709b5b6
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/chemical/sensirion,sps30.txt
@@ -0,0 +1,12 @@
+* Sensirion SPS30 particulate matter sensor
+
+Required properties:
+- compatible: must be "sensirion,sps30"
+- reg: the I2C address of the sensor
+
+Example:
+
+sps30@69 {
+	compatible = "sensirion,sps30";
+	reg = <0x69>;
+};
-- 
2.19.2
