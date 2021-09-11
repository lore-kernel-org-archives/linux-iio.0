Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9A4C433EF
	for <linux-iio@archiver.kernel.org>; Sat, 11 Sep 2021 17:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AC3061212
	for <linux-iio@archiver.kernel.org>; Sat, 11 Sep 2021 17:08:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbhIKRJO (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 11 Sep 2021 13:09:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:43386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230018AbhIKRJO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 11 Sep 2021 13:09:14 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B5BC611F0;
        Sat, 11 Sep 2021 17:07:59 +0000 (UTC)
Date:   Sat, 11 Sep 2021 18:11:31 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: ad799x: Add a single error handling block at
 the end of the function.
Message-ID: <20210911181131.4e7ff695@jic23-huawei>
In-Reply-To: <20210907062407.1930-1-caihuoqing@baidu.com>
References: <20210907062407.1930-1-caihuoqing@baidu.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 7 Sep 2021 14:24:06 +0800
Cai Huoqing <caihuoqing@baidu.com> wrote:

> A single error handling block at the end of the function could
> be brought in to make code a little more concise.
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---
>  drivers/iio/adc/ad799x.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
> index 18bf8386d50a..d3dbc4c1e375 100644
> --- a/drivers/iio/adc/ad799x.c
> +++ b/drivers/iio/adc/ad799x.c
> @@ -891,20 +891,23 @@ static int __maybe_unused ad799x_resume(struct device *dev)
>  	}
>  	ret = regulator_enable(st->vref);
>  	if (ret) {
> -		regulator_disable(st->reg);
>  		dev_err(dev, "Unable to enable vref regulator\n");
> -		return ret;
> +		goto error_disable_reg;
>  	}
>  
>  	/* resync config */
>  	ret = ad799x_update_config(st, st->config);
> -	if (ret) {
> -		regulator_disable(st->vref);
> -		regulator_disable(st->reg);
> -		return ret;
> -	}
> +	if (ret)
> +		goto error_disable_vref;
>  
>  	return 0;
> +
> +error_disable_vref:
> +	regulator_disable(st->vref);
> +error_disable_reg:
> +	regulator_disable(st->vref);
st->reg

> +
> +	return ret;
>  }
>  
>  static SIMPLE_DEV_PM_OPS(ad799x_pm_ops, ad799x_suspend, ad799x_resume);

