Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33694 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754978AbcK3UGH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 30 Nov 2016 15:06:07 -0500
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lorenzo.bianconi@st.com
Subject: [PATCH v2 2/2] Documentation: dt: iio: add st_lsm6dsx sensor device binding
Date: Wed, 30 Nov 2016 21:05:59 +0100
Message-Id: <20161130200559.29910-3-lorenzo.bianconi@st.com>
In-Reply-To: <20161130200559.29910-1-lorenzo.bianconi@st.com>
References: <20161130200559.29910-1-lorenzo.bianconi@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
---
 .../devicetree/bindings/iio/imu/st_lsm6dsx.txt     | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt

diff --git a/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt b/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
new file mode 100644
index 0000000..ed3cdac
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
@@ -0,0 +1,24 @@
+* ST_LSM6DSx driver for STM 6-axis (acc + gyro) imu Mems sensors
+
+Required properties:
+- compatible: must be one of:
+  "st,lsm6ds3"
+  "st,lsm6dsm"
+- reg: i2c address of the sensor / spi cs line
+
+Optional properties:
+- interrupt-parent: should be the phandle for the interrupt controller
+- interrupts: interrupt mapping for IRQ. It should be configured with
+  flags IRQ_TYPE_LEVEL_HIGH or IRQ_TYPE_EDGE_RISING.
+
+  Refer to interrupt-controller/interrupts.txt for generic interrupt
+  client node bindings.
+
+Example:
+
+lsm6dsm@6b {
+	compatible = "st,lsm6dsm";
+	reg = <0x6b>;
+	interrupt-parent = <&gpio0>;
+	interrupts = <0 IRQ_TYPE_EDGE_RISING>;
+};
-- 
2.9.3

