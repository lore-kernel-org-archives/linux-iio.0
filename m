Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:58351 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934337AbdBQQFJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Feb 2017 11:05:09 -0500
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <jic23@kernel.org>, <linux@armlinux.org.uk>, <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linux-iio@vger.kernel.org>, <mark.rutland@arm.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <fabrice.gasnier@st.com>, <benjamin.gaignard@linaro.org>,
        <benjamin.gaignard@st.com>, <linus.walleij@linaro.org>
Subject: [RFC 1/4] dt-bindings: iio: introduce trigger providers, consumers
Date: Fri, 17 Feb 2017 17:03:46 +0100
Message-ID: <1487347429-31761-2-git-send-email-fabrice.gasnier@st.com>
In-Reply-To: <1487347429-31761-1-git-send-email-fabrice.gasnier@st.com>
References: <1487347429-31761-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Document iio provider and consumer bindings.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 .../devicetree/bindings/iio/iio-bindings.txt       | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/iio-bindings.txt b/Documentation/devicetree/bindings/iio/iio-bindings.txt
index 68d6f8c..3125390 100644
--- a/Documentation/devicetree/bindings/iio/iio-bindings.txt
+++ b/Documentation/devicetree/bindings/iio/iio-bindings.txt
@@ -95,3 +95,40 @@ vdd channel is connected to output 0 of the &ref device.
 		io-channels = <&adc 10>, <&adc 11>;
 		io-channel-names = "adc1", "adc2";
 	};
+
+==IIO trigger providers==
+Sources of IIO triggers can be represented by any node in the device
+tree. Those nodes are designated as IIO trigger providers. IIO trigger
+consumer uses a phandle and an IIO trigger specifier to connect to an
+IIO trigger provider.
+An IIO trigger specifier is an array of one or more cells identifying
+the IIO trigger output on a device. The length of an IIO trigger
+specifier is defined by the value of a #io-trigger-cells property in
+the IIO trigger provider node.
+
+Required properties:
+#io-trigger-cells:
+		Number of cells in an IIO trigger specifier; Typically
+		0 for nodes with a simple IIO trigger output.
+
+Example:
+	gpiotrig0: iio-gpio-trigger0 {
+		#io-trigger-cells = <0>;
+		compatible = "iio-gpio-trigger";
+		gpios = <&gpioa 11 0>;
+	}
+
+==IIO trigger consumers==
+Required properties:
+- io-triggers:	List of phandle representing the IIO trigger specifier.
+
+Optional properties:
+- io-trigger-names :
+		List of IIO trigger name strings that matches elements
+		in 'io-triggers' list property.
+
+Example:
+	some_trigger_consumer {
+		io-triggers = <&gpiotrig0>;
+		io-trigger-names = "mytrig";
+	}
-- 
1.9.1

