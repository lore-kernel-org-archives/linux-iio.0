Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44434 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754886AbaDLR2v (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 12 Apr 2014 13:28:51 -0400
Message-ID: <53497823.2000903@kernel.org>
Date: Sat, 12 Apr 2014 18:30:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Michael Welling <mwelling@ieee.org>, linux-iio@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: Re: [PATCH 1/3] Staging: iio: Removes unwanted space before semicolon
References: <1397096805-25168-1-git-send-email-mwelling@ieee.org> <1397096805-25168-2-git-send-email-mwelling@ieee.org>
In-Reply-To: <1397096805-25168-2-git-send-email-mwelling@ieee.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/04/14 03:26, Michael Welling wrote:
> Signed-off-by: Michael Welling <mwelling@ieee.org>
Applied, though renamed to mention the fact it is in the tsl2583 driver rather than
generally across the subsystem.  Will be in the togreg branch, but I initially
push that out as testing to allow the various autobuilders to play.

Thanks,

Jonathan
> ---
>   drivers/staging/iio/light/tsl2583.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
> index 0a60def..77c7f65 100644
> --- a/drivers/staging/iio/light/tsl2583.c
> +++ b/drivers/staging/iio/light/tsl2583.c
> @@ -211,7 +211,7 @@ static int taos_get_lux(struct iio_dev *indio_dev)
>   	if (chip->taos_chip_status != TSL258X_CHIP_WORKING) {
>   		/* device is not enabled */
>   		dev_err(&chip->client->dev, "taos_get_lux device is not enabled\n");
> -		ret = -EBUSY ;
> +		ret = -EBUSY;
>   		goto out_unlock;
>   	}
>
>

