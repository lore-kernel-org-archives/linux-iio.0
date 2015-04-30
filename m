Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47095 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751372AbbD3U4R (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 30 Apr 2015 16:56:17 -0400
Message-ID: <554296EE.5030705@kernel.org>
Date: Thu, 30 Apr 2015 21:56:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	linux-iio@vger.kernel.org
CC: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	daniel.baluta@intel.com, dan.carpenter@oracle.com, kbuild@01.org
Subject: Re: [PATCH] staging: iio: light: isl29018: Add missing mutex_unlock
 on error path
References: <1430240967-2459-1-git-send-email-roberta.dobrescu@gmail.com>
In-Reply-To: <1430240967-2459-1-git-send-email-roberta.dobrescu@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 28/04/15 18:09, Roberta Dobrescu wrote:
> This patch fixes the following warning:
> 
> drivers/staging/iio/light/isl29018.c:386 isl29018_write_raw() warn:
> inconsistent returns 'mutex:&chip->lock'.
>  Locked on:   line 374
>  Unlocked on: line 386
> 
> Signed-off-by: Roberta Dobrescu <roberta.dobrescu@gmail.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
I applied this as a fixup rather than a separate patch.

Anyhow, new testing and togreg branches should have this fixed.
> ---
>  drivers/staging/iio/light/isl29018.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
> index 435d417..08ca9a4 100644
> --- a/drivers/staging/iio/light/isl29018.c
> +++ b/drivers/staging/iio/light/isl29018.c
> @@ -370,8 +370,10 @@ static int isl29018_write_raw(struct iio_dev *indio_dev,
>  		break;
>  	case IIO_CHAN_INFO_INT_TIME:
>  		if (chan->type == IIO_LIGHT)
> -			if (val != 0)
> +			if (val != 0) {
> +				mutex_unlock(&chip->lock);
>  				return -EINVAL;
> +			}
>  			ret = isl29018_set_integration_time(chip, val2);
>  		break;
>  	case IIO_CHAN_INFO_SCALE:
> 

