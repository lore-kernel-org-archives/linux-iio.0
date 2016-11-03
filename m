Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from up.free-electrons.com ([163.172.77.33]:33331 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752138AbcKCKQU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 3 Nov 2016 06:16:20 -0400
From: Quentin Schulz <quentin.schulz@free-electrons.com>
To: linux@armlinux.org.uk, maxime.ripard@free-electrons.com,
        wens@csie.org, jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, dmitry.torokhov@gmail.com, lee.jones@linaro.org
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>,
        antoine.tenart@free-electrons.com,
        thomas.petazzoni@free-electrons.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-input@vger.kernel.org
Subject: [PATCH v7 2/3] ARM: sunxi_defconfig: Add CONFIG_THERMAL_OF
Date: Thu,  3 Nov 2016 11:16:00 +0100
Message-Id: <20161103101601.24529-3-quentin.schulz@free-electrons.com>
In-Reply-To: <20161103101601.24529-1-quentin.schulz@free-electrons.com>
References: <20161103101601.24529-1-quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This enables CONFIG_THERMAL_OF by default for sunxi_defconfig.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---

added in v7

 arch/arm/configs/sunxi_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
index 714da33..8aaeae3 100644
--- a/arch/arm/configs/sunxi_defconfig
+++ b/arch/arm/configs/sunxi_defconfig
@@ -83,6 +83,7 @@ CONFIG_GPIO_SYSFS=y
 CONFIG_POWER_SUPPLY=y
 CONFIG_AXP20X_POWER=y
 CONFIG_THERMAL=y
+CONFIG_THERMAL_OF=y
 CONFIG_CPU_THERMAL=y
 CONFIG_WATCHDOG=y
 CONFIG_SUNXI_WATCHDOG=y
-- 
2.9.3

