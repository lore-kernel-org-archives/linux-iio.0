Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750984AbdE1P0j (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 28 May 2017 11:26:39 -0400
Date: Sun, 28 May 2017 16:26:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Eugen Hristev <eugen.hristev@microchip.com>
Cc: <nicolas.ferre@microchip.com>, <alexandre.belloni@microchip.com>,
        <linux-iio@vger.kernel.org>, <lars@metafoo.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ludovic.desroches@microchip.com>
Subject: Re: [PATCH v3 2/4] Documentation: dt: iio: at91-sama5d2_adc: add
 adtrg trigger binding
Message-ID: <20170528162636.64f9bcfe@kernel.org>
In-Reply-To: <1495711034-28410-3-git-send-email-eugen.hristev@microchip.com>
References: <1495711034-28410-1-git-send-email-eugen.hristev@microchip.com>
        <1495711034-28410-3-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 25 May 2017 14:17:12 +0300
Eugen Hristev <eugen.hristev@microchip.com> wrote:

> Add node information for ADTRG hardware pin and the three possible
> edge nodes that are available for the driver
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>

Given this is effectively an internal interrupt (i.e. one that software
never sees) I wonder if we can borrow some of the form of the binding
from there?

I'm not really sure it fits though so this is only a passing quick thought!

Jonathan
> ---
>  .../devicetree/bindings/iio/adc/at91-sama5d2_adc.txt    | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt b/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt
> index 3223684..e30ede3 100644
> --- a/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt
> @@ -11,6 +11,13 @@ Required properties:
>    - atmel,min-sample-rate-hz: Minimum sampling rate, it depends on SoC.
>    - atmel,max-sample-rate-hz: Maximum sampling rate, it depends on SoC.
>    - atmel,startup-time-ms: Startup time expressed in ms, it depends on SoC.
> +  - atmel,trigger-edge-type: phandle to one of the adtrg possible edge types
> +
> +Required adtrg node:
> +  - Required edge nodes:
> +	For each possible edge type for the ADTRG hardware trigger pin,
> +	 a specific sub node. The driver recognises only the three possible
> +	 edge types: external_rising, external_falling, external_any.
>  
>  Example:
>  
> @@ -25,4 +32,14 @@ adc: adc@fc030000 {
>  	atmel,startup-time-ms = <4>;
>  	vddana-supply = <&vdd_3v3_lp_reg>;
>  	vref-supply = <&vdd_3v3_lp_reg>;
> +	atmel,trigger-edge-type = <&external_rising>;
> +
> +	adtrg: adtrg {
> +		external_rising: external_rising {
> +		};
> +		external_falling: external_falling {
> +		};
> +		external_any: external_any {
> +		};
> +	};
>  }

