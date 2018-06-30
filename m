Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751460AbeF3Rcj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 30 Jun 2018 13:32:39 -0400
Date: Sat, 30 Jun 2018 18:32:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andreas Klinger <ak@it-klinger.de>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com, mchehab@kernel.org,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, linus.walleij@linaro.org,
        rdunlap@infradead.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] iio: hx711: add data-ready-delay-ns property in
 DT
Message-ID: <20180630183232.540ce031@archlinux>
In-Reply-To: <20180625151802.GA6369@arbeit>
References: <20180625151802.GA6369@arbeit>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 25 Jun 2018 17:18:02 +0200
Andreas Klinger <ak@it-klinger.de> wrote:

> add data-ready-delay-ns property for hx711 ADC
> this is the delay after rising PD_SCK until DOUT is read and assumed to be
> ready
> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>

Hmm. It's not particularly generic... I think this should have
have vendor prefix until we have some visibility of whether it
is a common thing we want to standardise around or not.

I'll also be waiting for a devicetree ack on this one as it's a
tiny bit unusual.

Thanks,

Jonathan
> ---
>  Documentation/devicetree/bindings/iio/adc/avia-hx711.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt b/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
> index b3629405f568..d0c066e3df69 100644
> --- a/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
> @@ -8,11 +8,18 @@ Required properties:
>  		See Documentation/devicetree/bindings/gpio/gpio.txt
>   - avdd-supply:	Definition of the regulator used as analog supply
>  
> +Optional properties:
> + - data-ready-delay-ns:	additional delay in nanoseconds between rising of
> +			PD_SCK until DOUT is ready
> +			should be less then maximum PD_SCK high time which
> +			is 50000 in the datasheet
> +
>  Example:
>  weight@0 {
>  	compatible = "avia,hx711";
>  	sck-gpios = <&gpio3 10 GPIO_ACTIVE_HIGH>;
>  	dout-gpios = <&gpio0 7 GPIO_ACTIVE_HIGH>;
>  	avdd-suppy = <&avdd>;
> +	data-ready-delay-ns = <1000>;
>  };
>  

