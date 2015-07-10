Return-Path: <shawnguo@kernel.org>
Date: Fri, 10 Jul 2015 16:53:24 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Sanchayan Maity <maitysanchayan@gmail.com>
Cc: jic23@kernel.org, shawn.guo@linaro.org, kernel@pengutronix.de,
	robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	B38611@freescale.com, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, stefan@agner.ch
Subject: Re: [PATCH v2 2/2] ARM: dts: vfxxx: Add property for minimum sample
 time
Message-ID: <20150710085324.GL23464@tiger>
References: <cover.1435134626.git.maitysanchayan@gmail.com>
 <36fa3cef10b6a21b39e96283ea5d6961e9f6d972.1435134626.git.maitysanchayan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <36fa3cef10b6a21b39e96283ea5d6961e9f6d972.1435134626.git.maitysanchayan@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

On Wed, Jun 24, 2015 at 02:03:41PM +0530, Sanchayan Maity wrote:
> Add a device tree property which allows to specify the minimum sample
> time which can be used to calculate the actual ADC cycles required
> depending on the hardware.
> 
> Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
> ---
>  arch/arm/boot/dts/vfxxx.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
> index 90a03d5..71d9c08 100644
> --- a/arch/arm/boot/dts/vfxxx.dtsi
> +++ b/arch/arm/boot/dts/vfxxx.dtsi
> @@ -229,6 +229,7 @@
>  				status = "disabled";
>  				fsl,adck-max-frequency = <30000000>, <40000000>,
>  							<20000000>;
> +				min-sample-time = <1000>;
>  			};
>  
>  			wdoga5: wdog@4003e000 {
> @@ -447,6 +448,7 @@
>  				status = "disabled";
>  				fsl,adck-max-frequency = <30000000>, <40000000>,
>  							<20000000>;
> +				min-sample-time = <1000>;

Can we code 1000 as the default in kernel driver, so that only boards
requiring different value need to have this property?  Doing so makes
the property optional rather than required.

Shawn

>  			};
>  
>  			esdhc1: esdhc@400b2000 {
> -- 
> 2.4.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
