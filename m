Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37187 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755409AbdCKSsa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 11 Mar 2017 13:48:30 -0500
Subject: Re: [PATCH v1 10/10] staging: iio: gyro: Remove exceptional & on
 function name
To: simran singhal <singhalsimran0@gmail.com>, lars@metafoo.de
References: <1489242404-12352-1-git-send-email-singhalsimran0@gmail.com>
 <1489242404-12352-11-git-send-email-singhalsimran0@gmail.com>
Cc: Michael.Hennerich@analog.com, knaack.h@gmx.de,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <563954e3-76f4-d563-1328-3525d15ffdff@kernel.org>
Date: Sat, 11 Mar 2017 18:48:26 +0000
MIME-Version: 1.0
In-Reply-To: <1489242404-12352-11-git-send-email-singhalsimran0@gmail.com>
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
Again, I couldn't identify any other function pointers in this file
so have amended the patch description to reflect that.

I also added a note that will hopefully prevent anyone seeing
this patch deciding to send me the several hundred patches it
'might' - I haven't checked - take to clean up the whole subsystem.

Thanks for the whole series.

Applied to the togreg branhc of iio.git and pushed out as testing.

Jonathan
> ---
>  drivers/staging/iio/gyro/adis16060_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/gyro/adis16060_core.c b/drivers/staging/iio/gyro/adis16060_core.c
> index ab816a2..c9d46e7 100644
> --- a/drivers/staging/iio/gyro/adis16060_core.c
> +++ b/drivers/staging/iio/gyro/adis16060_core.c
> @@ -117,7 +117,7 @@ static int adis16060_read_raw(struct iio_dev *indio_dev,
>  }
>  
>  static const struct iio_info adis16060_info = {
> -	.read_raw = &adis16060_read_raw,
> +	.read_raw = adis16060_read_raw,
>  	.driver_module = THIS_MODULE,
>  };
>  
> 

