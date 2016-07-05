Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42543 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752049AbcGET5B (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 5 Jul 2016 15:57:01 -0400
Subject: Re: [RFC 0/2] iio: add support for LMP91000EVM potentiostat board
To: Matt Ranostay <mranostay@gmail.com>
References: <1467497127-32431-1-git-send-email-mranostay@gmail.com>
 <CAKzfze9e0=W3=XnXbOMnuW8LiaVOuohzX0TgE6D0dJyty9T8Ag@mail.gmail.com>
 <d7e6e144-739d-3447-c715-df1c0203e32e@kernel.org>
 <CAKzfze9kCKiKF32Yc1spowkwbkHWWHCiV2niLE2JMdpkUhABZg@mail.gmail.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Peter Meerwald <pmeerw@pmeerw.net>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <e01fac4f-2283-29a7-df29-f763381ec0ab@kernel.org>
Date: Tue, 5 Jul 2016 20:56:48 +0100
MIME-Version: 1.0
In-Reply-To: <CAKzfze9kCKiKF32Yc1spowkwbkHWWHCiV2niLE2JMdpkUhABZg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/07/16 23:24, Matt Ranostay wrote:
> On Sun, Jul 3, 2016 at 6:41 AM, Jonathan Cameron <jic23@kernel.org> wrote:
>> On 02/07/16 23:13, Matt Ranostay wrote:
>>> On Sat, Jul 2, 2016 at 3:05 PM, Matt Ranostay <mranostay@gmail.com> wrote:
>>>> LMP91000EVM evaluation board has LMP91000 potentiostat along with an
>>>> 16-bit ADC for chemical sensoring applications.
>>>>
>>>>  * add support for the TI LMP91000 potentiostat
>>>>  * add support for ADC141S626 and ADC161S626 ADC chips
>>>
>>> Probably should have put what I am RFC'ing :).
>>>
>>> * does this belong in a new path drivers/iio/potentiostat ?
>> I'm going for drivers/iio/AFE/potentiostat with drivers/iio/AFE/amplifiers
>> as well to take the only similar driver we already have.
>>
>>> * first example of a iio consumer within drivers/iio, does it seems sane?
>> It's 'interesting'.  You've worked around the whole question of how to handle
>> a mux by putting a push interface equipped client on top of the polled interface
>> of the ADC.  It's an elegant solution that I'd never considered.
>>
>> By the very nature of a mux interface, unless we are piping the mux switching
>> out on the same trigger system as the read back, the actual read out must be
>> polled rather than self clocked. Only the mux knows when it is ready.
>> The triggered version has all sorts of additional complexity even if we had
>> output buffers already to go (such as requiring the output buffering to
>> 'lead' the input buffering to give the mux time to switch.
>>
>> Question to my mind is whether this is a generic and flexible enough approach
>> to use for this sort of device in the future... I think we have two classes
>> of 'analog device' that we need to support:
>>
>> 1) Simple all channels always there devices such as analog accelerometers
>> feeding into an ADC with a sequencer (or a software based sequencer).
>> In that case the data flow is clearly going to go over the buffered interface.
>> The accelerometer driver is just massaging the data for types / scale adjustments.
>> It has no influence on the sampling of the data.
>>
>> 2) The 'smart' front end with a mux.  In this case the 'when to read' question
>> is driven by the front end, not the ADC.  Games could be played to push the
>> sampling of data over to the ADC, but is it worth doing?
>>
> 
> Probably over-engineering unless we actually find a need to do this in
> the future.
I get the feeling we'll end up with a high performance system needing this
at some point.
> 
>> So if we wanted to do this, the AFE could itself export a trigger that is then
>> used by the ADC which in turn pushes data back to the AFE driver via the buffered
>> data interface.  The AFE driver would then have to handle the demux of this
>> data stream into a coherent form to push out in it's own buffer.
>> This approach gains the following:
>>  - quick data transfers, particularly if we are dealing with a multiple output
>>    mux.  e.g we might have a 16 to 4 mux into a 4 channel simultaneous sampling
>>    (or sequenced) ADC. So in this case if the mux was set to provide all 16
>>    channels in order we'd do 4 reads of the ADC getting 0 1 2 3, 4 5 6 7 etc.
>>    The mux driver would then have to recombine these 16 channels before kicking
>>    them out.
> 
> Makes sense but there is a slight issue of the settling time for the
> temp channel is 2-3 milliseconds. Can't assume all mux reads are going
> to take the same time constant.
That's down to the mux driver to handle it.  Only trigger once it's known
to be stable..
> 
>>
>> To do this we'd need to add an interface to allow the AFE/mux driver to set
>> the trigger for the ADC to its own.
> 
> Of course in this case the ADC and LMP91000 device are using both the
> hrtimer trigger, albeit of course you can't do it at the same time. So
> it is polling no matter what.
Fair point.
> 
>>
>> If we want to do this quickish I think that's about the lightest weight option
>> we can do.
>>
>> Now, the question is, what are the disadvantages of going with what you
>> have here for this driver but keeping in mind the above for when it matters?
>>
>> I'm guessing we never need to run this particularly driver very fast...
>> I'm inclined to say yes but would like some other opinions on this one!
>> (hence the expanded Cc list - please do pull in anyone else you think
>> might be interested!)
> 
> Yeah the sample response of the sensor isn't that high speed. Maybe a
> few dozen hertz.
> 
>>
>>> * ADC driver has no IIO_CHAN_INFO_SCALE due to no regulators being defined
>> Should be some defined. That was easy ;)
>>> * Should ADC value be signed or unsigned?   -16636 is 0V, 0 is 2/VA ,
>>> 16635 is ~VA. Of course true zero is defined by the VREF voltage.
>> err. Odd. Go with signed I think.
>>>
>>>>
>>>> Matt Ranostay (2):
>>>>   iio: adc: ti-adc1x1s: add support for TI 1-channel differential ADCs
>>>>   iio: potentiostat: add LMP91000 support
>>>>
>>>>  .../devicetree/bindings/iio/adc/ti-adc1x1s.txt     |  16 ++
>>>>  .../bindings/iio/potentiostat/lmp91000.txt         |  28 ++
>>>>  drivers/iio/Kconfig                                |   1 +
>>>>  drivers/iio/Makefile                               |   1 +
>>>>  drivers/iio/adc/Kconfig                            |  12 +
>>>>  drivers/iio/adc/Makefile                           |   1 +
>>>>  drivers/iio/adc/ti-adc1x1s.c                       | 233 ++++++++++++++++
>>>>  drivers/iio/potentiostat/Kconfig                   |  21 ++
>>>>  drivers/iio/potentiostat/Makefile                  |   6 +
>>>>  drivers/iio/potentiostat/lmp91000.c                | 303 +++++++++++++++++++++
>>>>  10 files changed, 622 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti-adc1x1s.txt
>>>>  create mode 100644 Documentation/devicetree/bindings/iio/potentiostat/lmp91000.txt
>>>>  create mode 100644 drivers/iio/adc/ti-adc1x1s.c
>>>>  create mode 100644 drivers/iio/potentiostat/Kconfig
>>>>  create mode 100644 drivers/iio/potentiostat/Makefile
>>>>  create mode 100644 drivers/iio/potentiostat/lmp91000.c
>>>>
>>>> --
>>>> 2.7.4
>>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

