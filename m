Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:59588 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752963AbbJFXNw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 6 Oct 2015 19:13:52 -0400
Message-ID: <561455AC.60504@denx.de>
Date: Wed, 07 Oct 2015 01:13:48 +0200
From: Marek Vasut <marex@denx.de>
MIME-Version: 1.0
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: mxs-lradc: Fix temperature offset
References: <1444141347-15301-1-git-send-email-alexandre.belloni@free-electrons.com>
In-Reply-To: <1444141347-15301-1-git-send-email-alexandre.belloni@free-electrons.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/06/2015 16:22, Alexandre Belloni wrote:
> 0° Kelvin is actually −273.15°C, not -272.15°C. Fix the temperature offset.
>
> Reported-by: Janusz Użycki <j.uzycki@elpromaelectronics.com>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Nice find :-)

Acked-by: Marek Vasut <marex@denx.de>

(I am using different MUA, please pardon the possible issues)

> ---
>   drivers/staging/iio/adc/mxs-lradc.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
> index 3f7715c9968b..67bfa54c4fb1 100644
> --- a/drivers/staging/iio/adc/mxs-lradc.c
> +++ b/drivers/staging/iio/adc/mxs-lradc.c
> @@ -916,10 +916,10 @@ static int mxs_lradc_read_raw(struct iio_dev *iio_dev,
>   		if (chan->type == IIO_TEMP) {
>   			/* The calculated value from the ADC is in Kelvin, we
>   			 * want Celsius for hwmon so the offset is
> -			 * -272.15 * scale
> +			 * -273.15 * scale
>   			 */
> -			*val = -1075;
> -			*val2 = 691699;
> +			*val = -1079;
> +			*val2 = 644268;
>
>   			return IIO_VAL_INT_PLUS_MICRO;
>   		}
>

