Return-Path: <jic23@jic23.retrosnub.co.uk>
Message-ID: <543ECC6E.708@jic23.retrosnub.co.uk>
Date: Wed, 15 Oct 2014 20:35:10 +0100
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
MIME-Version: 1.0
To: Dan Murphy <dmurphy@ti.com>, linux-iio@vger.kernel.org
CC: jic23@kernel.org
Subject: Re: [RFC Patch 1/3] iio: heart_monitors: Add support for heart rate
 monitors
References: <1413314032-923-1-git-send-email-dmurphy@ti.com> <1413314032-923-2-git-send-email-dmurphy@ti.com>
In-Reply-To: <1413314032-923-2-git-send-email-dmurphy@ti.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 14/10/14 20:13, Dan Murphy wrote:
> Add a type for heart rate monitors
> Add the modifier name in beats per minute.
The heart rate type is probably fine.  The modifier is unnecessary as
we simply define heartrate to be in beats per minute.  Modifiers
are used to distinguish things like direction or colour, not to
specify units.

Beats per minute is a little clunky from a general units point of
view, but I can see that beats per second seems a little silly here.

The issue is generality as there are plenty of other sources of
rate signals.  Clearly we would like equivalent base units for all
of them to avoid confusion.  To that end I wonder if it is
worth the slightly unusual option of beats per second here on
the basis any userspace util can easily multiply by 60.

Also, when introducing a new type - updating
Documentation/ABI/testing/sysfs-bus-iio is both useful in explaining
the use of the ABI and as documentation going forward.

Jonathan
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>  drivers/iio/industrialio-core.c                    |    2 ++
>  .../staging/iio/Documentation/iio_event_monitor.c  |    2 ++
>  include/linux/iio/types.h                          |    4 +++-
>  3 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index af3e76d..d87ca35 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -70,6 +70,7 @@ static const char * const iio_chan_type_name_spec[] = {
>  	[IIO_CCT] = "cct",
>  	[IIO_PRESSURE] = "pressure",
>  	[IIO_HUMIDITYRELATIVE] = "humidityrelative",
> +	[IIO_HEARTRATE] = "heartrate",
>  };
>  
>  static const char * const iio_modifier_names[] = {
> @@ -91,6 +92,7 @@ static const char * const iio_modifier_names[] = {
>  	[IIO_MOD_NORTH_TRUE] = "from_north_true",
>  	[IIO_MOD_NORTH_MAGN_TILT_COMP] = "from_north_magnetic_tilt_comp",
>  	[IIO_MOD_NORTH_TRUE_TILT_COMP] = "from_north_true_tilt_comp",
> +	[IIO_MOD_HEART_BPM] = "heartrate_beats_per_minute",
>  };
>  
>  /* relies on pairs of these shared then separate */
> diff --git a/drivers/staging/iio/Documentation/iio_event_monitor.c b/drivers/staging/iio/Documentation/iio_event_monitor.c
> index 569d6f8..b06dab7 100644
> --- a/drivers/staging/iio/Documentation/iio_event_monitor.c
> +++ b/drivers/staging/iio/Documentation/iio_event_monitor.c
> @@ -49,6 +49,7 @@ static const char * const iio_chan_type_name_spec[] = {
>  	[IIO_CCT] = "cct",
>  	[IIO_PRESSURE] = "pressure",
>  	[IIO_HUMIDITYRELATIVE] = "humidityrelative",
> +	[IIO_HEARTRATE] = "heartrate"
>  };
>  
>  static const char * const iio_ev_type_text[] = {
> @@ -108,6 +109,7 @@ static bool event_is_known(struct iio_event_data *event)
>  	case IIO_CCT:
>  	case IIO_PRESSURE:
>  	case IIO_HUMIDITYRELATIVE:
> +	case IIO_MOD_HEART_BPM:
>  		break;
>  	default:
>  		return false;
> diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
> index 4a2af8a..50b1456 100644
> --- a/include/linux/iio/types.h
> +++ b/include/linux/iio/types.h
> @@ -30,6 +30,7 @@ enum iio_chan_type {
>  	IIO_CCT,
>  	IIO_PRESSURE,
>  	IIO_HUMIDITYRELATIVE,
> +	IIO_HEARTRATE
>  };
>  
>  enum iio_modifier {
> @@ -59,7 +60,8 @@ enum iio_modifier {
>  	IIO_MOD_NORTH_MAGN,
>  	IIO_MOD_NORTH_TRUE,
>  	IIO_MOD_NORTH_MAGN_TILT_COMP,
> -	IIO_MOD_NORTH_TRUE_TILT_COMP
> +	IIO_MOD_NORTH_TRUE_TILT_COMP,
> +	IIO_MOD_HEART_BPM
>  };
>  
>  enum iio_event_type {
> 
