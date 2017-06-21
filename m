Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33054 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751041AbdFUTVf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 21 Jun 2017 15:21:35 -0400
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lorenzo.bianconi@st.com
Subject: [PATCH 2/2] dt-bindings: iio: imu: st_lsm6dsx: support open drain mode
Date: Wed, 21 Jun 2017 21:21:29 +0200
Message-Id: <20170621192129.10226-3-lorenzo.bianconi@st.com>
In-Reply-To: <20170621192129.10226-1-lorenzo.bianconi@st.com>
References: <20170621192129.10226-1-lorenzo.bianconi@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
---
 Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt b/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
index 6f28ff55f3ec..1ff1af799c76 100644
--- a/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
+++ b/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
@@ -11,6 +11,14 @@ Required properties:
 Optional properties:
 - st,drdy-int-pin: the pin on the package that will be used to signal
   "data ready" (valid values: 1 or 2).
+- drive-open-drain: the interrupt/data ready line will be configured
+  as open drain, which is useful if several sensors share the same
+  interrupt line. This is a boolean property.
+  (This binding is taken from pinctrl/pinctrl-bindings.txt)
+  If the requested interrupt is configured as IRQ_TYPE_LEVEL_HIGH or
+  IRQ_TYPE_EDGE_RISING a pull-down resistor is needed to drive the line
+  when it is not active, whereas a pull-up one is needed when interrupt
+  line is configured as IRQ_TYPE_LEVEL_LOW or IRQ_TYPE_EDGE_FALLING.
 - interrupt-parent: should be the phandle for the interrupt controller
 - interrupts: interrupt mapping for IRQ. It should be configured with
   flags IRQ_TYPE_LEVEL_HIGH, IRQ_TYPE_EDGE_RISING, IRQ_TYPE_LEVEL_LOW or
-- 
2.13.1

