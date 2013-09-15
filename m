Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53270 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757024Ab3IOPyj (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 15 Sep 2013 11:54:39 -0400
Message-ID: <5235E65D.4040700@kernel.org>
Date: Sun, 15 Sep 2013 17:54:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: Fix tcs3472 buffer size
References: <5234CB23.3050902@kernel.org> <1379260356-25851-1-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1379260356-25851-1-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/15/13 16:52, Peter Meerwald wrote:
> and drop obsolete #define
> 
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Oops, applied to the togreg branch of iio.git

Thanks for the fast fix up.
> ---
>  drivers/iio/light/tcs3472.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/light/tcs3472.c b/drivers/iio/light/tcs3472.c
> index 95510bd..dc7d823 100644
> --- a/drivers/iio/light/tcs3472.c
> +++ b/drivers/iio/light/tcs3472.c
> @@ -55,12 +55,9 @@ struct tcs3472_data {
>  	u8 enable;
>  	u8 control;
>  	u8 atime;
> -	u16 buffer[4];
> +	u16 buffer[8]; /* 4 16-bit channels + 64-bit timestamp */
>  };
>  
> -/* 4 16-bit channels + timestamp = 16 bytes */
> -#define TSL3472_BUFFER_SIZE 16
> -
>  #define TCS3472_CHANNEL(_color, _si, _addr) { \
>  	.type = IIO_INTENSITY, \
>  	.modified = 1, \
> 
