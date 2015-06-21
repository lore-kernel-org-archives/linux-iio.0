Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42755 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751320AbbFUJrE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 21 Jun 2015 05:47:04 -0400
Message-ID: <55868816.1030702@kernel.org>
Date: Sun, 21 Jun 2015 10:47:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/3] tools: iio: Add missing names to iio_event_monitor
References: <1434837152-30830-1-git-send-email-pmeerw@pmeerw.net> <1434837152-30830-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1434837152-30830-2-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/06/15 22:52, Peter Meerwald wrote:
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Applied to the togreg branch of iio.git - initially pushed out as
testing then languishing there or in togreg for a least a couple of weeks
given the merge window is about to open.

Thanks,

Jonathan
> ---
>  tools/iio/iio_event_monitor.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
> index 427c271..2a89616 100644
> --- a/tools/iio/iio_event_monitor.c
> +++ b/tools/iio/iio_event_monitor.c
> @@ -51,6 +51,9 @@ static const char * const iio_chan_type_name_spec[] = {
>  	[IIO_HUMIDITYRELATIVE] = "humidityrelative",
>  	[IIO_ACTIVITY] = "activity",
>  	[IIO_STEPS] = "steps",
> +	[IIO_ENERGY] = "energy",
> +	[IIO_DISTANCE] = "distance",
> +	[IIO_VELOCITY] = "velocity",
>  };
>  
>  static const char * const iio_ev_type_text[] = {
> @@ -99,6 +102,7 @@ static const char * const iio_modifier_names[] = {
>  	[IIO_MOD_JOGGING] = "jogging",
>  	[IIO_MOD_WALKING] = "walking",
>  	[IIO_MOD_STILL] = "still",
> +	[IIO_MOD_ROOT_SUM_SQUARED_X_Y_Z] = "sqrt(x^2+y^2+z^2)",
>  };
>  
>  static bool event_is_known(struct iio_event_data *event)
> @@ -130,6 +134,9 @@ static bool event_is_known(struct iio_event_data *event)
>  	case IIO_HUMIDITYRELATIVE:
>  	case IIO_ACTIVITY:
>  	case IIO_STEPS:
> +	case IIO_ENERGY:
> +	case IIO_DISTANCE:
> +	case IIO_VELOCITY:
>  		break;
>  	default:
>  		return false;
> @@ -167,6 +174,7 @@ static bool event_is_known(struct iio_event_data *event)
>  	case IIO_MOD_JOGGING:
>  	case IIO_MOD_WALKING:
>  	case IIO_MOD_STILL:
> +	case IIO_MOD_ROOT_SUM_SQUARED_X_Y_Z:
>  		break;
>  	default:
>  		return false;
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-iio" in
