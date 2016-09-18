Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51714 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755551AbcIRTW4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Sep 2016 15:22:56 -0400
Subject: Re: [PATCH v3 1/2] iio: Implement counter channel type and info
 constants
To: William Breathitt Gray <vilhelm.gray@gmail.com>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net
References: <cover.1473950198.git.vilhelm.gray@gmail.com>
 <322dbb6459919fbe93713669f9d25cf62f95a269.1473950198.git.vilhelm.gray@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <c6e6fe2e-2d50-8f30-da2d-5310cb4f20fa@kernel.org>
Date: Sun, 18 Sep 2016 20:22:53 +0100
MIME-Version: 1.0
In-Reply-To: <322dbb6459919fbe93713669f9d25cf62f95a269.1473950198.git.vilhelm.gray@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 15/09/16 15:50, William Breathitt Gray wrote:
> Quadrature encoders, such as rotary encoders and linear encoders, are
> devices which are capable of encoding the relative position and
> direction of motion of a shaft. This patch introduces several IIO
> constants for supporting quadrature encoder counter devices.
> 
>   IIO_COUNT: Current count (main data provided by the counter device)
>   IIO_INDEX: Set high when index input is at active level
>   IIO_CHAN_INFO_PRESET: Counter preset value
> 
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
We'll see how it pans out as the driver gets revised further, but
in general I think I am happy with what we have here.

I thought hard on whether INDEX should be handled as an event.
I'm still not entirely certain, but right now I think this is
the right option.

Jonathan
> ---
>  drivers/iio/industrialio-core.c | 3 +++
>  include/linux/iio/iio.h         | 1 +
>  include/uapi/linux/iio/types.h  | 2 ++
>  3 files changed, 6 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 0528a0c..42d8c8b 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -81,6 +81,8 @@ static const char * const iio_chan_type_name_spec[] = {
>  	[IIO_PH] = "ph",
>  	[IIO_UVINDEX] = "uvindex",
>  	[IIO_ELECTRICALCONDUCTIVITY] = "electricalconductivity",
> +	[IIO_COUNT] = "count",
> +	[IIO_INDEX] = "index",
>  };
>  
>  static const char * const iio_modifier_names[] = {
> @@ -151,6 +153,7 @@ static const char * const iio_chan_info_postfix[] = {
>  	[IIO_CHAN_INFO_DEBOUNCE_TIME] = "debounce_time",
>  	[IIO_CHAN_INFO_CALIBEMISSIVITY] = "calibemissivity",
>  	[IIO_CHAN_INFO_OVERSAMPLING_RATIO] = "oversampling_ratio",
> +	[IIO_CHAN_INFO_PRESET] = "preset",
>  };
>  
>  /**
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index b4a0679..7dc86d1 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -46,6 +46,7 @@ enum iio_chan_info_enum {
>  	IIO_CHAN_INFO_DEBOUNCE_TIME,
>  	IIO_CHAN_INFO_CALIBEMISSIVITY,
>  	IIO_CHAN_INFO_OVERSAMPLING_RATIO,
> +	IIO_CHAN_INFO_PRESET,
>  };
>  
>  enum iio_shared_by {
> diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
> index 22e5e58..e54d14a 100644
> --- a/include/uapi/linux/iio/types.h
> +++ b/include/uapi/linux/iio/types.h
> @@ -40,6 +40,8 @@ enum iio_chan_type {
>  	IIO_PH,
>  	IIO_UVINDEX,
>  	IIO_ELECTRICALCONDUCTIVITY,
> +	IIO_COUNT,
> +	IIO_INDEX,
>  };
>  
>  enum iio_modifier {
> 

