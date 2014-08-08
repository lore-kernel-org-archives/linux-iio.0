Return-Path: <san@rosetechnology.dk>
Message-ID: <1407488128.6599.4.camel@sanws1.rosetechnology.dk>
Subject: [patch v2 1/3] iio: adc: Kconfig mcp320x change description Add
 more ADCs
From: =?ISO-8859-1?Q?S=F8ren?= Andersen <san@rosetechnology.dk>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org
Date: Fri, 08 Aug 2014 10:55:28 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

v2:
Split the driver patch up to more patches
Don't rename the file

Signed-off-by: Soeren Andersen <san at rosetechnology.dk>
---
 drivers/iio/adc/Kconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index a80d236..f99f35f 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -148,10 +148,11 @@ config MAX1363
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
