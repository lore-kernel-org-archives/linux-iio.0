Return-Path: <marex@denx.de>
From: Marek Vasut <marex@denx.de>
To: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH V5] iio: acpi: Add ACPI0008 ALS driver
Date: Mon, 30 Sep 2013 01:44:22 +0200
Cc: "Lars-Peter Clausen" <lars@metafoo.de>,
 linux-iio@vger.kernel.org,
 Martin Liska <marxin.liska@gmail.com>,
 Zhang Rui <rui.zhang@intel.com>
References: <1374364717-10040-1-git-send-email-marex@denx.de> <5228D834.4060505@metafoo.de> <522C8450.3080504@kernel.org>
In-Reply-To: <522C8450.3080504@kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201309300144.22295.marex@denx.de>
List-ID: <linux-iio@vger.kernel.org>

Dear Jonathan Cameron,

[...]

> >> +static void acpi_als_notify(struct acpi_device *device, u32 event)
> >> +{
> >> +    struct iio_dev *iio = acpi_driver_data(device);
> >> +    struct acpi_als *als = iio_priv(iio);
> >> +    s64 time_ns = iio_get_time_ns();
> >> +
> >> +    mutex_lock(&als->lock);
> > 
> > Hm, so you lock the mutex here and unlock the mutex
> > acpi_als_trigger_handler. This really needs some explanation. You also
> > need to implement validate_trigger and validate_device callbacks to make
> > sure that this trigger is only used with this device and vice versa.
> 
> It may need some annotation as well to avoid various checks picking this
> up.

Do you have any particular one in mind?

[...]

> >> +    evt_buffer = devm_kzalloc(dev, evt_buffer_size, GFP_KERNEL);
> >> +    if (!evt_buffer)
> >> +        return -ENOMEM;
> >> +
> >> +    iio = iio_device_alloc(sizeof(*als));
> > 
> > devm_...
> 
> Also for the trigger allocation.

I'm on 3.12.0-rc2 (next 20130927), don't see either of them existing.

Best regards,
Marek Vasut
