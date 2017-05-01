Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:33703 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424078AbdEALY2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 1 May 2017 07:24:28 -0400
MIME-Version: 1.0
In-Reply-To: <6b7ca7916924965c30e9e5abb4133663e5c7916d.1493450577.git.eraretuya@gmail.com>
References: <cover.1493450577.git.eraretuya@gmail.com> <6b7ca7916924965c30e9e5abb4133663e5c7916d.1493450577.git.eraretuya@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 1 May 2017 14:24:27 +0300
Message-ID: <CAHp75VcRX8KeDu48-vwfePpSpY=_2dF1AckCpZSo0=K3JUUo8g@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] iio: accel: adxl345: Add support for triggered buffer
To: Eva Rachel Retuya <eraretuya@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Daniel Baluta <daniel.baluta@gmail.com>,
        Alison Schofield <amsfield22@gmail.com>,
        Florian Vaussard <florian.vaussard@heig-vd.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Apr 29, 2017 at 10:49 AM, Eva Rachel Retuya <eraretuya@gmail.com> wrote:
> Previously, the only way to capture data is to read the exposed sysfs
> files in_accel_[x/y/z]_raw and applying the scale from in_accel_scale.
> Provide a way for continuous data capture that allows multiple data
> channels to be read at once by setting up buffer support.
>
> Initialize scan_type fields that describe the buffer and make sure to
> claim and release direct mode in read_raw. The latter is done to ensure
> no raw reads are attempted when utilizing the buffer and vice versa.
>
> Lastly, add triggered buffer support that allows utilization of any
> given trigger such as DATA_READY, hrtimer, etc. to initiate capturing of
> data and placing said data in the buffer. The trigger handler performs
> an all-axes read with timestamp.

One nit below.
FWIW:
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> +static irqreturn_t adxl345_trigger_handler(int irq, void *p)
> +{
> +       struct iio_poll_func *pf = p;
> +       struct iio_dev *indio_dev = pf->indio_dev;
> +       struct adxl345_data *data = iio_priv(indio_dev);
> +       int ret;
> +
> +       mutex_lock(&data->lock);
> +       /* Make sure data is ready when using external trigger */
> +       if (!data->data_ready_trig_on) {
> +               ret = adxl345_data_ready(data);
> +               if (ret < 0)
> +                       goto error;
> +       }
> +
> +       ret = regmap_bulk_read(data->regmap, ADXL345_REG_DATAX0, data->buffer,
> +                              sizeof(__le16) * 3);
> +       if (ret < 0)
> +               goto error;
> +
> +       iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
> +                                          pf->timestamp);

> +error:

I would call it 'err_unlock_notify'.

> +       mutex_unlock(&data->lock);
> +       iio_trigger_notify_done(indio_dev->trig);
> +
> +       return IRQ_HANDLED;
> +}

-- 
With Best Regards,
Andy Shevchenko
