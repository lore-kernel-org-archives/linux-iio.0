Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33324 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750980AbdA2Kti (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 29 Jan 2017 05:49:38 -0500
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lorenzo.bianconi@st.com
Subject: [PATCH 3/5] Documentation: dt: iio: imu: st_lsm6dsx: add lsm6dsl sensor device binding
Date: Sun, 29 Jan 2017 11:49:26 +0100
Message-Id: <20170129104928.15533-4-lorenzo.bianconi@st.com>
In-Reply-To: <20170129104928.15533-1-lorenzo.bianconi@st.com>
References: <20170129104928.15533-1-lorenzo.bianconi@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
---
 Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt b/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
index cf81afd..048eca7 100644
--- a/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
+++ b/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
@@ -3,6 +3,7 @@
 Required properties:
 - compatible: must be one of:
   "st,lsm6ds3"
+  "st,lsm6dsl"
   "st,lsm6dsm"
 - reg: i2c address of the sensor / spi cs line
 
-- 
2.9.3

