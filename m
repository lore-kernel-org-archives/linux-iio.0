Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:50195 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932727AbdC2VF5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 29 Mar 2017 17:05:57 -0400
Subject: Re: [PATCH] iio: light: lm3533-als: constify attribute_group
 structures
To: simran singhal <singhalsimran0@gmail.com>
References: <20170328202559.GA25974@singhal-Inspiron-5558>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <f3ec1efd-dccd-6ffd-8a8b-651a6d284735@kernel.org>
Date: Wed, 29 Mar 2017 22:05:52 +0100
MIME-Version: 1.0
In-Reply-To: <20170328202559.GA25974@singhal-Inspiron-5558>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 28/03/17 21:25, simran singhal wrote:
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
>    5798    2376       0    8174    1fee drivers/iio/light/lm3533-als.o
> 
> File size after:
>    text	   data	    bss	    dec	    hex	filename
>    5862	   2312	      0	   8174	   1fee	drivers/iio/light/lm3533-als.o
> 
> Signed-off-by: simran singhal <singhalsimran0@gmail.com>
It's a good patch, but when you were checking it made sense did you
notice any related changes that should also be made?

See inline.  I'd like to see both in the same patch rather than two micro
patches..
> ---
>  drivers/iio/light/lm3533-als.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/lm3533-als.c b/drivers/iio/light/lm3533-als.c
> index f409c20..0bcc843 100644
> --- a/drivers/iio/light/lm3533-als.c
> +++ b/drivers/iio/light/lm3533-als.c
> @@ -690,7 +690,7 @@ static struct attribute *lm3533_als_event_attributes[] = {
>  	NULL
>  };
>  
> -static struct attribute_group lm3533_als_event_attribute_group = {
> +static const struct attribute_group lm3533_als_event_attribute_group = {
>  	.attrs = lm3533_als_event_attributes
>  };
When this gets used it is in a block that looks like:
static const struct iio_info lm3533_als_info = {
	.attrs		= &lm3533_als_attribute_group,
	.event_attrs	= &lm3533_als_event_attribute_group,
	.driver_module	= THIS_MODULE,
	.read_raw	= &lm3533_als_read_raw,
};

This would make me wonder if the issue being improved on might be
repeated as we have two attr groups and hopefully the author was consistent!

A quick search gives:

static struct attribute_group lm3533_als_attribute_group = {
	.attrs = lm3533_als_attributes
};

Also could be made const as both are const in struct iio_dev now.

I wouldn't mind so much, but the patch title kind of hints that it
is covering all attribute_group structures, whereas you only
looked at one of the two present.

If you wouldn't mind doing a v2 (noting that coccinelle patch presented
presumably only found one of them), that includes both. That would great.

Thanks

Jonathan

>  
> 

