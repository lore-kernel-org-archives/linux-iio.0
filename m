Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43111 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751068AbcF3TXg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 30 Jun 2016 15:23:36 -0400
Subject: Re: [PATCH 01/10 v4] iio: pressure: bmp280: augment DT bindings
To: Linus Walleij <linus.walleij@linaro.org>,
	linux-iio@vger.kernel.org, Akinobu Mita <akinobu.mita@gmail.com>,
	"H. Nikolaus Schaller" <hns@goldelico.com>,
	Matt Ranostay <mranostay@gmail.com>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <1467251334-30594-1-git-send-email-linus.walleij@linaro.org>
 <1467251334-30594-2-git-send-email-linus.walleij@linaro.org>
Cc: Christoph Mair <christoph.mair@gmail.com>,
	Vlad Dogaru <vlad.dogaru@intel.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Marek Belisko <marek@goldelico.com>,
	Eric Andersson <eric.andersson@unixphere.com>,
	Neil Brown <neilb@suse.de>, devicetree@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <0bd26779-4ac3-faa2-68e3-52fab273721a@kernel.org>
Date: Thu, 30 Jun 2016 20:23:26 +0100
MIME-Version: 1.0
In-Reply-To: <1467251334-30594-2-git-send-email-linus.walleij@linaro.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 30/06/16 02:48, Linus Walleij wrote:
> This adds standard device tree bindings for a reset GPIO line, and
> the VDDD and VDDA power regulators.
> 
> Cc: devicetree@vger.kernel.org
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Applied to the togreg branch of iio.git - initially pushed out as
testing.

Thanks,

Jonathan
> ---
> ChangeLog v3->v4:
> - Just resending. If the old patch (in the tree) is good enough, just
>   drop this.
> ChangeLog v2->v3:
> - None, just resending in case Jonathan prefers this binding doc
> ChangeLog v1->v2:
> - Order compatible string on single lines
> - Add "bosch,bme280" for the new sensor from Matt
> ---
>  Documentation/devicetree/bindings/iio/pressure/bmp085.txt | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/pressure/bmp085.txt b/Documentation/devicetree/bindings/iio/pressure/bmp085.txt
> index d7a6deb6b21e..c7198a03c906 100644
> --- a/Documentation/devicetree/bindings/iio/pressure/bmp085.txt
> +++ b/Documentation/devicetree/bindings/iio/pressure/bmp085.txt
> @@ -1,7 +1,11 @@
> -BMP085/BMP18x digital pressure sensors
> +BMP085/BMP18x/BMP28x digital pressure sensors
>  
>  Required properties:
> -- compatible: bosch,bmp085
> +- compatible: must be one of:
> +  "bosch,bmp085"
> +  "bosch,bmp180"
> +  "bosch,bmp280"
> +  "bosch,bme280"
>  
>  Optional properties:
>  - chip-id: configurable chip id for non-default chip revisions
> @@ -10,6 +14,10 @@ Optional properties:
>    value range is 0-3 with rising sensitivity.
>  - interrupt-parent: should be the phandle for the interrupt controller
>  - interrupts: interrupt mapping for IRQ
> +- reset-gpios: a GPIO line handling reset of the sensor: as the line is
> +  active low, it should be marked GPIO_ACTIVE_LOW (see gpio/gpio.txt)
> +- vddd-supply: digital voltage regulator (see regulator/regulator.txt)
> +- vdda-supply: analog voltage regulator (see regulator/regulator.txt)
>  
>  Example:
>  
> @@ -21,4 +29,7 @@ pressure@77 {
>  	default-oversampling = <2>;
>  	interrupt-parent = <&gpio0>;
>  	interrupts = <25 IRQ_TYPE_EDGE_RISING>;
> +	reset-gpios = <&gpio0 26 GPIO_ACTIVE_LOW>;
> +	vddd-supply = <&foo>;
> +	vdda-supply = <&bar>;
>  };
> 

