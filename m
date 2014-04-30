Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59414 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759303AbaD3Uze (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 30 Apr 2014 16:55:34 -0400
Message-ID: <536163A1.9010708@kernel.org>
Date: Wed, 30 Apr 2014 21:57:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Masanari Iida <standby24x7@gmail.com>, devel@driverdev.osuosl.org,
	gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] staging: iio: Fix format string mismatch in ad7280a.c
References: <1398700802-31361-1-git-send-email-standby24x7@gmail.com>
In-Reply-To: <1398700802-31361-1-git-send-email-standby24x7@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 28/04/14 17:00, Masanari Iida wrote:
> Fix two format string mismatch in ad7280a.c
>
> Signed-off-by: Masanari Iida <standby24x7@gmail.com>
Applied to the togreg branch of iio.git
Note this will initially get pushed out as testing for
the autobuilders to play.

Thanks,

Jonathan
> ---
>   drivers/staging/iio/adc/ad7280a.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
> index 1ac11f6..d215edf 100644
> --- a/drivers/staging/iio/adc/ad7280a.c
> +++ b/drivers/staging/iio/adc/ad7280a.c
> @@ -443,7 +443,7 @@ static ssize_t ad7280_show_balance_timer(struct device *dev,
>
>   	msecs = (ret >> 3) * 71500;
>
> -	return sprintf(buf, "%d\n", msecs);
> +	return sprintf(buf, "%u\n", msecs);
>   }
>
>   static ssize_t ad7280_store_balance_timer(struct device *dev,
> @@ -619,7 +619,7 @@ static ssize_t ad7280_read_channel_config(struct device *dev,
>   		return -EINVAL;
>   	}
>
> -	return sprintf(buf, "%d\n", val);
> +	return sprintf(buf, "%u\n", val);
>   }
>
>   static ssize_t ad7280_write_channel_config(struct device *dev,
>

