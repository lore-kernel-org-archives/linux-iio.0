Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37640 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753486AbaKHM5Z (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 8 Nov 2014 07:57:25 -0500
Message-ID: <545E1333.9010904@kernel.org>
Date: Sat, 08 Nov 2014 12:57:23 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Andrew Bresticker <abrestic@chromium.org>,
	James Hartley <james.hartley@imgtec.com>,
	Phani Movva <phani.movva@imgtec.com>
CC: linux-iio@vger.kernel.org, pmeerw@pmeerw.net, knaack.h@gmx.de,
	devicetree@vger.kernel.org,
	Naidu Tellapati <Naidu.Tellapati@imgtec.com>
Subject: Re: [PATCH v2 2/3] DT: iio: adc: Add CC_10001 binding documentation
References: <1415224611-22096-1-git-send-email-ezequiel.garcia@imgtec.com> <1415224611-22096-3-git-send-email-ezequiel.garcia@imgtec.com>
In-Reply-To: <1415224611-22096-3-git-send-email-ezequiel.garcia@imgtec.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/11/14 21:56, Ezequiel Garcia wrote:
> From: Phani Movva <Phani.Movva@imgtec.com>
> 
> Add the devicetree binding document for Cosmic Circuits 10001 ADC device.
> 
> Signed-off-by: Phani Movva <Phani.Movva@imgtec.com>
> Signed-off-by: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
> [Ezequiel: minor style cleaning]
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Please resend including the device tree list and maintainers.
All bindings must go to them whatever part they are for.


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
I suspect there may be other preferred ways of doing this (child nodes perhaps
for each enabled channel?)

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

