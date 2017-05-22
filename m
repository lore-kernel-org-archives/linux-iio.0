Return-Path: <SRS0=iYD7=44=cogentembedded.com=vladimir.barinov@kernel.org>
Subject: Re: [PATCH 2/4] iio: hi8435: avoid garbage event at first enable
To: Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
 Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Matt Ranostay <mranostay@gmail.com>, Gregor Boirie
 <gregor.boirie@parrot.com>, Sanchayan Maity <maitysanchayan@gmail.com>
References: <20170519144802.14427-1-nikita.yoush@cogentembedded.com>
 <20170519144802.14427-2-nikita.yoush@cogentembedded.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jeff White <Jeff.White@zii.aero>, Chris Healy <Chris.Healy@zii.aero>
From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Message-ID: <1df453fe-3ea4-a2fb-94e4-7462c2a2fad2@cogentembedded.com>
Date: Mon, 22 May 2017 21:20:30 +0300
MIME-Version: 1.0
In-Reply-To: <20170519144802.14427-2-nikita.yoush@cogentembedded.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-iio@vger.kernel.org>

Hi Nikita,

On 19.05.2017 17:48, Nikita Yushchenko wrote:
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

This will race with hi8435_iio_push_event for priv->event_scan_mask.

Since you adding raw access then it is reasonable to initialize 
priv->event_prev_val in hi8435_read_raw.
Then use the following sequence for your application:
1. read raw value
2. enable events

Regards,
Vladimir
