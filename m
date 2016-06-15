Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47217 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753117AbcFOTeu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 15 Jun 2016 15:34:50 -0400
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Subject: Re: [PATCH 0/2] iio: humidity: sht31: add Sensirion SHT31 support
To: Guenter Roeck <linux@roeck-us.net>
References: <1465708397-19649-1-git-send-email-mranostay@gmail.com>
 <20160613222502.GA4376@d830.WORKGROUP>
 <CAKzfze_=URjXxePW4+P_Y8OUrgoMiC90Nzr=3ey+G=ZHKsRxCA@mail.gmail.com>
 <f26e218318cd07bdb857f67b1357f36e@jic23.retrosnub.co.uk>
 <CAKzfze_LfWnorv-SagS8+0HbUiTprDFfXdAWCcTzC61TeFriYw@mail.gmail.com>
 <5760D6FD.7050604@roeck-us.net>
 <EC8BB308-9B34-4F50-9FD5-923229BE81D8@jic23.retrosnub.co.uk>
 <20160615184855.GA18198@roeck-us.net>
Cc: Matt Ranostay <mranostay@gmail.com>, linux-hwmon@vger.kernel.org,
	david.frey@sensirion.com, Alison Schofield <amsfield22@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>
Message-ID: <2725655c-4266-0918-bd96-d4da9d2fb181@jic23.retrosnub.co.uk>
Date: Wed, 15 Jun 2016 20:34:44 +0100
MIME-Version: 1.0
In-Reply-To: <20160615184855.GA18198@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 15 June 2016 19:48:55 BST, Guenter Roeck <linux@roeck-us.net> wrote:
>On Wed, Jun 15, 2016 at 05:31:10PM +0100, Jonathan Cameron wrote:
>> 
>> 
>> On 15 June 2016 05:18:05 BST, Guenter Roeck <linux@roeck-us.net>
>wrote:
>> >On 06/14/2016 12:01 PM, Matt Ranostay wrote:
>> >> Hello Guenter et al,
>> >>
>> >> So seems I wrote an iio driver for the SHT31 chipset about the
>same
>> >> David Frey had his merged into hwmon tree. So was wondering per
>> >> Jonathan's comments what your input on this would be.
>> >>
>> >>>From what I can see the additional functionality of the hrtimer
>> >> trigger + rather fast update/integration time that a case could be
>> >> made because of the triggered buffer.
>> >>
>> >> Now there is some functionality missing from my iio driver than
>> >exists
>> >> in the hwmon.. like the thermal and humidity trip points (but that
>> >can
>> >> be handled in a userspace HAL anyway), and the non-clock skewing
>> >> read/write functionality (this can be easily added).
>> >>
>> >
>> >I am quite sure that we had this discussion about this very driver
>> >before.
>> >One of the key reasons for going with hwmon was limit register
>support.
>> >
>> >Guess you claim that is no longer relevant since it can be handled
>in
>> >user space ?
>> >If so, I would disagree; it seems to be difficult to generate an
>alert
>> >signal
>> >from user space.
>> Agreed
>> >
>> >I don't mind if you folks want drivers for chips like like this (ie
>> >chips supporting
>> >limits, or in other words typical hardware monitoring chips) in iio,
>> >but I would
>> >kindly ask to enhance the iio subsystem to support limits.
>> 
>> It has done since day one via event chardev. Limitations are :
>> * One per channel per type per direction. (Didn't seem necessary at
>the time)
>> This obviously matters for hwmon chips.
>> * No in kernel interface yet so not pushed on to iio-hwmon bridge.
>> * Intended for interrupt type limits which do not always correspond
>to how all 
>> devices do it... there are ways around it but only indirectly.
>> 
>> All fixable and not actually directly relevant for this part
>(possibly the inkern
>>  interface is...)
>
>Sure, all is fixable. Not that it will help here.
Quite.
>
>If you plan to accept this driver, please let me and David know, and
>I'll drop
>the hwmon driver. It means we'll both have wasted our time, but it does
>not make
>sense to keep two drivers for this chip around.
I don't plan to accept it. The argument in favour has not been strong
enough for likely uses if this part. Humidity doesn't typically change
that fast. Would need a really strong usecase argument to persuade me...
(if anyone has one, now is the time to raise it!)

If the drivers had turned up in the other order I would been fine with
it in IIO. Sadly it happens sometimes and this time Matt loses!
Sorry Matt. 

However, whilst it is a bit tedious for everyone, I think we do
keep needing to debate the suitable home for border line drivers.
I don't think there really are any clear rules we can formulate
unfortunately.
>
>On another side note, I don't really believe that it makes much senses
>to add all
>this functionality to iio to start with. I'd rather fix the hwmon
>registration
>API and create a hwmon->iio bridge.
A worthy aim but I think you would either end up with some nasty name
of attr based hackery or a substantial part of the IIO stuff
reimplemented.  I wish I had more time to drive the plan to fully
separate the front end and back end of IIO to provide that
sort of 'minimal' hardware description interface. Annoyingly
we aren't actually that far away from it.

I am also unclear that there is that much point in doing hwmon
to IIO bridge in kernel space. Any general ADC driver that
would have uses outside hwmon that demand streaming data and
similar wouldn't work over such an interface anyway.
Anything else is polled via sysfs in both cases, a bit of name 
look up code and both can be supported by one library.

So for devices where the main usecase is probably relatively
slow polled reading, I personally don't feel it really
matters whether then end up in IIO of hwmon. Just comes
down to how they work with legacy interfaces (which
is pretty much all the iio-hwmon bridge is for).

Right now the unclear corners are 'unusual temperature sensors'
e.g. thermophiles, near infrared or high end theromcouple devices
where typically high speed drives them to IIO. (they change fast
because they are moving around quickly).

Humidity partly because a lot of the users are not coming from
hardware monitoring but rather environmental side of things.

General purpose ADCs - more historical I think where hwmon
was kind of the only option... + obviously there are specific
hardware monitoring focused parts where hwmon makes sense
as it has the interfaces tailored to these applications.

Anyhow, that's my 2 pence ;) I suspect we'll keep muddling
through but I absolutely agree that we should avoid two
drivers for the same part. 	

Maybe I should add a note in the relevant Kconfig files to
say if you are putting something here you'd better have a
good reason. Not sure anyone would notice though...

Jonathan
>
>Guenter
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
