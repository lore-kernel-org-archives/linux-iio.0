Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:40662 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751159AbaGTPQy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 20 Jul 2014 11:16:54 -0400
Message-ID: <53CBDDF2.3050904@kernel.org>
Date: Sun, 20 Jul 2014 16:19:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/6] iio: accel: kxcjk-1013: Fix setting frequency
References: <1405557754-19601-1-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1405557754-19601-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 17/07/14 01:42, Srinivas Pandruvada wrote:
> Fix issue with setting of 12.5 and 6.25 HZ. The match of val2 fails.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Applied to the togreg branch of iio.git

Thanks,
> ---
>   drivers/iio/accel/kxcjk-1013.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> index 72a6dbb..4702aeb 100644
> --- a/drivers/iio/accel/kxcjk-1013.c
> +++ b/drivers/iio/accel/kxcjk-1013.c
> @@ -98,7 +98,7 @@ static const struct {
>   	int val2;
>   	int odr_bits;
>   } samp_freq_table[] = { {0, 781000, 0x08}, {1, 563000, 0x09},
> -			{3, 125000, 0x0A}, {6, 25000, 0x0B}, {12, 5000, 0},
> +			{3, 125000, 0x0A}, {6, 250000, 0x0B}, {12, 500000, 0},
>   			{25, 0, 0x01}, {50, 0, 0x02}, {100, 0, 0x03},
>   			{200, 0, 0x04}, {400, 0, 0x05}, {800, 0, 0x06},
>   			{1600, 0, 0x07} };
>

