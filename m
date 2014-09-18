Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-bn1bon0142.outbound.protection.outlook.com ([157.56.111.142]:35232
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755873AbaIRPV7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 18 Sep 2014 11:21:59 -0400
Date: Thu, 18 Sep 2014 21:46:15 +0800
From: Shawn Guo <shawn.guo@freescale.com>
To: Sanchayan Maity <maitysanchayan@gmail.com>
CC: <stefan@agner.ch>, <B38611@freescale.com>,
	<linux@arm.linux.org.uk>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <jic23@kernel.org>,
	<linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/2] ARM: dts: vf610-colibri: Add ADC support
Message-ID: <20140918134613.GK4796@dragon>
References: <cover.1410873422.git.maitysanchayan@gmail.com>
 <1015e874d5b13795e38069402a66b4798d79b632.1410873422.git.maitysanchayan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1015e874d5b13795e38069402a66b4798d79b632.1410873422.git.maitysanchayan@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Sep 17, 2014 at 01:53:16PM +0530, Sanchayan Maity wrote:
> Enable ADC support for Colibri VF61 modules
> 
> Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
> ---
>  arch/arm/boot/dts/vf610-colibri.dtsi |   10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/vf610-colibri.dtsi b/arch/arm/boot/dts/vf610-colibri.dtsi
> index 0cd8343..275ebec 100644
> --- a/arch/arm/boot/dts/vf610-colibri.dtsi
> +++ b/arch/arm/boot/dts/vf610-colibri.dtsi
> @@ -69,6 +69,16 @@
>  	status = "okay";
>  };
>  
> +&adc0 {
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +
> +&adc1 {
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +

Please sort the nodes alphabetically in node name.

Shawn

>  &iomuxc {
>  	vf610-colibri {
>  		pinctrl_esdhc1: esdhc1grp {
> -- 
> 1.7.9.5
> 
