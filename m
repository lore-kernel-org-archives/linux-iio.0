Return-Path: <amsfield22@gmail.com>
Date: Tue, 31 May 2016 10:45:22 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: Matt Ranostay <mranostay@gmail.com>, jic23@kernel.org
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: hudmidity: hdc100x: fix incorrect shifting and
 scaling
Message-ID: <20160531174521.GA2841@d830.WORKGROUP>
References: <1464576722-6902-1-git-send-email-mranostay@gmail.com>
 <CAKzfze9usfXfL=MpbFJOCcfgGXYbkN6bvykC1jXs3ebEsaioqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAKzfze9usfXfL=MpbFJOCcfgGXYbkN6bvykC1jXs3ebEsaioqA@mail.gmail.com>
List-ID: <linux-iio@vger.kernel.org>

On Sun, May 29, 2016 at 07:53:08PM -0700, Matt Ranostay wrote:
> Alison,
> 
> Can you give a Tested-by:  since I don't own this sensor anymore.
> 
> Thanks,
> 
> Matt

Tested it.  Verified temp & humidty calcs.  Looks great!

And, (seeing a pattern here ;)) this comes with another question,
probably directed a Jonathan...

with regards to temperature calculations:

Datasheets give numbers for this method:
	temp = ((raw * scale) + offset)
IIO drivers report numbers for this method:
	temp = ((raw + offset) * scale)

I've figured out the math for translating between them and creating
the offset for the driver to report in sysfs, but don't know why we
are doing that. 'Our' way seems kind of ugly. For example, for HDC1008
the offset is -40. It's the minimum expected temp value. But, we munge
it to be -15887.515151 so we can apply it before scaling.
		 
Why do we do it this way in IIO?

alisons

> 
> On Sun, May 29, 2016 at 7:52 PM, Matt Ranostay <mranostay@gmail.com> wrote:
> > Shifting sensor data to the right 2 bits was incorrect and caused the
> > scaling values + offsets to be invalid.
> >
> > Reported-by: Alison Schofield <amsfield22@gmail.com>
> > Signed-off-by: Matt Ranostay <mranostay@gmail.com>
> > ---
> >  drivers/iio/humidity/hdc100x.c | 16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
> > index 3070983..a03832a 100644
> > --- a/drivers/iio/humidity/hdc100x.c
> > +++ b/drivers/iio/humidity/hdc100x.c
> > @@ -164,14 +164,14 @@ static int hdc100x_get_measurement(struct hdc100x_data *data,
> >                 dev_err(&client->dev, "cannot read high byte measurement");
> >                 return ret;
> >         }
> > -       val = ret << 6;
> > +       val = ret << 8;
> >
> >         ret = i2c_smbus_read_byte(client);
> >         if (ret < 0) {
> >                 dev_err(&client->dev, "cannot read low byte measurement");
> >                 return ret;
> >         }
> > -       val |= ret >> 2;
> > +       val |= ret;
> >
> >         return val;
> >  }
> > @@ -212,17 +212,17 @@ static int hdc100x_read_raw(struct iio_dev *indio_dev,
> >         case IIO_CHAN_INFO_SCALE:
> >                 if (chan->type == IIO_TEMP) {
> >                         *val = 165000;
> > -                       *val2 = 65536 >> 2;
> > +                       *val2 = 65536;
> >                         return IIO_VAL_FRACTIONAL;
> >                 } else {
> > -                       *val = 0;
> > -                       *val2 = 10000;
> > -                       return IIO_VAL_INT_PLUS_MICRO;
> > +                       *val = 100;
> > +                       *val2 = 65536;
> > +                       return IIO_VAL_FRACTIONAL;
> >                 }
> >                 break;
> >         case IIO_CHAN_INFO_OFFSET:
> > -               *val = -3971;
> > -               *val2 = 879096;
> > +               *val = -15887;
> > +               *val2 = 515151;
> >                 return IIO_VAL_INT_PLUS_MICRO;
> >         default:
> >                 return -EINVAL;
> > --
> > 2.7.4
> >
