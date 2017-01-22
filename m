Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40234 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751125AbdAVNTd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Jan 2017 08:19:33 -0500
Subject: Re: [PATCH] iio: adc: constify iio_info structures
To: Bhumika Goyal <bhumirks@gmail.com>, julia.lawall@lip6.fr,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1485018180-22799-1-git-send-email-bhumirks@gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <3eb33e08-61d3-131c-4807-103fcee653ac@kernel.org>
Date: Sun, 22 Jan 2017 13:19:31 +0000
MIME-Version: 1.0
In-Reply-To: <1485018180-22799-1-git-send-email-bhumirks@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 21/01/17 17:03, Bhumika Goyal wrote:
> Declare iio_info structures as const as they are only stored in
> the info field of a iio_dev structure. This field is of type const,
> so iio_info structures having similar properties can be made const too.
> 
> File size before:
>    text	   data	    bss	    dec	    hex	filename
>    6944	    792	      0	   7736	   1e38	drivers/iio/adc/ti-ads1015.o
> 
> File size after:
>    text   data	    bss	    dec	    hex	filename
>    7264	    472	      0	   7736	   1e38	drivers/iio/adc/ti-ads1015.o
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
Good find.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/adc/ti-ads1015.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
> index cde6f13..422b314 100644
> --- a/drivers/iio/adc/ti-ads1015.c
> +++ b/drivers/iio/adc/ti-ads1015.c
> @@ -472,14 +472,14 @@ static const struct attribute_group ads1115_attribute_group = {
>  	.attrs = ads1115_attributes,
>  };
>  
> -static struct iio_info ads1015_info = {
> +static const struct iio_info ads1015_info = {
>  	.driver_module	= THIS_MODULE,
>  	.read_raw	= ads1015_read_raw,
>  	.write_raw	= ads1015_write_raw,
>  	.attrs          = &ads1015_attribute_group,
>  };
>  
> -static struct iio_info ads1115_info = {
> +static const struct iio_info ads1115_info = {
>  	.driver_module	= THIS_MODULE,
>  	.read_raw	= ads1015_read_raw,
>  	.write_raw	= ads1015_write_raw,
> 

