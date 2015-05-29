Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:40921 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755736AbbE2IrN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 29 May 2015 04:47:13 -0400
Date: Fri, 29 May 2015 10:47:11 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Kevin Tsai <ktsai@capellamicro.com>
cc: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Irina Tirdea <irina.tirdea@intel.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Reyad Attiyat <reyad.attiyat@gmail.com>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/1] iio: Add iio_mod_light_uva, iio_mod_light_uvb, and
 iio_mod_light_uvc.
In-Reply-To: <1432886683-7467-1-git-send-email-ktsai@capellamicro.com>
Message-ID: <alpine.DEB.2.02.1505291042520.16730@pmeerw.net>
References: <1432886683-7467-1-git-send-email-ktsai@capellamicro.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 29 May 2015, Kevin Tsai wrote:

> Add Ultraviolet(UV) support:
> UVA: 315 ~ 400 nm
> UVB: 280 ~ 315 nm
> UVC: 100 ~ 280 nm

for what sensor chip do you intend this addition?

I'm working on support for the Si1132 which exposes an UV Index measure, 
see http://www.silabs.com/Support%20Documents/TechnicalDocs/Si1132.pdf

I just want to bring it up so we can plan how to support UV...
 
> Signed-off-by: Kevin Tsai <ktsai@capellamicro.com>
> ---
>  drivers/iio/industrialio-core.c | 3 +++
>  include/uapi/linux/iio/types.h  | 3 +++
>  tools/iio/iio_event_monitor.c   | 6 ++++++
>  3 files changed, 12 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 3524b0d..ecbdd1e 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -89,6 +89,9 @@ static const char * const iio_modifier_names[] = {
>  	[IIO_MOD_LIGHT_RED] = "red",
>  	[IIO_MOD_LIGHT_GREEN] = "green",
>  	[IIO_MOD_LIGHT_BLUE] = "blue",
> +	[IIO_MOD_LIGHT_UVA] = "uva",
> +	[IIO_MOD_LIGHT_UVB] = "uvb",
> +	[IIO_MOD_LIGHT_UVC] = "uvc",
>  	[IIO_MOD_QUATERNION] = "quaternion",
>  	[IIO_MOD_TEMP_AMBIENT] = "ambient",
>  	[IIO_MOD_TEMP_OBJECT] = "object",
> diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
> index 2f8b117..5c99090 100644
> --- a/include/uapi/linux/iio/types.h
> +++ b/include/uapi/linux/iio/types.h
> @@ -72,6 +72,9 @@ enum iio_modifier {
>  	IIO_MOD_ROOT_SUM_SQUARED_X_Y_Z,
>  	IIO_MOD_I,
>  	IIO_MOD_Q,
> +	IIO_MOD_LIGHT_UVA,
> +	IIO_MOD_LIGHT_UVB,
> +	IIO_MOD_LIGHT_UVC,
>  };
>  
>  enum iio_event_type {
> diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
> index 427c271..46dd27f 100644
> --- a/tools/iio/iio_event_monitor.c
> +++ b/tools/iio/iio_event_monitor.c
> @@ -88,6 +88,9 @@ static const char * const iio_modifier_names[] = {
>  	[IIO_MOD_LIGHT_RED] = "red",
>  	[IIO_MOD_LIGHT_GREEN] = "green",
>  	[IIO_MOD_LIGHT_BLUE] = "blue",
> +	[IIO_MOD_LIGHT_UVA] = "uva",
> +	[IIO_MOD_LIGHT_UVB] = "uvb",
> +	[IIO_MOD_LIGHT_UVC] = "uvc",
>  	[IIO_MOD_QUATERNION] = "quaternion",
>  	[IIO_MOD_TEMP_AMBIENT] = "ambient",
>  	[IIO_MOD_TEMP_OBJECT] = "object",
> @@ -156,6 +159,9 @@ static bool event_is_known(struct iio_event_data *event)
>  	case IIO_MOD_LIGHT_RED:
>  	case IIO_MOD_LIGHT_GREEN:
>  	case IIO_MOD_LIGHT_BLUE:
> +	case IIO_MOD_LIGHT_UVA:
> +	case IIO_MOD_LIGHT_UVB:
> +	case IIO_MOD_LIGHT_UVC:
>  	case IIO_MOD_QUATERNION:
>  	case IIO_MOD_TEMP_AMBIENT:
>  	case IIO_MOD_TEMP_OBJECT:
> 

-- 

Peter Meerwald
+43-664-2444418 (mobile)
