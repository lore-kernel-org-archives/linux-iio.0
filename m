Return-Path: <SRS0=JtcQ=3L=gmail.com=robherring2@kernel.org>
Date: Mon, 3 Apr 2017 11:42:40 -0500
From: Rob Herring <robh@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: jic23@kernel.org, linux@armlinux.org.uk,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	mark.rutland@arm.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@st.com, lars@metafoo.de, knaack.h@gmx.de,
	pmeerw@pmeerw.net, benjamin.gaignard@linaro.org,
	benjamin.gaignard@st.com, linus.walleij@linaro.org,
	amelie.delaunay@st.com
Subject: Re: [PATCH 1/4] dt-bindings: iio: stm32-dac: Add support for STM32
 DAC
Message-ID: <20170403164240.hw4wza7y3s5faivb@rob-hp-laptop>
References: <1490960707-22422-1-git-send-email-fabrice.gasnier@st.com>
 <1490960707-22422-2-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1490960707-22422-2-git-send-email-fabrice.gasnier@st.com>
List-ID: <linux-iio@vger.kernel.org>

On Fri, Mar 31, 2017 at 01:45:04PM +0200, Fabrice Gasnier wrote:
> Document STMicroelectronics STM32 DAC (digital-to-analog converter).
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>  .../devicetree/bindings/iio/dac/st,stm32-dac.txt   | 56 ++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/st,stm32-dac.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/st,stm32-dac.txt b/Documentation/devicetree/bindings/iio/dac/st,stm32-dac.txt
> new file mode 100644
> index 0000000..1981983
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/st,stm32-dac.txt
> @@ -0,0 +1,56 @@
> +STMicroelectronics STM32 DAC
> +
> +The STM32 DAC is a 12-bit voltage output digital-to-analog converter. The DAC
> +can be configured in 8- or 12-bit mode. In 12-bit mode, the data could be
> +left- or right-aligned. It has two output channels, each with its own converter.
> +It has built-in noise and triangle waveform generator and supports external
> +triggers for conversions. The DAC's output buffer allows a high drive output
> +current.
> +
> +Contents of a stm32 dac root node:
> +-----------------------------------
> +Required properties:
> +- compatible: Must be "st,stm32h7-dac-core".
> +- reg: Offset and length of the device's register set.
> +- clocks: Must contain an entry for pclk (which feeds the peripheral bus
> +  interface)
> +- clock-names: Must be "pclk".
> +- vref-supply: Phandle to the vref+ input analog reference supply.
> +
> +Optional properties:
> +- resets: Must contain the phandle to the reset controller.
> +- A pinctrl state named "default" for each DAC channel may be defined to set
> +  DAC_OUTx pin in mode of operation for analog output on external pin.
> +
> +Contents of a stm32 dac child node:
> +-----------------------------------
> +DAC core node should contain at least one subnode, representing a
> +DAC instance/channel available on the machine.
> +
> +Required properties:
> +- compatible: Must be "st,stm32-dac".
> +- #io-channel-cells = <1>: See the IIO bindings section "IIO consumers" in
> +  Documentation/devicetree/bindings/iio/iio-bindings.txt
> +- st,dac-channel: Must be either 1 or 2, to define channel in use (e.g.
> +  single channels: 1 or 2)

Use "reg" instead.

> +
> +Example:
> +	dac: dac@40007400 {
> +		compatible = "st,stm32h7-dac-core";
> +		reg = <0x40007400 0x400>;
> +		clocks = <&clk>;
> +		clock-names = "pclk";
> +		vref-supply = <&reg_vref>;
> +
> +		dac1: dac@1 {
> +			compatible = "st,stm32-dac";
> +			#io-channels-cells = <1>;
> +			st,dac-channel = <1>;
> +		};
> +
> +		dac2: dac@2 {
> +			compatible = "st,stm32-dac";
> +			#io-channels-cells = <1>;
> +			st,dac-channel = <2>;
> +		};
> +	};
> -- 
> 1.9.1
> 
