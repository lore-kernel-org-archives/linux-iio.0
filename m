Return-Path: <gizero@gmail.com>
From: Andrea Galbusera <gizero@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Andrea Galbusera <gizero@gmail.com>
Subject: [PATCH 4/4] iio: adc: mcp320x: update dt-bindings help
Date: Tue, 14 Jul 2015 15:36:23 +0200
Message-Id: <1436880983-29017-4-git-send-email-gizero@gmail.com>
In-Reply-To: <1436880983-29017-1-git-send-email-gizero@gmail.com>
References: <1436880983-29017-1-git-send-email-gizero@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Andrea Galbusera <gizero@gmail.com>
---
 Documentation/devicetree/bindings/iio/adc/mcp320x.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/mcp320x.txt b/Documentation/devicetree/bindings/iio/adc/mcp320x.txt
index b851843..2a1f3af 100644
--- a/Documentation/devicetree/bindings/iio/adc/mcp320x.txt
+++ b/Documentation/devicetree/bindings/iio/adc/mcp320x.txt
@@ -18,6 +18,7 @@ Required properties:
 				"mcp3202"
 				"mcp3204"
 				"mcp3208"
+				"mcp3301"
 
 
 Examples:
-- 
1.9.1
