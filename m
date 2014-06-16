Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp6-g21.free.fr ([212.27.42.6]:53982 "EHLO smtp6-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754967AbaFPJ3W (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 16 Jun 2014 05:29:22 -0400
From: Denis Carikli <denis@eukrea.com>
To: Shawn Guo <shawn.guo@linaro.org>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Hartmut Knaack <knaack.h@gmx.de>
Cc: =?UTF-8?q?Eric=20B=C3=A9nard?= <eric@eukrea.com>,
	Sascha Hauer <kernel@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org,
	Lee Jones <lee.jones@linaro.org>, linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Markus Pargmann <mpa@pengutronix.de>,
	Denis Carikli <denis@eukrea.com>
Subject: [PATCH v3 6/6] ARM: imx_v4_v5_defconfig: Add I.MX25 Touchscreen controller and ADC support.
Date: Mon, 16 Jun 2014 11:28:53 +0200
Message-Id: <1402910933-20534-6-git-send-email-denis@eukrea.com>
In-Reply-To: <1402910933-20534-1-git-send-email-denis@eukrea.com>
References: <1402910933-20534-1-git-send-email-denis@eukrea.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Denis Carikli <denis@eukrea.com>
---
Changelog v2->v3:
- Added ADC support, splitting it would be overkill.
---
 arch/arm/configs/imx_v4_v5_defconfig |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/configs/imx_v4_v5_defconfig b/arch/arm/configs/imx_v4_v5_defconfig
index 397f43c..580c367 100644
--- a/arch/arm/configs/imx_v4_v5_defconfig
+++ b/arch/arm/configs/imx_v4_v5_defconfig
@@ -98,6 +98,7 @@ CONFIG_KEYBOARD_IMX=y
 # CONFIG_INPUT_MOUSE is not set
 CONFIG_INPUT_TOUCHSCREEN=y
 CONFIG_TOUCHSCREEN_ADS7846=m
+CONFIG_TOUCHSCREEN_MX25=y
 CONFIG_TOUCHSCREEN_MC13783=y
 # CONFIG_LEGACY_PTYS is not set
 CONFIG_SERIAL_8250=m
@@ -118,6 +119,7 @@ CONFIG_HWMON=m
 CONFIG_SENSORS_MC13783_ADC=m
 CONFIG_WATCHDOG=y
 CONFIG_IMX2_WDT=y
+CONFIG_MFD_MX25_TSADC=y
 CONFIG_MFD_MC13XXX_SPI=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
@@ -184,6 +186,8 @@ CONFIG_DMADEVICES=y
 CONFIG_IMX_SDMA=y
 CONFIG_IMX_DMA=y
 # CONFIG_IOMMU_SUPPORT is not set
+CONFIG_IIO=y
+CONFIG_FSL_MX25_ADC=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 CONFIG_EXT4_FS=y
-- 
1.7.9.5

