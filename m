Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbeKZAnJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 25 Nov 2018 19:43:09 -0500
Date: Sun, 25 Nov 2018 13:51:57 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Daniel Baluta <daniel.baluta@intel.com>
Cc: martin@martingkelly.com, linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: bmi160: use all devm functions in probe
Message-ID: <20181125135157.508659d6@archlinux>
In-Reply-To: <CAEnQRZB9fWnCr_V68MAF5VRS32Ge4oXQ7dCL2AhnyEYuJWeiPQ@mail.gmail.com>
References: <20181119005347.747-1-martin@martingkelly.com>
        <20181119005347.747-2-martin@martingkelly.com>
        <CAEnQRZB9fWnCr_V68MAF5VRS32Ge4oXQ7dCL2AhnyEYuJWeiPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 19 Nov 2018 10:48:20 +0200
Daniel Baluta <daniel.baluta@intel.com> wrote:

> On Mon, Nov 19, 2018 at 2:55 AM Martin Kelly <martin@martingkelly.com> wrote:
> >
> > From: Martin Kelly <martin@martingkelly.com>
> >
> > Currently, we're using the devm version of some but not all functions.
> > Switch to the devm version of iio_triggered_buffer_setup and
> > iio_device_register to simplify the code a bit and decrease the chance of
> > bugs.  
> 
> Yes, it makes sense.
> 
> Acked-by: Daniel Baluta <daniel.baluta@gmail.com>
Here we disagree :).  This results in the chip being uninitialized
via bmi160_chip_uninit before we remove the user space interfaces.
So the combination that is there right now was very deliberate
and is correct - that's not to say it can't be improved upon.

So if you do want to do this you need to ensure that operation
automatically occurs in the correct point in the remove and error
flows.

devm_add_action_or_reset is your friend here as it'll let you call
that uninit from the automatic unwinding path and hence at the
correct point.

Thanks,

Jonathan

> 
> >
> > Signed-off-by: Martin Kelly <martin@martingkelly.com>
> > ---
> >  drivers/iio/imu/bmi160/bmi160_core.c | 12 ++++--------
> >  1 file changed, 4 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
> > index 4d9d59d9e3a9..5e4efaed5e88 100644
> > --- a/drivers/iio/imu/bmi160/bmi160_core.c
> > +++ b/drivers/iio/imu/bmi160/bmi160_core.c
> > @@ -577,18 +577,16 @@ int bmi160_core_probe(struct device *dev, struct regmap *regmap,
> >         indio_dev->modes = INDIO_DIRECT_MODE;
> >         indio_dev->info = &bmi160_info;
> >
> > -       ret = iio_triggered_buffer_setup(indio_dev, NULL,
> > -                                        bmi160_trigger_handler, NULL);
> > +       ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
> > +                                             bmi160_trigger_handler, NULL);
> >         if (ret < 0)
> >                 goto uninit;
> >
> > -       ret = iio_device_register(indio_dev);
> > +       ret = devm_iio_device_register(dev, indio_dev);
> >         if (ret < 0)
> > -               goto buffer_cleanup;
> > +               goto uninit;
> >
> >         return 0;
> > -buffer_cleanup:
> > -       iio_triggered_buffer_cleanup(indio_dev);
> >  uninit:
> >         bmi160_chip_uninit(data);
> >         return ret;
> > @@ -600,8 +598,6 @@ void bmi160_core_remove(struct device *dev)
> >         struct iio_dev *indio_dev = dev_get_drvdata(dev);
> >         struct bmi160_data *data = iio_priv(indio_dev);
> >
> > -       iio_device_unregister(indio_dev);
> > -       iio_triggered_buffer_cleanup(indio_dev);
> >         bmi160_chip_uninit(data);
> >  }
> >  EXPORT_SYMBOL_GPL(bmi160_core_remove);
> > --
> > 2.11.0
> >  
