Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56532 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752280Ab3LBWI1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 2 Dec 2013 17:08:27 -0500
Message-ID: <529D04D8.5050600@kernel.org>
Date: Mon, 02 Dec 2013 22:08:24 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Axel Lin <axel.lin@ingics.com>,
	Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio:trigger: Convert to use ATTRIBUTE_GROUPS
References: <1385953044.30717.5.camel@phoenix>
In-Reply-To: <1385953044.30717.5.camel@phoenix>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/02/13 02:57, Axel Lin wrote:
> Use new ATTRIBUTE_GROUPS macro to declare attribute groups.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
Applied to the testing (and soon togreg) branch of iio.git

Thanks
> ---
>  drivers/iio/industrialio-trigger.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
> index 7ba2f00..766fab2 100644
> --- a/drivers/iio/industrialio-trigger.c
> +++ b/drivers/iio/industrialio-trigger.c
> @@ -55,15 +55,7 @@ static struct attribute *iio_trig_dev_attrs[] = {
>  	&dev_attr_name.attr,
>  	NULL,
>  };
> -
> -static struct attribute_group iio_trig_attr_group = {
> -	.attrs	= iio_trig_dev_attrs,
> -};
> -
> -static const struct attribute_group *iio_trig_attr_groups[] = {
> -	&iio_trig_attr_group,
> -	NULL
> -};
> +ATTRIBUTE_GROUPS(iio_trig_dev);
>  
>  int iio_trigger_register(struct iio_trigger *trig_info)
>  {
> @@ -403,7 +395,7 @@ static void iio_trig_release(struct device *device)
>  
>  static struct device_type iio_trig_type = {
>  	.release = iio_trig_release,
> -	.groups = iio_trig_attr_groups,
> +	.groups = iio_trig_dev_groups,
>  };
>  
>  static void iio_trig_subirqmask(struct irq_data *d)
> 
