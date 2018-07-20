Return-Path: <SRS0=Xsfc=KE=gmail.com=robherring2@kernel.org>
Date: Fri, 20 Jul 2018 08:46:34 -0600
From: Rob Herring <robh@kernel.org>
To: Stefan Popa <stefan.popa@analog.com>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	mark.rutland@arm.com, Michael.Hennerich@analog.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] iio:adxl372: Add FIFO and interrupts support
Message-ID: <20180720144634.GB25713@rob-hp-laptop>
References: <1531409760-20070-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1531409760-20070-1-git-send-email-stefan.popa@analog.com>
List-ID: <linux-iio@vger.kernel.org>

On Thu, Jul 12, 2018 at 06:36:00PM +0300, Stefan Popa wrote:
> This patch adds support for the adxl372 FIFO. In order to accomplish this,
> triggered buffers were used.
> 
> The number of FIFO samples which trigger the watermark interrupt can be
> configured by using the buffer watermark, while the format depends on the
> selected channels.The FIFO data along with the timestamp is pushed to the
> IIO device's buffer.
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> ---
>  .../devicetree/bindings/iio/accel/adxl372.txt      |   7 +

This belongs in patch 2. Bindings should reflect the h/w, not driver 
features.

>  drivers/iio/accel/adxl372.c                        | 346 ++++++++++++++++++++-
>  2 files changed, 352 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/adxl372.txt b/Documentation/devicetree/bindings/iio/accel/adxl372.txt
> index fea4baf..73d7e03 100644
> --- a/Documentation/devicetree/bindings/iio/accel/adxl372.txt
> +++ b/Documentation/devicetree/bindings/iio/accel/adxl372.txt
> @@ -7,10 +7,17 @@ Required properties:
>   - reg: SPI chip select number for the device
>   - spi-max-frequency: Max SPI frequency to use
>  
> +Optional properties:
> + - interrupt-parent: phandle to the parent interrupt controller

Don't need to put this in the binding. 

> + - interrupts: interrupt mapping for GPIO IRQ, it should by configured with
> + 		flag IRQ_TYPE_EDGE_FALLING
> +
>  Example:
>  
>  	accelerometer@0 {
>  		compatible = "adi,adxl372";
>  		reg = <0>;
>  		spi-max-frequency = <1000000>;
> +		interrupt-parent = <&gpio>;
> +		interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
>  	};
