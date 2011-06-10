Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:49425 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756156Ab1FJMwN (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 10 Jun 2011 08:52:13 -0400
Message-ID: <4DF21562.8040008@cam.ac.uk>
Date: Fri, 10 Jun 2011 14:00:18 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Subject: Re: [PATCH 1/2] iio: industrialio-core: Add IIO_OUT type
References: <1307706541-4750-1-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1307706541-4750-1-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/10/11 12:49, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> Add IIO_OUT type for DAC like devices
> In case of IIO_OUT make sure the channel device attribute is writable
> 
> Ideally we add a flag to iio_chan_spec that tells the core that
> the channel device attribute is writable...
That probably makes sense if / when we redo the naming again.
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  drivers/staging/iio/iio.h               |    1 +
>  drivers/staging/iio/industrialio-core.c |    4 +++-
>  2 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
> index 9ca89c7..7a6ce4d 100644
> --- a/drivers/staging/iio/iio.h
> +++ b/drivers/staging/iio/iio.h
> @@ -30,6 +30,7 @@
>  enum iio_chan_type {
>  	/* real channel types */
>  	IIO_IN,
> +	IIO_OUT,
>  	IIO_CURRENT,
>  	IIO_POWER,
>  	IIO_ACCEL,
> diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
> index 744153e..8fa2be6 100644
> --- a/drivers/staging/iio/industrialio-core.c
> +++ b/drivers/staging/iio/industrialio-core.c
> @@ -47,6 +47,7 @@ static const char * const iio_chan_type_name_spec_shared[] = {
>  	[IIO_TIMESTAMP] = "timestamp",
>  	[IIO_ACCEL] = "accel",
>  	[IIO_IN] = "in",
> +	[IIO_OUT] = "out",
>  	[IIO_CURRENT] = "current",
>  	[IIO_POWER] = "power",
>  	[IIO_IN_DIFF] = "in-in",
> @@ -675,7 +676,8 @@ static int iio_device_add_channel_sysfs(struct iio_dev *dev_info,
>  	else
>  		ret = __iio_add_chan_devattr("raw", NULL, chan,
>  					     &iio_read_channel_info,
> -					     NULL,
> +					     (chan->type == IIO_OUT ?
> +					     &iio_write_channel_info : NULL),
>  					     0,
>  					     0,
>  					     &dev_info->dev,

