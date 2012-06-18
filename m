Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:41572 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751340Ab2FRMIj (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 18 Jun 2012 08:08:39 -0400
Message-ID: <4FDF1A43.7010701@cam.ac.uk>
Date: Mon, 18 Jun 2012 13:08:35 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 01/10] iio: iio_buffer_register: Skip channels with
 negative scan index
References: <1340019903-13305-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1340019903-13305-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 6/18/2012 12:44 PM, Lars-Peter Clausen wrote:
> It is not always the case that all channels can be used in buffered mode. This
> patch allows channels, which can not be used in buffered mode, to set their scan
> index to a negative number, which will cause iio_buffer_register to ignore the
> channel.
>
> Signed-off-by: Lars-Peter Clausen<lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
> This patch is new in v4
>
> Sorry for the extra noise, I should have noticed the problem with the ad7298
> driver earlier.
> ---
>   drivers/iio/industrialio-buffer.c |    3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 2f35db9..3d8d187 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -285,6 +285,9 @@ int iio_buffer_register(struct iio_dev *indio_dev,
>   	if (channels) {
>   		/* new magic */
>   		for (i = 0; i<  num_channels; i++) {
> +			if (channels[i].scan_index<  0)
> +				continue;
> +
>   			/* Establish necessary mask length */
>   			if (channels[i].scan_index>
>   			(int)indio_dev->masklength - 1)

