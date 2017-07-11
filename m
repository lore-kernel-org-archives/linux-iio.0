Return-Path: <SRS0=JQ00=6O=gmail.com=robherring2@kernel.org>
Date: Mon, 10 Jul 2017 21:51:58 -0500
From: Rob Herring <robh@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	lorenzo.bianconi@st.com
Subject: Re: [PATCH 8/9] dt-bindings: iio: humidity: hts221: support open
 drain mode
Message-ID: <20170711025158.vpt6bcznkhi3bslm@rob-hp-laptop>
References: <20170709165704.26311-1-lorenzo.bianconi@st.com>
 <20170709165704.26311-9-lorenzo.bianconi@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170709165704.26311-9-lorenzo.bianconi@st.com>
List-ID: <linux-iio@vger.kernel.org>

On Sun, Jul 09, 2017 at 06:57:03PM +0200, Lorenzo Bianconi wrote:
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
> ---
>  Documentation/devicetree/bindings/iio/humidity/hts221.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/humidity/hts221.txt b/Documentation/devicetree/bindings/iio/humidity/hts221.txt
> index fca263e13400..732b83c06c08 100644
> --- a/Documentation/devicetree/bindings/iio/humidity/hts221.txt
> +++ b/Documentation/devicetree/bindings/iio/humidity/hts221.txt
> @@ -5,6 +5,14 @@ Required properties:
>  - reg: i2c address of the sensor / spi cs line
>  
>  Optional properties:
> +- drive-open-drain: the interrupt/data ready line will be configured

Needs a vendor prefix and "drdy-open-drain" would be more specific.

> +  as open drain, which is useful if several sensors share the same
> +  interrupt line. This is a boolean property.
> +  (This binding is taken from pinctrl/pinctrl-bindings.txt)
> +  If the requested interrupt is configured as IRQ_TYPE_LEVEL_HIGH or
> +  IRQ_TYPE_EDGE_RISING a pull-down resistor is needed to drive the line
> +  when it is not active, whereas a pull-up one is needed when interrupt
> +  line is configured as IRQ_TYPE_LEVEL_LOW or IRQ_TYPE_EDGE_FALLING.
>  - interrupt-parent: should be the phandle for the interrupt controller
>  - interrupts: interrupt mapping for IRQ. It should be configured with
>    flags IRQ_TYPE_LEVEL_HIGH, IRQ_TYPE_EDGE_RISING, IRQ_TYPE_LEVEL_LOW or
> -- 
> 2.13.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
