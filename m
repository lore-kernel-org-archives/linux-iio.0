Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: devicetree-discuss@lists.ozlabs.org
Cc: jic23@kernel.org,
	rob.herring@calxeda.com,
	grant.likely@secretlab.ca,
	linux-iio@vger.kernel.org,
	sachin.kamat@linaro.org,
	patches@linaro.org
Subject: [PATCH 1/1] iio: exynos-adc: Fix typo in DT documentation
Date: Tue, 26 Mar 2013 17:22:57 +0530
Message-Id: <1364298777-8178-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

Fixes some typos in the documentation of exynos-adc.txt.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 .../devicetree/bindings/arm/samsung/exynos-adc.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/samsung/exynos-adc.txt b/Documentation/devicetree/bindings/arm/samsung/exynos-adc.txt
index 05e9d95..1fc744b 100644
--- a/Documentation/devicetree/bindings/arm/samsung/exynos-adc.txt
+++ b/Documentation/devicetree/bindings/arm/samsung/exynos-adc.txt
@@ -1,6 +1,6 @@
 Samsung Exynos Analog to Digital Converter bindings
 
-This devicetree binding are for the new adc driver written fori
+The devicetree bindings are for the new ADC driver written for
 Exynos4 and upward SoCs from Samsung.
 
 New driver handles the following
@@ -49,4 +49,4 @@ adc@12D10000 {
 };
 
 Note: Does not apply to ADC driver under arch/arm/plat-samsung/
-Note: The child node can be added under the adc node or seperately.
+Note: The child node can be added under the adc node or separately.
-- 
1.7.4.1
