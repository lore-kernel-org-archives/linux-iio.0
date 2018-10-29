Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-co1nam03on0060.outbound.protection.outlook.com ([104.47.40.60]:34030
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728416AbeJ2U7l (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 29 Oct 2018 16:59:41 -0400
From: Manish Narani <manish.narani@xilinx.com>
To: <jic23@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <michal.simek@xilinx.com>, <manish.narani@xilinx.com>,
        <amit.kucheria@linaro.org>, <sudeep.holla@arm.com>,
        <olof@lixom.net>, <broonie@kernel.org>, <arnaud.pouliquen@st.com>,
        <eugen.hristev@microchip.com>, <linus.walleij@linaro.org>,
        <vilhelm.gray@gmail.com>, <geert@linux-m68k.org>,
        <freeman.liu@spreadtrum.com>, <rdunlap@infradead.org>,
        <tglx@linutronix.de>, <baolin.wang@linaro.org>,
        <gregkh@linuxfoundation.org>, <jdelvare@suse.com>,
        <linux@roeck-us.net>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-hwmon@vger.kernel.org>
Subject: [PATCH v3 3/3] arm64: zynqmp: DT: Add Xilinx AMS node
Date: Mon, 29 Oct 2018 17:40:26 +0530
Message-ID: <1540815026-1012-4-git-send-email-manish.narani@xilinx.com>
In-Reply-To: <1540815026-1012-1-git-send-email-manish.narani@xilinx.com>
References: <1540815026-1012-1-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The Xilinx AMS includes an ADC as well as on-chip sensors that can be
used to sample external and monitor on-die operating conditions, such as
temperature and supply voltage levels.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 29ce234..e5facd8 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -617,5 +617,32 @@
 			reg = <0x0 0xfd4d0000 0x0 0x1000>;
 			timeout-sec = <10>;
 		};
+
+		xilinx_ams: ams@ffa50000 {
+			compatible = "xlnx,zynqmp-ams";
+			status = "disabled";
+			interrupt-parent = <&gic>;
+			interrupts = <0 56 4>;
+			interrupt-names = "ams-irq";
+			reg = <0x0 0xffa50000 0x0 0x800>;
+			reg-names = "ams-base";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			#io-channel-cells = <1>;
+			ranges = <0 0 0xffa50800 0x400
+				  1 0 0xffa50c00 0x400>;
+
+			ams_ps: ams_ps@0,0 {
+				compatible = "xlnx,zynqmp-ams-ps";
+				status = "disabled";
+				reg = <0 0x400>;
+			};
+
+			ams_pl: ams_pl@1,0 {
+				compatible = "xlnx,zynqmp-ams-pl";
+				status = "disabled";
+				reg = <0 0x400>;
+			};
+		};
 	};
 };
-- 
2.1.1
