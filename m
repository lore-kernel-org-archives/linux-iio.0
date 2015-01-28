Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:43114 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753815AbbA1URA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 28 Jan 2015 15:17:00 -0500
From: Karol Wrona <k.wrona@samsung.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Karol Wrona <wrona.vy@gmail.com>,
	Karol Wrona <k.wrona@samsung.com>
Subject: [PATCH v5 2/5] iio: sensorhub: Add sensorhub bindings
Date: Wed, 28 Jan 2015 15:05:51 +0100
Message-id: <1422453954-27317-3-git-send-email-k.wrona@samsung.com>
In-reply-to: <1422453954-27317-1-git-send-email-k.wrona@samsung.com>
References: <1422453954-27317-1-git-send-email-k.wrona@samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add sensorhub bindings for sensorhub on Galaxy Gear 2.

Signed-off-by: Karol Wrona <k.wrona@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 .../devicetree/bindings/iio/sensorhub.txt          |   25 ++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/sensorhub.txt

diff --git a/Documentation/devicetree/bindings/iio/sensorhub.txt b/Documentation/devicetree/bindings/iio/sensorhub.txt
new file mode 100644
index 0000000..8d57571
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/sensorhub.txt
@@ -0,0 +1,25 @@
+Samsung Sensorhub driver
+
+Sensorhub is a MCU which manages several sensors and also plays the role
+of a virtual sensor device.
+
+Required properties:
+- compatible: "samsung,sensorhub-rinato" or "samsung,sensorhub-thermostat"
+- spi-max-frequency: max SPI clock frequency
+- interrupt-parent: interrupt parent
+- interrupts: communication interrupt
+- ap-mcu-gpios: [out] ap to sensorhub line - used during communication
+- mcu-ap-gpios: [in] sensorhub to ap - used during communication
+- mcu-reset-gpios: [out] sensorhub reset
+
+Example:
+
+	shub_spi: shub {
+		compatible = "samsung,sensorhub-rinato";
+		spi-max-frequency = <5000000>;
+		interrupt-parent = <&gpx0>;
+		interrupts = <2 0>;
+		ap-mcu-gpios = <&gpx0 0 0>;
+		mcu-ap-gpios = <&gpx0 4 0>;
+		mcu-reset-gpios = <&gpx0 5 0>;
+	};
-- 
1.7.9.5

