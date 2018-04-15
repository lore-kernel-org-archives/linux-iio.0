Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752506AbeDOPht (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Apr 2018 11:37:49 -0400
Date: Sun, 15 Apr 2018 16:37:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?SGVybsOhbg==?= Gonzalez <hernan@vanguardiasur.com.ar>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, Michael.Hennerich@analog.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 11/14] staging: iio: ad7746: Add devicetree bindings
 documentation
Message-ID: <20180415163743.2fa992f9@archlinux>
In-Reply-To: <1523637411-8531-12-git-send-email-hernan@vanguardiasur.com.ar>
References: <1523637411-8531-1-git-send-email-hernan@vanguardiasur.com.ar>
        <1523637411-8531-12-git-send-email-hernan@vanguardiasur.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 13 Apr 2018 13:36:48 -0300
Hernán Gonzalez <hernan@vanguardiasur.com.ar> wrote:

> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Hernán Gonzalez <hernan@vanguardiasur.com.ar>
A few comments inline.

Thanks,

Jonathan

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

The naming is rather odd.  Why _en?

> +	- adi,nexcb_en:	Invert excitation output B.
> +
> +Example:
> +Here exclvl would be 1 (VDD/4), Excitation pin A would be inverted and
> +Excitation pin B would NOT be inverted.
> +
> +i2c2 {
> +
> +      < . . . >
What does this spacer add to the example?
Sure, there can be other devices, but no need to illustrate that here.

> +
> +      ad7746: ad7746@60 {
> +              compatible = "ad7746";
> +              reg = <0x60>;
> +              adi,exclvl = <1>;
> +              adi,nexca_en;
> +      };
> +};

