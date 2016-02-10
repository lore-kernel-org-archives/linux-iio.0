Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:52580 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750997AbcBJPJk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 10 Feb 2016 10:09:40 -0500
From: "Sricharan" <sricharan@codeaurora.org>
To: "'Daniel Baluta'" <daniel.baluta@intel.com>
Cc: "'Michael Welling'" <mwelling@ieee.org>,
	"'Wolfram Sang'" <wsa@the-dreams.de>,
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
References: <1454678238-16313-1-git-send-email-daniel.baluta@intel.com>	<20160205172457.GA16778@deathstar>	<CAEnQRZAjgn3Y0618MgO284DMc_9cE49b9jeUr0j2HwUK6YK+0A@mail.gmail.com>	<20160206003245.GA1329@deathstar>	<20160208102459.GC2220@tetsubishi>	<20160208163632.GA3630@deathstar>	<01fd01d162a4$8e28c450$aa7a4cf0$@codeaurora.org>	<20160208191658.GA23145@deathstar>	<001b01d163fd$bfb15280$3f13f780$@codeaurora.org> <CAEnQRZCzkq5wFsS7Ydby+bsFJTbGVq=AX9TLkkhfMKOG8gAZHA@mail.gmail.com>
In-Reply-To: <CAEnQRZCzkq5wFsS7Ydby+bsFJTbGVq=AX9TLkkhfMKOG8gAZHA@mail.gmail.com>
Subject: RE: [PATCH v4] iio: adc: Add TI ADS1015 ADC driver support
Date: Wed, 10 Feb 2016 20:39:04 +0530
Message-ID: <003201d16415$0eb1a8f0$2c14fad0$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

<snip>...

> >> > > > >
> >> > > > > Indeed it is the pm_runtime_get_sync that fails with a -EINVAL.
> >> > > > >
> >> > > > > > >
> >> > > > > > > When I comment out the break the readings come back but
> >> > > > > > > are not
> >> > > updated continually.
> >> > > > > > > If I read in_voltage0-voltage1_raw then in_voltage0_raw
> >> > > > > > > the value
> >> > is
> >> > > updated.
> >> > > > > >
> >> > > > > > I guess this is normal if set_power_state fails.
> >> > > > >
> >> > > > > The hwmod driver works fine BTW.
> >> > > > >
> >> > > > > My guess is there is an issue with the qup i2c driver seeing
> >> > > > > as it has worked on other system without issue.
> >> > > > >
> >> > > > > CC'd some the latest developer on the qup i2c driver.
> >> > > > >
> >> > > > > I2C guys have any ideas on this?
> >> > > > >
> >> > > >
> >> > > > Adding some more people who recently worked on this. Might be
> >> > > > nice to know which kernel version you are using.
> >> > > >
> >> >  Which i2c bus is this connected to ? I can give a try with 410c to
> >> > see why pm_runtime_get_sync from qup  fails.
> >>
> >> It is on the lowspeed header. Here is my devicetree entry:
> >>
> >>                  i2c@78b6000 {
> >>                  /* On Low speed expansion */
> >>                          label = "LS-I2C0";
> >>                          status = "okay";
> >>
> >>                          pca: pca@40 {
> >>                                  compatible = "nxp,pca9685-pwm";
> >>                                  #pwm-cells = <2>;
> >>                                  reg = <0x40>;
> >>                          };
> >>
> >>                          adc: adc@48 {
> >>                                  compatible = "ti,ads1015";
> >>                                  reg = <0x48>;
> >>                          };
> >>                  };
> >
> > Whats the sequence in which the failure happens ?
> >
> > I tested on DB410c by adding the DT entry that you mentioned above on
> > 4.5-rc2 and rc3.
> > I see that the i2c transfers call from pca9685  during
> > pca9685_pwm_probe did go through and no failure from
> > pm_runtime_get_sync
> 
> Hi Sricharan,
> 
> Are you looking at pca9685_pwm_probe in drivers/pwm/pwm-pca9685.c
> right?
>
 Yes.
 
> I'm asking this because this driver doesn't seem to support runtime pm and
> there is no check for regmap_write/regmap_write return code in the probe
> function.
   Hmm to be clear, so it’s the pm_runtime_getsync from i2c-qup which fails right ?
   I was tracking that when there are i2c_xfers from pwm. I did not see any failures there.
   So wanted to know the correct sequence to reproduce.
  
Regards,
  Sricharan
  


