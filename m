Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtpfb1-g21.free.fr ([212.27.42.9]:41399 "EHLO
	smtpfb1-g21.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753667AbaFXOrI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 24 Jun 2014 10:47:08 -0400
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
	devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Denis Carikli <denis@eukrea.com>
Subject: [PATCH v4 5/6] ARM: dts: imx25: mbimxsd25: Add touchscreen support.
Date: Tue, 24 Jun 2014 16:46:34 +0200
Message-Id: <1403621195-9622-5-git-send-email-denis@eukrea.com>
In-Reply-To: <1403621195-9622-1-git-send-email-denis@eukrea.com>
References: <1403621195-9622-1-git-send-email-denis@eukrea.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Denis Carikli <denis@eukrea.com>
---
Changelog v3->v4:
- None

Changelog v2->v3:
- Most of the non-board specific tsc and tscadc
  parts were moved to imx25.dtsi. So this patch
  was adapted to that.
- Thanks to a fix in the tsc driver, the 
  'fsl,pen-debounce = <100>;' is not necessary anymore.
---
 .../imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts  |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts b/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts
index 68d0834..2f3bc3f 100644
--- a/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts
+++ b/arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts
@@ -71,3 +71,11 @@
 	lcd-supply = <&reg_lcd_3v3>;
 	status = "okay";
 };
+
+&tsc {
+	status = "okay";
+};
+
+&tscadc {
+	status = "okay";
+};
-- 
1.7.9.5

