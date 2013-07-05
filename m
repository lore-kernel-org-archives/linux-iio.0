Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:32889 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755549Ab3GELhn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 5 Jul 2013 07:37:43 -0400
From: Marek Vasut <marex@denx.de>
To: Hector Palacios <hector.palacios@digi.com>
Subject: Re: [PATCH 1/4] iio: mxs-lradc: change the realbits to 12
Date: Fri, 5 Jul 2013 13:37:39 +0200
Cc: linux-iio@vger.kernel.org, alexandre.belloni@free-electrons.com,
	lars@metafoo.de, jic23@kernel.org, fabio.estevam@freescale.com
References: <1373013039-19461-1-git-send-email-hector.palacios@digi.com> <1373013039-19461-2-git-send-email-hector.palacios@digi.com>
In-Reply-To: <1373013039-19461-2-git-send-email-hector.palacios@digi.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201307051337.39215.marex@denx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Dear Hector Palacios,

> The LRADC virtual channels have an 18 bit field to store the sum of up
> to 2^5 accumulated samples. The read_raw function however only operates
> over a single sample (12 bit resolution).
> In order to use this field for scaling operations, we need it to be the
> exact resolution value of the LRADC.

How would this work once the accumulation is supported?

> Signed-off-by: Hector Palacios <hector.palacios@digi.com>
> ---
>  drivers/staging/iio/adc/mxs-lradc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/adc/mxs-lradc.c
> b/drivers/staging/iio/adc/mxs-lradc.c index 163c638..d65a594 100644
> --- a/drivers/staging/iio/adc/mxs-lradc.c
> +++ b/drivers/staging/iio/adc/mxs-lradc.c
> @@ -822,7 +822,7 @@ static const struct iio_buffer_setup_ops
> mxs_lradc_buffer_ops = { .channel = (idx),					
\
>  	.scan_type = {						\
>  		.sign = 'u',					\
> -		.realbits = 18,					\
> +		.realbits = 12,					\
>  		.storagebits = 32,				\
>  	},							\
>  }

Best regards,
Marek Vasut
