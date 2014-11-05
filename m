Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42583 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753888AbaKENkL (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 5 Nov 2014 08:40:11 -0500
Message-ID: <545A28B6.9000902@kernel.org>
Date: Wed, 05 Nov 2014 13:40:06 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
	linux-iio@vger.kernel.org, lars@metafoo.de,
	Naidu.Tellapati@imgtec.com, james.hartley@imgtec.com,
	abrestic@chromium.org
CC: Phani Movva <Phani.Movva@imgtec.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>
Subject: Re: [PATCH 2/2] DT: iio: adc: Add CC_10001 binding documentation
References: <1414615531-26172-1-git-send-email-ezequiel.garcia@imgtec.com> <1414615531-26172-3-git-send-email-ezequiel.garcia@imgtec.com>
In-Reply-To: <1414615531-26172-3-git-send-email-ezequiel.garcia@imgtec.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 29/10/14 20:45, Ezequiel Garcia wrote:
> From: Phani Movva <Phani.Movva@imgtec.com>
> 
> Add the devicetree binding document for Cosmic Circuits 10001 ADC device.
> 
> Signed-off-by: Phani Movva <Phani.Movva@imgtec.com>
> Signed-off-by: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
> [Ezequiel: minor style cleaning]
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Looks fine, but as with all bindings needs to go to the device tree list
and maintainers for them to take a look.
> ---
>  .../devicetree/bindings/iio/adc/cc_10001_adc.txt      | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/cc_10001_adc.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/cc_10001_adc.txt b/Documentation/devicetree/bindings/iio/adc/cc_10001_adc.txt
> new file mode 100644
> index 0000000..6491839
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/cc_10001_adc.txt
> @@ -0,0 +1,19 @@
> +* Cosmic Circuits - Analog to Digital Converter (CC-10001-ADC)
> +
> +Required properties:
> +  - compatible: Should be "cosmic,10001-adc"
> +  - reg: Should contain adc registers location and length.
> +  - cosmic,adc-available-channels: Bitmask of the channels currently enabled.
> +  - clock-names: Should contain "adc".
> +  - clocks: phandles to input clocks.
> +  - vref-supply: The regulator supply ADC reference voltage.
> +
> +Example:
> +adc: adc@18101600 {
> +	compatible = "cosmic,10001-adc";
> +	reg = <0x18101600 0x24>;
> +	cosmic,adc-available-channels = <0xa>;
> +	clocks = <&adc_clk>;
> +	clock-names = "adc";
> +	vref-supply = <&reg_1v8>;
> +};
> 
