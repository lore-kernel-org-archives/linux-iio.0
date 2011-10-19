Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:58595 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751570Ab1JSPtH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 19 Oct 2011 11:49:07 -0400
Message-ID: <4E9EF177.80807@cam.ac.uk>
Date: Wed, 19 Oct 2011 16:49:11 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Michael Hennerich <michael.hennerich@analog.com>,
	linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Subject: Re: [PATCH] staging:iio:dac:ad5686: Check for negative values
References: <1319039103-16706-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1319039103-16706-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/19/11 16:45, Lars-Peter Clausen wrote:
> Currently it is possible to write negative values to the ad5686's raw attribute.
> This will cause undefined behaviour, so reject negative values.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  drivers/staging/iio/dac/ad5686.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/staging/iio/dac/ad5686.c b/drivers/staging/iio/dac/ad5686.c
> index 1d50dd1..48389e1 100644
> --- a/drivers/staging/iio/dac/ad5686.c
> +++ b/drivers/staging/iio/dac/ad5686.c
> @@ -327,7 +327,7 @@ static int ad5686_write_raw(struct iio_dev *indio_dev,
>  
>  	switch (mask) {
>  	case 0:
> -		if (val > (1 << chan->scan_type.realbits))
> +		if (val > (1 << chan->scan_type.realbits) || val < 0)
>  			return -EINVAL;
>  
>  		mutex_lock(&indio_dev->mlock);

