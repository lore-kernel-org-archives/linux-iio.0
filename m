Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46070 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753791AbaAAMrR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 1 Jan 2014 07:47:17 -0500
Message-ID: <52C40E53.1040906@kernel.org>
Date: Wed, 01 Jan 2014 12:47:15 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [RFC]iio:industrialio-event fix error-handling in iio_device_add_event
References: <52C00D75.70302@gmx.de>
In-Reply-To: <52C00D75.70302@gmx.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


On 29/12/13 11:54, Hartmut Knaack wrote:
> __iio_add_chan_devattr returns -EBUSY, when registering the event-interface of
> ad799x, but iio_device_add_event does not catch it. So, handle it like in
> iio_device_add_info_mask_type. Not sure, if this is the right solution, but it
> makes the ad799x (and possibly others as well) usable.
>
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
I think the fix is correct, but I'm not entirely sure what is triggering 
the bug in this particular driver. All of the elements of ad799x_events 
are in mask separate so shared_by should be IIO_SEPARATE for all calls 
to this function.

Lars, any idea's on what Hartmut is hitting?
Also, is the below patch as valid as it appears at first glance?

> ---
> diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
> index c10eab6..d37a907 100644
> --- a/drivers/iio/industrialio-event.c
> +++ b/drivers/iio/industrialio-event.c
> @@ -362,7 +362,9 @@ static int iio_device_add_event(struct iio_dev *indio_dev,
>   			&indio_dev->event_interface->dev_attr_list);
>   		kfree(postfix);
>
> -		if (ret)
> +		if ((ret == -EBUSY) && (shared_by != IIO_SEPARATE))
> +			continue;
> +		else if (ret < 0)
>   			return ret;
>
>   		attrcount++;
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
