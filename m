Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:52428 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752533Ab2FONd4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 15 Jun 2012 09:33:56 -0400
Message-ID: <4FDB39C2.40102@cam.ac.uk>
Date: Fri, 15 Jun 2012 14:33:54 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio:buffer: Fix NULL pointer deref caused by empty scan
 mask
References: <1339766749-5460-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1339766749-5460-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 6/15/2012 2:25 PM, Lars-Peter Clausen wrote:
> iio_scan_mask_match() returns NULL if the passed in scan mask is empty. This
> will happen if no channel has been selected and buffer is enabled.
> iio_sw_buffer_preenable() will assign NULL to indio_dev->active_scan_mask in
> this case and as a result iio_update_demux() will cause a NULL pointer deref,
> because it expects active_scan_mask to be non-NULL.
>
> Since it does not make much sense to start data capture if there is no data to
> capture this patch updates the code to fail gracefully in iio_scan_mask_match()
> instead of crashing the kernel.
oops *looks embarassed*.
>
> Signed-off-by: Lars-Peter Clausen<lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>   drivers/iio/industrialio-buffer.c |    4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index ac185b8..2f35db9 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -553,6 +553,10 @@ int iio_sw_buffer_preenable(struct iio_dev *indio_dev)
>   					    buffer->scan_mask);
>   	else
>   		indio_dev->active_scan_mask = buffer->scan_mask;
> +
> +	if (indio_dev->active_scan_mask == NULL)
> +		return -EINVAL;
> +
>   	iio_update_demux(indio_dev);
>
>   	if (indio_dev->info->update_scan_mode)

