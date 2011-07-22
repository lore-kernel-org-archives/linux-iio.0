Return-Path: <jic23@cam.ac.uk>
Message-ID: <4E294B3B.3000602@cam.ac.uk>
Date: Fri, 22 Jul 2011 11:04:43 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "device-drivers-devel@blackfin.uclinux.org" <device-drivers-devel@blackfin.uclinux.org>,
 "Hennerich, Michael" <Michael.Hennerich@analog.com>,
 Jon Brenner <jbrenner@taosinc.com>,
 Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
Subject: Re: 64 bit event code. How to split up?
References: <4E2948E7.7080908@cam.ac.uk>
In-Reply-To: <4E2948E7.7080908@cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 07/22/11 10:54, Jonathan Cameron wrote:
> Hi All,
> 
> Given Michael has already run out of space in our 32 bit event code I suggest
> we bite the bullet and move over to a 64 bit one now.  I doubt there is much
> userspace code in place so this shouldn't be 'too' painful.
> 
> So to start the ball rolling, how about the following split.
> The final will probably still be a macro of doom.  Bitfields get a bit
> confusing cross architectures.  I 'think' the following should even
> be fine of arm oabi (IIRC that has 4 byte alignment for structures).
> 
> The following avoids all the conditionals we currently have in the macro.
> It costs us space, but we have more of that. Note we'll need to add
> a NO_MOD modifier and add 1 to all the modifier codes.  It should also
> allow us to use enums for everything.
> 
> /**
>  * iio_event - general purpose event to userspace.
>  * @time: timestamp
>  * @chan: index of non differential channel
>  * @chan1: index of first end of differential channel
>  * @chan2: index of second end of differential channel
>  * @chan_type: an iio_chan_type (we currently have 15)
>  * @modifier: currently we interleave several types of these (axial, light).
>  *            having this much space would allow us to relax that and lead to
>  *            simpler code.
>  * @direction: currently only 3, but definitely want level versions as well.
>  * @type: event type (currently thresh, mag, roc). Can see we will have more
>  *        of these.
Forgot to say, this also effects the size of the event_mask in iio_chan_spec.
Right now that allows for 8 types and 4 directions.  It's going to be fiddly to
allow that to expand beyond 64 bits.
>  */
> 
> struct iio_event {
>         int64_t time;
> 	union {
> 		unsigned chan:32;
> 		struct {
> 			unsigned chan1:16;
> 			unsigned chan2:16;
> 		};
> 	};
> 	unsigned chan_type:8;
> 	unsigned modifier:8;
> 	unsigned direction:8;
> 	unsigned type:8;
> };
> 
> So the question is, is this rough and ready distribution of bits good
> enough, or do we need more channel types for example at the cost of some
> directions?
> 
> I'll hack some patches based on this together shortly so we can see what
> other cleanups it allows.
> 
> Jonathan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
