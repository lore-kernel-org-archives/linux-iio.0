Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:58540 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756207Ab1EKP45 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 11 May 2011 11:56:57 -0400
Message-ID: <4DCA7E90.1000803@cam.ac.uk>
Date: Wed, 11 May 2011 13:18:24 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: linux-iio@vger.kernel.org, drivers@analog.com,
	device-drivers-devel@blackfin.uclinux.org
Subject: Re: [PATCH 2/2] IIO-work: Add channel types IIO_CURRENT and IIO_POWER
References: <1305115119-8850-1-git-send-email-michael.hennerich@analog.com> <1305115119-8850-2-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1305115119-8850-2-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/11/11 12:58, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> Add channel types IIO_CURRENT and IIO_POWER.
> This is required for the ADE7758 driver cleanup.
Will slot this one in right before the ade7758 patches.
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  drivers/staging/iio/iio.h               |    2 ++
>  drivers/staging/iio/industrialio-core.c |    2 ++
>  2 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
> index d9f2692..80a81d4 100644
> --- a/drivers/staging/iio/iio.h
> +++ b/drivers/staging/iio/iio.h
> @@ -30,6 +30,8 @@
>  enum iio_chan_type {
>  	/* real channel types */
>  	IIO_IN,
> +	IIO_CURRENT,
> +	IIO_POWER,
>  	IIO_ACCEL,
>  	IIO_IN_DIFF,
>  	IIO_GYRO,
> diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
> index faa34af..9218fee 100644
> --- a/drivers/staging/iio/industrialio-core.c
> +++ b/drivers/staging/iio/industrialio-core.c
> @@ -47,6 +47,8 @@ static const char * const iio_chan_type_name_spec_shared[] = {
>  	[IIO_TIMESTAMP] = "timestamp",
>  	[IIO_ACCEL] = "accel",
>  	[IIO_IN] = "in",
> +	[IIO_CURRENT] = "current",
> +	[IIO_POWER] = "power",
>  	[IIO_IN_DIFF] = "in-in",
>  	[IIO_GYRO] = "gyro",
>  	[IIO_TEMP] = "temp",

