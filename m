Return-Path: <SRS0=cXGt=ZE=it-klinger.de=ak@kernel.org>
Date: Sun, 22 Jan 2017 21:41:10 +0100
From: Andreas Klinger <ak@it-klinger.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	ktsai@capellamicro.com, wsa@the-dreams.de, robh+dt@kernel.org,
	pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	trivial@kernel.org, mranostay@gmail.com, linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 3/3] iio: distance: srf08: add driver ABI documentation
Message-ID: <20170122204110.GA1840@andreas>
References: <20170117135006.GA22903@andreas>
 <2e87aeed-a611-e160-c245-f5b16f2ef304@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2e87aeed-a611-e160-c245-f5b16f2ef304@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

Hi Jonathan,

see question below.

Andreas


Jonathan Cameron <jic23@kernel.org> schrieb am Sun, 22. Jan 13:41:
> On 17/01/17 13:50, Andreas Klinger wrote:
> > Add sysfs-bus-iio-distance-srf08 for individual attributes of the driver,
> > especially:
> >  - sensitivity which the device documentation calls gain for amplifying the
> >    signal
> >  - max_range for limiting the maximum distance for expected echos and
> >    therefore limiting the time waiting for telegrams
> > 
> > Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> > ---
> >  .../ABI/testing/sysfs-bus-iio-distance-srf08       | 27 ++++++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-distance-srf08
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-distance-srf08 b/Documentation/ABI/testing/sysfs-bus-iio-distance-srf08
> > new file mode 100644
> > index 000000000000..e96c28064748
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio-distance-srf08
> > @@ -0,0 +1,27 @@
> > +What		/sys/bus/iio/devices/iio:deviceX/in_distance_raw
> > +Date:		January 2017
> > +KernelVersion:	4.11
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		Get the current distance in meters between the sensor and
> > +		the first object recognized
> Generally no need to document what are effectively standard elements.
> Just leads to the possibility of disagreements in the docs! 
> Still no harm here really.
> > +
> > +What		/sys/bus/iio/devices/iio:deviceX/sensor_sensitivity
> > +Date:		January 2017
> > +KernelVersion:	4.11
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		Show or set the gain boost of the amp, from 0-31 range.
> > +		default 31
> > +
> > +What		/sys/bus/iio/devices/iio:deviceX/sensor_max_range
> > +Date:		January 2017
> > +KernelVersion:	4.11
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		Show or set the maximum range between the sensor and the
> > +		first object echoed in millimeters.
> > +		This setting limits the time the driver is waiting for a
> > +		echo.
> > +		Can be set between 43 and 11008 in a grid of 43 mm.
> > +		default 6020
> This needs to be in the same units as the range - so m.

Just to clarify:
There should be a floating point number be passed to the driver and being parsed
there, e. g.:
0.043 or 6.020
right?

Or should this number be passed using the scale attribute like the raw value
does? So that the scale is used by both the value itself and the attribute.

> I'm not 100% sure this is the best ABI we can do for this. However, supporting
> this as a legacy abi if we come up with something more general will be a very
> small burden, so lets not stall the driver on this!
> 
> Jonathan
> > 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
