Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from dmz4.rosetechnology.dk ([5.206.196.244]:50705 "EHLO
	dmz4.rosetechnology.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752780AbbCJVUU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 10 Mar 2015 17:20:20 -0400
Message-ID: <1426021927.5476.36.camel@sanws1.rosetechnology.dk>
Subject: [patch 1/2] iio: adc: Kconfig mcp320x change description Add more
 ADCs
From: =?ISO-8859-1?Q?S=F8ren?= Andersen <san@rosetechnology.dk>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org
Date: Tue, 10 Mar 2015 22:12:07 +0100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

I once submitted patches for adding support for more mcp ADCs
But it seams that not all the patches is in the new kernel, so I try to resubmit

Signed-off-by: Soeren Andersen <san at rosetechnology.dk>
---
 drivers/iio/adc/Kconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 202daf8..9eaa8d1 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -186,10 +186,11 @@ config MAX1363
 	  data via the iio dev interface.
 
 config MCP320X
-	tristate "Microchip Technology MCP3204/08"
+	tristate "Microchip Technology MCP3x01/02/04/08"
 	depends on SPI
 	help
-	  Say yes here to build support for Microchip Technology's MCP3204 or
+	  Say yes here to build support for Microchip Technology's
+	  MCP3001, MCP3002, MCP3004, MCP3008, MCP3201, MCP3202, MCP3204 or
 	  MCP3208 analog to digital converter.
 
 	  This driver can also be built as a module. If so, the module will be


