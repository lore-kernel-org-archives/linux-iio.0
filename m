Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56209 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751445Ab2GCUAS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 3 Jul 2012 16:00:18 -0400
Message-ID: <4FF34F50.40502@kernel.org>
Date: Tue, 03 Jul 2012 21:00:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] iio staging: add recently added modifiers to iio_event_monitor
References: <1341138013-28267-1-git-send-email-pmeerw@pmeerw.net> <1341138013-28267-4-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1341138013-28267-4-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/01/2012 11:20 AM, Peter Meerwald wrote:
> maybe iio_modifier_names and iio_chan_type_name_spec should be
> exported from industrialio-core instead?
gah, I clean forgot this existed.

Cc Lars-Peter on patches to this, but I have merged as
I can't see anything controversial here (or have I spoken too soon!)
> 
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
merged
> ---
>  .../staging/iio/Documentation/iio_event_monitor.c  |   12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/staging/iio/Documentation/iio_event_monitor.c b/drivers/staging/iio/Documentation/iio_event_monitor.c
> index 4326e9e..3a9b000 100644
> --- a/drivers/staging/iio/Documentation/iio_event_monitor.c
> +++ b/drivers/staging/iio/Documentation/iio_event_monitor.c
> @@ -68,6 +68,12 @@ static const char * const iio_modifier_names[] = {
>  	[IIO_MOD_Z] = "z",
>  	[IIO_MOD_LIGHT_BOTH] = "both",
>  	[IIO_MOD_LIGHT_IR] = "ir",
> +	[IIO_MOD_ROOT_SUM_SQUARED_X_Y] = "sqrt(x^2+y^2)",
> +	[IIO_MOD_SUM_SQUARED_X_Y_Z] = "x^2+y^2+z^2",
> +	[IIO_MOD_LIGHT_CLEAR] = "clear",
> +	[IIO_MOD_LIGHT_RED] = "red",
> +	[IIO_MOD_LIGHT_GREEN] = "green",
> +	[IIO_MOD_LIGHT_BLUE] = "blue",
>  };
>  
>  static bool event_is_known(struct iio_event_data *event)
> @@ -106,6 +112,12 @@ static bool event_is_known(struct iio_event_data *event)
>  	case IIO_MOD_Z:
>  	case IIO_MOD_LIGHT_BOTH:
>  	case IIO_MOD_LIGHT_IR:
> +	case IIO_MOD_ROOT_SUM_SQUARED_X_Y:
> +	case IIO_MOD_SUM_SQUARED_X_Y_Z:
> +	case IIO_MOD_LIGHT_CLEAR:
> +	case IIO_MOD_LIGHT_RED:
> +	case IIO_MOD_LIGHT_GREEN:
> +	case IIO_MOD_LIGHT_BLUE:
>  		break;
>  	default:
>  		return false;
> 


