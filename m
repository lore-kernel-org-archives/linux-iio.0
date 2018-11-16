Return-Path: <henk.medenblik@tno.nl>
From: "Medenblik, H.J.W. (Henk)" <henk.medenblik@tno.nl>
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>, David Frey
	<dpfrey@gmail.com>
CC: linux-iio <linux-iio@vger.kernel.org>
Subject: Re: Buffers and sampling frequency
Date: Fri, 16 Nov 2018 18:36:46 +0000
Message-ID: <d241cb0d2df842569fd163c5c8a37819@tno.nl>
References: <9a7e271c-92d5-f8f4-b077-8e24d8d7798f@gmail.com>
 <20181116171722.7dfb04bb@archlinux>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Hi Jonathan,

I was triggered by this mail because here was something mentioned about
metadata in FIFO's and the use within iio.
I am currently designing some FPGA functionality and originally I also
wanted to use metadata in front of the actual payload data of my IIO
device (which is a radar acquisition system).
Therefore I was wondering if there never have been a request to support
a metadata feature in the iio framework. Is this because of complexity
or does it have another reason?
In my case I would like to add this metadata to inform the user with
formatting of the payload data but it would also give us a manner to
include hardware timestamps which can be used to correlate with other
captured data  (from other sensors).

With kind regards
Henk

On 16-11-18 18:17, Jonathan Cameron wrote:
> On Wed, 14 Nov 2018 09:36:42 -0800
> David Frey <dpfrey@gmail.com> wrote:
>
>> Hi,
> Hi David,
>
>> I'm trying to add triggered buffer support to the bmi160 IMU driver and
>> a question came up that I don't know the answer to.  The driver defines
>> an x, y, z channel of type IIO_ACCEL and an x, y, z channel of type
>> IIO_ANGL_VEL.  Then within each of these channel definitions,
>> info_mask_shared_by_type is set to:
>> BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_SAMP_FREQ)
>>
>> This means that the driver allows for a different sampling frequency on
>> the accelerometer and gyro components.  The chip has a hardware FIFO and
>> the chip is configurable whether the FIFO is in headerless or header
>> mode.  In header mode the header tells the reader the structure of the
>> data.  Here's a relevant snippet from the datasheet
>> (https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BMI1=
60-DS000-07.pdf):
> Yeah. This is an annoyingly common hardware design.  To my mind it's over=
kill
> as the chances of any software actually taking full advantage of different
> frequencies of data is fairly low.
>
> Also note that typically sampling frequency controls have additional side
> effects in terms of filtering etc which apply to data not coming through
> the fifos.
>
>>> In contrast, the header mode is intended for situations where flexibili=
ty
>> in the data structure is required, e.g. when sensor run at different ODR=
s or
>> when switching sensors on or off on the fly during operation.
>   =

>> Do IIO buffers support the case where multiple channels are enabled
>> that have different ODRs (sampling frequencies)?  It seems to me like
>> the client on the receiving end of the buffer will receive samples of
>> a fixed size equal to the sum of the sizes of all the enabled
>> channels and that the client can only look at which channels are
>> enabled.  They can't distinguish which channels are populated in the
>> current sample.
> Indeed you are correct on that but there are ways of handling this if
> it actually matters enough.
>
>> Am I correct about this limitation?  If so, what is the suggested
>> behavior by the driver?  Should the channel definitions be changed so
>> that sampling frequency is info_mask_shared_by_all?  Or should I do
>> something like use iio_buffer_setup_ops.validate_scan_mask to validate
>> that the sampling frequency is equal for all channels specified by the
>> scan_mask?
> So, when we first met devices that did this sort of tagged data (which
> as you have observed doesn't fit with our data model at all), we did
> exactly what you say and had drivers only support a shared data rate
> across all their data types (basically don't use the tagged modes).
>
> There is however, one bit exception in tree which offers another (more
> complex path), the lsm6dsx.  In that case we actually register multiple
> iio devices, one per data type, handle the complexity of bringing them
> up appropriately and then push data to the right iio device dependant
> on the tag.  I've always been in two minds about this.  One side effect
> is you loose the implicit association between channels of different types
> and have to align the data using timestamps in userspace which is ugly,
> but if we need to support it that is the only way to do it in a model
> where we don't carry meta data in the buffer.
>
> Now to support this in the bmi160 which supports (I believe) the
> headerless mode already, we would have to continue supporting a single
> device, but could potentially have additional auxilliary devices on which
> channels can be enabled if you want to have the data with header mode
> with uneven sampling frequencies.  It can be done, but it'll make for
> a somewhat unexpected userspace interface which is perhaps not a good
> thing.  =

>
> So the question is whether your question is abstract, or you have a
> real usecase that needs the uneven sampling?  Or have you just spotted
> a bug with how it currently works and want to fix that (so the frequencies
> are in lock when the buffer is enabled?)
>
>> Thanks,
>> David
> Jonathan
>

This message may contain information that is not intended for you. If you a=
re not the addressee or if this message was sent to you by mistake, you are=
 requested to inform the sender and delete the message. TNO accepts no liab=
ility for the content of this e-mail, for the manner in which you use it an=
d for damage of any kind resulting from the risks inherent to the electroni=
c transmission of messages.
