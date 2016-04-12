Return-Path: <jic23@jic23.retrosnub.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Tue, 12 Apr 2016 09:29:48 +0100
From: jic23@jic23.retrosnub.co.uk
To: "Andrew F. Davis" <afd@ti.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>,
 Marc Titinger <mtitinger@baylibre.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.de>, Guenter Roeck
 <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 1/1] iio: adc: Add driver for the TI INA3221 Triple
 Current/Voltage Monitor
In-Reply-To: <570BC74B.3000208@ti.com>
References: <1460139580-11865-1-git-send-email-afd@ti.com>
 <570A3FB2.7000600@kernel.org> <570BC74B.3000208@ti.com>
Message-ID: <f80d7649ad4cefdfe4a53518f62ed1ce@jic23.retrosnub.co.uk>
List-ID: <linux-iio@vger.kernel.org>

On 11.04.2016 16:48, Andrew F. Davis wrote:
> On 04/10/2016 06:57 AM, Jonathan Cameron wrote:
>> On 08/04/16 19:19, Andrew F. Davis wrote:
>>> The INA3221 is a three-channel, high-side current and bus voltage 
>>> monitor
>>> with an I2C and SMBUS compatible interface.
>>> 
>>> Signed-off-by: Andrew F. Davis <afd@ti.com>
>> Hi Andrew,
>> 
>> My immediate thought on this one is whether it would be better off in 
>> hwmon.
>> I'm not convinced either way from a quick glance at the data sheet, 
>> but the
>> question needs to be addressed.
>> 
> 
> I was on the fence with this also, I was leaning towards hwmod until I
> looked onto how the ina2xx driver has been ported to iio. This is 
> almost
> the same part but the ina3x has three monitors vs one. In addition it
> looks like NVIDIA has written a hwmod driver for this part
> (https://github.com/Bogdacutu/STLinux-Kernel/blob/master/drivers/hwmon/ina3221.c)
> but then also ported it over to IIO (although doesn't appear to be
> upstream ready or ever has been submitted for such)
> (https://github.com/SuperPichu/shield-tablet-kernel/blob/master/drivers/staging/iio/meter/ina3221.c)
> So I figured this was the way things are moving, but I have no problem
> working this as a hwmod driver. The IIO work is already done here, I'll
> write the hwmod version also but keep working this, I see no reason we
> cant have both if needed. (unless using this and just using iio_hwmod.c
> if needed is more acceptable?)
> 
>> It's not exactly a clean fit for the IIO ABI either at the moment 
>> though
>> I think some elements of that could be easily sorted out.
>> The key think in my mind is to look at what is actually being measured
>> rather than assume all the external components will be as the 
>> datasheet
>> assumes them to be...
>> 
>> + where do the alert lines actually go?
>> 
>> Jonathan
>>> ---
>>>  .../ABI/testing/sysfs-bus-iio-adc-ina3221          |  23 ++
>>>  drivers/iio/adc/Kconfig                            |   7 +
>>>  drivers/iio/adc/Makefile                           |   1 +
>>>  drivers/iio/adc/ina3221.c                          | 417 
>>> +++++++++++++++++++++
>>>  4 files changed, 448 insertions(+)
>>>  create mode 100644 
>>> Documentation/ABI/testing/sysfs-bus-iio-adc-ina3221
>>>  create mode 100644 drivers/iio/adc/ina3221.c
>>> 
>>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-ina3221 
>>> b/Documentation/ABI/testing/sysfs-bus-iio-adc-ina3221
>>> new file mode 100644
>>> index 0000000..bbe4f8c
>>> --- /dev/null
>>> +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-ina3221
>>> @@ -0,0 +1,23 @@
>>> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_shunt_(raw|scale)
>>> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_bus_(raw|scale)
>>> +Date:		April 2016
>>> +KernelVersion:	4.7
>>> +Contact:	Andrew F. Davis <afd@ti.com>
>>> +Description:
>>> +		Shunt and Bus voltage for each channel.
>> Units etc need specifying or at least a reference to the main 
>> in_voltageY_raw
>> docs etc.  These are really completely separate measurements be it 
>> differential measurements where the + on one is the - on the other 
>> (second is really a
>> unipolar measurement as it's relative to 0).  I wonder if we are
>> better off supporting them as such so define this device as having the 
>> channels.
>> in_voltage1-voltage0_raw (shunt voltage 1)
>> in_voltage0_raw (bus voltage 1)
>> in_voltage3-voltage2_raw (shunt voltage 2)
>> in_voltage2_raw (bus voltage 2)
>> in_voltage5-voltage4_raw (shunt voltage 3)
>> in_voltage4_raw
>> 
>> That I think reflects the actual measuring options, without applying
>> assumptions on what is connected to them.  Yes the datasheet says you 
>> should
>> put a shunt between the first two connections and the load between the
>> second connection and the 0 volt line, but I can't see anything 
>> preventing
>> this being used differently...
> 
> I feel this may become confusing to some, but I have no real objection
> to this.
Guenter's point that the shunt measurements are really current measures 
may mean it makes
more sense to handle these by allowing say device tree to provide the 
resistance values and
then converting them to a direct current measure.
> 
>>> +
>>> +What:		/sys/bus/iio/devices/iio:deviceX/shunt_integration_time[_available]
>>> +What:		/sys/bus/iio/devices/iio:deviceX/bus_integration_time[_available]
>>> +Date:		April 2016
>>> +KernelVersion:	4.7
>>> +Contact:	Andrew F. Davis <afd@ti.com>
>>> +Description:
>>> +		Shunt and Bus integration time for each channel.
>> I'd keep these tightly associated with the channels as then they 
>> become
>> standard abi elements, just for channels with extended names.
> 
> The other option is to have each channel have an integration_time, but
> this may give the false impression that they are individually 
> adjustable
> when they are actually all linked together, change one, they all change
> (of the same type (bus/shunt)).
Hmm. It is a little fiddly as we don't support grouping by extended name 
like this.
It's far from uncommon to have a set of channel parameters tied together 
and the ABI
allows for this.  Any parameter can change any other.  I think I'd 
rather stay within
the standard abi if at all possible.  Perhaps this will all be cleaned 
up anyway if we
move to having the shunt voltages output as currents?


> 
>>> +
>>> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_shunt_critical_(raw|scale)
>>> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_shunt_warning_(raw|scale)
>>> +Date:		April 2016
>>> +KernelVersion:	4.7
>>> +Contact:	Andrew F. Davis <afd@ti.com>
>>> +Description:
>>> +		Shunt voltage critical and warning trigger levels.
>> This is why I think this may really belong in hwmon.
>> The way you currently have this done is a bodge on the relevant IIO 
>> interfaces.
>> If there is good reason to look at multiple equivalent event types on 
>> a
>> given channel in IIO we can look at adding that support to the core.
>> This is a lot more common in explicit hardware monitoring chips than 
>> in
>> more general ADCs.
>> 
> 
> Agree, we already have threshold events, perhaps a way to set the
> threshold for devices like this that have adjustable ones could be
> useful, but I see what you mean, why would regular ADCs need an
> adjustable threshold?
> 
I'm a little confused as all the thresholds are adjustable... Issue is 
we
only currently allow one event of a given type per channel - here you 
effectively
had two.

>> Also I see nothing in the driver that is actually detecting if these
>> conditions have been passed?  If that is assumed to be a problem for 
>> external
>> hardware then it should be clearly documented as such.
>> 
> 
> I was thinking about leaving these to the user to do something with,
> they may want them tie them to an alert event somehow. Or I could
> probably tie them to channel events?
Channel event I think, but to support this properly we need the ability 
to
have two such thresholds on one channel.
> 
>>> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>>> index af4aea7..d713c9c 100644
>>> --- a/drivers/iio/adc/Kconfig
>>> +++ b/drivers/iio/adc/Kconfig
>>> @@ -232,6 +232,13 @@ config IMX7D_ADC
>>>  	  This driver can also be built as a module. If so, the module will 
>>> be
>>>  	  called imx7d_adc.
>>> 
>>> +config INA3221
>>> +	tristate "Texas Instruments INA3221 Triple Power Monitor"
>>> +	depends on I2C
>>> +	select REGMAP_I2C
>>> +	help
>>> +	  Say yes here to build support for TI INA3221 Triple Power 
>>> Monitor.
>> Need more detail here really.  Something about what it provides and 
>> the name
>> of the module would be conventional.
> 
> Will add.
> 
> [...]
> 
>>> +	INA3221_CHAN(3, INA3221_SHUNT3, "shunt"),
>>> +	INA3221_CHAN(3, INA3221_BUS3, "bus"),
>>> +	INA3221_CHAN(3, INA3221_CRIT3, "shunt_critical"),
>>> +	INA3221_CHAN(3, INA3221_WARN3, "shunt_warning"),
>> I'm not really sure how these work at all...  You can set the 
>> thresholds
>> but how does the driver know if they have been tripped?
>> Or are we dealing with the assumption that it is a problem for 
>> external
>> hardware?
>> 
> 
> They just trigger a pin when reached, these can then be hooked to
> anything the designer would like, I wasn't sure how to best handle this
> so I left them un-wired to anything in this driver, but I can see how
> this would make these channels seem out of place. :/
Interesting use case - I wonder if we need a way of making it explicit 
that
an event is controlled, but not received by an IIO driver... hmm.  Maybe
just a case of detecting that we didn't specify the relevant itnerrupt 
line.
> 
> 
> 
> A quick look though hwmod seems to reveal a lot of basic
> Voltage/Current/Temp parts, what seems to separates them is hwmon
> drivers expose more alerts, perhaps the IIO framework could be expanded
> to handle some hwmon like alerts, then the frameworks could move 
> towards
> being merged, as opposed to parts having a driver for each framework
> depending on use ( not volunteering, just suggesting :) ). I guess 
> there
> is little keeping me from simply registering with both frameworks in 
> one
> driver...
I'll expand on this later in the thread (as it seems to have come up)
but the 'plan' with IIO which has gotten rather stalled was to work 
towards
what I've always termed IIO on IIO,  that is IIO userspace side as just
another client of an IIO backend.  Thus you can use the IIO backend with
a bridge (or consumer if you prefer) providing any of the likely front 
ends
without having to have the IIO userspace as well.


> 
> Andrew
