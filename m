Return-Path: <ldewangan@nvidia.com>
From: Laxman Dewangan <ldewangan@nvidia.com>
To: grant.likely@secretlab.ca, rob.herring@calxeda.com, rob@landley.net,
        linux@arm.linux.org.uk, jic23@cam.ac.uk, gregkh@linuxfoundation.org,
        swarren@nvidia.com, olof@lixom.net,
        devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-tegra@vger.kernel.org
Cc: Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH V2 3/4] ARM: dt: tegra: enable als and proximity sensor
Date: Mon, 23 Apr 2012 17:41:36 +0530
Message-Id: <1335183097-21104-5-git-send-email-ldewangan@nvidia.com>
In-Reply-To: <1335183097-21104-1-git-send-email-ldewangan@nvidia.com>
References: <1335183097-21104-1-git-send-email-ldewangan@nvidia.com>
List-ID: <linux-iio@vger.kernel.org>

Add the device info for ALS and proximity sensor for tegra
boards cardhu, ventana and seabridge.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
Changes from V1:
- remove labels.
- added interrupt numbers.

 arch/arm/boot/dts/tegra-cardhu.dts   |    8 ++++++++
 arch/arm/boot/dts/tegra-seaboard.dts |    8 ++++++++
 arch/arm/boot/dts/tegra-ventana.dts  |    8 ++++++++
 3 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/tegra-cardhu.dts b/arch/arm/boot/dts/tegra-cardhu.dts
index ab8d901..facb950 100644
--- a/arch/arm/boot/dts/tegra-cardhu.dts
+++ b/arch/arm/boot/dts/tegra-cardhu.dts
@@ -93,6 +93,14 @@
 
 	i2c@7000c500 {
 		clock-frequency = <100000>;
+
+		/* ALS and Proximity sensor */
+		isl29028@44 {
+			compatible = "isil,isl29028";
+			reg = <0x44>;
+			interrupt-parent = <&gpio>;
+			interrupts = <88 0x04>; /*gpio PL0 */
+		};
 	};
 
 	i2c@7000c700 {
diff --git a/arch/arm/boot/dts/tegra-seaboard.dts b/arch/arm/boot/dts/tegra-seaboard.dts
index ed0a2f5..a114183 100644
--- a/arch/arm/boot/dts/tegra-seaboard.dts
+++ b/arch/arm/boot/dts/tegra-seaboard.dts
@@ -270,6 +270,14 @@
 			micdet-delay = <100>;
 			gpio-cfg = < 0xffffffff 0xffffffff 0 0xffffffff 0xffffffff >;
 		};
+
+		/* ALS and proximity sensor */
+		isl29018@44 {
+			compatible = "isil,isl29018";
+			reg = <0x44>;
+			interrupt-parent = <&gpio>;
+			interrupts = < 202 0x04 >; /* GPIO PZ02 */
+		};
 	};
 
 	i2c@7000c400 {
diff --git a/arch/arm/boot/dts/tegra-ventana.dts b/arch/arm/boot/dts/tegra-ventana.dts
index bd074cf..6ea41df 100644
--- a/arch/arm/boot/dts/tegra-ventana.dts
+++ b/arch/arm/boot/dts/tegra-ventana.dts
@@ -256,6 +256,14 @@
 			micdet-delay = <100>;
 			gpio-cfg = < 0xffffffff 0xffffffff 0 0xffffffff 0xffffffff >;
 		};
+
+		/* ALS and proximity sensor */
+		isl29018@44 {
+			compatible = "isil,isl29018";
+			reg = <0x44>;
+			interrupt-parent = <&gpio>;
+			interrupts = <202 0x04>; /*gpio PZ02 */
+		};
 	};
 
 	i2c@7000c400 {
-- 
1.7.1.1
