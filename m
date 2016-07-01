Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
Sender: daniel.baluta@gmail.com
In-Reply-To: <1467340430-15184-1-git-send-email-mranostay@gmail.com>
References: <1467340430-15184-1-git-send-email-mranostay@gmail.com>
From: Daniel Baluta <daniel.baluta@intel.com>
Date: Fri, 1 Jul 2016 16:34:19 +0300
Message-ID: <CAEnQRZB2wbAtd8M45g8d_-Bsw32z1YQLnEctwZvfwh__dTgRLA@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: ti-ads1015: add indio_dev->dev.of_node reference
To: Matt Ranostay <mranostay@gmail.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Daniel Baluta <daniel.baluta@intel.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Fri, Jul 1, 2016 at 5:33 AM, Matt Ranostay <mranostay@gmail.com> wrote:
> Add the pointer to the device tree node of the ADC so that iio
> consumers can reference the respective channels.
>
> Cc: Daniel Baluta <daniel.baluta@intel.com>
> Signed-off-by: Matt Ranostay <mranostay@gmail.com>

Acked-by: Daniel Baluta <daniel.baluta@intel.com>



> ---
>  drivers/iio/adc/ti-ads1015.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
> index 8be192a84893..6f75a4aa67c1 100644
> --- a/drivers/iio/adc/ti-ads1015.c
> +++ b/drivers/iio/adc/ti-ads1015.c
> @@ -585,6 +585,7 @@ static int ads1015_probe(struct i2c_client *client,
>         mutex_init(&data->lock);
>
>         indio_dev->dev.parent = &client->dev;
> +       indio_dev->dev.of_node = client->dev.of_node;
>         indio_dev->name = ADS1015_DRV_NAME;
>         indio_dev->modes = INDIO_DIRECT_MODE;
>
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
