Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49145 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753061AbcJOQpi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 15 Oct 2016 12:45:38 -0400
Subject: Re: [PATCH 01/18] staging:iio:accel:sca3000 Fix a use before setting
 of the indio_dev->buffer pointer.
To: linux-iio@vger.kernel.org
References: <20161008163918.18758-1-jic23@kernel.org>
 <20161008163918.18758-2-jic23@kernel.org>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <339603dd-61df-1f68-a4bb-5d72f3a28116@kernel.org>
Date: Sat, 15 Oct 2016 17:45:36 +0100
MIME-Version: 1.0
In-Reply-To: <20161008163918.18758-2-jic23@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/10/16 17:39, Jonathan Cameron wrote:
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Jonathan
> ---
>  drivers/staging/iio/accel/sca3000_ring.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/accel/sca3000_ring.c b/drivers/staging/iio/accel/sca3000_ring.c
> index d1cb9b9cf22b..e5de52d05a5c 100644
> --- a/drivers/staging/iio/accel/sca3000_ring.c
> +++ b/drivers/staging/iio/accel/sca3000_ring.c
> @@ -270,8 +270,8 @@ int sca3000_configure_ring(struct iio_dev *indio_dev)
>  		return -ENOMEM;
>  	indio_dev->modes |= INDIO_BUFFER_HARDWARE;
>  
> -	indio_dev->buffer->access = &sca3000_ring_access_funcs;
>  
> +	buffer->access = &sca3000_ring_access_funcs;
>  	iio_device_attach_buffer(indio_dev, buffer);
>  
>  	return 0;
> 

