Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59379 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757101AbcIXPgb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 24 Sep 2016 11:36:31 -0400
Subject: Re: [PATCH 1/7] iio: Use kmalloc_array() in iio_scan_mask_set()
To: SF Markus Elfring <elfring@users.sourceforge.net>,
        linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <c11fbb47-1fd3-4e9e-042e-0f271cfef814@users.sourceforge.net>
 <d0db8c45-5999-6000-212a-3e8957766afb@users.sourceforge.net>
Cc: LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Julia Lawall <julia.lawall@lip6.fr>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <7d1ed0ab-f3ce-3112-a004-1540c54638fd@kernel.org>
Date: Sat, 24 Sep 2016 16:36:29 +0100
MIME-Version: 1.0
In-Reply-To: <d0db8c45-5999-6000-212a-3e8957766afb@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/09/16 07:24, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 23 Sep 2016 22:30:32 +0200
> 
> A multiplication for the size determination of a memory allocation
> indicated that an array data structure should be processed.
> Thus use the corresponding function "kmalloc_array".
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Applied to the togreg branch of iio.git - initially pushed out
as testing for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/industrialio-buffer.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 49bf9c5..7a4d9499 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -307,10 +307,9 @@ static int iio_scan_mask_set(struct iio_dev *indio_dev,
>  	const unsigned long *mask;
>  	unsigned long *trialmask;
>  
> -	trialmask = kmalloc(sizeof(*trialmask)*
> -			    BITS_TO_LONGS(indio_dev->masklength),
> -			    GFP_KERNEL);
> -
> +	trialmask = kmalloc_array(BITS_TO_LONGS(indio_dev->masklength),
> +				  sizeof(*trialmask),
> +				  GFP_KERNEL);
>  	if (trialmask == NULL)
>  		return -ENOMEM;
>  	if (!indio_dev->masklength) {
> 

