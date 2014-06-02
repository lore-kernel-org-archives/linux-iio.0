Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail1.ams.com ([212.166.112.31]:42982 "EHLO mail1.ams.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753844AbaFBQSc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 2 Jun 2014 12:18:32 -0400
From: Jon Brenner <Jon.Brenner@ams.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Mario Schuknecht <mario.schuknecht@dresearch-fe.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Date: Mon, 2 Jun 2014 18:08:44 +0200
Subject: RE: [PATCH] staging: iio: tsl2x7x_core: fix proximity threshold
Message-ID: <9A1AC870E7D6284DB056414587DDA8F701BF67BB@SUX2182.office.amsiag.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello Jonathan,
Looks fine  (these changes should have already been in there as they reflect exactly what I have in my most recent source) - but I'll figure that out later.
 

-----Original Message-----
From: Jonathan Cameron [mailto:jic23@kernel.org] 
Sent: Saturday, May 31, 2014 5:25 AM
To: Mario Schuknecht; linux-iio@vger.kernel.org; Jon Brenner
Subject: Re: [PATCH] staging: iio: tsl2x7x_core: fix proximity treshold

On 27/05/14 07:19, Mario Schuknecht wrote:
> Consider high byte of proximity min and max treshold in function 
> 'tsl2x7x_chip_on'. So far, the high byte was not set.
>
> Signed-off-by: Mario Schuknecht <mario.schuknecht@dresearch-fe.de>
Looks right to me.

Jon, it's your driver so do you have a few mins to check this?  Given timing this won't go in until the merge window has closed now anyway so you have a few weeks.  Looks like stable material though so I'll mark it as such when I apply it.


> ---
>   drivers/staging/iio/light/tsl2x7x_core.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/staging/iio/light/tsl2x7x_core.c 
> b/drivers/staging/iio/light/tsl2x7x_core.c
> index 9e0f2a9..ab338e3 100644
> --- a/drivers/staging/iio/light/tsl2x7x_core.c
> +++ b/drivers/staging/iio/light/tsl2x7x_core.c
> @@ -667,9 +667,13 @@ static int tsl2x7x_chip_on(struct iio_dev *indio_dev)
>   	chip->tsl2x7x_config[TSL2X7X_PRX_COUNT] =
>   			chip->tsl2x7x_settings.prox_pulse_count;
>   	chip->tsl2x7x_config[TSL2X7X_PRX_MINTHRESHLO] =
> -	chip->tsl2x7x_settings.prox_thres_low;
> +			(chip->tsl2x7x_settings.prox_thres_low) & 0xFF;
> +	chip->tsl2x7x_config[TSL2X7X_PRX_MINTHRESHHI] =
> +			(chip->tsl2x7x_settings.prox_thres_low >> 8) & 0xFF;
>   	chip->tsl2x7x_config[TSL2X7X_PRX_MAXTHRESHLO] =
> -			chip->tsl2x7x_settings.prox_thres_high;
> +			(chip->tsl2x7x_settings.prox_thres_high) & 0xFF;
> +	chip->tsl2x7x_config[TSL2X7X_PRX_MAXTHRESHHI] =
> +			(chip->tsl2x7x_settings.prox_thres_high >> 8) & 0xFF;
>
>   	/* and make sure we're not already on */
>   	if (chip->tsl2x7x_chip_status == TSL2X7X_CHIP_WORKING) {
>

