Return-Path: <SRS0=/wsa=AS=gmail.com=lorenzo.bianconi83@kernel.org>
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	lorenzo.bianconi@st.com,
	devicetree@vger.kernel.org
Subject: [PATCH 4/4] dt-bindings: iio: accel: add LIS3DHH device bindings
Date: Sun, 17 Sep 2017 18:17:12 +0200
Message-Id: <20170917161712.14645-5-lorenzo.bianconi@st.com>
In-Reply-To: <20170917161712.14645-1-lorenzo.bianconi@st.com>
References: <20170917161712.14645-1-lorenzo.bianconi@st.com>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
---
 Documentation/devicetree/bindings/iio/st-sensors.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/st-sensors.txt b/Documentation/devicetree/bindings/iio/st-sensors.txt
index 9cfc82d21792..6f626f73417e 100644
--- a/Documentation/devicetree/bindings/iio/st-sensors.txt
+++ b/Documentation/devicetree/bindings/iio/st-sensors.txt
@@ -47,6 +47,7 @@ Accelerometers:
 - st,lng2dm-accel
 - st,lis3l02dq
 - st,lis2dw12
+- st,lis3dhh
 
 Gyroscopes:
 - st,l3g4200d-gyro
-- 
2.14.1
