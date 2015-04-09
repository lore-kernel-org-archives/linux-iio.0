Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52751 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753451AbbDIOFZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 9 Apr 2015 10:05:25 -0400
Message-ID: <55268724.1040102@kernel.org>
Date: Thu, 09 Apr 2015 15:05:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: =?UTF-8?B?Vmlhbm5leSBsZSBDbMOpbWVudCBkZSBTYWludC1NYXJjcQ==?=
	<vianney.leclement@essensium.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
CC: "Arnout Vandecappelle (Essensium/Mind)" <arnout@mind.be>
Subject: Re: [PATCH v3 2/5] iio: mlx90614: Add devicetree bindings documentation
References: <1427704502-22347-1-git-send-email-vianney.leclement@essensium.com> <1427704502-22347-3-git-send-email-vianney.leclement@essensium.com>
In-Reply-To: <1427704502-22347-3-git-send-email-vianney.leclement@essensium.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 30/03/15 09:34, Vianney le Clément de Saint-Marcq wrote:
> Also introduce "melexis" as a vendor prefix for device tree bindings.
> 
> Signed-off-by: Vianney le Clément de Saint-Marcq <vianney.leclement@essensium.com>
> Cc: Arnout Vandecappelle (Essensium/Mind) <arnout@mind.be>
Nothing even remotely controversial in here so applied to the togreg branch of iio.git
initially pushed out as testing.  Thanks,

Jonathan
> 
> ---
> 
> v3: new patch split out from v2 patch 6 (power management)
> ---
>  .../devicetree/bindings/iio/temperature/mlx90614.txt      | 15 +++++++++++++++
>  Documentation/devicetree/bindings/vendor-prefixes.txt     |  1 +
>  2 files changed, 16 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/temperature/mlx90614.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/temperature/mlx90614.txt b/Documentation/devicetree/bindings/iio/temperature/mlx90614.txt
> new file mode 100644
> index 0000000..4c959f3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/temperature/mlx90614.txt
> @@ -0,0 +1,15 @@
> +* Melexis MLX90614 contactless IR temperature sensor
> +
> +http://melexis.com/Infrared-Thermometer-Sensors/Infrared-Thermometer-Sensors/MLX90614-615.aspx
> +
> +Required properties:
> +
> +  - compatible: should be "melexis,mlx90614"
> +  - reg: the I2C address of the sensor
> +
> +Example:
> +
> +mlx90614@5a {
> +	compatible = "melexis,mlx90614";
> +	reg = <0x5a>;
> +};
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index fae26d0..c8db30c 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -110,6 +110,7 @@ lltc	Linear Technology Corporation
>  marvell	Marvell Technology Group Ltd.
>  maxim	Maxim Integrated Products
>  mediatek	MediaTek Inc.
> +melexis	Melexis N.V.
>  merrii	Merrii Technology Co., Ltd.
>  micrel	Micrel Inc.
>  microchip	Microchip Technology Inc.
> 

