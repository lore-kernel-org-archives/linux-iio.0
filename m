Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37333 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751438AbdBSMA4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Feb 2017 07:00:56 -0500
Subject: Re: [PATCH 4/8] iio: max30100: Set parent device
To: Lars-Peter Clausen <lars@metafoo.de>
References: <1486816461-28618-1-git-send-email-lars@metafoo.de>
 <1486816461-28618-5-git-send-email-lars@metafoo.de>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <569c1271-6cb4-a4a4-4075-2cf605d6b33d@kernel.org>
Date: Sun, 19 Feb 2017 12:00:00 +0000
MIME-Version: 1.0
In-Reply-To: <1486816461-28618-5-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/02/17 12:34, Lars-Peter Clausen wrote:
> Initialize the parent of the IIO device to the device that registered it.
> This makes sure that the IIO device appears the right level in the device
> hierarchy.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/health/max30100.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/health/max30100.c b/drivers/iio/health/max30100.c
> index 9648c69..10b3e0d 100644
> --- a/drivers/iio/health/max30100.c
> +++ b/drivers/iio/health/max30100.c
> @@ -449,6 +449,7 @@ static int max30100_probe(struct i2c_client *client,
>  	indio_dev->available_scan_masks = max30100_scan_masks;
>  	indio_dev->modes = (INDIO_BUFFER_SOFTWARE | INDIO_DIRECT_MODE);
>  	indio_dev->setup_ops = &max30100_buffer_setup_ops;
> +	indio_dev->dev.parent = &client->dev;
>  
>  	data = iio_priv(indio_dev);
>  	data->indio_dev = indio_dev;
> 

