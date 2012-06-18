Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41626 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751185Ab2FRHkp (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 18 Jun 2012 03:40:45 -0400
Message-ID: <4FDEDB7B.7080703@kernel.org>
Date: Mon, 18 Jun 2012 08:40:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio staging: fix typos in tsl*: register
References: <1339952599-22105-1-git-send-email-pmeerw@pmeerw.net> <1339952599-22105-3-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1339952599-22105-3-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 6/17/2012 6:03 PM, Peter Meerwald wrote:
Nothing like copy and paste for repeating errors ;)
> Signed-off-by: Peter Meerwald<pmeerw@pmeerw.net>
Acked-by: Jonathan Cameron <jic23@kernel.org>

Thanks for these Peter.  I like short patches I can reviews whilst 
drinking a coffee :)
> ---
>   drivers/staging/iio/light/tsl2583.c      |    2 +-
>   drivers/staging/iio/light/tsl2x7x_core.c |    2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
> index 5e23ad5..6d2f4c6 100644
> --- a/drivers/staging/iio/light/tsl2583.c
> +++ b/drivers/staging/iio/light/tsl2583.c
> @@ -410,7 +410,7 @@ static int taos_chip_on(struct iio_dev *indio_dev)
>   		return -EINVAL;
>   	}
>
> -	/* determine als integration regster */
> +	/* determine als integration register */
>   	als_count = (chip->taos_settings.als_time * 100 + 135) / 270;
>   	if (als_count == 0)
>   		als_count = 1; /* ensure at least one cycle */
> diff --git a/drivers/staging/iio/light/tsl2x7x_core.c b/drivers/staging/iio/light/tsl2x7x_core.c
> index 040da4a..fdf75e4 100644
> --- a/drivers/staging/iio/light/tsl2x7x_core.c
> +++ b/drivers/staging/iio/light/tsl2x7x_core.c
> @@ -736,7 +736,7 @@ static int tsl2x7x_chip_on(struct iio_dev *indio_dev)
>   		return -EINVAL;
>   	}
>
> -	/* determine als integration regster */
> +	/* determine als integration register */
>   	als_count = (chip->tsl2x7x_settings.als_time * 100 + 135) / 270;
>   	if (als_count == 0)
>   		als_count = 1; /* ensure at least one cycle */

