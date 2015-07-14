Return-Path: <gizero@gmail.com>
From: Andrea Galbusera <gizero@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Andrea Galbusera <gizero@gmail.com>
Subject: [PATCH 3/4] iio: adc: mcp320x: Kconfig update description
Date: Tue, 14 Jul 2015 15:36:22 +0200
Message-Id: <1436880983-29017-3-git-send-email-gizero@gmail.com>
In-Reply-To: <1436880983-29017-1-git-send-email-gizero@gmail.com>
References: <1436880983-29017-1-git-send-email-gizero@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Andrea Galbusera <gizero@gmail.com>
---
 drivers/iio/adc/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 7c55658..f074b6a 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -207,8 +207,8 @@ config MCP320X
 	depends on SPI
 	help
 	  Say yes here to build support for Microchip Technology's
-	  MCP3001, MCP3002, MCP3004, MCP3008, MCP3201, MCP3202, MCP3204 or
-	  MCP3208 analog to digital converter.
+	  MCP3001, MCP3002, MCP3004, MCP3008, MCP3201, MCP3202, MCP3204,
+	  MCP3208 or MCP3301 analog to digital converter.
 
 	  This driver can also be built as a module. If so, the module will be
 	  called mcp320x.
-- 
1.9.1
