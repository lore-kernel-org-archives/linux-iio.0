Return-Path: <SRS0=QH+w=EF=sirena.org.uk=broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc: Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Alexandre Torgue <alexandre.torgue@st.com>, linux-iio@vger.kernel.org, arnaud.pouliquen@st.com, Maxime Coquelin <mcoquelin.stm32@gmail.com>, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: add bindings for stm32 DFSDM filter" to the asoc tree
In-Reply-To: <1512744566-13233-13-git-send-email-arnaud.pouliquen@st.com>
Message-Id: <E1eZEJO-0004rr-2R@debutante>
Date: Wed, 10 Jan 2018 11:12:50 +0000
List-ID: <linux-iio@vger.kernel.org>

The patch

   ASoC: add bindings for stm32 DFSDM filter

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From a71615792d0b341500a9d1d7b374d19e3d443a12 Mon Sep 17 00:00:00 2001
From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Date: Wed, 10 Jan 2018 11:13:14 +0100
Subject: [PATCH] ASoC: add bindings for stm32 DFSDM filter

Add bindings that describes audio settings to support
Digital Filter for pulse density modulation(PDM) microphone.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/st,stm32-adfsdm.txt  | 63 ++++++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/st,stm32-adfsdm.txt

diff --git a/Documentation/devicetree/bindings/sound/st,stm32-adfsdm.txt b/Documentation/devicetree/bindings/sound/st,stm32-adfsdm.txt
new file mode 100644
index 000000000000..864f5b00b031
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/st,stm32-adfsdm.txt
@@ -0,0 +1,63 @@
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
+		#interrupt-cells = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		dfsdm_adc0: filter@0 {
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
2.15.1
