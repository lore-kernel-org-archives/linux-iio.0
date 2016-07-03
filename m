Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57486 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751890AbcGCKlf (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 3 Jul 2016 06:41:35 -0400
Subject: Re: [PATCH v3 1/2] iio: adc: max1363: Add device tree binding
 documentation
To: Florian Vaussard <florian.vaussard@gmail.com>,
	devicetree@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <1467272586-28761-1-git-send-email-florian.vaussard@heig-vd.ch>
 <1467272586-28761-2-git-send-email-florian.vaussard@heig-vd.ch>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Martin Kepplinger <martink@posteo.de>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Florian Vaussard <florian.vaussard@heig-vd.ch>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <57424d5d-2b28-2ea1-153c-6282899492a9@kernel.org>
Date: Sun, 3 Jul 2016 11:41:32 +0100
MIME-Version: 1.0
In-Reply-To: <1467272586-28761-2-git-send-email-florian.vaussard@heig-vd.ch>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 30/06/16 08:43, Florian Vaussard wrote:
> Add the device tree documentation for all the supported parts. Mandatory
> binding is the compatible string and the slave I2C address.
> 
> Optional properties can be used to specify the Vcc / Vref regulators, as
> well as the IRQ line if available.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Florian Vaussard <florian.vaussard@heig-vd.ch>
Really small point, but typically author sign off goes first then acks etc
that are gained at any intermediate states, then the sign off of whoever takes
the patch and applies it (here, that's me).  So it kind of communicates some
idea of when in the process various tags were obtained.  It's not a rule
set in stone though so I'll be lazy and leave this as it is.

Anyhow, great and applied to the togreg branch of iio.git initially pushed
out as testing for the autobuilders to poke it (or not in the case of this
docume

Jonathan
> ---
>  .../devicetree/bindings/iio/adc/max1363.txt        | 63 ++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/max1363.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/max1363.txt b/Documentation/devicetree/bindings/iio/adc/max1363.txt
> new file mode 100644
> index 0000000..94a9011
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/max1363.txt
> @@ -0,0 +1,63 @@
> +* Maxim 1x3x/136x/116xx Analog to Digital Converter (ADC)
> +
> +The node for this driver must be a child node of a I2C controller, hence
> +all mandatory properties for your controller must be specified. See directory:
> +
> +        Documentation/devicetree/bindings/i2c
> +
> +for more details.
> +
> +Required properties:
> +  - compatible: Should be one of
> +		"maxim,max1361"
> +		"maxim,max1362"
> +		"maxim,max1363"
> +		"maxim,max1364"
> +		"maxim,max1036"
> +		"maxim,max1037"
> +		"maxim,max1038"
> +		"maxim,max1039"
> +		"maxim,max1136"
> +		"maxim,max1137"
> +		"maxim,max1138"
> +		"maxim,max1139"
> +		"maxim,max1236"
> +		"maxim,max1237"
> +		"maxim,max1238"
> +		"maxim,max1239"
> +		"maxim,max11600"
> +		"maxim,max11601"
> +		"maxim,max11602"
> +		"maxim,max11603"
> +		"maxim,max11604"
> +		"maxim,max11605"
> +		"maxim,max11606"
> +		"maxim,max11607"
> +		"maxim,max11608"
> +		"maxim,max11609"
> +		"maxim,max11610"
> +		"maxim,max11611"
> +		"maxim,max11612"
> +		"maxim,max11613"
> +		"maxim,max11614"
> +		"maxim,max11615"
> +		"maxim,max11616"
> +		"maxim,max11617"
> +		"maxim,max11644"
> +		"maxim,max11645"
> +		"maxim,max11646"
> +		"maxim,max11647"
> +  - reg: Should contain the ADC I2C address
> +
> +Optional properties:
> +  - vcc-supply: phandle to the regulator that provides power to the ADC.
> +  - vref-supply: phandle to the regulator for ADC reference voltage.
> +  - interrupts: IRQ line for the ADC. If not used the driver will use
> +    polling.
> +
> +Example:
> +adc: max11644@36 {
> +	compatible = "maxim,max11644";
> +	reg = <0x36>;
> +	vref-supply = <&adc_vref>;
> +};
> 

