Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:35663 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754700AbdCXOwR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 Mar 2017 10:52:17 -0400
Date: Fri, 24 Mar 2017 09:52:08 -0500
From: Rob Herring <robh@kernel.org>
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        alsa-devel@alsa-project.org, kernel@stlinux.com,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        olivier moysan <olivier.moysan@st.com>
Subject: Re: [PATCH v3 10/11] ASoC: add bindings for stm32 DFSDM filter
Message-ID: <20170324145208.6tj5swol5du5lkyc@rob-hp-laptop>
References: <1489759704-30217-1-git-send-email-arnaud.pouliquen@st.com>
 <1489759704-30217-11-git-send-email-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1489759704-30217-11-git-send-email-arnaud.pouliquen@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Mar 17, 2017 at 03:08:23PM +0100, Arnaud Pouliquen wrote:
> Add bindings that describes audio settings to support
> Digital Filter for pulse density modulation(PDM) microphone.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> ---
> V2->V3:
>    Fixes based on V2 comments
> 
>  .../devicetree/bindings/sound/st,stm32-adfsdm.txt  | 41 ++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/st,stm32-adfsdm.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/st,stm32-adfsdm.txt b/Documentation/devicetree/bindings/sound/st,stm32-adfsdm.txt
> new file mode 100644
> index 0000000..ab610bc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/st,stm32-adfsdm.txt
> @@ -0,0 +1,40 @@
> +STMicroelectronics audio DFSDM DT bindings
> +
> +This driver supports audio PDM microphone capture through Digital Filter format
> +Sigma Delta modulators (DFSDM).
> +
> +Required properties:
> +  - compatible: "st,stm32h7-adfsdm".
> +
> +  - #sound-dai-cells : Must be equal to 0
> +
> +  - io-channels : phandle to iio dfsdm instance node.
> +
> +
> +Example of a simple sound card using audio DFSDM node.
> +
> +	dmic0: dmic_@0 {

Drop the '_' and unit address.

> +		compatible = "dmic-codec";
> +		#sound-dai-cells = <0>;
> +	};
> +
> +	asoc-pdm@0 {

asoc is a Linux term. Drop the unit address.

> +		compatible = "st,stm32h7-adfsdm";

Is this a separate block from the ADC? A drawing of the h/w blocks and 
connections would help.

> +		#sound-dai-cells = <0>;
> +		io-channels = <&dfsdm_adc0 0>;
> +	};
> +
> +	sound_dfsdm_pdm {

sound-card {

> + 		compatible = "simple-audio-card";
> + 		simple-audio-card,name = "dfsdm_pdm";
> +
> + 		dfsdm0_mic0: simple-audio-card,dai-link@0 {

I'd suggest moving to the graph card.

> + 			format = "pdm";
> + 			cpu {
> + 				sound-dai = <&asoc_pdm1>;

This phandle doesn't point to anything.

> + 			};
> + 			dmic0_codec: codec {
> + 				sound-dai = <&dmic0>;
> + 			};
> + 		};
> +	};
> \ No newline at end of file

^^^

> -- 
> 1.9.1
> 
