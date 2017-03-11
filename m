Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37092 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754075AbdCKSjm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 11 Mar 2017 13:39:42 -0500
Subject: Re: [PATCH v1 03/10] staging: iio: cdc: ad7746: Remove exceptional &
 on function name
To: simran singhal <singhalsimran0@gmail.com>, lars@metafoo.de
References: <1489242404-12352-1-git-send-email-singhalsimran0@gmail.com>
 <1489242404-12352-4-git-send-email-singhalsimran0@gmail.com>
Cc: Michael.Hennerich@analog.com, knaack.h@gmx.de,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <ce2f8b03-25dd-31d8-65c3-832613092022@kernel.org>
Date: Sat, 11 Mar 2017 18:39:39 +0000
MIME-Version: 1.0
In-Reply-To: <1489242404-12352-4-git-send-email-singhalsimran0@gmail.com>
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

It's a little unobvious that other function pointers in this
one don't have the & as they are only used via macros.

However, I'm in general in favour of the change so don't
really care that much!

Jonathan
> ---
>  drivers/staging/iio/cdc/ad7746.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
> index 81f8b9e..6294de7 100644
> --- a/drivers/staging/iio/cdc/ad7746.c
> +++ b/drivers/staging/iio/cdc/ad7746.c
> @@ -664,8 +664,8 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
>  
>  static const struct iio_info ad7746_info = {
>  	.attrs = &ad7746_attribute_group,
> -	.read_raw = &ad7746_read_raw,
> -	.write_raw = &ad7746_write_raw,
> +	.read_raw = ad7746_read_raw,
> +	.write_raw = ad7746_write_raw,
>  	.driver_module = THIS_MODULE,
>  };
>  
> 

