Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:32973 "EHLO
	mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751687AbcGPTb1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 16 Jul 2016 15:31:27 -0400
Date: Sat, 16 Jul 2016 14:31:25 -0500
From: Rob Herring <robh@kernel.org>
To: zhiyong tao <zhiyong.tao@mediatek.com>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, srv_heupstream@mediatek.com,
	liguo.zhang@mediatek.com, yingjoe.chen@mediatek.com,
	eddie.huang@mediatek.com, erin.lo@mediatek.com,
	dawei.chien@mediatek.com, matthias.bgg@gmail.com,
	s.hauer@pengutronix.de, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v4 1/3] dt-bindings: auxadc: Add binding document for
 Mediatek auxadc.
Message-ID: <20160716193125.GA14506@rob-hp-laptop>
References: <1468219197-9572-1-git-send-email-zhiyong.tao@mediatek.com>
 <1468219197-9572-2-git-send-email-zhiyong.tao@mediatek.com>
 <1468291396.419.15.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1468291396.419.15.camel@mhfsdcap03>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Jul 12, 2016 at 10:43:16AM +0800, zhiyong tao wrote:
> On Mon, 2016-07-11 at 14:39 +0800, Zhiyong Tao wrote:
> > The commit adds the device tree binding documentation for the mediatek
> > auxadc found on Mediatek MT2701.
> > Thermal gets auxadc sample data by iio device.
> > So the commit changes auxadc device tree binding documentation from
> > /soc/mediatek/auxadc.txt to /iio/adc/mt6577_auxadc.txt.
> > 
> > Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> > ---
> 
> I forgot that I should use the command 'git format-patch -M' to submit
> this patch. The follow information is the patch after executing the
> above command. If the patch needs to be resent, please help to notify
> me. I will resend the patch quickly.
> The follow information:
> 
>  .../auxadc.txt => iio/adc/mt6577_auxadc.txt}       |   16
> +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>  rename Documentation/devicetree/bindings/{soc/mediatek/auxadc.txt =>
> iio/adc/mt6577_auxadc.txt} (50%)
> 
> diff --git a/Documentation/devicetree/bindings/soc/mediatek/auxadc.txt
> b/Documentation/devicetree/bindings/iio/adc/mt6577_auxadc.txt
> similarity index 50%
> rename from Documentation/devicetree/bindings/soc/mediatek/auxadc.txt
> rename to Documentation/devicetree/bindings/iio/adc/mt6577_auxadc.txt
> index bdb7829..bc23792 100644
> --- a/Documentation/devicetree/bindings/soc/mediatek/auxadc.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/mt6577_auxadc.txt
> @@ -1,4 +1,4 @@
> -MediaTek AUXADC
> +* Mediatek AUXADC - Analog to Digital Converter on Mediatek mobile soc
> (mt65xx/mt81xx/mt27xx)
>  ===============
> 
>  The Auxiliary Analog/Digital Converter (AUXADC) is an ADC found
> @@ -10,12 +10,18 @@
> Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
>  for the Thermal Controller which holds a phandle to the AUXADC.
> 
>  Required properties:
> -- compatible: Must be "mediatek,mt8173-auxadc"
> -- reg: Address range of the AUXADC unit
> +  - compatible: "mediatek,mt2701-auxadc" or "mediatek,mt8173-auxadc"

It's preferred to list one per line, but this is fine unless you resend.

Acked-by: Rob Herring <robh@kernel.org>
