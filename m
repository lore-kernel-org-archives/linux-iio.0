Return-Path: <SRS0=RSSa=C5=st.com=arnaud.pouliquen@kernel.org>
From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler
	<pmeerw@pmeerw.net>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	<broonie@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>, <arnaud.pouliquen@st.com>
Subject: [PATCH v6 12/13] ASoC: add bindings for stm32 DFSDM filter
Date: Fri, 1 Dec 2017 18:40:19 +0100
Message-ID: <1512150020-20335-13-git-send-email-arnaud.pouliquen@st.com>
In-Reply-To: <1512150020-20335-1-git-send-email-arnaud.pouliquen@st.com>
References: <1512150020-20335-1-git-send-email-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Add bindings that describes audio settings to support
Digital Filter for pulse density modulation(PDM) microphone.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 .../devicetree/bindings/sound/st,stm32-adfsdm.txt  | 62 ++++++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/st,stm32-adfsdm.txt

diff --git a/Documentation/devicetree/bindings/sound/st,stm32-adfsdm.txt b/Documentation/devicetree/bindings/sound/st,stm32-adfsdm.txt
new file mode 100644
index 0000000..2782cda
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/st,stm32-adfsdm.txt
@@ -0,0 +1,62 @@
+STMicroelectronics Audio Digital Filter Sigma Delta modulators(DFSDM)
+
+The DFSDM allows PDM microphones capture through SPI interface. The Audio
+interface is seems as a sub block of the DFSDM device.
+For details on DFSDM bindings refer to ../iio/adc/st,stm32-dfsdm-adc.txt
+
+Required properties:
+  - compatible: "st,stm32h7-dfsdm-dai".
+
+  - #sound-dai-cells : Must be equal to 0
+
+  - io-channels : phandle to iio dfsdm instance node.
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
+
+			dfsdm_dai0: dfsdm-dai {
+				compatible = "st,stm32h7-dfsdm-dai";
+				#sound-dai-cells = <0>;
+				io-channels = <&dfsdm_adc0 0>;
+				cpu_port: port {
+				dfsdm_endpoint: endpoint {
+					remote-endpoint = <&dmic0_endpoint>;
+				};
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
