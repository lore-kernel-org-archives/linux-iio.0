Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76720C433B4
	for <linux-iio@archiver.kernel.org>; Sun, 16 May 2021 09:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5577B6113C
	for <linux-iio@archiver.kernel.org>; Sun, 16 May 2021 09:29:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234590AbhEPJa6 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 16 May 2021 05:30:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:55088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231187AbhEPJa5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 16 May 2021 05:30:57 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCD1E61139;
        Sun, 16 May 2021 09:29:41 +0000 (UTC)
Date:   Sun, 16 May 2021 10:30:53 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Joe Sandom <joe.g.sandom@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: light: tsl2591: fix some signedness bugs
Message-ID: <20210516103053.35528ab4@jic23-huawei>
In-Reply-To: <YJ52r1XZ44myD9Xx@mwanda>
References: <YJ52r1XZ44myD9Xx@mwanda>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 14 May 2021 16:10:07 +0300
Dan Carpenter <dan.carpenter@oracle.com> wrote:

> These variables need to be int for the error handling to work.
> 
> Fixes: f053d4e748ce ("iio: light: Added AMS tsl2591 driver implementation")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Both applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to poke at it.

As such, there is still a bit of time if anyone else wants to review
these / give tags etc, before I push it out as a non rebasing branch.

thanks,

Jonathan

> ---
>  drivers/iio/light/tsl2591.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/light/tsl2591.c b/drivers/iio/light/tsl2591.c
> index 2bdae388ff01..26e3cb6c4ff8 100644
> --- a/drivers/iio/light/tsl2591.c
> +++ b/drivers/iio/light/tsl2591.c
> @@ -213,7 +213,7 @@ static int tsl2591_gain_to_multiplier(const u8 als_gain)
>  	}
>  }
>  
> -static u8 tsl2591_multiplier_to_gain(const u32 multiplier)
> +static int tsl2591_multiplier_to_gain(const u32 multiplier)
>  {
>  	switch (multiplier) {
>  	case TSL2591_CTRL_ALS_LOW_GAIN_MULTIPLIER:
> @@ -783,8 +783,8 @@ static int tsl2591_write_raw(struct iio_dev *indio_dev,
>  			     int val, int val2, long mask)
>  {
>  	struct tsl2591_chip *chip = iio_priv(indio_dev);
> -	u32 int_time;
> -	u8 gain;
> +	int int_time;
> +	int gain;
>  	int ret;
>  
>  	mutex_lock(&chip->als_mutex);

