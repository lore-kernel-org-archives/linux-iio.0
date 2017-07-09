Return-Path: <SRS0=3AiK=6M=gmail.com=lorenzo.bianconi83@kernel.org>
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	lorenzo.bianconi@st.com
Subject: [PATCH 8/9] dt-bindings: iio: humidity: hts221: support open drain mode
Date: Sun,  9 Jul 2017 18:57:03 +0200
Message-Id: <20170709165704.26311-9-lorenzo.bianconi@st.com>
In-Reply-To: <20170709165704.26311-1-lorenzo.bianconi@st.com>
References: <20170709165704.26311-1-lorenzo.bianconi@st.com>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
---
 Documentation/devicetree/bindings/iio/humidity/hts221.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/humidity/hts221.txt b/Documentation/devicetree/bindings/iio/humidity/hts221.txt
index fca263e13400..732b83c06c08 100644
--- a/Documentation/devicetree/bindings/iio/humidity/hts221.txt
+++ b/Documentation/devicetree/bindings/iio/humidity/hts221.txt
@@ -5,6 +5,14 @@ Required properties:
 - reg: i2c address of the sensor / spi cs line
 
 Optional properties:
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
