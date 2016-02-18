Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:56980 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424633AbcBRIp6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 18 Feb 2016 03:45:58 -0500
From: "Sricharan" <sricharan@codeaurora.org>
To: "'Michael Welling'" <mwelling@ieee.org>
Cc: "'Daniel Baluta'" <daniel.baluta@intel.com>,
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
References: <CAEnQRZAjgn3Y0618MgO284DMc_9cE49b9jeUr0j2HwUK6YK+0A@mail.gmail.com> <20160206003245.GA1329@deathstar> <20160208102459.GC2220@tetsubishi> <20160208163632.GA3630@deathstar> <01fd01d162a4$8e28c450$aa7a4cf0$@codeaurora.org> <20160208191658.GA23145@deathstar> <001b01d163fd$bfb15280$3f13f780$@codeaurora.org> <CAEnQRZCzkq5wFsS7Ydby+bsFJTbGVq=AX9TLkkhfMKOG8gAZHA@mail.gmail.com> <003201d16415$0eb1a8f0$2c14fad0$@codeaurora.org> <20160210163622.GA1390@deathstar> <20160217235314.GA13145@deathstar>
In-Reply-To: <20160217235314.GA13145@deathstar>
Subject: RE: [PATCH v4] iio: adc: Add TI ADS1015 ADC driver support
Date: Thu, 18 Feb 2016 14:15:42 +0530
Message-ID: <000101d16a28$c7867950$56936bf0$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

> On Wed, Feb 10, 2016 at 10:36:22AM -0600, Michael Welling wrote:
> > On Wed, Feb 10, 2016 at 08:39:04PM +0530, Sricharan wrote:
> > > > Hi Sricharan,
> > > >
> > > > Are you looking at pca9685_pwm_probe in drivers/pwm/pwm-
> pca9685.c
> > > > right?
> > > >
> > >  Yes.
> > >
> > > > I'm asking this because this driver doesn't seem to support
> > > > runtime pm and there is no check for regmap_write/regmap_write
> > > > return code in the probe function.
> > >    Hmm to be clear, so it’s the pm_runtime_getsync from i2c-qup which
> fails right ?
> > >    I was tracking that when there are i2c_xfers from pwm. I did not see
> any failures there.
> > >    So wanted to know the correct sequence to reproduce.
> > >
> >
> > The problem was discovered using the patch that this thread is on. The
> > PWM driver does not have the problem.
> >
> > When the driver in this patch called pm_runtime_get_sync you got -EINVAL
> back.
> 
> I noticed some patches for the QUP I2C driver in linux-next so I built against
> it.
> 
> The ADC driver now appears to work as desired.
> 
   Ok, I suppose those were changes merged last week to add qup V2 tags support, but
   not sure how that is helping to solve the pm_runtime issue here. 

Regards,
  Sricharan

