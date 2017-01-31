Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:55745 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751498AbdAaSEV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Jan 2017 13:04:21 -0500
Date: Tue, 31 Jan 2017 19:03:06 +0100
From: Andreas Klinger <ak@it-klinger.de>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org, dledford@redhat.com,
        akpm@linux-foundation.org, shraddha.6596@gmail.com, w@1wt.eu,
        balbi@kernel.org, mtk.manpages@gmail.com, sjenning@redhat.com,
        ksenija.stanojevic@gmail.com, vilhelm.gray@gmail.com,
        robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
        ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Cc: ak@it-klinger.de
Subject: [PATCH v3 1/2] iio: distance: add dt binding for devantech-srf04
Message-ID: <20170131180306.GA12880@andreas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch adds dt binding for devantech ultrasonic ranger srf04.

The vendor "devantech" was already added to the vendor list with
        "[PATCH v4 1/3] iio: distance: srf08: add trivial DT binding"

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 .../bindings/iio/proximity/devantech-srf04.txt     | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/devantech-srf04.txt

diff --git a/Documentation/devicetree/bindings/iio/proximity/devantech-srf04.txt b/Documentation/devicetree/bindings/iio/proximity/devantech-srf04.txt
new file mode 100644
index 000000000000..d4dc7a227e2e
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/proximity/devantech-srf04.txt
@@ -0,0 +1,28 @@
+* Devantech SRF04 ultrasonic range finder
+  Bit-banging driver using two GPIOs
+
+Required properties:
+ - compatible:	Should be "devantech,srf04"
+
+ - trig-gpios:	Definition of the GPIO for the triggering (output)
+		This GPIO is set for about 10 us by the driver to tell the
+		device it should initiate the measurement cycle.
+
+ - echo-gpios:	Definition of the GPIO for the echo (input)
+		This GPIO is set by the device as soon as an ultrasonic
+		burst is sent out and reset when the first echo is
+		received.
+		Thus this GPIO is set while the ultrasonic waves are doing
+		one round trip.
+		It needs to be an GPIO which is able to deliver an
+		interrupt because the time between two interrupts is
+		measured in the driver.
+		See Documentation/devicetree/bindings/gpio/gpio.txt for
+		information on how to specify a consumer gpio.
+
+Example:
+srf04@0 {
+	compatible = "devantech,srf04";
+	trig-gpios = <&gpio1 15 GPIO_ACTIVE_HIGH>;
+	echo-gpios = <&gpio2  6 GPIO_ACTIVE_HIGH>;
+};
-- 
2.1.4

