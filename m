Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:61830 "EHLO
	mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751075Ab3KMUiz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 13 Nov 2013 15:38:55 -0500
Message-ID: <5283E396.9020301@metafoo.de>
Date: Wed, 13 Nov 2013 21:39:50 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org, frank@zago.net
Subject: Re: [PATCH] iio:accel:kxsd9 fix missing mutex unlock
References: <1384374470-3188-1-git-send-email-jic23@kernel.org>
In-Reply-To: <1384374470-3188-1-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/13/2013 09:27 PM, Jonathan Cameron wrote:
> From: Frank Zago <frank@zago.net>
>
> This will leave a lock held after reading from the device, preventing
> any further reads.
>
> Signed-off-by: Frank Zago <frank@zago.net>
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
> ---
> I have reworked this from a patch sent to me by Frank and put it
> into the correct format.
>
> Frank, do you mind me adding your sign off on this. It's shorter
> than your patch, but the effect is the same.  This approach of unlocking
> before checking a return value is a common kernel idiom.
>
> Jonathan
>
>   drivers/iio/accel/kxsd9.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
> index d72118d1189c..12df91986dd2 100644
> --- a/drivers/iio/accel/kxsd9.c
> +++ b/drivers/iio/accel/kxsd9.c
> @@ -112,6 +112,7 @@ static int kxsd9_read(struct iio_dev *indio_dev, u8 address)
>   	mutex_lock(&st->buf_lock);
>   	st->tx[0] = KXSD9_READ(address);
>   	ret = spi_sync_transfer(st->us, xfers, ARRAY_SIZE(xfers));
> +	mutex_unlock(&st->buf_lock);
>   	if (ret)
>   		return ret;
>   	return (((u16)(st->rx[0])) << 8) | (st->rx[1] & 0xF0);

I think you'll need to hold the lock until you've actually read the data from 
the buffer.

- Lars

