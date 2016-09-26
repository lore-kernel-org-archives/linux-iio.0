Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:33583 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936198AbcIZTsM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 26 Sep 2016 15:48:12 -0400
Received: by mail-lf0-f66.google.com with SMTP id l131so10624190lfl.0
        for <linux-iio@vger.kernel.org>; Mon, 26 Sep 2016 12:48:11 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, lorenzo.bianconi@st.com
Subject: [PATCH 2/2] Documentation: dt: iio: add st_lsm6dsx sensor device binding
Date: Mon, 26 Sep 2016 21:48:04 +0200
Message-Id: <1474919284-20898-3-git-send-email-lorenzo.bianconi@st.com>
In-Reply-To: <1474919284-20898-1-git-send-email-lorenzo.bianconi@st.com>
References: <1474919284-20898-1-git-send-email-lorenzo.bianconi@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
---
 .../devicetree/bindings/iio/imu/st_lsm6dsx.txt       | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt

diff --git a/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt b/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
new file mode 100644
index 0000000..9f7b3a5
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
@@ -0,0 +1,20 @@
+* ST_LSM6DSX driver for STM LSM6DS3-LSM6DSM 6-axis (acc + gyro) Mems sensor
+
+Required properties:
+- compatible: must be one of:
+  "st,lsm6ds3"
+  "st,lsm6dsm"
+- reg: i2c address of the sensor / spi cs line
+
+Optional properties:
+- interrupts: interrupt mapping for GPIO IRQ
+- interrupt-parent: should be the phandle for the interrupt controller
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
2.7.4

