Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:57733 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750810AbbJFSn6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 6 Oct 2015 14:43:58 -0400
Date: Tue, 6 Oct 2015 20:43:53 +0200 (CEST)
From: Stefan Wahren <stefan.wahren@i2se.com>
Reply-To: Stefan Wahren <stefan.wahren@i2se.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, Marek Vasut <marex@denx.de>,
	=?UTF-8?Q?Janusz_U=C5=BCycki?= <j.uzycki@elpromaelectronics.com>,
	Jonathan Cameron <jic23@kernel.org>
Message-ID: <415576093.114803.1444157033983.JavaMail.open-xchange@oxbaltgw07.schlund.de>
In-Reply-To: <1444141347-15301-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1444141347-15301-1-git-send-email-alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH] iio: mxs-lradc: Fix temperature offset
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

> Alexandre Belloni <alexandre.belloni@free-electrons.com> hat am 6. Oktober
> 2015 um 16:22 geschrieben:
>
>
> 0° Kelvin is actually −273.15°C, not -272.15°C. Fix the temperature offset.
>
> Reported-by: Janusz Użycki <j.uzycki@elpromaelectronics.com>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
> drivers/staging/iio/adc/mxs-lradc.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/staging/iio/adc/mxs-lradc.c
> b/drivers/staging/iio/adc/mxs-lradc.c
> index 3f7715c9968b..67bfa54c4fb1 100644
> --- a/drivers/staging/iio/adc/mxs-lradc.c
> +++ b/drivers/staging/iio/adc/mxs-lradc.c
> @@ -916,10 +916,10 @@ static int mxs_lradc_read_raw(struct iio_dev *iio_dev,
> if (chan->type == IIO_TEMP) {
> /* The calculated value from the ADC is in Kelvin, we
> * want Celsius for hwmon so the offset is
> - * -272.15 * scale
> + * -273.15 * scale
> */
> - *val = -1075;
> - *val2 = 691699;
> + *val = -1079;
> + *val2 = 644268;
>

i think it would be nice to break down the calculation of these magic values in
a second patch.

Regards
Stefan
