Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48560 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753161AbcJOOv3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 15 Oct 2016 10:51:29 -0400
Subject: Re: [PATCH] iio: accel: mma8452: claim direct mode during raw reads
To: Alison Schofield <amsfield22@gmail.com>
References: <20161011193127.GA8708@d830.WORKGROUP>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <caa2c0c2-1ef7-15e8-cd1c-e0d6c7da1c81@kernel.org>
Date: Sat, 15 Oct 2016 15:50:42 +0100
MIME-Version: 1.0
In-Reply-To: <20161011193127.GA8708@d830.WORKGROUP>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/10/16 20:31, Alison Schofield wrote:
> Driver was checking for direct mode but not locking it.  Use
> claim/release helper functions to guarantee the device stays
> in direct mode during raw reads.
> 
> Signed-off-by: Alison Schofield <amsfield22@gmail.com>
Applied to the togreg branch of iio.git and pushed out as
testing for the autobuilders to play with it.

Hohum. Amazing how often we used to get this rather obvious
thing wrong ;)

Thanks,

Jonathan
> ---
>  drivers/iio/accel/mma8452.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index 6e82e02..cbbc746 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -459,12 +459,14 @@ static int mma8452_read_raw(struct iio_dev *indio_dev,
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> -		if (iio_buffer_enabled(indio_dev))
> -			return -EBUSY;
> +		ret = iio_device_claim_direct_mode(indio_dev);
> +		if (ret)
> +			return ret;
>  
>  		mutex_lock(&data->lock);
>  		ret = mma8452_read(data, buffer);
>  		mutex_unlock(&data->lock);
> +		iio_device_release_direct_mode(indio_dev);
>  		if (ret < 0)
>  			return ret;
>  
> 

