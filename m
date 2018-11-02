Return-Path: <SRS0=oaKA=NN=gmail.com=songqiang1304521@kernel.org>
From: Song Qiang <songqiang1304521@gmail.com>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	robh+dt@kernel.org,
	mark.rutland@arm.com,
	preid@electromag.com.au,
	himanshujha199640@gmail.com
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Song Qiang <songqiang1304521@gmail.com>
Subject: [PATCH v5 1/3] dt-bindings: Add PNI to the vendor prefixes.
Date: Fri,  2 Nov 2018 15:42:07 +0800
Message-Id: <20181102074209.12620-2-songqiang1304521@gmail.com>
In-Reply-To: <20181102074209.12620-1-songqiang1304521@gmail.com>
References: <20181102074209.12620-1-songqiang1304521@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Song Qiang <songqiang1304521@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 4b1a2a8fcc16..adcdf60124dd 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -303,6 +303,7 @@ pixcir  PIXCIR MICROELECTRONICS Co., Ltd
 plathome	Plat'Home Co., Ltd.
 plda	PLDA
 plx	Broadcom Corporation (formerly PLX Technology)
+pni     PNI Sensor Corporation
 portwell	Portwell Inc.
 poslab	Poslab Technology Co., Ltd.
 powervr	PowerVR (deprecated, use img)
-- 
2.17.1
