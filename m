Return-Path: <mwelling79@gmail.com>
Sender: Michael Welling <mwelling79@gmail.com>
Date: Mon, 8 Feb 2016 14:06:21 -0600
From: Michael Welling <mwelling@ieee.org>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Sricharan <sricharan@codeaurora.org>,
	'Daniel Baluta' <daniel.baluta@intel.com>,
	'Jonathan Cameron' <jic23@kernel.org>,
	'Hartmut Knaack' <knaack.h@gmx.de>,
	'Lars-Peter Clausen' <lars@metafoo.de>,
	'Peter Meerwald-Stadler' <pmeerw@pmeerw.net>,
	'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>,
	linux-iio@vger.kernel.org,
	'Lucas De Marchi' <lucas.demarchi@intel.com>,
	'Andy Gross' <agross@codeaurora.org>,
	'Pramod Gurav' <pramod.gurav@smartplayin.com>,
	'Bjorn Andersson' <bjorn.andersson@sonymobile.com>,
	'Guenter Roeck' <linux@roeck-us.net>, eibach@gdsys.de,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4] iio: adc: Add TI ADS1015 ADC driver support
Message-ID: <20160208200621.GA28017@deathstar>
References: <1454678238-16313-1-git-send-email-daniel.baluta@intel.com>
 <20160205172457.GA16778@deathstar>
 <CAEnQRZAjgn3Y0618MgO284DMc_9cE49b9jeUr0j2HwUK6YK+0A@mail.gmail.com>
 <20160206003245.GA1329@deathstar>
 <20160208102459.GC2220@tetsubishi>
 <20160208163632.GA3630@deathstar>
 <01fd01d162a4$8e28c450$aa7a4cf0$@codeaurora.org>
 <20160208191658.GA23145@deathstar>
 <20160208200027.GA1997@tetsubishi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160208200027.GA1997@tetsubishi>
List-ID: <linux-iio@vger.kernel.org>

On Mon, Feb 08, 2016 at 09:00:27PM +0100, Wolfram Sang wrote:
> > > > On Mon, Feb 08, 2016 at 11:25:00AM +0100, Wolfram Sang wrote:
> > > > > On Fri, Feb 05, 2016 at 06:32:45PM -0600, Michael Welling wrote:
> > > > > > On Fri, Feb 05, 2016 at 09:32:34PM +0200, Daniel Baluta wrote:
> > > > > > > >> +static int ads1015_read_raw(struct iio_dev *indio_dev,
> > > > > > > >> +                         struct iio_chan_spec const *chan, int
> 
> Guys, please quote only relevant sections.
>

Sorry. 

> >                          pca: pca@40 {
> >                                  compatible = "nxp,pca9685-pwm";
> >                                  #pwm-cells = <2>;
> >                                  reg = <0x40>;
> >                          };
> 
> Does accessing the pca work?
> 

Yes.

https://plus.google.com/+MichaelWelling79/posts/PdmGysBfZp4
