Return-Path: <SRS0=/UZX=4I=gmail.com=eraretuya@kernel.org>
Date: Tue, 2 May 2017 20:24:53 +0800
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
Subject: Re: [PATCH v2 4/4] iio: accel: adxl345: Add support for triggered
 buffer
Message-ID: <20170502122452.GF3030@Socrates-UM>
References: <cover.1493450577.git.eraretuya@gmail.com>
 <6b7ca7916924965c30e9e5abb4133663e5c7916d.1493450577.git.eraretuya@gmail.com>
 <CAHp75VcRX8KeDu48-vwfePpSpY=_2dF1AckCpZSo0=K3JUUo8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAHp75VcRX8KeDu48-vwfePpSpY=_2dF1AckCpZSo0=K3JUUo8g@mail.gmail.com>
List-ID: <linux-iio@vger.kernel.org>

On Mon, May 01, 2017 at 02:24:27PM +0300, Andy Shevchenko wrote:
[...]
> One nit below.
> FWIW:
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
> > +static irqreturn_t adxl345_trigger_handler(int irq, void *p)
> > +{
> > +       struct iio_poll_func *pf = p;
> > +       struct iio_dev *indio_dev = pf->indio_dev;
> > +       struct adxl345_data *data = iio_priv(indio_dev);
> > +       int ret;
> > +
> > +       mutex_lock(&data->lock);
> > +       /* Make sure data is ready when using external trigger */
> > +       if (!data->data_ready_trig_on) {
> > +               ret = adxl345_data_ready(data);
> > +               if (ret < 0)
> > +                       goto error;
> > +       }
> > +
> > +       ret = regmap_bulk_read(data->regmap, ADXL345_REG_DATAX0, data->buffer,
> > +                              sizeof(__le16) * 3);
> > +       if (ret < 0)
> > +               goto error;
> > +
> > +       iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
> > +                                          pf->timestamp);
> 
> > +error:
> 
> I would call it 'err_unlock_notify'.
> 

OK.

Thanks for the review,
Eva

> > +       mutex_unlock(&data->lock);
> > +       iio_trigger_notify_done(indio_dev->trig);
> > +
> > +       return IRQ_HANDLED;
> > +}
> 
> -- 
> With Best Regards,
> Andy Shevchenko
