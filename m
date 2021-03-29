Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B08C5C433DB
	for <linux-iio@archiver.kernel.org>; Mon, 29 Mar 2021 12:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 796E260C3D
	for <linux-iio@archiver.kernel.org>; Mon, 29 Mar 2021 12:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbhC2M05 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 29 Mar 2021 08:26:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:43250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231205AbhC2M0p (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 29 Mar 2021 08:26:45 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8E3B60C3D;
        Mon, 29 Mar 2021 12:26:42 +0000 (UTC)
Date:   Mon, 29 Mar 2021 13:26:48 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH] iio: Fix iio_read_channel_processed_scale()
Message-ID: <20210329132648.1d18c0c1@jic23-huawei>
In-Reply-To: <20210323122705.1326362-1-linus.walleij@linaro.org>
References: <20210323122705.1326362-1-linus.walleij@linaro.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 23 Mar 2021 13:27:05 +0100
Linus Walleij <linus.walleij@linaro.org> wrote:

> The code was checking if (ret) from the processed
> channel readout, not smart, we need to check if (ret < 0)
> as this will likely be something like IIO_VAL_INT.
> 
> Fixes: dc98269f7c7d ("iio: Provide iio_read_channel_processed_scale() API")
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Jonathan: this Fixes tag is the commit ID found in your
> testing branch, feel free to just squash if you prefer
> that.

Applied to the togreg branch of iio.git

Thanks,

Jonathan

> ---
>  drivers/iio/inkern.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index c61fc06f98b8..9c22697b7e83 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -702,7 +702,7 @@ int iio_read_channel_processed_scale(struct iio_channel *chan, int *val,
>  	if (iio_channel_has_info(chan->channel, IIO_CHAN_INFO_PROCESSED)) {
>  		ret = iio_channel_read(chan, val, NULL,
>  				       IIO_CHAN_INFO_PROCESSED);
> -		if (ret)
> +		if (ret < 0)
>  			goto err_unlock;
>  		*val *= scale;
>  	} else {

