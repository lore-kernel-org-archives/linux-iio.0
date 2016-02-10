Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:39281 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750749AbcBJMWt (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 10 Feb 2016 07:22:49 -0500
From: "Sricharan" <sricharan@codeaurora.org>
To: "'Michael Welling'" <mwelling@ieee.org>
Cc: "'Wolfram Sang'" <wsa@the-dreams.de>,
	"'Daniel Baluta'" <daniel.baluta@intel.com>,
	"'Jonathan Cameron'" <jic23@kernel.org>,
	"'Hartmut Knaack'" <knaack.h@gmx.de>,
	"'Lars-Peter Clausen'" <lars@metafoo.de>,
	"'Peter Meerwald-Stadler'" <pmeerw@pmeerw.net>,
	"'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
	<linux-iio@vger.kernel.org>,
	"'Lucas De Marchi'" <lucas.demarchi@intel.com>,
	"'Andy Gross'" <agross@codeaurora.org>,
	"'Pramod Gurav'" <pramod.gurav@smartplayin.com>,
	"'Bjorn Andersson'" <bjorn.andersson@sonymobile.com>,
	"'Guenter Roeck'" <linux@roeck-us.net>, <eibach@gdsys.de>,
	<linux-arm-msm@vger.kernel.org>
References: <1454678238-16313-1-git-send-email-daniel.baluta@intel.com> <20160205172457.GA16778@deathstar> <CAEnQRZAjgn3Y0618MgO284DMc_9cE49b9jeUr0j2HwUK6YK+0A@mail.gmail.com> <20160206003245.GA1329@deathstar> <20160208102459.GC2220@tetsubishi> <20160208163632.GA3630@deathstar> <01fd01d162a4$8e28c450$aa7a4cf0$@codeaurora.org> <20160208191658.GA23145@deathstar>
In-Reply-To: <20160208191658.GA23145@deathstar>
Subject: RE: [PATCH v4] iio: adc: Add TI ADS1015 ADC driver support
Date: Wed, 10 Feb 2016 17:52:37 +0530
Message-ID: <001b01d163fd$bfb15280$3f13f780$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

> -----Original Message-----
> From: linux-arm-msm-owner@vger.kernel.org [mailto:linux-arm-msm-
> owner@vger.kernel.org] On Behalf Of Michael Welling
> Sent: Tuesday, February 09, 2016 12:47 AM
> To: Sricharan
> Cc: 'Wolfram Sang'; 'Daniel Baluta'; 'Jonathan Cameron'; 'Hartmut Knaack';
> 'Lars-Peter Clausen'; 'Peter Meerwald-Stadler'; 'Linux Kernel Mailing
List';
> linux-iio@vger.kernel.org; 'Lucas De Marchi'; 'Andy Gross'; 'Pramod
Gurav';
> 'Bjorn Andersson'; 'Guenter Roeck'; eibach@gdsys.de; linux-arm-
> msm@vger.kernel.org
> Subject: Re: [PATCH v4] iio: adc: Add TI ADS1015 ADC driver support
> 
> On Tue, Feb 09, 2016 at 12:41:35AM +0530, Sricharan wrote:
> > Hi,
> >
> > > -----Original Message-----
> > > From: Michael Welling [mailto:mwelling79@gmail.com] On Behalf Of
> > > Michael Welling
> > > Sent: Monday, February 08, 2016 10:07 PM
> > > To: Wolfram Sang
> > > Cc: Daniel Baluta; Jonathan Cameron; Hartmut Knaack; Lars-Peter
> > > Clausen; Peter Meerwald-Stadler; Linux Kernel Mailing List;
> > linux-iio@vger.kernel.org;
> > > Lucas De Marchi; Andy Gross; Pramod Gurav; Bjorn Andersson; Guenter
> > > Roeck; eibach@gdsys.de; Sricharan R; linux-arm-msm@vger.kernel.org
> > > Subject: Re: [PATCH v4] iio: adc: Add TI ADS1015 ADC driver support
> > >
> > > On Mon, Feb 08, 2016 at 11:25:00AM +0100, Wolfram Sang wrote:
> > > > On Fri, Feb 05, 2016 at 06:32:45PM -0600, Michael Welling wrote:
> > > > > On Fri, Feb 05, 2016 at 09:32:34PM +0200, Daniel Baluta wrote:
> > > > > > >> +static int ads1015_read_raw(struct iio_dev *indio_dev,
> > > > > > >> +                         struct iio_chan_spec const *chan,
> > > > > > >> +int
> > *val,
> > > > > > >> +                         int *val2, long mask) {
> > > > > > >> +     int ret, idx;
> > > > > > >> +     struct ads1015_data *data = iio_priv(indio_dev);
> > > > > > >> +
> > > > > > >> +     mutex_lock(&data->lock);
> > > > > > >> +     switch (mask) {
> > > > > > >> +     case IIO_CHAN_INFO_RAW:
> > > > > > >> +             if (iio_buffer_enabled(indio_dev)) {
> > > > > > >> +                     ret = -EBUSY;
> > > > > > >> +                     break;
> > > > > > >> +             }
> > > > > > >> +
> > > > > > >> +             ret = ads1015_set_power_state(data, true);
> > > > > > >> +             if (ret < 0)
> > > > > > >> +                     break;
> > > > > > >
> > > > > > > Just tested the driver on a Dragonboard 410C with a robotics
> > > > > > > mezzanine that I designed.
> > > > > > >
> > > > > > > The above ads1015_set_power_state(data, true) is always
> > > > > > > returning
> > -
> > > EINVAL.
> > > > > > >
> > > > > > > Any ideas why that would be happening?
> > > > > > > I think it may be the return from pm_runtime_get_sync?
> > > > > >
> > > > > > Can you confirm that pm_runtime_get_sync fails? Using some
> printk?
> > > > > >
> > > > > > Also adding printks in suspend/resume function would be helpful.
> > > > > > Do you have CONFIG_PM enabled?
> > > > > >
> > > > >
> > > > > Indeed it is the pm_runtime_get_sync that fails with a -EINVAL.
> > > > >
> > > > > > >
> > > > > > > When I comment out the break the readings come back but are
> > > > > > > not
> > > updated continually.
> > > > > > > If I read in_voltage0-voltage1_raw then in_voltage0_raw the
> > > > > > > value
> > is
> > > updated.
> > > > > >
> > > > > > I guess this is normal if set_power_state fails.
> > > > >
> > > > > The hwmod driver works fine BTW.
> > > > >
> > > > > My guess is there is an issue with the qup i2c driver seeing as
> > > > > it has worked on other system without issue.
> > > > >
> > > > > CC'd some the latest developer on the qup i2c driver.
> > > > >
> > > > > I2C guys have any ideas on this?
> > > > >
> > > >
> > > > Adding some more people who recently worked on this. Might be nice
> > > > to know which kernel version you are using.
> > > >
> >  Which i2c bus is this connected to ? I can give a try with 410c to
> > see why pm_runtime_get_sync from qup  fails.
> 
> It is on the lowspeed header. Here is my devicetree entry:
> 
>                  i2c@78b6000 {
>                  /* On Low speed expansion */
>                          label = "LS-I2C0";
>                          status = "okay";
> 
>                          pca: pca@40 {
>                                  compatible = "nxp,pca9685-pwm";
>                                  #pwm-cells = <2>;
>                                  reg = <0x40>;
>                          };
> 
>                          adc: adc@48 {
>                                  compatible = "ti,ads1015";
>                                  reg = <0x48>;
>                          };
>                  };

Whats the sequence in which the failure happens ?

I tested on DB410c by adding the DT entry that you mentioned above on
4.5-rc2 and rc3.
I see that the i2c transfers call from pca9685  during  pca9685_pwm_probe
did
go through and no failure from pm_runtime_get_sync

Regards,
 Sricharan

