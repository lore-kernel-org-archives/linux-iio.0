Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40899 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751674AbdDAKhR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 Apr 2017 06:37:17 -0400
Subject: Re: [PATCH] iio: humidity: hdc100x: constify attribute_group
 structures
To: simran singhal <singhalsimran0@gmail.com>
References: <20170401082333.GA3515@singhal-Inspiron-5558>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <50d31aec-2f9f-460c-a270-38fc3cf70726@kernel.org>
Date: Sat, 1 Apr 2017 11:37:15 +0100
MIME-Version: 1.0
In-Reply-To: <20170401082333.GA3515@singhal-Inspiron-5558>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/04/17 09:23, simran singhal wrote:
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
>    3459	    488	      0	   3947	    f6b	drivers/iio/humidity/hdc100x.o
> 
> File size after:
>    text	   data	    bss	    dec	    hex	filename
>    3507	    424	      0	   3931	    f5b	drivers/iio/humidity/hdc100x.o
> 
> Signed-off-by: simran singhal <singhalsimran0@gmail.com>
Applied.
> ---
>  drivers/iio/humidity/hdc100x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
> index 265c34d..aa17115 100644
> --- a/drivers/iio/humidity/hdc100x.c
> +++ b/drivers/iio/humidity/hdc100x.c
> @@ -79,7 +79,7 @@ static struct attribute *hdc100x_attributes[] = {
>  	NULL
>  };
>  
> -static struct attribute_group hdc100x_attribute_group = {
> +static const struct attribute_group hdc100x_attribute_group = {
>  	.attrs = hdc100x_attributes,
>  };
>  
> 

