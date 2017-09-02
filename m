Return-Path: <SRS0=N6O5=AD=gmail.com=lorenzo.bianconi83@kernel.org>
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	lorenzo.bianconi@st.com,
	devicetree@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: iio: pressure: add LPS33HW and LPS35HW device bindings
Date: Sat,  2 Sep 2017 19:39:15 +0200
Message-Id: <20170902173915.17341-3-lorenzo.bianconi@st.com>
In-Reply-To: <20170902173915.17341-1-lorenzo.bianconi@st.com>
References: <20170902173915.17341-1-lorenzo.bianconi@st.com>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
---
 Documentation/devicetree/bindings/iio/st-sensors.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/st-sensors.txt b/Documentation/devicetree/bindings/iio/st-sensors.txt
index be64357808d0..9cfc82d21792 100644
--- a/Documentation/devicetree/bindings/iio/st-sensors.txt
+++ b/Documentation/devicetree/bindings/iio/st-sensors.txt
@@ -72,3 +72,5 @@ Pressure sensors:
 - st,lps25h-press
 - st,lps331ap-press
 - st,lps22hb-press
+- st,lps33hw
+- st,lps35hw
-- 
2.14.1
