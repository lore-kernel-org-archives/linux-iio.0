Return-Path: <SRS0=Xx0/=JS=huawei.com=jonathan.cameron@kernel.org>
Date: Mon, 2 Jul 2018 14:03:52 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: David Lechner <david@lechnology.com>
CC: Lars-Peter Clausen <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	"Peter Meerwald-Stadler" <pmeerw@pmeerw.net>, <linux-kernel@vger.kernel.org>,
	"William Breathitt Gray" <vilhelm.gray@gmail.com>
Subject: Re: [PATCH] iio: add channel type for frequency
Message-ID: <20180702140352.00002c6c@huawei.com>
In-Reply-To: <74c98fdc-b498-c593-e0b1-6aeb7057398a@lechnology.com>
References: <20180701025953.3561-1-david@lechnology.com>
	<308015e8-d203-c4d1-ba80-3c2adf4b377a@metafoo.de>
	<74c98fdc-b498-c593-e0b1-6aeb7057398a@lechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
List-ID: <linux-iio@vger.kernel.org>

On Sun, 1 Jul 2018 17:24:34 -0500
David Lechner <david@lechnology.com> wrote:

> On 07/01/2018 02:18 AM, Lars-Peter Clausen wrote:
> > On 07/01/2018 04:59 AM, David Lechner wrote:  
> >> This adds a new type for frequency to the IIO channel type enumeration.
> >>
> >> Units are in Hz.
> >>  
> > 
> > Documentation?  
> 
> I take it that you mean Documentation/ABI/testing/sysfs-bus-iio? Or
> somewhere else too?

Yes.

> 
> > 
> > We already have the altvoltage channel type with the frequency attribute.
> > Difficult to say if there are any overlaps without documentation on how this
> > new attribute is supposed to be used.  
> 
> I'm basically trying to implement a quadrature encoder in iio. I want to be
> able to use it in-kernel to get a rotational speed value for a motor.

Have you seen the counters subsystem work that is pretty much ready to merge?

https://lkml.org/lkml/2018/6/21/659

> 
> The motors (and encoder wheels) are hot-swapable, so we don't know how many
> counts from the quadrature encoder equals one rotation because it depends on
> which motor is being used. So using IIO_ANGL_VEL doesn't work for this case.

Hmm. This always ugly when we have hotswappable external devices.  Ideal is
to describe them with device tree or similar none the less as this stuff isn't
really something userspace should have to figure out.

> 
> It seems to me that the proper generic unit for "speed" from the quadrature
> encoder would be counts per second, hence the suggestion of a frequency unit.

It is probably not that clear cut, as what is it frequency of?  All depends on
what mode the quadrature counter is working in x4 or x1 for simplest options.


> I'm not sure if voltage frequency works here since a "count" on a quadrature
> encoder is derived from two different voltage signals (and may vary depending
> on how the encoder determines what one count it).
> 
> Also, unrelated to my quadrature encoder project, I was thinking that
> frequency counters would use this unit as well (although the voltage alt
> makes more sense for this case).
> 
> There are also sound sensors that measure frequency that could use this unit.

I have not fundamental issue with having a frequency channel, but only
if we have a clear cut use case.  I suspect the right option here is to
look at what extensions are needed to William's counter subsystem instead
of in IIO (which frankly failed to stretch far enough to support counters
well).

Jonathan

> 
> >   
> >> Signed-off-by: David Lechner <david@lechnology.com>
> >> ---
> >>   drivers/iio/industrialio-core.c | 1 +
> >>   include/uapi/linux/iio/types.h  | 1 +
> >>   tools/iio/iio_event_monitor.c   | 1 +
> >>   3 files changed, 3 insertions(+)
> >>
> >> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> >> index 19bdf3d2962a..f3c2c9e4b997 100644
> >> --- a/drivers/iio/industrialio-core.c
> >> +++ b/drivers/iio/industrialio-core.c
> >> @@ -85,6 +85,7 @@ static const char * const iio_chan_type_name_spec[] = {
> >>   	[IIO_COUNT] = "count",
> >>   	[IIO_INDEX] = "index",
> >>   	[IIO_GRAVITY]  = "gravity",
> >> +	[IIO_FREQUENCY] = "frequency",
> >>   };
> >>   
> >>   static const char * const iio_modifier_names[] = {
> >> diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
> >> index 4213cdf88e3c..9fee86e2046f 100644
> >> --- a/include/uapi/linux/iio/types.h
> >> +++ b/include/uapi/linux/iio/types.h
> >> @@ -44,6 +44,7 @@ enum iio_chan_type {
> >>   	IIO_COUNT,
> >>   	IIO_INDEX,
> >>   	IIO_GRAVITY,
> >> +	IIO_FREQUENCY,
> >>   };
> >>   
> >>   enum iio_modifier {
> >> diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
> >> index b61245e1181d..c3ef20057d52 100644
> >> --- a/tools/iio/iio_event_monitor.c
> >> +++ b/tools/iio/iio_event_monitor.c
> >> @@ -58,6 +58,7 @@ static const char * const iio_chan_type_name_spec[] = {
> >>   	[IIO_PH] = "ph",
> >>   	[IIO_UVINDEX] = "uvindex",
> >>   	[IIO_GRAVITY] = "gravity",
> >> +	[IIO_FREQUENCY] = "frequency",
> >>   };
> >>   
> >>   static const char * const iio_ev_type_text[] = {
> >>  
> >   
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
