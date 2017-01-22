Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40214 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750973AbdAVNRJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Jan 2017 08:17:09 -0500
Subject: Re: [PATCH] iio: industrialio-trigger: constify device_type
 structures
To: Bhumika Goyal <bhumirks@gmail.com>, julia.lawall@lip6.fr,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1485017989-22670-1-git-send-email-bhumirks@gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <def5dabb-404d-f050-386a-116575fcc0e8@kernel.org>
Date: Sun, 22 Jan 2017 13:17:06 +0000
MIME-Version: 1.0
In-Reply-To: <1485017989-22670-1-git-send-email-bhumirks@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 21/01/17 16:59, Bhumika Goyal wrote:
> Declare device_type structure as const as it is only stored in the
> type field of a device structure. This field is of type const, so add
> const to declaration of device_type structure.
> 
> File size before:
>    text	   data	    bss	    dec	    hex	filename
>    5389	    208	     48	   5645	   160d	iio/industrialio-trigger.o
> 
> File size after:
>    text	   data	    bss	    dec	    hex	filename
>    5453	    176	     48	   5677	   162d	iio/industrialio-trigger.o
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
Makes sense.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/industrialio-trigger.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
> index 978729f..3257f0e 100644
> --- a/drivers/iio/industrialio-trigger.c
> +++ b/drivers/iio/industrialio-trigger.c
> @@ -487,7 +487,7 @@ static void iio_trig_release(struct device *device)
>  	kfree(trig);
>  }
>  
> -static struct device_type iio_trig_type = {
> +static const struct device_type iio_trig_type = {
>  	.release = iio_trig_release,
>  	.groups = iio_trig_dev_groups,
>  };
> 

