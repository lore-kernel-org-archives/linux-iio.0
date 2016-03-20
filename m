Return-Path: <sst@poczta.fm>
Date: Sun, 20 Mar 2016 18:24:14 +0100
From: Slawomir Stepien <sst@poczta.fm>
To: Joachim Eastwood <manabian@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] iio: add driver for Microchip
 MCP413X/414X/415X/416X/423X/424X/425X/426X
Message-ID: <20160320172414.GE10728@x220>
References: <20160320143021.GD10728@x220>
 <CAGhQ9VzO-QR7XYW2fkCDB7jj+hJTC7AU3R7UPLO5RVxoOWmsHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAGhQ9VzO-QR7XYW2fkCDB7jj+hJTC7AU3R7UPLO5RVxoOWmsHA@mail.gmail.com>
List-ID: <linux-iio@vger.kernel.org>

On Mar 20, 2016 17:12, Joachim Eastwood wrote:
> Hi Slawomir,
> 
> On 20 March 2016 at 15:30, Slawomir Stepien <sst@poczta.fm> wrote:
> > The following functionalities are supported:
> >  - write, read from volatile memory
> 
> I think it would be useful if you could put 'potentiometer' either in
> the subject and/or commit text so it is more obvious what this driver
> is for.

Ok

> > +       spi_message_init(&data->msg);
> > +       spi_message_add_tail(&data->xfer, &data->msg);
> > +
> > +       err = spi_sync(spi, &data->msg);
> > +       if (err) {
> > +               dev_err(&spi->dev, "spi_sync(): %d\n", err);
> > +               return err;
> > +       }
> 
> Isn't this init, add, sync sequence basically open coding of what
> spi_write/spi_read does?
> If you could use those you could also get rid transfer/message structs
> in priv data.
> Also it these any reason why the data buffer can just be a local
> variable in mcp4131_read_raw/mcp4131_write_raw?
> If it could be I think it should be possible to move the lock into the
> mcp4131_exec function.

Ok I'll try that.

> > +       case IIO_CHAN_INFO_SCALE:
> > +               *val = 1000 * data->cfg->kohms;
> > +               *val2 = data->cfg->max_pos;
> > +               mutex_unlock(&data->lock);
> 
> Is locking really necessary for IIO_CHAN_INFO_SCALE?
> Isn't all data->cfg stuff constant?
 
Yes you're right here. Didn't see it like that.

> > +static int mcp4131_write_raw(struct iio_dev *indio_dev,
> > +                            struct iio_chan_spec const *chan,
> > +                            int val, int val2, long mask)
> > +{
> > +       int err;
> > +       struct mcp4131_data *data = iio_priv(indio_dev);
> > +       int address = chan->channel << MCP4131_WIPER_SHIFT;
> > +
> > +       mutex_lock(&data->lock);
> > +
> > +       switch (mask) {
> > +       case IIO_CHAN_INFO_RAW:
> > +               if (val > data->cfg->max_pos || val < 0) {
> > +                       mutex_unlock(&data->lock);
> > +                       return -EINVAL;
> > +               }
> > +               break;
> > +       default:
> > +               mutex_unlock(&data->lock);
> > +               return -EINVAL;
> > +       }
> > +
> > +       err = mcp4131_exec(data, address, MCP4131_WRITE, val);
> > +       mutex_unlock(&data->lock);
> 
> While this is not a huge function it is usually good practice to keep
> the locking scope as small as possible.
> 
> So wouldn't this be sufficient here.
>     mutex_lock(&data->lock);
>     err = mcp4131_exec(data, address, MCP4131_WRITE, val);
>     mutex_unlock(&data->lock);
> 
> Of course if you are able move the lock into mcp4131_exec this will go away.
 
I'll see if it's possible to move the whole locking into this function.

Thank you for comments.

> regards,
> Joachim Eastwood

-- 
Slawomir Stepien
