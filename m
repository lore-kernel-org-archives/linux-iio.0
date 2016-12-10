Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wj0-f194.google.com ([209.85.210.194]:33406 "EHLO
        mail-wj0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752180AbcLJJC1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 10 Dec 2016 04:02:27 -0500
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lorenzo.bianconi@st.com
Subject: [PATCH v3 2/2] Documentation: dt: iio: add st_lsm6dsx sensor device binding
Date: Sat, 10 Dec 2016 10:02:18 +0100
Message-Id: <20161210090218.4609-3-lorenzo.bianconi@st.com>
In-Reply-To: <20161210090218.4609-1-lorenzo.bianconi@st.com>
References: <20161210090218.4609-1-lorenzo.bianconi@st.com>
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

