Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-eopbgr710049.outbound.protection.outlook.com ([40.107.71.49]:37917
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726527AbeINMcs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 14 Sep 2018 08:32:48 -0400
From: Manish Narani <manish.narani@xilinx.com>
To: <jic23@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <michal.simek@xilinx.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <manish.narani@xilinx.com>, <sudeep.holla@arm.com>,
        <amit.kucheria@linaro.org>, <leoyang.li@nxp.com>,
        <broonie@kernel.org>, <arnaud.pouliquen@st.com>,
        <eugen.hristev@microchip.com>, <rdunlap@infradead.org>,
        <geert@linux-m68k.org>, <ak@it-klinger.de>,
        <freeman.liu@spreadtrum.com>, <lukas@wunner.de>,
        <vilhelm.gray@gmail.com>, <gregkh@linuxfoundation.org>,
        <kstewart@linuxfoundation.org>
CC: <sgoud@xilinx.com>, <anirudh@xilinx.com>,
        <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v2 4/4] arm64: zynqmp: DT: Add Xilinx AMS node
Date: Fri, 14 Sep 2018 12:48:30 +0530
Message-ID: <1536909510-7166-5-git-send-email-manish.narani@xilinx.com>
In-Reply-To: <1536909510-7166-1-git-send-email-manish.narani@xilinx.com>
References: <1536909510-7166-1-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The Xilinx AMS includes an ADC as well as on-chip sensors that can be
used to sample external and monitor on-die operating conditions, such as
temperature and supply voltage levels.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 29ce234..6e42ca2 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -617,5 +617,31 @@
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
+			#address-cells = <2>;
+			#size-cells = <2>;
+			#io-channel-cells = <1>;
+			ranges;
+
+			ams_ps: ams_ps@ffa50800 {
+				compatible = "xlnx,zynqmp-ams-ps";
+				status = "disabled";
+				reg = <0x0 0xffa50800 0x0 0x400>;
+			};
+
+			ams_pl: ams_pl@ffa50c00 {
+				compatible = "xlnx,zynqmp-ams-pl";
+				status = "disabled";
+				reg = <0x0 0xffa50c00 0x0 0x400>;
+			};
+		};
 	};
 };
-- 
2.1.1
