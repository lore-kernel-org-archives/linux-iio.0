Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39797 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933047Ab3AIVt1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 9 Jan 2013 16:49:27 -0500
Message-ID: <50EDE5DD.2010203@kernel.org>
Date: Wed, 09 Jan 2013 21:49:17 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 4/7] staging:iio:adis16080: be16 cleanups
References: <1357740079-12326-1-git-send-email-lars@metafoo.de> <1357740079-12326-4-git-send-email-lars@metafoo.de>
In-Reply-To: <1357740079-12326-4-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/09/2013 02:01 PM, Lars-Peter Clausen wrote:
> The sample buffer contains big endian 16bit words. So use the be16 datatype for
> the buffer and use the proper helper functions for endianness conversion instead
> of openconding it.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Hmm.. Should have read on.  Having seen this I'm going to back
out the series and wait for the fix to propogate through to Greg's
staging-next tree.  Annoying but we are fairly early in the
cycle so if I get that out to him sometime in the next few days
there should be masses of time to add this series later.

Thanks

Jonathan
> ---
>  drivers/staging/iio/gyro/adis16080_core.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/iio/gyro/adis16080_core.c b/drivers/staging/iio/gyro/adis16080_core.c
> index 6016e4c..6ff9ffc 100644
> --- a/drivers/staging/iio/gyro/adis16080_core.c
> +++ b/drivers/staging/iio/gyro/adis16080_core.c
> @@ -39,7 +39,7 @@ struct adis16080_state {
>  	struct spi_device		*us;
>  	struct mutex			buf_lock;
>  
> -	u8 buf[2] ____cacheline_aligned;
> +	__be16 buf ____cacheline_aligned;
>  };
>  
>  static int adis16080_read_sample(struct iio_dev *indio_dev,
> @@ -60,8 +60,7 @@ static int adis16080_read_sample(struct iio_dev *indio_dev,
>  	};
>  
>  	mutex_lock(&st->buf_lock);
> -	st->buf[0] = addr >> 8;
> -	st->buf[1] = addr;
> +	st->buf = cpu_to_be16(addr | ADIS16080_DIN_WRITE);
>  
>  	spi_message_init(&m);
>  	spi_message_add_tail(&t[0], &m);
> @@ -69,7 +68,7 @@ static int adis16080_read_sample(struct iio_dev *indio_dev,
>  
>  	ret = spi_sync(st->us, &m);
>  	if (ret == 0)
> -		*val = sign_extend32(12, ((st->buf[0] & 0xF) << 8) | st->buf[1]);
> +		*val = sign_extend32(12, be16_to_cpu(st->buf));
>  	mutex_unlock(&st->buf_lock);
>  
>  	return ret;
> 
