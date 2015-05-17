Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60054 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752842AbbEQMw2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 17 May 2015 08:52:28 -0400
Message-ID: <55588F0B.8050607@kernel.org>
Date: Sun, 17 May 2015 13:52:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Dan Murphy <dmurphy@ti.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 1/3] iio: heart_monitors: Add an event for heart rate
 monitors
References: <1431374726-23383-1-git-send-email-dmurphy@ti.com> <1431374726-23383-2-git-send-email-dmurphy@ti.com>
In-Reply-To: <1431374726-23383-2-git-send-email-dmurphy@ti.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/05/15 21:05, Dan Murphy wrote:
> Add an event for heart rate monitors to signal an event
> once a heart rate measurement has been completed.
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
Not needed by the current driver.
> ---
>  drivers/iio/industrialio-core.c | 1 +
>  include/uapi/linux/iio/types.h  | 1 +
>  tools/iio/iio_event_monitor.c   | 2 ++
>  3 files changed, 4 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 4df97f6..b7b3817 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -75,6 +75,7 @@ static const char * const iio_chan_type_name_spec[] = {
>  	[IIO_ENERGY] = "energy",
>  	[IIO_DISTANCE] = "distance",
>  	[IIO_VELOCITY] = "velocity",
> +	[IIO_HEARTRATE] = "heartrate",
>  };
>  
>  static const char * const iio_modifier_names[] = {
> diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
> index 5c46019..b5e8c2f 100644
> --- a/include/uapi/linux/iio/types.h
> +++ b/include/uapi/linux/iio/types.h
> @@ -35,6 +35,7 @@ enum iio_chan_type {
>  	IIO_ENERGY,
>  	IIO_DISTANCE,
>  	IIO_VELOCITY,
> +	IIO_HEARTRATE,
>  };
>  
>  enum iio_modifier {
> diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
> index 427c271..b2cc544 100644
> --- a/tools/iio/iio_event_monitor.c
> +++ b/tools/iio/iio_event_monitor.c
> @@ -51,6 +51,7 @@ static const char * const iio_chan_type_name_spec[] = {
>  	[IIO_HUMIDITYRELATIVE] = "humidityrelative",
>  	[IIO_ACTIVITY] = "activity",
>  	[IIO_STEPS] = "steps",
> +	[IIO_HEARTRATE] = "heartrate",
>  };
>  
>  static const char * const iio_ev_type_text[] = {
> @@ -130,6 +131,7 @@ static bool event_is_known(struct iio_event_data *event)
>  	case IIO_HUMIDITYRELATIVE:
>  	case IIO_ACTIVITY:
>  	case IIO_STEPS:
> +	case IIO_HEARTRATE:
>  		break;
>  	default:
>  		return false;
> 

