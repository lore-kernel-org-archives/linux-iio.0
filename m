Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:45056 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756149AbdLVPJu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 22 Dec 2017 10:09:50 -0500
From: Eugen Hristev <eugen.hristev@microchip.com>
To: <nicolas.ferre@microchip.com>, <ludovic.desroches@microchip.com>,
        <alexandre.belloni@free-electrons.com>,
        <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jic23@kernel.org>, <linux-input@vger.kernel.org>,
        <dmitry.torokhov@gmail.com>
CC: Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH 01/14] MAINTAINERS: add sama5d2 resistive touchscreen
Date: Fri, 22 Dec 2017 17:07:08 +0200
Message-ID: <1513955241-10985-2-git-send-email-eugen.hristev@microchip.com>
In-Reply-To: <1513955241-10985-1-git-send-email-eugen.hristev@microchip.com>
References: <1513955241-10985-1-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add MAINTAINERS entry for sama5d2 resistive touchscreen driver

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 650aa0e..8beec28 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8957,6 +8957,12 @@ F:	drivers/media/platform/atmel/atmel-isc.c
 F:	drivers/media/platform/atmel/atmel-isc-regs.h
 F:	devicetree/bindings/media/atmel-isc.txt
 
+MICROCHIP / ATMEL SAMA5D2 RESISTIVE TOUCHSCREEN DRIVER
+M:	Eugen Hristev <eugen.hristev@microchip.com>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	drivers/input/touchscreen/sama5d2_rts.c
+
 MICROCHIP KSZ SERIES ETHERNET SWITCH DRIVER
 M:	Woojung Huh <Woojung.Huh@microchip.com>
 M:	Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
-- 
2.7.4

