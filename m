Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:49428 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751014AbaGKURW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 11 Jul 2014 16:17:22 -0400
Message-ID: <53C046D8.5070500@kernel.org>
Date: Fri, 11 Jul 2014 21:19:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio:core: Handle error when mask type is not separate
References: <1404853414-9263-1-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1404853414-9263-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/07/14 22:03, Srinivas Pandruvada wrote:
> When event spec is shared by multiple channels, which has definition
> for mask_shared_by_type, iio_device_register_eventset fails.
>
> For example:
> static const struct iio_event_spec iio_dummy_events[] = {
> 	{
> 		.type = IIO_EV_TYPE_THRESH,
> 		.dir = IIO_EV_DIR_RISING,
> 		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
> 		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE),
> 	}, {
> 		.type = IIO_EV_TYPE_THRESH,
> 		.dir = IIO_EV_DIR_FALLING,
> 		.mask_separate = BIT(IIO_EV_INFO_ENABLE),a
> 		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE),
> 	}
> };
>
> If two channels use this event spec, this will result in error.
>
> This change handles EBUSY error similar to iio_device_add_info_mask_type().
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Good spot.  Applied to the fixes-togreg branch of iio.git and marked
for stable.  Grep suggests there is only one user in the tree (lis3l02dq)
but still worth getting the fix out there for that one.

J
> ---
>   drivers/iio/industrialio-event.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
> index 258a973..bfbf4d4 100644
> --- a/drivers/iio/industrialio-event.c
> +++ b/drivers/iio/industrialio-event.c
> @@ -345,6 +345,9 @@ static int iio_device_add_event(struct iio_dev *indio_dev,
>   			&indio_dev->event_interface->dev_attr_list);
>   		kfree(postfix);
>
> +		if ((ret == -EBUSY) && (shared_by != IIO_SEPARATE))
> +			continue;
> +
>   		if (ret)
>   			return ret;
>
>

