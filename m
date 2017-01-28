Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:50743 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752164AbdA1X7O (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 28 Jan 2017 18:59:14 -0500
Date: Sun, 29 Jan 2017 00:58:14 +0100
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
Subject: [PATCH 1/2] iio: distance: add dt binding for devantech-srf04
Message-ID: <20170128235814.GA4786@andreas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch adds dt binding for devantech ultrasonic ranger srf04.

The vendor "devantech" was already added to the vendor list with 
	"[PATCH v4 1/3] iio: distance: srf08: add trivial DT binding"

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 .../bindings/iio/proximity/devantech-srf04.txt          | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/devantech-srf04.txt

diff --git a/Documentation/devicetree/bindings/iio/proximity/devantech-srf04.txt b/Documentation/devicetree/bindings/iio/proximity/devantech-srf04.txt
new file mode 100644
index 000000000000..4ea29ef3ff89
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/proximity/devantech-srf04.txt
@@ -0,0 +1,17 @@
+* Devantech SRF04 ultrasonic range finder
+  Bit-banging driver
+
+Required properties:
+ - compatible:	Should be "devantech,srf04"
+ - trig-gpios:	Definition of the GPIO for the triggering input
+ - echo-gpios:	Definition of the GPIO for the echo
+		needs to be an interrupt input
+		See Documentation/devicetree/bindings/gpio/gpio.txt
+
+Example:
+srf04@0 {
+	compatible = "devantech,srf04";
+	trig-gpios = <&gpio1 15 GPIO_ACTIVE_HIGH>;
+	echo-gpios = <&gpio2  6 GPIO_ACTIVE_HIGH>;
+};
+
-- 
2.1.4

