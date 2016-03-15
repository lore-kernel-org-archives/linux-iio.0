Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35346 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932826AbcCOWJb (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 15 Mar 2016 18:09:31 -0400
Subject: Re: [PATCH] tools: iio: Update iio_event_monitor names
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <1458078891-17859-1-git-send-email-pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56E8881A.6050201@kernel.org>
Date: Tue, 15 Mar 2016 22:09:30 +0000
MIME-Version: 1.0
In-Reply-To: <1458078891-17859-1-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 15/03/16 21:54, Peter Meerwald-Stadler wrote:
> add recently added channel types and modifiers
> 
> Signed-off-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Straight forward so applied to the togreg branch of iio.git.
Pushed out as testing for the autobuilders to ignore it.
Come to think of it, I should suggest that builds of tools are
done for patches that touch them...

Jonathan
> ---
>  tools/iio/iio_event_monitor.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
> index d51eb04..90980f5 100644
> --- a/tools/iio/iio_event_monitor.c
> +++ b/tools/iio/iio_event_monitor.c
> @@ -53,6 +53,9 @@ static const char * const iio_chan_type_name_spec[] = {
>  	[IIO_ENERGY] = "energy",
>  	[IIO_DISTANCE] = "distance",
>  	[IIO_VELOCITY] = "velocity",
> +	[IIO_CONCENTRATION] = "concentration",
> +	[IIO_RESISTANCE] = "resistance",
> +	[IIO_PH] = "ph",
>  };
>  
>  static const char * const iio_ev_type_text[] = {
> @@ -102,6 +105,10 @@ static const char * const iio_modifier_names[] = {
>  	[IIO_MOD_WALKING] = "walking",
>  	[IIO_MOD_STILL] = "still",
>  	[IIO_MOD_ROOT_SUM_SQUARED_X_Y_Z] = "sqrt(x^2+y^2+z^2)",
> +	[IIO_MOD_I] = "i",
> +	[IIO_MOD_Q] = "q",
> +	[IIO_MOD_CO2] = "co2",
> +	[IIO_MOD_VOC] = "voc",
>  };
>  
>  static bool event_is_known(struct iio_event_data *event)
> @@ -136,6 +143,9 @@ static bool event_is_known(struct iio_event_data *event)
>  	case IIO_ENERGY:
>  	case IIO_DISTANCE:
>  	case IIO_VELOCITY:
> +	case IIO_CONCENTRATION:
> +	case IIO_RESISTANCE:
> +	case IIO_PH:
>  		break;
>  	default:
>  		return false;
> @@ -174,6 +184,10 @@ static bool event_is_known(struct iio_event_data *event)
>  	case IIO_MOD_WALKING:
>  	case IIO_MOD_STILL:
>  	case IIO_MOD_ROOT_SUM_SQUARED_X_Y_Z:
> +	case IIO_MOD_I:
> +	case IIO_MOD_Q:
> +	case IIO_MOD_CO2:
> +	case IIO_MOD_VOC:
>  		break;
>  	default:
>  		return false;
> 

