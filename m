Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59372 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751092AbbJYNbq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 25 Oct 2015 09:31:46 -0400
Subject: Re: [PATCHv2 1/2] Documentation: ad5592r: Added devicetree bindings
 documentation
To: Paul Cercueil <paul.cercueil@analog.com>
References: <1444729080-9937-1-git-send-email-paul.cercueil@analog.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Antonio Fiol <antonio@fiol.es>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <562CD9BD.6030206@kernel.org>
Date: Sun, 25 Oct 2015 13:31:41 +0000
MIME-Version: 1.0
In-Reply-To: <1444729080-9937-1-git-send-email-paul.cercueil@analog.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 13/10/15 10:37, Paul Cercueil wrote:
> Signed-off-by: Paul Cercueil <paul.cercueil@analog.com>
Looks good to me, but as it is a little bit 'different' and we are
defining entirely new generic bindings (the channel modes stuff)
I would like some more input.  It might be overkill but we do
of course have the pinctl framework which covers this sort of
thing... Might be worth considering if using that to get the unified
bindings might make sense here...

cc'd Linus in case he wants to comment on this.

It would obviously be a very heavy weight solution to the problem
so I'm far from convinced it makes sense - or even fits the usecase
terrible well.  Just thought I'd mention the possibility.
> ---
>  .../devicetree/bindings/iio/dac/ad5592r.txt        | 43 ++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/ad5592r.txt
> 
>  v2: Fix indentation issue
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/ad5592r.txt b/Documentation/devicetree/bindings/iio/dac/ad5592r.txt
> new file mode 100644
> index 0000000..12b8d0e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/ad5592r.txt
> @@ -0,0 +1,43 @@
> +Analog Devices AD5592R/AD5593R DAC/ADC device driver
> +
> +Required properties for the AD5592R:
> +	- compatible: Must be "adi,ad5592r"
> +	- reg: SPI chip select number for the device
> +	- spi-max-frequency: Max SPI frequency to use (< 30000000)
> +	- spi-cpol: The AD5592R requires inverse clock polarity (CPOL) mode
> +
> +Required properties for the AD5593R:
> +	- compatible: Must be "adi,ad5593r"
> +	- reg: I2C address of the device
> +
> +Required properties for all supported chips:
> +	- channel-modes: An array of eight 8-bit values (one per channel)
> +	  describing the mode of each channel. Macros specifying the valid values
> +	  can be found in <dt-bindings/iio/adi,ad5592r.h>.
> +	  The following values are currently supported:
> +		* CH_MODE_UNUSED (the pin is pulled down)
> +		* CH_MODE_DAC
> +		* CH_MODE_ADC
> +		* CH_MODE_GPIO_TRISTATE
> +
> +Example:
> +
> +	#include <dt-bindings/iio/adi,ad5592r.h>
> +
> +	ad5592r@0 {
> +		compatible = "adi,ad5592r";
> +		reg = <0>;
> +		spi-max-frequency = <1000000>;
> +		spi-cpol;
> +
> +		channel-modes = /bits/ 8 <
> +			CH_MODE_DAC
> +			CH_MODE_ADC
> +			CH_MODE_ADC
> +			CH_MODE_UNUSED
> +			CH_MODE_UNUSED
> +			CH_MODE_UNUSED
> +			CH_MODE_UNUSED
> +			CH_MODE_UNUSED
> +		>;
> +	};
> 

