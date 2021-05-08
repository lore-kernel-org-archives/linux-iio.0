Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F15C433B4
	for <linux-iio@archiver.kernel.org>; Sat,  8 May 2021 16:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41B04613EE
	for <linux-iio@archiver.kernel.org>; Sat,  8 May 2021 16:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbhEHQNE (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 8 May 2021 12:13:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:58360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229500AbhEHQNE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 8 May 2021 12:13:04 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEFEB61260;
        Sat,  8 May 2021 16:11:59 +0000 (UTC)
Date:   Sat, 8 May 2021 17:12:58 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jon Brenner <jbrenner@taosinc.com>, linux-iio@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: tsl2583: Fix division by a zero lux_val
Message-ID: <20210508171258.2ef71a70@jic23-huawei>
In-Reply-To: <20210507183041.115864-1-colin.king@canonical.com>
References: <20210507183041.115864-1-colin.king@canonical.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri,  7 May 2021 19:30:41 +0100
Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> The lux_val returned from tsl2583_get_lux can potentially be zero,
> so check for this to avoid a division by zero and an overflowed
> gain_trim_val.
> 
> Fixes clang scan-build warning:
> 
> drivers/iio/light/tsl2583.c:345:40: warning: Either the
> condition 'lux_val<0' is redundant or there is division
> by zero at line 345. [zerodivcond]
> 
> Fixes: ac4f6eee8fe8 ("staging: iio: TAOS tsl258x: Device driver")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Definitely looks like it could happen so applied to the fixes-togreg branch of
iio.git and marked for stable.

Thanks,

Jonathan
> ---
>  drivers/iio/light/tsl2583.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/iio/light/tsl2583.c b/drivers/iio/light/tsl2583.c
> index 0f787bfc88fc..c9d8f07a6fcd 100644
> --- a/drivers/iio/light/tsl2583.c
> +++ b/drivers/iio/light/tsl2583.c
> @@ -341,6 +341,14 @@ static int tsl2583_als_calibrate(struct iio_dev *indio_dev)
>  		return lux_val;
>  	}
>  
> +	/* Avoid division by zero of lux_value later on */
> +	if (lux_val == 0) {
> +		dev_err(&chip->client->dev,
> +			"%s: lux_val of 0 will produce out of range trim_value\n",
> +			__func__);
> +		return -ENODATA;
> +	}
> +
>  	gain_trim_val = (unsigned int)(((chip->als_settings.als_cal_target)
>  			* chip->als_settings.als_gain_trim) / lux_val);
>  	if ((gain_trim_val < 250) || (gain_trim_val > 4000)) {

