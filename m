Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751452AbdGAJVT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 Jul 2017 05:21:19 -0400
Date: Sat, 1 Jul 2017 10:21:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Zhiyong Tao <zhiyong.tao@mediatek.com>
Cc: <robh+dt@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <srv_heupstream@mediatek.com>,
        <liguo.zhang@mediatek.com>, <yingjoe.chen@mediatek.com>,
        <sean.wang@mediatek.com>, <matthias.bgg@gmail.com>,
        <s.hauer@pengutronix.de>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v2 3/3] iio: adc: mt7622: Add compatible node for
 mt7622.
Message-ID: <20170701102113.2f53742c@kernel.org>
In-Reply-To: <1498457502-3669-4-git-send-email-zhiyong.tao@mediatek.com>
References: <1498457502-3669-1-git-send-email-zhiyong.tao@mediatek.com>
        <1498457502-3669-4-git-send-email-zhiyong.tao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 26 Jun 2017 14:11:42 +0800
Zhiyong Tao <zhiyong.tao@mediatek.com> wrote:

> This commit adds mt7622 compatible node.
> 
> Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
Applied.

Thanks,

Jonathan
> ---
>  drivers/iio/adc/mt6577_auxadc.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/adc/mt6577_auxadc.c b/drivers/iio/adc/mt6577_auxadc.c
> index c174b73..4224fc0 100644
> --- a/drivers/iio/adc/mt6577_auxadc.c
> +++ b/drivers/iio/adc/mt6577_auxadc.c
> @@ -308,6 +308,7 @@ static SIMPLE_DEV_PM_OPS(mt6577_auxadc_pm_ops,
>  
>  static const struct of_device_id mt6577_auxadc_of_match[] = {
>  	{ .compatible = "mediatek,mt2701-auxadc", },
> +	{ .compatible = "mediatek,mt7622-auxadc", },
>  	{ .compatible = "mediatek,mt8173-auxadc", },
>  	{ }
>  };

