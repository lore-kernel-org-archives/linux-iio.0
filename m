Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51246 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759940Ab3GSJ2T (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 19 Jul 2013 05:28:19 -0400
From: Oleksandr Kozaruk <oleksandr.kozaruk@ti.com>
To: <tony@atomide.com>, <benoit.cousson@linaro.org>, <rnayak@ti.com>,
	<peter.ujfalusi@ti.com>, <kishon@ti.com>, <jic23@cam.ac.uk>,
	<grant.likely@linaro.org>, <rob.herring@calxeda.com>,
	<lars@metafoo.de>, <sameo@linux.intel.com>,
	<ch.naveen@samsung.com>, <poeschel@lemonage.de>, <milo.kim@ti.com>,
	<balajitk@ti.com>, <gg@slimlogic.co.uk>
CC: <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree-discuss@lists.ozlabs.org>, <linux-omap@vger.kernel.org>
Subject: [PATCH v6 1/2] ARM: dts: twl: Add GPADC data to device tree
Date: Fri, 19 Jul 2013 12:27:18 +0300
Message-ID: <1374226039-16943-2-git-send-email-oleksandr.kozaruk@ti.com>
In-Reply-To: <1374226039-16943-1-git-send-email-oleksandr.kozaruk@ti.com>
References: <1374226039-16943-1-git-send-email-oleksandr.kozaruk@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

GPADC is the general purpose ADC present on twl6030.
The dt data is interrupt used to trigger end of ADC
conversion.

Signed-off-by: Oleksandr Kozaruk <oleksandr.kozaruk@ti.com>
---
 arch/arm/boot/dts/twl6030.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/twl6030.dtsi b/arch/arm/boot/dts/twl6030.dtsi
index 2e3bd31..d7d4c28 100644
--- a/arch/arm/boot/dts/twl6030.dtsi
+++ b/arch/arm/boot/dts/twl6030.dtsi
@@ -103,4 +103,10 @@
 		compatible = "ti,twl6030-pwmled";
 		#pwm-cells = <2>;
 	};
+
+	adc: gpadc {
+		compatible = "ti,twl6030-gpadc";
+		interrupts = <3>;
+		#io-channel-cells = <1>;
+	};
 };
-- 
1.8.1.2

