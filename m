Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:36189 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751262AbaKFQEM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 6 Nov 2014 11:04:12 -0500
Received: by mail-wg0-f42.google.com with SMTP id k14so1564987wgh.29
        for <linux-iio@vger.kernel.org>; Thu, 06 Nov 2014 08:04:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1415287106-13491-1-git-send-email-dmurphy@ti.com>
References: <1415287106-13491-1-git-send-email-dmurphy@ti.com>
Date: Thu, 6 Nov 2014 18:04:11 +0200
Message-ID: <CAEnQRZBRASQZVtG2FYxy54k7LOeECnwoLARdGmLLjE5+PkYO-w@mail.gmail.com>
Subject: Re: [RFC v2 1/3] iio: heart_monitors: Add support for heart rate monitors
From: Daniel Baluta <daniel.baluta@intel.com>
To: Dan Murphy <dmurphy@ti.com>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Karol Wrona <k.wrona@samsung.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Dan,

Use iio: heart_monitor instead of iio: heart_monitors in subject.

On Thu, Nov 6, 2014 at 5:18 PM, Dan Murphy <dmurphy@ti.com> wrote:
> Add a type for heart rate monitors
> Add the modifier name in beats per minute.
>
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>
> v2 - Updated per v1 comments - http://marc.info/?l=linux-iio&m=141331404232216&w=2
>
>  Documentation/ABI/testing/sysfs-bus-iio               | 7 +++++++
>  drivers/iio/industrialio-core.c                       | 1 +
>  drivers/staging/iio/Documentation/iio_event_monitor.c | 2 ++
>  include/linux/iio/types.h                             | 3 ++-
>  4 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index d760b02..bf95808 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -1028,3 +1028,10 @@ Contact: linux-iio@vger.kernel.org
>  Description:
>                 Raw value of rotation from true/magnetic north measured with
>                 or without compensation from tilt sensors.
> +
> +What:          /sys/bus/iio/devices/iio:deviceX/in_rot_from_north_magnetic_tilt_comp_raw
> +KernelVersion: 3.19
> +Contact:       linux-iio@vger.kernel.org
> +Description:
> +               Raw value of rotation from true/magnetic north measured with
> +               or without compensation from tilt sensors.

Something went wrong here. This should be about
heart rate monitor not  rotation from true/magnetic north.

> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index af3e76d..e332a18 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -70,6 +70,7 @@ static const char * const iio_chan_type_name_spec[] = {
>         [IIO_CCT] = "cct",
>         [IIO_PRESSURE] = "pressure",
>         [IIO_HUMIDITYRELATIVE] = "humidityrelative",
> +       [IIO_HEARTRATE] = "heartrate",
>  };
>
>  static const char * const iio_modifier_names[] = {
> diff --git a/drivers/staging/iio/Documentation/iio_event_monitor.c b/drivers/staging/iio/Documentation/iio_event_monitor.c
> index 569d6f8..90a655d 100644
> --- a/drivers/staging/iio/Documentation/iio_event_monitor.c
> +++ b/drivers/staging/iio/Documentation/iio_event_monitor.c
> @@ -49,6 +49,7 @@ static const char * const iio_chan_type_name_spec[] = {
>         [IIO_CCT] = "cct",
>         [IIO_PRESSURE] = "pressure",
>         [IIO_HUMIDITYRELATIVE] = "humidityrelative",
> +       [IIO_HEARTRATE] = "heartrate"
>  };

Please, don't forget the comma after "heartrate".

>
>  static const char * const iio_ev_type_text[] = {
> @@ -108,6 +109,7 @@ static bool event_is_known(struct iio_event_data *event)
>         case IIO_CCT:
>         case IIO_PRESSURE:
>         case IIO_HUMIDITYRELATIVE:
> +       case IIO_HEARTRATE:
>                 break;
>         default:
>                 return false;
> diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
> index 4a2af8a..f22b9d6 100644
> --- a/include/linux/iio/types.h
> +++ b/include/linux/iio/types.h
> @@ -30,6 +30,7 @@ enum iio_chan_type {
>         IIO_CCT,
>         IIO_PRESSURE,
>         IIO_HUMIDITYRELATIVE,
> +       IIO_HEARTRATE,
>  };
>
>  enum iio_modifier {
> @@ -59,7 +60,7 @@ enum iio_modifier {
>         IIO_MOD_NORTH_MAGN,
>         IIO_MOD_NORTH_TRUE,
>         IIO_MOD_NORTH_MAGN_TILT_COMP,
> -       IIO_MOD_NORTH_TRUE_TILT_COMP
> +       IIO_MOD_NORTH_TRUE_TILT_COMP,

You shouldn't care about this now. Hopefully, the comma will be fixed
by the next person that adds an iio_modifier.

>  };
>
>  enum iio_event_type {
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
