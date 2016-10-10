Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48628 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751498AbcJJUx1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 Oct 2016 16:53:27 -0400
Subject: Re: [PATCH v2 4/8] staging: iio: isl29018: combine two return
 statements into one
To: Brian Masney <masneyb@onstation.org>
References: <1476084002-29683-1-git-send-email-masneyb@onstation.org>
 <1476084002-29683-5-git-send-email-masneyb@onstation.org>
Cc: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <a094e2a9-5462-d634-1a31-05360642e483@kernel.org>
Date: Mon, 10 Oct 2016 21:53:22 +0100
MIME-Version: 1.0
In-Reply-To: <1476084002-29683-5-git-send-email-masneyb@onstation.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/10/16 08:19, Brian Masney wrote:
> Use the return value from isl29018_set_integration_time() as the return
> value for isl29018_chip_init() since this is the last piece of work
> inside that function.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied to the togreg branch of iio.git and pushed out as
testing for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/light/isl29018.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
> index 132de8e..6b6c761 100644
> --- a/drivers/staging/iio/light/isl29018.c
> +++ b/drivers/staging/iio/light/isl29018.c
> @@ -616,12 +616,10 @@ static int isl29018_chip_init(struct isl29018_chip *chip)
>  
>  	status = isl29018_set_integration_time(chip,
>  			isl29018_int_utimes[chip->type][chip->int_time]);
> -	if (status < 0) {
> +	if (status < 0)
>  		dev_err(dev, "Init of isl29018 fails\n");
> -		return status;
> -	}
>  
> -	return 0;
> +	return status;
>  }
>  
>  static const struct iio_info isl29018_info = {
> 

