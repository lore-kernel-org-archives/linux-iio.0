Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21455 "EHLO
        sender-of-o52.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbeHaBXN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Aug 2018 21:23:13 -0400
From: Afonso Bordado <afonsobordado@az8.co>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 4/4] MAINTAINERS: add entry for fxas21002c gyro driver
Date: Thu, 30 Aug 2018 22:18:25 +0100
Message-Id: <20180830211825.12202-4-afonsobordado@az8.co>
In-Reply-To: <20180830211825.12202-1-afonsobordado@az8.co>
References: <20180830211825.12202-1-afonsobordado@az8.co>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add entry for fxas21002c gyroscope driver and add myself as
maintainer of this driver.

Signed-off-by: Afonso Bordado <afonsobordado@az8.co>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2b7b24b145f0..faf5f41b1465 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5838,6 +5838,13 @@ L:	linuxppc-dev@lists.ozlabs.org
 S:	Maintained
 F:	drivers/usb/gadget/udc/fsl*
 
+FREESCALE FXAS21002C
+M:	Afonso Bordado <afonsobordado@az8.co>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	drivers/iio/gyro/fxas21002.c
+F:	Documentation/devicetree/bindings/iio/gyroscope/fsl,fxas21002c.txt
+
 FREEVXFS FILESYSTEM
 M:	Christoph Hellwig <hch@infradead.org>
 W:	ftp://ftp.openlinux.org/pub/people/hch/vxfs
-- 
2.18.0
