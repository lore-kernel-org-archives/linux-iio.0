Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1464312684-14050-1-git-send-email-mranostay@gmail.com>
References: <1464312684-14050-1-git-send-email-mranostay@gmail.com>
Date: Fri, 27 May 2016 15:46:44 +0300
Message-ID: <CAEnQRZDyN6+9tn2oHviP50xzFJuhfQpifCD7Qs9hn+UJN=g8TA@mail.gmail.com>
Subject: Re: [PATCH] iio: temperature: add support for Maxim thermocouple chips
From: Daniel Baluta <daniel.baluta@gmail.com>
To: Matt Ranostay <mranostay@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Marek Vasut <marex@denx.de>,
	Matt Porter <mporter@konsulko.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

> +static int maxim_thermocouple_read_raw(struct iio_dev *indio_dev,
> +                                      struct iio_chan_spec const *chan,
> +                                      int *val, int *val2, long mask)
> +{
> +       struct maxim_thermocouple_data *data = iio_priv(indio_dev);
> +       int ret = -EINVAL;
> +
> +       mutex_lock(&indio_dev->mlock);
> +

Lets try to use here iio_device_claim_direct_mode wrappers.


> +       if (iio_buffer_enabled(indio_dev) && mask == IIO_CHAN_INFO_RAW) {
> +               ret = -EBUSY;
> +               goto error_busy;
> +       }

thanks,
Daniel.
