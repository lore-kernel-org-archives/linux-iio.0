Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53048 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752017AbcHUS6n (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 21 Aug 2016 14:58:43 -0400
Subject: Re: [PATCH v7 3/3] arm: dts: mt2701: Add auxadc node.
To: Zhiyong Tao <zhiyong.tao@mediatek.com>, robh+dt@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net
References: <1471504297-26947-1-git-send-email-zhiyong.tao@mediatek.com>
 <1471504297-26947-4-git-send-email-zhiyong.tao@mediatek.com>
Cc: srv_heupstream@mediatek.com, liguo.zhang@mediatek.com,
        yingjoe.chen@mediatek.com, eddie.huang@mediatek.com,
        erin.lo@mediatek.com, dawei.chien@mediatek.com,
        matthias.bgg@gmail.com, s.hauer@pengutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-mediatek@lists.infradead.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <c238236c-2445-7802-6f2e-2f4776778c36@kernel.org>
Date: Sun, 21 Aug 2016 19:58:40 +0100
MIME-Version: 1.0
In-Reply-To: <1471504297-26947-4-git-send-email-zhiyong.tao@mediatek.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18/08/16 08:11, Zhiyong Tao wrote:
> The commit adds auxadc nodes to the Mediatek MT2701 dtsi file.
> 
> Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> ---
> This patch dependents on "Add clock support for Mediatek MT2701"[1].
> Please accept this patch together with [1].
> [1]http://lists.infradead.org/pipermail/linux-mediatek/2016-August/006620.html
Guessing this is working it's way ultimately through arm-soc.  Patches
1 and 2 are now heading through the iio / staging-iio route and should be
merging in the next merge window if nothing odd happens.

Thanks,

Jonathan
> ---
>  arch/arm/boot/dts/mt2701.dtsi |    9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/mt2701.dtsi b/arch/arm/boot/dts/mt2701.dtsi
> index 7eab6f4..8e6a18c 100644
> --- a/arch/arm/boot/dts/mt2701.dtsi
> +++ b/arch/arm/boot/dts/mt2701.dtsi
> @@ -175,6 +175,15 @@
>  		      <0 0x10216000 0 0x2000>;
>  	};
>  
> +	auxadc: adc@11001000 {
> +		compatible = "mediatek,mt2701-auxadc";
> +		reg = <0 0x11001000 0 0x1000>;
> +		clocks = <&pericfg CLK_PERI_AUXADC>;
> +		clock-names = "main";
> +		#io-channel-cells = <1>;
> +		status = "disabled";
> +	};
> +
>  	uart0: serial@11002000 {
>  		compatible = "mediatek,mt2701-uart",
>  			     "mediatek,mt6577-uart";
> 

