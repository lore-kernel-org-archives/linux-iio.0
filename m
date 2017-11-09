Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:40002 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751786AbdKIKOG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 Nov 2017 05:14:06 -0500
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
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <arnaud.pouliquen@st.com>
Subject: [PATCH v4 11/12] ASoC: add bindings for stm32 DFSDM filter
Date: Thu, 9 Nov 2017 11:12:33 +0100
Message-ID: <1510222354-15290-12-git-send-email-arnaud.pouliquen@st.com>
In-Reply-To: <1510222354-15290-1-git-send-email-arnaud.pouliquen@st.com>
References: <1510222354-15290-1-git-send-email-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add bindings that describes audio settings to support
Digital Filter for pulse density modulation(PDM) microphone.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
V3 -> V4 changes:
	- Update to move on of_graph description.
	- Link to DFSDM IIO bindings.

 .../devicetree/bindings/sound/st,stm32-adfsdm.txt  | 63 ++++++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/st,stm32-adfsdm.txt

diff --git a/Documentation/devicetree/bindings/sound/st,stm32-adfsdm.txt b/Documentation/devicetree/bindings/sound/st,stm32-adfsdm.txt
new file mode 100644
index 0000000..75e298b
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/st,stm32-adfsdm.txt
@@ -0,0 +1,63 @@
+STMicroelectronics audio DFSDM DT bindings
+
+This driver supports audio PDM microphone capture through Digital Filter format
+Sigma Delta modulators (DFSDM).
+
+Required properties:
+  - compatible: "st,stm32h7-dfsdm-dai".
+
+  - #sound-dai-cells : Must be equal to 0
+
+  - io-channels : phandle to iio dfsdm instance node.
+		[See: ../iio/adc/st,stm32-dfsdm-adc.txt for DFSDM options]
+
+Example of a sound card using audio DFSDM node.
+
+	sound_card {
+		compatible = "audio-graph-card";
+
+		dais = <&cpu_port>;
+	};
+
+	dfsdm: dfsdm@40017000 {
+		compatible = "st,stm32h7-dfsdm";
+		reg = <0x40017000 0x400>;
+		clocks = <&rcc DFSDM1_CK>;
+		clock-names = "dfsdm";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		dfsdm_adc0: dfsdm-adc@0 {
+			compatible = "st,stm32-dfsdm-dmic";
+			reg = <0>;
+			interrupts = <110>;
+			dmas = <&dmamux1 101 0x400 0x00>;
+			dma-names = "rx";
+			st,adc-channels = <1>;
+			st,adc-channel-names = "dmic0";
+			st,adc-channel-types = "SPI_R";
+			st,adc-channel-clk-src = "CLKOUT";
+			st,filter-order = <5>;
+		};
+	}
+
+	dfsdm_dai0:dfsdm_dai@0 {
+		compatible = "st,stm32h7-dfsdm-dai";
+		#sound-dai-cells = <0>;
+		io-channels = <&dfsdm_adc0 0>;
+		cpu_port: port {
+			dfsdm_endpoint: endpoint {
+				remote-endpoint = <&dmic0_endpoint>;
+			};
+		};
+	};
+
+	dmic0: dmic@0 {
+		compatible = "dmic-codec";
+		#sound-dai-cells = <0>;
+		port {
+			dmic0_endpoint: endpoint {
+				remote-endpoint = <&dfsdm_endpoint>;
+			};
+		};
+	};
-- 
2.7.4

