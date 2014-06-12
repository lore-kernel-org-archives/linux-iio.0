Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-164.synserver.de ([212.40.185.164]:1067 "EHLO
	smtp-out-164.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755218AbaFLIIL (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 12 Jun 2014 04:08:11 -0400
Message-ID: <53995FEB.5070207@metafoo.de>
Date: Thu, 12 Jun 2014 10:08:11 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org, jic23@kernel.org
Subject: Re: [PATCH v3 11/12] iio:adc:ad799x: Return more meaningful event
 enabled state
References: <1402548856-3564-1-git-send-email-pmeerw@pmeerw.net> <1402548856-3564-12-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1402548856-3564-12-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/12/2014 06:54 AM, Peter Meerwald wrote:
> only report an event as enabled if it actually is enabled
>
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Thanks.

> ---
>   drivers/iio/adc/ad799x.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
> index abc36c8..08bcada3 100644
> --- a/drivers/iio/adc/ad799x.c
> +++ b/drivers/iio/adc/ad799x.c
> @@ -364,7 +364,15 @@ static int ad799x_read_event_config(struct iio_dev *indio_dev,
>   				    enum iio_event_type type,
>   				    enum iio_event_direction dir)
>   {
> -	return 1;
> +	struct ad799x_state *st = iio_priv(indio_dev);
> +
> +	if (!(st->config & AD7998_ALERT_EN))
> +		return 0;
> +
> +	if ((st->config >> AD799X_CHANNEL_SHIFT) & BIT(chan->scan_index))
> +		return 1;
> +
> +	return 0;
>   }
>
>   static unsigned int ad799x_threshold_reg(const struct iio_chan_spec *chan,
>

