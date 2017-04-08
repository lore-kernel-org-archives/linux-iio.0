Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37962 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751428AbdDHQCz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 8 Apr 2017 12:02:55 -0400
Subject: Re: [PATCH v5 4/4] arm64: dts: salvator-x: Add current sense
 amplifiers
To: Jacopo Mondi <jacopo+renesas@jmondi.org>, geert@linux-m68k.org,
        wsa+renesas@sang-engineering.com, magnus.damm@gmail.com,
        laurent.pinchart@ideasonboard.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        mark.rutland@arm.com
References: <1491488454-22468-1-git-send-email-jacopo+renesas@jmondi.org>
 <1491488454-22468-5-git-send-email-jacopo+renesas@jmondi.org>
Cc: linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <8cc2a7a4-57be-15d7-2190-eb3d3cad3972@kernel.org>
Date: Sat, 8 Apr 2017 17:02:53 +0100
MIME-Version: 1.0
In-Reply-To: <1491488454-22468-5-git-send-email-jacopo+renesas@jmondi.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/04/17 15:20, Jacopo Mondi wrote:
> Add device nodes for two Maxim max961x current sense amplifiers
> sensing VDD_08 and DVFS_08 lines.
> 
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Driver now applied and should make the coming merge window easily,
so I'll assume this will head upstream via an appropriate tree.

Thanks,

Jonathan
> ---
>  arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
> index c7f40f8..c4860a1 100644
> --- a/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
> +++ b/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
> @@ -257,6 +257,24 @@
>  	status = "okay";
>  };
>  
> +&i2c4 {
> +	status = "okay";
> +
> +	csa_vdd: adc@7c {
> +		compatible = "maxim,max9611";
> +		reg = <0x7c>;
> +
> +		shunt-resistor-micro-ohms = <5000>;
> +	};
> +
> +	csa_dvfs: adc@7f {
> +		compatible = "maxim,max9611";
> +		reg = <0x7f>;
> +
> +		shunt-resistor-micro-ohms = <5000>;
> +	};
> +};
> +
>  &wdt0 {
>  	timeout-sec = <60>;
>  	status = "okay";
> 

