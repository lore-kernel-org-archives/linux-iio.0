Return-Path: <SRS0=j+/x=BX=gmail.com=robherring2@kernel.org>
Date: Tue, 24 Oct 2017 11:41:38 -0500
From: Rob Herring <robh@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: jic23@kernel.org, linux@armlinux.org.uk, mark.rutland@arm.com,
	mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, lars@metafoo.de,
	knaack.h@gmx.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, benjamin.gaignard@linaro.org,
	benjamin.gaignard@st.com
Subject: Re: [PATCH 1/3] dt-bindings: iio: adc: stm32: add support for diff
 channels
Message-ID: <20171024164138.arnjrlw4pmk5xaqy@rob-hp-laptop>
References: <1508246145-19417-1-git-send-email-fabrice.gasnier@st.com>
 <1508246145-19417-2-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1508246145-19417-2-git-send-email-fabrice.gasnier@st.com>
List-ID: <linux-iio@vger.kernel.org>

On Tue, Oct 17, 2017 at 03:15:43PM +0200, Fabrice Gasnier wrote:
> STM32H7 ADC channels may be configured either as single-ended or
> differential.
> Add 'st,adc-diff-channels' property to support differential channels.
> Differential channels are defined as a pair of positive and negative
> inputs: vinp & vinn.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
> index 48bfcaa3..c3c8de1 100644
> --- a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
> @@ -62,6 +62,12 @@ Required properties:
>  - st,adc-channels: List of single-ended channels muxed for this ADC.
>    It can have up to 16 channels on stm32f4 or 20 channels on stm32h7, numbered
>    from 0 to 15 or 19 (resp. for in0..in15 or in0..in19).
> +- st,adc-diff-channels: List of differential channels muxed for this ADC.
> +  Depending on part used, some channels can be configured as differential
> +  instead of single-ended (e.g. stm32h7). List here positive and negative
> +  inputs pairs as <vinp vinn>, <vinp vinn>,... vinp and vinn are numbered
> +  from 0 to 19 on stm32h7)
> +  Note: At least one of "st,adc-channels" or "st,adc-diff-channels" is required.

Wouldn't both present be invalid?

>  - #io-channel-cells = <1>: See the IIO bindings section "IIO consumers" in
>    Documentation/devicetree/bindings/iio/iio-bindings.txt
>  
> -- 
> 1.9.1
> 
