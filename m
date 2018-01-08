Return-Path: <SRS0=2D9W=ED=oracle.com=dan.carpenter@kernel.org>
Date: Mon, 8 Jan 2018 14:48:43 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: George Edward Bulmer <gebulmer@googlemail.com>
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org, lars@metafoo.de,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmeerw@pmeerw.net, knaack.h@gmx.de, jic23@kernel.org
Subject: Re: [PATCH] staging: iio: light: Add breaks to lengthy lines
Message-ID: <20180108114843.burtlxsfarp3uqlp@mwanda>
References: <20180107150801.21617-1-gebulmer@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180107150801.21617-1-gebulmer@googlemail.com>
List-ID: <linux-iio@vger.kernel.org>

On Sun, Jan 07, 2018 at 03:08:01PM +0000, George Edward Bulmer wrote:
> This fixes three instances of checkpatch warning:
> WARNING: line over 80 characters
> 
> Signed-off-by: George Edward Bulmer <gebulmer@googlemail.com>
> ---
>  drivers/staging/iio/light/tsl2x7x.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index 42ed9c015aaf..126e11530ce0 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -1441,7 +1441,8 @@ static irqreturn_t tsl2x7x_event_handler(int irq, void *private)
>  
>  static struct attribute *tsl2x7x_ALS_device_attrs[] = {
>  	&dev_attr_in_illuminance0_calibscale_available.attr,
> -	&iio_const_attr_in_illuminance0_integration_time_available.dev_attr.attr,
> +	&iio_const_attr_in_illuminance0_integration_time_available
> +		.dev_attr.attr,

Ugh.  No.  The original was better.

regards,
dan carpenter
