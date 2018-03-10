Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932433AbeCJQRq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 10 Mar 2018 11:17:46 -0500
Date: Sat, 10 Mar 2018 16:17:42 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Tom Lebreux <tomlebreux@cock.li>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] staging:iio:ad7152: Align arguments to match open
 parenthesis
Message-ID: <20180310161728.639a1912@archlinux>
In-Reply-To: <20180308231904.4154-1-tomlebreux@cock.li>
References: <20180308231904.4154-1-tomlebreux@cock.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu,  8 Mar 2018 18:19:04 -0500
Tom Lebreux <tomlebreux@cock.li> wrote:

> This patch fixes checkpatch.pl CHECK for alignment.
> 
> Signed-off-by: Tom Lebreux <tomlebreux@cock.li>
Applied to the togreg branch of iio.git and pushed out as
testing for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/cdc/ad7152.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/cdc/ad7152.c b/drivers/staging/iio/cdc/ad7152.c
> index 19dc896603a1..25f51db05d2d 100644
> --- a/drivers/staging/iio/cdc/ad7152.c
> +++ b/drivers/staging/iio/cdc/ad7152.c
> @@ -426,8 +426,8 @@ static int ad7152_read_raw(struct iio_dev *indio_dev,
>  }
>  
>  static int ad7152_write_raw_get_fmt(struct iio_dev *indio_dev,
> -			       struct iio_chan_spec const *chan,
> -			       long mask)
> +				    struct iio_chan_spec const *chan,
> +				    long mask)
>  {
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SCALE:
> @@ -493,7 +493,7 @@ static const struct iio_chan_spec ad7152_channels[] = {
>   */
>  
>  static int ad7152_probe(struct i2c_client *client,
> -		const struct i2c_device_id *id)
> +			const struct i2c_device_id *id)
>  {
>  	int ret = 0;
>  	struct ad7152_chip_info *chip;

