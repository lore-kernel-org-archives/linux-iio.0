Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:49020 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751410Ab2FFJRJ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 6 Jun 2012 05:17:09 -0400
Message-ID: <4FCF2011.4030206@cam.ac.uk>
Date: Wed, 06 Jun 2012 10:17:05 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: srinivas pandruvada <srinivas.pandruvada@intel.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH,] IIO: Add additional modifier names
References: <1338508298-21748-1-git-send-email-srinivas.pandruvada@intel.com>
In-Reply-To: <1338508298-21748-1-git-send-email-srinivas.pandruvada@intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 6/1/2012 12:51 AM, srinivas pandruvada wrote:
> Added additional modifier names in the list for the supported
> types. Otherwise it substitutes (null) in the filename.
>
> Signed-off-by: srinivas pandruvada<srinivas.pandruvada@intel.com>

When we originally introducted the concept of these, the intent was
to have rather more explicit naming. Hence
[IIO_MOD_X_AND_Y_AND_Z] = "x&y&z",
[IIO_MOD_X_OR_Y_OR_Z] = "x|y|z",

It costs a small amount of effort in escape characters, but
gives a much more meaningful naming to the resulting attributes.

They aren't there in the core code because nothing using chan_spec
based registration was using these (they were needed for modifiers of
rather obscure events).  What have you actually needed them for?


Jonathan
> ---
>   drivers/staging/iio/industrialio-core.c |    8 ++++++++
>   1 files changed, 8 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
> index d303bfb..65d40ce 100644
> --- a/drivers/staging/iio/industrialio-core.c
> +++ b/drivers/staging/iio/industrialio-core.c
> @@ -76,6 +76,14 @@ static const char * const iio_modifier_names[] = {
>   	[IIO_MOD_Z] = "z",
>   	[IIO_MOD_LIGHT_BOTH] = "both",
>   	[IIO_MOD_LIGHT_IR] = "ir",
> +	[IIO_MOD_X_AND_Y] = "xy",
> +	[IIO_MOD_X_AND_Z] = "xz",
> +	[IIO_MOD_Y_AND_Z] = "yz",
> +	[IIO_MOD_X_AND_Y_AND_Z] = "xyz",
> +	[IIO_MOD_X_OR_Y] = "x_y",
> +	[IIO_MOD_X_OR_Z] = "x_z",
> +	[IIO_MOD_Y_OR_Z] = "y_z",
> +	[IIO_MOD_X_OR_Y_OR_Z] = "x_y_z",
>   };
>
>   /* relies on pairs of these shared then separate */

