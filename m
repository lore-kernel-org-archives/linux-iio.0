Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:50261 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933024AbdC2VN3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 29 Mar 2017 17:13:29 -0400
Subject: Re: [PATCH] iio: adc: ad799x: constify attribute_group structures
To: simran singhal <singhalsimran0@gmail.com>, lars@metafoo.de
References: <20170328200745.GA8033@singhal-Inspiron-5558>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <6eb0038d-ac22-99be-2aee-b29284bdadf3@kernel.org>
Date: Wed, 29 Mar 2017 22:13:26 +0100
MIME-Version: 1.0
In-Reply-To: <20170328200745.GA8033@singhal-Inspiron-5558>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 28/03/17 21:07, simran singhal wrote:
> Check for attribute_group structures that are only stored in the
> event_attrs filed of iio_info structure. As the event_attrs field of
> iio_info structures is constant, so these attribute_group structures can
> also be declared constant.
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
>   26051     464       0   26515    6793 drivers/iio/adc/ad799x.o
> 
> File size after:
>    text	   data	    bss	    dec	    hex	filename
>   26115	    400	      0	  26515	   6793	drivers/iio/adc/ad799x.o
> 
> Signed-off-by: simran singhal <singhalsimran0@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/adc/ad799x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
> index 9704090..22426ae 100644
> --- a/drivers/iio/adc/ad799x.c
> +++ b/drivers/iio/adc/ad799x.c
> @@ -520,7 +520,7 @@ static struct attribute *ad799x_event_attributes[] = {
>  	NULL,
>  };
>  
> -static struct attribute_group ad799x_event_attrs_group = {
> +static const struct attribute_group ad799x_event_attrs_group = {
>  	.attrs = ad799x_event_attributes,
>  };
>  
> 

