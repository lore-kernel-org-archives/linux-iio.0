Return-Path: <Michael.Hennerich@analog.com>
Message-ID: <4E4D00ED.4080106@analog.com>
Date: Thu, 18 Aug 2011 14:09:17 +0200
From: Michael Hennerich <michael.hennerich@analog.com>
Reply-To: <michael.hennerich@analog.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: RFC: Does separate types for differential signals make sense?
References: <4E4CE6E6.2010308@cam.ac.uk>
In-Reply-To: <4E4CE6E6.2010308@cam.ac.uk>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 08/18/2011 12:18 PM, Jonathan Cameron wrote:
> Hi All,
>
> Whilst working on some of the capacitance adc drivers yesterday I added a second
> differential type.   Whilst we only had IIO_VOlTAGE_DIFF, it seemed easier to
> handle it as a special case - now we have IIO_CAPACITANCE_DIFF, I'm not so sure.
IIO_CURRENT_DIFF is also likely to be added in future...

> The alternative is to add another flag to struct iio_chan_spec and build the
> differential names automatically (easy enough I think).  Nastier is how to handle
> the related event codes.  As we haven't pushed out the new 64 bit codes, this
> is a perfect time to slip in a change there (rather than two changes back to back.)
> Current macro to generate codes is:
>
> define IIO_EVENT_CODE(chan_type, modifier, direction,			\
> 		       type, chan, chan1, chan2)			\
> 	(((u64)type<<  56) | ((u64)direction<<  48) | ((u64)modifier<<  40) | \
> 	 ((u64)chan_type<<  32) | (chan2<<  16) | chan1 | chan)
>
> So if we were to steal a bit to mark channels as differential, where would we do it?
> Obvious choice is in type - reducing max number of types to 128 - can't see that being
> a problem any time soon.  Could pinch the top bit off direction instead - that one
> has way more values than I can think of uses for...
In the way we use chan_type today - I think it would be the best spot.
> This is going to be an annoyingly invasive patch to do. I'll probably scrap the
> use of the IIO_CHAN macro for all differential channels rather than adding another
> parameter to it. Plan was to scrap that macro entirely eventually, so not such a
> bad thing.
>
> Jonathan
>
>


-- 
Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin,
Margaret Seif
