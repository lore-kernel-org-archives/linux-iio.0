Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:40341 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751717AbaGTOyn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 20 Jul 2014 10:54:43 -0400
Message-ID: <53CBD8BF.40207@kernel.org>
Date: Sun, 20 Jul 2014 15:57:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/4] iio: buffer: Fix demux table creation
References: <1405612789-27964-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1405612789-27964-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 17/07/14 16:59, Lars-Peter Clausen wrote:
> When creating the demux table we need to iterate over the selected scan mask for
> the buffer to get the samples which should be copied to destination buffer.
> Right now the code uses the mask which contains all active channels, which means
> the demux table contains entries which causes it to copy all the samples from
> source to destination buffer one by one without doing any demuxing.
>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Ouch.  Applied to the fixes-togreg branch of iio.git and marked
for stable.

How we managed to fail to see the effects of this is beyond me.
I guess the fact that the timestamp is handled separately made
it quite a bit less obvious than it otherwise would have been.

Thanks,

Jonathan
> ---
>   drivers/iio/industrialio-buffer.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 2952ee0..0472ee2 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -963,7 +963,7 @@ static int iio_buffer_update_demux(struct iio_dev *indio_dev,
>
>   	/* Now we have the two masks, work from least sig and build up sizes */
>   	for_each_set_bit(out_ind,
> -			 indio_dev->active_scan_mask,
> +			 buffer->scan_mask,
>   			 indio_dev->masklength) {
>   		in_ind = find_next_bit(indio_dev->active_scan_mask,
>   				       indio_dev->masklength,
>

