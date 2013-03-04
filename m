Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:41940 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932236Ab3CDVXy (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 4 Mar 2013 16:23:54 -0500
From: Marek Vasut <marex@denx.de>
To: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 2/3] staging:iio:adc:mxs move to info_mask_(shared_by_type/separate)
Date: Mon, 4 Mar 2013 22:23:50 +0100
Cc: linux-iio@vger.kernel.org
References: <1362431780-27682-1-git-send-email-jic23@kernel.org> <1362431780-27682-3-git-send-email-jic23@kernel.org>
In-Reply-To: <1362431780-27682-3-git-send-email-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201303042223.50819.marex@denx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Dear Jonathan Cameron,

> The original info_mask is going away in favour of the broken out versions.
> 
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
> cc: Marek Vasut <marex@denx.de>
> ---
>  drivers/staging/iio/adc/mxs-lradc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/adc/mxs-lradc.c
> b/drivers/staging/iio/adc/mxs-lradc.c index f5fb0df..4ef3070 100644
> --- a/drivers/staging/iio/adc/mxs-lradc.c
> +++ b/drivers/staging/iio/adc/mxs-lradc.c
> @@ -821,7 +821,7 @@ static const struct iio_buffer_setup_ops
> mxs_lradc_buffer_ops = { .type = (chan_type),					
\
>  	.indexed = 1,						\
>  	.scan_index = (idx),					\
> -	.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT,		\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
>  	.channel = (idx),					\
>  	.scan_type = {						\
>  		.sign = 'u',					\

Reviewed-by: Marek Vasut <marex@denx.de>

Best regards,
Marek Vasut
