Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:42956 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755046AbcLNKMH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 14 Dec 2016 05:12:07 -0500
Subject: Re: [PATCH v2 1/2] iio: adc: hx711: Add DT binding for avia,hx711
To: Andreas Klinger <ak@it-klinger.de>, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
References: <20161214095945.GA26511@andreas>
Cc: linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        pawel.moll@arm.com, mark.rutland@arm.com,
        ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
        jic23@kernel.org, knaack.h@gmx.de, pmeerw@pmeerw.net
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <470f0017-2607-d5bd-bcd3-69f892cdc88b@metafoo.de>
Date: Wed, 14 Dec 2016 11:11:36 +0100
MIME-Version: 1.0
In-Reply-To: <20161214095945.GA26511@andreas>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/14/2016 10:59 AM, Andreas Klinger wrote:
> Add DT bindings for avia,hx711
> Add vendor avia to vendor list
> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> ---
>  .../devicetree/bindings/iio/adc/avia-hx711.txt      | 21 +++++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.txt         |  1 +
>  2 files changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt b/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
> new file mode 100644
> index 000000000000..6a4659fc7a4f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
> @@ -0,0 +1,21 @@
> +* AVIA HX711 ADC chip for weight cells
> +  Bit-banging driver
> +
> +Required properties:
> + - compatible: Should be "avia,hx711"
> + - sck-gpios:	Definition of the GPIO for the clock
> + - dout-gpios:	Definition of the GPIO for data-out
> +		See Documentation/devicetree/bindings/gpio/gpio.txt
> +
> +Recommended properties:
> + - gain:	Gain select, can be 32, 64 or 128
> +		default is 128

If the gain is software programmable it should be exposed by the driver
allowing the application to change it rather than putting it in the devicetree.

