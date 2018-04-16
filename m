Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ot0-f195.google.com ([74.125.82.195]:37323 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753323AbeDPUIH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Apr 2018 16:08:07 -0400
Date: Mon, 16 Apr 2018 15:08:05 -0500
From: Rob Herring <robh@kernel.org>
To: =?iso-8859-1?Q?Hern=E1n?= Gonzalez <hernan@vanguardiasur.com.ar>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 11/14] staging: iio: ad7746: Add devicetree bindings
 documentation
Message-ID: <20180416200805.nybyyrribqvnigh3@rob-hp-laptop>
References: <1523637411-8531-1-git-send-email-hernan@vanguardiasur.com.ar>
 <1523637411-8531-12-git-send-email-hernan@vanguardiasur.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1523637411-8531-12-git-send-email-hernan@vanguardiasur.com.ar>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Apr 13, 2018 at 01:36:48PM -0300, Hernán Gonzalez wrote:

Commit msg?

> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Hernán Gonzalez <hernan@vanguardiasur.com.ar>
> ---
>  .../devicetree/bindings/staging/iio/cdc/ad7746.txt | 34 ++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/staging/iio/cdc/ad7746.txt
> 
> diff --git a/Documentation/devicetree/bindings/staging/iio/cdc/ad7746.txt b/Documentation/devicetree/bindings/staging/iio/cdc/ad7746.txt
> new file mode 100644
> index 0000000..7740f05
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/staging/iio/cdc/ad7746.txt
> @@ -0,0 +1,34 @@
> +Analog Devices AD7746/5/7 capacitive sensor driver
> +
> +Required properties:
> +	- compatible: Should be one of
> +		* "adi,ad7745"
> +		* "adi,ad7746"
> +	  * "adi,ad7747"

Alignment.

> +	- reg: The 7-bits long I2c address of the device
> +
> +Optional properties:
> +	- adi,exclvl: This property defines the excitation voltage level for the
> +    capacitance to be measured. Possible values are:
> +      * 0 = +-VDD/8
> +      * 1 = +-VDD/4
> +      * 2 = +-VDD * 3/8
> +      * 3 = +-VDD/2 (Default)
> +	- adi,nexca_en: Invert excitation output A.
> +	- adi,nexcb_en:	Invert excitation output B.

s/_/-/

> +
> +Example:
> +Here exclvl would be 1 (VDD/4), Excitation pin A would be inverted and
> +Excitation pin B would NOT be inverted.
> +
> +i2c2 {
> +
> +      < . . . >
> +
> +      ad7746: ad7746@60 {
> +              compatible = "ad7746";
> +              reg = <0x60>;
> +              adi,exclvl = <1>;
> +              adi,nexca_en;
> +      };
> +};
> -- 
> 2.7.4
> 
