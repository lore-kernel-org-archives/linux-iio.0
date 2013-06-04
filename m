Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51365 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753092Ab3FDRue (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 4 Jun 2013 13:50:34 -0400
Message-ID: <51AE28E8.2050601@kernel.org>
Date: Tue, 04 Jun 2013 18:50:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio:inkern: Fix typo/bug in convert raw to processed.
References: <1370246656-15546-1-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1370246656-15546-1-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/03/2013 09:04 AM, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
oops.  Applied to fixes-togreg branch of iio.git

Thanks,
> ---
>  drivers/iio/inkern.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index 795d100..442d529 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -450,7 +450,7 @@ static int iio_convert_raw_to_processed_unlocked(struct iio_channel *chan,
>  	s64 raw64 = raw;
>  	int ret;
>  
> -	ret = iio_channel_read(chan, &offset, NULL, IIO_CHAN_INFO_SCALE);
> +	ret = iio_channel_read(chan, &offset, NULL, IIO_CHAN_INFO_OFFSET);
>  	if (ret == 0)
>  		raw64 += offset;
>  
> 
