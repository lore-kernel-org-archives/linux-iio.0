Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:46116 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753968AbaEaKXg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 31 May 2014 06:23:36 -0400
Message-ID: <5389AE13.70903@kernel.org>
Date: Sat, 31 May 2014 11:25:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Mario Schuknecht <mario.schuknecht@dresearch-fe.de>,
	linux-iio@vger.kernel.org, jbrenner@taosinc.com
Subject: Re: [PATCH] staging: iio: tsl2x7x_core: fix proximity treshold
References: <1401171595-13448-1-git-send-email-mario.schuknecht@dresearch-fe.de>
In-Reply-To: <1401171595-13448-1-git-send-email-mario.schuknecht@dresearch-fe.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 27/05/14 07:19, Mario Schuknecht wrote:
> Consider high byte of proximity min and max treshold in function
> 'tsl2x7x_chip_on'. So far, the high byte was not set.
>
> Signed-off-by: Mario Schuknecht <mario.schuknecht@dresearch-fe.de>
Looks right to me.

Jon, it's your driver so do you have a few mins to check this?  Given
timing this won't go in until the merge window has closed now anyway
so you have a few weeks.  Looks like stable material though so I'll
mark it as such when I apply it.


> ---
>   drivers/staging/iio/light/tsl2x7x_core.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/staging/iio/light/tsl2x7x_core.c b/drivers/staging/iio/light/tsl2x7x_core.c
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

