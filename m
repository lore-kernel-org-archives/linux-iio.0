Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-164.synserver.de ([212.40.185.164]:1035 "EHLO
	smtp-out-164.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755218AbaFLIIy (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 12 Jun 2014 04:08:54 -0400
Message-ID: <53996012.2050606@metafoo.de>
Date: Thu, 12 Jun 2014 10:08:50 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org, jic23@kernel.org
Subject: Re: [PATCH v3 12/12] iio:adc:ad799x: Allow to write event config
References: <1402548856-3564-1-git-send-email-pmeerw@pmeerw.net> <1402548856-3564-13-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1402548856-3564-13-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/12/2014 06:54 AM, Peter Meerwald wrote:
> allow to enable events
>
> previously, events were always reported as enabled, but actually only
> implicitly enabled when updating the buffer scan mode
>
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>

It's not perfect, but is an improvement over the current situation so,

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Thanks.

> ---
>   drivers/iio/adc/ad799x.c | 34 ++++++++++++++++++++++++++++++++++
>   1 file changed, 34 insertions(+)
>
> diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
> index 08bcada3..e37412d 100644
> --- a/drivers/iio/adc/ad799x.c
> +++ b/drivers/iio/adc/ad799x.c
> @@ -375,6 +375,39 @@ static int ad799x_read_event_config(struct iio_dev *indio_dev,
>   	return 0;
>   }
>
> +static int ad799x_write_event_config(struct iio_dev *indio_dev,
> +				     const struct iio_chan_spec *chan,
> +				     enum iio_event_type type,
> +				     enum iio_event_direction dir,
> +				     int state)
> +{
> +	struct ad799x_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	mutex_lock(&indio_dev->mlock);
> +	if (iio_buffer_enabled(indio_dev)) {
> +		ret = -EBUSY;
> +		goto done;
> +	}
> +
> +	if (state)
> +		st->config |= BIT(chan->scan_index) << AD799X_CHANNEL_SHIFT;
> +	else
> +		st->config &= ~(BIT(chan->scan_index) << AD799X_CHANNEL_SHIFT);
> +
> +	if (st->config >> AD799X_CHANNEL_SHIFT)
> +		st->config |= AD7998_ALERT_EN;
> +	else
> +		st->config &= ~AD7998_ALERT_EN;
> +
> +	ret = ad799x_write_config(st, st->config);
> +
> +done:
> +	mutex_unlock(&indio_dev->mlock);
> +
> +	return ret;
> +}
> +
>   static unsigned int ad799x_threshold_reg(const struct iio_chan_spec *chan,
>   					 enum iio_event_direction dir,
>   					 enum iio_event_info info)
> @@ -502,6 +535,7 @@ static const struct iio_info ad7993_4_7_8_irq_info = {
>   	.read_raw = &ad799x_read_raw,
>   	.event_attrs = &ad799x_event_attrs_group,
>   	.read_event_config = &ad799x_read_event_config,
> +	.write_event_config = &ad799x_write_event_config,
>   	.read_event_value = &ad799x_read_event_value,
>   	.write_event_value = &ad799x_write_event_value,
>   	.driver_module = THIS_MODULE,
>

