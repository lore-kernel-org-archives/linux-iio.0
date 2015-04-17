Return-Path: <irina.tirdea@intel.com>
From: Irina Tirdea <irina.tirdea@intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH 3/3] iio: magn: bmc150_magn: Add devicetree binding documentation
Date: Fri, 17 Apr 2015 13:50:30 +0300
Message-Id: <1429267830-13681-4-git-send-email-irina.tirdea@intel.com>
In-Reply-To: <1429267830-13681-1-git-send-email-irina.tirdea@intel.com>
References: <1429267830-13681-1-git-send-email-irina.tirdea@intel.com>
List-ID: <linux-iio@vger.kernel.org>

Add binding documentation for Bosch BMC150 magnetometer.

Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
---
 .../bindings/iio/magnetometer/bmc150_magn.txt        | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/bmc150_magn.txt

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/bmc150_magn.txt b/Documentation/devicetree/bindings/iio/magnetometer/bmc150_magn.txt
new file mode 100644
index 0000000..4ed035c
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/magnetometer/bmc150_magn.txt
@@ -0,0 +1,20 @@
+* Bosch BMC150 magnetometer sensor
+
+http://ae-bst.resource.bosch.com/media/products/dokumente/bmc150/BST-BMC150-DS000-04.pdf
+
+Required properties:
+
+  - compatible : should be "bosch,bmc150_magn"
+  - reg : the I2C address of the magnetometer
+
+Optional properties:
+
+  - gpios : should be device tree identifier of the magnetometer DRDY pin
+
+Example:
+
+bmc150_magn@12 {
+        compatible = "bosch,bmc150_magn";
+        reg = <0x12>;
+        interrupt-gpio = <&gpio1 0 1>;
+};
-- 
1.9.1
