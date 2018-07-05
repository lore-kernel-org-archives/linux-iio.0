Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:42956 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753186AbeGEVaV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 5 Jul 2018 17:30:21 -0400
Date: Thu, 5 Jul 2018 15:30:19 -0600
From: Rob Herring <robh@kernel.org>
To: Andreas Klinger <ak@it-klinger.de>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, mark.rutland@arm.com, mchehab@kernel.org,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, linus.walleij@linaro.org,
        rdunlap@infradead.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] iio: hx711: add clock-frequency property in DT
Message-ID: <20180705213019.GA12792@rob-hp-laptop>
References: <20180704123638.GA30535@arbeit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180704123638.GA30535@arbeit>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Jul 04, 2018 at 02:36:38PM +0200, Andreas Klinger wrote:
> Add clock-frequency property for hx711 ADC
> 
> This is the frequency of PD_SCK. It affects only the high value duration
> since low value duration is not relevant and we are not able to switch
> faster than the minimum duration specified.
> 
> After PD_SCK goes high DOUT is read just before PD_SCK goes down again.
> This is necessary because of parasitic capacities on the wiring.

s/capacities/capacitance/

> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> ---
>  Documentation/devicetree/bindings/iio/adc/avia-hx711.txt | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt b/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
> index b3629405f568..4bee51d536e1 100644
> --- a/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
> @@ -8,11 +8,21 @@ Required properties:
>  		See Documentation/devicetree/bindings/gpio/gpio.txt
>   - avdd-supply:	Definition of the regulator used as analog supply
>  
> +Optional properties:
> + - clock-frequency:	Frequency of PD_SCK
> +			This setting affects the duration of the high value
> +			phase of the clock (PD_SCK). The low value phase is
> +			not affected since it is not relevant for the
> +			measurement.

That's not how frequency works. The high time should be equal to the low 
time. If you have parasitic capacitance affecting the rise time, then it 
is going to affect the fall time too.

Perhaps there could be some reason not to have a square wave, but I 
didn't see one in the datasheet.

> +			Minimum value allowed is 20 kHz because of maximum
> +			high time of 50 microseconds.

So 10kHz should be minimum.

> +
>  Example:
>  weight@0 {
>  	compatible = "avia,hx711";
>  	sck-gpios = <&gpio3 10 GPIO_ACTIVE_HIGH>;
>  	dout-gpios = <&gpio0 7 GPIO_ACTIVE_HIGH>;
>  	avdd-suppy = <&avdd>;
> +	clock-frequency = <100000>;
>  };
>  
> -- 
> 2.1.4
