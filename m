Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33006 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752257AbcF1Hk1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jun 2016 03:40:27 -0400
Received: by mail-pa0-f54.google.com with SMTP id b13so3994175pat.0
        for <linux-iio@vger.kernel.org>; Tue, 28 Jun 2016 00:40:27 -0700 (PDT)
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
Subject: [PATCH v4 1/3] Documentation: DT: Add iproc-static-adc binding
Date: Tue, 28 Jun 2016 13:10:34 +0530
Message-Id: <1467099636-31855-2-git-send-email-raveendra.padasalagi@broadcom.com>
In-Reply-To: <1467099636-31855-1-git-send-email-raveendra.padasalagi@broadcom.com>
References: <1467099636-31855-1-git-send-email-raveendra.padasalagi@broadcom.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The patch adds devicetree binding document for broadcom's
iproc-static-adc controller driver.

Signed-off-by: Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
---
 .../bindings/iio/adc/brcm,iproc-static-adc.txt     | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/brcm,iproc-static-adc.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/brcm,iproc-static-adc.txt b/Documentation/devicetree/bindings/iio/adc/brcm,iproc-static-adc.txt
new file mode 100644
index 0000000..caaaed7
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/brcm,iproc-static-adc.txt
@@ -0,0 +1,41 @@
+* Broadcom's IPROC Static ADC controller
+
+Broadcom iProc ADC controller has 8 channels 10bit ADC.
+Allows user to convert analog input voltage values to digital.
+
+Required properties:
+
+- compatible: Must be "brcm,iproc-static-adc"
+
+- adc-syscon: Handler of syscon node defining physical base address of the
+  controller and length of memory mapped region.
+
+- #io-channel-cells = <1>; As ADC has multiple outputs
+  refer to Documentation/devicetree/bindings/iio/iio-bindings.txt for details.
+
+- io-channel-ranges:
+  refer to Documentation/devicetree/bindings/iio/iio-bindings.txt for details.
+
+- clocks: Clock used for this block.
+
+- clock-names: Clock name should be given as tsc_clk.
+
+- interrupts: interrupt line number.
+
+For example:
+
+	ts_adc_syscon: ts_adc_syscon@180a6000 {
+		compatible = "brcm,iproc-ts-adc-syscon","syscon";
+		reg = <0x180a6000 0xc30>;
+	};
+
+	adc: adc@180a6000 {
+		compatible = "brcm,iproc-static-adc";
+		adc-syscon = <&ts_adc_syscon>;
+		#io-channel-cells = <1>;
+		io-channel-ranges;
+		clocks = <&asiu_clks BCM_CYGNUS_ASIU_ADC_CLK>;
+		clock-names = "tsc_clk";
+		interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
-- 
1.9.1

