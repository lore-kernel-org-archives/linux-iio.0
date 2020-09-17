Return-Path: <SRS0=wjVZ=C2=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FFBC43461
	for <linux-iio@archiver.kernel.org>; Thu, 17 Sep 2020 18:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77935221EE
	for <linux-iio@archiver.kernel.org>; Thu, 17 Sep 2020 18:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgIQSkM (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 17 Sep 2020 14:40:12 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:51046 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbgIQSkJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 17 Sep 2020 14:40:09 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 14:40:08 EDT
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 80B019E0250;
        Thu, 17 Sep 2020 19:40:06 +0100 (BST)
Date:   Thu, 17 Sep 2020 19:40:05 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: Re: [PATCH] iio:dac:ad5592r: Fix use of true where iio_shared_by
 enum required
Message-ID: <20200917194005.401d5279@archlinux>
In-Reply-To: <20200913114731.739478-1-jic23@kernel.org>
References: <20200913114731.739478-1-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 13 Sep 2020 12:47:31 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Given true evaluates to 1, this should IIO_SHARED_BY_TYPE.
I sent this same one out before and then lost it.  I've picked that
version up as at was reviewed at that time.

Sorry for the noise.

Jonathan

> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Alexandru Ardelean <alexandru.ardelean@analog.com>
> Fixes: 56ca9db862bf ("iio: dac: Add support for the AD5592R/AD5593R ADCs/DACs")
> ---
>  drivers/iio/dac/ad5592r-base.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/dac/ad5592r-base.c b/drivers/iio/dac/ad5592r-base.c
> index cc4875660a69..456bf5292c44 100644
> --- a/drivers/iio/dac/ad5592r-base.c
> +++ b/drivers/iio/dac/ad5592r-base.c
> @@ -488,7 +488,7 @@ static const struct iio_chan_spec_ext_info ad5592r_ext_info[] = {
>  	{
>  	 .name = "scale_available",
>  	 .read = ad5592r_show_scale_available,
> -	 .shared = true,
> +	 .shared = IIO_SHARED_BY_TYPE,
>  	 },
>  	{},
>  };

