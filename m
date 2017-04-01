Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40935 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751856AbdDAKlI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 Apr 2017 06:41:08 -0400
Subject: Re: [PATCH] staging: iio: light: constify attribute_group structures
To: simran singhal <singhalsimran0@gmail.com>
References: <20170401022856.GA9305@singhal-Inspiron-5558>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <277e5ae4-5154-547a-147c-9fee105ba5a6@kernel.org>
Date: Sat, 1 Apr 2017 11:41:06 +0100
MIME-Version: 1.0
In-Reply-To: <20170401022856.GA9305@singhal-Inspiron-5558>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/04/17 03:28, simran singhal wrote:
> As the event_attrs field of iio_info structures is constant, so these
> attribute_group structures can also be declared constant.
> 
> File size before:
>    text	   data	    bss	    dec	    hex	filename
>   15064	   1528	      0	  16592	   40d0
> drivers/staging/iio/light/tsl2x7x_core.o
> 
> File size after:
>    text	   data	    bss	    dec	    hex	filename
>   15192	   1400	      0	  16592	   40d0
> drivers/staging/iio/light/tsl2x7x_core.o
> 
> Signed-off-by: simran singhal <singhalsimran0@gmail.com>
Not a big thing, but as this only touches the one driver, i would have
liked that mentioned in the naming of the patch...

I've added it.
Applied.
> ---
>  drivers/staging/iio/light/tsl2x7x_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x_core.c b/drivers/staging/iio/light/tsl2x7x_core.c
> index 0490c1d..9a0046a 100644
> --- a/drivers/staging/iio/light/tsl2x7x_core.c
> +++ b/drivers/staging/iio/light/tsl2x7x_core.c
> @@ -1676,7 +1676,7 @@ static const struct attribute_group tsl2X7X_device_attr_group_tbl[] = {
>  	},
>  };
>  
> -static struct attribute_group tsl2X7X_event_attr_group_tbl[] = {
> +static const struct attribute_group tsl2X7X_event_attr_group_tbl[] = {
>  	[ALS] = {
>  		.attrs = tsl2X7X_ALS_event_attrs,
>  		.name = "events",
> 

