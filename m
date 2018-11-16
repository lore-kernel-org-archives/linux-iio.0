Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727710AbeKQEwO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 16 Nov 2018 23:52:14 -0500
Date: Fri, 16 Nov 2018 18:38:38 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Stefan Popa <stefan.popa@analog.com>
Cc: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <Michael.Hennerich@analog.com>, <gregkh@linuxfoundation.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 2/4] dt-bindings: iio: adc: Add common ADCs
 properties to a separate file
Message-ID: <20181116183838.6a079255@archlinux>
In-Reply-To: <1542108061-3471-1-git-send-email-stefan.popa@analog.com>
References: <1542108061-3471-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 13 Nov 2018 13:21:01 +0200
Stefan Popa <stefan.popa@analog.com> wrote:

> There are several ADC drivers that depend on the same device tree
> bindings. Rather than continue to duplicate the properties, this patch
> adds a common adc binding document that can be referenced. For beginning,
> only two properties are documented.
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
Looks very sensible to me, but as we are looking at a some generalization
here, I'd like an Ack from Rob if possible (as he suggested it I think :)

Thanks,

Jonathan

> ---
> Changes in v2, v3:
> 	- N/A.
> Changes in v4:
> 	- Added this commit.
> Changes in v5:
> 	- Nothing changed.
> 
>  Documentation/devicetree/bindings/iio/adc/adc.txt | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adc.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adc.txt b/Documentation/devicetree/bindings/iio/adc/adc.txt
> new file mode 100644
> index 0000000..5bbaa33
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adc.txt
> @@ -0,0 +1,23 @@
> +Common ADCs properties
> +
> +Optional properties for child nodes:
> +- bipolar : Boolean, if set the channel is used in bipolar mode.
> +- diff-channels : Differential channels muxed for this ADC. The first value
> +		specifies the positive input pin, the second value the negative
> +		input pin.
> +
> +Example:
> +	adc@0 {
> +		compatible = "some,adc";
> +		...
> +		channel@0 {
> +			bipolar;
> +			diff-channels = <0 1>;
> +			...
> +		};
> +
> +		channel@1 {
> +			diff-channels = <2 3>;
> +			...
> +		};
> +	};
