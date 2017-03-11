Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37097 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933384AbdCKSkL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 11 Mar 2017 13:40:11 -0500
Subject: Re: [PATCH v1 04/10] staging: iio: cdc: ad7152: Remove exceptional &
 on function name
To: simran singhal <singhalsimran0@gmail.com>, lars@metafoo.de
References: <1489242404-12352-1-git-send-email-singhalsimran0@gmail.com>
 <1489242404-12352-5-git-send-email-singhalsimran0@gmail.com>
Cc: Michael.Hennerich@analog.com, knaack.h@gmx.de,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <7c2e327d-a060-cbb3-ed22-388593729657@kernel.org>
Date: Sat, 11 Mar 2017 18:40:09 +0000
MIME-Version: 1.0
In-Reply-To: <1489242404-12352-5-git-send-email-singhalsimran0@gmail.com>
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
> ---
>  drivers/staging/iio/cdc/ad7152.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/cdc/ad7152.c b/drivers/staging/iio/cdc/ad7152.c
> index e8609b8..59ef93c 100644
> --- a/drivers/staging/iio/cdc/ad7152.c
> +++ b/drivers/staging/iio/cdc/ad7152.c
> @@ -441,9 +441,9 @@ static int ad7152_write_raw_get_fmt(struct iio_dev *indio_dev,
>  
>  static const struct iio_info ad7152_info = {
>  	.attrs = &ad7152_attribute_group,
> -	.read_raw = &ad7152_read_raw,
> -	.write_raw = &ad7152_write_raw,
> -	.write_raw_get_fmt = &ad7152_write_raw_get_fmt,
> +	.read_raw = ad7152_read_raw,
> +	.write_raw = ad7152_write_raw,
> +	.write_raw_get_fmt = ad7152_write_raw_get_fmt,
>  	.driver_module = THIS_MODULE,
>  };
>  
> 

