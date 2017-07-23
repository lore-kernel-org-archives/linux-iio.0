Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from hermes.aosc.io ([199.195.250.187]:36653 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755417AbdGWOOu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 23 Jul 2017 10:14:50 -0400
From: Icenowy Zheng <icenowy@aosc.io>
To: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH v3 5/5] ARM: sun8i: h3: add partial CPU thermal zone
Date: Sun, 23 Jul 2017 22:13:54 +0800
Message-Id: <20170723141354.42646-6-icenowy@aosc.io>
In-Reply-To: <20170723141354.42646-1-icenowy@aosc.io>
References: <20170723141354.42646-1-icenowy@aosc.io>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Because of the restriction of the OF thermal framework, the thermal
sensor will fail to probe if the thermal zone doesn't exist.

Add a partial thermal zone which claims the H3 THS as the thermal sensor.

The cooling device (CPU DVFS) is still not added as it's not ready, and
the trip points are also not added yet.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm/boot/dts/sun8i-h3.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index efe3a8e4f2af..551efecaab5d 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -125,6 +125,15 @@
 		};
 	};
 
+	thermal-zones {
+		cpu-thermal {
+			/* milliseconds */
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+			thermal-sensors = <&ths>;
+		};
+	};
+
 	timer {
 		compatible = "arm,armv7-timer";
 		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-- 
2.13.0

