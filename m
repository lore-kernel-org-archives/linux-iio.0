Return-Path: <SRS0=C534=6U=gmail.com=lorenzo.bianconi83@kernel.org>
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	lorenzo.bianconi@st.com
Subject: [PATCH v2 07/10] dt-bindings: iio: humidity: hts221: support active-low interrupts
Date: Mon, 17 Jul 2017 19:39:02 +0200
Message-Id: <20170717173905.8209-8-lorenzo.bianconi@st.com>
In-Reply-To: <20170717173905.8209-1-lorenzo.bianconi@st.com>
References: <20170717173905.8209-1-lorenzo.bianconi@st.com>
List-ID: <linux-iio@vger.kernel.org>

Update hts221 device binding with active-low interrupts support
(IRQ_TYPE_LEVEL_LOW and IRQ_TYPE_EDGE_FALLING).

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
---
 Documentation/devicetree/bindings/iio/humidity/hts221.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/humidity/hts221.txt b/Documentation/devicetree/bindings/iio/humidity/hts221.txt
index b20ab9c12080..fca263e13400 100644
--- a/Documentation/devicetree/bindings/iio/humidity/hts221.txt
+++ b/Documentation/devicetree/bindings/iio/humidity/hts221.txt
@@ -7,7 +7,8 @@ Required properties:
 Optional properties:
 - interrupt-parent: should be the phandle for the interrupt controller
 - interrupts: interrupt mapping for IRQ. It should be configured with
-  flags IRQ_TYPE_LEVEL_HIGH or IRQ_TYPE_EDGE_RISING.
+  flags IRQ_TYPE_LEVEL_HIGH, IRQ_TYPE_EDGE_RISING, IRQ_TYPE_LEVEL_LOW or
+  IRQ_TYPE_EDGE_FALLING.
 
   Refer to interrupt-controller/interrupts.txt for generic interrupt
   client node bindings.
-- 
2.13.2
