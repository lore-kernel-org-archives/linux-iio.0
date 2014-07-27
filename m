Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:55948 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752551AbaG0SLH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 27 Jul 2014 14:11:07 -0400
Message-ID: <53D5414A.6080007@kernel.org>
Date: Sun, 27 Jul 2014 19:13:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/4] iio: buffer: Use roundup() instead of open-coding
 it
References: <1405612789-27964-1-git-send-email-lars@metafoo.de> <1405612789-27964-3-git-send-email-lars@metafoo.de>
In-Reply-To: <1405612789-27964-3-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 17/07/14 16:59, Lars-Peter Clausen wrote:
> Makes the code slightly shorter and a bit easier to understand.
>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Indeed, a sensible cleanup.

Applied to the togreg branch of iio.git

Thanks,

J
> ---
>   drivers/iio/industrialio-buffer.c | 16 +++++-----------
>   1 file changed, 5 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 6da5272..5063703 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -979,9 +979,7 @@ static int iio_buffer_update_demux(struct iio_dev *indio_dev,
>   			else
>   				length = ch->scan_type.storagebits / 8;
>   			/* Make sure we are aligned */
> -			in_loc += length;
> -			if (in_loc % length)
> -				in_loc += length - in_loc % length;
> +			in_loc = roundup(in_loc, length) + length;
>   		}
>   		p = kmalloc(sizeof(*p), GFP_KERNEL);
>   		if (p == NULL) {
> @@ -994,10 +992,8 @@ static int iio_buffer_update_demux(struct iio_dev *indio_dev,
>   				ch->scan_type.repeat;
>   		else
>   			length = ch->scan_type.storagebits / 8;
> -		if (out_loc % length)
> -			out_loc += length - out_loc % length;
> -		if (in_loc % length)
> -			in_loc += length - in_loc % length;
> +		out_loc = roundup(out_loc, length);
> +		in_loc = roundup(in_loc, length);
>   		p->from = in_loc;
>   		p->to = out_loc;
>   		p->length = length;
> @@ -1019,10 +1015,8 @@ static int iio_buffer_update_demux(struct iio_dev *indio_dev,
>   				ch->scan_type.repeat;
>   		else
>   			length = ch->scan_type.storagebits / 8;
> -		if (out_loc % length)
> -			out_loc += length - out_loc % length;
> -		if (in_loc % length)
> -			in_loc += length - in_loc % length;
> +		out_loc = roundup(out_loc, length);
> +		in_loc = roundup(in_loc, length);
>   		p->from = in_loc;
>   		p->to = out_loc;
>   		p->length = length;
>

