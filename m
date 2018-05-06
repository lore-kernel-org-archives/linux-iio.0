Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751751AbeEFRv2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 6 May 2018 13:51:28 -0400
Date: Sun, 6 May 2018 18:51:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
Cc: robh+dt@kernel.org, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: ti-dac5571: Add DT binding documentation
Message-ID: <20180506185123.2dcafe8b@archlinux>
In-Reply-To: <20180501081554.5832-2-sean.nyekjaer@prevas.dk>
References: <20180501081554.5832-1-sean.nyekjaer@prevas.dk>
        <20180501081554.5832-2-sean.nyekjaer@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue,  1 May 2018 10:15:54 +0200
Sean Nyekjaer <sean.nyekjaer@prevas.dk> wrote:

> Adding binding documentation for Texas Instruments DAC5571 Family
> 
> Signed-off-by: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied to the togreg branch of iio.git and pushed out as testing.

Thanks,

Jonathan

> ---
>  .../bindings/iio/dac/ti,dac5571.txt           | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/ti,dac5571.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/ti,dac5571.txt b/Documentation/devicetree/bindings/iio/dac/ti,dac5571.txt
> new file mode 100644
> index 000000000000..03af6b9a4d07
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/ti,dac5571.txt
> @@ -0,0 +1,24 @@
> +* Texas Instruments DAC5571 Family
> +
> +Required properties:
> + - compatible: Should contain
> +    "ti,dac5571"
> +    "ti,dac6571"
> +    "ti,dac7571"
> +    "ti,dac5574"
> +    "ti,dac6574"
> +    "ti,dac7574"
> +    "ti,dac5573"
> +    "ti,dac6573"
> +    "ti,dac7573"
> + - reg: Should contain the DAC I2C address
> +
> +Optional properties:
> + - vref-supply: The regulator supply for DAC reference voltage
> +
> +Example:
> +dac@0 {
> +	compatible = "ti,dac5571";
> +	reg = <0x4C>;
> +	vref-supply = <&vdd_supply>;
> +};

