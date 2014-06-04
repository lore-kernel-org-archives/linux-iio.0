Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-156.synserver.de ([212.40.185.156]:1117 "EHLO
	smtp-out-155.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753109AbaFDH4V (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 4 Jun 2014 03:56:21 -0400
Message-ID: <538ED117.9020903@metafoo.de>
Date: Wed, 04 Jun 2014 09:56:07 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org, knaack.h@gmx.de
Subject: Re: [PATCH 05/15] iio:adc:ad799x: Save some lines in ad7997_8_update_scan_mode()
 exit handling
References: <1401835335-29969-1-git-send-email-pmeerw@pmeerw.net> <1401835335-29969-6-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1401835335-29969-6-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/04/2014 12:42 AM, Peter Meerwald wrote:
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>

well, ok

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

> ---
>   drivers/iio/adc/ad799x.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
> index c03406e..24eca2f 100644
> --- a/drivers/iio/adc/ad799x.c
> +++ b/drivers/iio/adc/ad799x.c
> @@ -193,10 +193,8 @@ static int ad7997_8_update_scan_mode(struct iio_dev *indio_dev,
>   		return i2c_smbus_write_word_swapped(st->client, AD7998_CONF_REG,
>   			st->config | (*scan_mask << AD799X_CHANNEL_SHIFT));
>   	default:
> -		break;
> +		return 0;
>   	}
> -
> -	return 0;
>   }
>
>   static int ad799x_scan_direct(struct ad799x_state *st, unsigned ch)
>

