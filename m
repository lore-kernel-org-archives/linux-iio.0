Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:32882 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751447Ab3JEJ6w (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 5 Oct 2013 05:58:52 -0400
Message-ID: <524FF10C.7020608@kernel.org>
Date: Sat, 05 Oct 2013 11:59:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/8] iio:adis16080: Use spi_sync_transfer()
References: <1380959108-21775-1-git-send-email-lars@metafoo.de> <1380959108-21775-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1380959108-21775-2-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/05/13 08:45, Lars-Peter Clausen wrote:
> Use the spi_sync_transfer() helper function instead of open-coding it. Makes
> the code a bit shorter.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git

Thanks,

> ---
>  drivers/iio/gyro/adis16080.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/gyro/adis16080.c b/drivers/iio/gyro/adis16080.c
> index e9ec022..add5098 100644
> --- a/drivers/iio/gyro/adis16080.c
> +++ b/drivers/iio/gyro/adis16080.c
> @@ -51,7 +51,6 @@ static int adis16080_read_sample(struct iio_dev *indio_dev,
>  		u16 addr, int *val)
>  {
>  	struct adis16080_state *st = iio_priv(indio_dev);
> -	struct spi_message m;
>  	int ret;
>  	struct spi_transfer	t[] = {
>  		{
> @@ -66,11 +65,7 @@ static int adis16080_read_sample(struct iio_dev *indio_dev,
>  
>  	st->buf = cpu_to_be16(addr | ADIS16080_DIN_WRITE);
>  
> -	spi_message_init(&m);
> -	spi_message_add_tail(&t[0], &m);
> -	spi_message_add_tail(&t[1], &m);
> -
> -	ret = spi_sync(st->us, &m);
> +	ret = spi_sync_transfer(st->us, t, ARRAY_SIZE(t));
>  	if (ret == 0)
>  		*val = sign_extend32(be16_to_cpu(st->buf), 11);
>  
> 
