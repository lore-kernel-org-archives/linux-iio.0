Return-Path: <sergei.shtylyov@cogentembedded.com>
Message-ID: <51E94F97.40002@cogentembedded.com>
Date: Fri, 19 Jul 2013 18:39:19 +0400
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
To: Oleksandr Kozaruk <oleksandr.kozaruk@ti.com>
CC: tony@atomide.com, benoit.cousson@linaro.org, rnayak@ti.com,
 peter.ujfalusi@ti.com, kishon@ti.com, jic23@cam.ac.uk,
 grant.likely@linaro.org, rob.herring@calxeda.com, lars@metafoo.de,
 sameo@linux.intel.com, ch.naveen@samsung.com, poeschel@lemonage.de,
 milo.kim@ti.com, balajitk@ti.com, gg@slimlogic.co.uk,
 linux-iio@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
 linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 1/2] ARM: dts: twl: Add GPADC data to device tree
References: <1374226039-16943-1-git-send-email-oleksandr.kozaruk@ti.com> <1374226039-16943-2-git-send-email-oleksandr.kozaruk@ti.com>
In-Reply-To: <1374226039-16943-2-git-send-email-oleksandr.kozaruk@ti.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-iio@vger.kernel.org>

Hello.

On 19-07-2013 13:27, Oleksandr Kozaruk wrote:

> GPADC is the general purpose ADC present on twl6030.
> The dt data is interrupt used to trigger end of ADC
> conversion.

> Signed-off-by: Oleksandr Kozaruk <oleksandr.kozaruk@ti.com>
> ---
>   arch/arm/boot/dts/twl6030.dtsi | 6 ++++++
>   1 file changed, 6 insertions(+)

> diff --git a/arch/arm/boot/dts/twl6030.dtsi b/arch/arm/boot/dts/twl6030.dtsi
> index 2e3bd31..d7d4c28 100644
> --- a/arch/arm/boot/dts/twl6030.dtsi
> +++ b/arch/arm/boot/dts/twl6030.dtsi
> @@ -103,4 +103,10 @@
>   		compatible = "ti,twl6030-pwmled";
>   		#pwm-cells = <2>;
>   	};
> +
> +	adc: gpadc {

    Read my lips: the node should be called just "adc", not "gpadc".

WBR, Sergei
