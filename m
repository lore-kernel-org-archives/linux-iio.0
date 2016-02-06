Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ig0-f195.google.com ([209.85.213.195]:36406 "EHLO
	mail-ig0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751037AbcBFAc7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 5 Feb 2016 19:32:59 -0500
Date: Fri, 5 Feb 2016 18:32:45 -0600
From: Michael Welling <mwelling@ieee.org>
To: Daniel Baluta <daniel.baluta@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Andy Gross <agross@codeaurora.org>,
	Wolfram Sang <wsa@the-dreams.de>,
	Pramod Gurav <pramod.gurav@smartplayin.com>,
	Bjorn Andersson <bjorn.andersson@sonymobile.com>,
	Guenter Roeck <linux@roeck-us.net>, eibach@gdsys.de
Subject: Re: [PATCH v4] iio: adc: Add TI ADS1015 ADC driver support
Message-ID: <20160206003245.GA1329@deathstar>
References: <1454678238-16313-1-git-send-email-daniel.baluta@intel.com>
 <20160205172457.GA16778@deathstar>
 <CAEnQRZAjgn3Y0618MgO284DMc_9cE49b9jeUr0j2HwUK6YK+0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAEnQRZAjgn3Y0618MgO284DMc_9cE49b9jeUr0j2HwUK6YK+0A@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Feb 05, 2016 at 09:32:34PM +0200, Daniel Baluta wrote:
> >> +static int ads1015_read_raw(struct iio_dev *indio_dev,
> >> +                         struct iio_chan_spec const *chan, int *val,
> >> +                         int *val2, long mask)
> >> +{
> >> +     int ret, idx;
> >> +     struct ads1015_data *data = iio_priv(indio_dev);
> >> +
> >> +     mutex_lock(&data->lock);
> >> +     switch (mask) {
> >> +     case IIO_CHAN_INFO_RAW:
> >> +             if (iio_buffer_enabled(indio_dev)) {
> >> +                     ret = -EBUSY;
> >> +                     break;
> >> +             }
> >> +
> >> +             ret = ads1015_set_power_state(data, true);
> >> +             if (ret < 0)
> >> +                     break;
> >
> > Just tested the driver on a Dragonboard 410C with a robotics mezzanine that I
> > designed.
> >
> > The above ads1015_set_power_state(data, true) is always returning -EINVAL.
> >
> > Any ideas why that would be happening?
> > I think it may be the return from pm_runtime_get_sync?
> 
> Can you confirm that pm_runtime_get_sync fails? Using some printk?
> 
> Also adding printks in suspend/resume function would be helpful. Do
> you have CONFIG_PM enabled?
>

Indeed it is the pm_runtime_get_sync that fails with a -EINVAL.

> >
> > When I comment out the break the readings come back but are not updated continually.
> > If I read in_voltage0-voltage1_raw then in_voltage0_raw the value is updated.
> 
> I guess this is normal if set_power_state fails.

The hwmod driver works fine BTW.

My guess is there is an issue with the qup i2c driver seeing as it has worked on
other system without issue.

CC'd some the latest developer on the qup i2c driver.

I2C guys have any ideas on this?

> 
> thanks,
> Daniel.
