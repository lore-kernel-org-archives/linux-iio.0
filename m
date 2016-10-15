Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49290 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752462AbcJORNz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 15 Oct 2016 13:13:55 -0400
Subject: Re: [PATCH 00/18 V2] staging:iio:accel rework driver and move out of
 staging.
To: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
References: <20161008163918.18758-1-jic23@kernel.org>
 <d7ee3c5c-5922-d1ac-731d-2eb08154d4bf@kernel.org>
 <54aa839a-3965-e49f-f5b6-c89fc3f5b36f@metafoo.de>
 <c02b6ad1-e4ea-2d32-c486-12b4b02a478c@kernel.org>
Cc: knaack.h@gmx.de, pmeerw@pmeerw.net
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <756603a2-2840-76e3-4f33-705951e09ee6@kernel.org>
Date: Sat, 15 Oct 2016 18:13:53 +0100
MIME-Version: 1.0
In-Reply-To: <c02b6ad1-e4ea-2d32-c486-12b4b02a478c@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 15/10/16 17:42, Jonathan Cameron wrote:
> On 15/10/16 16:58, Lars-Peter Clausen wrote:
>> On 10/15/2016 05:17 PM, Jonathan Cameron wrote:
>>> *Smiles sweetly at the list*
>>>
>>> Go on, someone give me a review on these.
>>
>> Looks good, otherwise I'd complained ;)
>>
>> Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>
> Cool. Don't want to add to those stats of applied with
> no sign offs or reviews other than the author ;)
All applied and pushed out as testing to see what I missed.

Thanks,

Jonathan
> 
> Jonathan
>>
>>>
>>> Thanks,
>>>
>>> Jonathan
>>>
>>> On 08/10/16 17:39, Jonathan Cameron wrote:
>>>> Changes since V1:
>>>> - Fix the patch that breaks the makefile due to a := when it should be +=
>>>>   It didn't make it to the end of the set, but broke building of other drivers
>>>>   in the middle (thanks Lars-Peter Clausen)
>>>> - Drop the unwanted buffer setup after the move to the hybrid hardware /
>>>>   software buffer (Lars-Peter Clausen)
>>>> - Use chan->address rather than the modifier to index the address array.
>>>>   (Lars-Peter Clausen)
>>>> - Typo and gibberish fixups (Peter Meerwald-Stadhler)
>>>>
>>>> V1 Message
>>>>
>>>> This was around about the 4th IIO driver dating back to the days when I was
>>>> sticking these on sprinters and seeing if we could learn anything useful
>>>> about how they ran.
>>>>
>>>> It was a device way ahead of it's time.  Back then this was pretty much
>>>> the only relatively high G / low cost sensor and it had a hardware fifo.
>>>>
>>>> Anyhow, it has languished in staging primarily because of the complexity
>>>> around working out how we handle hardware buffers.  However, that trail has
>>>> long since been blaized by the likes of the am335x driver and now lots of
>>>> of newer devices are coming with fifos to smooth the flow of data between
>>>> these realtime chips and non realtime operating sytems, so it just became
>>>> a question of getting around to sorting it out.  I suspect there are very
>>>> few of these still out there, but I have an sca3000-e05 so that's no excuse 
>>>>
>>>> Anyhow, please review the whole series, but in particular the final move
>>>> patch (i.e. the resulting code).  The only odd corner I know of now is
>>>> the interaction of the watermark with the software controlled watermarks.
>>>> That may take some thought, but in the meantime I don't think that is
>>>> sufficient reason to keep it in staging.
>>>>
>>>> Some wacky corners in this hardware (like the crazy number representations
>>>> for the motion detection thresholds).  It's a good datasheet but you
>>>> do have to wonder what the designers were thinking at times 
>>>>
>>>> Jonathan
>>>>
>>>> p.s. The best bit about this series is now I can moan at everyone else
>>>> about not cleaning up their staging drivers as this is the last one
>>>> of mine. 
>>>>
>>>> Jonathan Cameron (18):
>>>>   staging:iio:accel:sca3000 Fix a use before setting of the
>>>>     indio_dev->buffer pointer.
>>>>   staging:iio:accel:sca3000 merge files into one.
>>>>   staging:iio:accel:sca3000 drop sca3000_register_ring_funcs
>>>>   staging:iio:accel:sca3000 Fix clearing of flag + setting of size of
>>>>     scan.
>>>>   staging:iio:accel:sca3000 Drop custom ABI for watersheds.
>>>>   staging:iio:accel:sca3000 move to hybrid hard / soft buffer design.
>>>>   staging:iio:accel:sca3000 drop some unused variables.
>>>>   staging:iio:accel:sca3000 use a 'fake' channel to handle freefall
>>>>     event registration.
>>>>   staging:iio:accel:sca3000 Clean up register defines.
>>>>   staging:iio:accel:sca3000 add readback of the 3db low pass filter
>>>>     frequency
>>>>   staging:iio:accel:sca3000: Fix off by one error in axis due to
>>>>     IIO_NO_MOD
>>>>   staging:iio:accel:sca3000 Add write support to the low pass filter
>>>>     control
>>>>   staging:iio:accel:sca3000 Drop custom measurement mode attributes
>>>>   staging:iio:accel:sca3000 replace non standard revision attr with
>>>>     dev_info on probe
>>>>   staging:iio:accel:sca3000 Tidy up probe order to avoid a race.
>>>>   staging:iio:accel:sca3000 small checkpatch fixes (alignment etc)
>>>>   staging:iio:accel:sca3000 kernel docify comments that were nearly
>>>>     kernel doc.
>>>>   staging:iio:accel:sca3000 Move out of staging.
>>>>
>>>>  drivers/iio/accel/Kconfig                |   12 +
>>>>  drivers/iio/accel/Makefile               |    2 +
>>>>  drivers/iio/accel/sca3000.c              | 1575 ++++++++++++++++++++++++++++++
>>>>  drivers/staging/iio/accel/Kconfig        |   10 -
>>>>  drivers/staging/iio/accel/Makefile       |    3 -
>>>>  drivers/staging/iio/accel/sca3000.h      |  279 ------
>>>>  drivers/staging/iio/accel/sca3000_core.c | 1210 -----------------------
>>>>  drivers/staging/iio/accel/sca3000_ring.c |  350 -------
>>>>  drivers/staging/iio/ring_hw.h            |   27 -
>>>>  9 files changed, 1589 insertions(+), 1879 deletions(-)
>>>>  create mode 100644 drivers/iio/accel/sca3000.c
>>>>  delete mode 100644 drivers/staging/iio/accel/sca3000.h
>>>>  delete mode 100644 drivers/staging/iio/accel/sca3000_core.c
>>>>  delete mode 100644 drivers/staging/iio/accel/sca3000_ring.c
>>>>  delete mode 100644 drivers/staging/iio/ring_hw.h
>>>>
>>>
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

