Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B136CC4338F
	for <linux-iio@archiver.kernel.org>; Sat, 31 Jul 2021 13:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 845AA61042
	for <linux-iio@archiver.kernel.org>; Sat, 31 Jul 2021 13:45:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233391AbhGaNpk (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 31 Jul 2021 09:45:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:42846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233367AbhGaNpV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Jul 2021 09:45:21 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3C8E61042;
        Sat, 31 Jul 2021 13:44:53 +0000 (UTC)
Date:   Sat, 31 Jul 2021 14:47:32 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Lee Jones <lee.jones@linaro.org>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Pradeep Goudagunta <pgoudagunta@nvidia.com>,
        Marek Belisko <marek@goldelico.com>, linux-iio@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: Fix incorrect exit of for-loop
Message-ID: <20210731144732.57777e20@jic23-huawei>
In-Reply-To: <20210730071651.17394-1-colin.king@canonical.com>
References: <20210730071651.17394-1-colin.king@canonical.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 30 Jul 2021 08:16:51 +0100
Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently the for-loop that scans for the optimial adc_period iterates
> through all the possible adc_period levels because the exit logic in
> the loop is inverted. I believe the comparison should be swapped and
> the continue replaced with a break to exit the loop at the correct
> point.
> 
> Addresses-Coverity: ("Continue has no effect")
> Fixes: e08e19c331fb ("iio:adc: add iio driver for Palmas (twl6035/7) gpadc")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
ouch.

Applied to the fixes togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/palmas_gpadc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_gpadc.c
> index 6ef09609be9f..f9c8385c72d3 100644
> --- a/drivers/iio/adc/palmas_gpadc.c
> +++ b/drivers/iio/adc/palmas_gpadc.c
> @@ -664,8 +664,8 @@ static int palmas_adc_wakeup_configure(struct palmas_gpadc *adc)
>  
>  	adc_period = adc->auto_conversion_period;
>  	for (i = 0; i < 16; ++i) {
> -		if (((1000 * (1 << i)) / 32) < adc_period)
> -			continue;
> +		if (((1000 * (1 << i)) / 32) >= adc_period)
> +			break;
>  	}
>  	if (i > 0)
>  		i--;

