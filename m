Return-Path: <SRS0=AltI=EV=sholland.org=samuel@kernel.org>
Subject: Re: [linux-sunxi] [PATCH 13/16] arm: dts: sun8i: h3: add thermal zone
 to H3
To: embed3d@gmail.com, lee.jones@linaro.org, robh+dt@kernel.org,
 mark.rutland@arm.com, maxime.ripard@free-electrons.com, wens@csie.org,
 linux@armlinux.org.uk, jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
 pmeerw@pmeerw.net, davem@davemloft.net, hans.verkuil@cisco.com,
 mchehab@kernel.org, rask@formelder.dk, clabbe.montjoie@gmail.com,
 sean@mess.org, krzk@kernel.org, quentin.schulz@free-electrons.com,
 icenowy@aosc.io, edu.molinas@gmail.com, singhalsimran0@gmail.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-sunxi@googlegroups.com
References: <20180126151941.12183-1-embed3d@gmail.com>
 <20180126151941.12183-14-embed3d@gmail.com>
From: Samuel Holland <samuel@sholland.org>
Message-ID: <4cfb1faf-a712-c882-1ef1-55845c1bb00e@sholland.org>
Date: Fri, 26 Jan 2018 10:26:19 -0600
MIME-Version: 1.0
In-Reply-To: <20180126151941.12183-14-embed3d@gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

On 01/26/18 09:19, Philipp Rossak wrote:
> This patch adds the thermal zones to the H3. We have only one sensor and
> that is placed in the cpu.
> 
> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
> ---
>  arch/arm/boot/dts/sun8i-h3.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
> index fbb007e5798e..3f83f6a27c74 100644
> --- a/arch/arm/boot/dts/sun8i-h3.dtsi
> +++ b/arch/arm/boot/dts/sun8i-h3.dtsi
> @@ -72,6 +72,15 @@
>  		};
>  	};
>  
> +	thermal-zones {
> +		cpu-thermal {
> +			/* milliseconds */
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +			thermal-sensors = <&ths 0>;

If #thermal-sensor-cells = <0>, shouldn't this just be <&ths> ?

> +		};
> +	};
> +
>  	timer {
>  		compatible = "arm,armv7-timer";
>  		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> 

Thanks,
Samuel
