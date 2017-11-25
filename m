Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751674AbdKYQLa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 25 Nov 2017 11:11:30 -0500
Date: Sat, 25 Nov 2017 16:11:26 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: iio: light: add UVIS25 device
 bindings
Message-ID: <20171125161126.5ac74773@archlinux>
In-Reply-To: <20171123225906.31838-3-lorenzo.bianconi83@gmail.com>
References: <20171123225906.31838-1-lorenzo.bianconi83@gmail.com>
        <20171123225906.31838-3-lorenzo.bianconi83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 23 Nov 2017 23:59:06 +0100
Lorenzo Bianconi <lorenzo.bianconi83@gmail.com> wrote:

> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Applied
> ---
>  .../devicetree/bindings/iio/light/uvis25.txt       | 23 ++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/uvis25.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/uvis25.txt b/Documentation/devicetree/bindings/iio/light/uvis25.txt
> new file mode 100644
> index 000000000000..3041207e3f3c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/uvis25.txt
> @@ -0,0 +1,23 @@
> +* ST UVIS25 uv sensor
> +
> +Required properties:
> +- compatible: should be "st,uvis25"
> +- reg: i2c address of the sensor / spi cs line
> +
> +Optional properties:
> +- interrupt-parent: should be the phandle for the interrupt controller
> +- interrupts: interrupt mapping for IRQ. It should be configured with
> +  flags IRQ_TYPE_LEVEL_HIGH, IRQ_TYPE_EDGE_RISING, IRQ_TYPE_LEVEL_LOW or
> +  IRQ_TYPE_EDGE_FALLING.
> +
> +  Refer to interrupt-controller/interrupts.txt for generic interrupt
> +  client node bindings.
> +
> +Example:
> +
> +uvis25@47 {
> +	compatible = "st,uvis25";
> +	reg = <0x47>;
> +	interrupt-parent = <&gpio0>;
> +	interrupts = <0 IRQ_TYPE_EDGE_RISING>;
> +};

