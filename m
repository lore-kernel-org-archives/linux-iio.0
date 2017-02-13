Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:61327 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752234AbdBMQkd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Feb 2017 11:40:33 -0500
From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
To: Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC: <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <kernel@stlinux.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <arnaud.pouliquen@st.com>, olivier moysan <olivier.moysan@st.com>
Subject: [RFC v2 2/7] IIO: Add bindings for simple sigma delta adc
Date: Mon, 13 Feb 2017 17:38:24 +0100
Message-ID: <1487003909-11710-3-git-send-email-arnaud.pouliquen@st.com>
In-Reply-To: <1487003909-11710-1-git-send-email-arnaud.pouliquen@st.com>
References: <1487003909-11710-1-git-send-email-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add documentation of device tree bindings to support
sigma delta modulator in IIO framework.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 Documentation/devicetree/bindings/iio/adc/simple_sd_adc.txt | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/simple_sd_adc.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/simple_sd_adc.txt b/Documentation/devicetree/bindings/iio/adc/simple_sd_adc.txt
new file mode 100644
index 0000000..2b3968a
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/simple_sd_adc.txt
@@ -0,0 +1,13 @@
+Device-Tree bindings for simple sigma delta adc
+
+Required properties:
+- compatible: should be "sd-modulator".
+- #io-channel-cells = <1>: See the IIO bindings section "IIO consumers".
+
+Example node:
+
+	ads1202: simple_sd_adc@0 {
+		compatible = "sd-modulator";
+		#io-channel-cells = <1>;
+		status = "okay";
+	};
-- 
1.9.1

