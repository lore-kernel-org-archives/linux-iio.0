Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:33633 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753418AbeGEVcl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 5 Jul 2018 17:32:41 -0400
Date: Thu, 5 Jul 2018 15:32:37 -0600
From: Rob Herring <robh@kernel.org>
To: Andreas Klinger <ak@it-klinger.de>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, mark.rutland@arm.com, mchehab@kernel.org,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, linus.walleij@linaro.org,
        rdunlap@infradead.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] iio: hx711: warning in dt binding example doc
Message-ID: <20180705213237.GA22282@rob-hp-laptop>
References: <20180704123719.GA30645@arbeit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180704123719.GA30645@arbeit>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Jul 04, 2018 at 02:37:19PM +0200, Andreas Klinger wrote:
> device tree compiler (dtc) gives a warning if a device node has "@" with a
> following number as it's name but no reg property.
> 
> fix the example in the documentation of avia,hx711 to conform to dtc
> behavior

Capitalization and punctuation needed.

The subject could be more specific. Perhaps "... fix spurious 
unit-address in example"

> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> ---
>  Documentation/devicetree/bindings/iio/adc/avia-hx711.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt b/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
> index 4bee51d536e1..b218e093b55a 100644
> --- a/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
> @@ -18,7 +18,7 @@ Optional properties:
>  			high time of 50 microseconds.
>  
>  Example:
> -weight@0 {
> +weight {
>  	compatible = "avia,hx711";
>  	sck-gpios = <&gpio3 10 GPIO_ACTIVE_HIGH>;
>  	dout-gpios = <&gpio0 7 GPIO_ACTIVE_HIGH>;
> -- 
> 2.1.4
