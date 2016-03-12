Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45427 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750776AbcCLSRn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 12 Mar 2016 13:17:43 -0500
Subject: Re: [PATCH v3 4/4] dt: document NXP LPC1850 DAC driver bindings
To: Joachim Eastwood <manabian@gmail.com>
References: <1457785817-32328-1-git-send-email-manabian@gmail.com>
 <1457785817-32328-5-git-send-email-manabian@gmail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, robh+dt@kernel.org,
	devicetree@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56E45D45.4050605@kernel.org>
Date: Sat, 12 Mar 2016 18:17:41 +0000
MIME-Version: 1.0
In-Reply-To: <1457785817-32328-5-git-send-email-manabian@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/03/16 12:30, Joachim Eastwood wrote:
> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
A very straight forward binding so I'm happy to apply this without
a devicetree ack (still time if anyone does want to take a look though as
it won't be in my non rebasing tree until probably next weekend now.)

Applied to the togreg branch of iio.git - initially pushed out as testing
for the autobuilders to play with it.

We have unfortunately missed the merge window that will probably open tomorrow
(as IIO stuff must be in a few weeks before that) so this is looking at the
next merge window in 3 months time.  Will be in linux-next in about 3-4 weeks
though after I send a pull request to Greg KH post merge window closing.

Thanks,

Jonathan
> ---
>  .../devicetree/bindings/iio/dac/lpc1850-dac.txt      | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/lpc1850-dac.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/lpc1850-dac.txt b/Documentation/devicetree/bindings/iio/dac/lpc1850-dac.txt
> new file mode 100644
> index 000000000000..7d6647d4af5e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/lpc1850-dac.txt
> @@ -0,0 +1,20 @@
> +NXP LPC1850 DAC bindings
> +
> +Required properties:
> +- compatible: Should be "nxp,lpc1850-dac"
> +- reg: Offset and length of the register set for the ADC device
> +- interrupts: The interrupt number for the ADC device
> +- clocks: The root clock of the ADC controller
> +- vref-supply: The regulator supply ADC reference voltage
> +- resets: phandle to reset controller and line specifier
> +
> +Example:
> +dac: dac@400e1000 {
> +	compatible = "nxp,lpc1850-dac";
> +	reg = <0x400e1000 0x1000>;
> +	interrupts = <0>;
> +	clocks = <&ccu1 CLK_APB3_DAC>;
> +	vref-supply = <&reg_vdda>;
> +	resets = <&rgu 42>;
> +	status = "disabled";
> +};
> 

