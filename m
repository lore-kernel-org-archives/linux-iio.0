Return-Path: <mwelling79@gmail.com>
Sender: Michael Welling <mwelling79@gmail.com>
Date: Tue, 1 Mar 2016 09:57:44 -0600
From: Michael Welling <mwelling@ieee.org>
To: Daniel Baluta <daniel.baluta@intel.com>
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	lkml <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Guenter Roeck <linux@roeck-us.net>, eibach@gdsys.de
Subject: Re: [PATCH v4] iio: adc: Add TI ADS1015 ADC driver support
Message-ID: <20160301155744.GA5484@deathstar>
References: <1454678238-16313-1-git-send-email-daniel.baluta@intel.com>
 <20160301005032.GA15476@deathstar>
 <CAKi4VAKBOge=-DcT9S7+uZWUte3EFNQ95u-fHCudRXZHqYuE1w@mail.gmail.com>
 <20160301024217.GA12912@deathstar>
 <CAEnQRZCQqGgofK7s7S1MS_e+rWXwaQCaZxaAiSnGxQaQN-Q4=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAEnQRZCQqGgofK7s7S1MS_e+rWXwaQCaZxaAiSnGxQaQN-Q4=A@mail.gmail.com>
List-ID: <linux-iio@vger.kernel.org>

On Tue, Mar 01, 2016 at 01:28:26PM +0200, Daniel Baluta wrote:
> On Tue, Mar 1, 2016 at 4:42 AM, Michael Welling <mwelling@ieee.org> wrote:
> > On Mon, Feb 29, 2016 at 10:09:10PM -0300, Lucas De Marchi wrote:
> >> On Mon, Feb 29, 2016 at 9:50 PM, Michael Welling <mwelling@ieee.org> wrote:
> >> > On Fri, Feb 05, 2016 at 03:17:18PM +0200, Daniel Baluta wrote:
> >> >> The driver has sysfs readings with runtime PM support for power saving.
> >> >> It also offers buffer support that can be used together with IIO software
> >> >> triggers.
> >> >>
> >> >
> >> > Daniel,
> >> >
> >> > So I noticed something yesterday while testing new boards.
> >> > The channels are occassionally swapping when accessing data from multiple channels.
> >> >
> >> > I wrote a simple bash script to demonstrate.
> >>
> >> This happened to me in a previous version of the patch. I remember it
> >> being fixed in the last version (or at least I could not reproduce).
> >> I'll test again tomorrow with your script.
> >>
> >
> > Here is what I believe is happening.
> >
> > The request for a conversion on a new channel comes in while the conversion
> > for the previous channel is still converting. The driver waits approximately
> > one conversion cycle. The previous channel completes within this timeframe
> > and the MUX is changed and the new sample is started. The new sample is still
> > converting and the driver returns the value from the previous conversion.
> >
> 
> Yes, this was the problem in the initial driver. The fix was to wait
> for the conversion to complete
> but it seems that it doesn't always work on your setup :(.
> 
>      if (change) {
> +               conv_time = DIV_ROUND_UP(USEC_PER_SEC, ads1015_data_rate[dr]);
> +               usleep_range(conv_time, conv_time + 1);
> +       }
> +
>

The result can theoretically take up to nearly 2 conversion cycles if the
request for a new channel comes in just as the previous conversion starts.

> 
> > For a test I multiplied the conv_time value by 2 in the ads1015_get_adc_result
> > function. This allows time for the current sample flush out and always returns
> > the appropriate channel's value.
> >
> > Looking at the buffered mode it appears that only one channel is being accessed
> > at any time. This being the first one in the active_scan_mask found by
> > find_first_bit. So the MUX would never change is buffered mode as far I can
> > tell.
> >
> > Don't we typically want to read all of enabled channels in buffered mode?
> 
> For the moment we allow only a single channel to be enabled in buffer mode.

Okay just making sure. Adding more channels would effectively divide the sampling
rate and increase the complexity of the driver.
