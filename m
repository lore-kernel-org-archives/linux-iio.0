Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35446 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752226AbbCHMfs (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 8 Mar 2015 08:35:48 -0400
Message-ID: <54FC4222.3030206@kernel.org>
Date: Sun, 08 Mar 2015 12:35:46 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Angelo Compagnucci <angelo.compagnucci@gmail.com>,
	devicetree@vger.kernel.org
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: mcp3422: Add DT binding documentation
References: <1424085663-21799-1-git-send-email-angelo.compagnucci@gmail.com>
In-Reply-To: <1424085663-21799-1-git-send-email-angelo.compagnucci@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 16/02/15 11:21, Angelo Compagnucci wrote:
> Adding binding documentation for ADC MCP3422.
Could have gone in the trivial bindings, but I'm happy enough happy enough with it
here.

Anyhow, no sign off so not applied.  Please repost with a sign off.

Jonathan
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

