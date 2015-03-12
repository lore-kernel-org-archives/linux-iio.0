Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:54299 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754252AbbCNOAq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 14 Mar 2015 10:00:46 -0400
Message-ID: <550167FC.6010904@kernel.org>
Date: Thu, 12 Mar 2015 10:18:36 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: =?UTF-8?B?U8O4cmVuIEFuZGVyc2Vu?= <san@rosetechnology.dk>
CC: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [patch 2/2] dt-bindings Help for MCP ADCs
References: <1426022097.5476.39.camel@sanws1.rosetechnology.dk>
In-Reply-To: <1426022097.5476.39.camel@sanws1.rosetechnology.dk>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


Applied to the togreg branch of iio.git. Initially pushed out as
testing for the autobuilders to play.

Thanks

Jonathan
On 10/03/15 21:14, Søren Andersen wrote:
> Signed-off-by: Soeren Andersen <san at rosetechnology.dk>
> ---
> Documentation/devicetree/bindings/iio/adc/mcp320x.txt | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/mcp320x.txt b/Documentation/devicetree/bindings/iio/adc/mcp320x.txt
> new file mode 100644
> index 0000000..b851843
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/mcp320x.txt
> @@ -0,0 +1,30 @@
> +* Microchip Analog to Digital Converter (ADC)
> +
> +The node for this driver must be a child node of a SPI controller, hence
> +all mandatory properties described in
> +
> +        Documentation/devicetree/bindings/spi/spi-bus.txt
> +
> +must be specified.
> +
> +Required properties:
> +	- compatible:  	Must be one of the following, depending on the
> +			model:
> +				"mcp3001"
> +				"mcp3002"
> +				"mcp3004"
> +				"mcp3008"
> +				"mcp3201"
> +				"mcp3202"
> +				"mcp3204"
> +				"mcp3208"
> +
> +
> +Examples:
> +spi_controller {
> +	mcp3x0x@0 {
> +		compatible = "mcp3002";
> +		reg = <0>;
> +		spi-max-frequency = <1000000>;
> +	};
> +};
> 
> 

