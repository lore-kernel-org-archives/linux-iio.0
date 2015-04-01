Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
In-Reply-To: <f807f1dedd46ef414e5b5160b4d5c8574ac5a2a7.1427861152.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1427861152.git.sathyanarayanan.kuppuswamy@linux.intel.com>
	<f807f1dedd46ef414e5b5160b4d5c8574ac5a2a7.1427861152.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Date: Wed, 1 Apr 2015 18:10:02 +0300
Message-ID: <CAEnQRZDJn2X0kWg4od2LMHVDu4kLmBjV9jJTu+GFqR86HDKMgw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] iio: ltr301: Add support for ltr301
From: Daniel Baluta <daniel.baluta@gmail.com>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Peter Meerwald <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Wed, Apr 1, 2015 at 7:06 AM, Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> Added support for Liteon 301 Ambient light sensor. Since
> LTR301 and LTR501 are register compatible(and even have same
> part id), LTR501 driver has been extended to support both
> devices. LTR501 is similar to LTR301 in ALS sensing, But the
> only difference is, LTR501 also supports proximity sensing.
>
> LTR501 - ALS + Proximity combo
> LTR301 - ALS sensor.

As I'm adding support for LTR559 sensor, we should agree
on what's the best way to this.

I suggest we should add a ltr501_chip_info for each chip type as
done in [1]

>  static int ltr501_write_contr(struct i2c_client *client, u8 als_val, u8 ps_val)
>  {
>         int ret = i2c_smbus_write_byte_data(client, LTR501_ALS_CONTR, als_val);
> @@ -347,6 +377,7 @@ static int ltr501_probe(struct i2c_client *client,
>         data = iio_priv(indio_dev);
>         i2c_set_clientdata(client, indio_dev);
>         data->client = client;
> +       data->chip_id = id->driver_data;

id can be NULL here if enumerated via ACPI.

>         mutex_init(&data->lock_als);
>         mutex_init(&data->lock_ps);
>
> @@ -357,12 +388,24 @@ static int ltr501_probe(struct i2c_client *client,
>                 return -ENODEV;
>
>         indio_dev->dev.parent = &client->dev;
> -       indio_dev->info = &ltr501_info;
> -       indio_dev->channels = ltr501_channels;
>         indio_dev->num_channels = ARRAY_SIZE(ltr501_channels);
>         indio_dev->name = LTR501_DRV_NAME;

Name should be taken via id->name or ACPI.

>         indio_dev->modes = INDIO_DIRECT_MODE;
>
> +       switch (data->chip_id) {
> +       case LTR301:
> +               indio_dev->info = &ltr301_info;
> +               indio_dev->channels = ltr301_channels;
> +               break;
> +       case LTR501:
> +               indio_dev->info = &ltr501_info;
> +               indio_dev->channels = ltr501_channels;
> +               break;
> +       default:
> +               pr_warn("ltr chip invalid\n");
We do have  dev struct here, so we should use dev_warn.

Daniel.

[1]  https://lkml.org/lkml/2015/3/31/198
