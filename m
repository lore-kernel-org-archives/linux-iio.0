Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:38382 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751608AbbCTNga (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 20 Mar 2015 09:36:30 -0400
From: Antoine Tenart <antoine.tenart@free-electrons.com>
To: sebastian.hesselbarth@gmail.com, jic23@kernel.org, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net
Cc: Antoine Tenart <antoine.tenart@free-electrons.com>,
	zmxu@marvell.com, jszhang@marvell.com, yrliao@marvell.com,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] ARM: berlin: enable the ADC on the BG2Q DMP
Date: Fri, 20 Mar 2015 14:36:05 +0100
Message-Id: <1426858565-31053-5-git-send-email-antoine.tenart@free-electrons.com>
In-Reply-To: <1426858565-31053-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1426858565-31053-1-git-send-email-antoine.tenart@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

An ADC node is now available in the BG2Q SoC device tree. Enable it on
the BG2Q DMP board.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 arch/arm/boot/dts/berlin2q-marvell-dmp.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/berlin2q-marvell-dmp.dts b/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
index a98ac1bd8f65..a6de0039e5bc 100644
--- a/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
+++ b/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
@@ -112,3 +112,7 @@
 &sata_phy {
 	status = "okay";
 };
+
+&adc {
+	status = "okay";
+};
-- 
2.3.3

