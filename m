Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52711 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751831AbbDIOAL (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 9 Apr 2015 10:00:11 -0400
Message-ID: <552685E9.2090704@kernel.org>
Date: Thu, 09 Apr 2015 15:00:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Antoine Tenart <antoine.tenart@free-electrons.com>,
	sebastian.hesselbarth@gmail.com, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net
CC: zmxu@marvell.com, jszhang@marvell.com, yrliao@marvell.com,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] Documentation: bindings: document the Berlin ADC
 driver
References: <1428066409-30392-1-git-send-email-antoine.tenart@free-electrons.com> <1428066409-30392-3-git-send-email-antoine.tenart@free-electrons.com>
In-Reply-To: <1428066409-30392-3-git-send-email-antoine.tenart@free-electrons.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/04/15 14:06, Antoine Tenart wrote:
> Following the addition of a Berlin ADC driver, this patch adds the
> corresponding bindings documentation.
> 
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
About as straightfoward as they come.

Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  .../devicetree/bindings/iio/adc/berlin2_adc.txt       | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/berlin2_adc.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/berlin2_adc.txt b/Documentation/devicetree/bindings/iio/adc/berlin2_adc.txt
> new file mode 100644
> index 000000000000..908334c6b07f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/berlin2_adc.txt
> @@ -0,0 +1,19 @@
> +* Berlin Analog to Digital Converter (ADC)
> +
> +The Berlin ADC has 8 channels, with one connected to a temperature sensor.
> +It is part of the system controller register set. The ADC node should be a
> +sub-node of the system controller node.
> +
> +Required properties:
> +- compatible: must be "marvell,berlin2-adc"
> +- interrupts: the interrupts for the ADC and the temperature sensor
> +- interrupt-names: should be "adc" and "tsen"
> +
> +Example:
> +
> +adc: adc {
> +	compatible = "marvell,berlin2-adc";
> +	interrupt-parent = <&sic>;
> +	interrupts = <12>, <14>;
> +	interrupt-names = "adc", "tsen";
> +};
> 

