Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:57396 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751508AbaGGMaM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 7 Jul 2014 08:30:12 -0400
Message-ID: <53BA9356.8070303@kernel.org>
Date: Mon, 07 Jul 2014 13:32:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@samsung.com>, linux-iio@vger.kernel.org
CC: gregkh@linuxfoundation.org, spk.linux@gmail.com,
	Michael Hennerich <hennerich@blackfin.uclinux.org>
Subject: Re: [PATCH 1/1] staging: iio: ad9832: Remove redundant check
References: <1404388568-5370-1-git-send-email-sachin.kamat@samsung.com>
In-Reply-To: <1404388568-5370-1-git-send-email-sachin.kamat@samsung.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/07/14 12:56, Sachin Kamat wrote:
> 'val' is unsigned and cannot be negative.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@samsung.com>
> Cc: Michael Hennerich <hennerich@blackfin.uclinux.org>
Applied to the togreg branch of iio.git

Thanks
> ---
>   drivers/staging/iio/frequency/ad9832.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
> index b7c8351..cf68159 100644
> --- a/drivers/staging/iio/frequency/ad9832.c
> +++ b/drivers/staging/iio/frequency/ad9832.c
> @@ -120,7 +120,7 @@ static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
>   		ret = spi_sync(st->spi, &st->msg);
>   		break;
>   	case AD9832_PHASE_SYM:
> -		if (val < 0 || val > 3) {
> +		if (val > 3) {
>   			ret = -EINVAL;
>   			break;
>   		}
>

