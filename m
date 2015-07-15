Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:47335 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751904AbbGOB5y (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 14 Jul 2015 21:57:54 -0400
Date: Wed, 15 Jul 2015 09:57:26 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Sanchayan Maity <maitysanchayan@gmail.com>
Cc: jic23@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org,
	B38611@freescale.com, pawel.moll@arm.com,
	ijc+devicetree@hellion.org.uk, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, stefan@agner.ch, robh+dt@kernel.org,
	kernel@pengutronix.de, galak@codeaurora.org, shawn.guo@linaro.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/2] ARM: dts: vf-colibri: Add property for minimum
 sample time
Message-ID: <20150715015725.GK4119@tiger>
References: <cover.1436880513.git.maitysanchayan@gmail.com>
 <20e2cfad3fbb1a45332e9936ea493ddc8bfaf51d.1436880513.git.maitysanchayan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20e2cfad3fbb1a45332e9936ea493ddc8bfaf51d.1436880513.git.maitysanchayan@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Jul 14, 2015 at 07:23:23PM +0530, Sanchayan Maity wrote:
> Add a device tree property which allows to specify the minimum sample
> time which can be used to calculate the actual ADC cycles required
> depending on the hardware.
> 
> Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
> ---
>  arch/arm/boot/dts/vf-colibri.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/vf-colibri.dtsi b/arch/arm/boot/dts/vf-colibri.dtsi
> index ab10d2e..59f5deb 100644
> --- a/arch/arm/boot/dts/vf-colibri.dtsi
> +++ b/arch/arm/boot/dts/vf-colibri.dtsi
> @@ -16,10 +16,12 @@
>  };
>  
>  &adc0 {
> +	min-sample-time = <1000>;
>  	status = "okay";
>  };
>  
>  &adc1 {
> +	min-sample-time = <1000>;

Since this is the default value anyway, we can just save the patch,
right?

Shawn

>  	status = "okay";
>  };
>  
> -- 
> 2.4.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
