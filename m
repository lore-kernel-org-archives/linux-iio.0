Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-155.synserver.de ([212.40.185.155]:1076 "EHLO
	smtp-out-155.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755250AbaFDHrA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 4 Jun 2014 03:47:00 -0400
Message-ID: <538ECEED.5020307@metafoo.de>
Date: Wed, 04 Jun 2014 09:46:53 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org, knaack.h@gmx.de
Subject: Re: [PATCH 10/15] iio:adc:ad799x: Check event value range on write
References: <1401835335-29969-1-git-send-email-pmeerw@pmeerw.net> <1401835335-29969-11-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1401835335-29969-11-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/04/2014 12:42 AM, Peter Meerwald wrote:
> event values are 10 or 12 bit max., and need to be left-shifted
> on ad7993, ad7997
>

This should probably be squashed in the previous patch. As that one updates 
how the write value is computed and this one how the read value is computed.

> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
> ---
>   drivers/iio/adc/ad799x.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
> index 0d8e950..dbc7c2b 100644
> --- a/drivers/iio/adc/ad799x.c
> +++ b/drivers/iio/adc/ad799x.c
> @@ -368,9 +368,13 @@ static int ad799x_write_event_value(struct iio_dev *indio_dev,
>   	int ret;
>   	struct ad799x_state *st = iio_priv(indio_dev);
>
> +	if (val > GENMASK(chan->scan_type.realbits - 1, 0))
> +		return -EINVAL;
> +
>   	mutex_lock(&indio_dev->mlock);
>   	ret = i2c_smbus_write_word_swapped(st->client,
> -		ad799x_threshold_reg(chan, dir, info), val);
> +		ad799x_threshold_reg(chan, dir, info),
> +		val << chan->scan_type.shift);
>   	mutex_unlock(&indio_dev->mlock);
>
>   	return ret;
>

