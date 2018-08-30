Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from vps.xff.cz ([195.181.215.36]:35644 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727117AbeH3Ule (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 30 Aug 2018 16:41:34 -0400
Date: Thu, 30 Aug 2018 18:38:33 +0200
From: =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To: Philipp Rossak <embed3d@gmail.com>
Cc: lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, linux@armlinux.org.uk,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, eugen.hristev@microchip.com,
        rdunlap@infradead.org, vilhelm.gray@gmail.com,
        clabbe.montjoie@gmail.com, quentin.schulz@bootlin.com,
        geert+renesas@glider.be, lukas@wunner.de, icenowy@aosc.io,
        arnd@arndb.de, broonie@kernel.org, arnaud.pouliquen@st.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [linux-sunxi] [PATCH v3 30/30] ARM: sun8i: a83t: full range OPP
 tables and CPUfreq
Message-ID: <20180830163833.v7zvmaz2vsxvzhur@core>
References: <20180830154518.29507-1-embed3d@gmail.com>
 <20180830154518.29507-31-embed3d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180830154518.29507-31-embed3d@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello,

On Thu, Aug 30, 2018 at 05:45:18PM +0200, Philipp Rossak wrote:
> Since we have now thermal trotteling enabeled we can now add the full
> range of the OPP table.

I'm not sure we can. I have a tablet with A83T SoC and it gets unstable
at these frequencies even with thermal throttling on mainline kernel. (Though
I have my own THS driver, but I doubt a different driver will change much.)

There might be some other issue left in the cpufreq code. I'll let others
test this on a better cooled boards though.

Did you/someone test this?

regards,
  o.

> The operating points were found in Allwinner BSP and fex files.
> 
> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
> ---
>  arch/arm/boot/dts/sun8i-a83t.dtsi | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
> index 78aa448e869f..ddcf404f9c80 100644
> --- a/arch/arm/boot/dts/sun8i-a83t.dtsi
> +++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
> @@ -250,6 +250,22 @@
>  			opp-microvolt = <840000>;
>  			clock-latency-ns = <244144>; /* 8 32k periods */
>  		};
> +
> +		opp-1608000000 {
> +			opp-hz = /bits/ 64 <1608000000>;
> +			opp-microvolt = <920000>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +		};
> +		opp-1800000000 { /* BOOT FREQ */
> +			opp-hz = /bits/ 64 <1800000000>;
> +			opp-microvolt = <1000000>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +		};
> +		opp-2016000000 {
> +			opp-hz = /bits/ 64 <2016000000>;
> +			opp-microvolt = <1080000>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +		};
>  	};
>  
>  	cpu1_opp_table: opp_table1 {
> @@ -303,6 +319,22 @@
>  			opp-microvolt = <840000>;
>  			clock-latency-ns = <244144>; /* 8 32k periods */
>  		};
> +
> +		opp-1608000000 {
> +			opp-hz = /bits/ 64 <1608000000>;
> +			opp-microvolt = <920000>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +		};
> +		opp-1800000000 { /* BOOT FREQ */
> +			opp-hz = /bits/ 64 <1800000000>;
> +			opp-microvolt = <1000000>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +		};
> +		opp-2016000000 {
> +			opp-hz = /bits/ 64 <2016000000>;
> +			opp-microvolt = <1080000>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +		};
>  	};
>  
>  	soc {
> -- 
> 2.11.0
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
