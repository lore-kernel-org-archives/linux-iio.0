Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C591C388F9
	for <linux-iio@archiver.kernel.org>; Sat, 21 Nov 2020 16:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CEF322206
	for <linux-iio@archiver.kernel.org>; Sat, 21 Nov 2020 16:39:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgKUQj0 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 21 Nov 2020 11:39:26 -0500
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:59546 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbgKUQj0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Nov 2020 11:39:26 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 44EAF9E0076;
        Sat, 21 Nov 2020 16:39:21 +0000 (GMT)
Date:   Sat, 21 Nov 2020 16:39:19 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Qinglang Miao <miaoqinglang@huawei.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Heiko Stuebner <heiko@sntech.de>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio: adc: rockchip_saradc: fix missing
 clk_disable_unprepare() on error in rockchip_saradc_resume
Message-ID: <20201121163919.2fcb9e71@archlinux>
In-Reply-To: <20201108154128.57f4162f@archlinux>
References: <20201103120743.110662-1-miaoqinglang@huawei.com>
        <20201108154128.57f4162f@archlinux>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 8 Nov 2020 15:41:28 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Tue, 3 Nov 2020 20:07:43 +0800
> Qinglang Miao <miaoqinglang@huawei.com> wrote:
> 
> > Fix the missing clk_disable_unprepare() of info->pclk
> > before return from rockchip_saradc_resume in the error
> > handling case when fails to prepare and enable info->clk.
> > 
> > Fixes: 44d6f2ef94f9 ("iio: adc: add driver for Rockchip saradc")
> > Suggested-by:Robin Murphy <robin.murphy@arm.com>
> > Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>  
> 
> Looks good to me.  I'll just give it a little longer on the list so Heiko
> and others have a chance to sanity check it.
> 
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> Thanks,
> 
> Jonathan
> 
> > ---
> > v2: remove useless braces because early return is pointless.
> > 
> >  drivers/iio/adc/rockchip_saradc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
> > index 1f3d7d639..12584f163 100644
> > --- a/drivers/iio/adc/rockchip_saradc.c
> > +++ b/drivers/iio/adc/rockchip_saradc.c
> > @@ -462,7 +462,7 @@ static int rockchip_saradc_resume(struct device *dev)
> >  
> >  	ret = clk_prepare_enable(info->clk);
> >  	if (ret)
> > -		return ret;
> > +		clk_disable_unprepare(info->pclk);
> >  
> >  	return ret;
> >  }  
> 

