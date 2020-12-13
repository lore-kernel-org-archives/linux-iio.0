Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83788C4361B
	for <linux-iio@archiver.kernel.org>; Sun, 13 Dec 2020 13:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 443CD20575
	for <linux-iio@archiver.kernel.org>; Sun, 13 Dec 2020 13:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406824AbgLMNXz (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 13 Dec 2020 08:23:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:51546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbgLMNXt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Dec 2020 08:23:49 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 146EB22EBE;
        Sun, 13 Dec 2020 13:23:06 +0000 (UTC)
Date:   Sun, 13 Dec 2020 13:23:03 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Daniel Campello <campello@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: sx9310: Off by one in sx9310_read_thresh()
Message-ID: <20201213132303.4b362987@archlinux>
In-Reply-To: <X8XqwK0z//8sSWJR@mwanda>
References: <X8XqwK0z//8sSWJR@mwanda>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 1 Dec 2020 10:03:28 +0300
Dan Carpenter <dan.carpenter@oracle.com> wrote:

> This > should be >= to prevent reading one element beyond the end of
> the sx9310_pthresh_codes[] array.
> 
> Fixes: ad2b473e2ba3 ("iio: sx9310: Support setting proximity thresholds")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Applied to the fixes-togreg branch of iio.git which won't go anywhere now
until after rc1 (and is based on the stuff queued up for the merge window)

thanks,

Jonathan

> ---
>  drivers/iio/proximity/sx9310.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
> index a2f820997afc..62eacb22e9bc 100644
> --- a/drivers/iio/proximity/sx9310.c
> +++ b/drivers/iio/proximity/sx9310.c
> @@ -601,7 +601,7 @@ static int sx9310_read_thresh(struct sx9310_data *data,
>  		return ret;
>  
>  	regval = FIELD_GET(SX9310_REG_PROX_CTRL8_9_PTHRESH_MASK, regval);
> -	if (regval > ARRAY_SIZE(sx9310_pthresh_codes))
> +	if (regval >= ARRAY_SIZE(sx9310_pthresh_codes))
>  		return -EINVAL;
>  
>  	*val = sx9310_pthresh_codes[regval];

