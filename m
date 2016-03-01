Return-Path: <mwelling79@gmail.com>
Sender: Michael Welling <mwelling79@gmail.com>
Date: Mon, 29 Feb 2016 19:16:34 -0600
From: Michael Welling <mwelling@ieee.org>
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: Daniel Baluta <daniel.baluta@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	lkml <linux-kernel@vger.kernel.org>, linux-iio@vger.kernel.org,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Guenter Roeck <linux@roeck-us.net>, eibach@gdsys.de
Subject: Re: [PATCH v4] iio: adc: Add TI ADS1015 ADC driver support
Message-ID: <20160301011634.GA18558@deathstar>
References: <1454678238-16313-1-git-send-email-daniel.baluta@intel.com>
 <20160301005032.GA15476@deathstar>
 <CAKi4VAKBOge=-DcT9S7+uZWUte3EFNQ95u-fHCudRXZHqYuE1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAKi4VAKBOge=-DcT9S7+uZWUte3EFNQ95u-fHCudRXZHqYuE1w@mail.gmail.com>
List-ID: <linux-iio@vger.kernel.org>

On Mon, Feb 29, 2016 at 10:09:10PM -0300, Lucas De Marchi wrote:
> On Mon, Feb 29, 2016 at 9:50 PM, Michael Welling <mwelling@ieee.org> wrote:
> > On Fri, Feb 05, 2016 at 03:17:18PM +0200, Daniel Baluta wrote:
> >> The driver has sysfs readings with runtime PM support for power saving.
> >> It also offers buffer support that can be used together with IIO software
> >> triggers.
> >>
> >
> > Daniel,
> >
> > So I noticed something yesterday while testing new boards.
> > The channels are occassionally swapping when accessing data from multiple channels.
> >
> > I wrote a simple bash script to demonstrate.
> 
> This happened to me in a previous version of the patch. I remember it
> being fixed in the last version (or at least I could not reproduce).
> I'll test again tomorrow with your script.
>

Okay thanks. I will see if I am using a dated version of the driver for some reason.
 
> Lucas De Marchi
