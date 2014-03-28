Return-Path: <morbidrsa@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20140328083126.GO25192@mwanda>
References: <20140328083126.GO25192@mwanda>
Date: Fri, 28 Mar 2014 15:07:22 +0100
Message-ID: <CAGH8bx77dKAm7w53F5MfTXaPm6KxQcVCXERnW-oXmR5Ww-HLTw@mail.gmail.com>
Subject: Re: [patch] iio: adc: checking for NULL instead of IS_ERR() in probe
From: johannes thumshirn <morbidrsa@gmail.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Fri, Mar 28, 2014 at 9:33 AM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> mcb_request_mem() returns an ERR_PTR(), it doesn't return NULL.
>
> Fixes: 74aeac4da66f ('iio: adc: Add MEN 16z188 ADC driver')
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> diff --git a/drivers/iio/adc/men_z188_adc.c b/drivers/iio/adc/men_z188_adc.c
> index 6989c16..b58d630 100644
> --- a/drivers/iio/adc/men_z188_adc.c
> +++ b/drivers/iio/adc/men_z188_adc.c
> @@ -121,8 +121,8 @@ static int men_z188_probe(struct mcb_device *dev,
>         indio_dev->num_channels = ARRAY_SIZE(z188_adc_iio_channels);
>
>         mem = mcb_request_mem(dev, "z188-adc");
> -       if (!mem)
> -               return -ENOMEM;
> +       if (IS_ERR(mem))
> +               return PTR_ERR(mem);
>
>         adc->base = ioremap(mem->start, resource_size(mem));
>         if (adc->base == NULL)

Acked-by: Johannes Thumshirn <johannes.thumshirn@men.de>
