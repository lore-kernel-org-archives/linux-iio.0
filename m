Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43845 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753619AbbFUNYw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 21 Jun 2015 09:24:52 -0400
Message-ID: <5586BB22.9030104@kernel.org>
Date: Sun, 21 Jun 2015 14:24:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: Add missing modifier names to core
References: <1434837152-30830-1-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1434837152-30830-1-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/06/15 22:52, Peter Meerwald wrote:
> some are documented, others are in iio_event_monitor.c which
> was recently moved from staging
> 
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
This is legacy of the older event description stuff that typically
only used these codes for exporting to userspace (they weren't used
to build attribute names).  Given how we do it now, they can
be used (particularly for enable attributes) so we do indeed need the whole
set.

Applied to the togreg branch of iio.git

Thanks,

Jonathan
> ---
>  drivers/iio/industrialio-core.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 4df97f6..f3bf00c 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -81,6 +81,14 @@ static const char * const iio_modifier_names[] = {
>  	[IIO_MOD_X] = "x",
>  	[IIO_MOD_Y] = "y",
>  	[IIO_MOD_Z] = "z",
> +	[IIO_MOD_X_AND_Y] = "x&y",
> +	[IIO_MOD_X_AND_Z] = "x&z",
> +	[IIO_MOD_Y_AND_Z] = "y&z",
> +	[IIO_MOD_X_AND_Y_AND_Z] = "x&y&z",
> +	[IIO_MOD_X_OR_Y] = "x|y",
> +	[IIO_MOD_X_OR_Z] = "x|z",
> +	[IIO_MOD_Y_OR_Z] = "y|z",
> +	[IIO_MOD_X_OR_Y_OR_Z] = "x|y|z",
>  	[IIO_MOD_ROOT_SUM_SQUARED_X_Y] = "sqrt(x^2+y^2)",
>  	[IIO_MOD_SUM_SQUARED_X_Y_Z] = "x^2+y^2+z^2",
>  	[IIO_MOD_LIGHT_BOTH] = "both",
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-iio" in
