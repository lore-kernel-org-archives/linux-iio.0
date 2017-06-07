Return-Path: <SRS0=W4DQ=5M=gmail.com=lorenzo.bianconi83@kernel.org>
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	lorenzo.bianconi@st.com
Subject: [PATCH 2/2] Documentation: dt: iio: imu: st_lsm6dsx: support active-low interrupts
Date: Wed,  7 Jun 2017 20:17:11 +0200
Message-Id: <20170607181711.16195-3-lorenzo.bianconi@st.com>
In-Reply-To: <20170607181711.16195-1-lorenzo.bianconi@st.com>
References: <20170607181711.16195-1-lorenzo.bianconi@st.com>
List-ID: <linux-iio@vger.kernel.org>

Update st_lsm6dsx device binding with active-low interrupts support
(IRQ_TYPE_LEVEL_LOW and IRQ_TYPE_EDGE_FALLING).

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
---
 Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt b/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
index 8305fb05ffda..6f28ff55f3ec 100644
--- a/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
+++ b/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
@@ -13,7 +13,8 @@ Optional properties:
   "data ready" (valid values: 1 or 2).
 - interrupt-parent: should be the phandle for the interrupt controller
 - interrupts: interrupt mapping for IRQ. It should be configured with
-  flags IRQ_TYPE_LEVEL_HIGH or IRQ_TYPE_EDGE_RISING.
+  flags IRQ_TYPE_LEVEL_HIGH, IRQ_TYPE_EDGE_RISING, IRQ_TYPE_LEVEL_LOW or
+  IRQ_TYPE_EDGE_FALLING.
 
   Refer to interrupt-controller/interrupts.txt for generic interrupt
   client node bindings.
-- 
2.12.2
