Return-Path: <robherring2@gmail.com>
Date: Mon, 10 Oct 2016 09:50:46 -0500
From: Rob Herring <robh@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	devicetree <devicetree@vger.kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] dt: bindings: vendor-prefix: Add 3 accelerometer
 vendor prefixes
Message-ID: <20161010145046.GA25572@rob-hp-laptop>
References: <20161006170650.13518-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161006170650.13518-1-hdegoede@redhat.com>
List-ID: <linux-iio@vger.kernel.org>

On Thu, Oct 06, 2016 at 07:06:50PM +0200, Hans de Goede wrote:
> Recently the kernel has gotten support in the iio subsystem for a number
> of new accelerometers from mCube, Memsic and MiraMEMS.
> 
> This commit adds the vendor prefixes already used for these vendors
> in Documentation/devicetree/bindings/i2c/trivial-devices.txt to
> vendor-prefixes.txt.
> 
> The "full" company names were taken from the company's websites:
> http://www.mcubemems.com/
> http://www.memsic.com/
> http://www.miramems.com/en/
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -Drop domintech, it is already in the iio/next tree
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 5c67e91..abe0129 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -157,13 +157,16 @@ lltc	Linear Technology Corporation
>  marvell	Marvell Technology Group Ltd.
>  maxim	Maxim Integrated Products
>  meas	Measurement Specialties
> +mcube	mCube

Not in alphabetical order.

>  mediatek	MediaTek Inc.
>  melexis	Melexis N.V.
> +memsic	MEMSIC Inc.
>  merrii	Merrii Technology Co., Ltd.
>  micrel	Micrel Inc.
>  microchip	Microchip Technology Inc.
>  micron	Micron Technology Inc.
>  minix	MINIX Technology Ltd.
> +miramems	MiraMEMS Sensing Technology Co., Ltd.
>  mitsubishi	Mitsubishi Electric Corporation
>  mosaixtech	Mosaix Technologies, Inc.
>  moxa	Moxa
> -- 
> 2.9.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
