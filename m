Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751047AbeBJPsb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 10 Feb 2018 10:48:31 -0500
Date: Sat, 10 Feb 2018 15:48:26 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Phil Reid <preid@electromag.com.au>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com,
        Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, martinbv@mothictech.com
Subject: Re: [PATCH v5 1/2] dt-bindings: ad5272: Add bindings for Analog
 Devices digital potentiometers
Message-ID: <20180210154826.060cbec0@archlinux>
In-Reply-To: <1518137847-63381-2-git-send-email-preid@electromag.com.au>
References: <1518137847-63381-1-git-send-email-preid@electromag.com.au>
        <1518137847-63381-2-git-send-email-preid@electromag.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri,  9 Feb 2018 08:57:26 +0800
Phil Reid <preid@electromag.com.au> wrote:

> Add binding documentation for Analog Devices AD5272 and AD5274 digital
> potentiometer devices.
> 
> Signed-off-by: Phil Reid <preid@electromag.com.au>
Applied

Thanks,

Jonathan
> ---
>  .../bindings/iio/potentiometer/ad5272.txt          | 27 ++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/potentiometer/ad5272.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/potentiometer/ad5272.txt b/Documentation/devicetree/bindings/iio/potentiometer/ad5272.txt
> new file mode 100644
> index 0000000..f9b2eef
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/potentiometer/ad5272.txt
> @@ -0,0 +1,27 @@
> +* Analog Devices AD5272 digital potentiometer
> +
> +The node for this device must be a child node of a I2C controller, hence
> +all mandatory properties for your controller must be specified. See directory:
> +
> +        Documentation/devicetree/bindings/i2c
> +
> +for more details.
> +
> +Required properties:
> +	- compatible:  	Must be one of the following, depending on the model:
> +			adi,ad5272-020
> +			adi,ad5272-050
> +			adi,ad5272-100
> +			adi,ad5274-020
> +			adi,ad5274-100
> +
> +Optional properties:
> + - reset-gpios: GPIO specification for the RESET input. This is an
> +		active low signal to the AD5272.
> +
> +Example:
> +ad5272: potentiometer@2f {
> +	reg = <0x2F>;
> +	compatible = "adi,ad5272-020";
> +	reset-gpios = <&gpio3 6 GPIO_ACTIVE_HIGH>;
> +};

