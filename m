Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932075AbeCJOyP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 10 Mar 2018 09:54:15 -0500
Date: Sat, 10 Mar 2018 14:54:10 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Cc: linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        Jon.Brenner@ams.com
Subject: Re: [PATCH 11/12] staging: iio: tsl2x7x: remove unnecessary sysfs
 attribute
Message-ID: <20180310145410.3dac7025@archlinux>
In-Reply-To: <20180304014942.18727-12-masneyb@onstation.org>
References: <20180304014942.18727-1-masneyb@onstation.org>
        <20180304014942.18727-12-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat,  3 Mar 2018 20:49:41 -0500
Brian Masney <masneyb@onstation.org> wrote:

> The tsl2771 and tmd2771 devices create the
> in_proximity0_calibscale_available sysfs attribute. These two particular
> devices do not support changing the proximity gain value on the
> chip so this patch removes that sysfs attribute. As expected, these two
> devices already did not create the IIO_CHAN_INFO_CALIBSCALE channel and
> proximity0_calibrate sysfs attribute.
> 
> Page 38 of the tsl2772 data sheet shows that the proximity gain can be
> adjusted with bits 2-3 on the control register:
> https://ams.com/eng/content/download/291503/1066377/file/TSL2772_DS000181_2-00.pdf
> 
> Page 35 of the tsl2771 and tmd2771 data sheets shows that bits 2-3 on
> the control register are reserved and changing the proximity gain is
> not supported:
> https://ams.com/eng/content/download/250264/976045/file/TSL2771_DS000105_3-00.pdf
> https://ams.com/eng/content/download/250283/976077/file/TMD2771_DS000177_2-00.pdf
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
This one applied without the previous so I have done so.

Applied.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/light/tsl2x7x.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index fb91c46c8747..8c29a52153c1 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -1477,7 +1477,6 @@ static struct attribute *tsl2x7x_ALSPRX_device_attrs[] = {
>  	&dev_attr_in_illuminance0_target_input.attr,
>  	&dev_attr_in_illuminance0_calibrate.attr,
>  	&dev_attr_in_illuminance0_lux_table.attr,
> -	&iio_const_attr_in_proximity0_calibscale_available.dev_attr.attr,
>  	NULL
>  };
>  

