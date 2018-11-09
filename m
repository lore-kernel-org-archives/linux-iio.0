Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-by2nam03on0043.outbound.protection.outlook.com ([104.47.42.43]:35616
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727802AbeKJBWl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 9 Nov 2018 20:22:41 -0500
From: Stefan Popa <stefan.popa@analog.com>
To: <jic23@kernel.org>, <robh+dt@kernel.org>
CC: <mark.rutland@arm.com>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <Michael.Hennerich@analog.com>,
        <gregkh@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stefan.popa@analog.com>
Subject: [PATCH v4 2/4] dt-bindings: iio: adc: Add common ADCs properties to a separate file
Date: Fri, 9 Nov 2018 17:40:55 +0200
Message-ID: <1541778055-7629-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

There are several ADC drivers that depend on the same device tree
bindings. Rather than continue to duplicate the properties, this patch
adds a common adc binding document that can be referenced. For beginning,
only two properties are documented.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
Changes in v2, v3:
	- N/A.
Changes in v4:
	- Added this commit.

 Documentation/devicetree/bindings/iio/adc/adc.txt | 25 +++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adc.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/adc.txt b/Documentation/devicetree/bindings/iio/adc/adc.txt
new file mode 100644
index 0000000..1e3cc21
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adc.txt
@@ -0,0 +1,25 @@
+Common ADCs properties
+
+This binding is a work-in-progress
+
+Optional properties for child nodes:
+- bipolar : Boolean, if set the channel is used in bipolar mode.
+- diff-channels : Differential channels muxed for this ADC. The first value
+		specifies the positive input pin, the second value the negative
+		input pin.
+
+Example:
+	adc@0 {
+		compatible = "some,adc";
+		...
+		channel@0 {
+			bipolar;
+			diff-channels = <0 1>;
+			...
+		};
+
+		channel@1 {
+			diff-channels = <2 3>;
+			...
+		};
+	};
-- 
2.7.4
