Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:62519 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727575AbeGSPfv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Jul 2018 11:35:51 -0400
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <jic23@kernel.org>, <robh+dt@kernel.org>
CC: <mark.rutland@arm.com>, <arnaud.pouliquen@st.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] dt-bindings: iio: sigma-delta-modulator: fix unit-address in example
Date: Thu, 19 Jul 2018 16:51:50 +0200
Message-ID: <1532011910-11641-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Device tree compiler gives a warning if a device node has "@"
but no reg property.
Fix the example in iio: adc: sigma-delta-modulator.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.txt b/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.txt
index ba24ca7..59b92cd 100644
--- a/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.txt
+++ b/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.txt
@@ -7,7 +7,7 @@ Required properties:
 
 Example node:
 
-	ads1202: adc@0 {
+	ads1202: adc {
 		compatible = "sd-modulator";
 		#io-channel-cells = <0>;
 	};
-- 
1.9.1

