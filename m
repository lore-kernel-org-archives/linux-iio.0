Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([218.249.47.110]:59054 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751521AbdFZBzr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 25 Jun 2017 21:55:47 -0400
Message-ID: <1498442139.536.4.camel@mhfsdcap03>
Subject: Re: [PATCH 3/3] iio: adc: mt7622: Add compatible node for mt7622.
From: zhiyong tao <zhiyong.tao@mediatek.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: <robh+dt@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <srv_heupstream@mediatek.com>,
        <liguo.zhang@mediatek.com>, <yingjoe.chen@mediatek.com>,
        <sean.wang@mediatek.com>, <matthias.bgg@gmail.com>,
        <s.hauer@pengutronix.de>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
Date: Mon, 26 Jun 2017 09:55:39 +0800
In-Reply-To: <20170624210213.5e552e5c@kernel.org>
References: <1498110274-18678-1-git-send-email-zhiyong.tao@mediatek.com>
         <1498110274-18678-4-git-send-email-zhiyong.tao@mediatek.com>
         <20170624210213.5e552e5c@kernel.org>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 2017-06-24 at 21:02 +0100, Jonathan Cameron wrote:
> On Thu, 22 Jun 2017 13:44:34 +0800
> Zhiyong Tao <zhiyong.tao@mediatek.com> wrote:
> 
> > This commit adds mt7622 compatible node.
> > 
> > Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> > ---
> >  drivers/iio/adc/mt6577_auxadc.c |    1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/iio/adc/mt6577_auxadc.c b/drivers/iio/adc/mt6577_auxadc.c
> > index 2dd7c74..4a2cd9e 100644
> > --- a/drivers/iio/adc/mt6577_auxadc.c
> > +++ b/drivers/iio/adc/mt6577_auxadc.c
> > @@ -308,6 +308,7 @@ static int mt6577_auxadc_remove(struct platform_device *pdev)
> >  static const struct of_device_id mt6577_auxadc_of_match[] = {
> >  	{ .compatible = "mediatek,mt2701-auxadc", },
> >  	{ .compatible = "mediatek,mt8173-auxadc", },
> > +	{ .compatible = "mediatek,mt7622-auxadc", },
> Keep them in numeric order perhaps?
> 
> Might become a worthwhile step if this logic gets used for lot more parts in future!
> 
> Jonathan

==>Ok, we will change them in numeric order perhaps in v2.
Thanks.

> >  	{ }
> >  };
> >  MODULE_DEVICE_TABLE(of, mt6577_auxadc_of_match);
> 


