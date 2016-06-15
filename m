Return-Path: <raveendra.padasalagi@broadcom.com>
From: Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Russell King <linux@arm.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Jonathan Richardson <jonathar@broadcom.com>,
	Jon Mason <jonmason@broadcom.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Anup Patel <anup.patel@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Pramod Kumar <pramod.kumar@broadcom.com>,
	linux-kernel@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
Subject: [PATCH 3/3] ARM:dts-Add dt node for Broadcom iproc-static-adc
Date: Wed, 15 Jun 2016 12:08:41 +0530
Message-Id: <1465972721-7639-4-git-send-email-raveendra.padasalagi@broadcom.com>
In-Reply-To: <1465972721-7639-1-git-send-email-raveendra.padasalagi@broadcom.com>
References: <1465972721-7639-1-git-send-email-raveendra.padasalagi@broadcom.com>
List-ID: <linux-iio@vger.kernel.org>

This patch adds DT node for Broadcom's iproc-static-adc
controller driver.

Signed-off-by: Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
---
 arch/arm/boot/dts/bcm-cygnus.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
index b42fe55..317b53b 100644
--- a/arch/arm/boot/dts/bcm-cygnus.dtsi
+++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
@@ -366,5 +366,18 @@
 			interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
 		};
+
+		adc: adc@180a6000 {
+			compatible = "brcm,iproc-static-adc";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			#io-channel-cells = <1>;
+			io-channel-ranges;
+			adc-syscon = <&ts_adc_syscon>;
+			clocks = <&asiu_clks BCM_CYGNUS_ASIU_ADC_CLK>;
+			clock-names = "tsc_clk";
+			interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
 	};
 };
-- 
1.9.1
