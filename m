Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56275 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755124Ab2GCUFT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 3 Jul 2012 16:05:19 -0400
Message-ID: <4FF3507E.3080002@kernel.org>
Date: Tue, 03 Jul 2012 21:05:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sascha Hauer <s.hauer@pengutronix.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: Fix unitialized use of list
References: <1341305740-17939-1-git-send-email-s.hauer@pengutronix.de>
In-Reply-To: <1341305740-17939-1-git-send-email-s.hauer@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/03/2012 09:55 AM, Sascha Hauer wrote:
> The dev_attr list is initialized in __iio_add_event_config_attrs which
> is called only when indio_dev->channels is true. Nevertheless the list
> is used unconditionally later in iio_device_register_eventset which
> results in a NULL pointer exception. To fix this unconditionally
> initialize the list in iio_device_register_eventset.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
merged to fixes. Thanks.
> ---
>  drivers/iio/industrialio-event.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
> index b49059d..fa6543b 100644
> --- a/drivers/iio/industrialio-event.c
> +++ b/drivers/iio/industrialio-event.c
> @@ -345,7 +345,6 @@ static inline int __iio_add_event_config_attrs(struct iio_dev *indio_dev)
>  {
>  	int j, ret, attrcount = 0;
>  
> -	INIT_LIST_HEAD(&indio_dev->event_interface->dev_attr_list);
>  	/* Dynically created from the channels array */
>  	for (j = 0; j < indio_dev->num_channels; j++) {
>  		ret = iio_device_add_event_sysfs(indio_dev,
> @@ -396,6 +395,8 @@ int iio_device_register_eventset(struct iio_dev *indio_dev)
>  		goto error_ret;
>  	}
>  
> +	INIT_LIST_HEAD(&indio_dev->event_interface->dev_attr_list);
> +
>  	iio_setup_ev_int(indio_dev->event_interface);
>  	if (indio_dev->info->event_attrs != NULL) {
>  		attr = indio_dev->info->event_attrs->attrs;
> 


