Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35848 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752297AbcF1Hkp (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jun 2016 03:40:45 -0400
Received: by mail-pf0-f179.google.com with SMTP id t190so4149480pfb.3
        for <linux-iio@vger.kernel.org>; Tue, 28 Jun 2016 00:40:45 -0700 (PDT)
From: Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Rob Herring <robh+dt@kernel.org>,
	Russell King <linux@arm.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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
Subject: [PATCH v4 3/3] ARM:dts-Add dt node for Broadcom iproc-static-adc
Date: Tue, 28 Jun 2016 13:10:36 +0530
Message-Id: <1467099636-31855-4-git-send-email-raveendra.padasalagi@broadcom.com>
In-Reply-To: <1467099636-31855-1-git-send-email-raveendra.padasalagi@broadcom.com>
References: <1467099636-31855-1-git-send-email-raveendra.padasalagi@broadcom.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch adds DT node for Broadcom's iproc-static-adc
controller driver.

Signed-off-by: Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
---
 arch/arm/boot/dts/bcm-cygnus.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
index b42fe55..fabc9f3 100644
--- a/arch/arm/boot/dts/bcm-cygnus.dtsi
+++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
@@ -366,5 +366,16 @@
 			interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
 		};
+
+		adc: adc@180a6000 {
+			compatible = "brcm,iproc-static-adc";
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

