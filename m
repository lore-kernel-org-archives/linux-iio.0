Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:50236 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932785AbdC2VL3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 29 Mar 2017 17:11:29 -0400
Subject: Re: [PATCH] iio: adc: max1363: constify attribute_group structures
To: simran singhal <singhalsimran0@gmail.com>
References: <20170328201528.GA15455@singhal-Inspiron-5558>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <2f65895f-52a8-df0f-0743-7cda5a7915dc@kernel.org>
Date: Wed, 29 Mar 2017 22:11:26 +0100
MIME-Version: 1.0
In-Reply-To: <20170328201528.GA15455@singhal-Inspiron-5558>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 28/03/17 21:15, simran singhal wrote:
> Check for attribute_group structures that are only stored in the
> event_attrs filed of iio_info structure. As the event_attrs field of
> iio_info structures is constant, so these attribute_group structures can
> also be declared constant. Done using coccinelle:
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
> x.event_attrs=&i@p;
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
>    text    data     bss     dec     hex filename
>   36951     448       0   37399    9217 drivers/iio/adc/max1363.o
> 
> File size after:
>    text	   data	    bss	    dec	    hex	filename
>   37015	    384	      0	  37399	   9217	drivers/iio/adc/max1363.o
> 
> Signed-off-by: simran singhal <singhalsimran0@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/adc/max1363.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
> index c6c12fe..80eada4 100644
> --- a/drivers/iio/adc/max1363.c
> +++ b/drivers/iio/adc/max1363.c
> @@ -1007,7 +1007,7 @@ static struct attribute *max1363_event_attributes[] = {
>  	NULL,
>  };
>  
> -static struct attribute_group max1363_event_attribute_group = {
> +static const struct attribute_group max1363_event_attribute_group = {
>  	.attrs = max1363_event_attributes,
>  };
>  
> 

