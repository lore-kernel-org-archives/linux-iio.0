Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f67.google.com ([209.85.220.67]:32912 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756070AbcGZMNf (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 26 Jul 2016 08:13:35 -0400
From: Caesar Wang <wxt@rock-chips.com>
To: jic23@kernel.org, heiko@sntech.de
Cc: devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	john@metanate.com, dianders@chromium.org, linux@roeck-us.net,
	Caesar Wang <wxt@rock-chips.com>
Subject: [PATCH v2 3/4] arm64: dts: rockchip: add reset saradc node for rk3368 SoCs
Date: Tue, 26 Jul 2016 20:13:14 +0800
Message-Id: <1469535195-5227-3-git-send-email-wxt@rock-chips.com>
In-Reply-To: <1469535195-5227-1-git-send-email-wxt@rock-chips.com>
References: <1469535195-5227-1-git-send-email-wxt@rock-chips.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

SARADC controller needs to be reset before programming it, otherwise
it will not function properly.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

Changes in v2: None

 arch/arm64/boot/dts/rockchip/rk3368.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
index d02a9003..4f44d11 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
@@ -270,6 +270,8 @@
 		#io-channel-cells = <1>;
 		clocks = <&cru SCLK_SARADC>, <&cru PCLK_SARADC>;
 		clock-names = "saradc", "apb_pclk";
+		resets = <&cru SRST_SARADC>;
+		reset-names = "saradc-apb";
 		status = "disabled";
 	};
 
-- 
1.9.1

