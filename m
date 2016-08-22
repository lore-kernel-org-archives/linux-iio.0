Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([218.249.47.110]:37598 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754321AbcHVGWV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Aug 2016 02:22:21 -0400
Message-ID: <1471846928.16635.3.camel@mhfsdcap03>
Subject: Re: [PATCH v7 3/3] arm: dts: mt2701: Add auxadc node.
From: zhiyong tao <zhiyong.tao@mediatek.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: <robh+dt@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <srv_heupstream@mediatek.com>,
        <liguo.zhang@mediatek.com>, <yingjoe.chen@mediatek.com>,
        <eddie.huang@mediatek.com>, <erin.lo@mediatek.com>,
        <dawei.chien@mediatek.com>, <matthias.bgg@gmail.com>,
        <s.hauer@pengutronix.de>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
Date: Mon, 22 Aug 2016 14:22:08 +0800
In-Reply-To: <c238236c-2445-7802-6f2e-2f4776778c36@kernel.org>
References: <1471504297-26947-1-git-send-email-zhiyong.tao@mediatek.com>
         <1471504297-26947-4-git-send-email-zhiyong.tao@mediatek.com>
         <c238236c-2445-7802-6f2e-2f4776778c36@kernel.org>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 2016-08-21 at 19:58 +0100, Jonathan Cameron wrote:
> On 18/08/16 08:11, Zhiyong Tao wrote:
> > The commit adds auxadc nodes to the Mediatek MT2701 dtsi file.
> > 
> > Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> > ---
> > This patch dependents on "Add clock support for Mediatek MT2701"[1].
> > Please accept this patch together with [1].
> > [1]http://lists.infradead.org/pipermail/linux-mediatek/2016-August/006620.html

Dear Jonathan,

This patch dependents on "Add clock support for Mediatek MT2701"[1]. 
We will refresh it again to Matthias when [1] is merged. 
[1]http://lists.infradead.org/pipermail/linux-mediatek/2016-August/006620.html

Thanks.

> Guessing this is working it's way ultimately through arm-soc.  Patches
> 1 and 2 are now heading through the iio / staging-iio route and should be
> merging in the next merge window if nothing odd happens.
> 
> Thanks,
> 
> Jonathan
> > ---
> >  arch/arm/boot/dts/mt2701.dtsi |    9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/mt2701.dtsi b/arch/arm/boot/dts/mt2701.dtsi
> > index 7eab6f4..8e6a18c 100644
> > --- a/arch/arm/boot/dts/mt2701.dtsi
> > +++ b/arch/arm/boot/dts/mt2701.dtsi
> > @@ -175,6 +175,15 @@
> >  		      <0 0x10216000 0 0x2000>;
> >  	};
> >  
> > +	auxadc: adc@11001000 {
> > +		compatible = "mediatek,mt2701-auxadc";
> > +		reg = <0 0x11001000 0 0x1000>;
> > +		clocks = <&pericfg CLK_PERI_AUXADC>;
> > +		clock-names = "main";
> > +		#io-channel-cells = <1>;
> > +		status = "disabled";
> > +	};
> > +
> >  	uart0: serial@11002000 {
> >  		compatible = "mediatek,mt2701-uart",
> >  			     "mediatek,mt6577-uart";
> > 
> 


