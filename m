Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34079 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932315AbcE2Sqt (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 29 May 2016 14:46:49 -0400
Subject: Re: [PATCH] iio: humidity: hdc100x: fix IIO_TEMP channel reporting
To: Matt Ranostay <mranostay@gmail.com>, linux-iio@vger.kernel.org
References: <1464317706-25569-1-git-send-email-mranostay@gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <6902c38d-0b3a-9d8c-02cf-29806c195dda@kernel.org>
Date: Sun, 29 May 2016 19:46:47 +0100
MIME-Version: 1.0
In-Reply-To: <1464317706-25569-1-git-send-email-mranostay@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 27/05/16 03:55, Matt Ranostay wrote:
> IIO_TEMP channel was being incorrectly reported back as Celsius when it
> should have been milliCelsius.
> 
> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
Applied to fixes-togreg-post-rc1 and marked for stable.

Thanks,

Jonathan
> ---
>  drivers/iio/humidity/hdc100x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
> index fa47676..7e73c56 100644
> --- a/drivers/iio/humidity/hdc100x.c
> +++ b/drivers/iio/humidity/hdc100x.c
> @@ -211,7 +211,7 @@ static int hdc100x_read_raw(struct iio_dev *indio_dev,
>  		return IIO_VAL_INT_PLUS_MICRO;
>  	case IIO_CHAN_INFO_SCALE:
>  		if (chan->type == IIO_TEMP) {
> -			*val = 165;
> +			*val = 165000;
>  			*val2 = 65536 >> 2;
>  			return IIO_VAL_FRACTIONAL;
>  		} else {
> 

