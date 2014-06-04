Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-156.synserver.de ([212.40.185.156]:1081 "EHLO
	smtp-out-156.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751387AbaFDIG0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 4 Jun 2014 04:06:26 -0400
Message-ID: <538ED37D.3060708@metafoo.de>
Date: Wed, 04 Jun 2014 10:06:21 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org, knaack.h@gmx.de
Subject: Re: [PATCH 13/15] iio:adc:ad799x: Rename ad7997_8_update_scan_mode()
 to ad799x_update_scan_mode()
References: <1401835335-29969-1-git-send-email-pmeerw@pmeerw.net> <1401835335-29969-14-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1401835335-29969-14-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/04/2014 12:42 AM, Peter Meerwald wrote:
> function is used by all chips with ALERT pin

The subject is a bit misleading, this does a bit more than just renaming the 
function.

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

>
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
> ---
>   drivers/iio/adc/ad799x.c | 14 +++++++++-----
>   1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
> index f8e029d..5c9445e 100644
> --- a/drivers/iio/adc/ad799x.c
> +++ b/drivers/iio/adc/ad799x.c
> @@ -208,7 +208,7 @@ out:
>   	return IRQ_HANDLED;
>   }
>
> -static int ad7997_8_update_scan_mode(struct iio_dev *indio_dev,
> +static int ad799x_update_scan_mode(struct iio_dev *indio_dev,
>   	const unsigned long *scan_mask)
>   {
>   	struct ad799x_state *st = iio_priv(indio_dev);
> @@ -221,10 +221,14 @@ static int ad7997_8_update_scan_mode(struct iio_dev *indio_dev,
>   	st->transfer_size = bitmap_weight(scan_mask, indio_dev->masklength) * 2;
>
>   	switch (st->id) {
> +	case ad7992:
> +	case ad7993:
> +	case ad7994:
>   	case ad7997:
>   	case ad7998:
> -		return i2c_smbus_write_word_swapped(st->client, AD7998_CONF_REG,
> -			st->config | (*scan_mask << AD799X_CHANNEL_SHIFT));
> +		st->config &= ~(GENMASK(7, 0) << AD799X_CHANNEL_SHIFT);
> +		st->config |= (*scan_mask << AD799X_CHANNEL_SHIFT);
> +		return ad799x_write_config(st, st->config);
>   	default:
>   		return 0;
>   	}
> @@ -483,7 +487,7 @@ static const struct iio_info ad7991_info = {
>   static const struct iio_info ad7993_4_7_8_noirq_info = {
>   	.read_raw = &ad799x_read_raw,
>   	.driver_module = THIS_MODULE,
> -	.update_scan_mode = ad7997_8_update_scan_mode,
> +	.update_scan_mode = ad799x_update_scan_mode,
>   };
>
>   static const struct iio_info ad7993_4_7_8_irq_info = {
> @@ -493,7 +497,7 @@ static const struct iio_info ad7993_4_7_8_irq_info = {
>   	.read_event_value = &ad799x_read_event_value,
>   	.write_event_value = &ad799x_write_event_value,
>   	.driver_module = THIS_MODULE,
> -	.update_scan_mode = ad7997_8_update_scan_mode,
> +	.update_scan_mode = ad799x_update_scan_mode,
>   };
>
>   static const struct iio_event_spec ad799x_events[] = {
>

