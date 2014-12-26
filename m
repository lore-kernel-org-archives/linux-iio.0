Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44950 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751627AbaLZL6D (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 26 Dec 2014 06:58:03 -0500
Message-ID: <549D4D49.5000101@kernel.org>
Date: Fri, 26 Dec 2014 11:58:01 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Angelo Compagnucci <angelo.compagnucci@gmail.com>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: mcp3422: Add DT binding documentation
References: <1418839862-4235-1-git-send-email-angelo.compagnucci@gmail.com>
In-Reply-To: <1418839862-4235-1-git-send-email-angelo.compagnucci@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 17/12/14 18:11, Angelo Compagnucci wrote:
> Adding binding documentation for ADC MCP3422.
No sign off.

Also, should go to the device tree list and maintainers.
Another option for this would be to add it to the list
in bindings/i2c/trivial-devices - but I think I prefer them
to have explicit binding docs myself.

Jonathan
> ---
>  Documentation/devicetree/bindings/iio/adc/mcp3422.txt | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/mcp3422.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/mcp3422.txt b/Documentation/devicetree/bindings/iio/adc/mcp3422.txt
> new file mode 100644
> index 0000000..d6d6eb6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/mcp3422.txt
> @@ -0,0 +1,12 @@
> +* Microchip mcp3422/3/4/6/7/8 chip family (ADC)
> +
> +Required properties:
> +  - compatible: Should be 
> +               "microchip,mcp3422" or
> +               "microchip,mcp3423" or
> +               "microchip,mcp3424" or
> +               "microchip,mcp3426" or
> +               "microchip,mcp3427" or
> +               "microchip,mcp3428"
> +  - reg: I2C address for the device
> +
> +Example:
> +adc@0 {
> +	compatible = "microchip,mcp3424";
> +	reg = <0x68>;
> +};
> 

