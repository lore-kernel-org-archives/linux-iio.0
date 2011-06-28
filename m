Return-Path: <Michael.Hennerich@analog.com>
Message-ID: <4E09D434.9030504@analog.com>
Date: Tue, 28 Jun 2011 15:16:36 +0200
From: Michael Hennerich <michael.hennerich@analog.com>
Reply-To: <michael.hennerich@analog.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: Variable accuracy devices.
References: <4E09A5E0.7030300@cam.ac.uk>
In-Reply-To: <4E09A5E0.7030300@cam.ac.uk>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 06/28/2011 11:58 AM, Jonathan Cameron wrote:
> Hi All,
>
> There are a couple of different types of variable accuracy drivers in three.
>
> 1) Devices with variable gain - these are well handled
>
> 2) Devices with variable number of bits per sample. Typically they will
>     do higher accuracy at a slower rate.
>
> 3) Variable bit depths in hardware ring buffers (sca3000 only - currently
> glossed over).
>
>
> In case 2 we have for example the adis16130 gyro driver (a very simple driver).
> This one doesn't currently implement buffered capture, so our only read route
> is through the sysfs attributes.   So my question here is whether there is
> a use case for sampling at anything other than maximum accuracy if we are
> reading via a slow path anyway?
I don't think so.
>    Basically I'd like to drop the non standard
> interface that this driver has.
ACK

> Case 3 is one I've been avoiding mainly because it only exists in one driver
> right now and that one is for a long deprecated part.   It is however similar
> to a controllable nbit adc or indeed the adis16130 gyro.  In those cases we
> want to be able to control the accuracy of data that is captured into a
> software buffer.  Right now we don't have an easy way of doing this.
>
> The solution that comes to mind is:
> Additional optional callback within ring_setup_ops (it kind of fits in there
> if we broaden the term setup somewhat), checked by equivalent replacement
> of iio_show_fixed_type.  If it's present, the driver is queried, if not then
> we use the fixed type stuff from the iio_chan_spec structure.  Clearly
> we will also need a write function.  The matching _available attribute
> could be done by a second callback.
>
> What do people think?
Sounds good to me.

-- 
Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin,
Margaret Seif
