Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43802 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752887AbbK2OWP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 29 Nov 2015 09:22:15 -0500
Subject: Re: [PATCH] iio: adis_buffer: Fix out-of-bounds memory access
To: Lars-Peter Clausen <lars@metafoo.de>
References: <1448632556-13005-1-git-send-email-lars@metafoo.de>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <565B0A16.80408@kernel.org>
Date: Sun, 29 Nov 2015 14:22:14 +0000
MIME-Version: 1.0
In-Reply-To: <1448632556-13005-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 27/11/15 13:55, Lars-Peter Clausen wrote:
> The SPI tx and rx buffers are both supposed to be scan_bytes amount of
> bytes large and a common allocation is used to allocate both buffers. This
> puts the beginning of the tx buffer scan_bytes bytes after the rx buffer.
> The initialization of the tx buffer pointer is done adding scan_bytes to
> the beginning of the rx buffer, but since the rx buffer is of type __be16
> this will actually add two times as much and the tx buffer ends up pointing
> after the allocated buffer.
> 
> Fix this by using scan_count, which is scan_bytes / 2, instead of
> scan_bytes when initializing the tx buffer pointer.
> 
> Fixes: aacff892cbd5 ("staging:iio:adis: Preallocate transfer message")
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to my local fixes branch - will push out once Greg has caught
up with last pull request - don't want to muddy the waters!

Jonathan
> ---
> Apologies if you got this twice, forgot the mailinglist on the first try.
> ---
>  drivers/iio/imu/adis_buffer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/adis_buffer.c b/drivers/iio/imu/adis_buffer.c
> index cb32b59..36607d5 100644
> --- a/drivers/iio/imu/adis_buffer.c
> +++ b/drivers/iio/imu/adis_buffer.c
> @@ -43,7 +43,7 @@ int adis_update_scan_mode(struct iio_dev *indio_dev,
>  		return -ENOMEM;
>  
>  	rx = adis->buffer;
> -	tx = rx + indio_dev->scan_bytes;
> +	tx = rx + scan_count;
>  
>  	spi_message_init(&adis->msg);
>  
> 

