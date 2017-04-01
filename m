Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40895 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751420AbdDAKgf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 Apr 2017 06:36:35 -0400
Subject: Re: [PATCH] iio: light: apds9960: constify attribute_group structures
To: simran singhal <singhalsimran0@gmail.com>
References: <20170401082910.GA10374@singhal-Inspiron-5558>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <b777e298-b4fc-0614-b799-07bd52ec5354@kernel.org>
Date: Sat, 1 Apr 2017 11:36:33 +0100
MIME-Version: 1.0
In-Reply-To: <20170401082910.GA10374@singhal-Inspiron-5558>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/04/17 09:29, simran singhal wrote:
> Check for attribute_group structures that are only stored in the
> attrs filed of iio_info structure. As the attrs field of iio_info
> structures is constant, so these attribute_group structures can also be
> declared constant.
> Done using coccinelle:
> 
> @r1 disable optional_qualifier @
> identifier i;
> position p;
> @@
> static struct attribute_group i@p = {...};
> 
> @ok1@
> identifier r1.i;
> position p;
> struct iio_info x;
> @@
> x.attrs=&i@p;
> 
> @bad@
> position p!={r1.p,ok1.p};
> identifier r1.i;
> @@
> i@p
> 
> @depends on !bad disable optional_qualifier@
> identifier r1.i;
> @@
> static
> +const
> struct attribute_group i={...};
> 
> @depends on !bad disable optional_qualifier@
> identifier r1.i;
> @@
> +const
> struct attribute_group i;
> 
> File size before:
>    text	   data	    bss	    dec	    hex	filename
>    8503	    488	      0	   8991	   231f	drivers/iio/light/apds9960.o
> 
> File size after:
>    text	   data	    bss	    dec	    hex	filename
>    8567	    424	      0	   8991	   231f	drivers/iio/light/apds9960.o
> 
> Signed-off-by: simran singhal <singhalsimran0@gmail.com>
Applied.
> ---
>  drivers/iio/light/apds9960.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
> index 90bc98d..c7af36d 100644
> --- a/drivers/iio/light/apds9960.c
> +++ b/drivers/iio/light/apds9960.c
> @@ -343,7 +343,7 @@ static struct attribute *apds9960_attributes[] = {
>  	NULL,
>  };
>  
> -static struct attribute_group apds9960_attribute_group = {
> +static const struct attribute_group apds9960_attribute_group = {
>  	.attrs = apds9960_attributes,
>  };
>  
> 

