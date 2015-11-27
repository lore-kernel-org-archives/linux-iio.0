Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:53897 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754942AbbK0UPc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 27 Nov 2015 15:15:32 -0500
Date: Fri, 27 Nov 2015 14:15:26 -0600
From: Rob Herring <robh@kernel.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: iio: adc: Update mcp342x binding for
 the mcp3421
Message-ID: <20151127201526.GA31568@rob-hp-laptop>
References: <1448632372-5315-1-git-send-email-s.hauer@pengutronix.de>
 <1448632372-5315-3-git-send-email-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1448632372-5315-3-git-send-email-s.hauer@pengutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Nov 27, 2015 at 02:52:52PM +0100, Sascha Hauer wrote:
> The mcp3421 is the single channel variant of the mcp342x family and
> can be supported by the mcp342x driver.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: devicetree@vger.kernel.org

Acked-by: Rob Herring <robh@kernel.org>

> ---
>  Documentation/devicetree/bindings/iio/adc/mcp3422.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/mcp3422.txt b/Documentation/devicetree/bindings/iio/adc/mcp3422.txt
> index 333139c..dcae4cc 100644
> --- a/Documentation/devicetree/bindings/iio/adc/mcp3422.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/mcp3422.txt
> @@ -1,7 +1,8 @@
> -* Microchip mcp3422/3/4/6/7/8 chip family (ADC)
> +* Microchip mcp3421/2/3/4/6/7/8 chip family (ADC)
>  
>  Required properties:
>   - compatible: Should be
> +	"microchip,mcp3421" or
>  	"microchip,mcp3422" or
>  	"microchip,mcp3423" or
>  	"microchip,mcp3424" or
> -- 
> 2.6.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
