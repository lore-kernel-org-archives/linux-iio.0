Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:53577 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946451AbcBROha (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 18 Feb 2016 09:37:30 -0500
Date: Thu, 18 Feb 2016 08:37:24 -0600
From: Rob Herring <robh@kernel.org>
To: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 4/4] iio: ad5755: Add full DT binding documentation
Message-ID: <20160218143724.GQ9654@rob-hp-laptop>
References: <1455632757-21748-1-git-send-email-sean.nyekjaer@prevas.dk>
 <1455632757-21748-2-git-send-email-sean.nyekjaer@prevas.dk>
 <1455632757-21748-3-git-send-email-sean.nyekjaer@prevas.dk>
 <1455632757-21748-4-git-send-email-sean.nyekjaer@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1455632757-21748-4-git-send-email-sean.nyekjaer@prevas.dk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Feb 16, 2016 at 03:25:57PM +0100, Sean Nyekjaer wrote:
> Signed-off-by: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
> ---
> Changes since v2:
>  - Removed defines, alot easier to read :-)
> 
>  .../devicetree/bindings/iio/dac/ad5755.txt         | 94 ++++++++++++++++++++++
>  1 file changed, 94 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/ad5755.txt b/Documentation/devicetree/bindings/iio/dac/ad5755.txt
> index 4c91583..751204b 100644
> --- a/Documentation/devicetree/bindings/iio/dac/ad5755.txt
> +++ b/Documentation/devicetree/bindings/iio/dac/ad5755.txt
> @@ -15,10 +15,104 @@ Recommended properties:
>   - spi-max-frequency: Definition as per
>  		Documentation/devicetree/bindings/spi/spi-bus.txt
>  
> +Optional properties:
> +See include/dt-bindings/iio/ad5755.h
> + - adi,ext_dc_dc_compenstation_resistor: boolean set if the hardware have an

Use - instead of _ in property names.

> +					 external resistor and thereby bypasses
> +					 the internal compensation resistor.
> + - adi,dc_dc_phase:
> +	Valid values for DC DC Phase control is:
> +	0: All dc-to-dc converters clock on the same edge.
> +	1: Channel A and Channel B clock on the same edge,
> +	   Channel C and Channel D clock on opposite edges.
> +	2: Channel A and Channel C clock on the same edge,
> +	   Channel B and Channel D clock on opposite edges.
> +	3: Channel A, Channel B, Channel C, and Channel D
> +	   clock 90 degrees out of phase from each other.
> + - adi,dc_dc_freq:
> +	Valid values for DC DC frequency is:
> +	0: 250 kHz.
> +	1: 410 kHz.
> +	2: 650 kHz.

It is preferrable to make the values the actual units rather than 
register values. Then we can have common properties. Is this a common 
property of a DAC?

> + - adi,dc_dc_maxv:
> +	Valid values for the maximum allowed Vboost voltage supplied by
> +	the dc-to-dc converter is:
> +	0: 23 V.
> +	1: 24.5 V.
> +	2: 27 V.
> +	3: 29.5 V.

Same here.

Rob

