Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46950 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750724Ab3JLKow (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 12 Oct 2013 06:44:52 -0400
Message-ID: <52593650.3020605@kernel.org>
Date: Sat, 12 Oct 2013 12:45:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 09/20] staging:iio:lis2l02dq: Share threshold value
 between axis
References: <1381155094-20166-1-git-send-email-lars@metafoo.de> <1381155094-20166-9-git-send-email-lars@metafoo.de>
In-Reply-To: <1381155094-20166-9-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/07/13 15:11, Lars-Peter Clausen wrote:
> The threshold event can be enabled/disabled separately, but the threshold value
> is shared between all three axis.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Build fix applied as below.
> ---
>  drivers/staging/iio/accel/lis3l02dq_core.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/lis3l02dq_core.c b/drivers/staging/iio/accel/lis3l02dq_core.c
> index 78187f1..b2d1dfa 100644
> --- a/drivers/staging/iio/accel/lis3l02dq_core.c
> +++ b/drivers/staging/iio/accel/lis3l02dq_core.c
> @@ -518,13 +518,13 @@ static const struct iio_event_spec lis3l02dq_event[] = {
>  	{
>  		.type = IIO_EV_TYPE_THRESH,
>  		.dir = IIO_EV_DIR_RISING,
> -		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
> -			BIT(IIO_EV_INFO_ENABLE),
> +		.mask_separate = BIT(IIO_EV_INFO_ENABLE);
semicolons?
> +		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE);
>  	}, {
>  		.type = IIO_EV_TYPE_THRESH,
>  		.dir = IIO_EV_DIR_FALLING,
> -		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
> -			BIT(IIO_EV_INFO_ENABLE),
> +		.mask_separate = BIT(IIO_EV_INFO_ENABLE);
> +		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE);
>  	}
>  };
>  
> 
