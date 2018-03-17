Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751236AbeCQUan (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 17 Mar 2018 16:30:43 -0400
Date: Sat, 17 Mar 2018 20:30:37 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: John Syne <john3909@gmail.com>
Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        devel@driverdev.osuosl.org, Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>, daniel.baluta@nxp.com
Subject: Re: [PATCH v2 1/3] staging:iio:meter: Replaces IIO_DEV_ATTR_CH_OFF
 by IIO_DEVICE_ATTR
Message-ID: <20180317203037.1093cc11@archlinux>
In-Reply-To: <79D3051B-FF2F-4DD3-AF75-F6A4BAD81838@gmail.com>
References: <cover.1520382753.git.rodrigosiqueiramelo@gmail.com>
        <3af0e5a795059a8418cf08ff29f05f8d5e00da9b.1520382753.git.rodrigosiqueiramelo@gmail.com>
        <20180307200730.08ed3c2f@archlinux>
        <20180309003733.aichruo53vqryafg@smtp.gmail.com>
        <20180310151045.4570e85d@archlinux>
        <79D3051B-FF2F-4DD3-AF75-F6A4BAD81838@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 14 Mar 2018 23:12:02 -0700
John Syne <john3909@gmail.com> wrote:

> Hi Jonathan,
> 
> I have been looking at the IIO ABI docs and if I understand
> correctly, the idea is to use consistent naming conventions? So for
> example, looking at the ADE7854 datasheet, the naming matching the
> ADE7854 registers would be as follows:

Welcome to one of the big reasons no one tidied these drivers
up originally.  Still we have moved on somewhat since then
so similar circumstances have come up in other types of sensor.

> 
> {direction}_{type}_{index}_{modifier}_{info_mask}
> 
> AIGAIN	-	In_current_a_gain
Other than the fact that gain isn't an ABI element and that index
doesn't have
_ before it that is right.
in_voltageA_scale

That was a weird quirk a long time back which we should probably
not have done (copied it from hwmon)

> AVGAIN	-	in_voltage_a_gain
> BIGAIN	-	in_current_b_gain
> BVGAIN	-	in_voltage_b_gain
> —
> How do we represent the rms and offset
> AIRMSOS	-	in_current_a_rmsoffset
> AVRMSOS	-	in_voltage_a_rmsoffset

Right now we can't unfortunately though this one is easier to fix.
We already have modifiers for multi axis devices doing sum_squared
so add one of those for root_mean_square - this one is well known
enough that rms is fine in the string.

It's a effectively a different channel be it one derived from a simple
one.  This is going to get tricky however as we would normally use
modifier to specialise a channel type - thoughts on this below.

> —
> Here I don’t understand how to represent both the phase and the active/reactive/apparent power components. Do we combine the phase and quadrature part like this
> AVAGAIN		-	in_power_a_gain				/* apparent power */
> —
> AWGAIN		-	in_power_ai_gain				/* active power */
And that is the problem.  How do we represent the various power types.
Hmm. We could do it with modifiers but above we show that we have already used them.

It would be easy enough to add yet another field to the channel spec to specify
this but there is a problem - Events.  The event format is already pretty full
so where do we put this extra element if we need to define a channel separated
only by it.

One thought is we could instead define these as different top level
IIO_CHAN_TYPES in a similar fashion to we do for relative humidity vs
the proposed absolute humidity.

in_powerreactiveA_scale
in_poweractivceA_scale
(or in_powerrealA_scale to match with what I got taught years ago?)

I presume we keep in_powerA_scale etc for the apparent power and
modify any docs to make that clear.

> —
> AVARGAIN	-	in_power_aq_gain				/* reactive power */
> —
> Now here it becomes more complicated. Not sure how this gets handled. 
> AFWATTOS	-	in_power_a_active/fundamental/offset
Yeah, some of these are getting odd.
If I read this correctly this is the active power estimate based on only
the fundamental frequency - so no harmonics?

Hmm.  This then becomes a separate channel with additional properties
specifying it is only the fundamental.  This feels a bit like a filter
be it an unusual one?  Might just be necessary to add a _fundamental_only
element on the end (would be info_mask if this is common enough to
justify that rather than using the extended methods to define it.).


> —
> AWATTHR	-	in_energy_ai_accumulation
Great, just when I thought we had gone far enough they define reactive
energy which is presumably roughly the same as reactivepower * time?
In that case we need types for that as well.
in_energyreactiveA_*
in_energyactiveA_*

> —
> AVARHR		-	in_energy_aq_accumulation
> —
> IPEAK		-	in_current_peak
That one is easy as we have an info_mask element for peak and one
for peak_scale that has always been a bit odd but was needed somewhere.

> —
> 
> I’ll leave it there, because there are some even more complicated register naming issues.
Something to look forward to.  Gah, I always hated power engineering
though I taught it very briefly (I really pity those students :(

Jonathan

> 
> Regards,
> John
> 
> 
> 
> 
> 
> > On Mar 10, 2018, at 7:10 AM, Jonathan Cameron <jic23@kernel.org> wrote:
> > 
> > On Thu, 8 Mar 2018 21:37:33 -0300
> > Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com> wrote:
> >   
> >> On 03/07, Jonathan Cameron wrote:  
> >>> On Tue, 6 Mar 2018 21:43:47 -0300
> >>> Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com> wrote:
> >>>   
> >>>> The macro IIO_DEV_ATTR_CH_OFF is a wrapper for IIO_DEVICE_ATTR, with a
> >>>> tiny change in the name definition. This extra macro does not improve
> >>>> the readability and also creates some checkpatch errors.
> >>>> 
> >>>> This patch fixes the checkpatch.pl errors:
> >>>> 
> >>>> staging/iio/meter/ade7753.c:391: ERROR: Use 4 digit octal (0777) not
> >>>> decimal permissions
> >>>> staging/iio/meter/ade7753.c:395: ERROR: Use 4 digit octal (0777) not
> >>>> decimal permissions
> >>>> staging/iio/meter/ade7759.c:331: ERROR: Use 4 digit octal (0777) not
> >>>> decimal permissions
> >>>> staging/iio/meter/ade7759.c:335: ERROR: Use 4 digit octal (0777) not
> >>>> decimal permissions
> >>>> 
> >>>> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>    
> >>> 
> >>> Hmm. I wondered a bit about this one. It's a correct patch in of
> >>> itself but the interface in question doesn't even vaguely conform
> >>> to any of defined IIO ABI.  Anyhow, it's still and improvement so
> >>> I'll take it.    
> >> 
> >> I am not sure if I understood the comment about the ABI. The meter
> >> interface is wrong because it uses things like IIO_DEVICE_ATTR? It
> >> should use iio_info together with *write_raw and *read_raw. Right? Is it
> >> the ABI problem that you refer?  
> > The ABI is about the userspace interface of IIO.  It is defined
> > in Documentation/ABI/testing/sysfs-bus-iio*
> > So this documents the naming of sysfs attributes and (more or less)
> > describes a consistent interface to userspace across lots of different
> > types of devices.
> > 
> > A lot of these older drivers in staging involve a good deal of ABI that
> > was not reviewed or discussed.  That is one of the biggest reasons we
> > didn't take them out of staging in the first place.
> > 
> > In order for generic userspace programs to have any idea what to do
> > with these devices this all needs to be fixed.
> > 
> > There may well be cases where we need to expand the existing ABI to
> > cover new things.   That's fine, but it has to be done with full
> > review of the relevant documentation patches.
> > 
> > Incidentally if you want an easy driver to work on moving out of staging
> > then first thing to do is to compare what it shows to userspace with these
> > docs.  If it's totally different then you have a big job on your hands
> > as often ABI can take a lot of discussion and a long time to establish
> > a consensus.
> > 
> > Jonathan
> > 
> >   
> >> 
> >> Thanks :)
> >>   
> >>> Applied to the togreg branch of iio.git and pushed out as testing
> >>> for the autobuilders to play with it.
> >>> 
> >>> I also added the removal of the header define which is no
> >>> longer used.
> >>> 
> >>> Please note, following discussions with Michael, I am going to send
> >>> an email announcing an intent to drop these meter drivers next
> >>> cycle unless someone can provide testing for any attempt to
> >>> move them out of staging.  I'm still taking patches on the basis
> >>> that 'might' happen - but I wouldn't focus on these until we
> >>> have some certainty on whether they will be around long term!
> >>> 
> >>> Jonathan
> >>>   
> >>>> ---
> >>>> drivers/staging/iio/meter/ade7753.c | 18 ++++++++++--------
> >>>> drivers/staging/iio/meter/ade7759.c | 18 ++++++++++--------
> >>>> 2 files changed, 20 insertions(+), 16 deletions(-)
> >>>> 
> >>>> diff --git a/drivers/staging/iio/meter/ade7753.c b/drivers/staging/iio/meter/ade7753.c
> >>>> index c44eb577dc35..275e8dfff836 100644
> >>>> --- a/drivers/staging/iio/meter/ade7753.c
> >>>> +++ b/drivers/staging/iio/meter/ade7753.c
> >>>> @@ -388,14 +388,16 @@ static IIO_DEV_ATTR_VPERIOD(0444,
> >>>> 		ade7753_read_16bit,
> >>>> 		NULL,
> >>>> 		ADE7753_PERIOD);
> >>>> -static IIO_DEV_ATTR_CH_OFF(1, 0644,
> >>>> -		ade7753_read_8bit,
> >>>> -		ade7753_write_8bit,
> >>>> -		ADE7753_CH1OS);
> >>>> -static IIO_DEV_ATTR_CH_OFF(2, 0644,
> >>>> -		ade7753_read_8bit,
> >>>> -		ade7753_write_8bit,
> >>>> -		ADE7753_CH2OS);
> >>>> +
> >>>> +static IIO_DEVICE_ATTR(choff_1, 0644,
> >>>> +			ade7753_read_8bit,
> >>>> +			ade7753_write_8bit,
> >>>> +			ADE7753_CH1OS);
> >>>> +
> >>>> +static IIO_DEVICE_ATTR(choff_2, 0644,
> >>>> +			ade7753_read_8bit,
> >>>> +			ade7753_write_8bit,
> >>>> +			ADE7753_CH2OS);
> >>>> 
> >>>> static int ade7753_set_irq(struct device *dev, bool enable)
> >>>> {
> >>>> diff --git a/drivers/staging/iio/meter/ade7759.c b/drivers/staging/iio/meter/ade7759.c
> >>>> index 1decb2b8afab..c078b770fa53 100644
> >>>> --- a/drivers/staging/iio/meter/ade7759.c
> >>>> +++ b/drivers/staging/iio/meter/ade7759.c
> >>>> @@ -328,14 +328,16 @@ static IIO_DEV_ATTR_ACTIVE_POWER_GAIN(0644,
> >>>> 		ade7759_read_16bit,
> >>>> 		ade7759_write_16bit,
> >>>> 		ADE7759_APGAIN);
> >>>> -static IIO_DEV_ATTR_CH_OFF(1, 0644,
> >>>> -		ade7759_read_8bit,
> >>>> -		ade7759_write_8bit,
> >>>> -		ADE7759_CH1OS);
> >>>> -static IIO_DEV_ATTR_CH_OFF(2, 0644,
> >>>> -		ade7759_read_8bit,
> >>>> -		ade7759_write_8bit,
> >>>> -		ADE7759_CH2OS);
> >>>> +
> >>>> +static IIO_DEVICE_ATTR(choff_1, 0644,
> >>>> +			ade7759_read_8bit,
> >>>> +			ade7759_write_8bit,
> >>>> +			ADE7759_CH1OS);
> >>>> +
> >>>> +static IIO_DEVICE_ATTR(choff_2, 0644,
> >>>> +			ade7759_read_8bit,
> >>>> +			ade7759_write_8bit,
> >>>> +			ADE7759_CH2OS);
> >>>> 
> >>>> static int ade7759_set_irq(struct device *dev, bool enable)
> >>>> {    
> >>>   
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html  
> > 
> > _______________________________________________
> > devel mailing list
> > devel@linuxdriverproject.org
> > http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel  
> 

