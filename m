Return-Path: <jic23@jic23.retrosnub.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Tue, 12 Apr 2016 09:34:39 +0100
From: jic23@jic23.retrosnub.co.uk
To: Guenter Roeck <linux@roeck-us.net>
Cc: "Andrew F. Davis" <afd@ti.com>, Jonathan Cameron <jic23@kernel.org>,
 Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald <pmeerw@pmeerw.net>, Marc Titinger <mtitinger@baylibre.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Jean Delvare
 <jdelvare@suse.de>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 1/1] iio: adc: Add driver for the TI INA3221 Triple
 Current/Voltage Monitor
In-Reply-To: <20160411180839.GA10942@roeck-us.net>
References: <1460139580-11865-1-git-send-email-afd@ti.com>
 <570A3FB2.7000600@kernel.org> <570BC74B.3000208@ti.com>
 <20160411163843.GA27218@roeck-us.net> <570BD530.8060508@ti.com>
 <20160411180839.GA10942@roeck-us.net>
Message-ID: <e5bf29a1db784fa428235b59b812d666@jic23.retrosnub.co.uk>
List-ID: <linux-iio@vger.kernel.org>

On 11.04.2016 19:08, Guenter Roeck wrote:
> On Mon, Apr 11, 2016 at 11:47:44AM -0500, Andrew F. Davis wrote:
>> On 04/11/2016 11:38 AM, Guenter Roeck wrote:
>> > On Mon, Apr 11, 2016 at 10:48:27AM -0500, Andrew F. Davis wrote:
>> >> On 04/10/2016 06:57 AM, Jonathan Cameron wrote:
>> >>> On 08/04/16 19:19, Andrew F. Davis wrote:
>> >>>> The INA3221 is a three-channel, high-side current and bus voltage monitor
>> >>>> with an I2C and SMBUS compatible interface.
>> >>>>
>> >>>> Signed-off-by: Andrew F. Davis <afd@ti.com>
>> >>> Hi Andrew,
>> >>>
>> >>> My immediate thought on this one is whether it would be better off in hwmon.
>> >>> I'm not convinced either way from a quick glance at the data sheet, but the
>> >>> question needs to be addressed.
>> >>>
>> >>
>> >> I was on the fence with this also, I was leaning towards hwmod until I
>> >> looked onto how the ina2xx driver has been ported to iio. This is almost
>> >> the same part but the ina3x has three monitors vs one. In addition it
>> >> looks like NVIDIA has written a hwmod driver for this part
>> >> (https://github.com/Bogdacutu/STLinux-Kernel/blob/master/drivers/hwmon/ina3221.c)
>> >> but then also ported it over to IIO (although doesn't appear to be
>> >> upstream ready or ever has been submitted for such)
>> >> (https://github.com/SuperPichu/shield-tablet-kernel/blob/master/drivers/staging/iio/meter/ina3221.c)
>> >> So I figured this was the way things are moving, but I have no problem
>> >> working this as a hwmod driver. The IIO work is already done here, I'll
>> >> write the hwmod version also but keep working this, I see no reason we
>> >> cant have both if needed. (unless using this and just using iio_hwmod.c
>> >> if needed is more acceptable?)
>> >>
>> >
>> > You can not have both since they would conflict with each other.
>> > ina2xx has possibly created a bad precedent. I am not inclined to accept
>> > a hwmon driver if an iio driver already exists. If you want an iio driver,
>> > fine with me, but then you (and its users) will have to live with its
>> > limitations when it comes to hardware monitoring.
>> >
>> 
>> Hmm, my plan was an MFD device core, that then could mediate the two
>> sub-drivers, but I'm not sure about this yet.
>> 
> mfd is intended to separate multi-function devices, not multiple
> linux subsystems accessing the same logical functionality in a chip 
> just
> because the subsystems don't have a means to communicate with each 
> other.
> I don't think using mfd for this purpose is a good idea; someone would
> have to work hard to convince me that it is.
> 
>> > I don't really mind if things are going all towards iio if that is where
>> > the community wants to go. However, if that is the case, I would suggest
>> > that someone should spend the time to define a clear sense of 'limits'
>> > as well as alert handling in iio, in a way that is exportable to other
>> > subsystems (hwmon and thermal come into mind).
>> >
>> 
>> I agree. I think both frameworks offer useful interfaces, so I would
>> hate to limit users to one, but for now I'll just post the hwmon 
>> version
>> here in a bit and live with that until someone requests the IIO 
>> support.
>> 
> Ultimately it might make sense to create a hwmon->iio bridge in the 
> hwmon
> core (just like it would make sense to create a hwmon->thermal bridge).
> This way drivers could be implemented whereever it is more convenient,
> and where the primary use case fits best. The basic idea would be for a
> hwmon driver to register with a flag such as "register with the iio
> subsystem as well".
> 
> However, that would require substantial structural changes (or call it
> modernization) of the hwmon driver core API. Unfortunately, that is 
> unlikely
> to happen anytime soon - I don't have the time, and no one else seems 
> to
> show much interest in hwmon lately. So instead of doing that, people 
> end up
> writing drivers for the same chip in multiple subsystems, and end up 
> with
> limitations one way or another. ina2xx is a perfect example.
The aim from the IIO side was to take a kind of different approach to 
this.
Original suggest was Mark Brown's (I like to blame him whenever possible 
;).
His usecase was SoC ADCs where one single ADC is commonly used to do a 
whole
load of parallel tasks.  It's not uncommon to have one logic block 
doing,
touchscreen, hwmon and general purpose ADC channels.

Anyhow, what he brought up is that, as we were adding the ability to 
have
other consumers of IIO data in the kernel we can separate the backend 
from
the front end.

The backend :
* Handles the hardware providing any of:

> 
> Guenter
