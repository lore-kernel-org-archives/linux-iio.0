Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58451 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759053Ab2JSRmy (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 19 Oct 2012 13:42:54 -0400
Message-ID: <50817172.9060006@kernel.org>
Date: Fri, 19 Oct 2012 16:27:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/4] iio: Don't compare boolean values to true/false
References: <1350571399-17723-1-git-send-email-lars@metafoo.de> <1350571399-17723-3-git-send-email-lars@metafoo.de>
In-Reply-To: <1350571399-17723-3-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/18/2012 03:43 PM, Lars-Peter Clausen wrote:
> Fixes the following warnings from coccicheck:
> 	drivers/iio/inkern.c:81:6-14: WARNING: Comparison to bool
> 	drivers/iio/dac/ad5686.c:191:5-11: WARNING: Comparison to bool
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Another 'exciting patch'.  I guess it fills the time whilst on a train
under the sea though... hohum.  Land soon and back to mindless websurfing...
> ---
>  drivers/iio/dac/ad5686.c |    2 +-
>  drivers/iio/inkern.c     |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
> index 6948d75..bc92ff9 100644
> --- a/drivers/iio/dac/ad5686.c
> +++ b/drivers/iio/dac/ad5686.c
> @@ -188,7 +188,7 @@ static ssize_t ad5686_write_dac_powerdown(struct iio_dev *indio_dev,
>  	if (ret)
>  		return ret;
>  
> -	if (readin == true)
> +	if (readin)
>  		st->pwr_down_mask |= (0x3 << (chan->channel * 2));
>  	else
>  		st->pwr_down_mask &= ~(0x3 << (chan->channel * 2));
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index f2b78d4..5230a33 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -78,7 +78,7 @@ int iio_map_array_unregister(struct iio_dev *indio_dev,
>  				found_it = true;
>  				break;
>  			}
> -		if (found_it == false) {
> +		if (!found_it) {
>  			ret = -ENODEV;
>  			goto error_ret;
>  		}
> 
