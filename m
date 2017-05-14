Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.lysator.liu.se ([130.236.254.3]:34116 "EHLO
        mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759612AbdENT5t (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 14 May 2017 15:57:49 -0400
From: Peter Rosin <peda@lysator.liu.se>
To: linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin Ian King <colin.king@canonical.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Philipp Zabel <p.zabel@pengutronix.de>, kernel@pengutronix.de
Subject: [PATCH v15 06/13] dt-bindings: iio: io-channel-mux: document io-channel-mux bindings
Date: Sun, 14 May 2017 21:51:09 +0200
Message-Id: <1494791476-14599-7-git-send-email-peda@lysator.liu.se>
In-Reply-To: <1494791476-14599-1-git-send-email-peda@lysator.liu.se>
References: <1494791476-14599-1-git-send-email-peda@lysator.liu.se>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Peter Rosin <peda@axentia.se>

Describe how a multiplexer can be used to select which signal is fed to
an io-channel.

Acked-by: Jonathan Cameron <jic23@kernel.org>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 .../bindings/iio/multiplexer/io-channel-mux.txt    | 39 ++++++++++++++++++++++
 MAINTAINERS                                        |  6 ++++
 2 files changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/multiplexer/io-channel-mux.txt

diff --git a/Documentation/devicetree/bindings/iio/multiplexer/io-channel-mux.txt b/Documentation/devicetree/bindings/iio/multiplexer/io-channel-mux.txt
new file mode 100644
index 000000000000..c82794002595
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/multiplexer/io-channel-mux.txt
@@ -0,0 +1,39 @@
+I/O channel multiplexer bindings
+
+If a multiplexer is used to select which hardware signal is fed to
+e.g. an ADC channel, these bindings describe that situation.
+
+Required properties:
+- compatible : "io-channel-mux"
+- io-channels : Channel node of the parent channel that has multiplexed
+		input.
+- io-channel-names : Should be "parent".
+- #address-cells = <1>;
+- #size-cells = <0>;
+- mux-controls : Mux controller node to use for operating the mux
+- channels : List of strings, labeling the mux controller states.
+
+For each non-empty string in the channels property, an io-channel will
+be created. The number of this io-channel is the same as the index into
+the list of strings in the channels property, and also matches the mux
+controller state. The mux controller state is described in
+../mux/mux-controller.txt
+
+Example:
+	mux: mux-controller {
+		compatible = "mux-gpio";
+		#mux-control-cells = <0>;
+
+		mux-gpios = <&pioA 0 GPIO_ACTIVE_HIGH>,
+			    <&pioA 1 GPIO_ACTIVE_HIGH>;
+	};
+
+	adc-mux {
+		compatible = "io-channel-mux";
+		io-channels = <&adc 0>;
+		io-channel-names = "parent";
+
+		mux-controls = <&mux>;
+
+		channels = "sync", "in", "system-regulator";
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index a0cce325b08e..eea8432b2df1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6474,6 +6474,12 @@ F:	Documentation/ABI/testing/sysfs-bus-iio-adc-envelope-detector
 F:	Documentation/devicetree/bindings/iio/adc/envelope-detector.txt
 F:	drivers/iio/adc/envelope-detector.c
 
+IIO MULTIPLEXER
+M:	Peter Rosin <peda@axentia.se>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/multiplexer/iio-mux.txt
+
 IIO SUBSYSTEM AND DRIVERS
 M:	Jonathan Cameron <jic23@kernel.org>
 R:	Hartmut Knaack <knaack.h@gmx.de>
-- 
2.1.4

