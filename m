Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60307 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753531AbdETQdk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 20 May 2017 12:33:40 -0400
Subject: Re: [PATCH 1/4] iio: hi8435: add raw access
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
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <67afb274-c93b-f35b-64c1-0ab8ccb21557@kernel.org>
Date: Sat, 20 May 2017 17:33:40 +0100
MIME-Version: 1.0
In-Reply-To: <20170519144802.14427-1-nikita.yoush@cogentembedded.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/05/17 15:47, Nikita Yushchenko wrote:
> With current event-only driver, it is not possible for user space
> application to know current senses if they don't change since
> application starts.
> 
> Address that by adding raw access to channels.
> 
> Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Ideally I'd like Vladimir's ack on these, but I am going to guess
that he is fine with this and rely on him shouting if not ;)

Applied to the togreg branch of iio.git and pushed out as testing.

Thanks,

Jonathan
> ---
>   drivers/iio/adc/hi8435.c | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/iio/adc/hi8435.c b/drivers/iio/adc/hi8435.c
> index 678e8c7ea763..cb8e6342eddf 100644
> --- a/drivers/iio/adc/hi8435.c
> +++ b/drivers/iio/adc/hi8435.c
> @@ -105,6 +105,26 @@ static int hi8435_writew(struct hi8435_priv *priv, u8 reg, u16 val)
>   	return spi_write(priv->spi, priv->reg_buffer, 3);
>   }
>   
> +static int hi8435_read_raw(struct iio_dev *idev,
> +			   const struct iio_chan_spec *chan,
> +			   int *val, int *val2, long mask)
> +{
> +	struct hi8435_priv *priv = iio_priv(idev);
> +	u32 tmp;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = hi8435_readl(priv, HI8435_SO31_0_REG, &tmp);
> +		if (ret < 0)
> +			return ret;
> +		*val = !!(tmp & BIT(chan->channel));
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
>   static int hi8435_read_event_config(struct iio_dev *idev,
>   				    const struct iio_chan_spec *chan,
>   				    enum iio_event_type type,
> @@ -333,6 +353,7 @@ static const struct iio_chan_spec_ext_info hi8435_ext_info[] = {
>   	.type = IIO_VOLTAGE,				\
>   	.indexed = 1,					\
>   	.channel = num,					\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
>   	.event_spec = hi8435_events,			\
>   	.num_event_specs = ARRAY_SIZE(hi8435_events),	\
>   	.ext_info = hi8435_ext_info,			\
> @@ -376,6 +397,7 @@ static const struct iio_chan_spec hi8435_channels[] = {
>   
>   static const struct iio_info hi8435_info = {
>   	.driver_module = THIS_MODULE,
> +	.read_raw = hi8435_read_raw,
>   	.read_event_config = &hi8435_read_event_config,
>   	.write_event_config = hi8435_write_event_config,
>   	.read_event_value = &hi8435_read_event_value,
> 

