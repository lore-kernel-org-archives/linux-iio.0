Return-Path: <SRS0=gxlc=LZ=az8.co=afonsobordado@kernel.org>
From: Afonso Bordado <afonsobordado@az8.co>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v4 5/5] MAINTAINERS: add entry for fxas21002c gyro driver
Date: Tue, 11 Sep 2018 16:00:11 +0100
Message-Id: <20180911150011.31964-5-afonsobordado@az8.co>
In-Reply-To: <20180911150011.31964-1-afonsobordado@az8.co>
References: <20180911150011.31964-1-afonsobordado@az8.co>
List-ID: <linux-iio@vger.kernel.org>

Add entry for fxas21002c gyroscope driver and add myself as
maintainer of this driver.

Signed-off-by: Afonso Bordado <afonsobordado@az8.co>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2b9a364b043d..9420f0a8140d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5718,6 +5718,13 @@ S:	Maintained
 F:	drivers/net/ethernet/freescale/gianfar*
 F:	Documentation/devicetree/bindings/net/fsl-tsec-phy.txt
 
+FREESCALE FXAS21002C
+M:	Afonso Bordado <afonsobordado@az8.co>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	drivers/iio/gyro/fxas21002.c
+F:	Documentation/devicetree/bindings/iio/gyroscope/fsl,fxas21002c.txt
+
 FREESCALE GPMI NAND DRIVER
 M:	Han Xu <han.xu@nxp.com>
 L:	linux-mtd@lists.infradead.org
-- 
2.18.0
