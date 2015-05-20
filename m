Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from skprod3.natinst.com ([130.164.80.24]:59146 "EHLO ni.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754152AbbETPXd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 20 May 2015 11:23:33 -0400
From: Xander Huff <xander.huff@ni.com>
To: lars@metafoo.de, robh+dt@kernel.org, pawel.moll@arm.com,
	mark.rutland@arm.com, ijc+devicetree@hellion.org.uk,
	galak@codeaurora.org
Cc: michal.simek@xilinx.com, soren.brinkmann@xilinx.com,
	jic23@kernel.org, knaack.h@gmx.de, pmeerw@pmeerw.net,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org, ben.shelton@ni.com, joshc@ni.com,
	joe.hershberger@ni.com, Xander Huff <xander.huff@ni.com>
Subject: [PATCH v2 1/2] devicetree: xilinx-xadc: Add optional label property
Date: Wed, 20 May 2015 10:22:31 -0500
Message-Id: <1432135352-29848-1-git-send-email-xander.huff@ni.com>
In-Reply-To: <555B78A3.2030202@metafoo.de>
References: <555B78A3.2030202@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

To better facilitate user-mode access to optional aux channels, allow
device trees to specify a custom label for defined channels.

Signed-off-by: Xander Huff <xander.huff@ni.com>
Reviewed-by: Joe Hershberger <joe.hershberger@ni.com>
Reviewed-by: Josh Cartwright <joshc@ni.com>
---
 Documentation/devicetree/bindings/iio/adc/xilinx-xadc.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/xilinx-xadc.txt b/Documentation/devicetree/bindings/iio/adc/xilinx-xadc.txt
index d71258e..19dcd96 100644
--- a/Documentation/devicetree/bindings/iio/adc/xilinx-xadc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/xilinx-xadc.txt
@@ -68,6 +68,7 @@ Optional properties:
 			  Note each channel number should only be used at most
 			  once.
 		Optional properties:
+			* label: Custom label for the channel.
 			* xlnx,bipolar: If set the channel is used in bipolar
 			  mode.
 
@@ -107,6 +108,7 @@ Examples:
 			#size-cells = <0>;
 			channel@0 {
 				reg = <0>;
+				label = "vin_v";
 				xlnx,bipolar;
 			};
 		};
-- 
1.9.1

