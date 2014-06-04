Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-156.synserver.de ([212.40.185.156]:1043 "EHLO
	smtp-out-155.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753109AbaFDHzL (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 4 Jun 2014 03:55:11 -0400
Message-ID: <538ED0DB.906@metafoo.de>
Date: Wed, 04 Jun 2014 09:55:07 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org, knaack.h@gmx.de
Subject: Re: [PATCH 15/15] iio:adc:ad799x: Allow to write event config
References: <1401835335-29969-1-git-send-email-pmeerw@pmeerw.net> <1401835335-29969-16-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1401835335-29969-16-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/04/2014 12:42 AM, Peter Meerwald wrote:
> allow to enable events
>
> previously, events were always reported as enabled, but actually only
> implicitly enabled when updating the buffer scan mode
>
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
> ---
>   drivers/iio/adc/ad799x.c | 34 ++++++++++++++++++++++++++++++++++
>   1 file changed, 34 insertions(+)
>
> diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
> index b8191f1..f8bfbcb 100644
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

If I understand this correctly the enabled channels will be overwritten 
again as soon as the scan mode is updated. I think that is a bit unexpected. 
I'm not quite sure how to implement being able to independently enable a 
channel for sampling and for event monitoring in a proper way though.

