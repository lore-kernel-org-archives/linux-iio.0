Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751020AbdFYP6v (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 25 Jun 2017 11:58:51 -0400
Date: Sun, 25 Jun 2017 16:58:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jack Andersen <jackoalan@gmail.com>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Lee Jones <lee.jones@linaro.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: Add support for DLN2 ADC
Message-ID: <20170625165845.489597b2@kernel.org>
In-Reply-To: <CAPHBK3ZeVFVtJgsNQhqhGPkiKTL4mi6h0nLi4Jjm6BUHM5u96Q@mail.gmail.com>
References: <alpine.DEB.2.20.1706230915470.489@vps.pmeerw.net>
        <20170624203801.7e982ad0@kernel.org>
        <CAPHBK3ZeVFVtJgsNQhqhGPkiKTL4mi6h0nLi4Jjm6BUHM5u96Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 24 Jun 2017 12:18:58 -1000
Jack Andersen <jackoalan@gmail.com> wrote:

> You're right about the fiddly device part. The important thing
> to note about the DLN2 is it's a multifunction device with a
> unified command message interface. All four functions (GPIO, ADC,
> I2C, SPI) use this interface for every possible action. Commands
> are performed synchronously and return at least an error code.
> 
> The dln2.c module in MFD implements this command interface and
> manages 'handles' for all four functions as well as a single
> event handle for handling USB transfers of events like GPIO
> low/high and ADC thresholds / periodic timers. Existing modules
> like dln2_gpio and dln2_i2c all share the symbols exported by
> dln2.
> 
> I'll revaluate the code when I'm back in the office on Monday.
> 
> More explanations inline.
> 
> On 24 June 2017 at 09:38, Jonathan Cameron <jic23@kernel.org> wrote:
> > On Fri, 23 Jun 2017 09:25:58 +0200 (CEST)
> > Peter Meerwald-Stadler <pmeerw@pmeerw.net> wrote:
> >  
> >> > This patch adds support for Diolan DLN2 ADC via IIO's ADC interface.
> >> > ADC is the fourth and final component of the DLN2 for the kernel.  
> >>
> >> I am missing a changelog or information if and how review comments have
> >> been addressed
> >>
> >> thanks for the super-fast turnaround, anyway
> >>
> >> p.  
> > A few bits and pieces inline.  Fiddly device.  Out of curiosity
> > are then any relevant docs or is this a reverse engineering job?
> >
> > There were a few unusual elements so would be nice to verify they
> > line up with docs if available!
> >
> > Jonathan  
> Reverse engineering wasn't really necessary; Diolan has macros
> of all the command enums and structures in their userspace
> headers (for some reason). The calls implemented in their binary
> blob are simple libusb transfer wrappers; I essentially stuck to
> the transfer style used by dln2_gpio instead.
> 
> For reference:
> http://dlnware.com/downloads/linux-setup
> Unzip and refer to examples/common/dln_adc.h
> >>  
> >> > Signed-off-by: Jack Andersen <jackoalan@gmail.com>
> >> > ---
> >> >  drivers/iio/adc/Kconfig    |   9 +
> >> >  drivers/iio/adc/Makefile   |   1 +
> >> >  drivers/iio/adc/dln2-adc.c | 644 +++++++++++++++++++++++++++++++++++++++++++++
> >> >  drivers/mfd/dln2.c         |  12 +  
> > touching an mfd file so needs an ack from Lee. Cc'd.  
> >> >  4 files changed, 666 insertions(+)
> >> >  create mode 100644 drivers/iio/adc/dln2-adc.c
> >> >
> >> > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> >> > index 401f47b..78d7455 100644
> >> > --- a/drivers/iio/adc/Kconfig
> >> > +++ b/drivers/iio/adc/Kconfig
> >> > @@ -239,6 +239,15 @@ config DA9150_GPADC
> >> >       To compile this driver as a module, choose M here: the module will be
> >> >       called berlin2-adc.
> >> >
> >> > +config DLN2_ADC
> >> > +   tristate "Diolan DLN-2 ADC driver support"
> >> > +   depends on MFD_DLN2
> >> > +   help
> >> > +     Say yes here to build support for Diolan DLN-2 ADC.
> >> > +
> >> > +     This driver can also be built as a module. If so, the module will be
> >> > +     called adc_dln2.
> >> > +
> >> >  config ENVELOPE_DETECTOR
> >> >     tristate "Envelope detector using a DAC and a comparator"
> >> >     depends on OF
> >> > diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> >> > index 9339bec..378bc65 100644
> >> > --- a/drivers/iio/adc/Makefile
> >> > +++ b/drivers/iio/adc/Makefile
> >> > @@ -24,6 +24,7 @@ obj-$(CONFIG_BERLIN2_ADC) += berlin2-adc.o
> >> >  obj-$(CONFIG_CC10001_ADC) += cc10001_adc.o
> >> >  obj-$(CONFIG_CPCAP_ADC) += cpcap-adc.o
> >> >  obj-$(CONFIG_DA9150_GPADC) += da9150-gpadc.o
> >> > +obj-$(CONFIG_DLN2_ADC) += dln2-adc.o
> >> >  obj-$(CONFIG_ENVELOPE_DETECTOR) += envelope-detector.o
> >> >  obj-$(CONFIG_EXYNOS_ADC) += exynos_adc.o
> >> >  obj-$(CONFIG_FSL_MX25_ADC) += fsl-imx25-gcq.o
> >> > diff --git a/drivers/iio/adc/dln2-adc.c b/drivers/iio/adc/dln2-adc.c
> >> > new file mode 100644
> >> > index 0000000..6c58b76
> >> > --- /dev/null
> >> > +++ b/drivers/iio/adc/dln2-adc.c
> >> > @@ -0,0 +1,644 @@
> >> > +/*
> >> > + * Driver for the Diolan DLN-2 USB-ADC adapter
> >> > + *
> >> > + * Copyright (c) 2017 Jack Andersen
> >> > + *
> >> > + * This program is free software; you can redistribute it and/or
> >> > + * modify it under the terms of the GNU General Public License as
> >> > + * published by the Free Software Foundation, version 2.
> >> > + */
> >> > +
> >> > +#include <linux/kernel.h>
> >> > +#include <linux/module.h>
> >> > +#include <linux/types.h>
> >> > +#include <linux/platform_device.h>
> >> > +#include <linux/mfd/dln2.h>
> >> > +
> >> > +#include <linux/iio/iio.h>
> >> > +#include <linux/iio/sysfs.h>
> >> > +#include <linux/iio/trigger.h>
> >> > +#include <linux/iio/trigger_consumer.h>
> >> > +#include <linux/iio/buffer.h>
> >> > +#include <linux/iio/kfifo_buf.h>
> >> > +
> >> > +#define DLN2_ADC_MOD_NAME "dln2-adc"
> >> > +
> >> > +#define DLN2_ADC_ID             0x06
> >> > +
> >> > +#define DLN2_ADC_GET_CHANNEL_COUNT DLN2_CMD(0x01, DLN2_ADC_ID)
> >> > +#define DLN2_ADC_ENABLE                    DLN2_CMD(0x02, DLN2_ADC_ID)
> >> > +#define DLN2_ADC_DISABLE           DLN2_CMD(0x03, DLN2_ADC_ID)
> >> > +#define DLN2_ADC_CHANNEL_ENABLE            DLN2_CMD(0x05, DLN2_ADC_ID)
> >> > +#define DLN2_ADC_CHANNEL_DISABLE   DLN2_CMD(0x06, DLN2_ADC_ID)
> >> > +#define DLN2_ADC_SET_RESOLUTION            DLN2_CMD(0x08, DLN2_ADC_ID)
> >> > +#define DLN2_ADC_CHANNEL_GET_VAL   DLN2_CMD(0x0A, DLN2_ADC_ID)
> >> > +#define DLN2_ADC_CHANNEL_GET_ALL_VAL       DLN2_CMD(0x0B, DLN2_ADC_ID)
> >> > +#define DLN2_ADC_CHANNEL_SET_CFG   DLN2_CMD(0x0C, DLN2_ADC_ID)
> >> > +#define DLN2_ADC_CHANNEL_GET_CFG   DLN2_CMD(0x0D, DLN2_ADC_ID)
> >> > +#define DLN2_ADC_CONDITION_MET_EV  DLN2_CMD(0x10, DLN2_ADC_ID)
> >> > +
> >> > +#define DLN2_ADC_EVENT_NONE                0
> >> > +#define DLN2_ADC_EVENT_BELOW               1
> >> > +#define DLN2_ADC_EVENT_LEVEL_ABOVE 2
> >> > +#define DLN2_ADC_EVENT_OUTSIDE             3
> >> > +#define DLN2_ADC_EVENT_INSIDE              4
> >> > +#define DLN2_ADC_EVENT_ALWAYS              5
> >> > +
> >> > +#define DLN2_ADC_MAX_CHANNELS 8
> >> > +#define DLN2_ADC_DATA_BITS 10
> >> > +
> >> > +struct dln2_adc {
> >> > +   struct platform_device *pdev;
> >> > +   int port;
> >> > +   struct iio_trigger *trig;
> >> > +   struct mutex mutex;
> >> > +   /* Set once initialized */
> >> > +   bool port_enabled;
> >> > +   /* Set once resolution request made to HW */
> >> > +   bool resolution_set;
> >> > +   /* Bitmask requesting enabled channels */
> >> > +   unsigned long chans_requested;
> >> > +   /* Bitmask indicating enabled channels on HW */
> >> > +   unsigned long chans_enabled;
> >> > +   /* Channel that is arbitrated for event trigger */
> >> > +   int trigger_chan;
> >> > +};
> >> > +
> >> > +struct dln2_adc_port_chan {
> >> > +   u8 port;
> >> > +   u8 chan;
> >> > +};
> >> > +
> >> > +struct dln2_adc_get_all_vals {
> >> > +   __le16 channel_mask;
> >> > +   __le16 values[DLN2_ADC_MAX_CHANNELS];
> >> > +};
> >> > +
> >> > +static int dln2_adc_get_chan_count(struct dln2_adc *dln2)
> >> > +{
> >> > +   int ret;
> >> > +   u8 port = dln2->port;
> >> > +   u8 count;
> >> > +   int olen = sizeof(count);
> >> > +
> >> > +   ret = dln2_transfer(dln2->pdev, DLN2_ADC_GET_CHANNEL_COUNT,
> >> > +                       &port, sizeof(port), &count, &olen);
> >> > +   if (ret < 0) {
> >> > +           dev_dbg(&dln2->pdev->dev, "Problem in %s\n", __func__);
> >> > +           return ret;
> >> > +   }
> >> > +   if (olen < sizeof(count))
> >> > +           return -EPROTO;
> >> > +
> >> > +   return count;
> >> > +}
> >> > +
> >> > +static int dln2_adc_set_port_resolution(struct dln2_adc *dln2)
> >> > +{
> >> > +   int ret;
> >> > +   struct dln2_adc_port_chan port_chan = {
> >> > +           .port = dln2->port,
> >> > +           .chan = DLN2_ADC_DATA_BITS,
> >> > +   };
> >> > +
> >> > +   ret = dln2_transfer_tx(dln2->pdev, DLN2_ADC_SET_RESOLUTION,
> >> > +                          &port_chan, sizeof(port_chan));
> >> > +   if (ret < 0) {
> >> > +           dev_dbg(&dln2->pdev->dev, "Problem in %s\n", __func__);
> >> > +           return ret;
> >> > +   }
> >> > +
> >> > +   return 0;
> >> > +}
> >> > +
> >> > +static int dln2_adc_set_chan_enabled(struct dln2_adc *dln2,
> >> > +                                int channel, bool enable)
> >> > +{
> >> > +   int ret;
> >> > +   struct dln2_adc_port_chan port_chan = {
> >> > +           .port = dln2->port,
> >> > +           .chan = channel,
> >> > +   };
> >> > +
> >> > +   u16 cmd = enable ? DLN2_ADC_CHANNEL_ENABLE : DLN2_ADC_CHANNEL_DISABLE;
> >> > +
> >> > +   ret = dln2_transfer_tx(dln2->pdev, cmd, &port_chan, sizeof(port_chan));
> >> > +   if (ret < 0) {
> >> > +           dev_dbg(&dln2->pdev->dev, "Problem in %s\n", __func__);
> >> > +           return ret;
> >> > +   }
> >> > +
> >> > +   return 0;
> >> > +}
> >> > +
> >> > +static int dln2_adc_set_port_enabled(struct dln2_adc *dln2, bool enable)
> >> > +{
> >> > +   int ret;
> >> > +   u8 port = dln2->port;
> >> > +   __le16 conflict;
> >> > +   int olen = sizeof(conflict);
> >> > +
> >> > +   u16 cmd = enable ? DLN2_ADC_ENABLE : DLN2_ADC_DISABLE;
> >> > +
> >> > +   ret = dln2_transfer(dln2->pdev, cmd, &port, sizeof(port),
> >> > +                       &conflict, &olen);
> >> > +   if (ret < 0) {
> >> > +           dev_dbg(&dln2->pdev->dev, "Problem in %s(%d)\n",
> >> > +                   __func__, (int)enable);
> >> > +           return ret;
> >> > +   }
> >> > +   if (enable && olen < sizeof(conflict))
> >> > +           return -EPROTO;
> >> > +
> >> > +   return 0;
> >> > +}
> >> > +
> >> > +/*
> >> > + * ADC channels are lazily enabled due to the pins being shared with GPIO
> >> > + * channels. Enabling channels requires taking the ADC port offline, specifying
> >> > + * the resolution, individually enabling channels, then putting the port back
> >> > + * online. If GPIO pins have already been exported by gpio_dln2, EINVAL is
> >> > + * reported.
> >> > + */  
> > Ah, now it's all starting to make sense.  Let me check I have this right.
> >
> > 1) You have an 8 channel adc.
> > 2) You can only (or it's more efficient) to read all 8 channels at once.
> > 3) As the pins are shared, not all 8 channels are actually wired to anything.
> > 4) This prevents you just using an available_scan_mask entry to enable them all.
> >    Hence you have rolled your own demux.  If you need to do this quick then
> >    take a look at the precomputed mux tables in the core.  If not I guess
> >    what you have works fine.  
> Yes, that code was borrowed from the simple dummy example module.
> I'm new to IIO, so I didn't realize a more efficient remuxing
> mechanism was available. I can look into integrating that on
> Monday.
I'm thinking it's a non starter because of the lazy enabling, but maybe
there is some way to make it work.
> >> > +static int dln2_adc_update_enabled_chans(struct dln2_adc *dln2)
> >> > +{
> >> > +   int ret, i, chan_count;
> >> > +   struct iio_dev *indio_dev;
> >> > +
> >> > +   if (dln2->chans_enabled == dln2->chans_requested)
> >> > +           return 0;
> >> > +
> >> > +   indio_dev = platform_get_drvdata(dln2->pdev);
> >> > +   chan_count = indio_dev->num_channels;
> >> > +
> >> > +   if (dln2->port_enabled) {
> >> > +           ret = dln2_adc_set_port_enabled(dln2, false);
> >> > +           if (ret < 0)
> >> > +                   return ret;
> >> > +           dln2->port_enabled = false;
> >> > +   }
> >> > +
> >> > +   if (!dln2->resolution_set) {
> >> > +           ret = dln2_adc_set_port_resolution(dln2);
> >> > +           if (ret < 0)
> >> > +                   return ret;
> >> > +           dln2->resolution_set = true;
> >> > +   }
> >> > +
> >> > +   for (i = 0; i < chan_count; ++i) {
> >> > +           bool requested = dln2->chans_requested & (1 << i);
> >> > +           bool enabled = dln2->chans_enabled & (1 << i);
> >> > +
> >> > +           if (requested == enabled)
> >> > +                   continue;
> >> > +           ret = dln2_adc_set_chan_enabled(dln2, i, requested);
> >> > +           if (ret < 0)
> >> > +                   return ret;
> >> > +   }
> >> > +
> >> > +   dln2->chans_enabled = dln2->chans_requested;
> >> > +
> >> > +   ret = dln2_adc_set_port_enabled(dln2, true);
> >> > +   if (ret < 0)
> >> > +           return ret;
> >> > +   dln2->port_enabled = true;
> >> > +
> >> > +   return 0;
> >> > +}
> >> > +
> >> > +static int dln2_adc_get_chan_freq(struct dln2_adc *dln2, unsigned int channel)
> >> > +{
> >> > +   int ret;
> >> > +   struct dln2_adc_port_chan port_chan = {
> >> > +           .port = dln2->port,
> >> > +           .chan = channel,
> >> > +   };
> >> > +   struct {
> >> > +           __u8 type;
> >> > +           __le16 period;
> >> > +           __le16 low;
> >> > +           __le16 high;
> >> > +   } __packed get_cfg;
> >> > +   int olen = sizeof(get_cfg);
> >> > +
> >> > +   ret = dln2_transfer(dln2->pdev, DLN2_ADC_CHANNEL_GET_CFG,
> >> > +                       &port_chan, sizeof(port_chan), &get_cfg, &olen);
> >> > +   if (ret < 0) {
> >> > +           dev_dbg(&dln2->pdev->dev, "Problem in %s\n", __func__);
> >> > +           return ret;
> >> > +   }
> >> > +   if (olen < sizeof(get_cfg))
> >> > +           return -EPROTO;
> >> > +
> >> > +   return get_cfg.period;  
> > Returning a value called period for a function claiming to be reading the
> > frequency is unusual. It's got to be converted to the frequency.  
> Yea, I screwed up there. Diolan's command interface uses periods
> in milliseconds so I'll make sure the necessary reciprocal gets
> put in and the function is clearly named.
> >> > +}
> >> > +
> >> > +static int dln2_adc_set_chan_freq(struct dln2_adc *dln2, unsigned int channel,
> >> > +                             unsigned int freq)
> >> > +{
> >> > +   int ret;
> >> > +   struct {
> >> > +           struct dln2_adc_port_chan port_chan;
> >> > +           __u8 type;
> >> > +           __le16 period;
> >> > +           __le16 low;
> >> > +           __le16 high;
> >> > +   } __packed set_cfg = {
> >> > +           .port_chan.port = dln2->port,
> >> > +           .port_chan.chan = channel,
> >> > +           .type = freq ? DLN2_ADC_EVENT_ALWAYS : DLN2_ADC_EVENT_NONE,
> >> > +           .period = cpu_to_le16(freq)
> >> > +   };
> >> > +
> >> > +   ret = dln2_transfer_tx(dln2->pdev, DLN2_ADC_CHANNEL_SET_CFG,
> >> > +                          &set_cfg, sizeof(set_cfg));
> >> > +   if (ret < 0) {
> >> > +           dev_dbg(&dln2->pdev->dev, "Problem in %s\n", __func__);
> >> > +           return ret;
> >> > +   }
> >> > +   return 0;
> >> > +}
> >> > +
> >> > +static int dln2_adc_read(struct dln2_adc *dln2, unsigned int channel)
> >> > +{
> >> > +   int ret;
> >> > +   int old_chans_requested = dln2->chans_requested;
> >> > +
> >> > +   dln2->chans_requested |= (1 << channel);  
> > Ah, so this changes the enabled channels and can lead to the
> > changes in what is enabled when buffered mode is going on.
> >
> > I'd just use the iio_claim_direct_mode set of functions
> > to prevent direct reads when the buffer is operating.
> > They add a lot of complexity for what is usually a fairly
> > unusual requirement.  
> Will do.
> >> > +   ret = dln2_adc_update_enabled_chans(dln2);
> >> > +   if (ret < 0) {
> >> > +           dln2->chans_requested = old_chans_requested;
> >> > +           return ret;
> >> > +   }
> >> > +   dln2->port_enabled = true;
> >> > +
> >> > +   struct dln2_adc_port_chan port_chan = {
> >> > +           .port = dln2->port,
> >> > +           .chan = channel,
> >> > +   };
> >> > +   __le16 value;
> >> > +   int olen = sizeof(value);
> >> > +
> >> > +   ret = dln2_transfer(dln2->pdev, DLN2_ADC_CHANNEL_GET_VAL,
> >> > +                       &port_chan, sizeof(port_chan), &value, &olen);
> >> > +   if (ret < 0) {
> >> > +           dev_dbg(&dln2->pdev->dev, "Problem in %s\n", __func__);
> >> > +           return ret;
> >> > +   }
> >> > +   if (olen < sizeof(value))
> >> > +           return -EPROTO;
> >> > +
> >> > +   return le16_to_cpu(value);
> >> > +}
> >> > +
> >> > +static int dln2_adc_read_all(struct dln2_adc *dln2,
> >> > +                        struct dln2_adc_get_all_vals *get_all_vals)
> >> > +{
> >> > +   int ret;
> >> > +   __u8 port = dln2->port;
> >> > +   int olen = sizeof(*get_all_vals);
> >> > +
> >> > +   ret = dln2_transfer(dln2->pdev, DLN2_ADC_CHANNEL_GET_ALL_VAL,
> >> > +                       &port, sizeof(port), get_all_vals, &olen);  
> > Getting channels that aren't wired to anything?  Fair enough if true,
> > but unusual.  
> I had the same thought myself; the adc example in Diolan's
> package reads in a fixed 8 channels every time, apparently
> zeroing the disabled ones.
It would make their firmware simpler probably.  Push the complexity to
the more powerful main processor.
> >> > +   if (ret < 0) {
> >> > +           dev_dbg(&dln2->pdev->dev, "Problem in %s\n", __func__);
> >> > +           return ret;
> >> > +   }
> >> > +   if (olen < sizeof(*get_all_vals))
> >> > +           return -EPROTO;
> >> > +
> >> > +   return 0;
> >> > +}
> >> > +
> >> > +static int dln2_adc_read_raw(struct iio_dev *indio_dev,
> >> > +                        struct iio_chan_spec const *chan,
> >> > +                        int *val,
> >> > +                        int *val2,
> >> > +                        long mask)
> >> > +{
> >> > +   int ret;
> >> > +   struct dln2_adc *dln2 = iio_priv(indio_dev);
> >> > +
> >> > +   switch (mask) {
> >> > +   case IIO_CHAN_INFO_RAW:
> >> > +           mutex_lock(&dln2->mutex);
> >> > +           ret = dln2_adc_read(dln2, chan->channel);
> >> > +           mutex_unlock(&dln2->mutex);
> >> > +
> >> > +           if (ret < 0)
> >> > +                   return ret;
> >> > +
> >> > +           *val = ret;
> >> > +           return IIO_VAL_INT;
> >> > +
> >> > +   case IIO_CHAN_INFO_SCALE:
> >> > +           *val = 0;
> >> > +           /* 3.3 / (1 << 10) * 1000000000 */
> >> > +           *val2 = 3222656;
> >> > +           return IIO_VAL_INT_PLUS_NANO;
> >> > +
> >> > +   case IIO_CHAN_INFO_SAMP_FREQ:
> >> > +           mutex_lock(&dln2->mutex);
> >> > +           if (dln2->trigger_chan == -1)
> >> > +                   ret = 0;
> >> > +           else
> >> > +                   ret = dln2_adc_get_chan_freq(dln2, dln2->trigger_chan);
> >> > +           mutex_unlock(&dln2->mutex);
> >> > +
> >> > +           if (ret < 0)
> >> > +                   return ret;
> >> > +
> >> > +           *val = ret / 1000;
> >> > +           *val2 = (ret % 1000) * 1000;
> >> > +           return IIO_VAL_INT_PLUS_MICRO;
> >> > +
> >> > +   default:
> >> > +           return -EINVAL;
> >> > +   }
> >> > +}
> >> > +
> >> > +static int dln2_adc_write_raw(struct iio_dev *indio_dev,
> >> > +                         struct iio_chan_spec const *chan,
> >> > +                         int val,
> >> > +                         int val2,
> >> > +                         long mask)
> >> > +{
> >> > +   int ret;
> >> > +   unsigned int freq;
> >> > +   struct dln2_adc *dln2 = iio_priv(indio_dev);
> >> > +
> >> > +   switch (mask) {
> >> > +   case IIO_CHAN_INFO_SAMP_FREQ:
> >> > +           freq = val * 1000 + val2 / 1000;
> >> > +           if (freq > 65535) {
> >> > +                   freq = 65535;
> >> > +                   dev_warn(&dln2->pdev->dev,
> >> > +                            "clamping freq to 65535ms\n");  
> > frequency measured in a unit of time?  
> Will fix Monday
> >> > +           }
> >> > +           mutex_lock(&dln2->mutex);
> >> > +
> >> > +           /*
> >> > +            * The first requested channel is arbitrated as a shared
> >> > +            * trigger source, so only one event is registered with the DLN.
> >> > +            * The event handler will then read all enabled channel values
> >> > +            * using DLN2_ADC_CHANNEL_GET_ALL_VAL to maintain
> >> > +            * synchronization between ADC readings.
> >> > +            */
> >> > +           if (dln2->trigger_chan == -1)
> >> > +                   dln2->trigger_chan = chan->channel;  
> > This looks dangerous. either it is always fine to use a random channel or it's
> > not...
> >
> > I'd cache the frequency and only actually set it when bringing up the buffer
> > - that way if the setup is sane you will have a channel.  
> Fair point, I'll refactor it that way.
> >> > +           ret = dln2_adc_set_chan_freq(dln2, dln2->trigger_chan, freq);
> >> > +
> >> > +           mutex_unlock(&dln2->mutex);
> >> > +
> >> > +           if (ret < 0)
> >> > +                   return ret;
> >> > +
> >> > +           return 0;  
> > Just return ret and loose the other path.  I chased through the code
> > and we get 0 for success.  
> Ok
> >> > +
> >> > +   default:
> >> > +           return -EINVAL;
> >> > +   }
> >> > +}
> >> > +
> >> > +#define DLN2_ADC_CHAN(idx) {                                       \
> >> > +   .type = IIO_VOLTAGE,                                    \
> >> > +   .channel = idx,                                         \
> >> > +   .indexed = 1,                                           \
> >> > +   .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),           \
> >> > +   .info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SCALE) |   \
> >> > +                              BIT(IIO_CHAN_INFO_SAMP_FREQ),\
> >> > +   .scan_index = idx,                                      \  
> > .scan_type = {
> >         .sign = 'u', etc is easier to read.  
> Ok
> >> > +   .scan_type.sign = 'u',                                  \
> >> > +   .scan_type.realbits = DLN2_ADC_DATA_BITS,               \
> >> > +   .scan_type.storagebits = 16,                            \
> >> > +   .scan_type.endianness = IIO_LE,                         \
> >> > +}
> >> > +
> >> > +static const struct iio_chan_spec dln2_adc_iio_channels[] = {
> >> > +   DLN2_ADC_CHAN(0),
> >> > +   DLN2_ADC_CHAN(1),
> >> > +   DLN2_ADC_CHAN(2),
> >> > +   DLN2_ADC_CHAN(3),
> >> > +   DLN2_ADC_CHAN(4),
> >> > +   DLN2_ADC_CHAN(5),
> >> > +   DLN2_ADC_CHAN(6),
> >> > +   DLN2_ADC_CHAN(7),
> >> > +   IIO_CHAN_SOFT_TIMESTAMP(8),
> >> > +};
> >> > +
> >> > +static const struct iio_info dln2_adc_info = {
> >> > +   .read_raw = dln2_adc_read_raw,
> >> > +   .write_raw = dln2_adc_write_raw,
> >> > +   .driver_module = THIS_MODULE,
> >> > +};
> >> > +
> >> > +static irqreturn_t dln2_adc_trigger_h(int irq, void *p)
> >> > +{
> >> > +   struct iio_poll_func *pf = p;
> >> > +   struct iio_dev *indio_dev = pf->indio_dev;
> >> > +   struct {
> >> > +           __le16 values[DLN2_ADC_MAX_CHANNELS];
> >> > +           int64_t timestamp_space;
> >> > +   } data;
> >> > +   struct dln2_adc_get_all_vals dev_data;
> >> > +   struct dln2_adc *dln2 = iio_priv(indio_dev);
> >> > +   int old_chans_requested;
> >> > +   int i, j;
> >> > +
> >> > +   mutex_lock(&dln2->mutex);
> >> > +
> >> > +   old_chans_requested = dln2->chans_requested;
> >> > +   dln2->chans_requested |= *indio_dev->active_scan_mask;
> >> > +   if (dln2_adc_update_enabled_chans(dln2) < 0) {
> >> > +           dln2->chans_requested = old_chans_requested;  
> > I'm confused. Why would this change here?  Shouldn't change
> > whilst data is being captured unless something very odd is going on.
> > Ah, found it - you want to allow sysfs reads at the same time.
> > Given the complexity required to do that safely, I'd just not
> > do it for now - maybe add it as a follow up patch later.  
> >> > +           mutex_unlock(&dln2->mutex);
> >> > +           goto done;
> >> > +   }
> >> > +
> >> > +   if (dln2_adc_read_all(dln2, &dev_data) < 0) {
> >> > +           mutex_unlock(&dln2->mutex);
> >> > +           goto done;
> >> > +   }
> >> > +
> >> > +   mutex_unlock(&dln2->mutex);
> >> > +
> >> > +   for (i = 0, j = 0;  
> >
> > Having found the note about lazy enabling above I think I now
> > understand what you are doing here.  You can't use the
> > core infrastructure and set available_scan_masks to 0x1FF because
> > that would result in enabling all the pins, some of which are wanted
> > for gpio usage perhaps.
> >
> > Hence you end up rolling your own demux.  You are reading all
> > the ADC channels, but some aren't necessarily connected to any actual
> > pins.
> >  
> Precisely. The lazy enabling adapts to the demand of the user.
> Since IIO doesn't really have an export mechanism like the GPIO
> subsystem, I can't preemptively enable channels unless I make the
> driver buffer-only (which I'd rather not do cause direct reads
> come in handy).
one of those fiddly 'boundary' cases for defining connectivity.
If we were talking hard wired pins on a board this would all go
in device tree, but in reality most of the time we have
no idea what is connected to a given DLN2.
> >> > +        i < bitmap_weight(indio_dev->active_scan_mask,
> >> > +                          indio_dev->masklength); i++, j++) {
> >> > +           j = find_next_bit(indio_dev->active_scan_mask,
> >> > +                             indio_dev->masklength, j);
> >> > +           data.values[i] = dev_data.values[j];
> >> > +   }
> >> > +
> >> > +   iio_push_to_buffers_with_timestamp(indio_dev, &data,
> >> > +                                      iio_get_time_ns(indio_dev));
> >> > +
> >> > +done:
> >> > +   iio_trigger_notify_done(indio_dev->trig);
> >> > +   return IRQ_HANDLED;
> >> > +}
> >> > +
> >> > +static int dln2_adc_triggered_buffer_postenable(struct iio_dev *indio_dev)
> >> > +{
> >> > +   int ret;
> >> > +   struct dln2_adc *dln2 = iio_priv(indio_dev);
> >> > +
> >> > +   mutex_lock(&dln2->mutex);
> >> > +   dln2->chans_requested |= *indio_dev->active_scan_mask;  
> > Perhaps should be in the update_scan_mask callback rather than here?
> > You could have multiple consumers of this data which would cause
> > this path to be 'interesting'.
> >
> > I'm also a little curious to know why it isn't just an =
> > Also why don't you want to disable them when then buffer is disabled.  
> This allows the enabled channels to remain enabled if the user
> opts for direct raw reads. If I were to enable a channel
> temporarily for a raw read, that's 6 or 7 synchronous commands:
> - Set resolution (if not already done)
> - Enable channel
> - Enable port
> - Get value
> - Get value (a second one is needed because the first read after
>   enabling always seems to return 0, must be a firmware bug)
> - Disable port
> - Disable channel
> 
> This just strikes me as inefficient, but it would be more
> consistent state-wise. If you think this is an ok trade-off,
> I'll go for the enable/disable approach. I suppose it's also
> possible to reset the lazy channel mask when the user exits
> buffered mode. The initial zero-return after enabling channels is
> a real kicker, and makes me want to keep disables/enables to a
> minimum.
That is a pain.  Still more consistent to clear the channel mask
again after a buffer disable + prevent single channel reads
whilst it is running.  At least, do this for the first merge
of the driver then we can revisit if you have a usecase
where the juggling is really necessary.

> >> > +   ret = dln2_adc_update_enabled_chans(dln2);
> >> > +   mutex_unlock(&dln2->mutex);
> >> > +   if (ret < 0) {
> >> > +           dev_dbg(&dln2->pdev->dev, "Problem in %s\n", __func__);
> >> > +           return ret;
> >> > +   }
> >> > +
> >> > +   return iio_triggered_buffer_postenable(indio_dev);
> >> > +}
> >> > +
> >> > +static const struct iio_buffer_setup_ops dln2_adc_buffer_setup_ops = {
> >> > +   .postenable = dln2_adc_triggered_buffer_postenable,
> >> > +   .predisable = iio_triggered_buffer_predisable,
> >> > +};
> >> > +
> >> > +static void dln2_adc_event(struct platform_device *pdev, u16 echo,
> >> > +                      const void *data, int len)
> >> > +{
> >> > +   struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> >> > +   struct dln2_adc *dln2 = iio_priv(indio_dev);
> >> > +
> >> > +   iio_trigger_poll(dln2->trig);  
> > Is this in interrupt context?
> > if not should be iio_trigger_poll_chained(dln2->trig);  
> I'll double check that on Monday, the MFD code would determine
> that.
> >> > +}
> >> > +
> >> > +static const struct iio_trigger_ops dln2_adc_trigger_ops = {
> >> > +   .owner = THIS_MODULE,  
> > Hohum.  Patch set to remove the need for this is waiting for me
> > to get around to revising it.  Interestingly checking why you
> > had this at all lead me to a check in the trigger register that
> > I wasn't getting rid of in that patch set. oops.
> >
> > Upshot is that the equivalent is done via macro magic rather
> > than an explicit entry in this structure.  It's possible this
> > driver will cross with that series, in which case we'll get
> > some build issues that will need fixing up.  I'll hopefully
> > remember to deal with them when applying though.  
> >> > +};
> >> > +
> >> > +static int dln2_adc_probe(struct platform_device *pdev)
> >> > +{
> >> > +   struct device *dev = pdev->dev;
> >> > +   struct dln2_adc *dln2;
> >> > +   struct dln2_platform_data *pdata = dev_get_platdata(&pdev->dev);
> >> > +   struct iio_dev *indio_dev;
> >> > +   struct iio_buffer *buffer;
> >> > +   int ret;
> >> > +   int chans;
> >> > +
> >> > +   indio_dev = devm_iio_device_alloc(dev, sizeof(struct dln2_adc));  
> > Slight preference for sizeof(*dln2)  
> Agreed
> >> > +   if (!indio_dev) {
> >> > +           dev_err(dev, "failed allocating iio device\n");
> >> > +           return -ENOMEM;
> >> > +   }
> >> > +
> >> > +   dln2 = iio_priv(indio_dev);
> >> > +   dln2->pdev = pdev;
> >> > +   dln2->port = pdata->port;
> >> > +   mutex_init(&dln2->mutex);
> >> > +   dln2->port_enabled = false;
> >> > +   dln2->resolution_set = false;
> >> > +   dln2->chans_requested = 0;
> >> > +   dln2->chans_enabled = 0;
> >> > +   dln2->trigger_chan = -1;  
> > This is fine at setup, but isn't reset to -1 if the channels are all disabled.  
> Ok
> >> > +
> >> > +   platform_set_drvdata(pdev, indio_dev);
> >> > +
> >> > +   chans = dln2_adc_get_chan_count(dln2);
> >> > +   if (chans < 0) {
> >> > +           dev_err(dev, "failed to get channel count: %d\n", chans);
> >> > +           ret = chans;
> >> > +           goto dealloc_dev;
> >> > +   }
> >> > +   if (chans > DLN2_ADC_MAX_CHANNELS) {
> >> > +           chans = DLN2_ADC_MAX_CHANNELS;
> >> > +           dev_warn(dev, "clamping channels to %d\n",
> >> > +                    DLN2_ADC_MAX_CHANNELS);
> >> > +   }
> >> > +
> >> > +   indio_dev->name = DLN2_ADC_MOD_NAME;
> >> > +   indio_dev->dev.parent = dev;
> >> > +   indio_dev->info = &dln2_adc_info;
> >> > +   indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_TRIGGERED;
> >> > +   indio_dev->channels = dln2_adc_iio_channels;
> >> > +   indio_dev->num_channels = chans + 1;  
> > Why +1?  Presumably to include the timestamp.  I guess this
> > means that the code that gets the channel count always gets 8.
> > You need to check that if you are going to use a const channel array.  
> Yea, I see in the docs that's supposed to be monotonic.
> I'll assemble that array on the stack instead at probe time to be
> safe.
> >> > +   indio_dev->setup_ops = &dln2_adc_buffer_setup_ops;
> >> > +
> >> > +   dln2->trig = devm_iio_trigger_alloc(dev, "samplerate");  
> > Interesting naming for a trigger... rather too generic + doesn't
> > cope with multiple dln2's connect to same machine. Admittedly
> > a number of historical drivers have that problem but we can't
> > fix them now without ABI breakage.
> >  
> Good point, is there a preferred unique identifier to suffix that
> name?
we've never restricted this particularly as it's just a magic string
to match things up.

Quite a few drivers stick with "magicname-dev%d",  ..., indio_dev->id 
> >> > +   if (!dln2->trig) {
> >> > +           dev_err(dev, "failed to allocate trigger\n");
> >> > +           ret = -ENOMEM;
> >> > +           goto dealloc_dev;
> >> > +   }
> >> > +   dln2->trig->ops = &dln2_adc_trigger_ops;
> >> > +   iio_trigger_set_drvdata(dln2->trig, dln2);
> >> > +   iio_trigger_register(dln2->trig);
> >> > +   iio_trigger_set_immutable(indio_dev, dln2->trig);
> >> > +
> >> > +   buffer = devm_iio_kfifo_allocate(dev);
> >> > +   if (!buffer) {
> >> > +           dev_err(dev, "failed to allocate kfifo\n");
> >> > +           ret = -ENOMEM;
> >> > +           goto dealloc_trigger;
> >> > +   }
> >> > +
> >> > +   iio_device_attach_buffer(indio_dev, buffer);
> >> > +
> >> > +   indio_dev->pollfunc = iio_alloc_pollfunc(NULL,
> >> > +                                            &dln2_adc_trigger_h,
> >> > +                                            IRQF_ONESHOT,
> >> > +                                            indio_dev,
> >> > +                                            "samplerate");  
> > Again very generic naming + shouldn't be the same as the trigger name.
> > Almost no drivers do this manually any more.  Why does the
> > iio_triggered_buffer_setup boilerplate function not work here?  
> I read about this in the IIO presentation from back when the
> subsystem was first introduced. Didn't realize it was
> depreciated.
It's not deprecated as such, just that there are utility functions
to make the job easier if you happen to fit with the standard forms.
Just code repetition reduction really.  This approach may still
be necessary if something more 'interesting' is going on.
> >> > +
> >> > +   if (!indio_dev->pollfunc) {
> >> > +           ret = -ENOMEM;
> >> > +           goto dealloc_kfifo;
> >> > +   }
> >> > +
> >> > +   ret = dln2_register_event_cb(pdev, DLN2_ADC_CONDITION_MET_EV,
> >> > +                                dln2_adc_event);
> >> > +   if (ret) {
> >> > +           dev_err(dev, "failed to register event cb: %d\n", ret);
> >> > +           goto dealloc_pollfunc;
> >> > +   }
> >> > +
> >> > +   ret = iio_device_register(indio_dev);
> >> > +   if (ret) {
> >> > +           dev_err(dev, "failed to register iio device: %d\n", ret);
> >> > +           goto dealloc_pollfunc;
> >> > +   }
> >> > +
> >> > +   return 0;
> >> > +
> >> > +dealloc_pollfunc:
> >> > +   iio_dealloc_pollfunc(indio_dev->pollfunc);
> >> > +dealloc_kfifo:
> >> > +dealloc_trigger:
> >> > +   iio_trigger_unregister(dln2->trig);
> >> > +dealloc_dev:
> >> > +
> >> > +   return ret;
> >> > +}
> >> > +
> >> > +static int dln2_adc_remove(struct platform_device *pdev)
> >> > +{
> >> > +   struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> >> > +   struct dln2_adc *dln2 = iio_priv(indio_dev);
> >> > +
> >> > +   iio_device_unregister(indio_dev);
> >> > +   dln2_unregister_event_cb(pdev, DLN2_ADC_CONDITION_MET_EV);
> >> > +   iio_trigger_unregister(dln2->trig);
> >> > +   iio_dealloc_pollfunc(indio_dev->pollfunc);
> >> > +
> >> > +   return 0;
> >> > +}
> >> > +
> >> > +static struct platform_driver dln2_adc_driver = {
> >> > +   .driver.name    = DLN2_ADC_MOD_NAME,
> >> > +   .probe          = dln2_adc_probe,
> >> > +   .remove         = dln2_adc_remove,
> >> > +};
> >> > +
> >> > +module_platform_driver(dln2_adc_driver);
> >> > +
> >> > +MODULE_AUTHOR("Jack Andersen <jackoalan@gmail.com");
> >> > +MODULE_DESCRIPTION("Driver for the Diolan DLN2 ADC interface");
> >> > +MODULE_LICENSE("GPL v2");
> >> > +MODULE_ALIAS("platform:dln2-adc");
> >> > diff --git a/drivers/mfd/dln2.c b/drivers/mfd/dln2.c
> >> > index 704e189..a22ab8c 100644
> >> > --- a/drivers/mfd/dln2.c
> >> > +++ b/drivers/mfd/dln2.c
> >> > @@ -53,6 +53,7 @@ enum dln2_handle {
> >> >     DLN2_HANDLE_GPIO,
> >> >     DLN2_HANDLE_I2C,
> >> >     DLN2_HANDLE_SPI,
> >> > +   DLN2_HANDLE_ADC,
> >> >     DLN2_HANDLES
> >> >  };
> >> >
> >> > @@ -663,6 +664,12 @@ static int dln2_start_rx_urbs(struct dln2_dev *dln2, gfp_t gfp)
> >> >     .port = 0,
> >> >  };
> >> >
> >> > +/* Only one ADC port supported */
> >> > +static struct dln2_platform_data dln2_pdata_adc = {
> >> > +   .handle = DLN2_HANDLE_ADC,
> >> > +   .port = 0,
> >> > +};
> >> > +
> >> >  static const struct mfd_cell dln2_devs[] = {
> >> >     {
> >> >             .name = "dln2-gpio",
> >> > @@ -679,6 +686,11 @@ static int dln2_start_rx_urbs(struct dln2_dev *dln2, gfp_t gfp)
> >> >             .platform_data = &dln2_pdata_spi,
> >> >             .pdata_size = sizeof(struct dln2_platform_data),
> >> >     },
> >> > +   {
> >> > +           .name = "dln2-adc",
> >> > +           .platform_data = &dln2_pdata_adc,
> >> > +           .pdata_size = sizeof(struct dln2_platform_data),
> >> > +   },
> >> >  };
> >> >
> >> >  static void dln2_stop(struct dln2_dev *dln2)
> >> >  
> >>  
> >  

