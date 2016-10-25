Return-Path: <lorenzo.bianconi83@gmail.com>
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	lorenzo.bianconi@st.com
Subject: [PATCH 2/2] Documentation: dt: iio: accel: add lng2dm sensor device binding
Date: Tue, 25 Oct 2016 23:09:04 +0200
Message-Id: <1477429744-27713-3-git-send-email-lorenzo.bianconi@st.com>
In-Reply-To: <1477429744-27713-1-git-send-email-lorenzo.bianconi@st.com>
References: <1477429744-27713-1-git-send-email-lorenzo.bianconi@st.com>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
---
 Documentation/devicetree/bindings/iio/st-sensors.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/st-sensors.txt b/Documentation/devicetree/bindings/iio/st-sensors.txt
index e41fe34..c040c9a 100644
--- a/Documentation/devicetree/bindings/iio/st-sensors.txt
+++ b/Documentation/devicetree/bindings/iio/st-sensors.txt
@@ -42,6 +42,7 @@ Accelerometers:
 - st,lsm303agr-accel
 - st,lis2dh12-accel
 - st,h3lis331dl-accel
+- st,lng2dm-accel
 
 Gyroscopes:
 - st,l3g4200d-gyro
-- 
2.7.4
