Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48263 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752264Ab3AVMGp (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 22 Jan 2013 07:06:45 -0500
Message-ID: <50FE80D3.1020104@kernel.org>
Date: Tue, 22 Jan 2013 12:06:43 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Marek Vasut <marex@denx.de>
CC: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Fabio Estevam <fabio.estevam@freescale.com>,
	Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 2/2] ARM: mxs: Add OF props for MX23 LRADC
References: <1358798722-25102-1-git-send-email-marex@denx.de> <1358798722-25102-2-git-send-email-marex@denx.de>
In-Reply-To: <1358798722-25102-2-git-send-email-marex@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/21/2013 08:05 PM, Marek Vasut wrote:
> Add interrupt mapping and compatible string for MX23 LRADC.

Series looks fine to me, but obviously I'd like an ACK for this one
from Shawn before taking it.

Thanks,

Jonathan

> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Fabio Estevam <fabio.estevam@freescale.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> ---
>  arch/arm/boot/dts/imx23.dtsi |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
> index 65415c5..56afcf4 100644
> --- a/arch/arm/boot/dts/imx23.dtsi
> +++ b/arch/arm/boot/dts/imx23.dtsi
> @@ -391,7 +391,9 @@
>  			};
>  
>  			lradc@80050000 {
> +				compatible = "fsl,imx23-lradc";
>  				reg = <0x80050000 0x2000>;
> +				interrupts = <36 37 38 39 40 41 42 43 44>;
>  				status = "disabled";
>  			};
>  
> 
