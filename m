Return-Path: <SRS0=Zj+I=KS=onstation.org=masneyb@kernel.org>
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org,
	robh+dt@kernel.org,
	mark.rutland@arm.com,
	andy.gross@linaro.org,
	david.brown@linaro.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-soc@vger.kernel.org
Cc: jonathan@marek.ca,
	jmaneyrol@invensense.com,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	mkelly@xevo.com,
	fischerdouglasc@gmail.com,
	bshah@kde.org,
	ctatlor97@gmail.com
Subject: [PATCH v3 8/9] dt-bindings: iio: tsl2772: add binding for avago,apds9930
Date: Thu,  2 Aug 2018 20:18:59 -0400
Message-Id: <20180803001900.25371-9-masneyb@onstation.org>
In-Reply-To: <20180803001900.25371-1-masneyb@onstation.org>
References: <20180803001900.25371-1-masneyb@onstation.org>
List-ID: <linux-iio@vger.kernel.org>

This patch adds avago,apds9930 to the tsl2772 bindings.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 Documentation/devicetree/bindings/iio/light/tsl2772.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/light/tsl2772.txt b/Documentation/devicetree/bindings/iio/light/tsl2772.txt
index 4e7d98627cbf..1c5e6f17a1df 100644
--- a/Documentation/devicetree/bindings/iio/light/tsl2772.txt
+++ b/Documentation/devicetree/bindings/iio/light/tsl2772.txt
@@ -13,6 +13,7 @@ Required properties:
 		"amstaos,tmd2672"
 		"amstaos,tsl2772"
 		"amstaos,tmd2772"
+		"avago,apds9930"
   - reg: the I2C address of the device
 
 Optional properties:
-- 
2.17.1
