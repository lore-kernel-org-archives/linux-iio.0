Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932309AbdJZRsF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 26 Oct 2017 13:48:05 -0400
Date: Thu, 26 Oct 2017 18:41:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: <robh+dt@kernel.org>, <linux@armlinux.org.uk>,
        <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <benjamin.gaignard@linaro.org>,
        <benjamin.gaignard@st.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: iio: adc: stm32: add support for
 diff channels
Message-ID: <20171026184105.205070d3@archlinux>
In-Reply-To: <1508923665-2274-2-git-send-email-fabrice.gasnier@st.com>
References: <1508923665-2274-1-git-send-email-fabrice.gasnier@st.com>
        <1508923665-2274-2-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 25 Oct 2017 11:27:43 +0200
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> STM32H7 ADC channels may be configured either as single-ended or
> differential.
> Add 'st,adc-diff-channels' property to support differential channels.
> Differential channels are defined as a pair of positive and negative
> inputs: vinp & vinn.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>

Works for me, but I will want Rob to have time to look at this.
Unfortunately we are very late in the cycle, so I think this one
will have to wait for next cycle now.

Sorry about that, sometimes timing is against us and I want to
get my final pull request for this cycle out today.

Jonathan

> ---
> Changes in v2:
> - Add differential channels example
> - Add a note on mixed single-ended / differential channels
> ---
>  .../devicetree/bindings/iio/adc/st,stm32-adc.txt   | 24 ++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
> index 48bfcaa3..e8bb824 100644
> --- a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
> @@ -62,6 +62,15 @@ Required properties:
>  - st,adc-channels: List of single-ended channels muxed for this ADC.
>    It can have up to 16 channels on stm32f4 or 20 channels on stm32h7, numbered
>    from 0 to 15 or 19 (resp. for in0..in15 or in0..in19).
> +- st,adc-diff-channels: List of differential channels muxed for this ADC.
> +  Depending on part used, some channels can be configured as differential
> +  instead of single-ended (e.g. stm32h7). List here positive and negative
> +  inputs pairs as <vinp vinn>, <vinp vinn>,... vinp and vinn are numbered
> +  from 0 to 19 on stm32h7)
> +  Note: At least one of "st,adc-channels" or "st,adc-diff-channels" is required.
> +  Both properties can be used together. Some channels can be used as
> +  single-ended and some other ones as differential (mixed). But channels
> +  can't be configured both as single-ended and differential (invalid).
>  - #io-channel-cells = <1>: See the IIO bindings section "IIO consumers" in
>    Documentation/devicetree/bindings/iio/iio-bindings.txt
>  
> @@ -111,3 +120,18 @@ Example:
>  		...
>  		other adc child nodes follow...
>  	};
> +
> +Example to setup:
> +- channel 1 as single-ended
> +- channels 2 & 3 as differential (with resp. 6 & 7 negative inputs)
> +
> +	adc: adc@40022000 {
> +		compatible = "st,stm32h7-adc-core";
> +		...
> +		adc1: adc@0 {
> +			compatible = "st,stm32h7-adc";
> +			...
> +			st,adc-channels = <1>;
> +			st,adc-diff-channels = <2 6>, <3 7>;
> +		};
> +	};

