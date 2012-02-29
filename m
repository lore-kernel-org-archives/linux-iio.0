Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44375 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755070Ab2B2UOn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 29 Feb 2012 15:14:43 -0500
Message-ID: <4F4E8778.1030309@kernel.org>
Date: Wed, 29 Feb 2012 20:15:52 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Subject: Re: [PATCH 2/3] iio: core: Avoid NULL pointer de-ref in case indio_dev->setup_ops
 are not in use
References: <1329913815-5382-1-git-send-email-michael.hennerich@analog.com> <1329913815-5382-2-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1329913815-5382-2-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/22/2012 12:30 PM, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> Drivers may not need setup_ops at all, so let the core supply
> some empty ops.
Makes sense.
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  drivers/staging/iio/industrialio-core.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
> index 82c9128..6fc1430 100644
> --- a/drivers/staging/iio/industrialio-core.c
> +++ b/drivers/staging/iio/industrialio-core.c
> @@ -800,6 +800,8 @@ static const struct file_operations iio_buffer_fileops = {
>  	.compat_ioctl = iio_ioctl,
>  };
>  
> +static const struct iio_buffer_setup_ops noop_ring_setup_ops;
> +
>  int iio_device_register(struct iio_dev *indio_dev)
>  {
>  	int ret;
> @@ -828,6 +830,10 @@ int iio_device_register(struct iio_dev *indio_dev)
>  	if (indio_dev->modes & INDIO_BUFFER_TRIGGERED)
>  		iio_device_register_trigger_consumer(indio_dev);
>  
> +	if ((indio_dev->modes & INDIO_ALL_BUFFER_MODES) &&
> +		indio_dev->setup_ops == NULL)
> +		indio_dev->setup_ops = &noop_ring_setup_ops;
> +
>  	ret = device_add(&indio_dev->dev);
>  	if (ret < 0)
>  		goto error_unreg_eventset;

