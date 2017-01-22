Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35175 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751000AbdAVKa7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Jan 2017 05:30:59 -0500
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lorenzo.bianconi@st.com
Subject: [PATCH 2/2] Documentation: dt: iio: imu: st_lsm6dsx: add st,drdy-int-pin property
Date: Sun, 22 Jan 2017 11:30:52 +0100
Message-Id: <20170122103052.8769-3-lorenzo.bianconi@st.com>
In-Reply-To: <20170122103052.8769-1-lorenzo.bianconi@st.com>
References: <20170122103052.8769-1-lorenzo.bianconi@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add st,drdy-int-pin property to select interrupt pin of the package

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
---
 Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt b/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
index ed3cdac..cf81afd 100644
--- a/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
+++ b/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
@@ -7,6 +7,8 @@ Required properties:
 - reg: i2c address of the sensor / spi cs line
 
 Optional properties:
+- st,drdy-int-pin: the pin on the package that will be used to signal
+  "data ready" (valid values: 1 or 2).
 - interrupt-parent: should be the phandle for the interrupt controller
 - interrupts: interrupt mapping for IRQ. It should be configured with
   flags IRQ_TYPE_LEVEL_HIGH or IRQ_TYPE_EDGE_RISING.
-- 
2.9.3

