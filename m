Return-Path: <SRS0=NVyf=7D=gmail.com=daniel.baluta@kernel.org>
MIME-Version: 1.0
Sender: daniel.baluta@gmail.com
In-Reply-To: <20170801082605.kxzqtnrbt6glplmu@lenoch>
References: <20170801082521.namcrs4wyufwqyuh@lenoch> <20170801082605.kxzqtnrbt6glplmu@lenoch>
From: Daniel Baluta <daniel.baluta@intel.com>
Date: Tue, 1 Aug 2017 12:09:34 +0300
Message-ID: <CAEnQRZDKd1aWyX+2WvZ=acQGqDOMt22xWp0VCyVPfufFut86vg@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: adc: ti-ads1015: fix conversion time
To: Ladislav Michl <ladis@linux-mips.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Daniel Baluta <daniel.baluta@gmail.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

On Tue, Aug 1, 2017 at 11:26 AM, Ladislav Michl <ladis@linux-mips.org> wrote:
> When reading diffrent channel value than device is currently processing
> wait time of conversion period is applied, which is not enough as device
> might be already in the middle of conversion and therefore previously
> converted value is returned - the one belonging to another channel.
> Fix it by waiting for two sampling periods.
>
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>

Did you actually experienced this in practice? I guess you are right,
if you change the channel during a conversion, this change will be applied
to the next conversion *but* reading will still return old value because the
current conversion hasn't finished yet.

So,

Acked-by: Daniel Baluta <daniel.baluta@gmail.com>


> ---
>  drivers/iio/adc/ti-ads1015.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
> index 884b8e461b17..86fd2753869d 100644
> --- a/drivers/iio/adc/ti-ads1015.c
> +++ b/drivers/iio/adc/ti-ads1015.c
> @@ -260,7 +260,7 @@ int ads1015_get_adc_result(struct ads1015_data *data, int chan, int *val)
>                 return ret;
>
>         if (change) {
> -               conv_time = DIV_ROUND_UP(USEC_PER_SEC, data->data_rate[dr]);
> +               conv_time = 2 * DIV_ROUND_UP(USEC_PER_SEC, data->data_rate[dr]);
>                 usleep_range(conv_time, conv_time + 1);
>         }
>
> --
> 2.11.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
