Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49837 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023AbaJYTCp (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 25 Oct 2014 15:02:45 -0400
Message-ID: <544BF3D3.8010208@kernel.org>
Date: Sat, 25 Oct 2014 20:02:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@intel.com>
CC: irina.tirdea@intel.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/7] iio: core: Introduce IIO_EV_DIR_NONE
References: <1412858385-11954-1-git-send-email-daniel.baluta@intel.com> <1412858385-11954-4-git-send-email-daniel.baluta@intel.com>
In-Reply-To: <1412858385-11954-4-git-send-email-daniel.baluta@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/10/14 13:39, Daniel Baluta wrote:
> From: Irina Tirdea <irina.tirdea@intel.com>
> 
> For some events (e.g.: step detector) a direction does not make sense.
> 
> Add IIO_EV_DIR_NONE to be used with such events and generate sysfs event
> attributes that do not contain direction.
> 
> Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
Happy with this one.

J
> ---
>  drivers/iio/industrialio-event.c | 12 +++++++++---
>  include/linux/iio/types.h        |  1 +
>  2 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
> index afcf154..a9c9f34 100644
> --- a/drivers/iio/industrialio-event.c
> +++ b/drivers/iio/industrialio-event.c
> @@ -328,9 +328,15 @@ static int iio_device_add_event(struct iio_dev *indio_dev,
>  	for_each_set_bit(i, mask, sizeof(*mask)*8) {
>  		if (i >= ARRAY_SIZE(iio_ev_info_text))
>  			return -EINVAL;
> -		postfix = kasprintf(GFP_KERNEL, "%s_%s_%s",
> -				iio_ev_type_text[type], iio_ev_dir_text[dir],
> -				iio_ev_info_text[i]);
> +		if (dir != IIO_EV_DIR_NONE)
> +			postfix = kasprintf(GFP_KERNEL, "%s_%s_%s",
> +					iio_ev_type_text[type],
> +					iio_ev_dir_text[dir],
> +					iio_ev_info_text[i]);
> +		else
> +			postfix = kasprintf(GFP_KERNEL, "%s_%s",
> +					iio_ev_type_text[type],
> +					iio_ev_info_text[i]);
>  		if (postfix == NULL)
>  			return -ENOMEM;
>  
> diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
> index a08ee6c..9a1cc01 100644
> --- a/include/linux/iio/types.h
> +++ b/include/linux/iio/types.h
> @@ -87,6 +87,7 @@ enum iio_event_direction {
>  	IIO_EV_DIR_EITHER,
>  	IIO_EV_DIR_RISING,
>  	IIO_EV_DIR_FALLING,
> +	IIO_EV_DIR_NONE,
>  };
>  
>  #define IIO_VAL_INT 1
> 
