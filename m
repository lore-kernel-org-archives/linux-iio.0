Return-Path: <maitysanchayan@gmail.com>
From: Sanchayan Maity <maitysanchayan@gmail.com>
To: jic23@kernel.org
Cc: shawn.guo@linaro.org,
	kernel@pengutronix.de,
	robh+dt@kernel.org,
	pawel.moll@arm.com,
	mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk,
	galak@codeaurora.org,
	B38611@freescale.com,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stefan@agner.ch,
	Sanchayan Maity <maitysanchayan@gmail.com>
Subject: [PATCH v3 2/2] ARM: dts: vf-colibri: Add property for minimum sample time
Date: Tue, 14 Jul 2015 19:23:23 +0530
Message-Id: <20e2cfad3fbb1a45332e9936ea493ddc8bfaf51d.1436880513.git.maitysanchayan@gmail.com>
In-Reply-To: <cover.1436880513.git.maitysanchayan@gmail.com>
References: <cover.1436880513.git.maitysanchayan@gmail.com>
In-Reply-To: <cover.1436880513.git.maitysanchayan@gmail.com>
References: <cover.1436880513.git.maitysanchayan@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Add a device tree property which allows to specify the minimum sample
time which can be used to calculate the actual ADC cycles required
depending on the hardware.

Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
---
 arch/arm/boot/dts/vf-colibri.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/vf-colibri.dtsi b/arch/arm/boot/dts/vf-colibri.dtsi
index ab10d2e..59f5deb 100644
--- a/arch/arm/boot/dts/vf-colibri.dtsi
+++ b/arch/arm/boot/dts/vf-colibri.dtsi
@@ -16,10 +16,12 @@
 };
 
 &adc0 {
+	min-sample-time = <1000>;
 	status = "okay";
 };
 
 &adc1 {
+	min-sample-time = <1000>;
 	status = "okay";
 };
 
-- 
2.4.5
