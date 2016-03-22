Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtpo.poczta.interia.pl ([217.74.65.208]:49511 "EHLO
	smtpo.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751005AbcCVRE5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 22 Mar 2016 13:04:57 -0400
Date: Tue, 22 Mar 2016 18:05:39 +0100
From: Slawomir Stepien <sst@poczta.fm>
To: Joachim Eastwood <manabian@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] iio: potentiometer: add driver for Microchip
 MCP413X/414X/415X/416X/423X/424X/425X/426X
Message-ID: <20160322170538.GB871@x220>
References: <20160322154455.GA871@x220>
 <CAGhQ9VyphbjwuWy7O7nzGj8PnWX2QqkdN+29-DO1E_t_fs38sA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAGhQ9VyphbjwuWy7O7nzGj8PnWX2QqkdN+29-DO1E_t_fs38sA@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mar 22, 2016 17:10, Joachim Eastwood wrote:
> Hi Slawomir,
> 
> On 22 March 2016 at 16:44, Slawomir Stepien <sst@poczta.fm> wrote:
> > The following functionalities are supported:
> >  - write, read from volatile memory
> >
> > Datasheet: http://ww1.microchip.com/downloads/en/DeviceDoc/22060b.pdf
> >
> > Signed-off-by: Slawomir Stepien <sst@poczta.fm>
> > ---
> 
> > +#include <linux/module.h>
> > +#include <linux/spi/spi.h>
> > +#include <linux/err.h>
> > +
> > +#include <linux/iio/iio.h>
> 
> Give that you use that you have a some OF stuff in your driver you
> should also include <linux/of.h>. Same goes for <linux/mutex.h>.
> I am sure this builds fine without those includes, but you should
> explicitly include stuff that you use.

Oh yes that's true.

> While you're at it you could also put the includes in alphabetic order.

OK

> > +static int mcp4131_read_raw(struct iio_dev *indio_dev,
> > +                           struct iio_chan_spec const *chan,
> > +                           int *val, int *val2, long mask)
> > +{
> > +       int err;
> > +       struct mcp4131_data *data = iio_priv(indio_dev);
> > +       int address = chan->channel;
> > +
> > +       switch (mask) {
> > +       case IIO_CHAN_INFO_RAW:
> > +               mutex_lock(&data->lock);
> > +
> > +               data->buf[0] = (address << MCP4131_WIPER_SHIFT) | MCP4131_READ;
> > +               data->buf[1] = 0;
> > +
> > +               err = mcp4131_read(data->spi, data->buf, 2);
> > +               if (err) {
> > +                       mutex_unlock(&data->lock);
> > +                       return err;
> > +               }
> > +
> > +               /* Error, bad address/command combination */
> > +               if (!MCP4131_CMDERR(data->buf))
> > +                       return -EIO;
> 
> Missing mutex unlock here.

Oh ;) I'll fix that.

> > +
> > +               *val = MCP4131_RAW(data->buf);
> > +               mutex_unlock(&data->lock);
> > +
> > +               return IIO_VAL_INT;
> > +
> > +       case IIO_CHAN_INFO_SCALE:
> > +               *val = 1000 * data->cfg->kohms;
> > +               *val2 = data->cfg->max_pos;
> > +               return IIO_VAL_FRACTIONAL;
> > +       }
> > +
> > +       return -EINVAL;
> > +}
> > +
> > +static int mcp4131_write_raw(struct iio_dev *indio_dev,
> > +                            struct iio_chan_spec const *chan,
> > +                            int val, int val2, long mask)
> > +{
> > +       int err;
> > +       struct mcp4131_data *data = iio_priv(indio_dev);
> > +       int address = chan->channel << MCP4131_WIPER_SHIFT;
> > +
> > +       switch (mask) {
> > +       case IIO_CHAN_INFO_RAW:
> > +               if (val > data->cfg->max_pos || val < 0)
> > +                       return -EINVAL;
> > +               break;
> > +
> > +       default:
> > +               return -EINVAL;
> > +       }
> > +
> > +       mutex_lock(&data->lock);
> > +
> > +       data->buf[0] = address << MCP4131_WIPER_SHIFT;
> > +       data->buf[0] |= MCP4131_WRITE | (val >> 8);
> > +       data->buf[1] = val & 0xFF; /* 8 bits here */
> > +
> > +       err = spi_write(data->spi, data->buf, 2);
> > +       if (err) {
> > +               mutex_unlock(&data->lock);
> > +               return err;
> > +       }
> > +       mutex_unlock(&data->lock);
> > +
> > +       return 0;
> 
> This last part could be written as:
>   err = spi_write(data->spi, data->buf, 2);
>   mutex_unlock(&data->lock);
> 
>   return err;
 
OK

> Other than the things I noted driver looks good to me.
> 
> 
> regards,
> Joachim Eastwood

-- 
Slawomir Stepien
