Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37074 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933164AbdCKShN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 11 Mar 2017 13:37:13 -0500
Subject: Re: [PATCH v1 02/10] staging: iio: ad7780: Remove exceptional & on
 function name
To: simran singhal <singhalsimran0@gmail.com>, lars@metafoo.de
References: <1489242404-12352-1-git-send-email-singhalsimran0@gmail.com>
 <1489242404-12352-3-git-send-email-singhalsimran0@gmail.com>
Cc: Michael.Hennerich@analog.com, knaack.h@gmx.de,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <3ba0e7e7-c0a2-9614-37dd-aaf184383148@kernel.org>
Date: Sat, 11 Mar 2017 18:37:10 +0000
MIME-Version: 1.0
In-Reply-To: <1489242404-12352-3-git-send-email-singhalsimran0@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/03/17 14:26, simran singhal wrote:
> Remove & from function pointers to conform to the style found elsewhere
> in the file.  Done using the following semantic patch
> 
> // <smpl>
> @r@
> identifier f;
> @@
> 
> f(...) { ... }
> @@
> identifier r.f;
> @@
> 
> - &f
> + f
> // </smpl>
> 
> Signed-off-by: simran singhal <singhalsimran0@gmail.com>
Applied.

Thanks,
> ---
>  drivers/staging/iio/adc/ad7780.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
> index e149600..dec3ba6 100644
> --- a/drivers/staging/iio/adc/ad7780.c
> +++ b/drivers/staging/iio/adc/ad7780.c
> @@ -154,7 +154,7 @@ static const struct ad7780_chip_info ad7780_chip_info_tbl[] = {
>  };
>  
>  static const struct iio_info ad7780_info = {
> -	.read_raw = &ad7780_read_raw,
> +	.read_raw = ad7780_read_raw,
>  	.driver_module = THIS_MODULE,
>  };
>  
> 

