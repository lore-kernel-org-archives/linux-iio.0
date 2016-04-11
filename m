Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:60269 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752311AbcDKQ1y (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 11 Apr 2016 12:27:54 -0400
Date: Mon, 11 Apr 2016 09:27:55 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: "Andrew F. Davis" <afd@ti.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Marc Titinger <mtitinger@baylibre.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jean Delvare <jdelvare@suse.de>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 1/1] iio: adc: Add driver for the TI INA3221 Triple
 Current/Voltage Monitor
Message-ID: <20160411162755.GA26979@roeck-us.net>
References: <1460139580-11865-1-git-send-email-afd@ti.com>
 <570A3FB2.7000600@kernel.org>
 <570A6E4A.4010300@roeck-us.net>
 <570BC9CE.9010905@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <570BC9CE.9010905@ti.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Apr 11, 2016 at 10:59:10AM -0500, Andrew F. Davis wrote:
> On 04/10/2016 10:16 AM, Guenter Roeck wrote:
> > On 04/10/2016 04:57 AM, Jonathan Cameron wrote:
> >> On 08/04/16 19:19, Andrew F. Davis wrote:
> >>> The INA3221 is a three-channel, high-side current and bus voltage
> >>> monitor
> >>> with an I2C and SMBUS compatible interface.
> >>>
> >>> Signed-off-by: Andrew F. Davis <afd@ti.com>
> >> Hi Andrew,
> >>
> >> My immediate thought on this one is whether it would be better off in
> >> hwmon.
> >> I'm not convinced either way from a quick glance at the data sheet,
> >> but the
> >> question needs to be addressed.
> >>
> > 
> > It looks like a typical hardware monitoring device to me.
> > 
> >> It's not exactly a clean fit for the IIO ABI either at the moment though
> >> I think some elements of that could be easily sorted out.
> >> The key think in my mind is to look at what is actually being measured
> >> rather than assume all the external components will be as the datasheet
> >> assumes them to be...
> >>
> >> + where do the alert lines actually go?
> >>
> > In a typical application they would connect to interrupts or to gpio pins.
> > They could also trigger some direct action, such as turning on a fan,
> > though that is unlikely nowadays. The 'critical' pin might sometimes
> > trigger a system reset.
> > 
> > Some more comments inline.
> > 
> > Guenter
> > 
> >> Jonathan
> >>> ---
> >>>   .../ABI/testing/sysfs-bus-iio-adc-ina3221          |  23 ++
> >>>   drivers/iio/adc/Kconfig                            |   7 +
> >>>   drivers/iio/adc/Makefile                           |   1 +
> >>>   drivers/iio/adc/ina3221.c                          | 417
> >>> +++++++++++++++++++++
> >>>   4 files changed, 448 insertions(+)
> >>>   create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ina3221
> >>>   create mode 100644 drivers/iio/adc/ina3221.c
> >>>
> >>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-ina3221
> >>> b/Documentation/ABI/testing/sysfs-bus-iio-adc-ina3221
> >>> new file mode 100644
> >>> index 0000000..bbe4f8c
> >>> --- /dev/null
> >>> +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-ina3221
> >>> @@ -0,0 +1,23 @@
> >>> +What:       
> >>> /sys/bus/iio/devices/iio:deviceX/in_voltageY_shunt_(raw|scale)
> >>> +What:       
> >>> /sys/bus/iio/devices/iio:deviceX/in_voltageY_bus_(raw|scale)
> >>> +Date:        April 2016
> >>> +KernelVersion:    4.7
> >>> +Contact:    Andrew F. Davis <afd@ti.com>
> >>> +Description:
> >>> +        Shunt and Bus voltage for each channel.
> >> Units etc need specifying or at least a reference to the main
> >> in_voltageY_raw
> >> docs etc.  These are really completely separate measurements be it
> >> differential measurements where the + on one is the - on the other
> >> (second is really a
> >> unipolar measurement as it's relative to 0).  I wonder if we are
> >> better off supporting them as such so define this device as having the
> >> channels.
> >> in_voltage1-voltage0_raw (shunt voltage 1)
> >> in_voltage0_raw (bus voltage 1)
> >> in_voltage3-voltage2_raw (shunt voltage 2)
> >> in_voltage2_raw (bus voltage 2)
> >> in_voltage5-voltage4_raw (shunt voltage 3)
> >> in_voltage4_raw
> >>
> >> That I think reflects the actual measuring options, without applying
> >> assumptions on what is connected to them.  Yes the datasheet says you
> >> should
> >> put a shunt between the first two connections and the load between the
> >> second connection and the 0 volt line, but I can't see anything
> >> preventing
> >> this being used differently...
> > 
> > Shunt voltage (or voltage difference) has a LSB of 40uV. Using it for
> > anything else but current measurement doesn't really make much sense.
> > I would report it not as voltage but as current, but that is from
> > my filtered hwmon point of view, so maybe it doesn't really apply here.
> > 
> 
> I would need to know the shunt resistance, I could get this from the
> user somehow (DT/sysfs) but I decided to report directly from the ADC
> and let the reader do the math so I don't have to make any use assumptions.
> 
That is why one would specify it in devicetree. The board designers (those
who hopefully help writing the devicetree description of a board) would know.

Guenter
