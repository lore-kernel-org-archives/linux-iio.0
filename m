Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:41825 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751509AbaGTQjN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 20 Jul 2014 12:39:13 -0400
Message-ID: <53CBF13D.7010308@kernel.org>
Date: Sun, 20 Jul 2014 17:41:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
CC: Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
Subject: Re: [PATCH 02/13] iio:bma180: Missing check for frequency fractional
 part
References: <1405535576-26482-1-git-send-email-pmeerw@pmeerw.net> <1405535576-26482-3-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1405535576-26482-3-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 16/07/14 19:32, Peter Meerwald wrote:
> val2 should be zero
>
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
> Cc: Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.
I added a bit more explanation to the the description of what the actual
result was.

> ---
>   drivers/iio/accel/bma180.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
> index 28388bb..a077cc8 100644
> --- a/drivers/iio/accel/bma180.c
> +++ b/drivers/iio/accel/bma180.c
> @@ -376,6 +376,8 @@ static int bma180_write_raw(struct iio_dev *indio_dev,
>   		mutex_unlock(&data->mutex);
>   		return ret;
>   	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> +		if (val2)
> +			return -EINVAL;
>   		mutex_lock(&data->mutex);
>   		ret = bma180_set_bw(data, val);
>   		mutex_unlock(&data->mutex);
>

