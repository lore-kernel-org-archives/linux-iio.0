Return-Path: <SRS0=bMon=2D=gmail.com=robherring2@kernel.org>
Date: Wed, 22 Feb 2017 09:17:50 -0600
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
	alsa-devel@alsa-project.org, kernel@stlinux.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@st.com>,
	olivier moysan <olivier.moysan@st.com>
Subject: Re: [RFC v2 2/7] IIO: Add bindings for simple sigma delta adc
Message-ID: <20170222151750.h5d7gycltwnk7b4t@rob-hp-laptop>
References: <1487003909-11710-1-git-send-email-arnaud.pouliquen@st.com>
 <1487003909-11710-3-git-send-email-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1487003909-11710-3-git-send-email-arnaud.pouliquen@st.com>
List-ID: <linux-iio@vger.kernel.org>

On Mon, Feb 13, 2017 at 05:38:24PM +0100, Arnaud Pouliquen wrote:
> Add documentation of device tree bindings to support
> sigma delta modulator in IIO framework.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/simple_sd_adc.txt | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/simple_sd_adc.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/simple_sd_adc.txt b/Documentation/devicetree/bindings/iio/adc/simple_sd_adc.txt
> new file mode 100644
> index 0000000..2b3968a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/simple_sd_adc.txt
> @@ -0,0 +1,13 @@
> +Device-Tree bindings for simple sigma delta adc

What makes it "simple"?

> +
> +Required properties:
> +- compatible: should be "sd-modulator".
> +- #io-channel-cells = <1>: See the IIO bindings section "IIO consumers".
> +
> +Example node:
> +
> +	ads1202: simple_sd_adc@0 {

Is ads1202 the actual chip? Then it should be in the compatible list.

unit address without a reg prop is an error. The node name should be 
"adc".

> +		compatible = "sd-modulator";
> +		#io-channel-cells = <1>;
> +		status = "okay";

Drop status from examples.

> +	};
> -- 
> 1.9.1
> 
