Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40865 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751446AbdDAKbn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 Apr 2017 06:31:43 -0400
Subject: Re: [PATCH] iio: light: bh1750: constify attribute_group structures
To: simran singhal <singhalsimran0@gmail.com>
References: <20170401083330.GA14189@singhal-Inspiron-5558>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <0e777993-747d-ea9f-581a-ccd6a08e5e23@kernel.org>
Date: Sat, 1 Apr 2017 11:31:41 +0100
MIME-Version: 1.0
In-Reply-To: <20170401083330.GA14189@singhal-Inspiron-5558>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/04/17 09:33, simran singhal wrote:
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
>    2276	    352	      0	   2628	    a44	drivers/iio/light/bh1750.o
> 
> File size after:
>    text	   data	    bss	    dec	    hex	filename
>    2340	    320	      0	   2660	    a64	drivers/iio/light/bh1750.o
> 
> Signed-off-by: simran singhal <singhalsimran0@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.
(I'll get lazy in a mo and just put applied ;)

Jonathan
> ---
>  drivers/iio/light/bh1750.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/bh1750.c b/drivers/iio/light/bh1750.c
> index b059466..6c61187 100644
> --- a/drivers/iio/light/bh1750.c
> +++ b/drivers/iio/light/bh1750.c
> @@ -212,7 +212,7 @@ static struct attribute *bh1750_attributes[] = {
>  	NULL,
>  };
>  
> -static struct attribute_group bh1750_attribute_group = {
> +static const struct attribute_group bh1750_attribute_group = {
>  	.attrs = bh1750_attributes,
>  };
>  
> 

