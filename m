Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42390 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753716AbbCILEq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 9 Mar 2015 07:04:46 -0400
Message-ID: <54FD7E4D.20403@kernel.org>
Date: Mon, 09 Mar 2015 11:04:45 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Angelo Compagnucci <angelo.compagnucci@gmail.com>,
	linux-iio@vger.kernel.org
CC: devicetree@vger.kernel.org
Subject: Re: [PATCH] iio: mcp3422: Add DT binding documentation
References: <1425821843-29185-1-git-send-email-angelo.compagnucci@gmail.com>
In-Reply-To: <1425821843-29185-1-git-send-email-angelo.compagnucci@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/03/15 13:37, Angelo Compagnucci wrote:
> Adding binding documentation for ADC MCP3422.
> 
> Signed-off-by: Angelo Compagnucci <angelo.compagnucci@gmail.com>
Applied to the togreg branch of iio.git

Thanks,

> ---
>  Documentation/devicetree/bindings/iio/adc/mcp3422.txt | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/mcp3422.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/mcp3422.txt b/Documentation/devicetree/bindings/iio/adc/mcp3422.txt
> new file mode 100644
> index 0000000..333139c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/mcp3422.txt
> @@ -0,0 +1,17 @@
> +* Microchip mcp3422/3/4/6/7/8 chip family (ADC)
> +
> +Required properties:
> + - compatible: Should be
> +	"microchip,mcp3422" or
> +	"microchip,mcp3423" or
> +	"microchip,mcp3424" or
> +	"microchip,mcp3426" or
> +	"microchip,mcp3427" or
> +	"microchip,mcp3428"
> + - reg: I2C address for the device
> +
> +Example:
> +adc@0 {
> +	compatible = "microchip,mcp3424";
> +	reg = <0x68>;
> +};
> 

