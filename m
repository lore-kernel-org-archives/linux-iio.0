Return-Path: <SRS0=QBqV=Q3=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03054C43381
	for <linux-iio@archiver.kernel.org>; Wed, 20 Feb 2019 10:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C917E2183F
	for <linux-iio@archiver.kernel.org>; Wed, 20 Feb 2019 10:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550659883;
	bh=PzRJAPwBsgDtiqEoCYaFntr89KEcB3BMUXSrU8isO1E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=QEBkpNlCytgnCZpAe8hVQ9yLuu/v8+mFXIhBv7PZsKJBf1peDXSiGMbEj6d1DrPNf
	 HOqTy5bDPOhxNBu0q7MTpm7sKJCvkhDHOWOPS945NG0uymY9YvmH669DhHKk1c/803
	 xEYCXWs7HBC8R9fL5W0CFRnFt0FfgW41ONJZJWXA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbfBTKvX (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 20 Feb 2019 05:51:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:35836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbfBTKvX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 20 Feb 2019 05:51:23 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4A152147C;
        Wed, 20 Feb 2019 10:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550659882;
        bh=PzRJAPwBsgDtiqEoCYaFntr89KEcB3BMUXSrU8isO1E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=d7qDjHDcKUYCV3WAMdGqjD/LXg47Hzies/8pr02HQxp52elpjQ43IUzCi6YxbCUKu
         7QCgCzteqvOcEeasU4U1l7h0ZpJrMeJen0vQo3wiCyQZrBW573sd0bRsrFqNXJ9Ys6
         c7DqwAge+JvAuqcNtC/2Mb31u0toOfKI2gMCwOr4=
Date:   Wed, 20 Feb 2019 10:51:17 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Artur Rojek <contact@artur-rojek.eu>,
        <linux-iio@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH -next] iio: adc: ingenic: remove redundant dev_err call
 in ingenic_adc_probe()
Message-ID: <20190220105117.40104d25@archlinux>
In-Reply-To: <20190218065735.159915-1-weiyongjun1@huawei.com>
References: <20190218065735.159915-1-weiyongjun1@huawei.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 18 Feb 2019 06:57:35 +0000
Wei Yongjun <weiyongjun1@huawei.com> wrote:

> There is a error message within devm_ioremap_resource
> already, so remove the dev_err call to avoid redundant
> error message.
> 
> Fixes: 1a78daea107d ("IIO: add Ingenic JZ47xx ADC driver.")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Hi

The patch is good, but the fixes tag is too strong.  We don't want
the noise of backporting the dropping of an overly verbose bit
of error printing. It's not doing any harm, just not doing any
good either!  So, let us keep this as low priority tidy up.

Applied to the togreg branch of iio.git with that tag dropped.

Thanks,

Jonathan
> ---
>  drivers/iio/adc/ingenic-adc.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/ingenic-adc.c b/drivers/iio/adc/ingenic-adc.c
> index 6ee1673deb0d..8f9c125939a8 100644
> --- a/drivers/iio/adc/ingenic-adc.c
> +++ b/drivers/iio/adc/ingenic-adc.c
> @@ -302,10 +302,8 @@ static int ingenic_adc_probe(struct platform_device *pdev)
>  
>  	mem_base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	adc->base = devm_ioremap_resource(dev, mem_base);
> -	if (IS_ERR(adc->base)) {
> -		dev_err(dev, "Unable to ioremap mmio resource\n");
> +	if (IS_ERR(adc->base))
>  		return PTR_ERR(adc->base);
> -	}
>  
>  	adc->clk = devm_clk_get(dev, "adc");
>  	if (IS_ERR(adc->clk)) {
> 
> 
> 

