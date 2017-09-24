Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752437AbdIXPpS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 24 Sep 2017 11:45:18 -0400
Date: Sun, 24 Sep 2017 16:45:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Zhiyong Tao <zhiyong.tao@mediatek.com>
Cc: <robh+dt@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <srv_heupstream@mediatek.com>,
        <liguo.zhang@mediatek.com>, <yingjoe.chen@mediatek.com>,
        <sean.wang@mediatek.com>, <yt.shen@mediatek.com>,
        <matthias.bgg@gmail.com>, <s.hauer@pengutronix.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH 1/3] dt-bindings: adc: mt2712: add binding document
Message-ID: <20170924164512.5e06cb8f@archlinux>
In-Reply-To: <1505957212-13402-2-git-send-email-zhiyong.tao@mediatek.com>
References: <1505957212-13402-1-git-send-email-zhiyong.tao@mediatek.com>
        <1505957212-13402-2-git-send-email-zhiyong.tao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 21 Sep 2017 09:26:50 +0800
Zhiyong Tao <zhiyong.tao@mediatek.com> wrote:

> The commit adds mt2712 compatible node in binding document.
> 
> Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>

Given just how trivial this is, I'm not going to waste Rob or Marks
time by waiting for them to look at it.  I did tweak the patch
title to '... binding documentation' to reflect the fact this
isn't a new file which 'binding document' sort of implied.

Applied to the togreg branch of iio.git and pushed out as
testing for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  .../devicetree/bindings/iio/adc/mt6577_auxadc.txt  |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/mt6577_auxadc.txt b/Documentation/devicetree/bindings/iio/adc/mt6577_auxadc.txt
> index 64dc484..0df9bef 100644
> --- a/Documentation/devicetree/bindings/iio/adc/mt6577_auxadc.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/mt6577_auxadc.txt
> @@ -12,6 +12,7 @@ for the Thermal Controller which holds a phandle to the AUXADC.
>  Required properties:
>    - compatible: Should be one of:
>      - "mediatek,mt2701-auxadc": For MT2701 family of SoCs
> +    - "mediatek,mt2712-auxadc": For MT2712 family of SoCs
>      - "mediatek,mt7622-auxadc": For MT7622 family of SoCs
>      - "mediatek,mt8173-auxadc": For MT8173 family of SoCs
>    - reg: Address range of the AUXADC unit.

