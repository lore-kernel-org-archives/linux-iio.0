Return-Path: <SRS0=zW5g=EX=gmail.com=embed3d@kernel.org>
From: Philipp Rossak <embed3d@gmail.com>
To: lee.jones@linaro.org,
	robh+dt@kernel.org,
	mark.rutland@arm.com,
	maxime.ripard@free-electrons.com,
	wens@csie.org,
	linux@armlinux.org.uk,
	jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	davem@davemloft.net,
	hans.verkuil@cisco.com,
	mchehab@kernel.org,
	rask@formelder.dk,
	clabbe.montjoie@gmail.com,
	sean@mess.org,
	krzk@kernel.org,
	quentin.schulz@free-electrons.com,
	icenowy@aosc.io,
	edu.molinas@gmail.com,
	singhalsimran0@gmail.com
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-sunxi@googlegroups.com
Subject: [PATCH v2 02/16] arm: config: sunxi_defconfig: enable SUN4I_GPADC
Date: Mon, 29 Jan 2018 00:29:05 +0100
Message-Id: <20180128232919.12639-3-embed3d@gmail.com>
In-Reply-To: <20180128232919.12639-1-embed3d@gmail.com>
References: <20180128232919.12639-1-embed3d@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This commit enables the SUN4I_GPADC config option and
sets the value to yes. This is needed to enable the ths sensors.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 arch/arm/configs/sunxi_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
index 5caaf971fb50..52c3990b9d91 100644
--- a/arch/arm/configs/sunxi_defconfig
+++ b/arch/arm/configs/sunxi_defconfig
@@ -131,6 +131,7 @@ CONFIG_DMA_SUN6I=y
 CONFIG_EXTCON=y
 CONFIG_IIO=y
 CONFIG_AXP20X_ADC=y
+CONFIG_SUN4I_GPADC=y
 CONFIG_PWM=y
 CONFIG_PWM_SUN4I=y
 CONFIG_PHY_SUN4I_USB=y
-- 
2.11.0
