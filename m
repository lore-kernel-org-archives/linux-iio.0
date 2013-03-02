Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36420 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751896Ab3CBQYa (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 2 Mar 2013 11:24:30 -0500
Message-ID: <513227BD.3050000@kernel.org>
Date: Sat, 02 Mar 2013 16:24:29 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/3] iio:ad5064: Fix off by one in DAC value range check
References: <1362143239-891-1-git-send-email-lars@metafoo.de> <1362143239-891-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1362143239-891-2-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/01/2013 01:07 PM, Lars-Peter Clausen wrote:
> The DAC value range check allows values one larger than the maximum value, which
> effectively results in setting the DAC value to 0. This patch fixes the issue.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
applied to fixes-togreg branch of iio.git
> ---
>  drivers/iio/dac/ad5064.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/dac/ad5064.c b/drivers/iio/dac/ad5064.c
> index e19b73f..a491976 100644
> --- a/drivers/iio/dac/ad5064.c
> +++ b/drivers/iio/dac/ad5064.c
> @@ -257,7 +257,7 @@ static int ad5064_write_raw(struct iio_dev *indio_dev,
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> -		if (val > (1 << chan->scan_type.realbits) || val < 0)
> +		if (val >= (1 << chan->scan_type.realbits) || val < 0)
>  			return -EINVAL;
>  
>  		mutex_lock(&indio_dev->mlock);
> 
