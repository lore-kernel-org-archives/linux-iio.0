Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:46497 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753114AbbERJT1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 18 May 2015 05:19:27 -0400
From: Antoine Tenart <antoine.tenart@free-electrons.com>
To: sebastian.hesselbarth@gmail.com, jic23@kernel.org, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net
Cc: Antoine Tenart <antoine.tenart@free-electrons.com>,
	zmxu@marvell.com, jszhang@marvell.com, yrliao@marvell.com,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/3] ARM: berlin: add an ADC node for the BG2Q
Date: Mon, 18 May 2015 11:19:20 +0200
Message-Id: <1431940760-23896-4-git-send-email-antoine.tenart@free-electrons.com>
In-Reply-To: <1431940760-23896-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1431940760-23896-1-git-send-email-antoine.tenart@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch adds the ADC node for the Berlin BG2Q, using the newly added
Berlin IIO ADC driver.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 arch/arm/boot/dts/berlin2q.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
index 187d056f7ad2..97c7e19e3ec6 100644
--- a/arch/arm/boot/dts/berlin2q.dtsi
+++ b/arch/arm/boot/dts/berlin2q.dtsi
@@ -565,6 +565,13 @@
 						function = "twsi3";
 					};
 				};
+
+				adc: adc {
+					compatible = "marvell,berlin2-adc";
+					interrupt-parent = <&sic>;
+					interrupts = <12>, <14>;
+					interrupt-names = "adc", "tsen";
+				};
 			};
 
 			sic: interrupt-controller@e000 {
-- 
2.4.0

