Return-Path: <SRS0=+oXp=CN=gmail.com=robherring2@kernel.org>
Date: Wed, 15 Nov 2017 09:43:04 -0600
From: Rob Herring <robh@kernel.org>
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	alsa-devel@alsa-project.org,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@st.com>
Subject: Re: [PATCH v4 11/12] ASoC: add bindings for stm32 DFSDM filter
Message-ID: <20171115154304.dzrezz7trvoway73@rob-hp-laptop>
References: <1510222354-15290-1-git-send-email-arnaud.pouliquen@st.com>
 <1510222354-15290-12-git-send-email-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1510222354-15290-12-git-send-email-arnaud.pouliquen@st.com>
List-ID: <linux-iio@vger.kernel.org>

On Thu, Nov 09, 2017 at 11:12:33AM +0100, Arnaud Pouliquen wrote:
> Add bindings that describes audio settings to support
> Digital Filter for pulse density modulation(PDM) microphone.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> ---
> V3 -> V4 changes:
> 	- Update to move on of_graph description.
> 	- Link to DFSDM IIO bindings.
> 
>  .../devicetree/bindings/sound/st,stm32-adfsdm.txt  | 63 ++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/st,stm32-adfsdm.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/st,stm32-adfsdm.txt b/Documentation/devicetree/bindings/sound/st,stm32-adfsdm.txt
> new file mode 100644
> index 0000000..75e298b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/st,stm32-adfsdm.txt
> @@ -0,0 +1,63 @@
> +STMicroelectronics audio DFSDM DT bindings
> +
> +This driver supports audio PDM microphone capture through Digital Filter format

Bindings aren't drivers.

> +Sigma Delta modulators (DFSDM).
> +
> +Required properties:
> +  - compatible: "st,stm32h7-dfsdm-dai".
> +
> +  - #sound-dai-cells : Must be equal to 0
> +
> +  - io-channels : phandle to iio dfsdm instance node.
> +		[See: ../iio/adc/st,stm32-dfsdm-adc.txt for DFSDM options]
> +
> +Example of a sound card using audio DFSDM node.
> +
> +	sound_card {
> +		compatible = "audio-graph-card";
> +
> +		dais = <&cpu_port>;
> +	};
> +
> +	dfsdm: dfsdm@40017000 {
> +		compatible = "st,stm32h7-dfsdm";
> +		reg = <0x40017000 0x400>;
> +		clocks = <&rcc DFSDM1_CK>;
> +		clock-names = "dfsdm";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		dfsdm_adc0: dfsdm-adc@0 {
> +			compatible = "st,stm32-dfsdm-dmic";
> +			reg = <0>;
> +			interrupts = <110>;
> +			dmas = <&dmamux1 101 0x400 0x00>;
> +			dma-names = "rx";
> +			st,adc-channels = <1>;
> +			st,adc-channel-names = "dmic0";
> +			st,adc-channel-types = "SPI_R";
> +			st,adc-channel-clk-src = "CLKOUT";
> +			st,filter-order = <5>;
> +		};
> +	}
> +
> +	dfsdm_dai0:dfsdm_dai@0 {

Unit address without reg property is not valid. Building your dtb with 
W=2 will tell you this.

Need a space after the ':'.

Should be a child of dfsdm?

> +		compatible = "st,stm32h7-dfsdm-dai";
> +		#sound-dai-cells = <0>;
> +		io-channels = <&dfsdm_adc0 0>;

It doesn't seem like this is an actual h/w block. Why can't 'dais' point 
directly to the ADC?

> +		cpu_port: port {
> +			dfsdm_endpoint: endpoint {
> +				remote-endpoint = <&dmic0_endpoint>;
> +			};
> +		};
> +	};
> +
> +	dmic0: dmic@0 {
> +		compatible = "dmic-codec";
> +		#sound-dai-cells = <0>;
> +		port {
> +			dmic0_endpoint: endpoint {
> +				remote-endpoint = <&dfsdm_endpoint>;
> +			};
> +		};
> +	};
> -- 
> 2.7.4
> 
