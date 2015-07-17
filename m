Return-Path: <qingsong.gou@ck-telecom.com>
From: Jandy Gou <qingsong.gou@ck-telecom.com>
To: jic23@kernel.org
Cc: daniel.baluta@intel.com,
	viorel.suman@intel.com,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jandy Gou <qingsong.gou@ck-telecom.com>
Subject: [PATCH 2/2] iio: magnetometer: mmc35240: Add DT binding doc
Date: Fri, 17 Jul 2015 15:35:02 +0800
Message-Id: <1437118502-29625-3-git-send-email-qingsong.gou@ck-telecom.com>
In-Reply-To: <1437118502-29625-1-git-send-email-qingsong.gou@ck-telecom.com>
References: <1437118502-29625-1-git-send-email-qingsong.gou@ck-telecom.com>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jandy Gou <qingsong.gou@ck-telecom.com>
---
 .../devicetree/bindings/iio/magnetometer/mmc35240.txt       | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/mmc35240.txt

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/mmc35240.txt b/Documentation/devicetree/bindings/iio/magnetometer/mmc35240.txt
new file mode 100644
index 0000000..a01235c
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/magnetometer/mmc35240.txt
@@ -0,0 +1,13 @@
+* MEMSIC MMC35240 magnetometer sensor
+
+Required properties:
+
+  - compatible : should be "memsic,mmc35240"
+  - reg : the I2C address of the magnetometer
+
+Example:
+
+mmc35240@30 {
+        compatible = "memsic,mmc35240";
+        reg = <0x30>;
+};
-- 
1.9.1
