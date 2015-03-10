Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-239.synserver.de ([212.40.185.239]:1063 "EHLO
	smtp-out-239.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752183AbbCJN3F (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 10 Mar 2015 09:29:05 -0400
Message-ID: <54FEF1A4.3040100@metafoo.de>
Date: Tue, 10 Mar 2015 14:29:08 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>,
	abhijit <abhijitnaik27@gmail.com>, linux-iio@vger.kernel.org,
	Patrick Vasseur <patrick.vasseur@c-s.fr>,
	Michael Hennerich <hennerich@blackfin.uclinux.org>
Subject: Re: IIO Channel Sequencer Handling.  was Re: AD7923 sequencer functionality
 implementation in Kernel
References: <54FD2F9A.2070502@gmail.com> <54FD9CD9.3080306@kernel.org> <54FDA14D.3010803@metafoo.de> <54FDA4CE.5070500@kernel.org>
In-Reply-To: <54FDA4CE.5070500@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/09/2015 02:49 PM, Jonathan Cameron wrote:
> On 09/03/15 13:34, Lars-Peter Clausen wrote:
>> On 03/09/2015 02:15 PM, Jonathan Cameron wrote:
>>> On 09/03/15 05:28, abhijit wrote:
>>>> Hi All,
>>>>
>>>> We are using AD7923 driver as reference for one of our customer's ADC IP
>>>>
>>>> The ADC that we are using, has sequencer functionality. In current state of AD7923 driver, there is no support for sequencer functionality.
>>>>
>>>> Can you please let me know whether the IIO driver team is coming up with design for sequencer functionality of the device.
>>> Cc'd Lars, Michael and Patrick.  Looks like a fairly standard sequencer.
>>> Just a question of whether anyone has already looked at it.
>>
>> I've been tormenting my head now for a while how to properly model
>> sequencers in IIO, but haven't come to a conclusion yet.
>>
>> The problem is you have one physical channel but a configurable
>> amount of logical channels. The ADC will cycle through the selected
>> channels one after another.
> Ah I'd failed to register we don't have a convenient hardware buffer like
> the Maxim parts do.  On those you are cycling but the driver can read
> them all at the same time. Obviously the timestamps are less than
> great as a result.
>>
>> IIO on the other hand expects that all channels that are selected are
>> actually converted at the same time. E.g. you have to supply all the
>> selected channels at the same time to iio_buffer_push_data() and also
>> metadata, like the timestamps, is expected to be supplied only once
>> for every set of samples and not for every individual logical
>> channel.
> Hmm. Could add some more info to the timestamp to let us associate
> it with a channel I suppose..  Bit fiddly though.
>
> Not ideal.
>>
>> Furthermore things like the output data rate of each channel depend
>> on the number of selected channels. So if you configure the sample
>> rate and then change the number of selected channels you potentially
>> end up with a different sample rate than initially selected.
> For that we can rely on the standard ABI statement that a write to any
> attribute can change the value read from any other and just report
> the change via the sampling_frequency attribute.  I know that approach
> is ugly, but we can't hope to have a coherent way of coping with all
> the weird interactions we see on devices.



>
> Short of adding lots of meta data, I guess the easiest would be to
> fake what we do in the maxim drivers (with their sequencers feeding
> into a fifo) and construct a 'scan' of whatever channels we are reading
> with a rather fuzzy timestamp.
>
> We could specify known offsets from the timestamp for the individual
> channels.  These ought to be well specified.  Thus a single timestamp
> could be used to specify all the individual elements of the scans
> timing and have userspace reconstruct whatever timing info it wants.
>
> This functionality would also be useful for clock equipped devices
> where we timestamp on the dataready.  Clearly the sample and hold
> is usually at least a few ADC clocks before the interrupt.
>
> So would a new infomask element called *_timestampoffset
> (positive or negative depending on whether we timestamp on a trigger
>   of the sequence or at the end of it) solve that issue?
>
> (just thinking as a type so may well have missed something vital
> and haven't written a terribly coherent argument.

The easiest would probably be to just drop the timestamp and then use a 
software buffer to store the results until all samples have been converted.

But I'd rather model the hardware as accurately as possible rather than 
doing magic tricks in the driver. I have a feeling that the later will haunt 
us later on.

So the hardware is one or more ADCs that run in parallel and are 
synchronized. In front of the ADC is a crossbar multiplexer which connects 
the ADC pin(s) to the external pin(s). Sometimes there are even external 
multiplexers connected to external pins for even more channels. The ADC 
simply performs continuous conversions and outputs samples at the selected 
output data rate. In addition there is a automatic sequencer that cycles 
through the selected channels. So the ADC ends up doing a sequential 
conversion of the selected channels. In addition to conversion result the 
ADC might produce metadata for each sample, like a overrange flag or even 
the sequence number. This metadata generation can typically only be enabled 
globally.

So you basically have the ADC which has the data channel and metadata 
channels which can optionally be enabled.

In front of the ADC you have a sequencer which has channels that can be 
enabled through which it will cycle.

At the moment IIO pretty much assumes that each channel corresponds to one 
converter that directly corresponds to one physical signal without any kind 
of processing in between.

That makes it not only hard to represent a sequencer correctly but anything 
that has a more than trivial processing pipeline in hardware. And we really 
need some way to express those as more complex devices want to be supported.

Furthermore there is the issue of differentiating between software and 
hardware channels. E.g. I have a project where I have a normal SPI ADC were 
the data instead of copying to memory is fed into a processing pipeline. 
This processing pipeline obviously has not access to the software timestamp 
channel. Yet at a driver level we include the timestamp in the list of 
available channels. So we'll also need a mechanism to separate these things.

- Lars

- Lars
