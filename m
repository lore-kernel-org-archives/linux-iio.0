Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:50831 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750823Ab1GONTV (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 15 Jul 2011 09:19:21 -0400
Message-ID: <4E203E5A.2050408@cam.ac.uk>
Date: Fri, 15 Jul 2011 14:19:22 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Subject: Re: [PATCH 1/2] iio: core: deconstify members of struct iio_chan_spec
References: <1310734743-2623-1-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1310734743-2623-1-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/15/11 13:59, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> Allow dynamic allocation and population of channel spec.
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  drivers/staging/iio/iio.h |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
> index 7a6ce4d..a9d7730 100644
> --- a/drivers/staging/iio/iio.h
> +++ b/drivers/staging/iio/iio.h
> @@ -121,9 +121,9 @@ struct iio_chan_spec {
>  		u8	storagebits;
>  		u8	shift;
>  	} scan_type;
> -	const long		info_mask;
> -	const long		event_mask;
> -	const char		*extend_name;
> +	long			info_mask;
> +	long			event_mask;
> +	char			*extend_name;
>  	unsigned		processed_val:1;
>  	unsigned		modified:1;
>  	unsigned		indexed:1;

