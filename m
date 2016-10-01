Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44666 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750853AbcJAN7v (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 Oct 2016 09:59:51 -0400
Subject: Re: [PATCH v3 5/5] staging: iio: isl29018: check if the chip is in a
 suspended state
To: Brian Masney <masneyb@onstation.org>
References: <20160926075935.GA25938@kroah.com>
 <1474935620-13151-1-git-send-email-masneyb@onstation.org>
 <1474935620-13151-5-git-send-email-masneyb@onstation.org>
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <547487cf-87f7-0922-ad30-cf8dff599d71@kernel.org>
Date: Sat, 1 Oct 2016 14:59:49 +0100
MIME-Version: 1.0
In-Reply-To: <1474935620-13151-5-git-send-email-masneyb@onstation.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 27/09/16 01:20, Brian Masney wrote:
> Add a check to isl29018_write_raw() to ensure that the chip is not in a
> suspended state. This makes the code consistent with what is present
> in isl29018_read_raw().
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied to the togreg branch of iio.git.

Out of curiosity, do you actually have one of these?

At a quick glance, the only remaining bit keeping this driver
in staging is the lack of docs on the infrared_supression
attribute.  If you want to add something on that and a patch
moving it out of staging that would be great.

However, note that the graduation patch is usually the one
that gets the driver thoroughly reviewed by several people so
more stuff may come out of the woodwork.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/light/isl29018.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
> index 3a4d79d..51226bd 100644
> --- a/drivers/staging/iio/light/isl29018.c
> +++ b/drivers/staging/iio/light/isl29018.c
> @@ -355,6 +355,10 @@ static int isl29018_write_raw(struct iio_dev *indio_dev,
>  	int ret = -EINVAL;
>  
>  	mutex_lock(&chip->lock);
> +	if (chip->suspended) {
> +		ret = -EBUSY;
> +		goto write_done;
> +	}
>  	switch (mask) {
>  	case IIO_CHAN_INFO_CALIBSCALE:
>  		if (chan->type == IIO_LIGHT) {
> @@ -374,8 +378,9 @@ static int isl29018_write_raw(struct iio_dev *indio_dev,
>  	default:
>  		break;
>  	}
> -	mutex_unlock(&chip->lock);
>  
> +write_done:
> +	mutex_unlock(&chip->lock);
>  	return ret;
>  }
>  
> 

