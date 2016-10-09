Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39310 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753050AbcJIIe7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 9 Oct 2016 04:34:59 -0400
Subject: Re: [PATCH v3 3/4] ARM: dts: am33xx: add DMA properties for tscadc
To: Mugunthan V N <mugunthanvnm@ti.com>, linux-iio@vger.kernel.org
References: <20161005090443.24576-1-mugunthanvnm@ti.com>
 <20161005090443.24576-4-mugunthanvnm@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lee Jones <lee.jones@linaro.org>, Vignesh R <vigneshr@ti.com>,
        "Andrew F . Davis" <afd@ti.com>, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        John Syne <john3909@gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <b8272b0e-3051-445b-865e-968d2dac1a9f@kernel.org>
Date: Sun, 9 Oct 2016 09:34:52 +0100
MIME-Version: 1.0
In-Reply-To: <20161005090443.24576-4-mugunthanvnm@ti.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/10/16 10:04, Mugunthan V N wrote:
> Add DMA properties for tscadc
> 
> Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>
Do the binding docs need updating to reflect this?  I can't immediately
find the relevant doc to check!

Jonathan
> ---
>  arch/arm/boot/dts/am33xx.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index 98748c6..6d607b8 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -917,6 +917,8 @@
>  			interrupts = <16>;
>  			ti,hwmods = "adc_tsc";
>  			status = "disabled";
> +			dmas = <&edma 53 0>, <&edma 57 0>;
> +			dma-names = "fifo0", "fifo1";
>  
>  			tsc {
>  				compatible = "ti,am3359-tsc";
> 

