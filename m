Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48535 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751579AbcJJUeV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 Oct 2016 16:34:21 -0400
Subject: Re: [PATCH v2 3/8] staging: iio: isl29018: fix multiline comment
 syntax
To: Brian Masney <masneyb@onstation.org>
References: <1476084002-29683-1-git-send-email-masneyb@onstation.org>
 <1476084002-29683-4-git-send-email-masneyb@onstation.org>
Cc: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <d77e6e1d-d31c-4af8-b586-f2feba8857dd@kernel.org>
Date: Mon, 10 Oct 2016 21:34:19 +0100
MIME-Version: 1.0
In-Reply-To: <1476084002-29683-4-git-send-email-masneyb@onstation.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/10/16 08:19, Brian Masney wrote:
> Change multiline comments from:
> 
> /* line1
>  * line2
>  * ...
>  */
> 
> to
> 
> /*
>  * line1
>  * line2
>  * ...
>  */
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied to the togreg branch of iio.git and pushed out as testing.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/light/isl29018.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
> index 130f222..132de8e 100644
> --- a/drivers/staging/iio/light/isl29018.c
> +++ b/drivers/staging/iio/light/isl29018.c
> @@ -564,7 +564,8 @@ static int isl29018_chip_init(struct isl29018_chip *chip)
>  			return status;
>  	}
>  
> -	/* Code added per Intersil Application Note 1534:
> +	/*
> +	 * Code added per Intersil Application Note 1534:
>  	 *     When VDD sinks to approximately 1.8V or below, some of
>  	 * the part's registers may change their state. When VDD
>  	 * recovers to 2.25V (or greater), the part may thus be in an
> @@ -591,7 +592,8 @@ static int isl29018_chip_init(struct isl29018_chip *chip)
>  		return status;
>  	}
>  
> -	/* See Intersil AN1534 comments above.
> +	/*
> +	 * See Intersil AN1534 comments above.
>  	 * "Operating Mode" (COMMAND1) register is reprogrammed when
>  	 * data is read from the device.
>  	 */
> @@ -773,7 +775,8 @@ static int isl29018_suspend(struct device *dev)
>  
>  	mutex_lock(&chip->lock);
>  
> -	/* Since this driver uses only polling commands, we are by default in
> +	/*
> +	 * Since this driver uses only polling commands, we are by default in
>  	 * auto shutdown (ie, power-down) mode.
>  	 * So we do not have much to do here.
>  	 */
> 

