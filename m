Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:40526 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751734AbaGTPGd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 20 Jul 2014 11:06:33 -0400
Message-ID: <53CBDB85.10405@kernel.org>
Date: Sun, 20 Jul 2014 16:08:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org, Denis CIOCCA <denis.ciocca@st.com>
Subject: Re: [PATCH 2/4] iio: buffer: Use roundup() instead of ALIGN()
References: <1405612789-27964-1-git-send-email-lars@metafoo.de> <1405612789-27964-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1405612789-27964-2-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 17/07/14 16:59, Lars-Peter Clausen wrote:
> ALIGN() only works correctly if the alignment is a power of two. Some drivers
> use 3 bytes for the storage size of the word in which case ALIGN() will cause
> incorrect results. Use the more generic roundup() instead.
>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Gah.  Which driver is using a non power of two storage size?  I thought I'd caught
all of those at review.  As you've noted it's a very bad idea.

 From a quick dubious grep I have:
dac/ad5791.c (not effected as such given we aren't using this stuff for output)
pressure/st_pressure_core.c

I'd be tempted to fix those up rather than change this and introduce the
fun you've pointed out below.

What do you think?
> ---
> This at least makes the rules for alignment predictable and consistent. But
> mixing 3 bytes words with other word sizes will still result in strange layouts.
> E.g. 4-byte word, 3-byte word will result in 4-byte word, 2-byte alignment gap,
> 3-byte word.

> ---
>   drivers/iio/industrialio-buffer.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 0472ee2..6da5272 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -486,7 +486,7 @@ static int iio_compute_scan_bytes(struct iio_dev *indio_dev,
>   				ch->scan_type.repeat;
>   		else
>   			length = ch->scan_type.storagebits / 8;
> -		bytes = ALIGN(bytes, length);
> +		bytes = roundup(bytes, length);
>   		bytes += length;
>   	}
>   	if (timestamp) {
> @@ -497,7 +497,7 @@ static int iio_compute_scan_bytes(struct iio_dev *indio_dev,
>   				ch->scan_type.repeat;
>   		else
>   			length = ch->scan_type.storagebits / 8;
> -		bytes = ALIGN(bytes, length);
> +		bytes = roundup(bytes, length);
>   		bytes += length;
>   	}
>   	return bytes;
>

