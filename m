Return-Path: <SRS0=Xg61=EJ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B2A2C388F7
	for <linux-iio@archiver.kernel.org>; Tue,  3 Nov 2020 08:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2669222404
	for <linux-iio@archiver.kernel.org>; Tue,  3 Nov 2020 08:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725982AbgKCIUP (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 3 Nov 2020 03:20:15 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:7449 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgKCIUP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 Nov 2020 03:20:15 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CQN4s2bXGzhg9l;
        Tue,  3 Nov 2020 16:20:13 +0800 (CST)
Received: from [10.174.177.149] (10.174.177.149) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Tue, 3 Nov 2020 16:20:07 +0800
Subject: Re: [PATCH v2] iio: adc: rockchip_saradc: fix missing
 clk_disable_unprepare() on error in rockchip_saradc_resume
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Heiko Stuebner <heiko@sntech.de>
CC:     <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20201103074909.195465-1-miaoqinglang@huawei.com>
From:   Qinglang Miao <miaoqinglang@huawei.com>
Message-ID: <6739f62b-c88e-6792-3237-49787c73c662@huawei.com>
Date:   Tue, 3 Nov 2020 16:20:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20201103074909.195465-1-miaoqinglang@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.149]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



ÔÚ 2020/11/3 15:49, Qinglang Miao Ð´µÀ:
> Fix the missing clk_disable_unprepare() of info->pclk
> before return from rockchip_saradc_resume in the error
> handling case when fails to prepare and enable info->clk.
> 
> Fixes: 44d6f2ef94f9 ("iio: adc: add driver for Rockchip saradc")
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
> ---
>   drivers/iio/adc/rockchip_saradc.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
> index 1f3d7d639..5eb566274 100644
> --- a/drivers/iio/adc/rockchip_saradc.c
> +++ b/drivers/iio/adc/rockchip_saradc.c
> @@ -461,9 +461,10 @@ static int rockchip_saradc_resume(struct device *dev)
>   		return ret;
>   
>   	ret = clk_prepare_enable(info->clk);
> -	if (ret)
> +	if (ret) {
> +		clk_disable_unprepare(info->pclk);
>   		return ret;
> -
> +	}
>   	return ret;
>   }
>   #endif
> 
Hi everyone,

I made a careless mistake for adding v2 as subject-prefix, this patch is 
the base version actually.

Sorry about that.

Thanks.
