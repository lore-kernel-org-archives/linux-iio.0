Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35460 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750884AbdEBLrA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 2 May 2017 07:47:00 -0400
Date: Tue, 2 May 2017 19:46:56 +0800
From: Eva Rachel Retuya <eraretuya@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
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
Subject: Re: [PATCH v2 2/4] iio: accel: adxl345_core: Introduce set_mode and
 data_ready functions
Message-ID: <20170502114655.GB3030@Socrates-UM>
References: <cover.1493450577.git.eraretuya@gmail.com>
 <96d20633a6ff9792f7be642a590669fc07d9ad63.1493450577.git.eraretuya@gmail.com>
 <CAHp75VcOqrQ8QKiSLoS4gkREvm8voDsw22EnxRPwtWLJFkQu4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAHp75VcOqrQ8QKiSLoS4gkREvm8voDsw22EnxRPwtWLJFkQu4g@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, May 01, 2017 at 02:21:02PM +0300, Andy Shevchenko wrote:
[...]
> Couple of minors below.
> Otherwise, FWIW:
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 

Hello Andy,

> > +static int adxl345_data_ready(struct adxl345_data *data)
> > +{
> > +       struct device *dev = regmap_get_device(data->regmap);
> 
> > +       int tries = 5;
> 
> unsigned int tries = 5;
> 

Ack.

> > +       u32 val;
> > +       int ret;
> > +
> > +       do {
> 
> > +               /*
> > +                * 1/ODR + 1.1ms; 11.1ms at ODR of 0.10 Hz
> > +                * Sensor currently operates at default ODR of 100 Hz
> > +                */
> > +               usleep_range(1100, 11100);
> 
> From the above comment I can't get why we sleep first then attempt to
> read and not otherwise. Please, elaborate.
> 

Before this function is called, the sensor is placed into measurement
mode. The delay is there to account for the "wake-up" time from standby
to measurement mode. So sleep first then attempt to read. In the first
version I was not yet aware of it until I look around in the datasheet
trying to justify how long to delay. I will clarify the comment to make
it more clear.

Thanks,
Eva

> > +
> > +               ret = regmap_read(data->regmap, ADXL345_REG_INT_SOURCE, &val);
> > +               if (ret < 0)
> > +                       return ret;
> > +               if ((val & ADXL345_INT_DATA_READY) == ADXL345_INT_DATA_READY)
> > +                       return 0;
> > +       } while (--tries);
> > +       dev_err(dev, "Data is not yet ready, try again.\n");
> > +
> > +       return -EAGAIN;
> > +}
> 
> -- 
> With Best Regards,
> Andy Shevchenko
