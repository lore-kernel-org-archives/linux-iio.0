Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38482 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753340AbbHaRCb (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 31 Aug 2015 13:02:31 -0400
Subject: Re: [PATCH v5 2/2] dt: Document Holt HI-8435 bindings
To: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
References: <1440772029-3022-1-git-send-email-vladimir.barinov@cogentembedded.com>
 <1440772100-3115-1-git-send-email-vladimir.barinov@cogentembedded.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, cory.tusar@pid1solutions.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55E488A5.7000604@kernel.org>
Date: Mon, 31 Aug 2015 18:02:29 +0100
MIME-Version: 1.0
In-Reply-To: <1440772100-3115-1-git-send-email-vladimir.barinov@cogentembedded.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 28/08/15 15:28, Vladimir Barinov wrote:
> These bindings can be used to register Holt HI-8435 threshold detector
> 
> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
This is now trivial so I'm taking it.

Applied to the togreg branch of iio.git

Thanks,

Jonathan
> ---
> Changes in version 2:
> - renamed file name hi-843x.txt to hi8435.txt
> - removed hi-8436,hi-8436,hi-8437
> - removed holt,debounce-soft field
> - renamed holt,debounc-soft-delay to holt,debounce-interval
> - renamed mr-gpio to reset-gpios
> Changes in version 3:
> - none
> Changes in version 4:
> - removed debounce_interval property
> - removed reset-gpios to use GPIO descriptor API
> Changes in version 5:
> - none
> 
>  .../devicetree/bindings/iio/adc/hi8435.txt          | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/hi8435.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/hi8435.txt b/Documentation/devicetree/bindings/iio/adc/hi8435.txt
> new file mode 100644
> index 0000000..3b0348c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/hi8435.txt
> @@ -0,0 +1,21 @@
> +Holt Integrated Circuits HI-8435 threshold detector bindings
> +
> +Required properties:
> + - compatible: should be "holt,hi8435"
> + - reg: spi chip select number for the device
> +
> +Recommended properties:
> + - spi-max-frequency: definition as per
> +		Documentation/devicetree/bindings/spi/spi-bus.txt
> +
> +Optional properties:
> + - gpios: GPIO used for controlling the reset pin
> +
> +Example:
> +sensor@0 {
> +	compatible = "holt,hi8435";
> +	reg = <0>;
> +	gpios = <&gpio6 1 0>;
> +
> +	spi-max-frequency = <1000000>;
> +};
> 

