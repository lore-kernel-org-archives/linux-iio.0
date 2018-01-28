Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48534 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752402AbeA1IZm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 28 Jan 2018 03:25:42 -0500
Date: Sun, 28 Jan 2018 08:25:42 +0000
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc: <linux-iio@vger.kernel.org>, <michael.hennerich@analog.com>,
        <lars@metafoo.de>
Subject: Re: [PATCH] staging: iio: ad5933: switch buffer mode to software
Message-ID: <20180128082542.440d9d7c@archlinux>
In-Reply-To: <20180125123045.29550-1-alexandru.ardelean@analog.com>
References: <20180125123045.29550-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 25 Jan 2018 14:30:45 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> Since commit 152a6a884ae1 ("staging:iio:accel:sca3000 move
> to hybrid hard / soft buffer design.")
> the buffer mechanism has changed and the
> INDIO_BUFFER_HARDWARE flag has been unused.
> 
> Since commit 2d6ca60f3284 ("iio: Add a DMAengine framework
> based buffer")
> the INDIO_BUFFER_HARDWARE flag has been re-purposed for
> DMA buffers.
> 
> This driver has lagged behind these changes, and
> in order for buffers to work, the INDIO_BUFFER_SOFTWARE
> needs to be used.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
hmm. Arguably this driver was always doing the hybrid model
and should never have been marked as a hardware buffer in 
the first place..  Anyhow, never mind.

Patch applied with the breaking commit (DMAEngine one) added
as a fixes tag and marked for stable.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/impedance-analyzer/ad5933.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
> index 3d539eeb0e26..6d31001d1825 100644
> --- a/drivers/staging/iio/impedance-analyzer/ad5933.c
> +++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
> @@ -649,8 +649,6 @@ static int ad5933_register_ring_funcs_and_init(struct iio_dev *indio_dev)
>  	/* Ring buffer functions - here trigger setup related */
>  	indio_dev->setup_ops = &ad5933_ring_setup_ops;
>  
> -	indio_dev->modes |= INDIO_BUFFER_HARDWARE;
> -
>  	return 0;
>  }
>  
> @@ -763,7 +761,7 @@ static int ad5933_probe(struct i2c_client *client,
>  	indio_dev->dev.parent = &client->dev;
>  	indio_dev->info = &ad5933_info;
>  	indio_dev->name = id->name;
> -	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->modes = (INDIO_BUFFER_SOFTWARE | INDIO_DIRECT_MODE);
>  	indio_dev->channels = ad5933_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(ad5933_channels);
>  

