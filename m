Return-Path: <manabian@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20160320143021.GD10728@x220>
References: <20160320143021.GD10728@x220>
Date: Sun, 20 Mar 2016 17:12:20 +0100
Message-ID: <CAGhQ9VzO-QR7XYW2fkCDB7jj+hJTC7AU3R7UPLO5RVxoOWmsHA@mail.gmail.com>
Subject: Re: [PATCH v3] iio: add driver for Microchip MCP413X/414X/415X/416X/423X/424X/425X/426X
From: Joachim  Eastwood <manabian@gmail.com>
To: Slawomir Stepien <sst@poczta.fm>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Hi Slawomir,

On 20 March 2016 at 15:30, Slawomir Stepien <sst@poczta.fm> wrote:
> The following functionalities are supported:
>  - write, read from volatile memory

I think it would be useful if you could put 'potentiometer' either in
the subject and/or commit text so it is more obvious what this driver
is for.

> Datasheet: http://ww1.microchip.com/downloads/en/DeviceDoc/22060b.pdf
>
> Signed-off-by: Slawomir Stepien <sst@poczta.fm>

> +
> +struct mcp4131_data {
> +       struct spi_device *spi;
> +       const struct mcp4131_cfg *cfg;
> +       struct mutex lock;
> +       struct spi_transfer xfer;
> +       struct spi_message msg;
> +       u8 buf[2] ____cacheline_aligned;
> +};
> +
> +#define MCP4131_CHANNEL(ch) {                                  \
> +       .type = IIO_RESISTANCE,                                 \
> +       .indexed = 1,                                           \
> +       .output = 1,                                            \
> +       .channel = (ch),                                        \
> +       .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),           \
> +       .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),   \
> +}
> +
> +static const struct iio_chan_spec mcp4131_channels[] = {
> +       MCP4131_CHANNEL(0),
> +       MCP4131_CHANNEL(1),
> +};
> +
> +static int mcp4131_exec(struct mcp4131_data *data,
> +               u8 addr, u8 cmd,
> +               u16 val)
> +{
> +       int err;
> +       struct spi_device *spi = data->spi;
> +
> +       data->xfer.tx_buf = data->buf;
> +       data->xfer.rx_buf = data->buf;
> +
> +       switch (cmd) {
> +       case MCP4131_READ:
> +               data->xfer.len = 2; /* Two bytes transfer for this command */
> +               data->buf[0] = (addr << MCP4131_WIPER_SHIFT) | MCP4131_READ;
> +               data->buf[1] = 0;
> +               break;
> +
> +       case MCP4131_WRITE:
> +               data->xfer.len = 2;
> +               data->buf[0] = (addr << MCP4131_WIPER_SHIFT) |
> +                       MCP4131_WRITE | (val >> 8);
> +               data->buf[1] = val & 0xFF; /* 8 bits here */
> +               break;
> +
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       dev_dbg(&spi->dev, "mcp4131_exec: tx0: 0x%x tx1: 0x%x\n",
> +                       data->buf[0], data->buf[1]);
> +
> +       spi_message_init(&data->msg);
> +       spi_message_add_tail(&data->xfer, &data->msg);
> +
> +       err = spi_sync(spi, &data->msg);
> +       if (err) {
> +               dev_err(&spi->dev, "spi_sync(): %d\n", err);
> +               return err;
> +       }

Isn't this init, add, sync sequence basically open coding of what
spi_write/spi_read does?
If you could use those you could also get rid transfer/message structs
in priv data.

Also it these any reason why the data buffer can just be a local
variable in mcp4131_read_raw/mcp4131_write_raw?
If it could be I think it should be possible to move the lock into the
mcp4131_exec function.

> +
> +       dev_dbg(&spi->dev, "mcp4131_exec: rx0: 0x%x rx1: 0x%x\n",
> +                       data->buf[0], data->buf[1]);
> +
> +       return 0;
> +}
> +
> +static int mcp4131_read_raw(struct iio_dev *indio_dev,
> +                           struct iio_chan_spec const *chan,
> +                           int *val, int *val2, long mask)
> +{
> +       int err;
> +       struct mcp4131_data *data = iio_priv(indio_dev);
> +       int address = chan->channel;
> +
> +       mutex_lock(&data->lock);
> +
> +       switch (mask) {
> +       case IIO_CHAN_INFO_RAW:
> +               err = mcp4131_exec(data, address, MCP4131_READ, 0);
> +               if (err) {
> +                       mutex_unlock(&data->lock);
> +                       return err;
> +               }
> +
> +               /* Error, bad address/command combination */
> +               if (!MCP4131_CMDERR(data->buf)) {
> +                       mutex_unlock(&data->lock);
> +                       return -EIO;
> +               }
> +
> +               *val = MCP4131_RAW(data->buf);
> +               mutex_unlock(&data->lock);
> +               return IIO_VAL_INT;
> +
> +       case IIO_CHAN_INFO_SCALE:
> +               *val = 1000 * data->cfg->kohms;
> +               *val2 = data->cfg->max_pos;
> +               mutex_unlock(&data->lock);

Is locking really necessary for IIO_CHAN_INFO_SCALE?
Isn't all data->cfg stuff constant?


> +               return IIO_VAL_FRACTIONAL;
> +       }
> +
> +       mutex_unlock(&data->lock);
> +
> +       return -EINVAL;
> +}
> +
> +static int mcp4131_write_raw(struct iio_dev *indio_dev,
> +                            struct iio_chan_spec const *chan,
> +                            int val, int val2, long mask)
> +{
> +       int err;
> +       struct mcp4131_data *data = iio_priv(indio_dev);
> +       int address = chan->channel << MCP4131_WIPER_SHIFT;
> +
> +       mutex_lock(&data->lock);
> +
> +       switch (mask) {
> +       case IIO_CHAN_INFO_RAW:
> +               if (val > data->cfg->max_pos || val < 0) {
> +                       mutex_unlock(&data->lock);
> +                       return -EINVAL;
> +               }
> +               break;
> +       default:
> +               mutex_unlock(&data->lock);
> +               return -EINVAL;
> +       }
> +
> +       err = mcp4131_exec(data, address, MCP4131_WRITE, val);
> +       mutex_unlock(&data->lock);

While this is not a huge function it is usually good practice to keep
the locking scope as small as possible.

So wouldn't this be sufficient here.
    mutex_lock(&data->lock);
    err = mcp4131_exec(data, address, MCP4131_WRITE, val);
    mutex_unlock(&data->lock);

Of course if you are able move the lock into mcp4131_exec this will go away.


regards,
Joachim Eastwood
