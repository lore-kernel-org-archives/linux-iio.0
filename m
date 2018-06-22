Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:9125 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754291AbeFVRPv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 22 Jun 2018 13:15:51 -0400
Date: Fri, 22 Jun 2018 18:15:23 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Mathieu Othacehe <m.othacehe@gmail.com>
CC: <linux-iio@vger.kernel.org>, <pierre-moana.levesque@parrot.com>
Subject: Re: [PATCH 1/2] iio: Add channel for Phase
Message-ID: <20180622181523.000070f7@huawei.com>
In-Reply-To: <1529403409-15179-1-git-send-email-m.othacehe@gmail.com>
References: <1529403409-15179-1-git-send-email-m.othacehe@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 19 Jun 2018 12:16:48 +0200
Mathieu Othacehe <m.othacehe@gmail.com> wrote:

> Add new channel type support for phase.
> 
> This channel may be used by Time-of-flight sensors to express the
> phase difference between emitted and received signals. Those sensor
> will then use the phase shift of return signals to approximate the
> distance to objects.
> 
> Signed-off-by: Mathieu Othacehe <m.othacehe@gmail.com>
Looks good.  Will pick up once the user is ready.

Jonathan

> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 7 +++++++
>  drivers/iio/industrialio-core.c         | 1 +
>  include/uapi/linux/iio/types.h          | 1 +
>  tools/iio/iio_event_monitor.c           | 2 ++
>  4 files changed, 11 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 731146c..e0ff2b7 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -1663,3 +1663,10 @@ KernelVersion:	4.12
>  Contact:	linux-iio@vger.kernel.org
>  Description:
>  		Raw counter device counters direction for channel Y.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_phaseY_raw
> +KernelVersion:	4.18
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Raw (unscaled) phase difference reading from channel Y
> +		that can be processed to radians.
> \ No newline at end of file
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 19bdf3d..34333de 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -85,6 +85,7 @@ static const char * const iio_chan_type_name_spec[] = {
>  	[IIO_COUNT] = "count",
>  	[IIO_INDEX] = "index",
>  	[IIO_GRAVITY]  = "gravity",
> +	[IIO_PHASE] = "phase",
>  };
>  
>  static const char * const iio_modifier_names[] = {
> diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
> index 4213cdf..6252a0b 100644
> --- a/include/uapi/linux/iio/types.h
> +++ b/include/uapi/linux/iio/types.h
> @@ -44,6 +44,7 @@ enum iio_chan_type {
>  	IIO_COUNT,
>  	IIO_INDEX,
>  	IIO_GRAVITY,
> +	IIO_PHASE,
>  };
>  
>  enum iio_modifier {
> diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
> index b61245e..34190f4 100644
> --- a/tools/iio/iio_event_monitor.c
> +++ b/tools/iio/iio_event_monitor.c
> @@ -58,6 +58,7 @@ static const char * const iio_chan_type_name_spec[] = {
>  	[IIO_PH] = "ph",
>  	[IIO_UVINDEX] = "uvindex",
>  	[IIO_GRAVITY] = "gravity",
> +	[IIO_PHASE] = "phase",
>  };
>  
>  static const char * const iio_ev_type_text[] = {
> @@ -151,6 +152,7 @@ static bool event_is_known(struct iio_event_data *event)
>  	case IIO_PH:
>  	case IIO_UVINDEX:
>  	case IIO_GRAVITY:
> +	case IIO_PHASE:
>  		break;
>  	default:
>  		return false;


