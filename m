Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751283AbeF3RgZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 30 Jun 2018 13:36:25 -0400
Date: Sat, 30 Jun 2018 18:36:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andreas Klinger <ak@it-klinger.de>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com, mchehab@kernel.org,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, linus.walleij@linaro.org,
        rdunlap@infradead.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] iio: hx711: warning in dt binding example doc
Message-ID: <20180630183617.102dfb84@archlinux>
In-Reply-To: <20180625151926.GA6403@arbeit>
References: <20180625151926.GA6403@arbeit>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 25 Jun 2018 17:19:26 +0200
Andreas Klinger <ak@it-klinger.de> wrote:

> device tree compiler (dtc) gives a warning if a device node has "@" with a
> following number as it's name but no reg property.
> 
> fix the example in the documentation of avia,hx711 to conform to dtc
> behavior
> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>

Given there will be fuzz, I'll pick this up when patches 1 and 2 are
ready and Acked by a devicetree maintainer.

Thanks,

Jonathan
> ---
>  Documentation/devicetree/bindings/iio/adc/avia-hx711.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt b/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
> index d0c066e3df69..8c9bcaa4d750 100644
> --- a/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
> @@ -15,7 +15,7 @@ Optional properties:
>  			is 50000 in the datasheet
>  
>  Example:
> -weight@0 {
> +weight {
>  	compatible = "avia,hx711";
>  	sck-gpios = <&gpio3 10 GPIO_ACTIVE_HIGH>;
>  	dout-gpios = <&gpio0 7 GPIO_ACTIVE_HIGH>;

