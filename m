Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:34094 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754741Ab3GQOd5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 17 Jul 2013 10:33:57 -0400
Received: by mail-lb0-f178.google.com with SMTP id y6so1600495lbh.37
        for <linux-iio@vger.kernel.org>; Wed, 17 Jul 2013 07:33:56 -0700 (PDT)
Message-ID: <51E6AB54.103@cogentembedded.com>
Date: Wed, 17 Jul 2013 18:33:56 +0400
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
Subject: Re: [PATCH v5 1/2] ARM: dts: twl: Add GPADC data to device tree
References: <1374059564-6872-1-git-send-email-oleksandr.kozaruk@ti.com> <1374059564-6872-2-git-send-email-oleksandr.kozaruk@ti.com>
In-Reply-To: <1374059564-6872-2-git-send-email-oleksandr.kozaruk@ti.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello.

On 17-07-2013 15:12, Oleksandr Kozaruk wrote:

> GPADC is the general purpose ADC present on twl6030.
> The dt data is interrupt used to trigger end of ADC
> conversion.

> Signed-off-by: Oleksandr Kozaruk <oleksandr.kozaruk@ti.com>
> ---
>   arch/arm/boot/dts/twl6030.dtsi | 6 ++++++
>   1 file changed, 6 insertions(+)

> diff --git a/arch/arm/boot/dts/twl6030.dtsi b/arch/arm/boot/dts/twl6030.dtsi
> index 2e3bd31..322aa8e 100644
> --- a/arch/arm/boot/dts/twl6030.dtsi
> +++ b/arch/arm/boot/dts/twl6030.dtsi
> @@ -103,4 +103,10 @@
>   		compatible = "ti,twl6030-pwmled";
>   		#pwm-cells = <2>;
>   	};
> +
> +	adc: twl6030_gpadc {

    I was talking about the device name, not label. The "twl6030_gpadc" part.

WBR, Sergei

