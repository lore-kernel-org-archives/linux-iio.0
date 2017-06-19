Return-Path: <SRS0=ZnXk=5Y=gmail.com=lorenzo.bianconi83@kernel.org>
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: robert.dolca@intel.com,
	denis.ciocca@st.com,
	linus.walleij@linaro.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	lorenzo.bianconi@st.com
Subject: [PATCH 2/2] dt-bindings: iio: gyro: add L3GD20H sensor device binding
Date: Mon, 19 Jun 2017 22:04:31 +0200
Message-Id: <20170619200431.9615-3-lorenzo.bianconi@st.com>
In-Reply-To: <20170619200431.9615-1-lorenzo.bianconi@st.com>
References: <20170619200431.9615-1-lorenzo.bianconi@st.com>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
---
 Documentation/devicetree/bindings/iio/st-sensors.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/st-sensors.txt b/Documentation/devicetree/bindings/iio/st-sensors.txt
index eaa8fbba34e2..e31457ae6f50 100644
--- a/Documentation/devicetree/bindings/iio/st-sensors.txt
+++ b/Documentation/devicetree/bindings/iio/st-sensors.txt
@@ -52,6 +52,7 @@ Gyroscopes:
 - st,lsm330dl-gyro
 - st,lsm330dlc-gyro
 - st,l3gd20-gyro
+- st,l3gd20h-gyro
 - st,l3g4is-gyro
 - st,lsm330-gyro
 - st,lsm9ds0-gyro
-- 
2.13.1
