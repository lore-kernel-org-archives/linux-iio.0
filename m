Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbeGOJVa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Jul 2018 05:21:30 -0400
Date: Sun, 15 Jul 2018 09:59:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Cc: robh+dt@kernel.org, mark.rutland@arm.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: pressure: bmp280: remove unused options from
 device tree documentation
Message-ID: <20180715095912.03628b43@archlinux>
In-Reply-To: <20180711013345.22951-1-masneyb@onstation.org>
References: <20180711013345.22951-1-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 10 Jul 2018 21:33:45 -0400
Brian Masney <masneyb@onstation.org> wrote:

> There are several options in the device tree documentation that are
> no longer relevant for the current in-kernel bmp280 driver so this patch
> removes them.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Fair enough I guess - though this may confuse anyone looking at
new docs and running an old kernel with the misc driver still there.

Applied to the togreg branch of iio.git
> ---
>  Documentation/devicetree/bindings/iio/pressure/bmp085.txt | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/pressure/bmp085.txt b/Documentation/devicetree/bindings/iio/pressure/bmp085.txt
> index c7198a03c906..abcab02504fb 100644
> --- a/Documentation/devicetree/bindings/iio/pressure/bmp085.txt
> +++ b/Documentation/devicetree/bindings/iio/pressure/bmp085.txt
> @@ -8,10 +8,6 @@ Required properties:
>    "bosch,bme280"
>  
>  Optional properties:
> -- chip-id: configurable chip id for non-default chip revisions
> -- temp-measurement-period: temperature measurement period (milliseconds)
> -- default-oversampling: default oversampling value to be used at startup,
> -  value range is 0-3 with rising sensitivity.
>  - interrupt-parent: should be the phandle for the interrupt controller
>  - interrupts: interrupt mapping for IRQ
>  - reset-gpios: a GPIO line handling reset of the sensor: as the line is
> @@ -24,9 +20,6 @@ Example:
>  pressure@77 {
>  	compatible = "bosch,bmp085";
>  	reg = <0x77>;
> -	chip-id = <10>;
> -	temp-measurement-period = <100>;
> -	default-oversampling = <2>;
>  	interrupt-parent = <&gpio0>;
>  	interrupts = <25 IRQ_TYPE_EDGE_RISING>;
>  	reset-gpios = <&gpio0 26 GPIO_ACTIVE_LOW>;

