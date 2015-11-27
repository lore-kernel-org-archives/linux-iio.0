Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:51228 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751165AbbK0NxA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 27 Nov 2015 08:53:00 -0500
From: Sascha Hauer <s.hauer@pengutronix.de>
To: linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	devicetree@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: iio: adc: Update mcp342x binding for the mcp3421
Date: Fri, 27 Nov 2015 14:52:52 +0100
Message-Id: <1448632372-5315-3-git-send-email-s.hauer@pengutronix.de>
In-Reply-To: <1448632372-5315-1-git-send-email-s.hauer@pengutronix.de>
References: <1448632372-5315-1-git-send-email-s.hauer@pengutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The mcp3421 is the single channel variant of the mcp342x family and
can be supported by the mcp342x driver.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Cc: devicetree@vger.kernel.org
---
 Documentation/devicetree/bindings/iio/adc/mcp3422.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/mcp3422.txt b/Documentation/devicetree/bindings/iio/adc/mcp3422.txt
index 333139c..dcae4cc 100644
--- a/Documentation/devicetree/bindings/iio/adc/mcp3422.txt
+++ b/Documentation/devicetree/bindings/iio/adc/mcp3422.txt
@@ -1,7 +1,8 @@
-* Microchip mcp3422/3/4/6/7/8 chip family (ADC)
+* Microchip mcp3421/2/3/4/6/7/8 chip family (ADC)
 
 Required properties:
  - compatible: Should be
+	"microchip,mcp3421" or
 	"microchip,mcp3422" or
 	"microchip,mcp3423" or
 	"microchip,mcp3424" or
-- 
2.6.2

