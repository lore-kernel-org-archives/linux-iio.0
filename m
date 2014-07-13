Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:35223 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751747AbaGMUxs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 13 Jul 2014 16:53:48 -0400
Message-ID: <53C2F262.7030503@kernel.org>
Date: Sun, 13 Jul 2014 21:56:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 04/12] iio:adc:ad799x: Save some lines in ad7997_8_update_scan_mode()
 exit handling
References: <1402548856-3564-1-git-send-email-pmeerw@pmeerw.net> <1402548856-3564-5-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1402548856-3564-5-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/06/14 05:54, Peter Meerwald wrote:
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
Applied
> ---
>   drivers/iio/adc/ad799x.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
> index 34d93a5..878400c 100644
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

