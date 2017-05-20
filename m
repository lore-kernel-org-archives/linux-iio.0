Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60315 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751782AbdETQek (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 20 May 2017 12:34:40 -0400
Subject: Re: [PATCH 2/4] iio: hi8435: avoid garbage event at first enable
To: Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Matt Ranostay <mranostay@gmail.com>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Sanchayan Maity <maitysanchayan@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeff White <Jeff.White@zii.aero>,
        Chris Healy <Chris.Healy@zii.aero>,
        Vladimir Barinov <vladimir.barinov@cogentembedded.com>
References: <20170519144802.14427-1-nikita.yoush@cogentembedded.com>
 <20170519144802.14427-2-nikita.yoush@cogentembedded.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <3f28cc76-c8fe-e5a8-8c50-94c089af43e4@kernel.org>
Date: Sat, 20 May 2017 17:34:40 +0100
MIME-Version: 1.0
In-Reply-To: <20170519144802.14427-2-nikita.yoush@cogentembedded.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/05/17 15:48, Nikita Yushchenko wrote:
> Currently, driver generates events for channels if new reading differs
> from previous one. This "previous value" is initialized to zero, which
> results into event if value is constant-one.
> 
> Fix that by initializing "previous value" by reading at event enable
> time.
> 
> This provides reliable sequence for userspace:
> - enable event,
> - AFTER THAT read current value,
> - AFTER THAT each event will correspond to change.
> 
> Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
I'm hoping there aren't any userspace apps out there relying on this
'unusual' behaviour.  *cross fingers*

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>   drivers/iio/adc/hi8435.c | 15 +++++++++++++--
>   1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/hi8435.c b/drivers/iio/adc/hi8435.c
> index cb8e6342eddf..45a92e3e8f2b 100644
> --- a/drivers/iio/adc/hi8435.c
> +++ b/drivers/iio/adc/hi8435.c
> @@ -141,10 +141,21 @@ static int hi8435_write_event_config(struct iio_dev *idev,
>   				     enum iio_event_direction dir, int state)
>   {
>   	struct hi8435_priv *priv = iio_priv(idev);
> +	int ret;
> +	u32 tmp;
> +
> +	if (state) {
> +		ret = hi8435_readl(priv, HI8435_SO31_0_REG, &tmp);
> +		if (ret < 0)
> +			return ret;
> +		if (tmp & BIT(chan->channel))
> +			priv->event_prev_val |= BIT(chan->channel);
> +		else
> +			priv->event_prev_val &= ~BIT(chan->channel);
>   
> -	priv->event_scan_mask &= ~BIT(chan->channel);
> -	if (state)
>   		priv->event_scan_mask |= BIT(chan->channel);
> +	} else
> +		priv->event_scan_mask &= ~BIT(chan->channel);
>   
>   	return 0;
>   }
> 

